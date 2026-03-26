#!/usr/bin/env python3
"""
Analyze the arcade alien march loop to determine if speed is:
  A) Purely emergent (one alien per frame, no extra delay), OR
  B) Table-delayed (extra wait after each full sweep)

Focus on the main game tick at $0141 and the sweep-complete handler.
"""

rom = bytearray(8192)
for name, offset in [('invaders.h', 0x0000), ('invaders.g', 0x0800),
                     ('invaders.f', 0x1000), ('invaders.e', 0x1800)]:
    with open(f'Assets/Intel8080/{name}', 'rb') as f:
        data = f.read()
        rom[offset:offset+len(data)] = data

# Full 8080 disassembler
OPCODES_1 = {
    0x00: 'NOP', 0x02: 'STAX B', 0x03: 'INX B', 0x04: 'INR B',
    0x05: 'DCR B', 0x07: 'RLC', 0x09: 'DAD B', 0x0A: 'LDAX B',
    0x0B: 'DCX B', 0x0C: 'INR C', 0x0D: 'DCR C', 0x0F: 'RRC',
    0x12: 'STAX D', 0x13: 'INX D', 0x14: 'INR D', 0x15: 'DCR D',
    0x17: 'RAL', 0x19: 'DAD D', 0x1A: 'LDAX D', 0x1B: 'DCX D',
    0x1C: 'INR E', 0x1D: 'DCR E', 0x1F: 'RAR',
    0x23: 'INX H', 0x24: 'INR H', 0x25: 'DCR H',
    0x27: 'DAA', 0x29: 'DAD H', 0x2B: 'DCX H',
    0x2C: 'INR L', 0x2D: 'DCR L', 0x2F: 'CMA',
    0x33: 'INX SP', 0x34: 'INR M', 0x35: 'DCR M',
    0x37: 'STC', 0x39: 'DAD SP', 0x3B: 'DCX SP',
    0x3C: 'INR A', 0x3D: 'DCR A', 0x3F: 'CMC',
    0x76: 'HLT', 0xC9: 'RET', 0xC0: 'RNZ', 0xC8: 'RZ',
    0xD0: 'RNC', 0xD8: 'RC', 0xE0: 'RPO', 0xE8: 'RPE',
    0xF0: 'RP', 0xF8: 'RM',
    0xC1: 'POP B', 0xD1: 'POP D', 0xE1: 'POP H', 0xF1: 'POP PSW',
    0xC5: 'PUSH B', 0xD5: 'PUSH D', 0xE5: 'PUSH H', 0xF5: 'PUSH PSW',
    0xEB: 'XCHG', 0xE3: 'XTHL', 0xE9: 'PCHL', 0xF9: 'SPHL',
    0x20: 'RIM', 0x30: 'SIM',
}
# MOV r,r' (0x40-0x7F except 0x76)
for d in range(8):
    for s in range(8):
        op = 0x40 | (d<<3) | s
        if op == 0x76: continue
        rn = 'BCDEHLMA'
        OPCODES_1[op] = f'MOV {rn[d]},{rn[s]}'
# ALU r (0x80-0xBF)
alu_names = ['ADD','ADC','SUB','SBB','ANA','XRA','ORA','CMP']
for a in range(8):
    for s in range(8):
        op = 0x80 | (a<<3) | s
        rn = 'BCDEHLMA'
        OPCODES_1[op] = f'{alu_names[a]} {rn[s]}'

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
    0xDC: 'CC', 0xC4: 'CNZ',
    0xE2: 'JPO', 0xEA: 'JPE', 0xF2: 'JP', 0xFA: 'JM',
    0xE4: 'CPO', 0xEC: 'CPE', 0xF4: 'CP', 0xFC: 'CM',
}

def disasm(start, end, label=""):
    if label:
        print(f"\n{'='*60}")
        print(f"  {label}")
        print(f"{'='*60}")
    pc = start
    while pc < end and pc < len(rom):
        b = rom[pc]
        op1 = rom[pc+1] if pc+1 < len(rom) else 0
        op2 = rom[pc+2] if pc+2 < len(rom) else 0
        addr16 = op1 | (op2 << 8)
        
        if b in OPCODES_1:
            mnem = OPCODES_1[b]
            print(f'  {pc:04X}  {b:02X}            {mnem}')
            pc += 1
        elif b in OPCODES_IMM8:
            name = OPCODES_IMM8[b]
            print(f'  {pc:04X}  {b:02X} {op1:02X}         {name},${op1:02X}')
            pc += 2
        elif b in OPCODES_IMM16:
            name = OPCODES_IMM16[b]
            print(f'  {pc:04X}  {b:02X} {op1:02X} {op2:02X}      {name},${addr16:04X}')
            pc += 3
        else:
            print(f'  {pc:04X}  {b:02X}            DB ${b:02X}')
            pc += 1

# Key areas to analyze:
# 1. The main game tick (alien processing) 
disasm(0x0100, 0x019F, "Main game tick: Process one alien ($0100)")

# 2. Sweep complete handler at $01A1
disasm(0x019F, 0x01E0, "Sweep complete / cursor reset ($01A1)")

# 3. ISR Vblank area ($0953 onward)
disasm(0x0940, 0x0980, "ISR Vblank / RackBump ($0940-$097F)")

# 4. The RackBump speed adjustment and the called routine at $1A8B
disasm(0x1A80, 0x1AB5, "Code at $1A80 (near supposed speed table)")

# 5. Let's also check what's at $0008 and $0010 (interrupt vectors)
disasm(0x0000, 0x0030, "Reset and ISR vectors ($0000-$002F)")

# 6. Look for the sound timer / shuffle mechanics
# $2082 seems frequently referenced - analyze the code that stores to it
disasm(0x1600, 0x1620, "Code that STA $2082 (around $1605)")
