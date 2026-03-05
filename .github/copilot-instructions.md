# Project Guidelines

## Code Style
- Turbo Rascal syntax in .ras/.tru files; keep unit imports at the top via `@use`.
- Declare all variables at the beginning of procedures using `var` statements. TRSE uses a global variable namespace—use method-appropriate long descriptive names (e.g., `rightmost_block_column` not `col`) to avoid conflicts between functions.
- Interrupt handlers are declared explicitly and drive raster timing; follow the same naming style.
- Memory access uses `peek(^address, bank)` and `poke(^address, bank, value)` for reading/writing bytes; bank is 0 for current memory configuration. The `^` prefix is required — it marks the first argument as an address type. Without it TRSE rejects the call with "Parameter 0 must be a variable or address". Avoid `Memory::ReadByte`/`WriteByte` as they may not be available.

## TRSE Compiler Requirements
- **Bitwise operators**: Use `&` for bitwise AND, `|` for OR, `xor` for XOR, and `<<`/`>>` for shifts. The `and` keyword is for boolean logic only.
- **Function returns**: Use Pascal-style returns by assigning to the function name (e.g., `MyFunction := value;`). The `return` keyword is not supported.
- **Single assignment to function name**: A function can only assign to its name once. Use a temporary variable throughout the function and assign to the function name at the end.
- **No exit keyword**: TRSE does not support `exit` to return early from functions. Use control flow with flags (e.g., `found_flag`) and conditional loops instead.
- **No var parameters**: TRSE does not support `var` (pass-by-reference) parameters. Use global shared state variables or return values instead.
- **Global variable namespace**: All variables exist in a global namespace. Use descriptive prefixes (e.g., `cesc_`, `tas_`) for local variables in helper functions to avoid name collisions.

## TRSE Compiler Performance
The TRSE compiler has severe performance penalties for certain code patterns. Optimizing these can reduce compile times from minutes to seconds:

### Critical Bottlenecks (Confirmed via A/B Testing)
1. **Deep nesting (8+ levels)**: **MASSIVE PENALTY** (~50% of compile time)
   - Original nested-loop pattern in `CheckEnemyShieldContact` had 8 levels of nesting
   - Refactored to 4 levels maximum using method dispatch and loop unrolling
   - Result: **Compile time reduced by over 50%**
   - **Solution**: Extract nested loops into separate helper methods; unroll tight loops with constant iterations

2. **Long if/else chains** (10+ branches): **+1 second per 10 branches**
   - Tested with 10-branch palette selection in `AdvanceLevel`
   - **Solution**: Keep chains under 10 branches; consider lookup tables or method dispatch

### Fast Compilation Patterns
- **Constant array indices**: `array[0]`, `array[1]` compile much faster than `array[i]`
- **Loop unrolling**: Unroll loops with small fixed iteration counts (≤4 iterations)
- **Shallow nesting**: Keep nesting depth ≤4 levels; extract nested logic to helper methods
- **Method dispatch**: Call helper methods instead of deeply nested loops
- **Duplicated branches**: Duplicate code with constant values rather than shared logic with variables
- **Nested single-caller procedures**: Procedures with exactly one caller can be nested inside that caller's `var` block — confirmed to **improve** compile time

### TRSE Nested Procedure Pattern
Procedures called by exactly one other `procedure` (not `interrupt`) should be nested inside it. This reduces compile time and makes scope explicit.

```pascal
procedure OuterProc();
var
    outer_var : byte;

    // ── Nested: brief description ──────────────────────────────────────
    procedure InnerProc(param : byte);
    var
        inner_var : byte;
    begin
        // body — can access outer_var directly (shared scope)
    end; // InnerProc

begin  // OuterProc
    InnerProc(value);
end; // OuterProc
```

**Rules**:
- Nested procs are declared inside the outer proc's `var` block, after the outer's own vars
- **Innermost-first ordering**: when chaining multiple levels, declare the deepest proc first (bottom-up)
- Each nested proc has its own `var`/`begin`/`end`
- The outer proc's `begin` starts after all nested declarations
- Only applies to regular `procedure` — do **not** nest inside `interrupt` handlers (untested / unsupported)
- Nested procs share **only the global namespace** — they cannot access the outer procedure's local variables. Variables shared between outer and inner proc must remain global.
- Multi-caller procedures must **not** be nested

**Examples in codebase**:
- `CESC_TryAllShields_Unrolled` → `CESC_CheckColumn` → `CESC_CheckBlock` → `CESC_CheckRow` → `CheckEnemyShieldContact` (4-level chain)
- `CBC_CheckBlockColumn` nested inside `CheckBulletCollision`
- `SpawnShotFromColumn` nested inside `TickEnemyShotFiring`
- `HideGetReadyText` nested inside `StartLevel`
- `CopyShieldGlyph` nested inside `CopyShieldSprites`

### Refactoring Strategy for Compile-Time Optimization
1. Identify procedures with 5+ levels of nesting (primary target)
2. Extract each nested loop level into a separate helper method
3. Unroll loops with ≤4 constant iterations into sequential calls/checks
4. Use unique variable name prefixes per method to avoid global namespace collisions
5. Nest single-caller helper methods inside their sole caller (bottom-up ordering)
6. Test compile time before/after to measure impact

## IRQ Handling and Thread Safety
C64 raster interrupts can fire at any time, potentially corrupting shared state during multi-step operations.

### When to Use IRQ Protection
Use `PreventIRQ()` (disable interrupts) / `EnableIRQ()` (enable interrupts) around:
- **Multi-step state updates** where intermediate state is invalid (e.g., queuing shield erosion)
- **Critical sections** accessing shared global variables modified by both main loop and IRQ handlers
- **Complex calculations** that must complete atomically

### IRQ Protection Pattern
```pascal
procedure SensitiveOperation();
begin
    if some_condition then
    begin
        PreventIRQ();  // Disable IRQs for atomic operation
        
        // Critical section - multi-step updates
        global_state_1 := new_value;
        global_state_2 := calculate_something();
        
        EnableIRQ();  // Re-enable IRQs
    end;
end;
```

### Important IRQ Rules
- **Never nest `PreventIRQ`/`EnableIRQ`**: They are absolute flags, not a nesting stack. Nested `EnableIRQ()` will re-enable IRQs even if outer context expects them masked.
- **Keep critical sections short**: Long IRQ-disabled sections cause audio glitches and dropped frames
- **Main loop operations**: Most game logic runs in `MainRasterChain()` with IRQs already active - add protection only where needed
- **Interrupt handlers**: Use `interrupt` keyword and end with `EnableIRQ()` - never call `PreventIRQ`/`EnableIRQ` inside interrupt handlers

### Examples in Codebase
- `CheckEnemyShieldContact()`: Uses `PreventIRQ`/`EnableIRQ` to protect `cesc_contact_done` flag and `pending_shield_erosion` state
- `ShowGetReadyText()`: IRQ-safe — rewritten to use `poke`/`peek` with constant integer addresses only. No `^byte`/`pointer of byte` locals; ZP $24/$68 never touched. `Screen::PrintString` uses ZP $02–$09 (Screen unit), not the shared pool.
- `HideGetReadyText()`: Still uses local `pointer of byte` vars (ZP $24/$68) — not yet IRQ-safe.

## Enemy Formation — Coordinate System and Edge Boundaries

### Formation coordinates
- `monster_base_x` (byte): X pixel coordinate of sprite 1 (block-column 0). Sprites 2–4 are at `+54`, `+108`, `+162`.
- `monster_base_y` (byte): Y pixel coordinate of row 0. Rows 1 and 2 are `+MONSTER_ROW_OFFSET (26)` and `+52`.
- `MONSTER_SPACING = 54` pixels per block-column. `MONSTER_ROW_OFFSET = 26` pixels per block-row.
- Each block has 6 enemies in a 3×2 grid (columns 0–2, each 18px wide; rows 0–1). Block pixel width = 48px.
- Bullet hit window per block: `[cbcc_block_x - 11, cbcc_block_x + 37)` where `BULLET_X_CONTACT_REACH = 11`.

### Edge-detection boundary values (intentional / do not change)
- **Right-edge turn**: `right_edge >= 242` where `right_edge = monster_base_x + cached_rightmost_offset + 10`.
- **Left-edge turn**: `left_edge <= 36` where `left_edge = monster_base_x + cached_leftmost_offset`.
  - `36` is the minimum viable value: ensures all 3 enemy sub-columns reach the same turn point without underflowing the `cbcc_block_x - 11` bullet check on any normal play column.
  - This is 1–2 px narrower than the arcade original, but correct given the sprite-based approach.
  - **Do not raise this value** — it would make the play area too narrow.

### `cached_leftmost_offset` values
- All 4 block-columns alive with left-column enemies (bits 0–1): offset = `block_col * 54 + 0`
- Only middle-column enemies (bits 2–3) in leftmost block: offset = `block_col * 54 + 18`
- Only right-column enemies (bits 4–5) in leftmost block: offset = `block_col * 54 + 36`

### Known edge case — `monster_base_x` underflow at max speed
At maximum speed (1 enemy remaining, `enemy_count_diff = 0`), movement is 2 px/tick. If only the far-left enemy column survives (`cached_leftmost_offset = 36`) and direction changes on an even `monster_base_x`, it is possible for the decrement path to reach `monster_base_x = 0`, then have the 2px step underflow to `255`. Effect: formation teleports to far right for one frame before the turn fires. This is a known/accepted limitation:
- It only occurs at extreme end-of-level speed.
- Raising the left-edge boundary to prevent it would make the play area too narrow.
- Future mitigation options (not yet implemented):
  1. Clamp after move: `if monster_base_x > 200 then monster_base_x := 36;` (catches 255-side underflow).
  2. Align moves: after a direction change always snap `monster_base_x` to the nearest even/odd value matching the march parity, so 2px steps never land below 0.

## Bullet Collision — X Range Check
The horizontal hit-window check in `CBC_CheckBlockColumn` must use the **addition form** to avoid byte underflow:
```pascal
// CORRECT — no underflow possible:
if player_bullet_x + BULLET_X_CONTACT_REACH >= cbcc_block_x then

// WRONG — underflows to 245 when cbcc_block_x < 11:
if player_bullet_x >= cbcc_block_x - BULLET_X_CONTACT_REACH then
```
The `cbcc_rel_x` calculation that follows is safe: if the guard passes, the subtraction `player_bullet_x - cbcc_block_x + BULLET_X_CONTACT_REACH` always produces a value in [0..47].

## IRQ Safety of Formation Procedures

### `ClearMonster` — already IRQ-safe
`ClearMonster` uses `sprite_data_ptr` at ZP **$22** (confirmed from compiled ASM — not $24). It is called from within `MainRasterPlayer` interrupt during gameplay. The `LevelAdvance()` path (triggered on the last kill of a level) is now safe because `ShowGetReadyText` no longer uses ZP $24/$68.

### `PreclearLeftmostAndBottomEnemies` — calls ClearMonster for sprite data
Calls `ClearMonster` 17 times directly. `ClearMonster` handles everything via its normal `was_alive` path: zeroes sprite pixel data in both animation frames, clears the `block_enemies` bit, increments `numberOfEnemies`, and sets `pending_edge_rescan`. No block ever becomes fully empty from this preclear (each retains ≥2 enemies), so `LevelAdvance()` never fires.

`ClearMonster` uses `sprite_data_ptr` at ZP **$22**. The call site runs with IRQs enabled; safe as long as the SID player does not use ZP $22 (verify ZP address in compiled ASM after each recompile).

### `ReadyMonsters` — rewritten to be IRQ-safe
Uses **inline assembler** with absolute indexed addressing (`lda $2600,x` / `sta $2680,x` / `dex` / `bpl`) — no ZP pointers touched at all. 26 fixed-address loops (13 blocks × 2 frames), each copying 64 bytes using only the X register. Fully IRQ-safe; `PreventIRQ`/`EnableIRQ` no longer needed at the call site.

TRSE multi-line asm syntax (labels go in column 0, instructions are indented):
```pascal
asm("
        ldx #63
rm_b0f1 lda $2600,x
        sta $2680,x
        dex
        bpl rm_b0f1
");
```

**Old approach (kept for reference):** used local `^byte` pointer pair:

- **Local** `^byte` pointer variables all compile to the shared ZP $24/$68 pool (regardless of what you name them), which the SID play routine corrupts.
- **`poke`/`peek` with an integer variable address generates bad ASM in TRSE** — explicitly documented in helpers.tru. Do NOT use that form for variable-address writes.
- **TRSE's ZP pointer pool has a hard limit**. Adding global `^byte` variables consumes pool slots permanently.

### Recommended call sequence (IRQ-safe level setup)
```pascal
// All three safe to call from the main polling loop with IRQs enabled:
ReadyMonsters();                    // inline ASM, no ZP — fully IRQ-safe
PreclearLeftmostAndBottomEnemies(); // no ZP at all — fully IRQ-safe
MakeMonsters();                     // no ZP pointers — fully IRQ-safe
```

## Zero-Page Pointer Collision Map (from compiled SpaceInvaders64.asm)
TRSE allocates ZP addresses to pointer-type locals at compile time. Multiple procedures share the same ZP slot:
- `$22–$23`: `sprite_data_ptr` (ClearMonster) — **NOTE: differs from $24 in older builds; always re-check after recompile**
- `$24–$25`: `StarField_StaticStarPtr`, `source_sprite_ptr`, `csg_src_ptr`, `sgrt_ptr`, and others — all mapped to the same ZP pair
- `$68–$69`: `csg_dst_ptr`, `destination_sprite_ptr`, `sgrt_color_ptr` — same ZP pair
- `$02–$03`: `Screen_p1` (Screen unit PrintString pointer)
- `$04–$05`: `Screen_sp`, `$08–$09`: `Screen_p2`
- ZP aliasing causes corruption if an IRQ fires between the low/high byte writes of a pointer load. Any procedure using ZP $24/$68 pointers that runs in the main context while the SID IRQ is active must be wrapped with `PreventIRQ()`/`EnableIRQ()`.
- The ClearMonster `<<6` shift on `sprite_base_address : integer` is implemented as 6× `asl`/`rol` pairs — correctly 16-bit. Not a source of corruption.

## Architecture
- Main program entry is the TRSE project file pointing at the .ras source and output type.
- Starfield is isolated in a Turbo Rascal unit with its own procedures (e.g., `CreateStarScreen`).
- Sprite data is exported from a .flf spritesheet into a binary and loaded at $2000.

## Build and Test
- Use the TRSE project settings to build in the TRSE IDE. No command-line build tools are configured.

## Project Conventions
- Keep sprite memory layout consistent with `@spriteLoc` and `SetSpriteLoc(..., @spriteLoc/64, ...)`.
- Joystick input assumes port 2 via `joystickPort`.
- Asset inclusion uses `incsid` for SID music files and `incbin` for binary data, with `@define` for fixed memory addresses.
- Music and SFX are SID files under sid/.
- Sprite assets live under sprites/ and are exported from .flf files.
