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
