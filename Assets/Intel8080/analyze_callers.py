"""Find all callers of key routines and trace the player shot dispatch table."""
import struct

# Load ROM (4 x 2KB files, mapped to $0000-$1FFF)
rom = bytearray()
for f in ['Assets/Intel8080/invaders.h', 'Assets/Intel8080/invaders.g',
          'Assets/Intel8080/invaders.f', 'Assets/Intel8080/invaders.e']:
    rom += open(f, 'rb').read()

opcodes_3byte = {
    0xC3: 'JMP', 0xCD: 'CALL', 0xCA: 'JZ', 0xC2: 'JNZ',
    0xDA: 'JC', 0xD2: 'JNC', 0xFA: 'JM', 0xF2: 'JP',
    0xEA: 'JPE', 0xE2: 'JPO', 0xCC: 'CZ', 0xC4: 'CNZ',
    0xDC: 'CC', 0xD4: 'CNC', 0xFC: 'CM', 0xF4: 'CP',
    0xEC: 'CPE', 0xE4: 'CPO'
}

def find_refs(target):
    """Find all instructions that reference the given address."""
    lo = target & 0xFF
    hi = (target >> 8) & 0xFF
    refs = []
    for i in range(len(rom) - 2):
        if rom[i+1] == lo and rom[i+2] == hi and rom[i] in opcodes_3byte:
            refs.append((i, opcodes_3byte[rom[i]]))
    return refs

# 8080 opcode lengths (simplified)
def oplen(b):
    if b in (0x06,0x0E,0x16,0x1E,0x26,0x2E,0x36,0x3E,0xC6,0xCE,0xD6,0xDE,
             0xE6,0xEE,0xF6,0xFE,0xDB,0xD3):
        return 2
    if b in opcodes_3byte or b in (0x01,0x11,0x21,0x31,0x22,0x2A,0x32,0x3A):
        return 3
    return 1

def disasm_range(start, end):
    """Disassemble a range, returning list of (addr, bytes, text)."""
    mnemonics_1 = {
        0x00:'NOP',0x76:'HLT',0xC9:'RET',0xFB:'EI',0xF3:'DI',
        0x07:'RLC',0x0F:'RRC',0x17:'RAL',0x1F:'RAR',
        0x27:'DAA',0x2F:'CMA',0x37:'STC',0x3F:'CMC',
        0xC0:'RNZ',0xC8:'RZ',0xD0:'RNC',0xD8:'RC',
        0xE0:'RPO',0xE8:'RPE',0xF0:'RP',0xF8:'RM',
        0xE9:'PCHL',0xF9:'SPHL',0xEB:'XCHG',0xE3:'XTHL',
        0x09:'DAD B',0x19:'DAD D',0x29:'DAD H',0x39:'DAD SP',
        0xC5:'PUSH B',0xD5:'PUSH D',0xE5:'PUSH H',0xF5:'PUSH PSW',
        0xC1:'POP B',0xD1:'POP D',0xE1:'POP H',0xF1:'POP PSW',
        0x03:'INX B',0x13:'INX D',0x23:'INX H',0x33:'INX SP',
        0x0B:'DCX B',0x1B:'DCX D',0x2B:'DCX H',0x3B:'DCX SP',
        0x02:'STAX B',0x12:'STAX D',0x0A:'LDAX B',0x1A:'LDAX D',
        0xA7:'ANA A',0xAF:'XRA A',0xB7:'ORA A',0xBF:'CMP A',
    }
    regs8 = ['B','C','D','E','H','L','M','A']
    lines = []
    pc = start
    while pc < end and pc < len(rom):
        b = rom[pc]
        n = oplen(b)
        if pc + n > len(rom):
            break
        if b in mnemonics_1:
            text = mnemonics_1[b]
        elif b in opcodes_3byte:
            addr16 = rom[pc+1] | (rom[pc+2] << 8)
            text = f"{opcodes_3byte[b]} ${addr16:04X}"
        elif n == 3 and b in (0x01,0x11,0x21,0x31):
            rp = {0x01:'B',0x11:'D',0x21:'H',0x31:'SP'}[b]
            addr16 = rom[pc+1] | (rom[pc+2] << 8)
            text = f"LXI {rp},${addr16:04X}"
        elif n == 3 and b == 0x22:
            addr16 = rom[pc+1] | (rom[pc+2] << 8)
            text = f"SHLD ${addr16:04X}"
        elif n == 3 and b == 0x2A:
            addr16 = rom[pc+1] | (rom[pc+2] << 8)
            text = f"LHLD ${addr16:04X}"
        elif n == 3 and b == 0x32:
            addr16 = rom[pc+1] | (rom[pc+2] << 8)
            text = f"STA ${addr16:04X}"
        elif n == 3 and b == 0x3A:
            addr16 = rom[pc+1] | (rom[pc+2] << 8)
            text = f"LDA ${addr16:04X}"
        elif n == 2:
            imm_ops = {0xC6:'ADI',0xCE:'ACI',0xD6:'SUI',0xDE:'SBI',
                       0xE6:'ANI',0xEE:'XRI',0xF6:'ORI',0xFE:'CPI',
                       0xDB:'IN',0xD3:'OUT'}
            reg_ops = {0x06:'MVI B',0x0E:'MVI C',0x16:'MVI D',0x1E:'MVI E',
                       0x26:'MVI H',0x2E:'MVI L',0x36:'MVI M',0x3E:'MVI A'}
            if b in imm_ops:
                text = f"{imm_ops[b]} ${rom[pc+1]:02X}"
            elif b in reg_ops:
                text = f"{reg_ops[b]},${rom[pc+1]:02X}"
            else:
                text = f"DB ${b:02X} ${rom[pc+1]:02X}"
        else:
            # MOV, ADD, SUB, etc.
            if 0x40 <= b <= 0x7F and b != 0x76:
                dst = regs8[(b >> 3) & 7]
                src = regs8[b & 7]
                text = f"MOV {dst},{src}"
            elif 0x80 <= b <= 0x87:
                text = f"ADD {regs8[b&7]}"
            elif 0x88 <= b <= 0x8F:
                text = f"ADC {regs8[b&7]}"
            elif 0x90 <= b <= 0x97:
                text = f"SUB {regs8[b&7]}"
            elif 0x98 <= b <= 0x9F:
                text = f"SBB {regs8[b&7]}"
            elif 0xA0 <= b <= 0xA7:
                text = f"ANA {regs8[b&7]}"
            elif 0xA8 <= b <= 0xAF:
                text = f"XRA {regs8[b&7]}"
            elif 0xB0 <= b <= 0xB7:
                text = f"ORA {regs8[b&7]}"
            elif 0xB8 <= b <= 0xBF:
                text = f"CMP {regs8[b&7]}"
            elif 0x04 <= b <= 0x3C and (b & 7) == 4:
                text = f"INR {regs8[(b>>3)&7]}"
            elif 0x05 <= b <= 0x3D and (b & 7) == 5:
                text = f"DCR {regs8[(b>>3)&7]}"
            else:
                text = f"DB ${b:02X}"
        lines.append(f"  ${pc:04X}:  {' '.join(f'{rom[pc+j]:02X}' for j in range(n)):12s} {text}")
        pc += n
    return lines

print("=" * 78)
print("1. WHO CALLS/JUMPS TO $14D8?")
print("=" * 78)
refs = find_refs(0x14D8)
if not refs:
    print("  No references found!")
else:
    for addr, op in refs:
        print(f"  ${addr:04X}: {op} $14D8")
        # Show context
        start = max(0, addr - 10)
        for line in disasm_range(start, addr + 10):
            print(f"    {line}")

print()
print("=" * 78)
print("2. PLAYER SHOT HANDLER DISPATCH (around $03D0-$0410)")
print("=" * 78)
for line in disasm_range(0x03D0, 0x0415):
    print(line)

print()
print("=" * 78)
print("3. WHO CALLS $14D8's PARENT FUNCTION?")
print("   Looking for references to $14CB-$14DF")
print("=" * 78)
for target in range(0x14CB, 0x14E0):
    refs = find_refs(target)
    for addr, op in refs:
        print(f"  ${addr:04X}: {op} ${target:04X}")

print()
print("=" * 78)
print("4. AREA AROUND ENEMY SHOT HANDLERS ($0560-$0580)")
print("   Checking if $14D8 is called indirectly")
print("=" * 78)
for line in disasm_range(0x0560, 0x05A0):
    print(line)

print()
print("=" * 78)
print("5. WHAT DOES STATUS=3 DO? Find the status=3 handler")
print("   Searching player shot dispatch for status 3 path")
print("=" * 78)
# Check $1538 (SpriteShotCollision) callers
print("\nWho calls $1538 (SpriteShotCollision)?")
refs = find_refs(0x1538)
if not refs:
    print("  No CALL/JMP references found - may be reached via dispatch table")
else:
    for addr, op in refs:
        print(f"  ${addr:04X}: {op} $1538")

# Check if there's a jump table
print("\nLooking for jump table or dispatch between $0380-$03FF:")
for line in disasm_range(0x0380, 0x0400):
    print(line)

print()
print("=" * 78)
print("6. FULL PLAYER SHOT HANDLER ($0350-$0410)")
print("=" * 78)
for line in disasm_range(0x0350, 0x0415):
    print(line)

print()
print("=" * 78) 
print("7. WHAT CALLS THE ENEMY SHOT COLLISION PATH ($0563)?")
print("   And what does $0563 do?")
print("=" * 78)
for line in disasm_range(0x0563, 0x05C0):
    print(line)

print()
print("=" * 78)
print("8. EXTENDED ENEMY SHOT POST-HANDLER ($06A0-$0710)")
print("=" * 78)
for line in disasm_range(0x06A0, 0x0715):
    print(line)

print()
print("=" * 78)
print("9. WHAT IS RAM $2029? Search for writes to $2029")
print("=" * 78)
# Search for STA $2029 (opcode 32 29 20)
for i in range(len(rom) - 2):
    if rom[i] == 0x32 and rom[i+1] == 0x29 and rom[i+2] == 0x20:
        print(f"\n  STA $2029 at ${i:04X}:")
        for line in disasm_range(max(0, i-8), i+6):
            print(f"    {line}")

# Search for LXI pointing near $2029
print("\n  Also checking SHLD $2029:")
for i in range(len(rom) - 2):
    if rom[i] == 0x22 and rom[i+1] == 0x29 and rom[i+2] == 0x20:
        print(f"  SHLD $2029 at ${i:04X}:")
        for line in disasm_range(max(0, i-5), i+6):
            print(f"    {line}")

print()
print("=" * 78)
print("10. WHAT CHECKS $2061 (framebuffer collision flag)?")
print("=" * 78)
# Search for LDA $2061
for i in range(len(rom) - 2):
    if rom[i] == 0x3A and rom[i+1] == 0x61 and rom[i+2] == 0x20:
        print(f"\n  LDA $2061 at ${i:04X}:")
        for line in disasm_range(max(0, i-3), i+12):
            print(f"    {line}")

print()
print("=" * 78)
print("11. TRACKING THE ENEMY SHOT MOVEMENT → COLLISION FLOW")
print("    Plunger handler ($0617) full trace")
print("=" * 78)
for line in disasm_range(0x0617, 0x0680):
    print(line)

print()
print("=" * 78)
print("12. Squiggly handler ($05E9) full dump")
print("=" * 78)
for line in disasm_range(0x05E9, 0x0618):
    print(line)
