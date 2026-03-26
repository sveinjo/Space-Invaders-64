#!/usr/bin/env python3
"""Find the actual speed table in the Space Invaders ROM and verify ROM mapping."""

# The well-known speed table from ComputerArchaeology.com is:
# 32 30 28 10 1E 0B 14 08 0A 07 05 06 03 05 02 04 01 03 00
# This is at address $1AA1 in the arcade's memory space.
# Format: (threshold, delay) pairs, terminated by 0x00

KNOWN_TABLE = bytes([0x32, 0x30, 0x28, 0x10, 0x1E, 0x0B, 0x14, 0x08,
                      0x0A, 0x07, 0x05, 0x06, 0x03, 0x05, 0x02, 0x04,
                      0x01, 0x03, 0x00])

# Try all possible ROM orderings
import itertools
rom_files = ['invaders.h', 'invaders.g', 'invaders.f', 'invaders.e']
file_data = {}
for name in rom_files:
    with open(f'Assets/Intel8080/{name}', 'rb') as f:
        file_data[name] = f.read()
    print(f'{name}: {len(file_data[name])} bytes')

# Try the current ordering: h=0, g=0x800, f=0x1000, e=0x1800
orderings = [
    ('h,g,f,e', [('invaders.h', 0x0000), ('invaders.g', 0x0800), ('invaders.f', 0x1000), ('invaders.e', 0x1800)]),
    ('e,f,g,h', [('invaders.e', 0x0000), ('invaders.f', 0x0800), ('invaders.g', 0x1000), ('invaders.h', 0x1800)]),
    ('h,g,e,f', [('invaders.h', 0x0000), ('invaders.g', 0x0800), ('invaders.e', 0x1000), ('invaders.f', 0x1800)]),
    ('f,e,g,h', [('invaders.f', 0x0000), ('invaders.e', 0x0800), ('invaders.g', 0x1000), ('invaders.h', 0x1800)]),
]

for label, mapping in orderings:
    rom = bytearray(8192)
    for name, offset in mapping:
        rom[offset:offset+len(file_data[name])] = file_data[name]
    
    # Search for the speed table
    idx = rom.find(KNOWN_TABLE)
    if idx >= 0:
        print(f'\n*** FOUND speed table in ordering {label} at offset 0x{idx:04X} ***')
    
    # Also check what's at $1AA1
    print(f'\n  Ordering {label}, data at 0x1AA1:')
    print(f'    ' + ' '.join(f'{rom[0x1AA1+j]:02X}' for j in range(20)))

# If not found, search for partial pattern (just the delay values: 30 10 0B 08 07 06 05 04 03)
partial = bytes([0x30])  # Start with just 0x30 (delay=48)
print("\n\nSearching for known delay value 0x30 (48) as speed table delay...")

# Actually, let's just search for the full 19-byte sequence in ALL possible arrangements
for perm in itertools.permutations(rom_files):
    rom = bytearray(8192)
    for i, name in enumerate(perm):
        rom[i*0x800:(i+1)*0x800] = file_data[name]
    idx = rom.find(KNOWN_TABLE)
    if idx >= 0:
        print(f'  FOUND in ordering {",".join(perm)} at 0x{idx:04X}')

# If the exact table isn't found, search for just the threshold sequence: 32 28 1E 14 0A 05 03 02 01
# (skipping every other byte)
print("\nSearching for partial patterns...")
for perm in itertools.permutations(rom_files):
    rom = bytearray(8192)
    for i, name in enumerate(perm):
        rom[i*0x800:(i+1)*0x800] = file_data[name]
    
    # Search for "32 30" anywhere (50, 48 - first threshold/delay pair)
    for pos in range(len(rom) - 19):
        if rom[pos] == 0x32 and rom[pos+1] == 0x30 and rom[pos+2] == 0x28 and rom[pos+3] == 0x10:
            label = ",".join(perm)
            print(f'  Found "32 30 28 10" at 0x{pos:04X} in ordering {label}')
            print(f'  Full 20 bytes: {" ".join(f"{rom[pos+j]:02X}" for j in range(20))}')
            break

# Also let's verify by searching each individual ROM file
print("\nSearching individual ROM files:")
for name in rom_files:
    data = file_data[name]
    for partial_len in [4]:  # Search for first 4 bytes
        target = bytes([0x32, 0x30, 0x28, 0x10])
        idx = data.find(target)
        if idx >= 0:
            print(f'  Found "32 30 28 10" in {name} at local offset 0x{idx:04X}')
            print(f'  Full context: {" ".join(f"{data[idx+j]:02X}" for j in range(min(20, len(data)-idx)))}')

# Let's also understand what 0x2088 is - the "shuffleCountdown" / "alienShotTimer"
# by looking at how it's referenced
print("\n\nLooking for references to RAM 0x2088 and 0x2082 (known speed-related):")
for perm_label, mapping in orderings[:1]:  # Just use h,g,f,e
    rom = bytearray(8192)
    for name, offset in mapping:
        rom[offset:offset+len(file_data[name])] = file_data[name]
    
    # Search for STA 0x2088 (opcode 32 88 20) or LDA 0x2088 (opcode 3A 88 20)
    for addr_target in [0x2088, 0x2082, 0x2067, 0x2006]:
        lo = addr_target & 0xFF
        hi = (addr_target >> 8) & 0xFF
        for pos in range(len(rom) - 3):
            if rom[pos+1] == lo and rom[pos+2] == hi:
                if rom[pos] == 0x32:
                    print(f'  STA 0x{addr_target:04X} at ROM 0x{pos:04X}')
                elif rom[pos] == 0x3A:
                    print(f'  LDA 0x{addr_target:04X} at ROM 0x{pos:04X}')
                elif rom[pos] == 0x21:
                    print(f'  LXI H,0x{addr_target:04X} at ROM 0x{pos:04X}')
