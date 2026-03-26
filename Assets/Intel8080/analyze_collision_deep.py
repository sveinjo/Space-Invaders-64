#!/usr/bin/env python3
"""
Deep analysis of arcade shot collision scenarios.
Focus: trace EVERY path through the alien shot handlers to find
asymmetric collision cases (player bullet destroyed, enemy shot survives
or vice versa).
"""

def load_rom():
    rom = bytearray(0x2000)
    files = [
        ("Assets/Intel8080/invaders.h", 0x0000),
        ("Assets/Intel8080/invaders.g", 0x0800),
        ("Assets/Intel8080/invaders.f", 0x1000),
        ("Assets/Intel8080/invaders.e", 0x1800),
    ]
    for fname, base in files:
        with open(fname, "rb") as f:
            data = f.read()
            rom[base:base+len(data)] = data
    return bytes(rom)

OPCODES = {
    0x00: ("NOP", 1), 0x01: ("LXI B,${:04X}", 3), 0x03: ("INX B", 1),
    0x04: ("INR B", 1), 0x05: ("DCR B", 1), 0x06: ("MVI B,${:02X}", 2),
    0x07: ("RLC", 1), 0x09: ("DAD B", 1), 0x0A: ("LDAX B", 1),
    0x0B: ("DCX B", 1), 0x0C: ("INR C", 1), 0x0D: ("DCR C", 1),
    0x0E: ("MVI C,${:02X}", 2), 0x0F: ("RRC", 1),
    0x11: ("LXI D,${:04X}", 3), 0x13: ("INX D", 1), 0x14: ("INR D", 1),
    0x15: ("DCR D", 1), 0x16: ("MVI D,${:02X}", 2), 0x17: ("RAL", 1),
    0x19: ("DAD D", 1), 0x1A: ("LDAX D", 1), 0x1B: ("DCX D", 1),
    0x1E: ("MVI E,${:02X}", 2), 0x1F: ("RAR", 1),
    0x21: ("LXI H,${:04X}", 3), 0x22: ("SHLD ${:04X}", 3),
    0x23: ("INX H", 1), 0x24: ("INR H", 1), 0x25: ("DCR H", 1),
    0x26: ("MVI H,${:02X}", 2), 0x27: ("DAA", 1), 0x29: ("DAD H", 1),
    0x2A: ("LHLD ${:04X}", 3), 0x2B: ("DCX H", 1), 0x2C: ("INR L", 1),
    0x2D: ("DCR L", 1), 0x2E: ("MVI L,${:02X}", 2), 0x2F: ("CMA", 1),
    0x31: ("LXI SP,${:04X}", 3), 0x32: ("STA ${:04X}", 3),
    0x34: ("INR M", 1), 0x35: ("DCR M", 1), 0x36: ("MVI M,${:02X}", 2),
    0x37: ("STC", 1), 0x3A: ("LDA ${:04X}", 3), 0x3C: ("INR A", 1),
    0x3D: ("DCR A", 1), 0x3E: ("MVI A,${:02X}", 2), 0x3F: ("CMC", 1),
    0x40: ("MOV B,B", 1), 0x41: ("MOV B,C", 1), 0x42: ("MOV B,D", 1),
    0x43: ("MOV B,E", 1), 0x44: ("MOV B,H", 1), 0x45: ("MOV B,L", 1),
    0x46: ("MOV B,M", 1), 0x47: ("MOV B,A", 1), 0x48: ("MOV C,B", 1),
    0x49: ("MOV C,C", 1), 0x4A: ("MOV C,D", 1), 0x4B: ("MOV C,E", 1),
    0x4C: ("MOV C,H", 1), 0x4D: ("MOV C,L", 1), 0x4E: ("MOV C,M", 1),
    0x4F: ("MOV C,A", 1), 0x50: ("MOV D,B", 1), 0x51: ("MOV D,C", 1),
    0x52: ("MOV D,D", 1), 0x53: ("MOV D,E", 1), 0x54: ("MOV D,H", 1),
    0x55: ("MOV D,L", 1), 0x56: ("MOV D,M", 1), 0x57: ("MOV D,A", 1),
    0x58: ("MOV E,B", 1), 0x59: ("MOV E,C", 1), 0x5A: ("MOV E,D", 1),
    0x5B: ("MOV E,E", 1), 0x5C: ("MOV E,H", 1), 0x5D: ("MOV E,L", 1),
    0x5E: ("MOV E,M", 1), 0x5F: ("MOV E,A", 1), 0x60: ("MOV H,B", 1),
    0x61: ("MOV H,C", 1), 0x62: ("MOV H,D", 1), 0x63: ("MOV H,E", 1),
    0x64: ("MOV H,H", 1), 0x65: ("MOV H,L", 1), 0x66: ("MOV H,M", 1),
    0x67: ("MOV H,A", 1), 0x68: ("MOV L,B", 1), 0x69: ("MOV L,C", 1),
    0x6A: ("MOV L,D", 1), 0x6B: ("MOV L,E", 1), 0x6C: ("MOV L,H", 1),
    0x6D: ("MOV L,L", 1), 0x6E: ("MOV L,M", 1), 0x6F: ("MOV L,A", 1),
    0x70: ("MOV M,B", 1), 0x71: ("MOV M,C", 1), 0x72: ("MOV M,D", 1),
    0x73: ("MOV M,E", 1), 0x74: ("MOV M,H", 1), 0x75: ("MOV M,L", 1),
    0x76: ("HLT", 1), 0x77: ("MOV M,A", 1), 0x78: ("MOV A,B", 1),
    0x79: ("MOV A,C", 1), 0x7A: ("MOV A,D", 1), 0x7B: ("MOV A,E", 1),
    0x7C: ("MOV A,H", 1), 0x7D: ("MOV A,L", 1), 0x7E: ("MOV A,M", 1),
    0x7F: ("MOV A,A", 1), 0x80: ("ADD B", 1), 0x81: ("ADD C", 1),
    0x82: ("ADD D", 1), 0x83: ("ADD E", 1), 0x84: ("ADD H", 1),
    0x85: ("ADD L", 1), 0x86: ("ADD M", 1), 0x87: ("ADD A", 1),
    0x88: ("ADC B", 1), 0x90: ("SUB B", 1), 0x91: ("SUB C", 1),
    0x96: ("SUB M", 1), 0x97: ("SUB A", 1), 0xA0: ("ANA B", 1),
    0xA6: ("ANA M", 1), 0xA7: ("ANA A", 1), 0xAE: ("XRA M", 1),
    0xAF: ("XRA A", 1), 0xB0: ("ORA B", 1), 0xB1: ("ORA C", 1),
    0xB4: ("ORA H", 1), 0xB6: ("ORA M", 1), 0xB7: ("ORA A", 1),
    0xB8: ("CMP B", 1), 0xB9: ("CMP C", 1), 0xBA: ("CMP D", 1),
    0xBB: ("CMP E", 1), 0xBC: ("CMP H", 1), 0xBD: ("CMP L", 1),
    0xBE: ("CMP M", 1), 0xBF: ("CMP A", 1), 0xC0: ("RNZ", 1),
    0xC1: ("POP B", 1), 0xC2: ("JNZ ${:04X}", 3), 0xC3: ("JMP ${:04X}", 3),
    0xC4: ("CNZ ${:04X}", 3), 0xC5: ("PUSH B", 1),
    0xC6: ("ADI ${:02X}", 2), 0xC8: ("RZ", 1), 0xC9: ("RET", 1),
    0xCA: ("JZ ${:04X}", 3), 0xCC: ("CZ ${:04X}", 3),
    0xCD: ("CALL ${:04X}", 3), 0xD0: ("RNC", 1), 0xD1: ("POP D", 1),
    0xD2: ("JNC ${:04X}", 3), 0xD3: ("OUT ${:02X}", 2),
    0xD4: ("CNC ${:04X}", 3), 0xD5: ("PUSH D", 1),
    0xD6: ("SUI ${:02X}", 2), 0xD8: ("RC", 1),
    0xDA: ("JC ${:04X}", 3), 0xDB: ("IN ${:02X}", 2),
    0xDE: ("SBI ${:02X}", 2), 0xE1: ("POP H", 1), 0xE3: ("XTHL", 1),
    0xE5: ("PUSH H", 1), 0xE6: ("ANI ${:02X}", 2), 0xE9: ("PCHL", 1),
    0xEB: ("XCHG", 1), 0xEE: ("XRI ${:02X}", 2), 0xF1: ("POP PSW", 1),
    0xF5: ("PUSH PSW", 1), 0xF6: ("ORI ${:02X}", 2), 0xFB: ("EI", 1),
    0xFC: ("CM ${:04X}", 3), 0xFE: ("CPI ${:02X}", 2),
    0xE0: ("RPO", 1), 0xF0: ("RP", 1), 0xF8: ("RM", 1),
    0xF2: ("JP ${:04X}", 3), 0xFA: ("JM ${:04X}", 3),
    0xE2: ("JPO ${:04X}", 3), 0xEA: ("JPE ${:04X}", 3),
    0xC7: ("RST 0", 1), 0xCF: ("RST 1", 1), 0xD7: ("RST 2", 1),
    0xDF: ("RST 3", 1), 0xE7: ("RST 4", 1), 0xEF: ("RST 5", 1),
    0xF7: ("RST 6", 1), 0xFF: ("RST 7", 1),
}

def disasm_line(rom, pc):
    opcode = rom[pc]
    if opcode in OPCODES:
        fmt, size = OPCODES[opcode]
        raw = rom[pc:pc+size]
        hex_str = " ".join(f"{b:02X}" for b in raw)
        if size == 1:
            mnem = fmt
        elif size == 2:
            mnem = fmt.format(rom[pc+1])
        elif size == 3:
            word = rom[pc+1] | (rom[pc+2] << 8)
            mnem = fmt.format(word)
        return pc, size, hex_str, mnem
    else:
        return pc, 1, f"{rom[pc]:02X}", f"DB ${rom[pc]:02X}"

def disasm_range(rom, start, end):
    pc = start
    lines = []
    while pc < end:
        addr, size, hexs, mnem = disasm_line(rom, pc)
        lines.append(f"  ${addr:04X}:  {hexs:<12s}  {mnem}")
        pc += size
    return lines

def main():
    rom = load_rom()
    
    print("=" * 80)
    print("DEEP COLLISION SCENARIO ANALYSIS")
    print("=" * 80)
    
    # The main shot processing entry point is called from the vblank ISR.
    # Let's find where the three shot handlers are called from.
    
    # First, let's look at the complete alien shot dispatcher.
    # Based on the code at $05C1, the alien shot processing starts here
    # and dispatches based on shot type (bit 0 → rolling, else plunger/squiggly)
    
    print("\n" + "=" * 80)
    print("ALIEN SHOT DISPATCHER + SHARED ROUTINES ($0500-$05E9)")
    print("This is the common entry path for all alien shot processing.")
    print("=" * 80)
    for line in disasm_range(rom, 0x0500, 0x05E9):
        print(line)
    
    print("\n" + "=" * 80)
    print("FULL SQUIGGLY HANDLER ($05E9-$0617)")
    print("=" * 80)
    for line in disasm_range(rom, 0x05E9, 0x0617):
        print(line)
    
    print("\n" + "=" * 80)
    print("FULL PLUNGER HANDLER ($0617-$0644)")
    print("=" * 80)
    for line in disasm_range(rom, 0x0617, 0x0644):
        print(line)
    
    print("\n" + "=" * 80)
    print("FULL ROLLING HANDLER ($0644-$069A)")
    print("=" * 80)
    for line in disasm_range(rom, 0x0644, 0x069A):
        print(line)
    
    print("\n" + "=" * 80)
    print("POST-HANDLER CODE ($069A-$0798) — collision and scoring logic")
    print("=" * 80)
    for line in disasm_range(rom, 0x069A, 0x0798):
        print(line)
    
    print("\n" + "=" * 80)
    print("PLAYER SHOT HANDLER ($03BB-$04F0)")
    print("=" * 80)
    for line in disasm_range(rom, 0x03BB, 0x04F0):
        print(line)
    
    # Now look at the routine at $1A06 which is called by both player shot
    # and alien shot handlers — this might be a collision detection helper
    print("\n" + "=" * 80)
    print("ROUTINE $1A06 (called from shot handlers)")
    print("=" * 80)
    for line in disasm_range(rom, 0x1A06, 0x1A40):
        print(line)
    
    # And routines called from the collision area
    print("\n" + "=" * 80)
    print("ROUTINE $073C (called from collision code)")
    print("=" * 80)
    for line in disasm_range(rom, 0x073C, 0x0798):
        print(line)
    
    # $19DC routine
    print("\n" + "=" * 80)
    print("ROUTINE $19DC (called from collision code)")
    print("=" * 80)
    for line in disasm_range(rom, 0x19DC, 0x1A06):
        print(line)
    
    # Let's look at $050F which is a jump target from shot handlers
    print("\n" + "=" * 80)
    print("ROUTINE $050F (jump target for shot firing)")
    print("=" * 80)
    for line in disasm_range(rom, 0x050F, 0x0571):
        print(line)
    
    # Now trace all writes to plyrShotStatus and alien shot statuses
    # First find the actual player shot structure
    print("\n" + "=" * 80)
    print("SEARCHING FOR ALL REFERENCES TO PLAYER SHOT STATUS")
    print("=" * 80)
    
    # The PlayerShotHandler uses DE=$202A and CALL $1A06
    # Let's understand what $1A06 does with DE
    
    # Search for places that set status to 3 (destroyed by enemy shot)
    # MVI A,$03 followed by STA or MOV M,A
    print("\n--- Looking for MVI A,$03 near shot code ---")
    for addr in range(0x0500, 0x0800):
        if rom[addr] == 0x3E and rom[addr+1] == 0x03:
            # Show context
            for line in disasm_range(rom, max(addr-4, 0), min(addr+8, 0x2000)):
                print(line)
            print("  ---")
    
    print("\n--- Looking for MVI M,$03 near shot code ---")
    for addr in range(0x0500, 0x0800):
        if rom[addr] == 0x36 and rom[addr+1] == 0x03:
            for line in disasm_range(rom, max(addr-4, 0), min(addr+8, 0x2000)):
                print(line)
            print("  ---")
    
    # Also search whole ROM for MVI A,$03 followed by STA to any $20xx
    print("\n--- All MVI A,$03 followed by STA $20xx in entire ROM ---")
    for addr in range(0x0000, 0x1FFD):
        if rom[addr] == 0x3E and rom[addr+1] == 0x03:
            # Check if followed by STA within 4 bytes
            for off in range(2, 8):
                if addr + off + 2 < 0x2000 and rom[addr+off] == 0x32:
                    target = rom[addr+off+1] | (rom[addr+off+2] << 8)
                    if 0x2000 <= target <= 0x21FF:
                        print(f"  ${addr:04X}: MVI A,$03 ... ${addr+off:04X}: STA ${target:04X}")
                        for line in disasm_range(rom, max(addr-2, 0), min(addr+off+5, 0x2000)):
                            print(line)
                        print("  ---")
                        break
    
    # Search for MVI M,$03 at $20xx addresses (HL pointing to $20xx)
    print("\n--- All MVI M,$03 in shot-related code ---")
    for addr in range(0x0300, 0x0800):
        if rom[addr] == 0x36 and rom[addr+1] == 0x03:
            for line in disasm_range(rom, max(addr-6, 0), min(addr+6, 0x2000)):
                print(line)
            print("  ---")
    
    # Also look for where the player shot status is set to specific values
    # by searching for writes to the offset within the data structure
    # The player shot structure starts at $202A (from LXI D,$202A at $03BB)
    # Status is at offset +1 = $202B
    print("\n--- All STA to $202B (plyrShotStatus?) ---")
    for addr in range(0x0000, 0x2000):
        if rom[addr] == 0x32 and rom[addr+1] == 0x2B and rom[addr+2] == 0x20:
            for line in disasm_range(rom, max(addr-4, 0), min(addr+5, 0x2000)):
                print(line)
            print("  ---")
    
    # But the handler might use HL-relative addressing (MOV M,A)
    # Let's look at all the places that modify the status field
    # The player shot handler POPs H after CALL $1A06 with DE=$202A
    # So HL might be something derived from $202A...
    
    # Let's check $1A06 to understand what it returns
    print("\n" + "=" * 80)
    print("UNDERSTANDING SHOT DATA STRUCTURES")
    print("=" * 80)
    print("""
The arcade alien shot processing is driven by a shared 'shot control block'
structure. Each shot type (Rolling, Plunger, Squiggly) has its own block.

Let's look at the RAM layout more carefully.

From Computer Archeology / known SI analysis:
  Each alien shot has a 7-byte descriptor at a known RAM address:
    +0: status        (0=available, 1=stepping, 2=reached bottom, 
                       3=hit player, 5=exploding)
    +1: step counter  (animation frame index)
    +2: timer/delay
    +3: Y coordinate (rotated = column in screen terms)
    +4: Y delta
    +5: X coordinate (rotated = row in screen terms)
    +6: image pointer
    
  Rolling shot block: $20EB-$20F5
  Plunger shot block: $2100-$210A  
  Squiggly shot block: $2115-$211F
  
  Player shot block:  $2025-$202F (approximately)
    +0: status (0=inactive, 1=normal, 2=alien exploding, 3=bullet exploding,
                4=saucer hit, 5=alien hit pause)
    
Let's trace what happens when SpriteShotCollision detects a hit.
""")
    
    # Look at $1538 SpriteShotCollision more carefully
    print("\n" + "=" * 80) 
    print("SpriteShotCollision ($1538-$1590) + context")
    print("=" * 80)
    for line in disasm_range(rom, 0x1538, 0x15A0):
        print(line)
    
    # Now let's understand the shot status transitions
    # KEY: When alien shot handler detects collision with player bullet,
    # what values are written?
    
    # Find all references to $1538 (SpriteShotCollision)
    print("\n--- Who calls SpriteShotCollision ($1538)? ---")
    for addr in range(0x0000, 0x2000):
        if rom[addr] == 0xCD and rom[addr+1] == 0x38 and rom[addr+2] == 0x15:
            for line in disasm_range(rom, max(addr-2, 0), min(addr+5, 0x2000)):
                print(line)
            print("  ---")
    
    # Find all CALLs and JMPs to $069A 
    print("\n--- Who calls/jumps to $069A? ---")
    for addr in range(0x0000, 0x2000):
        if addr + 2 < 0x2000:
            if (rom[addr] in (0xCD, 0xC3, 0xC2, 0xCA, 0xD2, 0xDA)):
                target = rom[addr+1] | (rom[addr+2] << 8)
                if target == 0x069A:
                    for line in disasm_range(rom, max(addr-2, 0), min(addr+5, 0x2000)):
                        print(line)
                    print("  ---")
    
    # Find who calls/jumps to $0682 (the code before $069A)
    print("\n--- Who calls/jumps to $0682? ---")
    for addr in range(0x0000, 0x2000):
        if addr + 2 < 0x2000:
            if (rom[addr] in (0xCD, 0xC3, 0xC2, 0xCA, 0xD2, 0xDA)):
                target = rom[addr+1] | (rom[addr+2] << 8)
                if target == 0x0682:
                    for line in disasm_range(rom, max(addr-2, 0), min(addr+5, 0x2000)):
                        print(line)
                    print("  ---")
    
    # CRITICAL: Look at the alien shot explosion behavior more carefully
    # When shots collide, the alien shot handler needs to set the
    # player shot status to 3 (destroyed by enemy). WHERE does this happen?
    
    # Search for the value 3 being stored near shot collision code
    print("\n" + "=" * 80)
    print("TRACING PLAYER SHOT STATUS = 3 (destroyed by enemy shot)")
    print("=" * 80)
    
    # MVI A,3 or MVI M,3 anywhere in $0500-$0800
    for addr in range(0x0500, 0x0800):
        if ((rom[addr] == 0x3E and rom[addr+1] == 0x03) or 
            (rom[addr] == 0x36 and rom[addr+1] == 0x03)):
            context_start = max(addr - 8, 0)
            context_end = min(addr + 10, 0x2000)
            print(f"\n  Found at ${addr:04X}:")
            for line in disasm_range(rom, context_start, context_end):
                print(line)
    
    # Also check $1400-$1600 (ISR area)
    for addr in range(0x1400, 0x1600):
        if ((rom[addr] == 0x3E and rom[addr+1] == 0x03) or 
            (rom[addr] == 0x36 and rom[addr+1] == 0x03)):
            context_start = max(addr - 8, 0)
            context_end = min(addr + 10, 0x2000)
            print(f"\n  Found at ${addr:04X}:")
            for line in disasm_range(rom, context_start, context_end):
                print(line)
    
    # Let me also look at what $0742 and $074B do — these are called
    # from the collision code
    print("\n" + "=" * 80)
    print("ROUTINES $0742, $074B, $070C, $075F — collision handling helpers")
    print("=" * 80)

    print("\n--- $0700-$0798 (full block) ---")
    for line in disasm_range(rom, 0x0700, 0x0798):
        print(line)

if __name__ == "__main__":
    main()
