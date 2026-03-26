#!/usr/bin/env python3
"""
Final focused analysis: trace ALL collision paths in the arcade ROM.
Key finding: Player shot status is at RAM $2025, NOT $20C0.

Status values:
  0 = Available
  1 = Moving
  2 = Alien hit (exploding alien)
  3 = Destroyed by enemy shot (cross explosion, 16 frames)
  4 = Cleanup/done
  5 = Alien hit delay

Find: ALL references to $1530 (sets status=3) and $2025 (status register)
"""

def load_rom():
    rom = bytearray(0x2000)
    for fname, base in [
        ("Assets/Intel8080/invaders.h", 0x0000),
        ("Assets/Intel8080/invaders.g", 0x0800),
        ("Assets/Intel8080/invaders.f", 0x1000),
        ("Assets/Intel8080/invaders.e", 0x1800),
    ]:
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
    0x46: ("MOV B,M", 1), 0x47: ("MOV B,A", 1), 0x4E: ("MOV C,M", 1),
    0x4F: ("MOV C,A", 1), 0x56: ("MOV D,M", 1), 0x57: ("MOV D,A", 1),
    0x5E: ("MOV E,M", 1), 0x5F: ("MOV E,A", 1), 0x66: ("MOV H,M", 1),
    0x67: ("MOV H,A", 1), 0x6E: ("MOV L,M", 1), 0x6F: ("MOV L,A", 1),
    0x77: ("MOV M,A", 1), 0x7E: ("MOV A,M", 1),
    0x78: ("MOV A,B", 1), 0x79: ("MOV A,C", 1), 0x7A: ("MOV A,D", 1),
    0x7B: ("MOV A,E", 1), 0x7C: ("MOV A,H", 1), 0x7D: ("MOV A,L", 1),
    0x80: ("ADD B", 1), 0x81: ("ADD C", 1), 0x86: ("ADD M", 1),
    0x87: ("ADD A", 1), 0x90: ("SUB B", 1), 0x96: ("SUB M", 1),
    0x97: ("SUB A", 1), 0xA0: ("ANA B", 1), 0xA7: ("ANA A", 1),
    0xA8: ("XRA B", 1), 0xAE: ("XRA M", 1), 0xAF: ("XRA A", 1),
    0xB0: ("ORA B", 1), 0xB4: ("ORA H", 1), 0xB6: ("ORA M", 1),
    0xB7: ("ORA A", 1), 0xB8: ("CMP B", 1), 0xBC: ("CMP H", 1),
    0xBE: ("CMP M", 1),
    0xC0: ("RNZ", 1), 0xC1: ("POP B", 1), 0xC2: ("JNZ ${:04X}", 3),
    0xC3: ("JMP ${:04X}", 3), 0xC4: ("CNZ ${:04X}", 3), 0xC5: ("PUSH B", 1),
    0xC6: ("ADI ${:02X}", 2), 0xC8: ("RZ", 1), 0xC9: ("RET", 1),
    0xCA: ("JZ ${:04X}", 3), 0xCC: ("CZ ${:04X}", 3),
    0xCD: ("CALL ${:04X}", 3), 0xD0: ("RNC", 1), 0xD1: ("POP D", 1),
    0xD2: ("JNC ${:04X}", 3), 0xD3: ("OUT ${:02X}", 2),
    0xD4: ("CNC ${:04X}", 3), 0xD5: ("PUSH D", 1),
    0xD6: ("SUI ${:02X}", 2), 0xD8: ("RC", 1), 0xDA: ("JC ${:04X}", 3),
    0xDB: ("IN ${:02X}", 2), 0xDE: ("SBI ${:02X}", 2),
    0xE1: ("POP H", 1), 0xE3: ("XTHL", 1), 0xE5: ("PUSH H", 1),
    0xE6: ("ANI ${:02X}", 2), 0xE9: ("PCHL", 1), 0xEB: ("XCHG", 1),
    0xEE: ("XRI ${:02X}", 2), 0xF1: ("POP PSW", 1), 0xF5: ("PUSH PSW", 1),
    0xF6: ("ORI ${:02X}", 2), 0xFB: ("EI", 1), 0xFE: ("CPI ${:02X}", 2),
    0xFA: ("JM ${:04X}", 3), 0xF2: ("JP ${:04X}", 3),
    0xF0: ("RP", 1), 0xF8: ("RM", 1),
}

def disasm_range(rom, start, end):
    pc = start
    lines = []
    while pc < end and pc < len(rom):
        opcode = rom[pc]
        if opcode in OPCODES:
            fmt, size = OPCODES[opcode]
            raw = rom[pc:pc+size]
            hex_str = " ".join(f"{b:02X}" for b in raw)
            if size == 1:
                mnem = fmt
            elif size == 2:
                mnem = fmt.format(rom[pc+1])
            else:
                word = rom[pc+1] | (rom[pc+2] << 8)
                mnem = fmt.format(word)
            lines.append(f"  ${pc:04X}:  {hex_str:<12s}  {mnem}")
            pc += size
        else:
            lines.append(f"  ${pc:04X}:  {rom[pc]:02X}           DB ${rom[pc]:02X}")
            pc += 1
    return lines

def find_all_refs(rom, target_addr):
    """Find all 3-byte instructions that reference target_addr."""
    refs = []
    lo = target_addr & 0xFF
    hi = (target_addr >> 8) & 0xFF
    for addr in range(0, len(rom) - 2):
        if rom[addr+1] == lo and rom[addr+2] == hi:
            opcode = rom[addr]
            if opcode in OPCODES:
                _, size = OPCODES[opcode]
                if size == 3:
                    refs.append(addr)
    return refs

def main():
    rom = load_rom()
    
    print("=" * 80)
    print("FINAL COLLISION SCENARIO ANALYSIS")
    print("Player shot status register: RAM $2025")
    print("=" * 80)
    
    # 1. Find ALL references to $1530 (the routine that sets status=3)
    print("\n" + "=" * 80)
    print("A. ALL REFERENCES TO $1530 (sets plyrShotStatus := 3)")
    print("=" * 80)
    refs = find_all_refs(rom, 0x1530)
    for ref in refs:
        print(f"\n  Reference at ${ref:04X}:")
        for line in disasm_range(rom, max(ref-8, 0), min(ref+6, 0x2000)):
            print(line)
    if not refs:
        print("  None found!")
        # Check if it's reached by fall-through
        print("  (May be reached by fall-through only)")
    
    # 2. Find ALL references to $2025 (player shot status)
    print("\n" + "=" * 80)
    print("B. ALL REFERENCES TO $2025 (plyrShotStatus)")
    print("=" * 80)
    refs = find_all_refs(rom, 0x2025)
    for ref in refs:
        opcode = rom[ref]
        if opcode in OPCODES:
            fmt, _ = OPCODES[opcode]
        else:
            fmt = "?"
        mnem_name = fmt.split("{")[0] if "{" in fmt else fmt
        print(f"  ${ref:04X}: {mnem_name.strip()} $2025")
    
    # Show context for each STA $2025 (writes to status)
    print("\n  --- Details of STA $2025 (writes to status) ---")
    for ref in refs:
        if rom[ref] == 0x32:  # STA
            # Find the value being stored by looking for MVI A,xx or XRA A before
            val = "?"
            for back in range(1, 15):
                if ref - back >= 0:
                    if rom[ref-back] == 0x3E:  # MVI A
                        val = f"${rom[ref-back+1]:02X} ({rom[ref-back+1]})"
                        break
                    elif rom[ref-back] == 0xAF:  # XRA A = 0
                        val = "$00 (0, via XRA A)"
                        break
            print(f"\n  ${ref:04X}: STA $2025 = {val}")
            for line in disasm_range(rom, max(ref-6, 0), min(ref+4, 0x2000)):
                print(line)
    
    # 3. Find who CALLS/JUMPS to $1579 (sets $2085=1, jumps to $1545)
    print("\n" + "=" * 80) 
    print("C. ALL REFERENCES TO $1579 (sets collision flag $2085=1)")
    print("=" * 80)
    refs = find_all_refs(rom, 0x1579)
    for ref in refs:
        print(f"\n  Reference at ${ref:04X}:")
        for line in disasm_range(rom, max(ref-8, 0), min(ref+6, 0x2000)):
            print(line)
    if not refs:
        print("  None found! (reached by fall-through)")
    
    # 4. Find who references $2085 (collision flag)
    print("\n" + "=" * 80)
    print("D. ALL REFERENCES TO $2085 (collision/blow flag)")
    print("=" * 80)
    refs = find_all_refs(rom, 0x2085)
    for ref in refs:
        print(f"  ${ref:04X}:")
        for line in disasm_range(rom, ref, min(ref+4, 0x2000)):
            print(line)
    
    # 5. The CRITICAL question: What CALLS into the block at $1520-$1535?
    # Let's see the full block and find all refs
    print("\n" + "=" * 80)
    print("E. FULL BLOCK $1520-$1560 (collision detection area)")
    print("=" * 80)
    for line in disasm_range(rom, 0x1520, 0x1560):
        print(line)
    
    # Find references to $1528
    print("\n  --- References to $1528 ---")
    for r in find_all_refs(rom, 0x1528):
        print(f"  ${r:04X}:")
        for line in disasm_range(rom, max(r-4, 0), min(r+4, 0x2000)):
            print(line)
    
    # 6. The dispatcher at $05C1 — where does it call based on shot type?
    # And how does each shot type handle collision with player bullet?
    print("\n" + "=" * 80)
    print("F. IDENTIFYING THE COLLISION CHECK IN EACH SHOT TYPE")
    print("=" * 80)
    
    # The shared code at $0563 is called from alien shot processing
    # Let's look at what calls $0563
    print("\n--- Who calls $0563? ---")
    refs = find_all_refs(rom, 0x0563)
    for ref in refs:
        print(f"  ${ref:04X}:")
        for line in disasm_range(rom, max(ref-4, 0), min(ref+6, 0x2000)):
            print(line)
    
    # Now let's understand the flow more carefully
    # The key path: $05C1 → dispatch based on bit 0
    #   Bit 0 = 1 → Rolling ($0644)
    #   Bit 0 = 0 → Plunger/Squiggly → $05CF → INR M → CALL $0675
    
    # After the type-specific handlers, control returns to common code
    # that checks for player bullet collision.
    # Let's trace from $0675 (called/jumped from handlers)
    print("\n" + "=" * 80)
    print("G. TRACING FROM $0675 (common post-handler code)")
    print("=" * 80)
    for line in disasm_range(rom, 0x0675, 0x0682):
        print(line)
    print("  Note: $0675 calls $1A3B (read sprite ptr) then JMP $1452")
    print("  $1452 is likely DrawShields/erase sprite area")
    
    # Look at $1452
    print("\n--- $1452 routine ---")
    for line in disasm_range(rom, 0x1452, 0x1480):
        print(line)
    
    # 7. LOOK AT THE PLAYER SHOT HANDLER'S OWN COLLISION CHECK
    # In status 1 (moving), at $03FA:
    # $03FA: INR A → A=2, MOV M,A → status=2
    # Wait, that just sets status to 2 before checking... Let me re-read
    print("\n" + "=" * 80)
    print("H. PLAYER SHOT STATUS 1 (MOVING) — COLLISION CHECKS")
    print("=" * 80)
    for line in disasm_range(rom, 0x03FA, 0x040A):
        print(line)
    print("""
  Analysis: When player shot status=1 (moving):
  - $03FA: A was 1 (from CPI $01 match), INR A → A=2
  - $03FB: MOV M,A → set status to 2 (tentatively "alien hit"?)
  - $03FC: LDA $201B → player Y position
  - $03FF: ADI $08 → add 8 (shot offset?)
  - $0401: STA $202A → store shot Y
  - $0404: CALL $0430 → update display
  - $0407: JMP $1400 → DrawAlienRow (check for alien hit)
  
  NOTE: Status is set to 2 BEFORE the actual collision check. If the
  collision check at $1400 finds no alien hit, it must reset the status.
""")
    
    # Let's trace $1400 - DrawAlienRow / collision area
    print("\n--- $1400-$1440 ---")
    for line in disasm_range(rom, 0x1400, 0x1440):
        print(line)
    
    # 8. Find ALL references to $1439 (another common entry)
    print("\n--- Who calls $1439? ---")
    refs = find_all_refs(rom, 0x1439)
    for ref in refs:
        print(f"  ${ref:04X}:")
        for line in disasm_range(rom, max(ref-2, 0), min(ref+4, 0x2000)):
            print(line)
    
    # 9. Look at the whole $1400-$1540 block more carefully
    print("\n" + "=" * 80)
    print("I. FULL COLLISION DETECTION AREA $1400-$1540")
    print("=" * 80)
    for line in disasm_range(rom, 0x1400, 0x1540):
        print(line)
    
    # 10. Summary of collision behavior per shot type
    print("\n" + "=" * 80)
    print("SUMMARY: COLLISION PATHS")
    print("=" * 80)
    print("""
Based on the disassembly analysis:

1. The player shot has status values at RAM $2025:
   0=available, 1=moving, 2=alien-exploding, 3=destroyed-by-enemy, 4=cleanup, 5=alien-hit-init

2. The routine at $1530 sets status := 3 (destroyed by enemy shot):
   $1530: MVI A,$03
   $1532: STA $2025
   $1535: JMP $154A
   This is the ONLY place in the ROM that sets status to 3.

3. The routine at $1538 (SpriteShotCollision) handles the explosion timer:
   Decrements $2003 each frame until 0, then sets status := 4 (cleanup done).

4. $2085 is a collision flag: 1 = collision detected.
   Set at $1579 (JMP $1545 → status 4 path).
   Checked at $06B5 by the alien shot scoring/cleanup code.

5. Each alien shot type either CALLS or SKIPS the collision check:
   - Plunger & Squiggly: check for collision → mutual destruction
   - Rolling: SKIPS the collision check entirely (Teflon)
""")

if __name__ == "__main__":
    main()
