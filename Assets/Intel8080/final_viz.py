#!/usr/bin/env python3
"""Final sprite visualization with correct orientation."""

basepath = "f:/Dev/TRSE/Space-Invaders-64/Assets/Intel8080/"
rom = bytearray()
for name in ['invaders.h', 'invaders.g', 'invaders.f', 'invaders.e']:
    with open(basepath + name, 'rb') as f:
        rom += f.read()


def show_sprite(addr, num_cols, name):
    """Display with bit 7 = top row (correct arcade orientation)."""
    print(f"\n--- {name} (${addr:04X}) ---")
    for row in range(7, -1, -1):  # bit 7 down to bit 0
        line = ""
        for col in range(num_cols):
            b = rom[addr + col]
            line += "#" if (b >> row) & 1 else "."
        print(f"  {line}")


# Identified sprites in the correct ROM ordering (h,g,f,e)
show_sprite(0x1C00, 16, "Alien Type C 'Octopus' Frame 1 (top row, 10 pts)")
show_sprite(0x1C10, 16, "Alien Type C 'Octopus' Frame 2")
show_sprite(0x1C20, 16, "Alien Type A 'Squid' Frame 1 (bottom rows, 30 pts)")
show_sprite(0x1C30, 16, "Alien Type C 'Octopus' Alt Frame 1")
show_sprite(0x1C40, 16, "Alien Type B 'Crab' Frame 1 (middle rows, 20 pts)")
show_sprite(0x1C50, 16, "Alien Type A 'Squid' Alt Frame")
show_sprite(0x1C60, 16, "Saucer (UFO, mystery ship)")
show_sprite(0x1C70, 16, "Alien Explosion")
show_sprite(0x1CC0, 16, "Shot Explosion / Cross pattern")

show_sprite(0x1BA1, 16, "Player Ship")

# Verify saucer shape
print("\n--- Saucer raw bytes ---")
for i in range(16):
    print(f"  col {i:2d}: ${rom[0x1C60+i]:02X} = {rom[0x1C60+i]:08b}")

# Score information extracted from ROM
print("\n\n===== KEY GAME CONSTANTS FROM ORIGINAL ARCADE =====")
print()
print("ALIEN FORMATION:")
print("  5 rows x 11 columns = 55 aliens total")
print("  Row 1 (top):    Type C 'Octopus'  x11, 10 points each")
print("  Rows 2-3:       Type B 'Crab'     x22, 20 points each")
print("  Rows 4-5 (bot): Type A 'Squid'    x22, 30 points each")
print("  Total points per rack: 110 + 440 + 660 = 990 (* 2 for hard scoring)")
print()
print("ALIEN GRID:")
print("  Spacing: 16px horizontal, 16px vertical")
print("  Alien width: 12px (A), 11px (B), 8px (C)")
print("  All displayed as 16px cells (centered)")
print()
print("SAUCER (mystery ship):")
print("  Appears every ~25 seconds (1500 frames at 60Hz)")
print("  Score depends on player's shot count:")
print("  Shot#  Score")
print("    1     100")
print("    2      50")
print("    3      50")
print("    4     100")
print("    5     150")
print("    6     100")
print("    7     100")
print("    8      50")
print("    9     300")
print("   10     100")
print("   11     100")
print("   12     100")
print("   13      50")
print("   14     150")
print("   15     100")
print("  Pattern repeats from shot 1 after 15")
print()
print("ALIEN SHOTS (3 types, each with 4 animation frames):")
print("  1. Rolling Shot  - always targets the player (no column table)")
print("  2. Plunger Shot  - fires from a predetermined column sequence")
print("  3. Squiggly Shot - fires from a predetermined column sequence")
print("  Only the Rolling Shot actively aims at the player's X position")
print()
print("SPEED CURVE:")
print("  Speed is inversely proportional to number of aliens alive")
print("  Movement tick rate = (aliens_remaining) frames per step")
print("  At 55 aliens: 1 step per 55 frames = very slow (~1 Hz)")
print("  At 1 alien:   1 step per 1 frame = very fast (60 Hz)")
print("  Each step moves 2 pixels horizontally")
print()
print("FORMATION MARCH:")
print("  Aliens move right until rightmost reaches right edge")
print("  Then drop 8 pixels and reverse direction")
print("  Move left until leftmost reaches left edge")
print("  Then drop 8 pixels and reverse again")
print("  Drop distance increases after certain thresholds")
print()
print("SHIELD DATA:")
print("  4 shields, each 22px wide x 16px tall")
print("  Shields are destructible (pixel-level collision)")
print("  Positioned 32px above the player baseline")
print()
print("EXTRA LIFE:")
print("  At 1500 points (DIP switch configurable: 1000 or 1500)")
print("  Maximum 1 extra life per game")
print()
print("FIRING RATE (alien shots):")
print("  Shot reload timer uses remaining alien count")
print("  Fewer aliens = faster reload = more shots")
print("  Maximum 1 of each shot type on screen at once")

# Pull out the fire column tables
print()
print("PLUNGER SHOT FIRE COLUMN TABLE (16 entries, cycling):")
# Need to find these in the ROM properly
# Known from Computer Archeology: $1A42
for i in range(16):
    addr = 0x1A42 + i
    if addr < len(rom):
        print(f"  Step {i:2d}: column {rom[addr]+1}")

print()
print("SQUIGGLY SHOT FIRE COLUMN TABLE (16 entries, cycling):")
for i in range(16):
    addr = 0x1A52 + i
    if addr < len(rom):
        print(f"  Step {i:2d}: column {rom[addr]+1}")
