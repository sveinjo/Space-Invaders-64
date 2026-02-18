Restart / quick-recovery checklist

Purpose: get back to a known-good state quickly after a reboot or long build failure.

Steps to follow after you restart:

1. Open the workspace f:\\Dev\\TRSE\\Space-Invaders-64 and load the TRSE project `Space-Invaders-64.trse`.
2. Open `SpaceInvaders64.ras` and verify `CheckBulletCollision` is called from `MainRasterRow1()` (it must run after sprites are drawn during the raster chain).
3. Confirm `CheckBulletCollision` local variables use distinct, long names (look for `cb_` prefixes) to avoid TRSE's global-name collisions.
4. Build in the TRSE IDE (incremental builds should be fast). If builds are unreasonably slow (>30s):
   - Temporarily comment out `@export "sprites/spritesheet.flf" ...` so sprite export does not run every build.
   - Re-enable sprite export only when you change sprites.
5. Run the program and verify startup completes without an immediate crash. If it crashes on startup:
   - Inspect interrupt handlers for `Screen::PrintString` calls inside IRQs and remove them (printing in IRQs can crash TRSE runtime).
   - Revert recent edits (use `SpaceInvaders64.ras.bak` or `git checkout -- SpaceInvaders64.ras`).
6. Verify collision behaviour:
   - Ensure `$D01F` (VIC collision register) is read after all sprite rows are displayed (inside the raster chain in correct order).
   - Confirm per-pixel sprite bitmap test remains enabled for precise hit detection.
7. When debugging, use non-IRQ-safe markers only from the main loop or DisplayText area (avoid printing from interrupt handlers).
8. If you need to restore a known-good copy quickly, use `SpaceInvaders64.ras.bak` or `git` rollback.

If you want, I can also copy these lines into `.github/copilot-instructions.md` (or add additional project-specific recovery steps).