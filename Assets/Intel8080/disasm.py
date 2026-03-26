#!/usr/bin/env python3
"""
Intel 8080 disassembler for Space Invaders ROM.
Reads the four ROM files (h,g,e,f) and produces a disassembly
with known routine labels from the well-documented original arcade game.
"""

import sys

# Intel 8080 instruction set: (mnemonic, length)
# length includes the opcode byte
OPCODES = {
    0x00: ("NOP", 1),
    0x01: ("LXI B,", 3),
    0x02: ("STAX B", 1),
    0x03: ("INX B", 1),
    0x04: ("INR B", 1),
    0x05: ("DCR B", 1),
    0x06: ("MVI B,", 2),
    0x07: ("RLC", 1),
    0x08: ("NOP", 1),
    0x09: ("DAD B", 1),
    0x0A: ("LDAX B", 1),
    0x0B: ("DCX B", 1),
    0x0C: ("INR C", 1),
    0x0D: ("DCR C", 1),
    0x0E: ("MVI C,", 2),
    0x0F: ("RRC", 1),
    0x10: ("NOP", 1),
    0x11: ("LXI D,", 3),
    0x12: ("STAX D", 1),
    0x13: ("INX D", 1),
    0x14: ("INR D", 1),
    0x15: ("DCR D", 1),
    0x16: ("MVI D,", 2),
    0x17: ("RAL", 1),
    0x18: ("NOP", 1),
    0x19: ("DAD D", 1),
    0x1A: ("LDAX D", 1),
    0x1B: ("DCX D", 1),
    0x1C: ("INR E", 1),
    0x1D: ("DCR E", 1),
    0x1E: ("MVI E,", 2),
    0x1F: ("RAR", 1),
    0x20: ("RIM", 1),
    0x21: ("LXI H,", 3),
    0x22: ("SHLD ", 3),
    0x23: ("INX H", 1),
    0x24: ("INR H", 1),
    0x25: ("DCR H", 1),
    0x26: ("MVI H,", 2),
    0x27: ("DAA", 1),
    0x28: ("NOP", 1),
    0x29: ("DAD H", 1),
    0x2A: ("LHLD ", 3),
    0x2B: ("DCX H", 1),
    0x2C: ("INR L", 1),
    0x2D: ("DCR L", 1),
    0x2E: ("MVI L,", 2),
    0x2F: ("CMA", 1),
    0x30: ("SIM", 1),
    0x31: ("LXI SP,", 3),
    0x32: ("STA ", 3),
    0x33: ("INX SP", 1),
    0x34: ("INR M", 1),
    0x35: ("DCR M", 1),
    0x36: ("MVI M,", 2),
    0x37: ("STC", 1),
    0x38: ("NOP", 1),
    0x39: ("DAD SP", 1),
    0x3A: ("LDA ", 3),
    0x3B: ("DCX SP", 1),
    0x3C: ("INR A", 1),
    0x3D: ("DCR A", 1),
    0x3E: ("MVI A,", 2),
    0x3F: ("CMC", 1),
    0x40: ("MOV B,B", 1), 0x41: ("MOV B,C", 1), 0x42: ("MOV B,D", 1),
    0x43: ("MOV B,E", 1), 0x44: ("MOV B,H", 1), 0x45: ("MOV B,L", 1),
    0x46: ("MOV B,M", 1), 0x47: ("MOV B,A", 1),
    0x48: ("MOV C,B", 1), 0x49: ("MOV C,C", 1), 0x4A: ("MOV C,D", 1),
    0x4B: ("MOV C,E", 1), 0x4C: ("MOV C,H", 1), 0x4D: ("MOV C,L", 1),
    0x4E: ("MOV C,M", 1), 0x4F: ("MOV C,A", 1),
    0x50: ("MOV D,B", 1), 0x51: ("MOV D,C", 1), 0x52: ("MOV D,D", 1),
    0x53: ("MOV D,E", 1), 0x54: ("MOV D,H", 1), 0x55: ("MOV D,L", 1),
    0x56: ("MOV D,M", 1), 0x57: ("MOV D,A", 1),
    0x58: ("MOV E,B", 1), 0x59: ("MOV E,C", 1), 0x5A: ("MOV E,D", 1),
    0x5B: ("MOV E,E", 1), 0x5C: ("MOV E,H", 1), 0x5D: ("MOV E,L", 1),
    0x5E: ("MOV E,M", 1), 0x5F: ("MOV E,A", 1),
    0x60: ("MOV H,B", 1), 0x61: ("MOV H,C", 1), 0x62: ("MOV H,D", 1),
    0x63: ("MOV H,E", 1), 0x64: ("MOV H,H", 1), 0x65: ("MOV H,L", 1),
    0x66: ("MOV H,M", 1), 0x67: ("MOV H,A", 1),
    0x68: ("MOV L,B", 1), 0x69: ("MOV L,C", 1), 0x6A: ("MOV L,D", 1),
    0x6B: ("MOV L,E", 1), 0x6C: ("MOV L,H", 1), 0x6D: ("MOV L,L", 1),
    0x6E: ("MOV L,M", 1), 0x6F: ("MOV L,A", 1),
    0x70: ("MOV M,B", 1), 0x71: ("MOV M,C", 1), 0x72: ("MOV M,D", 1),
    0x73: ("MOV M,E", 1), 0x74: ("MOV M,H", 1), 0x75: ("MOV M,L", 1),
    0x76: ("HLT", 1),     0x77: ("MOV M,A", 1),
    0x78: ("MOV A,B", 1), 0x79: ("MOV A,C", 1), 0x7A: ("MOV A,D", 1),
    0x7B: ("MOV A,E", 1), 0x7C: ("MOV A,H", 1), 0x7D: ("MOV A,L", 1),
    0x7E: ("MOV A,M", 1), 0x7F: ("MOV A,A", 1),
    0x80: ("ADD B", 1), 0x81: ("ADD C", 1), 0x82: ("ADD D", 1),
    0x83: ("ADD E", 1), 0x84: ("ADD H", 1), 0x85: ("ADD L", 1),
    0x86: ("ADD M", 1), 0x87: ("ADD A", 1),
    0x88: ("ADC B", 1), 0x89: ("ADC C", 1), 0x8A: ("ADC D", 1),
    0x8B: ("ADC E", 1), 0x8C: ("ADC H", 1), 0x8D: ("ADC L", 1),
    0x8E: ("ADC M", 1), 0x8F: ("ADC A", 1),
    0x90: ("SUB B", 1), 0x91: ("SUB C", 1), 0x92: ("SUB D", 1),
    0x93: ("SUB E", 1), 0x94: ("SUB H", 1), 0x95: ("SUB L", 1),
    0x96: ("SUB M", 1), 0x97: ("SUB A", 1),
    0x98: ("SBB B", 1), 0x99: ("SBB C", 1), 0x9A: ("SBB D", 1),
    0x9B: ("SBB E", 1), 0x9C: ("SBB H", 1), 0x9D: ("SBB L", 1),
    0x9E: ("SBB M", 1), 0x9F: ("SBB A", 1),
    0xA0: ("ANA B", 1), 0xA1: ("ANA C", 1), 0xA2: ("ANA D", 1),
    0xA3: ("ANA E", 1), 0xA4: ("ANA H", 1), 0xA5: ("ANA L", 1),
    0xA6: ("ANA M", 1), 0xA7: ("ANA A", 1),
    0xA8: ("XRA B", 1), 0xA9: ("XRA C", 1), 0xAA: ("XRA D", 1),
    0xAB: ("XRA E", 1), 0xAC: ("XRA H", 1), 0xAD: ("XRA L", 1),
    0xAE: ("XRA M", 1), 0xAF: ("XRA A", 1),
    0xB0: ("ORA B", 1), 0xB1: ("ORA C", 1), 0xB2: ("ORA D", 1),
    0xB3: ("ORA E", 1), 0xB4: ("ORA H", 1), 0xB5: ("ORA L", 1),
    0xB6: ("ORA M", 1), 0xB7: ("ORA A", 1),
    0xB8: ("CMP B", 1), 0xB9: ("CMP C", 1), 0xBA: ("CMP D", 1),
    0xBB: ("CMP E", 1), 0xBC: ("CMP H", 1), 0xBD: ("CMP L", 1),
    0xBE: ("CMP M", 1), 0xBF: ("CMP A", 1),
    0xC0: ("RNZ", 1),
    0xC1: ("POP B", 1),
    0xC2: ("JNZ ", 3),
    0xC3: ("JMP ", 3),
    0xC4: ("CNZ ", 3),
    0xC5: ("PUSH B", 1),
    0xC6: ("ADI ", 2),
    0xC7: ("RST 0", 1),
    0xC8: ("RZ", 1),
    0xC9: ("RET", 1),
    0xCA: ("JZ ", 3),
    0xCB: ("JMP ", 3),
    0xCC: ("CZ ", 3),
    0xCD: ("CALL ", 3),
    0xCE: ("ACI ", 2),
    0xCF: ("RST 1", 1),
    0xD0: ("RNC", 1),
    0xD1: ("POP D", 1),
    0xD2: ("JNC ", 3),
    0xD3: ("OUT ", 2),
    0xD4: ("CNC ", 3),
    0xD5: ("PUSH D", 1),
    0xD6: ("SUI ", 2),
    0xD7: ("RST 2", 1),
    0xD8: ("RC", 1),
    0xD9: ("RET", 1),
    0xDA: ("JC ", 3),
    0xDB: ("IN ", 2),
    0xDC: ("CC ", 3),
    0xDD: ("CALL ", 3),
    0xDE: ("SBI ", 2),
    0xDF: ("RST 3", 1),
    0xE0: ("RPO", 1),
    0xE1: ("POP H", 1),
    0xE2: ("JPO ", 3),
    0xE3: ("XTHL", 1),
    0xE4: ("CPO ", 3),
    0xE5: ("PUSH H", 1),
    0xE6: ("ANI ", 2),
    0xE7: ("RST 4", 1),
    0xE8: ("RPE", 1),
    0xE9: ("PCHL", 1),
    0xEA: ("JPE ", 3),
    0xEB: ("XCHG", 1),
    0xEC: ("CPE ", 3),
    0xED: ("CALL ", 3),
    0xEE: ("XRI ", 2),
    0xEF: ("RST 5", 1),
    0xF0: ("RP", 1),
    0xF1: ("POP PSW", 1),
    0xF2: ("JP ", 3),
    0xF3: ("DI", 1),
    0xF4: ("CP ", 3),
    0xF5: ("PUSH PSW", 1),
    0xF6: ("ORI ", 2),
    0xF7: ("RST 6", 1),
    0xF8: ("RM", 1),
    0xF9: ("SPHL", 1),
    0xFA: ("JM ", 3),
    0xFB: ("EI", 1),
    0xFC: ("CM ", 3),
    0xFD: ("CALL ", 3),
    0xFE: ("CPI ", 2),
    0xFF: ("RST 7", 1),
}

# Known routine labels from the well-documented Space Invaders ROM
# Sources: Computer Archeology, various disassembly projects
LABELS = {
    0x0000: "RESET",
    0x0008: "ScanLine96_ISR",
    0x0010: "ScanLine224_ISR",
    0x0018: "DrawShiftedByte",
    0x0020: "TimeToSaucer_rst4",
    0x0028: "RST5",
    0x0030: "RST6",
    0x0038: "RST7",
    0x0046: "InitRack",
    0x008F: "DrawAlien",
    0x00A3: "CursorNextAlien",
    0x00C3: "GetAlienCoords",
    0x00E3: "MoveRefAlien",
    0x0100: "MoveAliensCurRow",
    0x0141: "EraseSimpleSprite",
    0x017A: "DrawSpriteGeneric",
    0x01A1: "PlayerShotHitAlien",
    0x01C0: "ReadInputs",
    0x01CF: "GameObj0",   
    0x01EF: "HandleNotAliveGameObj",
    0x0214: "ObjTimerAndInit",
    0x0237: "WaitOnDraw",
    0x0248: "RunGameObj",
    0x025B: "DrawGameObj",
    0x028E: "EraseGameObj",
    0x02BF: "HandleGameObjCollision",
    0x032B: "HandleAlienShotCollision",
    0x0380: "RemoveAlien",
    0x03BB: "PlayerShotHandler",
    0x0430: "PlayerShotMoving",
    0x044E: "EndOfPlayerShot",
    0x046B: "HandlePlayerShotHit",
    0x048B: "DrawExplosionSprite",
    0x04B6: "ShotBlowingUp",
    0x04CA: "DrawPlayerDie",
    0x0550: "ScoreForAlien",
    0x0563: "AlienScoreDelta",
    0x0582: "HandleHitFlag",
    0x0593: "AlienShotExplosionHandler",
    0x05E9: "SquigglyShot_handler",
    0x0617: "PlungerShot_handler",
    0x0644: "RollingShot_handler",
    0x0676: "ShotMoving",
    0x06B7: "HandleAlienShotMove",
    0x06D8: "HandleShotAtBottom",
    0x06F2: "AlienShotBlowingUp",
    0x0740: "ReadColumnFireTable",
    0x074B: "ShotWithinAlienFormation",
    0x076B: "FindAlienInColumn",
    0x0798: "TimeToFire",
    0x07BE: "SaucerScoring",
    0x0817: "RemoveSaucer",
    0x08D4: "PowerOnReset",
    0x0913: "SetupInterruptChain",
    0x0935: "ISR_MidScreen",
    0x0953: "ISR_Vblank",
    0x0971: "WaitVblank",
    0x0977: "RackBump_adjustSpeed",
    0x0993: "TimeToSaucer",
    0x09B2: "DrawSaucer",
    0x09CA: "ThinkSaucer",
    0x09E4: "SaucerMoving",
    0x0A07: "InitAliens",
    0x0A32: "RestoreShieldsAndSetup",
    0x0A5E: "DrawShieldBuffer",
    0x0AAB: "PrintMessage",
    0x0ABD: "PrintMessageDel",
    0x0AD7: "CopyShields",
    0x0AE0: "RestoreShields",
    0x0B00: "ScreenFlash",
    0x0B79: "GameLoop",
    0x0BAF: "NewGame",
    0x0BED: "MainPlayLoop",
    0x0C12: "HandleCoinSwitch",
    0x0C2A: "WaitForStart",
    0x0C53: "AttractMode_SplashScreen",
    0x0C87: "TwoSecondDelay",
    0x0C8F: "OneSecondDelay",
    0x0CA0: "ISR_SplashScreen",
    0x0CCD: "DrawNumCredits",
    0x0CE2: "HandleCoinInsert",
    0x0CF4: "PrintScore",
    0x0D12: "AdjScoreP1",
    0x0D32: "AdjScoreP2",
    0x0D52: "AdjHighScore",
    0x0D74: "Print4Digits",
    0x0DA6: "DrawStatus",
    0x0DC0: "ClearPlayfield",
    0x0DD6: "DrawBottomLine",
    0x0DEA: "AddDelta",
    0x0E00: "SpriteDataTable",
    0x0E30: "AlienSpritesCR",
    0x0E38: "AlienSpritesCR_B",
    0x1000: "AlienSpriteTypeA",  
    0x1010: "AlienSpriteTypeA2",
    0x1020: "AlienSpriteTypeB",
    0x1030: "AlienSpriteTypeB2",
    0x1040: "AlienSpriteTypeC",
    0x1050: "AlienSpriteTypeC2",
    0x1060: "ShotExplodingSprite",
    0x1068: "PlayerShotSprite",
    0x1070: "AlienExplodeSprite",
    0x1080: "SaucerSprite",
    0x1090: "PlayerSprite",
    0x1098: "ShieldSprite",
    0x1100: "AlienShotExplosionSprite",
    0x1108: "SquigglyShotData_A",
    0x110C: "SquigglyShotData_B",
    0x1110: "SquigglyShotData_C",
    0x1114: "SquigglyShotData_D",
    0x1118: "PlungerShotData_A",
    0x111C: "PlungerShotData_B",
    0x1120: "PlungerShotData_C",
    0x1124: "PlungerShotData_D",
    0x1128: "RollingShotData_A",
    0x112C: "RollingShotData_B",
    0x1130: "RollingShotData_C",
    0x1134: "RollingShotData_D",
    0x1140: "SaucerScoreTable",
    0x1170: "PlungerFireColumnTable",
    0x1180: "SquigglyFireColumnTable",
    0x1190: "AlienStartTable",
    0x1198: "PlayfieldAlienStartY",
    0x1400: "DrawAlienRow",
    0x141C: "CheckAlienReachedBottom",
    0x1424: "CursorNextAlienInRow",
    0x1439: "GetRefAlienDelta",
    0x1450: "MoveRefAlienYX",
    0x1470: "GetAlienStatPtr",
    0x1482: "HandleAlienKilled",
    0x14C0: "CountAliens",
    0x14CB: "DrawShields",
    0x1500: "SaucerLogic",
    0x1538: "SpriteShotCollision",
    0x1550: "CheckPlayerHit",
    0x1580: "ShotLandedOnPlayer",
    0x1592: "DropExtraLife",
    0x15C0: "PlayerAlive",
    0x15D0: "XEndOfTurn",
    0x1600: "GameTaskHandler",
    0x1640: "RackMarchConfig",
    0x1680: "PrintScoreLabelP1",
    0x16A0: "PrintScoreLabelP2",
    0x1700: "OnePlayerButton",
    0x1720: "TwoPlayerButton",
    0x1740: "PrintMessage2",
    0x1780: "DrawScoreHead",
    0x17C0: "CreditMessage",
    0x17C9: "AdjScore",
    0x1800: "SpaceInvadersLogo",
    0x1900: "ScoringAdvancedTable",
    0x1920: "ScoringTableData",
}

# RAM variable labels
RAM_LABELS = {
    0x2000: "alienAlive",
    0x2002: "alienCurIndex",
    0x2003: "alienPosRAM",
    0x2004: "refAlienDeltaY",
    0x2005: "refAlienDeltaX",
    0x2006: "refAlienY",
    0x2007: "refAlienX",
    0x2008: "rackDirection",
    0x2009: "rackDownDelta",
    0x200A: "playerAlive",
    0x200B: "waitOnDraw",
    0x200C: "playerOK",
    0x2010: "enableAlienFire",
    0x2015: "alienIsExploding",
    0x2016: "expAlienTimer",
    0x2020: "obj0Timer",
    0x2025: "shotSync",
    0x2060: "twoPlayers",
    0x2061: "playerDataMSB",
    0x2062: "playerOK2",
    0x2063: "saucerStart",
    0x2067: "numAliens",
    0x2068: "saucerActive",
    0x2069: "saucerHit",
    0x206B: "tillSaucerTime",
    0x206C: "saucerScoreStr",
    0x206F: "shotCountdown",
    0x2070: "splashAnimate",
    0x2072: "numCoins",
    0x2078: "P1ScorL",
    0x2079: "P1ScorM",
    0x207B: "P2ScorL",
    0x207C: "P2ScorM",
    0x207E: "HiScor",
    0x2080: "score1",
    0x2082: "shotPicEnd",
    0x2084: "numLives",
    0x2090: "gameMode",
    0x20C0: "plyrShotStatus",
    0x20C1: "plyrObjPtr",
    0x20C3: "plyrShotYr",
    0x20C5: "plyrShotSize",
    0x20C6: "plyrShotBlow",
    0x20C7: "plyrShotXr",
    0x20C8: "plyrShotBmpSz",
    0x20EB: "rolShotStatus",
    0x20EE: "rolShotYr",
    0x20F0: "rolShotSize",
    0x20F1: "rolShotBlow",
    0x20F3: "rolShotXr",
    0x2100: "pluShotStatus",
    0x2115: "squShotStatus",
    0x2400: "VRAM_Start",
}


def addr16(rom, offset):
    """Read a 16-bit little-endian address from ROM."""
    return rom[offset] | (rom[offset + 1] << 8)


def disassemble_range(rom, start, end):
    """Disassemble a range of bytes and return lines."""
    lines = []
    pc = start
    while pc < end and pc < len(rom):
        opcode = rom[pc]
        mnemonic, length = OPCODES.get(opcode, (f"DB ${opcode:02X}", 1))
        
        label = LABELS.get(pc, "")
        label_str = f"{label}:" if label else ""
        
        if length == 1:
            line = f"  {pc:04X}  {rom[pc]:02X}           {mnemonic}"
        elif length == 2:
            operand = rom[pc + 1] if pc + 1 < len(rom) else 0
            line = f"  {pc:04X}  {rom[pc]:02X} {operand:02X}        {mnemonic}${operand:02X}"
        elif length == 3:
            lo = rom[pc + 1] if pc + 1 < len(rom) else 0
            hi = rom[pc + 2] if pc + 2 < len(rom) else 0
            addr = lo | (hi << 8)
            target_label = LABELS.get(addr, RAM_LABELS.get(addr, f"${addr:04X}"))
            line = f"  {pc:04X}  {rom[pc]:02X} {lo:02X} {hi:02X}     {mnemonic}{target_label}"
        else:
            line = f"  {pc:04X}  {rom[pc]:02X}           ???"
        
        if label_str:
            lines.append(f"\n{label_str}")
        lines.append(line)
        pc += length
    return lines


def main():
    # Read ROM
    rom = bytearray()
    basepath = "f:/Dev/TRSE/Space-Invaders-64/Assets/Intel8080/"
    for name in ['invaders.h', 'invaders.g', 'invaders.e', 'invaders.f']:
        with open(basepath + name, 'rb') as f:
            rom += f.read()
    
    print(f"ROM size: {len(rom)} bytes (8KB)")
    print(f"Entry point bytes: {rom[0]:02X} {rom[1]:02X} {rom[2]:02X} {rom[3]:02X} {rom[4]:02X} {rom[5]:02X}")
    print()
    
    # Key ranges to disassemble
    ranges = [
        (0x0000, 0x0048, "Reset Vector and Interrupt Handlers"),
        (0x008F, 0x0100, "DrawAlien / CursorNextAlien / GetAlienCoords / MoveRefAlien"),
        (0x0100, 0x01A1, "MoveAliensCurRow / EraseSimpleSprite / DrawSpriteGeneric"),
        (0x01A1, 0x01D0, "PlayerShotHitAlien / ReadInputs"),
        (0x03BB, 0x04D0, "Player Shot Handler"),
        (0x0550, 0x05EA, "Score Calculation for Alien Hits"),
        (0x05E9, 0x0740, "Three Shot Types (Squiggly/Plunger/Rolling)"),
        (0x0740, 0x07C0, "Fire Column Table / FindAlienInColumn / TimeToFire"),
        (0x07BE, 0x0840, "Saucer Scoring / RemoveSaucer"),
        (0x08D4, 0x0978, "Power On Reset / ISR Setup"),
        (0x0993, 0x0A07, "Saucer Logic"),
        (0x0A07, 0x0B00, "Init Aliens / Restore Shields / Print Message"),
        (0x0B79, 0x0C00, "Game Loop / New Game / Main Play Loop"),
        (0x0CF4, 0x0DEA, "Score Display and Status / Clear Playfield / Draw Bottom Line"),
        (0x0E00, 0x0E40, "Sprite Data Table"),
        (0x1000, 0x1200, "Sprite Graphics Data (Aliens, Shots, Player, Shields)"),
        (0x1400, 0x14D0, "Draw Alien Row / Check Bottom / Count Aliens"),
        (0x14CB, 0x1600, "Draw Shields / Saucer / Collision / Player Hit"),
        (0x1780, 0x17D0, "Score Headers / AdjScore"),
    ]
    
    output = []
    for start, end, desc in ranges:
        output.append(f"\n{'='*70}")
        output.append(f"  {desc}")
        output.append(f"  Address range: ${start:04X}-${end:04X}")
        output.append(f"{'='*70}")
        output.extend(disassemble_range(rom, start, end))
    
    # Also dump sprite data as hex
    output.append(f"\n{'='*70}")
    output.append(f"  Sprite Graphics Data (hex dump)")
    output.append(f"{'='*70}")
    sprite_ranges = [
        (0x1000, 0x1010, "Alien Type A Frame 1 (16 bytes, 2 bytes wide x 8 rows)"),
        (0x1010, 0x1020, "Alien Type A Frame 2"),
        (0x1020, 0x1030, "Alien Type B Frame 1"),
        (0x1030, 0x1040, "Alien Type B Frame 2"),
        (0x1040, 0x1050, "Alien Type C Frame 1"),
        (0x1050, 0x1060, "Alien Type C Frame 2"),
        (0x1060, 0x1068, "Shot Exploding Sprite"),
        (0x1068, 0x1070, "Player Shot Sprite"),
        (0x1070, 0x1080, "Alien Explode Sprite"),
        (0x1080, 0x1090, "Saucer (UFO) Sprite"),
        (0x1090, 0x1098, "Player Sprite"),
        (0x1098, 0x10C0, "Shield Sprite"),
    ]
    for start, end, desc in sprite_ranges:
        hex_str = ' '.join(f'{rom[i]:02X}' for i in range(start, min(end, len(rom))))
        output.append(f"\n  {desc} (${start:04X}-${end-1:04X}):")
        output.append(f"  {hex_str}")
        # Also show as binary for visual representation
        for row in range(0, end - start, 2):
            if start + row + 1 < len(rom):
                b1 = rom[start + row]
                b2 = rom[start + row + 1]
                bits = f"{b1:08b}{b2:08b}"
                visual = bits.replace('0', '.').replace('1', '#')
                output.append(f"    {visual}")
    
    # Write full output
    with open("f:/Dev/TRSE/Space-Invaders-64/Assets/Intel8080/disassembly.txt", "w") as f:
        f.write("\n".join(output))
    
    print("Disassembly written to Assets/Intel8080/disassembly.txt")
    print(f"Total labeled routines found: {len(LABELS)}")

    # Also output RAM variables
    print("\n--- Key RAM Variables ---")
    for addr in sorted(RAM_LABELS.keys()):
        print(f"  ${addr:04X}: {RAM_LABELS[addr]}")


if __name__ == "__main__":
    main()
