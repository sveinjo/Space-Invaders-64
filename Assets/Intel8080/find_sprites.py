#!/usr/bin/env python3
"""Find sprite data and key routines in the Space Invaders ROM."""

basepath = "f:/Dev/TRSE/Space-Invaders-64/Assets/Intel8080/"
rom = bytearray()
for name in ['invaders.h', 'invaders.g', 'invaders.f', 'invaders.e']:
    with open(basepath + name, 'rb') as f:
        rom += f.read()

# Search for LXI H instructions referencing $1Bxx-$1Dxx (likely sprite data area)
print("LXI H instructions pointing to $1Bxx-$1Dxx:")
for addr in range(len(rom) - 2):
    if rom[addr] == 0x21:
        target = rom[addr+1] | (rom[addr+2] << 8)
        if 0x1B00 <= target <= 0x1DFF:
            print(f"  addr=0x{addr:04X}: LXI H, 0x{target:04X}")

print()
print("LXI H instructions pointing to $1800-$1AFF:")
for addr in range(len(rom) - 2):
    if rom[addr] == 0x21:
        target = rom[addr+1] | (rom[addr+2] << 8)
        if 0x1800 <= target <= 0x1AFF:
            print(f"  addr=0x{addr:04X}: LXI H, 0x{target:04X}")

# Search for known alien sprite byte sequence
# Alien A frame 1 (from Computer Archeology):
# 00 00 04 00 0A 00 8E 01 4E 01 FF 03 5E 01 AA 00
alien_a = bytes([0x00, 0x00, 0x04, 0x00, 0x0A, 0x00, 0x8E, 0x01,
                 0x4E, 0x01, 0xFF, 0x03, 0x5E, 0x01, 0xAA, 0x00])
print()
print("Searching for known alien A sprite data pattern...")
for i in range(len(rom) - len(alien_a)):
    if rom[i:i+len(alien_a)] == alien_a:
        print(f"  FOUND at offset 0x{i:04X}!")

# Also try reversed/alternative patterns
# Alien A frame 1 alternative (MSB first): 
# 00 00 00 20 00 50 80 71 80 72 C0 FF ...
alien_a_alt = bytes([0x00, 0x00, 0x00, 0x20, 0x00, 0x50, 0x80, 0x71])
print("Searching for alt alien A pattern...")
for i in range(len(rom) - len(alien_a_alt)):
    if rom[i:i+len(alien_a_alt)] == alien_a_alt:
        print(f"  FOUND at offset 0x{i:04X}!")

# Dump non-zero data regions in the $1000-$1800 area (invaders.f)
print()
print("Non-zero regions in invaders.f ($1000-$17FF):")
start = None
for i in range(0x1000, 0x1800):
    if rom[i] != 0:
        if start is None:
            start = i
    else:
        if start is not None:
            end = i
            print(f"  0x{start:04X}-0x{end-1:04X} ({end-start} bytes)")
            start = None
if start is not None:
    print(f"  0x{start:04X}-0x{0x17FF:04X} ({0x1800-start} bytes)")

# Check the same for invaders.e ($1800-$1FFF)
print()
print("Non-zero regions in invaders.e ($1800-$1FFF):")
start = None
for i in range(0x1800, 0x2000):
    if rom[i] != 0:
        if start is None:
            start = i
    else:
        if start is not None:
            end = i
            print(f"  0x{start:04X}-0x{end-1:04X} ({end-start} bytes)")
            start = None
if start is not None:
    print(f"  0x{start:04X}-0x{0x1FFF:04X} ({0x2000-start} bytes)")

# Look for the string "PLAY" or "SCORE" in the ROM
print()
print("Searching for text strings...")
for i in range(len(rom) - 4):
    # Space Invaders uses a custom character encoding where space=0x26, 
    # A=0x00 or similar. Let's search for the raw ASCII too.
    s = rom[i:i+5]
    try:
        decoded = s.decode('ascii')
        if decoded.isalpha() and len(decoded) >= 5:
            print(f"  ASCII at 0x{i:04X}: '{decoded}'")
    except:
        pass

# Dump hex at known sprite table addresses
print()
print("Hex dump at key addresses:")
for base_addr in [0x1B00, 0x1B10, 0x1B20, 0x1B30, 0x1B40, 0x1B50, 0x1B60, 0x1B70, 0x1B80, 0x1B90, 0x1BA0]:
    hex_str = ' '.join(f'{rom[base_addr+j]:02X}' for j in range(16))
    print(f"  0x{base_addr:04X}: {hex_str}")

print()
print("Hex dump at $1C00-$1C80:")
for base_addr in range(0x1C00, 0x1C80, 16):
    hex_str = ' '.join(f'{rom[base_addr+j]:02X}' for j in range(16))
    print(f"  0x{base_addr:04X}: {hex_str}")

# Show actual data at specific invaders.e locations
print()
print("Hex dump at $1900-$19B0 (possible sprite/data tables):")
for base_addr in range(0x1900, 0x19B0, 16):
    hex_str = ' '.join(f'{rom[base_addr+j]:02X}' for j in range(16))
    print(f"  0x{base_addr:04X}: {hex_str}")

if __name__ == "__main__":
    pass
