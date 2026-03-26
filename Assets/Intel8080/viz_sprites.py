#!/usr/bin/env python3
"""Visualize Space Invaders sprites from the ROM (rotated screen format)."""

basepath = "f:/Dev/TRSE/Space-Invaders-64/Assets/Intel8080/"
rom = bytearray()
for name in ['invaders.h', 'invaders.g', 'invaders.f', 'invaders.e']:
    with open(basepath + name, 'rb') as f:
        rom += f.read()


def show_rotated_sprite(addr, num_cols, name):
    """Display a sprite stored in rotated-screen format.
    Each byte = 1 column of 8 vertical pixels (bit 0 = top row).
    num_cols = number of bytes/columns in the sprite.
    """
    print(f"\n--- {name} (at ${addr:04X}, {num_cols} cols) ---")
    for row in range(8):
        line = ""
        for col in range(num_cols):
            b = rom[addr + col]
            line += "#" if (b >> row) & 1 else "."
        print(f"  {line}")


# These sprite addresses were found in the ROM at $1C00+
# The sprite table at $1B60+ contains pointers and metadata
show_rotated_sprite(0x1C00, 16, "Sprite at $1C00 (Alien Type C frame 1)")
show_rotated_sprite(0x1C10, 16, "Sprite at $1C10 (Alien Type C frame 2)")
show_rotated_sprite(0x1C20, 16, "Sprite at $1C20 (Alien Type C2 frame 1)")
show_rotated_sprite(0x1C30, 16, "Sprite at $1C30 (Alien Type B frame 1)")
show_rotated_sprite(0x1C40, 16, "Sprite at $1C40 (Alien Type B frame 2)")
show_rotated_sprite(0x1C50, 16, "Sprite at $1C50 (Alien Type B2 frame 1)")
show_rotated_sprite(0x1C60, 16, "Sprite at $1C60 (Saucer)")

# Check the explosion and player sprites
show_rotated_sprite(0x1C70, 16, "Sprite at $1C70 (Explosion/other)")
show_rotated_sprite(0x1C80, 16, "Sprite at $1C80")
show_rotated_sprite(0x1C90, 16, "Sprite at $1C90")
show_rotated_sprite(0x1CA0, 16, "Sprite at $1CA0")
show_rotated_sprite(0x1CB0, 16, "Sprite at $1CB0")
show_rotated_sprite(0x1CC0, 16, "Sprite at $1CC0")
show_rotated_sprite(0x1CD0, 16, "Sprite at $1CD0")

# Shot sprite data (typically 3 or 6 bytes wide)
show_rotated_sprite(0x1CE0, 8, "Sprite at $1CE0")
show_rotated_sprite(0x1CF0, 8, "Sprite at $1CF0")
show_rotated_sprite(0x1D00, 8, "Sprite at $1D00")

# Player and shield at known locations
# Let me also try alternative known addresses
show_rotated_sprite(0x1BA1, 16, "Data at $1BA1")

# Dump the sprite reference table at $1B60
print("\n--- Sprite pointer table dump ($1B60-$1B6F) ---")
for i in range(0, 16, 2):
    lo = rom[0x1B60 + i]
    hi = rom[0x1B60 + i + 1]
    addr = lo | (hi << 8)
    print(f"  Entry {i//2}: ${addr:04X}")

# Let me also look at what the DrawAlien routine references
# The code at $0124 references LXI H,$1C00 - that's sprite data
# Let me check the draw routine at $017A (DrawSpriteGeneric)
print("\n--- DrawSpriteGeneric code at $017A ---")
for i in range(0x017A, 0x01A1):
    print(f"{rom[i]:02X}", end=" ")
print()

# Let me also find the alien sprite table
# There should be a table that maps alien type to sprite address
# Check around $0563 (AlienScoreDelta)
print("\n--- Data near $0550 (ScoreForAlien) ---")
for i in range(0x0550, 0x0590):
    print(f"{rom[i]:02X}", end=" ")
    if (i - 0x0550) % 16 == 15:
        print()
