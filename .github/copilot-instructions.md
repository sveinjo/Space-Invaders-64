# Project Guidelines

## Code Style
- Turbo Rascal syntax in .ras/.tru files; keep unit imports at the top via `@use`.
- Declare all variables at the beginning of procedures using `var` statements. TRSE uses a global variable namespace—use method-appropriate long descriptive names (e.g., `rightmost_block_column` not `col`) to avoid conflicts between functions.
- Interrupt handlers are declared explicitly and drive raster timing; follow the same naming style.
- Memory access uses `peek(address, bank)` and `poke(address, value, bank)` for reading/writing bytes; bank is 0 for current memory configuration. Avoid `Memory::ReadByte`/`WriteByte` as they may not be available.

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

### Refactoring Strategy for Compile-Time Optimization
1. Identify procedures with 5+ levels of nesting (primary target)
2. Extract each nested loop level into a separate helper method
3. Unroll loops with ≤4 constant iterations into sequential calls/checks
4. Use unique variable name prefixes per method to avoid global namespace collisions
5. Test compile time before/after to measure impact

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
        
        CloseIRQ();  // Re-enable IRQs
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
- `ShowGetReadyText()` / `HideGetReadyText()`: Must NOT use nested `PreventIRQ`/`EnableIRQ` - caused crashes when called from IRQ-protected contexts

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
