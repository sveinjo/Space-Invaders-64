# Project Guidelines

## Code Style
- Turbo Rascal syntax in .ras/.tru files; keep unit imports at the top via `@use`. See [SpaceInvaders64.ras](SpaceInvaders64.ras#L2-L5).
- Asset inclusion uses `incsid`/`incbin` plus `@define` for fixed addresses. See [SpaceInvaders64.ras](SpaceInvaders64.ras#L8-L71).
- Interrupt handlers are declared explicitly and drive raster timing; follow the same naming style. See [SpaceInvaders64.ras](SpaceInvaders64.ras#L73-L77).

## Architecture
- Main program entry is the TRSE project file pointing at the .ras source and output type. See [Space-Invaders-64.trse](Space-Invaders-64.trse#L10-L43).
- Starfield is isolated in a Turbo Rascal unit with its own procedures (e.g., `CreateStarScreen`). See [starfield.tru](starfield.tru#L55-L175).
- Sprite data is exported from a .flf spritesheet into a binary and loaded at $2000. See [SpaceInvaders64.ras](SpaceInvaders64.ras#L60-L71).

## Build and Test
- No build or test commands are documented in the repo. Use the TRSE project settings in [Space-Invaders-64.trse](Space-Invaders-64.trse#L10-L43) to build in the TRSE IDE.

## Project Conventions
- Keep sprite memory layout consistent with `@spriteLoc` and `SetSpriteLoc(..., @spriteLoc/64, ...)`. See [SpaceInvaders64.ras](SpaceInvaders64.ras#L56-L71).
- Joystick input assumes port 2 via `joystickPort`. See [SpaceInvaders64.ras](SpaceInvaders64.ras#L62-L65).

## Integration Points
- Music and SFX are SID files under sid/ and are included via `incsid`. See [SpaceInvaders64.ras](SpaceInvaders64.ras#L8-L12).
- Sprite assets live under sprites/ and are exported from .flf. See [SpaceInvaders64.ras](SpaceInvaders64.ras#L69-L71).
