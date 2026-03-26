#!/usr/bin/env python3
"""
Disassemble all three alien shot handlers and the player shot handler
from the Space Invaders arcade ROM to identify every collision scenario.

Focus: When player bullet meets enemy shot, what happens to each?
"""

import struct

def load_rom():
    """Load all four ROM files into a single 8KB address space."""
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

def get_byte(rom, addr):
    return rom[addr]

def get_word(rom, addr):
    return rom[addr] | (rom[addr+1] << 8)

# Simple 8080 disassembler for the ranges we care about
OPCODES = {
    0x00: ("NOP", 1),
    0x01: ("LXI B,${:04X}", 3),
    0x03: ("INX B", 1),
    0x04: ("INR B", 1),
    0x05: ("DCR B", 1),
    0x06: ("MVI B,${:02X}", 2),
    0x07: ("RLC", 1),
    0x09: ("DAD B", 1),
    0x0A: ("LDAX B", 1),
    0x0B: ("DCX B", 1),
    0x0C: ("INR C", 1),
    0x0D: ("DCR C", 1),
    0x0E: ("MVI C,${:02X}", 2),
    0x0F: ("RRC", 1),
    0x11: ("LXI D,${:04X}", 3),
    0x13: ("INX D", 1),
    0x14: ("INR D", 1),
    0x15: ("DCR D", 1),
    0x16: ("MVI D,${:02X}", 2),
    0x17: ("RAL", 1),
    0x19: ("DAD D", 1),
    0x1A: ("LDAX D", 1),
    0x1B: ("DCX D", 1),
    0x1E: ("MVI E,${:02X}", 2),
    0x1F: ("RAR", 1),
    0x21: ("LXI H,${:04X}", 3),
    0x22: ("SHLD ${:04X}", 3),
    0x23: ("INX H", 1),
    0x24: ("INR H", 1),
    0x25: ("DCR H", 1),
    0x26: ("MVI H,${:02X}", 2),
    0x27: ("DAA", 1),
    0x29: ("DAD H", 1),
    0x2A: ("LHLD ${:04X}", 3),
    0x2B: ("DCX H", 1),
    0x2C: ("INR L", 1),
    0x2D: ("DCR L", 1),
    0x2E: ("MVI L,${:02X}", 2),
    0x2F: ("CMA", 1),
    0x31: ("LXI SP,${:04X}", 3),
    0x32: ("STA ${:04X}", 3),
    0x34: ("INR M", 1),
    0x35: ("DCR M", 1),
    0x36: ("MVI M,${:02X}", 2),
    0x37: ("STC", 1),
    0x3A: ("LDA ${:04X}", 3),
    0x3C: ("INR A", 1),
    0x3D: ("DCR A", 1),
    0x3E: ("MVI A,${:02X}", 2),
    0x3F: ("CMC", 1),
    0x40: ("MOV B,B", 1),
    0x41: ("MOV B,C", 1),
    0x42: ("MOV B,D", 1),
    0x43: ("MOV B,E", 1),
    0x44: ("MOV B,H", 1),
    0x45: ("MOV B,L", 1),
    0x46: ("MOV B,M", 1),
    0x47: ("MOV B,A", 1),
    0x48: ("MOV C,B", 1),
    0x49: ("MOV C,C", 1),
    0x4A: ("MOV C,D", 1),
    0x4B: ("MOV C,E", 1),
    0x4C: ("MOV C,H", 1),
    0x4D: ("MOV C,L", 1),
    0x4E: ("MOV C,M", 1),
    0x4F: ("MOV C,A", 1),
    0x50: ("MOV D,B", 1),
    0x51: ("MOV D,C", 1),
    0x52: ("MOV D,D", 1),
    0x53: ("MOV D,E", 1),
    0x54: ("MOV D,H", 1),
    0x55: ("MOV D,L", 1),
    0x56: ("MOV D,M", 1),
    0x57: ("MOV D,A", 1),
    0x58: ("MOV E,B", 1),
    0x59: ("MOV E,C", 1),
    0x5A: ("MOV E,D", 1),
    0x5B: ("MOV E,E", 1),
    0x5C: ("MOV E,H", 1),
    0x5D: ("MOV E,L", 1),
    0x5E: ("MOV E,M", 1),
    0x5F: ("MOV E,A", 1),
    0x60: ("MOV H,B", 1),
    0x61: ("MOV H,C", 1),
    0x62: ("MOV H,D", 1),
    0x63: ("MOV H,E", 1),
    0x64: ("MOV H,H", 1),
    0x65: ("MOV H,L", 1),
    0x66: ("MOV H,M", 1),
    0x67: ("MOV H,A", 1),
    0x68: ("MOV L,B", 1),
    0x69: ("MOV L,C", 1),
    0x6A: ("MOV L,D", 1),
    0x6B: ("MOV L,E", 1),
    0x6C: ("MOV L,H", 1),
    0x6D: ("MOV L,L", 1),
    0x6E: ("MOV L,M", 1),
    0x6F: ("MOV L,A", 1),
    0x70: ("MOV M,B", 1),
    0x71: ("MOV M,C", 1),
    0x72: ("MOV M,D", 1),
    0x73: ("MOV M,E", 1),
    0x74: ("MOV M,H", 1),
    0x75: ("MOV M,L", 1),
    0x76: ("HLT", 1),
    0x77: ("MOV M,A", 1),
    0x78: ("MOV A,B", 1),
    0x79: ("MOV A,C", 1),
    0x7A: ("MOV A,D", 1),
    0x7B: ("MOV A,E", 1),
    0x7C: ("MOV A,H", 1),
    0x7D: ("MOV A,L", 1),
    0x7E: ("MOV A,M", 1),
    0x7F: ("MOV A,A", 1),
    0x80: ("ADD B", 1),
    0x81: ("ADD C", 1),
    0x82: ("ADD D", 1),
    0x83: ("ADD E", 1),
    0x84: ("ADD H", 1),
    0x85: ("ADD L", 1),
    0x86: ("ADD M", 1),
    0x87: ("ADD A", 1),
    0x88: ("ADC B", 1),
    0x90: ("SUB B", 1),
    0x91: ("SUB C", 1),
    0x96: ("SUB M", 1),
    0x97: ("SUB A", 1),
    0xA0: ("ANA B", 1),
    0xA6: ("ANA M", 1),
    0xA7: ("ANA A", 1),
    0xAE: ("XRA M", 1),
    0xAF: ("XRA A", 1),
    0xB0: ("ORA B", 1),
    0xB1: ("ORA C", 1),
    0xB4: ("ORA H", 1),
    0xB6: ("ORA M", 1),
    0xB7: ("ORA A", 1),
    0xB8: ("CMP B", 1),
    0xB9: ("CMP C", 1),
    0xBA: ("CMP D", 1),
    0xBB: ("CMP E", 1),
    0xBC: ("CMP H", 1),
    0xBD: ("CMP L", 1),
    0xBE: ("CMP M", 1),
    0xBF: ("CMP A", 1),
    0xC0: ("RNZ", 1),
    0xC1: ("POP B", 1),
    0xC2: ("JNZ ${:04X}", 3),
    0xC3: ("JMP ${:04X}", 3),
    0xC4: ("CNZ ${:04X}", 3),
    0xC5: ("PUSH B", 1),
    0xC6: ("ADI ${:02X}", 2),
    0xC8: ("RZ", 1),
    0xC9: ("RET", 1),
    0xCA: ("JZ ${:04X}", 3),
    0xCC: ("CZ ${:04X}", 3),
    0xCD: ("CALL ${:04X}", 3),
    0xD0: ("RNC", 1),
    0xD1: ("POP D", 1),
    0xD2: ("JNC ${:04X}", 3),
    0xD3: ("OUT ${:02X}", 2),
    0xD4: ("CNC ${:04X}", 3),
    0xD5: ("PUSH D", 1),
    0xD6: ("SUI ${:02X}", 2),
    0xD8: ("RC", 1),
    0xDA: ("JC ${:04X}", 3),
    0xDB: ("IN ${:02X}", 2),
    0xDE: ("SBI ${:02X}", 2),
    0xE1: ("POP H", 1),
    0xE3: ("XTHL", 1),
    0xE5: ("PUSH H", 1),
    0xE6: ("ANI ${:02X}", 2),
    0xE9: ("PCHL", 1),
    0xEB: ("XCHG", 1),
    0xEE: ("XRI ${:02X}", 2),
    0xF1: ("POP PSW", 1),
    0xF5: ("PUSH PSW", 1),
    0xF6: ("ORI ${:02X}", 2),
    0xFB: ("EI", 1),
    0xFC: ("CM ${:04X}", 3),
    0xFE: ("CPI ${:02X}", 2),
}

# Known RAM addresses for annotation
RAM_LABELS = {
    0x2000: "gameMode",
    0x2002: "alienCurIndex",
    0x2005: "alienIsExploding",
    0x2006: "refAlienY",
    0x2007: "refAlienX",
    0x2008: "rackDirection",
    0x2009: "rackDownDelta",
    0x200A: "playerAlive",
    0x2015: "playerXr",
    0x2025: "p1ShieldBuffer",
    0x2067: "numAliens",
    0x2068: "saucerActive",
    0x206B: "tillSaucerTime",
    0x206F: "shotCountdown",
    0x2072: "numCoins",
    0x2078: "P1ScorL",
    0x2079: "P1ScorM",
    0x2080: "shotSync",
    0x2084: "numLives",
    # Player shot structure
    0x20C0: "plyrShotStatus",
    0x20C1: "plyrShotStepCnt",
    0x20C2: "plyrShotTimer",
    0x20C3: "plyrShotYr",
    0x20C5: "plyrShotXr",
    0x20C7: "plyrShotImagePtr",  # unused? maybe plyrShotCFire
    # Rolling shot structure (at $20EB)
    0x20EB: "rolShotStatus",
    0x20EC: "rolShotStepCnt",
    0x20ED: "rolShotTimer",
    0x20EE: "rolShotYr",
    0x20EF: "rolShotYrDelta",
    0x20F0: "rolShotXr",
    0x20F1: "rolShotXrImg",
    0x20F3: "rolShotCFire",
    0x20F5: "rolShotBlowCnt",
    # Plunger shot structure (at $2100)
    0x2100: "pluShotStatus",
    0x2101: "pluShotStepCnt",
    0x2102: "pluShotTimer",
    0x2103: "pluShotYr",
    0x2104: "pluShotYrDelta",
    0x2105: "pluShotXr",
    0x2106: "pluShotXrImg",
    0x2108: "pluShotCFire",
    0x210A: "pluShotBlowCnt",
    # Squiggly shot structure (at $2115)
    0x2115: "squShotStatus",
    0x2116: "squShotStepCnt",
    0x2117: "squShotTimer",
    0x2118: "squShotYr",
    0x2119: "squShotYrDelta",
    0x211A: "squShotXr",
    0x211B: "squShotXrImg",
    0x211D: "squShotCFire",
    0x211F: "squShotBlowCnt",
}

ROM_LABELS = {
    0x0141: "EraseSimpleSprite",
    0x017A: "DrawSpriteGeneric",
    0x01A1: "PlayerShotHitAlien",
    0x01C0: "ReadInputs",
    0x0380: "RemoveAlien",
    0x03BB: "PlayerShotHandler",
    0x0476: "HandleShotStatus2",  # approx
    0x04AB: "HandleShotStatus3",  # approx
    0x04B7: "HandleShotStatus4",
    0x0550: "ScoreForAlien",
    0x0571: "ShotReadyToFire",
    0x0580: "ShotStepDown",
    0x05A2: "ShotCheckShield",
    0x05C0: "ShotExplode",
    0x05D3: "ShotCheckBottom",
    0x05E9: "SquigglyShotHandler",
    0x0617: "PlungerShotHandler",
    0x0644: "RollingShotHandler",
    0x069A: "ShotVsPlayerBullet",  # called by Plunger & Squiggly
    0x0798: "TimeToFire",
    0x1538: "SpriteShotCollision",
}

def disasm(rom, start, end_addr):
    """Disassemble a range and return list of (addr, bytes_hex, mnemonic, comment)."""
    lines = []
    pc = start
    while pc < end_addr:
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
            else:
                mnem = fmt
            
            # Add label annotations
            comment = ""
            if size == 3:
                word = rom[pc+1] | (rom[pc+2] << 8)
                if word in RAM_LABELS:
                    comment = f"; {RAM_LABELS[word]}"
                elif word in ROM_LABELS:
                    comment = f"; {ROM_LABELS[word]}"
            elif size == 2 and opcode in (0x3E, 0xFE, 0xC6, 0xD6, 0xE6, 0x06, 0x0E, 0x16, 0x1E, 0x26, 0x2E, 0x36):
                val = rom[pc+1]
                comment = f"; ={val}"
            
            # Label the address itself
            addr_label = ""
            if pc in ROM_LABELS:
                addr_label = f"  ; <<< {ROM_LABELS[pc]} >>>"
            
            lines.append(f"  ${pc:04X}:  {hex_str:<12s}  {mnem:<24s}{comment}{addr_label}")
            pc += size
        else:
            lines.append(f"  ${pc:04X}:  {rom[pc]:02X}           DB ${rom[pc]:02X}")
            pc += 1
    return lines

def main():
    rom = load_rom()
    
    print("=" * 80)
    print("SPACE INVADERS ARCADE ROM — SHOT COLLISION ANALYSIS")
    print("=" * 80)
    
    # =========================================================================
    print("\n" + "=" * 80)
    print("1. SQUIGGLY SHOT HANDLER ($05E9 - $0616)")
    print("   This handler processes the squiggly alien shot.")
    print("=" * 80)
    for line in disasm(rom, 0x05E9, 0x0617):
        print(line)
    
    # =========================================================================
    print("\n" + "=" * 80)
    print("2. PLUNGER SHOT HANDLER ($0617 - $0643)")
    print("   This handler processes the plunger alien shot.")
    print("=" * 80)
    for line in disasm(rom, 0x0617, 0x0644):
        print(line)
    
    # =========================================================================
    print("\n" + "=" * 80)
    print("3. ROLLING SHOT HANDLER ($0644 - $0699)")
    print("   This handler processes the rolling/teflon alien shot.")
    print("   NOTE: This is the 'teflon' shot — does it skip collision?")
    print("=" * 80)
    for line in disasm(rom, 0x0644, 0x069A):
        print(line)
    
    # =========================================================================
    print("\n" + "=" * 80)
    print("4. ShotVsPlayerBullet ROUTINE ($069A - $06FF)")
    print("   Called by Plunger & Squiggly to check player bullet collision.")
    print("=" * 80)
    for line in disasm(rom, 0x069A, 0x0700):
        print(line)
    
    # =========================================================================
    print("\n" + "=" * 80)
    print("5. SHARED SHOT ROUTINES")
    print("=" * 80)
    
    print("\n--- ShotReadyToFire ($0571) ---")
    for line in disasm(rom, 0x0571, 0x0580):
        print(line)
    
    print("\n--- ShotStepDown ($0580) ---")
    for line in disasm(rom, 0x0580, 0x05A2):
        print(line)
    
    print("\n--- ShotCheckShield ($05A2) ---")
    for line in disasm(rom, 0x05A2, 0x05C0):
        print(line)

    print("\n--- ShotExplode ($05C0) ---")
    for line in disasm(rom, 0x05C0, 0x05D3):
        print(line)
    
    print("\n--- ShotCheckBottom ($05D3) ---")
    for line in disasm(rom, 0x05D3, 0x05E9):
        print(line)
    
    # =========================================================================
    print("\n" + "=" * 80)
    print("6. PLAYER SHOT HANDLER ($03BB - $04F0)")
    print("   Main state machine for the player's bullet.")
    print("=" * 80)
    for line in disasm(rom, 0x03BB, 0x04F0):
        print(line)
    
    # =========================================================================
    print("\n" + "=" * 80)
    print("7. SpriteShotCollision ($1538 - $1590)")
    print("   Pixel-level collision detection routine.")
    print("=" * 80)
    for line in disasm(rom, 0x1538, 0x1590):
        print(line)
    
    # =========================================================================
    # Now let's trace the logic flow for each shot type
    print("\n" + "=" * 80)
    print("ANALYSIS SUMMARY")
    print("=" * 80)
    
    print("""
KEY QUESTION: What are ALL the collision scenarios?

We need to trace what happens in each shot handler when the player bullet
is near the enemy shot. Specifically:

For Squiggly ($05E9) and Plunger ($0617):
- Both share a common structure: check status, step down, check shield,
  check bottom, then CALL the ShotVsPlayerBullet routine.
- ShotVsPlayerBullet checks if the player bullet and alien shot overlap.
- If they DO overlap: what happens to EACH bullet?

For Rolling ($0644):
- Uses a DIFFERENT structure. Does it skip the ShotVsPlayerBullet call?
- If so, the player bullet passes through — confirming "Teflon" behavior.

Let's look at the actual call patterns:
""")
    
    # Check what the three handlers call
    print("--- Squiggly handler calls ---")
    for addr in range(0x05E9, 0x0617):
        op = rom[addr]
        if op == 0xCD:  # CALL
            target = rom[addr+1] | (rom[addr+2] << 8)
            label = ROM_LABELS.get(target, "")
            print(f"  ${addr:04X}: CALL ${target:04X}  {label}")
    
    print("\n--- Plunger handler calls ---")
    for addr in range(0x0617, 0x0644):
        op = rom[addr]
        if op == 0xCD:  # CALL
            target = rom[addr+1] | (rom[addr+2] << 8)
            label = ROM_LABELS.get(target, "")
            print(f"  ${addr:04X}: CALL ${target:04X}  {label}")
    
    print("\n--- Rolling handler calls ---")
    for addr in range(0x0644, 0x069A):
        op = rom[addr]
        if op == 0xCD:  # CALL
            target = rom[addr+1] | (rom[addr+2] << 8)
            label = ROM_LABELS.get(target, "")
            print(f"  ${addr:04X}: CALL ${target:04X}  {label}")
    
    # Check what ShotVsPlayerBullet does
    print("\n--- ShotVsPlayerBullet calls ---")
    for addr in range(0x069A, 0x0700):
        op = rom[addr]
        if op == 0xCD:  # CALL
            target = rom[addr+1] | (rom[addr+2] << 8)
            label = ROM_LABELS.get(target, "")
            print(f"  ${addr:04X}: CALL ${target:04X}  {label}")
    
    # Now check all conditional jumps and returns in ShotVsPlayerBullet
    print("\n--- ShotVsPlayerBullet flow control ---")
    for addr in range(0x069A, 0x0700):
        op = rom[addr]
        if op in (0xC0, 0xC8, 0xD0, 0xD8):
            names = {0xC0: "RNZ", 0xC8: "RZ", 0xD0: "RNC", 0xD8: "RC"}
            print(f"  ${addr:04X}: {names[op]}")
        elif op in (0xC2, 0xCA, 0xD2, 0xDA):
            target = rom[addr+1] | (rom[addr+2] << 8)
            names = {0xC2: "JNZ", 0xCA: "JZ", 0xD2: "JNC", 0xDA: "JC"}
            label = ROM_LABELS.get(target, "")
            print(f"  ${addr:04X}: {names[op]} ${target:04X}  {label}")
        elif op == 0xC9:
            print(f"  ${addr:04X}: RET")
        elif op == 0xC3:
            target = rom[addr+1] | (rom[addr+2] << 8)
            label = ROM_LABELS.get(target, "")
            print(f"  ${addr:04X}: JMP ${target:04X}  {label}")
    
    # Now check the PlayerShotHandler status values
    print("\n" + "=" * 80)
    print("PLAYER SHOT STATUS VALUES")
    print("=" * 80)
    print("""
From the PlayerShotHandler ($03BB):
  Status 0: Inactive — check fire button
  Status 1: Moving — advance shot, check alien hit
  Status 2: Alien hit — exploding (alien death animation)
  Status 3: Destroyed by enemy shot — show cross explosion
  Status 4: Cleanup after explosion
  Status 5: Hit alien — brief pause (different from status 2?)

Let's check what sets plyrShotStatus to each value:
""")
    
    # Search for STA to plyrShotStatus ($20C0)
    print("--- All writes to plyrShotStatus ($20C0) ---")
    for addr in range(0x0000, 0x2000):
        if rom[addr] == 0x32:  # STA
            target = rom[addr+1] | (rom[addr+2] << 8)
            if target == 0x20C0:
                # What value? Check preceding MVI A
                val = "?"
                for back in range(1, 10):
                    if addr - back >= 0 and rom[addr-back] == 0x3E:
                        val = f"${rom[addr-back+1]:02X} (={rom[addr-back+1]})"
                        break
                    elif addr - back >= 0 and rom[addr-back] == 0xAF:
                        val = "$00 (XRA A = 0)"
                        break
                print(f"  ${addr:04X}: STA $20C0  ; value = {val}")
    
    # Also check what the ShotVsPlayerBullet routine does with the player shot
    print("\n--- Detailed trace of ShotVsPlayerBullet ($069A) ---")
    print("   What does it do when a collision IS detected?\n")
    for line in disasm(rom, 0x069A, 0x0710):
        print(line)

if __name__ == "__main__":
    main()
