#!/usr/bin/env python3
"""Analyze the arcade Space Invaders speed table and march mechanics."""

rom = bytearray(8192)
for name, offset in [('invaders.h', 0x0000), ('invaders.g', 0x0800),
                     ('invaders.f', 0x1000), ('invaders.e', 0x1800)]:
    with open(f'Assets/Intel8080/{name}', 'rb') as f:
        data = f.read()
        rom[offset:offset+len(data)] = data

# Dump bytes from $1A8B onward
start = 0x1A8B
print("Bytes at 0x1A8B-0x1ACF:")
for i in range(0, 80, 16):
    addr = start + i
    if addr + 16 > len(rom): break
    hexbytes = ' '.join(f'{rom[addr+j]:02X}' for j in range(16))
    print(f'  {addr:04X}  {hexbytes}')

# Speed table at $1AA1
print("\nSpeed table at 0x1AA1:")
addr = 0x1AA1
for i in range(0, 18, 2):
    threshold = rom[addr + i]
    delay = rom[addr + i + 1]
    print(f'  0x{addr+i:04X}  threshold={threshold:3d} (0x{threshold:02X})  delay={delay:3d} (0x{delay:02X})')

# Disassemble $1A8B routine
OPCODES = {
    0x00: ('NOP', 1), 0x03: ('INX B', 1), 0x04: ('INR B', 1),
    0x05: ('DCR B', 1), 0x07: ('RLC', 1), 0x09: ('DAD B', 1),
    0x0A: ('LDAX B', 1), 0x0B: ('DCX B', 1), 0x0C: ('INR C', 1),
    0x0D: ('DCR C', 1), 0x0F: ('RRC', 1), 0x13: ('INX D', 1),
    0x14: ('INR D', 1), 0x15: ('DCR D', 1), 0x17: ('RAL', 1),
    0x19: ('DAD D', 1), 0x1A: ('LDAX D', 1), 0x1B: ('DCX D', 1),
    0x1C: ('INR E', 1), 0x1D: ('DCR E', 1), 0x1F: ('RAR', 1),
    0x23: ('INX H', 1), 0x24: ('INR H', 1), 0x25: ('DCR H', 1),
    0x27: ('DAA', 1), 0x29: ('DAD H', 1), 0x2B: ('DCX H', 1),
    0x2C: ('INR L', 1), 0x2F: ('CMA', 1), 0x34: ('INR M', 1),
    0x35: ('DCR M', 1), 0x37: ('STC', 1), 0x3C: ('INR A', 1),
    0x3D: ('DCR A', 1), 0x3F: ('CMC', 1),
    0x40: ('MOV B,B', 1), 0x46: ('MOV B,M', 1), 0x47: ('MOV B,A', 1),
    0x48: ('MOV C,B', 1), 0x4E: ('MOV C,M', 1), 0x4F: ('MOV C,A', 1),
    0x56: ('MOV D,M', 1), 0x57: ('MOV D,A', 1),
    0x5E: ('MOV E,M', 1), 0x5F: ('MOV E,A', 1),
    0x66: ('MOV H,M', 1), 0x67: ('MOV H,A', 1),
    0x6E: ('MOV L,M', 1), 0x6F: ('MOV L,A', 1),
    0x70: ('MOV M,B', 1), 0x71: ('MOV M,C', 1), 0x76: ('HLT', 1),
    0x77: ('MOV M,A', 1), 0x78: ('MOV A,B', 1), 0x79: ('MOV A,C', 1),
    0x7A: ('MOV A,D', 1), 0x7B: ('MOV A,E', 1), 0x7C: ('MOV A,H', 1),
    0x7D: ('MOV A,L', 1), 0x7E: ('MOV A,M', 1),
    0x80: ('ADD B', 1), 0x83: ('ADD E', 1), 0x86: ('ADD M', 1),
    0x8A: ('ADC D', 1),
    0xA0: ('ANA B', 1), 0xA7: ('ANA A', 1),
    0xB0: ('ORA B', 1), 0xB7: ('ORA A', 1), 0xB8: ('CMP B', 1),
    0xBE: ('CMP M', 1),
    0xC0: ('RNZ', 1), 0xC1: ('POP B', 1), 0xC5: ('PUSH B', 1),
    0xC8: ('RZ', 1), 0xC9: ('RET', 1),
    0xD0: ('RNC', 1), 0xD1: ('POP D', 1), 0xD5: ('PUSH D', 1),
    0xD8: ('RC', 1), 0xE1: ('POP H', 1), 0xE5: ('PUSH H', 1),
    0xEB: ('XCHG', 1), 0xE9: ('PCHL', 1),
    0xF1: ('POP PSW', 1), 0xF5: ('PUSH PSW', 1), 0xF9: ('SPHL', 1),
    0x20: ('RIM', 1), 0x30: ('SIM', 1),
}
OPCODES_IMM8 = {
    0x06: 'MVI B', 0x0E: 'MVI C', 0x16: 'MVI D', 0x1E: 'MVI E',
    0x26: 'MVI H', 0x2E: 'MVI L', 0x36: 'MVI M', 0x3E: 'MVI A',
    0xC6: 'ADI', 0xCE: 'ACI', 0xD6: 'SUI', 0xDE: 'SBI',
    0xE6: 'ANI', 0xEE: 'XRI', 0xF6: 'ORI', 0xFE: 'CPI',
    0xDB: 'IN', 0xD3: 'OUT',
}
OPCODES_IMM16 = {
    0x01: 'LXI B', 0x11: 'LXI D', 0x21: 'LXI H', 0x31: 'LXI SP',
    0x22: 'SHLD', 0x2A: 'LHLD', 0x32: 'STA', 0x3A: 'LDA',
    0xC2: 'JNZ', 0xC3: 'JMP', 0xCA: 'JZ', 0xCD: 'CALL',
    0xD2: 'JNC', 0xDA: 'JC', 0xCC: 'CZ', 0xD4: 'CNC',
    0xDC: 'CC', 0xE2: 'JPO', 0xEA: 'JPE', 0xF2: 'JP', 0xFA: 'JM',
    0xC4: 'CNZ', 0xE4: 'CPO', 0xEC: 'CPE', 0xF4: 'CP', 0xFC: 'CM',
}

print("\nDisassembly 0x1A8B - 0x1AC0:")
pc = 0x1A8B
end = 0x1AC0
while pc < end and pc < len(rom):
    b = rom[pc]
    op1 = rom[pc+1] if pc+1 < len(rom) else 0
    op2 = rom[pc+2] if pc+2 < len(rom) else 0
    addr16 = op1 | (op2 << 8)
    
    if b in OPCODES:
        mnem, size = OPCODES[b]
        hexstr = ' '.join(f'{rom[pc+j]:02X}' for j in range(size))
        print(f'  {pc:04X}  {hexstr:12s}  {mnem}')
        pc += size
    elif b in OPCODES_IMM8:
        name = OPCODES_IMM8[b]
        hexstr = f'{b:02X} {op1:02X}'
        print(f'  {pc:04X}  {hexstr:12s}  {name},0x{op1:02X}')
        pc += 2
    elif b in OPCODES_IMM16:
        name = OPCODES_IMM16[b]
        hexstr = f'{b:02X} {op1:02X} {op2:02X}'
        print(f'  {pc:04X}  {hexstr:12s}  {name},0x{addr16:04X}')
        pc += 3
    else:
        print(f'  {pc:04X}  {b:02X}            DB 0x{b:02X}')
        pc += 1

# Also look at the main game loop / alien step logic
# The call to $1A8B is at $0968, in the ISR_Vblank handler
# Let's look at the context around $0953 (ISR_Vblank)
print("\n\nContext around ISR_Vblank (0x0953) and the game loop:")
pc = 0x0953
end = 0x0980
while pc < end and pc < len(rom):
    b = rom[pc]
    op1 = rom[pc+1] if pc+1 < len(rom) else 0
    op2 = rom[pc+2] if pc+2 < len(rom) else 0
    addr16 = op1 | (op2 << 8)
    
    if b in OPCODES:
        mnem, size = OPCODES[b]
        hexstr = ' '.join(f'{rom[pc+j]:02X}' for j in range(size))
        print(f'  {pc:04X}  {hexstr:12s}  {mnem}')
        pc += size
    elif b in OPCODES_IMM8:
        name = OPCODES_IMM8[b]
        hexstr = f'{b:02X} {op1:02X}'
        print(f'  {pc:04X}  {hexstr:12s}  {name},0x{op1:02X}')
        pc += 2
    elif b in OPCODES_IMM16:
        name = OPCODES_IMM16[b]
        hexstr = f'{b:02X} {op1:02X} {op2:02X}'
        print(f'  {pc:04X}  {hexstr:12s}  {name},0x{addr16:04X}')
        pc += 3
    else:
        print(f'  {pc:04X}  {b:02X}            DB 0x{b:02X}')
        pc += 1

# Now let's look at the alien march routine more carefully
# The main game loop is at the beginning of the ROM
# Let's find where aliens are processed
print("\n\nAlien march related code around 0x00E3:")
pc = 0x00E3
end = 0x0180
while pc < end and pc < len(rom):
    b = rom[pc]
    op1 = rom[pc+1] if pc+1 < len(rom) else 0
    op2 = rom[pc+2] if pc+2 < len(rom) else 0
    addr16 = op1 | (op2 << 8)
    
    if b in OPCODES:
        mnem, size = OPCODES[b]
        hexstr = ' '.join(f'{rom[pc+j]:02X}' for j in range(size))
        print(f'  {pc:04X}  {hexstr:12s}  {mnem}')
        pc += size
    elif b in OPCODES_IMM8:
        name = OPCODES_IMM8[b]
        hexstr = f'{b:02X} {op1:02X}'
        print(f'  {pc:04X}  {hexstr:12s}  {name},0x{op1:02X}')
        pc += 2
    elif b in OPCODES_IMM16:
        name = OPCODES_IMM16[b]
        hexstr = f'{b:02X} {op1:02X} {op2:02X}'
        print(f'  {pc:04X}  {hexstr:12s}  {name},0x{addr16:04X}')
        pc += 3
    else:
        print(f'  {pc:04X}  {b:02X}            DB 0x{b:02X}')
        pc += 1

# Now find GetRefAlienDelta at 0x1439
print("\n\nGetRefAlienDelta at 0x1439:")
pc = 0x1439
end = 0x14A0
while pc < end and pc < len(rom):
    b = rom[pc]
    op1 = rom[pc+1] if pc+1 < len(rom) else 0
    op2 = rom[pc+2] if pc+2 < len(rom) else 0
    addr16 = op1 | (op2 << 8)
    
    if b in OPCODES:
        mnem, size = OPCODES[b]
        hexstr = ' '.join(f'{rom[pc+j]:02X}' for j in range(size))
        print(f'  {pc:04X}  {hexstr:12s}  {mnem}')
        pc += size
    elif b in OPCODES_IMM8:
        name = OPCODES_IMM8[b]
        hexstr = f'{b:02X} {op1:02X}'
        print(f'  {pc:04X}  {hexstr:12s}  {name},0x{op1:02X}')
        pc += 2
    elif b in OPCODES_IMM16:
        name = OPCODES_IMM16[b]
        hexstr = f'{b:02X} {op1:02X} {op2:02X}'
        print(f'  {pc:04X}  {hexstr:12s}  {name},0x{addr16:04X}')
        pc += 3
    else:
        print(f'  {pc:04X}  {b:02X}            DB 0x{b:02X}')
        pc += 1

# Now let's examine what 0x2088 (alienShuffleCountdown?) is used for
# and the routine at 0x0140 area
print("\n\nCode at 0x0140-0x0170 (post-alien-sweep):")
pc = 0x0140
end = 0x0175
while pc < end and pc < len(rom):
    b = rom[pc]
    op1 = rom[pc+1] if pc+1 < len(rom) else 0
    op2 = rom[pc+2] if pc+2 < len(rom) else 0
    addr16 = op1 | (op2 << 8)
    
    if b in OPCODES:
        mnem, size = OPCODES[b]
        hexstr = ' '.join(f'{rom[pc+j]:02X}' for j in range(size))
        print(f'  {pc:04X}  {hexstr:12s}  {mnem}')
        pc += size
    elif b in OPCODES_IMM8:
        name = OPCODES_IMM8[b]
        hexstr = f'{b:02X} {op1:02X}'
        print(f'  {pc:04X}  {hexstr:12s}  {name},0x{op1:02X}')
        pc += 2
    elif b in OPCODES_IMM16:
        name = OPCODES_IMM16[b]
        hexstr = f'{b:02X} {op1:02X} {op2:02X}'
        print(f'  {pc:04X}  {hexstr:12s}  {name},0x{addr16:04X}')
        pc += 3
    else:
        print(f'  {pc:04X}  {b:02X}            DB 0x{b:02X}')
        pc += 1
