
 processor 6502
	org $801
StartBlock801:
	; Starting new memory block at $801
	.byte $b ; lo byte of next line
	.byte $8 ; hi byte of next line
	.byte $0a, $00 ; line 10 (lo, hi)
	.byte $9e, $20 ; SYS token and a space
	.byte   $32,$32,$35,$34,$34
	.byte $00, $00, $00 ; end of program
	; Ending memory block at $801
EndBlock801:
	org $1000
StartBlock1000:
	org $1000
	incbin	"F:/Dev/TRSE/Space-Invaders-64//sid/_Courier.dat"
EndBlock1000:
	org $2000
StartBlock2000:
	org $2000
sprites:
	incbin	 "F:/Dev/TRSE/Space-Invaders-64///sprites/spritesheet.bin"
end_incbin_sprites:
EndBlock2000:
	org $5810
StartBlock5810:
	; Starting new memory block at $5810
SpaceInvaders64
	jmp block1
Screen_p1	= $02
Screen_sp	= $04
Screen_p2	= $08
Screen_i	dc.b	0
Screen_j	dc.b	0
Screen_x	dc.b	0
Screen_y	dc.b	0
Screen_i2	dc.w	0
Screen_tab40	dc.w $00, $28, $50, $78, $a0, $c8, $f0, $118
	dc.w $140, $168, $190, $1b8, $1e0, $208, $230, $258
	dc.w $280, $2a8, $2d0, $2f8, $320, $348, $370, $398
	dc.w $3c0
Memory_p	= $16
Memory_v	dc.b	0
Memory_v2	dc.b	0
StarField_RasterCount	dc.b	0
StarField_StarfieldPtr	= $0B
StarField_StarfieldPtr2	= $0D
StarField_StarfieldPtr3	= $10
StarField_StarfieldPtr4	= $12
StarField_StaticStarPtr	= $22
StarField_StaticStarBlink	dc.b	0
StarField_StarfieldRow	dc.b $3a, $5c, $49, $40, $5b, $3e, $5d, $51
	dc.b $42, $5e, $56, $3b, $4f, $57, $50, $47
	dc.b $4c, $43, $52, $5f, $64, $4e, $63, $3c
	dc.b $4b, $3f, $54, $41, $53, $60, $44, $58
	dc.b $4a, $3d, $5a, $62, $55, $65, $61, $4d
StarField_StarColour1	dc.b	$06
StarField_StarColour2	dc.b	$04
StarField_StarColour3	dc.b	$0c
StarField_StarColour4	dc.b	$0f
StarField_StarColour5	dc.b	$0e
StarField_StarColour6	dc.b	$0b
StarField_StarfieldColours	dc.b $e, $a, $c, $f, $e, $d, $c, $b
	dc.b $a, $e, $e, $a, $e, $f, $e, $d
	dc.b $c, $b, $a, $c
Helpers_temp	dc.w	0
debug_enable_bgcol	dc.b	$00
enemyMoveCounter	dc.b	$48
enemy_direction	dc.b	$01
numberOfEnemies	dc.b	$00
monster_vertical_adjustment	dc.b	$08
sequential_clear_counter	dc.b	$47
temp_block_index	dc.b	$00
temp_enemy_index	dc.b	$00
pos_x	dc.b	$27
player_bullet_active	dc.b	$00
player_bullet_x	dc.b	0
player_bullet_y	dc.b	0
explosion_frame_counter	dc.b	$00
previous_fire_state	dc.b	$00
player_sprite_x	dc.b	$27
player_sprite_y	dc.b	$e2
monster_base_x	dc.b	0
monster_base_y	dc.b	0
block_enemies	dc.b $3f, $3f, $3f, $3f, $3f, $3f, $3f, $3f
	dc.b $3f, $3f, $3f, $3f
player_joystick_direction	dc.b	0
monster_animation_frame	dc.b	0
	; NodeProcedureDecl -1
	; ***********  Defining procedure : DebugBorder
	;    Procedure type : User-defined procedure
	rts
end_procedure_DebugBorder
	; NodeProcedureDecl -1
	; ***********  Defining procedure : init16x8div
	;    Procedure type : Built-in function
	;    Requires initialization : no
initdiv16x8_divisor = $4c     ;$59 used for hi-byte
initdiv16x8_dividend = $4e	  ;$fc used for hi-byte
initdiv16x8_remainder = $50	  ;$fe used for hi-byte
initdiv16x8_result = $4e ;save memory by reusing divident to store the result
divide16x8
	lda #0	        ;preset remainder to 0
	sta initdiv16x8_remainder
	sta initdiv16x8_remainder+1
	ldx #16	        ;repeat for each bit: ...
divloop16:	asl initdiv16x8_dividend	;dividend lb & hb*2, msb -> Carry
	rol initdiv16x8_dividend+1
	rol initdiv16x8_remainder	;remainder lb & hb * 2 + msb from carry
	rol initdiv16x8_remainder+1
	lda initdiv16x8_remainder
	sec
	sbc initdiv16x8_divisor	;substract divisor to see if it fits in
	tay	        ;lb result -> Y, for we may need it later
	lda initdiv16x8_remainder+1
	sbc initdiv16x8_divisor+1
	bcc skip16	;if carry=0 then divisor didn't fit in yet
	sta initdiv16x8_remainder+1	;else save substraction result as new remainder,
	sty initdiv16x8_remainder
	inc initdiv16x8_result	;and INCrement result cause divisor fit in 1 times
skip16
	dex
	bne divloop16
	rts
end_procedure_init16x8div
	; NodeProcedureDecl -1
	; ***********  Defining procedure : init16x8mul
	;    Procedure type : Built-in function
	;    Requires initialization : no
mul16x8_num1Hi = $4c
mul16x8_num1 = $4e
mul16x8_num2 = $50
mul16x8_procedure
	lda #$00
	ldy #$00
	beq mul16x8_enterLoop
mul16x8_doAdd
	clc
	adc mul16x8_num1
	tax
	tya
	adc mul16x8_num1Hi
	tay
	txa
mul16x8_loop
	asl mul16x8_num1
	rol mul16x8_num1Hi
mul16x8_enterLoop
	lsr mul16x8_num2
	bcs mul16x8_doAdd
	bne mul16x8_loop
	rts
end_procedure_init16x8mul
	; NodeProcedureDecl -1
	; ***********  Defining procedure : init8x8div
	;    Procedure type : Built-in function
	;    Requires initialization : no
div8x8_c = $4c
div8x8_d = $4e
div8x8_e = $50
	; Normal 8x8 bin div
div8x8_procedure
	lda #$00
	ldx #$07
	clc
div8x8_loop1
	rol div8x8_d
	rol
	cmp div8x8_c
	bcc div8x8_loop2
	sbc div8x8_c
div8x8_loop2
	dex
	bpl div8x8_loop1
	rol div8x8_d
	lda div8x8_d
div8x8_def_end
	rts
end_procedure_init8x8div
	; NodeProcedureDecl -1
	; ***********  Defining procedure : initeightbitmul
	;    Procedure type : Built-in function
	;    Requires initialization : no
multiplier = $4c
multiplier_a = $4e
multiply_eightbit
	cpx #$00
	beq mul_end
	dex
	stx $4e
	lsr
	sta multiplier
	lda #$00
	ldx #$08
mul_loop
	bcc mul_skip
mul_mod
	adc multiplier_a
mul_skip
	ror
	ror multiplier
	dex
	bne mul_loop
	ldx multiplier
	rts
mul_end
	txa
	rts
initeightbitmul_multiply_eightbit2
	rts
end_procedure_initeightbitmul
	; NodeProcedureDecl -1
	; ***********  Defining procedure : initjoystick
	;    Procedure type : Built-in function
	;    Requires initialization : no
joystickup: .byte 0
joystickdown: .byte 0
joystickleft: .byte 0
joystickright: .byte 0
joystickbutton: .byte 0
callJoystick
	lda #0
	sta joystickup
	sta joystickdown
	sta joystickleft
	sta joystickright
	sta joystickbutton
	lda #%00000001 ; mask joystick up mment
	bit $50      ; bitwise AND with address 56320
	bne joystick_down       ; zero flag is not set -> skip to down
	lda #1
	sta joystickup
joystick_down
	lda #%00000010 ; mask joystick down movement
	bit $50      ; bitwise AND with address 56320
	bne joystick_left       ; zero flag is not set -> skip to down
	lda #1
	sta joystickdown
joystick_left
	lda #%00000100 ; mask joystick left movement
	bit $50      ; bitwise AND with address 56320
	bne joystick_right       ; zero flag is not set -> skip to down
	lda #1
	sta joystickleft
joystick_right
	lda #%00001000 ; mask joystick up movement
	bit $50      ; bitwise AND with address 56320
	bne joystick_button       ; zero flag is not set -> skip to down
	lda #1
	sta joystickright
joystick_button
	lda #%00010000 ; mask joystick up movement
	bit $50      ; bitwise AND with address 56320
	bne callJoystick_end       ; zero flag is not set -> skip to down
	lda #1
	sta joystickbutton
callJoystick_end
	rts
	rts
end_procedure_initjoystick
	; NodeProcedureDecl -1
	; ***********  Defining procedure : initmoveto
	;    Procedure type : Built-in function
	;    Requires initialization : no
	jmp initmoveto_moveto3
screenmemory =  $fe
colormemory =  $fb
screen_x = $4c
screen_y = $4e
SetScreenPosition
	sta screenmemory+1
	lda #0
	sta screenmemory
	ldy screen_y
	beq sydone
syloop
	clc
	adc #40
	bcc sskip
	inc screenmemory+1
sskip
	dey
	bne syloop
sydone
	ldx screen_x
	beq sxdone
	clc
	adc screen_x
	bcc sxdone
	inc screenmemory+1
sxdone
	sta screenmemory
	rts
initmoveto_moveto3
	rts
end_procedure_initmoveto
	; NodeProcedureDecl -1
	; ***********  Defining procedure : initprintstring
	;    Procedure type : Built-in function
	;    Requires initialization : no
print_text = $4c
print_number_text: .dc "    ",0
printstring
	ldy #0
printstringloop
	lda (print_text),y
	cmp #0 ;keep
	beq printstring_done
	cmp #64
	bcc printstring_skip
	sec
	sbc #64
printstring_skip
	sta (screenmemory),y
	iny
	dex
	cpx #0
	beq printstring_done
	jmp printstringloop
printstring_done
	rts
end_procedure_initprintstring
	; NodeProcedureDecl -1
	; ***********  Defining procedure : Screen_PrintString
	;    Procedure type : User-defined procedure
Screen_PrintString_block4
Screen_PrintString
	; Generic 16 bit op
	ldy #0
	ldx #0 ; Fake 24 bit
	lda Screen_x
Screen_PrintString_rightvarInteger_var7 = $54
	sta Screen_PrintString_rightvarInteger_var7
	sty Screen_PrintString_rightvarInteger_var7+1
	; HandleVarBinopB16bit
	; RHS is pure, optimization
	; Load Integer array
	; CAST type INTEGER
	lda Screen_y
	asl
	tax
	lda Screen_tab40,x 
	ldy Screen_tab40+1,x 
	clc
	adc Screen_p2
	; Testing for byte:  Screen_p2+1
	; RHS is word, no optimization
	pha 
	tya 
	adc Screen_p2+1
	tay 
	pla 
	; Low bit binop:
	clc
	adc Screen_PrintString_rightvarInteger_var7
Screen_PrintString_wordAdd5
	sta Screen_PrintString_rightvarInteger_var7
	; High-bit binop
	tya
	adc Screen_PrintString_rightvarInteger_var7+1
	tay
	lda Screen_PrintString_rightvarInteger_var7
	sta Screen_sp
	sty Screen_sp+1
		ldy #0
printstring_loop1:
		lda (Screen_p1),y
		beq printstring_endd
		
		sta (Screen_sp),y
		iny
		jmp printstring_loop1
printstring_endd:
		
	
	
Screen_PrintString_while9
Screen_PrintString_loopstart13
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load pointer array
	ldy #$0
	lda (Screen_p1),y
	; cmp #$00 ignored
	beq Screen_PrintString_edblock12
Screen_PrintString_ctb10: ;Main true block ;keep 
	; Load pointer array
	ldy #$0
	lda (Screen_p1),y
	; Calling storevariable on generic assign expression
	sta Screen_j
	; Binary clause Simplified: GREATEREQUAL
	; Compare with pure num / var optimization
	cmp #$41;keep
	bcc Screen_PrintString_edblock29
Screen_PrintString_localsuccess31: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	lda Screen_j
	; Compare with pure num / var optimization
	cmp #$60;keep
	bcs Screen_PrintString_edblock29
Screen_PrintString_ctb27: ;Main true block ;keep 
	; Optimizer: a = a +/- b
	; Load16bitvariable : Screen_j
	lda Screen_j
	sec
	sbc #$40
	sta Screen_j
Screen_PrintString_edblock29
	lda Screen_j
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (Screen_sp),y
	lda Screen_sp
	clc
	adc #$01
	sta Screen_sp+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc Screen_PrintString_WordAdd33
	inc Screen_sp+1
Screen_PrintString_WordAdd33
	lda Screen_p1
	clc
	adc #$01
	sta Screen_p1+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc Screen_PrintString_WordAdd34
	inc Screen_p1+1
Screen_PrintString_WordAdd34
	jmp Screen_PrintString_while9
Screen_PrintString_edblock12
Screen_PrintString_loopend14
	rts
end_procedure_Screen_PrintString
	
; //
; // galenciastars
; //
; // By Alan Bourke in 2021 using Turbo Rascal.
; //
; //	This is a conversion of Jason Aldred's Galencia starfield, taken from his
; //	game of the same name. Jason extracted the starfield ASM code into a standalone
; //	programme (see link below), and this is an Turbo Rascal recreation of that.
; // ---------------------------------------------------------------------------------------------------------------------------------
; // How It Works 
; // ---------------------------------------------------------------------------------------------------------------------------------
; // CreateStarScreen fills the entire character screen with the characters and colours defined in StarfieldRow\StarfieldColours.
; // The character screen starts at location $0400 and is 25 rows of 40 characters. The screen is filled in such a way that chars
; // that are in sequence in the character set will be placed in vertical rows down the screen. 
; // Once this procedure is finished the first 4 rows of the screen will have these characters:
; // :.I..>.QB.V;OWPGLCR.DNC<K?TAS.DXJ=ZBUEAM
; // ;.JA.?.RC.W<PXQHMD:.EOD=L.UBTAEYK>.CVFBN
; // <.KB...:D.X=QYRINE;AFPE>MAVCUBFZL?.DWGCO
; // =.LC.A.;EAY>RZ:JOF<BGQF?NBWDVCG.M..EXHDP
; // Note the ':' and the ';' below it at the top left. These two characters are numbers 58 and 59 in the character set. We have copied
; // the character set into RAM starting at location $3000 (12288 decimal) . 'Star1Ptr' starts off pointing at 'Star1Init', which is 
; // location $31D0 (12572 decimal). 12288 - 12572 = 464 bytes or 58 characters. Therefore 'Star1Ptr' starts off pointing at the first
; // byte\row of the ':' character in memory. From there the 'DoStarField()' loop will place a star shape into that memory location and 
; // on the next pass erase it and draw it one byte down. This produces the falling stars.
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Resources
; // ---------------------------------------------------------------------------------------------------------------------------------
; // https:retrocomputing.stackexchange.com/questions/12678/get-exact-position-of-raster-beam-on-c64-c128
; // VICE monitor io d000
; // https:retrocomputing.stackexchange.com/questions/7528/commodore-8-bit-character-sets/8278
; // Jason Aldred's original Galencia starfield extracted to a standalone program.
; // https:
; //github.com/Jimmy2x2x/C64-Starfield/blob/master/starfield.asm
; // Info about the C64 character set.
; // https:
; //github.com/neilsf/XC-BASIC/tree/master/examples/invaders
; // https:
; //www.c64-wiki.com/wiki/Character_set
; // Info about the C64 memory map.
; // https:
; //www.pagetable.com/c64ref/c64mem
; /// https:
; //github.com/Project-64/reloaded/blob/master/c64/mapc64/MAPC6412.TXT
; // GRay Defender's breakdown of how the original ASM works - WATCH THIS.
; // https:
; //www.youtube.com/watch?v=47LakVkR5lg&t=1251s
; // Flags whether interrupt chain should use the Kernal.
; // Keeps track of the number of times the interrupt 
; // handler that draws the stars has been hit.
; // Star shapes - a bit pattern representing one 
; // byte in an 8-byte character.
; // The location in RAM to which the ROM-based
; // character set will be copied.
; // Init address for each star, CharSetLoc plus offset
; // For example:
; // CharsetLoc = $3000 = 12288 and Star1Init = $31D0 = 12752
; // 12752 - 12288 = 464. There are 8 bytes per char, so 464/8 = 58
; // This corresponds to the first byte of the ':' character in the 
; // C64 PETSCII character set (https:
; //www.c64-wiki.com/wiki/PETSCII)
; // Limit for Star 1. This is the last byte in the 'S' character.
; // Reset address for star 1. 
; // As per star 1.
; // 2 Locations for blinking static stars
; // These pointers track the current byte offset into the RAM
; // character set for the star in question.
; // Flag used to toggle the static blinking stars on and off.
; // One screen row of 40 PETSCII characters.
; // 14 (Light Blue)
; // 10 (Pink)
; // 12 (Grey Medium)
; // 15 (Grey Light)
; // 13 (Green Light)
; // 11 (Grey Dark)
; // The colour values corresponding to the characters.
; //StarfieldColours : array[20] of byte = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Fills the entire character screen with the characters and colours defined in StarfieldRow\StarfieldColours.
; // ---------------------------------------------------------------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : StarField_CreateStarScreen
	;    Procedure type : User-defined procedure
StarField_currentchar	dc.b	0
StarField_colourindex	dc.b	0
StarField_col	dc.b	0
StarField_row	dc.b	0
StarField_saddr	dc.w	 
	org StarField_saddr+50
StarField_caddr	dc.w	 
	org StarField_caddr+50
StarField_CreateStarScreen_block35
StarField_CreateStarScreen
	
; //offset : integer;
	; Clear screen with offset
	lda #$20
	ldx #$fa
StarField_CreateStarScreen_clearloop36
	dex
	sta $0000+$400,x
	sta $00fa+$400,x
	sta $01f4+$400,x
	sta $02ee+$400,x
	bne StarField_CreateStarScreen_clearloop36
	
; //DefineScreen();
	lda $d018
	and #%11110001
	ora #12
	sta $d018
	; Copy charset from ROM
	sei 
	lda #$33 ;from rom - rom visible at d800
	sta $01
	ldy #$00
StarField_CreateStarScreen_charsetcopy37
	lda $D000 + $00,y
	sta $3000+$00,y
	lda $D000 + $64,y
	sta $3000+$64,y
	lda $D000 + $c8,y
	sta $3000+$c8,y
	lda $D000 + $12c,y
	sta $3000+$12c,y
	lda $D000 + $190,y
	sta $3000+$190,y
	lda $D000 + $1f4,y
	sta $3000+$1f4,y
	lda $D000 + $258,y
	sta $3000+$258,y
	lda $D000 + $2bc,y
	sta $3000+$2bc,y
	dey
	bne StarField_CreateStarScreen_charsetcopy37
	lda #$37
	sta $01
	
; //StarField::CreateStarScreen();
; // -- Comment this line out to see the effect of the character set being overwritten.
; //ClearCharacterSet();
; //StarField::StarfieldPtr := #STARFIELD_STAR1INIT;
; //StarField::StarfieldPtr2 := #STARFIELD_STAR2INIT;
; //StarField::StarfieldPtr3 := #STARFIELD_STAR3INIT;
; //StarField::StarfieldPtr4 := #STARFIELD_STAR4INIT;
	lda StarField_StarColour1
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$0
	lda StarField_StarColour2
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$1
	lda StarField_StarColour3
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$2
	lda StarField_StarColour4
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$3
	lda StarField_StarColour1
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$4
	lda StarField_StarColour5
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$5
	lda StarField_StarColour3
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$6
	lda StarField_StarColour6
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$7
	lda StarField_StarColour2
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$8
	lda StarField_StarColour1
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$9
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$a
	lda StarField_StarColour2
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$b
	lda StarField_StarColour1
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$c
	lda StarField_StarColour4
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$d
	lda StarField_StarColour1
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$e
	lda StarField_StarColour5
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$f
	lda StarField_StarColour3
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$10
	lda StarField_StarColour6
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$11
	lda StarField_StarColour2
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$12
	lda StarField_StarColour3
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$13
	; ----------
	; DefineAddressTable address, StartValue, IncrementValue, TableSize
	ldy #>$400
	lda #<$400
	ldx #0
	sta StarField_saddr,x   ; Address of table
	tya
	sta StarField_saddr+1,x
StarField_CreateStarScreen_dtloop38
	tay
	lda StarField_saddr,x
	inx
	inx
	clc
	adc #$28
	bcc StarField_CreateStarScreen_dtnooverflow39
	iny
StarField_CreateStarScreen_dtnooverflow39
	sta StarField_saddr,x
	tya
	sta StarField_saddr+1,x
	cpx #$30
	bcc StarField_CreateStarScreen_dtloop38
	
; // $0400 screen address, 40 characters per column, 25 rows
	; ----------
	; DefineAddressTable address, StartValue, IncrementValue, TableSize
	ldy #>$d800
	lda #<$d800
	ldx #0
	sta StarField_caddr,x   ; Address of table
	tya
	sta StarField_caddr+1,x
StarField_CreateStarScreen_dtloop40
	tay
	lda StarField_caddr,x
	inx
	inx
	clc
	adc #$28
	bcc StarField_CreateStarScreen_dtnooverflow41
	iny
StarField_CreateStarScreen_dtnooverflow41
	sta StarField_caddr,x
	tya
	sta StarField_caddr+1,x
	cpx #$30
	bcc StarField_CreateStarScreen_dtloop40
	
; // $D800 color address, 40 characters per column, 25 rows
	lda #$0
	; Calling storevariable on generic assign expression
	sta StarField_col
StarField_CreateStarScreen_while42
StarField_CreateStarScreen_loopstart46
	; Optimization: replacing a <= N with a <= N-1
	; Binary clause Simplified: LESS
	lda StarField_col
	; Compare with pure num / var optimization
	cmp #$1d;keep
	bcs StarField_CreateStarScreen_localfailed107
	jmp StarField_CreateStarScreen_ctb43
StarField_CreateStarScreen_localfailed107
	jmp StarField_CreateStarScreen_edblock45
StarField_CreateStarScreen_ctb43: ;Main true block ;keep 
	; Load Byte array
	; CAST type NADA
	ldx StarField_col
	lda StarField_StarfieldRow,x 
	; Calling storevariable on generic assign expression
	sta StarField_currentchar
	lda #$0
	; Calling storevariable on generic assign expression
	sta StarField_row
StarField_CreateStarScreen_while109
StarField_CreateStarScreen_loopstart113
	; Binary clause Simplified: LESS
	lda StarField_row
	; Compare with pure num / var optimization
	cmp #$12;keep
	bcs StarField_CreateStarScreen_edblock112
StarField_CreateStarScreen_ctb110: ;Main true block ;keep 
	; ----------
	; AddressTable address, xoffset, yoffset
	; yoffset is complex
	lda StarField_row
	asl ; *2
	tax
	lda StarField_saddr,x   ; Address of table lo
	ldy StarField_saddr+1,x   ; Address of table hi
	clc
	adc StarField_col
	bcc StarField_CreateStarScreen_dtnooverflow139
	iny  ; overflow into high byte
StarField_CreateStarScreen_dtnooverflow139
	sta screenmemory
	sty screenmemory+1
	lda StarField_currentchar
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (screenmemory),y
	; Test Inc dec D
	inc StarField_currentchar
	; Binary clause Simplified: EQUALS
	; Compare with pure num / var optimization
	cmp #$6b;keep
	bne StarField_CreateStarScreen_eblock142
StarField_CreateStarScreen_ctb141: ;Main true block ;keep 
	
; // 83 = heart, 58 = colon
	lda #$53
	; Calling storevariable on generic assign expression
	sta StarField_currentchar
	jmp StarField_CreateStarScreen_edblock143
StarField_CreateStarScreen_eblock142
	; Binary clause Simplified: EQUALS
	lda StarField_currentchar
	; Compare with pure num / var optimization
	cmp #$53;keep
	bne StarField_CreateStarScreen_edblock157
StarField_CreateStarScreen_ctb155: ;Main true block ;keep 
	
; //currentchar := 0;
	lda #$3a
	; Calling storevariable on generic assign expression
	sta StarField_currentchar
StarField_CreateStarScreen_edblock157
StarField_CreateStarScreen_edblock143
	; ----------
	; AddressTable address, xoffset, yoffset
	; yoffset is complex
	lda StarField_row
	asl ; *2
	tax
	lda StarField_caddr,x   ; Address of table lo
	ldy StarField_caddr+1,x   ; Address of table hi
	clc
	adc StarField_col
	bcc StarField_CreateStarScreen_dtnooverflow160
	iny  ; overflow into high byte
StarField_CreateStarScreen_dtnooverflow160
	sta colormemory
	sty colormemory+1
	; Load Byte array
	; CAST type NADA
	ldx StarField_colourindex
	lda StarField_StarfieldColours,x 
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (colormemory),y
	; Test Inc dec D
	inc StarField_row
	jmp StarField_CreateStarScreen_while109
StarField_CreateStarScreen_edblock112
StarField_CreateStarScreen_loopend114
	; Test Inc dec D
	inc StarField_colourindex
	; Binary clause Simplified: GREATEREQUAL
	lda StarField_colourindex
	; Compare with pure num / var optimization
	cmp #$14;keep
	bcc StarField_CreateStarScreen_edblock164
StarField_CreateStarScreen_ctb162: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta StarField_colourindex
StarField_CreateStarScreen_edblock164
	; Test Inc dec D
	inc StarField_col
	jmp StarField_CreateStarScreen_while42
StarField_CreateStarScreen_edblock45
StarField_CreateStarScreen_loopend47
	rts
end_procedure_StarField_CreateStarScreen
	
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Update the starfield by redefining bytes in the character set once per frame.
; // ---------------------------------------------------------------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : StarField_DoStarfield
	;    Procedure type : User-defined procedure
StarField_DoStarfield
	; Binary clause Simplified: EQUALS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda StarField_RasterCount
	and #$1
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne StarField_DoStarfield_edblock171
StarField_DoStarfield_ctb169: ;Main true block ;keep 
	
; // -- Star 1 updates every other frame.
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StarField_StarfieldPtr),y
	iny
	sta (StarField_StarfieldPtr),y
	lda StarField_StarfieldPtr
	clc
	adc #$01
	sta StarField_StarfieldPtr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc StarField_DoStarfield_WordAdd182
	inc StarField_StarfieldPtr+1
StarField_DoStarfield_WordAdd182
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	; Load pointer array
	lda (StarField_StarfieldPtr),y
	pha
	iny
	lda (StarField_StarfieldPtr),y
	tay
	pla
	ora #$03
	; Testing for byte:  #$00
	; RHS is word, no optimization
	pha 
	tya 
	ora #$00
	tay 
	pla 
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	; Storing integer to a pointer of integer, need to move data in y to x
	pha
	tya
	tax
	pla
	pha
	lda #$0
	asl
	tay
	pla
	sta (StarField_StarfieldPtr),y
	iny
	txa
	sta (StarField_StarfieldPtr),y
	; Binary clause INTEGER: EQUALS
	lda StarField_StarfieldPtr+1   ; compare high bytes
	cmp #$32 ;keep
	bne StarField_DoStarfield_edblock187
	lda StarField_StarfieldPtr
	cmp #$98 ;keep
	bne StarField_DoStarfield_edblock187
	jmp StarField_DoStarfield_ctb185
StarField_DoStarfield_ctb185: ;Main true block ;keep 
	lda #$d0
	ldx #$31
	sta StarField_StarfieldPtr
	stx StarField_StarfieldPtr+1
StarField_DoStarfield_edblock187
StarField_DoStarfield_edblock171
	
; // -- Star 2 updates every frame.
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StarField_StarfieldPtr2),y
	iny
	sta (StarField_StarfieldPtr2),y
	lda StarField_StarfieldPtr2
	clc
	adc #$01
	sta StarField_StarfieldPtr2+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc StarField_DoStarfield_WordAdd190
	inc StarField_StarfieldPtr2+1
StarField_DoStarfield_WordAdd190
	; Binary clause INTEGER: EQUALS
	lda StarField_StarfieldPtr2+1   ; compare high bytes
	cmp #$33 ;keep
	bne StarField_DoStarfield_edblock194
	lda StarField_StarfieldPtr2
	cmp #$60 ;keep
	bne StarField_DoStarfield_edblock194
	jmp StarField_DoStarfield_ctb192
StarField_DoStarfield_ctb192: ;Main true block ;keep 
	lda #$98
	ldx #$32
	sta StarField_StarfieldPtr2
	stx StarField_StarfieldPtr2+1
StarField_DoStarfield_edblock194
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	; Load pointer array
	lda (StarField_StarfieldPtr2),y
	pha
	iny
	lda (StarField_StarfieldPtr2),y
	tay
	pla
	ora #$0c
	; Testing for byte:  #$00
	; RHS is word, no optimization
	pha 
	tya 
	ora #$00
	tay 
	pla 
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	; Storing integer to a pointer of integer, need to move data in y to x
	pha
	tya
	tax
	pla
	pha
	lda #$0
	asl
	tay
	pla
	sta (StarField_StarfieldPtr2),y
	iny
	txa
	sta (StarField_StarfieldPtr2),y
	; Binary clause Simplified: EQUALS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda StarField_RasterCount
	and #$1
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne StarField_DoStarfield_edblock201
StarField_DoStarfield_ctb199: ;Main true block ;keep 
	
; // -- Star 3 updates every other frame.
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StarField_StarfieldPtr3),y
	iny
	sta (StarField_StarfieldPtr3),y
	lda StarField_StarfieldPtr3
	clc
	adc #$01
	sta StarField_StarfieldPtr3+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc StarField_DoStarfield_WordAdd212
	inc StarField_StarfieldPtr3+1
StarField_DoStarfield_WordAdd212
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	; Load pointer array
	lda (StarField_StarfieldPtr3),y
	pha
	iny
	lda (StarField_StarfieldPtr3),y
	tay
	pla
	ora #$30
	; Testing for byte:  #$00
	; RHS is word, no optimization
	pha 
	tya 
	ora #$00
	tay 
	pla 
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	; Storing integer to a pointer of integer, need to move data in y to x
	pha
	tya
	tax
	pla
	pha
	lda #$0
	asl
	tay
	pla
	sta (StarField_StarfieldPtr3),y
	iny
	txa
	sta (StarField_StarfieldPtr3),y
	; Binary clause INTEGER: EQUALS
	lda StarField_StarfieldPtr3+1   ; compare high bytes
	cmp #$32 ;keep
	bne StarField_DoStarfield_edblock217
	lda StarField_StarfieldPtr3
	cmp #$98 ;keep
	bne StarField_DoStarfield_edblock217
	jmp StarField_DoStarfield_ctb215
StarField_DoStarfield_ctb215: ;Main true block ;keep 
	lda #$d0
	ldx #$31
	sta StarField_StarfieldPtr3
	stx StarField_StarfieldPtr3+1
StarField_DoStarfield_edblock217
StarField_DoStarfield_edblock201
	
; // -- Star 4 updates two pixels down every frame.
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StarField_StarfieldPtr4),y
	iny
	sta (StarField_StarfieldPtr4),y
	lda StarField_StarfieldPtr4
	clc
	adc #$01
	sta StarField_StarfieldPtr4+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc StarField_DoStarfield_WordAdd220
	inc StarField_StarfieldPtr4+1
StarField_DoStarfield_WordAdd220
	lda StarField_StarfieldPtr4
	clc
	adc #$01
	sta StarField_StarfieldPtr4+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc StarField_DoStarfield_WordAdd221
	inc StarField_StarfieldPtr4+1
StarField_DoStarfield_WordAdd221
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	; Load pointer array
	lda (StarField_StarfieldPtr4),y
	pha
	iny
	lda (StarField_StarfieldPtr4),y
	tay
	pla
	ora #$c0
	; Testing for byte:  #$00
	; RHS is word, no optimization
	pha 
	tya 
	ora #$00
	tay 
	pla 
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	; Storing integer to a pointer of integer, need to move data in y to x
	pha
	tya
	tax
	pla
	pha
	lda #$0
	asl
	tay
	pla
	sta (StarField_StarfieldPtr4),y
	iny
	txa
	sta (StarField_StarfieldPtr4),y
	; Binary clause INTEGER: EQUALS
	lda StarField_StarfieldPtr4+1   ; compare high bytes
	cmp #$33 ;keep
	bne StarField_DoStarfield_edblock226
	lda StarField_StarfieldPtr4
	cmp #$60 ;keep
	bne StarField_DoStarfield_edblock226
	jmp StarField_DoStarfield_ctb224
StarField_DoStarfield_ctb224: ;Main true block ;keep 
	lda #$98
	ldx #$32
	sta StarField_StarfieldPtr4
	stx StarField_StarfieldPtr4+1
StarField_DoStarfield_edblock226
	
; // -- Two static blinking stars.
	lda #$50
	ldx #$32
	sta StarField_StaticStarPtr
	stx StarField_StaticStarPtr+1
	; Binary clause Simplified: LESS
	lda StarField_RasterCount
	; Compare with pure num / var optimization
	cmp #$e6;keep
	bcs StarField_DoStarfield_eblock231
StarField_DoStarfield_ctb230: ;Main true block ;keep 
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	; Load pointer array
	lda (StarField_StaticStarPtr),y
	pha
	iny
	lda (StarField_StaticStarPtr),y
	tay
	pla
	ora #$10
	; Testing for byte:  #$00
	; RHS is word, no optimization
	pha 
	tya 
	ora #$00
	tay 
	pla 
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	; Storing integer to a pointer of integer, need to move data in y to x
	pha
	tya
	tax
	pla
	pha
	lda #$0
	asl
	tay
	pla
	sta (StarField_StaticStarPtr),y
	iny
	txa
	sta (StarField_StaticStarPtr),y
	jmp StarField_DoStarfield_edblock232
StarField_DoStarfield_eblock231
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StarField_StaticStarPtr),y
	iny
	sta (StarField_StaticStarPtr),y
StarField_DoStarfield_edblock232
	; 8 bit binop
	; Add/sub where right value is constant number
	lda StarField_RasterCount
	ora #$80
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta StarField_StaticStarBlink
	lda #$e0
	ldx #$31
	sta StarField_StaticStarPtr
	stx StarField_StaticStarPtr+1
	; Binary clause Simplified: LESS
	lda StarField_RasterCount
	; Compare with pure num / var optimization
	cmp #$e6;keep
	bcs StarField_DoStarfield_eblock241
StarField_DoStarfield_ctb240: ;Main true block ;keep 
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	; Load pointer array
	lda (StarField_StaticStarPtr),y
	pha
	iny
	lda (StarField_StaticStarPtr),y
	tay
	pla
	ora #$10
	; Testing for byte:  #$00
	; RHS is word, no optimization
	pha 
	tya 
	ora #$00
	tay 
	pla 
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	; Storing integer to a pointer of integer, need to move data in y to x
	pha
	tya
	tax
	pla
	pha
	lda #$0
	asl
	tay
	pla
	sta (StarField_StaticStarPtr),y
	iny
	txa
	sta (StarField_StaticStarPtr),y
	jmp StarField_DoStarfield_edblock242
StarField_DoStarfield_eblock241
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StarField_StaticStarPtr),y
	iny
	sta (StarField_StaticStarPtr),y
StarField_DoStarfield_edblock242
	rts
end_procedure_StarField_DoStarfield
	; NodeProcedureDecl -1
	; ***********  Defining procedure : Helpers_Clamp
	;    Procedure type : User-defined procedure
Helpers_value	dc.b	0
Helpers_minVal	dc.b	0
Helpers_maxVal	dc.b	0
Helpers_Clamp_block249
Helpers_Clamp
	; Binary clause Simplified: LESS
	lda Helpers_value
	; Compare with pure num / var optimization
	cmp Helpers_minVal;keep
	bcs Helpers_Clamp_eblock252
Helpers_Clamp_ctb251: ;Main true block ;keep 
	ldy #0 ; Fake 16 bit
	lda Helpers_minVal
	; Calling storevariable on generic assign expression
	; Casting from byte to integer
	sta Helpers_temp
	sty Helpers_temp+1
	jmp Helpers_Clamp_edblock253
Helpers_Clamp_eblock252
	; Binary clause Simplified: GREATER
	lda Helpers_value
	; Compare with pure num / var optimization
	cmp Helpers_maxVal;keep
	bcc Helpers_Clamp_eblock268
	beq Helpers_Clamp_eblock268
Helpers_Clamp_ctb267: ;Main true block ;keep 
	ldy #0 ; Fake 16 bit
	lda Helpers_maxVal
	; Calling storevariable on generic assign expression
	; Casting from byte to integer
	sta Helpers_temp
	sty Helpers_temp+1
	jmp Helpers_Clamp_edblock269
Helpers_Clamp_eblock268
	ldy #0 ; Fake 16 bit
	lda Helpers_value
	; Calling storevariable on generic assign expression
	; Casting from byte to integer
	sta Helpers_temp
	sty Helpers_temp+1
Helpers_Clamp_edblock269
Helpers_Clamp_edblock253
	ldy Helpers_temp+1 ;keep
	lda Helpers_temp
	rts
end_procedure_Helpers_Clamp
	; NodeProcedureDecl -1
	; ***********  Defining procedure : Helpers_Div
	;    Procedure type : User-defined procedure
Helpers_dividendInput	dc.b	0
Helpers_divisorInput	dc.b	0
Helpers_Div_block274
Helpers_Div
	; 8 bit div
	lda Helpers_dividendInput
	sta div8x8_d
	; Load right hand side
	lda Helpers_divisorInput
	sta div8x8_c
	jsr div8x8_procedure
	rts
end_procedure_Helpers_Div
	; NodeProcedureDecl -1
	; ***********  Defining procedure : Helpers_Mod
	;    Procedure type : User-defined procedure
Helpers_modDividend	dc.b	0
Helpers_modDivisor	dc.b	0
Helpers_Mod_block277
Helpers_Mod
	; 8 bit binop
	; Add/sub right value is variable/expression
	; 8 bit mul
	; 8 bit div
	lda Helpers_modDividend
	sta div8x8_d
	; Load right hand side
	lda Helpers_modDivisor
	sta div8x8_c
	jsr div8x8_procedure
	; Load right hand side
	tax
	lda Helpers_modDivisor
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
Helpers_Mod_rightvarAddSub_var282 = $54
	sta Helpers_Mod_rightvarAddSub_var282
	lda Helpers_modDividend
	sec
	sbc Helpers_Mod_rightvarAddSub_var282
	rts
end_procedure_Helpers_Mod
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MakeSprites
	;    Procedure type : User-defined procedure
MakeSprites
	
; // Set common sprite multicolor registers
	; Assigning memory location
	lda #$5
	; Calling storevariable on generic assign expression
	sta $d025
	; Assigning memory location
	lda #$1
	; Calling storevariable on generic assign expression
	sta $d026
	
; // Set sprite "0" individual color value 
	lda #$e
	; Calling storevariable on generic assign expression
	sta $D027+$0
	
; // Turn on sprite 0 (or @useSprite)
	; Toggle bit with constant
	lda $d015
	ora #%1
	sta $d015
	ldx #$0 ; optimized, look out for bugs
	lda #1
MakeSprites_shiftbit284
	cpx #0
	beq MakeSprites_shiftbitdone285
	asl
	dex
	jmp MakeSprites_shiftbit284
MakeSprites_shiftbitdone285
MakeSprites_bitmask_var286 = $54
	sta MakeSprites_bitmask_var286
	lda $d015
	ora MakeSprites_bitmask_var286
	sta $d015
	rts
end_procedure_MakeSprites
	
; //moveto(30,3,hi(screen_char_loc));
; //PrintDecimal(Score2,4);
; //moveto(34,3,hi(screen_char_loc));
; //PrintDecimal(Score,3);
; //PrintNumber(border_debug_color);moveto(34,3,hi(screen_char_loc));
; //	poke(^$D019, 0, 0);
; //	PrintNumber(peek(^$d01e, 0));
	; NodeProcedureDecl -1
	; ***********  Defining procedure : initializeMonsters
	;    Procedure type : User-defined procedure
block_loop_counter	dc.b	0
copy_loop_counter	dc.b	0
source_sprite_ptr	= $24
destination_sprite_ptr	= $68
initializeMonsters_block287
initializeMonsters
	lda #$0
	; Calling storevariable on generic assign expression
	sta block_loop_counter
initializeMonsters_forloop288
	
; // Copy monster sprite data (frames 1 and 2) into 24 consecutive sprite locations
; // Each of the 12 monster blocks gets 2 animation frames
; // Copy frame 1 (sprite index 24 from spritesheet)
	lda #$00
	ldx #$26
	sta source_sprite_ptr
	stx source_sprite_ptr+1
	
; // Source: sprite 24
	; Generic 16 bit op
	; Integer constant assigning
	; Load16bitvariable : #$2000
	ldy #$20
initializeMonsters_rightvarInteger_var327 = $54
	sta initializeMonsters_rightvarInteger_var327
	sty initializeMonsters_rightvarInteger_var327+1
	; Right is PURE NUMERIC : Is word =1
	; 16 bit mul or div
	; Mul 16x8 setup
	; Generic 16 bit op
	ldy #0
	lda #$1a
initializeMonsters_rightvarInteger_var330 = $56
	sta initializeMonsters_rightvarInteger_var330
	sty initializeMonsters_rightvarInteger_var330+1
	; Swapping nodes :  num * expr -> exp*num (mul only)
	; Right is PURE NUMERIC : Is word =1
	; 16 bit mul or div
	; Mul 16x8 setup
	; Load16bitvariable : block_loop_counter
	ldy #0
	lda block_loop_counter
	sta mul16x8_num1
	sty mul16x8_num1Hi
	lda #$2
	sta mul16x8_num2
	jsr mul16x8_procedure
	; Low bit binop:
	clc
	adc initializeMonsters_rightvarInteger_var330
initializeMonsters_wordAdd328
	sta initializeMonsters_rightvarInteger_var330
	; High-bit binop
	tya
	adc initializeMonsters_rightvarInteger_var330+1
	tay
	lda initializeMonsters_rightvarInteger_var330
	sta mul16x8_num1
	sty mul16x8_num1Hi
	ldy #0   ; Force integer assignment, set y = 0 for values lower than 255
	lda #$40
	sta mul16x8_num2
	jsr mul16x8_procedure
	; Low bit binop:
	clc
	adc initializeMonsters_rightvarInteger_var327
initializeMonsters_wordAdd325
	sta initializeMonsters_rightvarInteger_var327
	; High-bit binop
	tya
	adc initializeMonsters_rightvarInteger_var327+1
	tay
	lda initializeMonsters_rightvarInteger_var327
	sta destination_sprite_ptr
	sty destination_sprite_ptr+1
	lda #$0
	; Calling storevariable on generic assign expression
	sta copy_loop_counter
initializeMonsters_forloop331
	
; // Destination: sprite 26, 28, 30, 32...
	; Load pointer array
	ldy #$0
	lda (source_sprite_ptr),y
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	sta (destination_sprite_ptr),y
	lda source_sprite_ptr
	clc
	adc #$01
	sta source_sprite_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc initializeMonsters_WordAdd338
	inc source_sprite_ptr+1
initializeMonsters_WordAdd338
	lda destination_sprite_ptr
	clc
	adc #$01
	sta destination_sprite_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc initializeMonsters_WordAdd339
	inc destination_sprite_ptr+1
initializeMonsters_WordAdd339
initializeMonsters_loopstart332
	; Compare is onpage
	; Test Inc dec D
	inc copy_loop_counter
	lda #$3f
	cmp copy_loop_counter ;keep
	bne initializeMonsters_forloop331
initializeMonsters_loopdone340: ;keep
initializeMonsters_loopend333
	
; // Copy frame 2 (sprite index 25 from spritesheet)
	lda #$40
	ldx #$26
	sta source_sprite_ptr
	stx source_sprite_ptr+1
	
; // Source: sprite 25
	; Generic 16 bit op
	; Integer constant assigning
	; Load16bitvariable : #$2000
	ldy #$20
	lda #$00
initializeMonsters_rightvarInteger_var343 = $54
	sta initializeMonsters_rightvarInteger_var343
	sty initializeMonsters_rightvarInteger_var343+1
	; Right is PURE NUMERIC : Is word =1
	; 16 bit mul or div
	; Mul 16x8 setup
	; Generic 16 bit op
	ldy #0
	lda #$1b
initializeMonsters_rightvarInteger_var346 = $56
	sta initializeMonsters_rightvarInteger_var346
	sty initializeMonsters_rightvarInteger_var346+1
	; Swapping nodes :  num * expr -> exp*num (mul only)
	; Right is PURE NUMERIC : Is word =1
	; 16 bit mul or div
	; Mul 16x8 setup
	; Load16bitvariable : block_loop_counter
	ldy #0
	lda block_loop_counter
	sta mul16x8_num1
	sty mul16x8_num1Hi
	lda #$2
	sta mul16x8_num2
	jsr mul16x8_procedure
	; Low bit binop:
	clc
	adc initializeMonsters_rightvarInteger_var346
initializeMonsters_wordAdd344
	sta initializeMonsters_rightvarInteger_var346
	; High-bit binop
	tya
	adc initializeMonsters_rightvarInteger_var346+1
	tay
	lda initializeMonsters_rightvarInteger_var346
	sta mul16x8_num1
	sty mul16x8_num1Hi
	ldy #0   ; Force integer assignment, set y = 0 for values lower than 255
	lda #$40
	sta mul16x8_num2
	jsr mul16x8_procedure
	; Low bit binop:
	clc
	adc initializeMonsters_rightvarInteger_var343
initializeMonsters_wordAdd341
	sta initializeMonsters_rightvarInteger_var343
	; High-bit binop
	tya
	adc initializeMonsters_rightvarInteger_var343+1
	tay
	lda initializeMonsters_rightvarInteger_var343
	sta destination_sprite_ptr
	sty destination_sprite_ptr+1
	lda #$0
	; Calling storevariable on generic assign expression
	sta copy_loop_counter
initializeMonsters_forloop347
	
; // Destination: sprite 27, 29, 31, 33...
	; Load pointer array
	ldy #$0
	lda (source_sprite_ptr),y
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	sta (destination_sprite_ptr),y
	lda source_sprite_ptr
	clc
	adc #$01
	sta source_sprite_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc initializeMonsters_WordAdd354
	inc source_sprite_ptr+1
initializeMonsters_WordAdd354
	lda destination_sprite_ptr
	clc
	adc #$01
	sta destination_sprite_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc initializeMonsters_WordAdd355
	inc destination_sprite_ptr+1
initializeMonsters_WordAdd355
initializeMonsters_loopstart348
	; Compare is onpage
	; Test Inc dec D
	inc copy_loop_counter
	lda #$3f
	cmp copy_loop_counter ;keep
	bne initializeMonsters_forloop347
initializeMonsters_loopdone356: ;keep
initializeMonsters_loopend349
initializeMonsters_loopstart289
	; Test Inc dec D
	inc block_loop_counter
	lda #$c
	cmp block_loop_counter ;keep
	beq initializeMonsters_loopdone357
initializeMonsters_loopnotdone358
	jmp initializeMonsters_forloop288
initializeMonsters_loopdone357
initializeMonsters_loopend290
	rts
end_procedure_initializeMonsters
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateSprite
	;    Procedure type : User-defined procedure
UpdateSprite
	
; // Update player position based on joystick input
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda joystickright
	sec
	sbc joystickleft
	 ; end add / sub var with constant
	clc
	adc pos_x
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta Helpers_value
	lda #$27
	; Calling storevariable on generic assign expression
	sta Helpers_minVal
	lda #$da
	; Calling storevariable on generic assign expression
	sta Helpers_maxVal
	jsr Helpers_Clamp
	; Calling storevariable on generic assign expression
	sta pos_x
	; Calling storevariable on generic assign expression
	sta player_sprite_x
	
; // Update the sprite position on screen for sprite number @useSprite	
	; Setting sprite position
	; isi-pisi: value is constant
	ldx #0
	sta $D000,x
UpdateSprite_spritepos360
	lda $D010
	and #%11111110
	sta $D010
UpdateSprite_spriteposcontinue361
	inx
	txa
	tay
	lda player_sprite_y
	sta $D000,y
	; Binary clause Simplified: NOTEQUALS
	clc
	lda joystickright
	; cmp #$00 ignored
	beq UpdateSprite_edblock365
UpdateSprite_ctb363: ;Main true block ;keep 
	
; // Set left/right offset pointer for sprite
	lda #$1
	; Calling storevariable on generic assign expression
	sta player_joystick_direction
UpdateSprite_edblock365
	; Binary clause Simplified: NOTEQUALS
	clc
	lda joystickleft
	; cmp #$00 ignored
	beq UpdateSprite_edblock371
UpdateSprite_ctb369: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta player_joystick_direction
UpdateSprite_edblock371
	; Set sprite location
	ldx #$0 ; optimized, look out for bugs
	lda #$80
	sta $07f8 + $0,x
	rts
end_procedure_UpdateSprite
	
; //showBullet();
; //animateMonsters();
	; NodeProcedureDecl -1
	; ***********  Defining procedure : FirePlayerBullet
	;    Procedure type : User-defined procedure
FirePlayerBullet
	lda #$1
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	lda player_sprite_x
	; Calling storevariable on generic assign expression
	sta player_bullet_x
	
; // Same X as player
	; Optimizer: a = a +/- b
	; Load16bitvariable : player_sprite_y
	lda player_sprite_y
	sec
	sbc #$15
	sta player_bullet_y
	rts
end_procedure_FirePlayerBullet
	
; // One sprite height above player
; //player_bullet_y := player_sprite_y - 30;  
; // One sprite height above player
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ShowBullet
	;    Procedure type : User-defined procedure
bullet_sprite_index	dc.b	0
ShowBullet_block375
ShowBullet
	; Binary clause Simplified: NOTEQUALS
	clc
	lda player_bullet_active
	; cmp #$00 ignored
	beq ShowBullet_edblock379
ShowBullet_ctb377: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne ShowBullet_eblock397
ShowBullet_ctb396: ;Main true block ;keep 
	
; // Only display if bullet is active
; // Select sprite based on bullet state: 1=normal bullet, 2=explosion
; // Explosion sprite
	lda #$2
	; Calling storevariable on generic assign expression
	sta bullet_sprite_index
	jmp ShowBullet_edblock398
ShowBullet_eblock397
	lda #$1
	; Calling storevariable on generic assign expression
	sta bullet_sprite_index
ShowBullet_edblock398
	
; // Normal bullet sprite
	; Set sprite location
	lda #$0
	sta $50
	; Generic 16 bit op
	ldy #0
	lda bullet_sprite_index
ShowBullet_rightvarInteger_var405 = $54
	sta ShowBullet_rightvarInteger_var405
	sty ShowBullet_rightvarInteger_var405+1
	lda #128
	ldy #0
	; Low bit binop:
	clc
	adc ShowBullet_rightvarInteger_var405
ShowBullet_wordAdd403
	sta ShowBullet_rightvarInteger_var405
	; High-bit binop
	tya
	adc ShowBullet_rightvarInteger_var405+1
	tay
	lda ShowBullet_rightvarInteger_var405
	ldx $50
	sta $07f8 + $0,x
	; Setting sprite position
	; isi-pisi: value is constant
	lda player_bullet_x
	ldx #0
	sta $D000,x
ShowBullet_spritepos406
	lda $D010
	and #%11111110
	sta $D010
ShowBullet_spriteposcontinue407
	inx
	txa
	tay
	lda player_bullet_y
	sta $D000,y
ShowBullet_edblock379
	rts
end_procedure_ShowBullet
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdatePlayerBullet
	;    Procedure type : User-defined procedure
UpdatePlayerBullet
	; Binary clause Simplified: EQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne UpdatePlayerBullet_eblock411
UpdatePlayerBullet_ctb410: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	lda player_bullet_y
	; Compare with pure num / var optimization
	cmp #$5;keep
	bcc UpdatePlayerBullet_eblock444
UpdatePlayerBullet_ctb443: ;Main true block ;keep 
	
; // Move bullet up
	; Optimizer: a = a +/- b
	; Load16bitvariable : player_bullet_y
	lda player_bullet_y
	sec
	sbc #$4
	sta player_bullet_y
	jmp UpdatePlayerBullet_edblock445
UpdatePlayerBullet_eblock444
	
; // Bullet reached top of screen, deactivate
	lda #$0
	; Calling storevariable on generic assign expression
	sta player_bullet_active
UpdatePlayerBullet_edblock445
	jmp UpdatePlayerBullet_edblock412
UpdatePlayerBullet_eblock411
	; Binary clause Simplified: EQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne UpdatePlayerBullet_edblock454
UpdatePlayerBullet_ctb452: ;Main true block ;keep 
	
; // Explosion animation - count frames
	; Test Inc dec D
	inc explosion_frame_counter
	; Binary clause Simplified: GREATEREQUAL
	lda explosion_frame_counter
	; Compare with pure num / var optimization
	cmp #$10;keep
	bcc UpdatePlayerBullet_edblock466
UpdatePlayerBullet_ctb464: ;Main true block ;keep 
	
; // Explosion finished, reset bullet
	lda #$0
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	; Calling storevariable on generic assign expression
	sta explosion_frame_counter
UpdatePlayerBullet_edblock466
UpdatePlayerBullet_edblock454
UpdatePlayerBullet_edblock412
	rts
end_procedure_UpdatePlayerBullet
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CheckBulletCollision
	;    Procedure type : User-defined procedure
block_row	dc.b	0
block_col	dc.b	0
block_index	dc.b	0
enemy_alive	dc.b	0
block_x	dc.b	0
block_y	dc.b	0
rel_x	dc.b	0
rel_y	dc.b	0
enemy_col	dc.b	0
enemy_row	dc.b	0
hit_enemy_index	dc.b	0
cbc_enemy_mask	dc.b	0
should_check	dc.b	0
found_hit	dc.b	0
CheckBulletCollision_block469
CheckBulletCollision
	lda #$1
	; Calling storevariable on generic assign expression
	sta should_check
	lda #$0
	; Calling storevariable on generic assign expression
	sta found_hit
	; Binary clause Simplified: LESS
	lda player_bullet_y
	; Compare with pure num / var optimization
	cmp monster_base_y;keep
	bcs CheckBulletCollision_edblock473
CheckBulletCollision_ctb471: ;Main true block ;keep 
	
; // Early exit if bullet outside enemy formation area
; // Formation spans from monster_base_y to monster_base_y + adjustment + (3 rows × 26) + 21 sprite height
	lda #$0
	; Calling storevariable on generic assign expression
	sta should_check
CheckBulletCollision_edblock473
	; Swapped comparison expressions
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	clc
	adc #$50
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp player_bullet_y;keep
	bcs CheckBulletCollision_edblock479
CheckBulletCollision_ctb477: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta should_check
CheckBulletCollision_edblock479
	; Binary clause Simplified: NOTEQUALS
	clc
	lda should_check
	; cmp #$00 ignored
	beq CheckBulletCollision_localfailed1923
	jmp CheckBulletCollision_ctb483
CheckBulletCollision_localfailed1923
	jmp CheckBulletCollision_edblock485
CheckBulletCollision_ctb483: ;Main true block ;keep 
	
; // Calculate which block row (0-2) the bullet is in
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_y
	sec
	sbc monster_base_y
	 ; end add / sub var with constant
	sec
	sbc monster_vertical_adjustment
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta rel_y
	; Binary clause Simplified: LESS
	; Compare with pure num / var optimization
	cmp #$1a;keep
	bcs CheckBulletCollision_eblock1927
CheckBulletCollision_ctb1926: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta block_row
	jmp CheckBulletCollision_edblock1928
CheckBulletCollision_eblock1927
	; Binary clause Simplified: LESS
	lda rel_y
	; Compare with pure num / var optimization
	cmp #$34;keep
	bcs CheckBulletCollision_eblock1943
CheckBulletCollision_ctb1942: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta block_row
	jmp CheckBulletCollision_edblock1944
CheckBulletCollision_eblock1943
	lda #$2
	; Calling storevariable on generic assign expression
	sta block_row
CheckBulletCollision_edblock1944
CheckBulletCollision_edblock1928
	
; // Check all 4 blocks in the bullet's row
	lda #$0
	; Calling storevariable on generic assign expression
	sta block_col
CheckBulletCollision_while1949
CheckBulletCollision_loopstart1953
	; Binary clause Simplified: LESS
	lda block_col
	; Compare with pure num / var optimization
	cmp #$4;keep
	bcs CheckBulletCollision_localfailed2657
CheckBulletCollision_localsuccess2658: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda found_hit
	; cmp #$00 ignored
	bne CheckBulletCollision_localfailed2657
	jmp CheckBulletCollision_ctb1950
CheckBulletCollision_localfailed2657
	jmp CheckBulletCollision_edblock1952
CheckBulletCollision_ctb1950: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : block_row
	lda block_row
	asl
	asl
	clc
	adc block_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta block_index
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx block_index
	lda block_enemies,x 
	; Calling storevariable on generic assign expression
	sta enemy_alive
	; Binary clause Simplified: NOTEQUALS
	clc
	; cmp #$00 ignored
	beq CheckBulletCollision_localfailed3012
	jmp CheckBulletCollision_ctb2661
CheckBulletCollision_localfailed3012
	jmp CheckBulletCollision_edblock2663
CheckBulletCollision_ctb2661: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx block_col ; optimized, look out for bugs
	; Load right hand side
	lda #$36
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc monster_base_x
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta block_x
	; Binary clause Simplified: GREATEREQUAL
	lda player_bullet_x
	; Compare with pure num / var optimization
	cmp block_x;keep
	bcc CheckBulletCollision_localfailed3190
	jmp CheckBulletCollision_ctb3017
CheckBulletCollision_localfailed3190
	jmp CheckBulletCollision_edblock3019
CheckBulletCollision_ctb3017: ;Main true block ;keep 
	; Binary clause Simplified: GREATER
	; 8 bit binop
	; Add/sub where right value is constant number
	lda block_x
	clc
	adc #$30
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp player_bullet_x;keep
	bcc CheckBulletCollision_localfailed3278
	beq CheckBulletCollision_localfailed3278
	jmp CheckBulletCollision_ctb3193
CheckBulletCollision_localfailed3278
	jmp CheckBulletCollision_edblock3195
CheckBulletCollision_ctb3193: ;Main true block ;keep 
	
; // Quick horizontal range check
; // Inside this block horizontally - check which enemy
; // Note: Each enemy is 5 sprite pixels × 2 (stretch) = 10 screen pixels wide
; // Shift bullet position left by 4 pixels to center hitbox on visual sprite
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_x
	sec
	sbc block_x
	 ; end add / sub var with constant
	sec
	sbc #$4
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta rel_x
	; Binary clause Simplified: GREATEREQUAL
	; Compare with pure num / var optimization
	cmp #$c9;keep
	bcc CheckBulletCollision_edblock3283
CheckBulletCollision_ctb3281: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta rel_x
CheckBulletCollision_edblock3283
	
; // Handle underflow (byte wraparound)
	; 8 bit binop
	; Add/sub right value is variable/expression
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx block_row ; optimized, look out for bugs
	; Load right hand side
	lda #$1a
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
CheckBulletCollision_rightvarAddSub_var3288 = $54
	sta CheckBulletCollision_rightvarAddSub_var3288
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	clc
	adc CheckBulletCollision_rightvarAddSub_var3288
	; Calling storevariable on generic assign expression
	sta block_y
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_y
	sec
	sbc block_y
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta rel_y
	; Binary clause Simplified: LESS
	lda rel_x
	; Compare with pure num / var optimization
	cmp #$a;keep
	bcs CheckBulletCollision_eblock3291
CheckBulletCollision_ctb3290: ;Main true block ;keep 
	
; // Determine enemy column (0-2) by X position
; // Enemy 0: pixels 0-9, Enemy 1: pixels 10-27, Enemy 2: pixels 28-47
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_col
	jmp CheckBulletCollision_edblock3292
CheckBulletCollision_eblock3291
	; Binary clause Simplified: LESS
	lda rel_x
	; Compare with pure num / var optimization
	cmp #$1c;keep
	bcs CheckBulletCollision_eblock3307
CheckBulletCollision_ctb3306: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemy_col
	jmp CheckBulletCollision_edblock3308
CheckBulletCollision_eblock3307
	lda #$2
	; Calling storevariable on generic assign expression
	sta enemy_col
CheckBulletCollision_edblock3308
CheckBulletCollision_edblock3292
	
; // Determine enemy row (0-1) by Y position
; // Each enemy is 8 pixels tall with a 5-pixel gap between rows
; // Row 0 (top): Y 0-7, Gap: Y 8-12, Row 1 (bottom): Y 13-20
	lda #$ff
	; Calling storevariable on generic assign expression
	sta enemy_row
	; Binary clause Simplified: LESS
	lda rel_y
	; Compare with pure num / var optimization
	cmp #$8;keep
	bcs CheckBulletCollision_eblock3315
CheckBulletCollision_ctb3314: ;Main true block ;keep 
	
; // Invalid by default
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_row
	jmp CheckBulletCollision_edblock3316
CheckBulletCollision_eblock3315
	; Binary clause Simplified: GREATEREQUAL
	lda rel_y
	; Compare with pure num / var optimization
	cmp #$d;keep
	bcc CheckBulletCollision_edblock3331
CheckBulletCollision_localsuccess3333: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	lda rel_y
	; Compare with pure num / var optimization
	cmp #$15;keep
	bcs CheckBulletCollision_edblock3331
CheckBulletCollision_ctb3329: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemy_row
CheckBulletCollision_edblock3331
CheckBulletCollision_edblock3316
	; Binary clause Simplified: NOTEQUALS
	lda enemy_row
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CheckBulletCollision_edblock3338
CheckBulletCollision_ctb3336: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : enemy_col
	lda enemy_col
	asl
	clc
	adc enemy_row
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta hit_enemy_index
	tax ; optimized x, look out for bugs L22 ORG 	ldx hit_enemy_index ; optimized, look out for bugs
	lda #$1
	cpx #0
	beq CheckBulletCollision_lblShiftDone3352
CheckBulletCollision_lblShift3351
	asl
	dex
	cpx #0
	bne CheckBulletCollision_lblShift3351
CheckBulletCollision_lblShiftDone3352
	; Calling storevariable on generic assign expression
	sta cbc_enemy_mask
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda enemy_alive
	and cbc_enemy_mask
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq CheckBulletCollision_edblock3356
CheckBulletCollision_ctb3354: ;Main true block ;keep 
	
; // Check if this enemy is alive
; // Hit! Clear enemy and trigger explosion
	lda block_index
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$1
	; Calling storevariable on generic assign expression
	sta numBlocks
	lda hit_enemy_index
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	; 8 bit binop
	; Add/sub right value is variable/expression
	; 8 bit binop
	; Add/sub where right value is constant number
	lda cbc_enemy_mask
	eor #$ff
	 ; end add / sub var with constant
CheckBulletCollision_rightvarAddSub_var3360 = $54
	sta CheckBulletCollision_rightvarAddSub_var3360
	lda enemy_alive
	and CheckBulletCollision_rightvarAddSub_var3360
	; Calling storevariable on generic assign expression
	ldx block_index ; optimized, look out for bugs
	sta block_enemies,x
	lda #$2
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	lda #$0
	; Calling storevariable on generic assign expression
	sta explosion_frame_counter
	lda #$1
	; Calling storevariable on generic assign expression
	sta found_hit
CheckBulletCollision_edblock3356
CheckBulletCollision_edblock3338
CheckBulletCollision_edblock3195
CheckBulletCollision_edblock3019
CheckBulletCollision_edblock2663
	; Test Inc dec D
	inc block_col
	jmp CheckBulletCollision_while1949
CheckBulletCollision_edblock1952
CheckBulletCollision_loopend1954
CheckBulletCollision_edblock485
	rts
end_procedure_CheckBulletCollision
	; NodeProcedureDecl -1
	; ***********  Defining procedure : DisplayText
	;    Procedure type : User-defined procedure
DisplayText
	
; //moveto(29,1,hi(screen_char_loc));
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3363
	ldy #>DisplayText_stringassignstr3363
	sta Screen_p1
	sty Screen_p1+1
	lda #$1d
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$0
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3365
	ldy #>DisplayText_stringassignstr3365
	sta Screen_p1
	sty Screen_p1+1
	lda #$1d
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$1
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3367
	ldy #>DisplayText_stringassignstr3367
	sta Screen_p1
	sty Screen_p1+1
	lda #$1d
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$b
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3369
	ldy #>DisplayText_stringassignstr3369
	sta Screen_p1
	sty Screen_p1+1
	lda #$1d
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$d
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3371
	ldy #>DisplayText_stringassignstr3371
	sta Screen_p1
	sty Screen_p1+1
	lda #$1d
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$15
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3373
	ldy #>DisplayText_stringassignstr3373
	sta Screen_p1
	sty Screen_p1+1
	lda #$1d
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$17
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3375
	ldy #>DisplayText_stringassignstr3375
	sta Screen_p1
	sty Screen_p1+1
	lda #$4
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$13
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3377
	ldy #>DisplayText_stringassignstr3377
	sta Screen_p1
	sty Screen_p1+1
	lda #$4
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$14
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3379
	ldy #>DisplayText_stringassignstr3379
	sta Screen_p1
	sty Screen_p1+1
	lda #$a
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$13
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3381
	ldy #>DisplayText_stringassignstr3381
	sta Screen_p1
	sty Screen_p1+1
	lda #$a
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$14
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3383
	ldy #>DisplayText_stringassignstr3383
	sta Screen_p1
	sty Screen_p1+1
	lda #$10
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$13
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3385
	ldy #>DisplayText_stringassignstr3385
	sta Screen_p1
	sty Screen_p1+1
	lda #$10
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$14
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3387
	ldy #>DisplayText_stringassignstr3387
	sta Screen_p1
	sty Screen_p1+1
	lda #$16
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$13
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3389
	ldy #>DisplayText_stringassignstr3389
	sta Screen_p1
	sty Screen_p1+1
	lda #$16
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$14
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr3391
	ldy #>DisplayText_stringassignstr3391
	sta Screen_p1
	sty Screen_p1+1
	lda #$0
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$18
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	rts
end_procedure_DisplayText
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ClearEnemyAtCounter
	;    Procedure type : User-defined procedure
clear_index	dc.b	0
clear_col	dc.b	0
clear_local_index	dc.b	0
clear_row	dc.b	0
enemy_type	dc.b	0
pair_index	dc.b	0
sub_local	dc.b	0
enemy_sub	dc.b	0
cec_enemy_mask	dc.b	0
ClearEnemyAtCounter_block3392
ClearEnemyAtCounter
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$47
	sec
	sbc sequential_clear_counter
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta clear_index
	; 8 bit binop
	; Add/sub right value is variable/expression
	; Calling storevariable on generic assign expression
	sta Helpers_dividendInput
	lda #$12
	; Calling storevariable on generic assign expression
	sta Helpers_divisorInput
	jsr Helpers_Div
ClearEnemyAtCounter_rightvarAddSub_var3393 = $54
	sta ClearEnemyAtCounter_rightvarAddSub_var3393
	lda #$3
	sec
	sbc ClearEnemyAtCounter_rightvarAddSub_var3393
	; Calling storevariable on generic assign expression
	sta clear_col
	lda clear_index
	; Calling storevariable on generic assign expression
	sta Helpers_modDividend
	lda #$12
	; Calling storevariable on generic assign expression
	sta Helpers_modDivisor
	jsr Helpers_Mod
	; Calling storevariable on generic assign expression
	sta clear_local_index
	; Calling storevariable on generic assign expression
	sta Helpers_dividendInput
	lda #$6
	; Calling storevariable on generic assign expression
	sta Helpers_divisorInput
	jsr Helpers_Div
	; Calling storevariable on generic assign expression
	sta pair_index
	lda clear_local_index
	; Calling storevariable on generic assign expression
	sta Helpers_modDividend
	lda #$6
	; Calling storevariable on generic assign expression
	sta Helpers_modDivisor
	jsr Helpers_Mod
	; Calling storevariable on generic assign expression
	sta sub_local
	; 8 bit binop
	; Add/sub right value is variable/expression
	; Calling storevariable on generic assign expression
	sta Helpers_dividendInput
	lda #$2
	; Calling storevariable on generic assign expression
	sta Helpers_divisorInput
	jsr Helpers_Div
ClearEnemyAtCounter_rightvarAddSub_var3394 = $54
	sta ClearEnemyAtCounter_rightvarAddSub_var3394
	lda #$2
	sec
	sbc ClearEnemyAtCounter_rightvarAddSub_var3394
	; Calling storevariable on generic assign expression
	sta clear_row
	lda sub_local
	; Calling storevariable on generic assign expression
	sta Helpers_modDividend
	lda #$2
	; Calling storevariable on generic assign expression
	sta Helpers_modDivisor
	jsr Helpers_Mod
	; Calling storevariable on generic assign expression
	sta enemy_sub
	; Binary clause Simplified: EQUALS
	clc
	lda pair_index
	; cmp #$00 ignored
	bne ClearEnemyAtCounter_eblock3397
ClearEnemyAtCounter_ctb3396: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda enemy_sub
	; cmp #$00 ignored
	bne ClearEnemyAtCounter_eblock3452
ClearEnemyAtCounter_ctb3451: ;Main true block ;keep 
	
; // Column-based enemy indexing: Col0(0,1), Col1(2,3), Col2(4,5)
; // Clear from right to left, bottom then top within each column
	lda #$5
	; Calling storevariable on generic assign expression
	sta enemy_type
	jmp ClearEnemyAtCounter_edblock3453
ClearEnemyAtCounter_eblock3452
	lda #$4
	; Calling storevariable on generic assign expression
	sta enemy_type
ClearEnemyAtCounter_edblock3453
	jmp ClearEnemyAtCounter_edblock3398
ClearEnemyAtCounter_eblock3397
	
; // Left column
	; Binary clause Simplified: EQUALS
	lda pair_index
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne ClearEnemyAtCounter_eblock3461
ClearEnemyAtCounter_ctb3460: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda enemy_sub
	; cmp #$00 ignored
	bne ClearEnemyAtCounter_eblock3484
ClearEnemyAtCounter_ctb3483: ;Main true block ;keep 
	
; // Right column
	lda #$3
	; Calling storevariable on generic assign expression
	sta enemy_type
	jmp ClearEnemyAtCounter_edblock3485
ClearEnemyAtCounter_eblock3484
	lda #$2
	; Calling storevariable on generic assign expression
	sta enemy_type
ClearEnemyAtCounter_edblock3485
	jmp ClearEnemyAtCounter_edblock3462
ClearEnemyAtCounter_eblock3461
	; Binary clause Simplified: EQUALS
	clc
	lda enemy_sub
	; cmp #$00 ignored
	bne ClearEnemyAtCounter_eblock3493
ClearEnemyAtCounter_ctb3492: ;Main true block ;keep 
	
; // Middle column
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemy_type
	jmp ClearEnemyAtCounter_edblock3494
ClearEnemyAtCounter_eblock3493
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_type
ClearEnemyAtCounter_edblock3494
ClearEnemyAtCounter_edblock3462
ClearEnemyAtCounter_edblock3398
	lda enemy_type
	; Calling storevariable on generic assign expression
	sta temp_enemy_index
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : clear_row
	lda clear_row
	asl
	asl
	clc
	adc clear_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta temp_block_index
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$1
	; Calling storevariable on generic assign expression
	sta numBlocks
	lda temp_enemy_index
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	
; // Update block_enemies array to mark this enemy as cleared
	ldx enemy_type ; optimized, look out for bugs
	lda #$1
	cpx #0
	beq ClearEnemyAtCounter_lblShiftDone3500
ClearEnemyAtCounter_lblShift3499
	asl
	dex
	cpx #0
	bne ClearEnemyAtCounter_lblShift3499
ClearEnemyAtCounter_lblShiftDone3500
	; Calling storevariable on generic assign expression
	sta cec_enemy_mask
	; 8 bit binop
	; Add/sub right value is variable/expression
	; 8 bit binop
	; Add/sub where right value is constant number
	eor #$ff
	 ; end add / sub var with constant
ClearEnemyAtCounter_rightvarAddSub_var3501 = $54
	sta ClearEnemyAtCounter_rightvarAddSub_var3501
	; Load Byte array
	; CAST type NADA
	ldx temp_block_index
	lda block_enemies,x 
	and ClearEnemyAtCounter_rightvarAddSub_var3501
	; Calling storevariable on generic assign expression
	sta block_enemies,x
	rts
end_procedure_ClearEnemyAtCounter
	
; // Find the rightmost occupied enemy column offset (0-172)
; // Returns pixel offset from monster_base_x to the rightmost enemy
	; NodeProcedureDecl -1
	; ***********  Defining procedure : GetRightmostEnemyOffset
	;    Procedure type : User-defined procedure
rightmost_block_column	dc.b	0
rightmost_row_index	dc.b	0
rightmost_block_index	dc.b	0
rightmost_enemies_byte	dc.b	0
rightmost_found_flag	dc.b	0
rightmost_result_offset	dc.b	0
rightmost_column_loop_done	dc.b	0
GetRightmostEnemyOffset_block3502
GetRightmostEnemyOffset
	lda #$0
	; Calling storevariable on generic assign expression
	sta rightmost_found_flag
	; Calling storevariable on generic assign expression
	sta rightmost_result_offset
	; Calling storevariable on generic assign expression
	sta rightmost_column_loop_done
	
; // Scan from rightmost block column (3) to left (0)
	lda #$3
	; Calling storevariable on generic assign expression
	sta rightmost_block_column
GetRightmostEnemyOffset_while3503
GetRightmostEnemyOffset_loopstart3507
	; Binary clause Simplified: EQUALS
	clc
	lda rightmost_column_loop_done
	; cmp #$00 ignored
	bne GetRightmostEnemyOffset_localfailed3681
	jmp GetRightmostEnemyOffset_ctb3504
GetRightmostEnemyOffset_localfailed3681
	jmp GetRightmostEnemyOffset_edblock3506
GetRightmostEnemyOffset_ctb3504: ;Main true block ;keep 
	
; // Check all 3 rows for this block column
	lda #$0
	; Calling storevariable on generic assign expression
	sta rightmost_row_index
GetRightmostEnemyOffset_while3683
GetRightmostEnemyOffset_loopstart3687
	; Binary clause Simplified: LESS
	lda rightmost_row_index
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs GetRightmostEnemyOffset_localfailed3766
GetRightmostEnemyOffset_localsuccess3767: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda rightmost_found_flag
	; cmp #$00 ignored
	bne GetRightmostEnemyOffset_localfailed3766
	jmp GetRightmostEnemyOffset_ctb3684
GetRightmostEnemyOffset_localfailed3766
	jmp GetRightmostEnemyOffset_edblock3686
GetRightmostEnemyOffset_ctb3684: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : rightmost_row_index
	lda rightmost_row_index
	asl
	asl
	clc
	adc rightmost_block_column
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta rightmost_block_index
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx rightmost_block_index
	lda block_enemies,x 
	; Calling storevariable on generic assign expression
	sta rightmost_enemies_byte
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	and #$30
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetRightmostEnemyOffset_eblock3771
GetRightmostEnemyOffset_ctb3770: ;Main true block ;keep 
	
; // Column-based indexing: check right to left
; // bits 4,5 set (right column: enemies 4,5)
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx rightmost_block_column ; optimized, look out for bugs
	; Load right hand side
	lda #$36
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc #$24
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta rightmost_result_offset
	lda #$1
	; Calling storevariable on generic assign expression
	sta rightmost_found_flag
	jmp GetRightmostEnemyOffset_edblock3772
GetRightmostEnemyOffset_eblock3771
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda rightmost_enemies_byte
	and #$c
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetRightmostEnemyOffset_eblock3815
GetRightmostEnemyOffset_ctb3814: ;Main true block ;keep 
	
; // bits 2,3 set (middle column: enemies 2,3)
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx rightmost_block_column ; optimized, look out for bugs
	; Load right hand side
	lda #$36
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc #$12
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta rightmost_result_offset
	lda #$1
	; Calling storevariable on generic assign expression
	sta rightmost_found_flag
	jmp GetRightmostEnemyOffset_edblock3816
GetRightmostEnemyOffset_eblock3815
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda rightmost_enemies_byte
	and #$3
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetRightmostEnemyOffset_edblock3838
GetRightmostEnemyOffset_ctb3836: ;Main true block ;keep 
	
; // bits 0,1 set (left column: enemies 0,1)
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx rightmost_block_column ; optimized, look out for bugs
	; Load right hand side
	lda #$36
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	; Calling storevariable on generic assign expression
	sta rightmost_result_offset
	lda #$1
	; Calling storevariable on generic assign expression
	sta rightmost_found_flag
GetRightmostEnemyOffset_edblock3838
GetRightmostEnemyOffset_edblock3816
GetRightmostEnemyOffset_edblock3772
	; Test Inc dec D
	inc rightmost_row_index
	jmp GetRightmostEnemyOffset_while3683
GetRightmostEnemyOffset_edblock3686
GetRightmostEnemyOffset_loopend3688
	; Binary clause Simplified: EQUALS
	lda rightmost_found_flag
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne GetRightmostEnemyOffset_localfailed3851
	jmp GetRightmostEnemyOffset_ctb3846
GetRightmostEnemyOffset_localfailed3851: ;keep
	; ; logical OR, second chance
	; Binary clause Simplified: EQUALS
	clc
	lda rightmost_block_column
	; cmp #$00 ignored
	bne GetRightmostEnemyOffset_eblock3847
GetRightmostEnemyOffset_ctb3846: ;Main true block ;keep 
	
; // Exit if found or if we've checked column 0
	lda #$1
	; Calling storevariable on generic assign expression
	sta rightmost_column_loop_done
	jmp GetRightmostEnemyOffset_edblock3848
GetRightmostEnemyOffset_eblock3847
	; Test Inc dec D
	dec rightmost_block_column
GetRightmostEnemyOffset_edblock3848
	jmp GetRightmostEnemyOffset_while3503
GetRightmostEnemyOffset_edblock3506
GetRightmostEnemyOffset_loopend3508
	lda rightmost_result_offset
	rts
end_procedure_GetRightmostEnemyOffset
	
; // Find the leftmost occupied enemy column offset (0-172)
	; NodeProcedureDecl -1
	; ***********  Defining procedure : GetLeftmostEnemyOffset
	;    Procedure type : User-defined procedure
leftmost_block_column	dc.b	0
leftmost_row_index	dc.b	0
leftmost_block_index	dc.b	0
leftmost_enemies_byte	dc.b	0
leftmost_found_flag	dc.b	0
leftmost_result_offset	dc.b	0
leftmost_column_loop_done	dc.b	0
GetLeftmostEnemyOffset_block3854
GetLeftmostEnemyOffset
	lda #$0
	; Calling storevariable on generic assign expression
	sta leftmost_found_flag
	; Calling storevariable on generic assign expression
	sta leftmost_result_offset
	; Calling storevariable on generic assign expression
	sta leftmost_column_loop_done
	
; // Scan from leftmost block column (0) to right (3)
	; Calling storevariable on generic assign expression
	sta leftmost_block_column
GetLeftmostEnemyOffset_while3855
GetLeftmostEnemyOffset_loopstart3859
	; Binary clause Simplified: EQUALS
	clc
	lda leftmost_column_loop_done
	; cmp #$00 ignored
	bne GetLeftmostEnemyOffset_localfailed4033
	jmp GetLeftmostEnemyOffset_ctb3856
GetLeftmostEnemyOffset_localfailed4033
	jmp GetLeftmostEnemyOffset_edblock3858
GetLeftmostEnemyOffset_ctb3856: ;Main true block ;keep 
	
; // Check all 3 rows for this block column
	lda #$0
	; Calling storevariable on generic assign expression
	sta leftmost_row_index
GetLeftmostEnemyOffset_while4035
GetLeftmostEnemyOffset_loopstart4039
	; Binary clause Simplified: LESS
	lda leftmost_row_index
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs GetLeftmostEnemyOffset_localfailed4118
GetLeftmostEnemyOffset_localsuccess4119: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda leftmost_found_flag
	; cmp #$00 ignored
	bne GetLeftmostEnemyOffset_localfailed4118
	jmp GetLeftmostEnemyOffset_ctb4036
GetLeftmostEnemyOffset_localfailed4118
	jmp GetLeftmostEnemyOffset_edblock4038
GetLeftmostEnemyOffset_ctb4036: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : leftmost_row_index
	lda leftmost_row_index
	asl
	asl
	clc
	adc leftmost_block_column
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta leftmost_block_index
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx leftmost_block_index
	lda block_enemies,x 
	; Calling storevariable on generic assign expression
	sta leftmost_enemies_byte
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	and #$3
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetLeftmostEnemyOffset_eblock4123
GetLeftmostEnemyOffset_ctb4122: ;Main true block ;keep 
	
; // Column-based indexing: check left to right
; // bits 0,1 set (left column: enemies 0,1)
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx leftmost_block_column ; optimized, look out for bugs
	; Load right hand side
	lda #$36
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	; Calling storevariable on generic assign expression
	sta leftmost_result_offset
	lda #$1
	; Calling storevariable on generic assign expression
	sta leftmost_found_flag
	jmp GetLeftmostEnemyOffset_edblock4124
GetLeftmostEnemyOffset_eblock4123
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda leftmost_enemies_byte
	and #$c
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetLeftmostEnemyOffset_eblock4167
GetLeftmostEnemyOffset_ctb4166: ;Main true block ;keep 
	
; // bits 2,3 set (middle column: enemies 2,3)
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx leftmost_block_column ; optimized, look out for bugs
	; Load right hand side
	lda #$36
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc #$12
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta leftmost_result_offset
	lda #$1
	; Calling storevariable on generic assign expression
	sta leftmost_found_flag
	jmp GetLeftmostEnemyOffset_edblock4168
GetLeftmostEnemyOffset_eblock4167
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda leftmost_enemies_byte
	and #$30
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetLeftmostEnemyOffset_edblock4190
GetLeftmostEnemyOffset_ctb4188: ;Main true block ;keep 
	
; // bits 4,5 set (right column: enemies 4,5)
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx leftmost_block_column ; optimized, look out for bugs
	; Load right hand side
	lda #$36
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc #$24
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta leftmost_result_offset
	lda #$1
	; Calling storevariable on generic assign expression
	sta leftmost_found_flag
GetLeftmostEnemyOffset_edblock4190
GetLeftmostEnemyOffset_edblock4168
GetLeftmostEnemyOffset_edblock4124
	; Test Inc dec D
	inc leftmost_row_index
	jmp GetLeftmostEnemyOffset_while4035
GetLeftmostEnemyOffset_edblock4038
GetLeftmostEnemyOffset_loopend4040
	; Binary clause Simplified: EQUALS
	lda leftmost_found_flag
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne GetLeftmostEnemyOffset_localfailed4203
	jmp GetLeftmostEnemyOffset_ctb4198
GetLeftmostEnemyOffset_localfailed4203: ;keep
	; ; logical OR, second chance
	; Binary clause Simplified: EQUALS
	lda leftmost_block_column
	; Compare with pure num / var optimization
	cmp #$3;keep
	bne GetLeftmostEnemyOffset_eblock4199
GetLeftmostEnemyOffset_ctb4198: ;Main true block ;keep 
	
; // Exit if found or if we've checked column 3
	lda #$1
	; Calling storevariable on generic assign expression
	sta leftmost_column_loop_done
	jmp GetLeftmostEnemyOffset_edblock4200
GetLeftmostEnemyOffset_eblock4199
	; Test Inc dec D
	inc leftmost_block_column
GetLeftmostEnemyOffset_edblock4200
	jmp GetLeftmostEnemyOffset_while3855
GetLeftmostEnemyOffset_edblock3858
GetLeftmostEnemyOffset_loopend3860
	lda leftmost_result_offset
	rts
end_procedure_GetLeftmostEnemyOffset
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateTick
	;    Procedure type : User-defined procedure
should_move_enemy	dc.b	0
rightmost_offset	dc.b	0
leftmost_offset	dc.b	0
right_edge	dc.b	0
left_edge	dc.b	0
UpdateTick_block4206
UpdateTick
	lda #$0
	; Calling storevariable on generic assign expression
	sta should_move_enemy
	; Binary clause Simplified: NOTEQUALS
	clc
	lda enemyMoveCounter
	; cmp #$00 ignored
	beq UpdateTick_localfailed4257
	jmp UpdateTick_ctb4208
UpdateTick_localfailed4257
	jmp UpdateTick_eblock4209
UpdateTick_ctb4208: ;Main true block ;keep 
	; Test Inc dec D
	dec enemyMoveCounter
	
; // Calculate actual enemy formation edges based on remaining enemies
	jsr GetRightmostEnemyOffset
	; Calling storevariable on generic assign expression
	sta rightmost_offset
	jsr GetLeftmostEnemyOffset
	; Calling storevariable on generic assign expression
	sta leftmost_offset
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_x
	clc
	adc rightmost_offset
	 ; end add / sub var with constant
	clc
	adc #$a
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta right_edge
	
; // +10 for double-width enemy (5 sprite pixels × 2)
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_x
	clc
	adc leftmost_offset
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta left_edge
	; Binary clause Simplified: GREATEREQUAL
	lda right_edge
	; Compare with pure num / var optimization
	cmp #$fe;keep
	bcc UpdateTick_eblock4261
UpdateTick_ctb4260: ;Main true block ;keep 
	
; // Check boundaries and switch direction
; // Right boundary: ensure rightmost enemy doesn't exceed screen edge (~254)
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_direction
	jmp UpdateTick_edblock4262
UpdateTick_eblock4261
	; Binary clause Simplified: LESS
	lda left_edge
	; Compare with pure num / var optimization
	cmp #$19;keep
	bcs UpdateTick_edblock4276
UpdateTick_ctb4274: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemy_direction
UpdateTick_edblock4276
UpdateTick_edblock4262
	; Binary clause Simplified: EQUALS
	lda enemyMoveCounter
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne UpdateTick_edblock4282
UpdateTick_ctb4280: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta should_move_enemy
UpdateTick_edblock4282
	jmp UpdateTick_edblock4210
UpdateTick_eblock4209
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$48
	sec
	sbc numberOfEnemies
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta enemyMoveCounter
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_animation_frame
	eor #$1
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta monster_animation_frame
	
; // Update sprite pointers for row 0 - rows 1 and 2 are updated in raster interrupt
; // Each row uses different sprite blocks: row 0 (3-10), row 1 (11-18), row 2 (19-26)
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemyRow
	jsr AnimateMonsters
	; Binary clause Simplified: GREATEREQUAL
	lda sequential_clear_counter
	; Compare with pure num / var optimization
	cmp #$1;keep
	bcc UpdateTick_edblock4289
UpdateTick_ctb4287: ;Main true block ;keep 
	
; // Row 0 uses sprites based on row parameter
; // Clear enemies based on ENEMIES_TO_CLEAR constant
	jsr ClearEnemyAtCounter
	; Test Inc dec D
	dec sequential_clear_counter
	;inc(numberOfEnemies);	
; //				inc(numberOfEnemies);
	; Binary clause Simplified: LESS
	lda numberOfEnemies
	; Compare with pure num / var optimization
	cmp #$47;keep
	bcs UpdateTick_edblock4301
UpdateTick_ctb4299: ;Main true block ;keep 
	
; // Speed up as enemies decrease
	; Test Inc dec D
	inc numberOfEnemies
UpdateTick_edblock4301
UpdateTick_edblock4289
	lda #$1
	; Calling storevariable on generic assign expression
	sta should_move_enemy
UpdateTick_edblock4210
	; Binary clause Simplified: NOTEQUALS
	clc
	lda should_move_enemy
	; cmp #$00 ignored
	beq UpdateTick_edblock4307
UpdateTick_ctb4305: ;Main true block ;keep 
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$48
	sec
	sbc numberOfEnemies
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs UpdateTick_eblock4352
UpdateTick_ctb4351: ;Main true block ;keep 
	; Binary clause Simplified: NOTEQUALS
	clc
	lda enemy_direction
	; cmp #$00 ignored
	beq UpdateTick_eblock4375
UpdateTick_ctb4374: ;Main true block ;keep 
	
; // At maximum speed (moving every 1-2 frames), move 2 pixels to match player speed
; // At slower speeds, move 1 pixel
	; Optimizer: a = a +/- b
	; Load16bitvariable : monster_base_x
	lda monster_base_x
	clc
	adc #$2
	sta monster_base_x
	jmp UpdateTick_edblock4376
UpdateTick_eblock4375
	; Optimizer: a = a +/- b
	; Load16bitvariable : monster_base_x
	lda monster_base_x
	sec
	sbc #$2
	sta monster_base_x
UpdateTick_edblock4376
	jmp UpdateTick_edblock4353
UpdateTick_eblock4352
	; Binary clause Simplified: NOTEQUALS
	clc
	lda enemy_direction
	; cmp #$00 ignored
	beq UpdateTick_eblock4384
UpdateTick_ctb4383: ;Main true block ;keep 
	; Test Inc dec D
	inc monster_base_x
	jmp UpdateTick_edblock4385
UpdateTick_eblock4384
	; Test Inc dec D
	dec monster_base_x
UpdateTick_edblock4385
UpdateTick_edblock4353
UpdateTick_edblock4307
	rts
end_procedure_UpdateTick
	; NodeProcedureDecl -1
	; ***********  Defining procedure : AnimateMonsters
	;    Procedure type : User-defined procedure
sprite_ptr_base	dc.b	0
current_sprite_ptr	dc.b	0
enemyRow	dc.b	0
AnimateMonsters_block4390
AnimateMonsters
	
; // Calculate the base sprite pointer once for this row
; // Row 0: blocks 0-3 (sprites 26-33)
; // Row 1: blocks 4-7 (sprites 34-41)
; // Row 2: blocks 8-11 (sprites 42-49)
	; Generic 16 bit op
	ldy #0
	lda monster_animation_frame
AnimateMonsters_rightvarInteger_var4393 = $54
	sta AnimateMonsters_rightvarInteger_var4393
	sty AnimateMonsters_rightvarInteger_var4393+1
	; Generic 16 bit op
	ldy #0
	lda #154
AnimateMonsters_rightvarInteger_var4396 = $56
	sta AnimateMonsters_rightvarInteger_var4396
	sty AnimateMonsters_rightvarInteger_var4396+1
	lda enemyRow
	asl
	asl
	asl
	; Low bit binop:
	clc
	adc AnimateMonsters_rightvarInteger_var4396
AnimateMonsters_wordAdd4394
	sta AnimateMonsters_rightvarInteger_var4396
	; High-bit binop
	tya
	adc AnimateMonsters_rightvarInteger_var4396+1
	tay
	lda AnimateMonsters_rightvarInteger_var4396
	; Low bit binop:
	clc
	adc AnimateMonsters_rightvarInteger_var4393
AnimateMonsters_wordAdd4391
	sta AnimateMonsters_rightvarInteger_var4393
	; High-bit binop
	tya
	adc AnimateMonsters_rightvarInteger_var4393+1
	tay
	lda AnimateMonsters_rightvarInteger_var4393
	; Calling storevariable on generic assign expression
	sta sprite_ptr_base
	
; // Set sprite locations using pre-calculated base + incremental additions
	; Calling storevariable on generic assign expression
	sta current_sprite_ptr
	; Set sprite location
	ldx #$1 ; optimized, look out for bugs
	sta $07f8 + $0,x
	; Optimizer: a = a +/- b
	; Load16bitvariable : current_sprite_ptr
	clc
	adc #$2
	sta current_sprite_ptr
	; Set sprite location
	ldx #$2 ; optimized, look out for bugs
	sta $07f8 + $0,x
	; Optimizer: a = a +/- b
	; Load16bitvariable : current_sprite_ptr
	clc
	adc #$2
	sta current_sprite_ptr
	; Set sprite location
	ldx #$3 ; optimized, look out for bugs
	sta $07f8 + $0,x
	; Optimizer: a = a +/- b
	; Load16bitvariable : current_sprite_ptr
	clc
	adc #$2
	sta current_sprite_ptr
	; Set sprite location
	ldx #$4 ; optimized, look out for bugs
	sta $07f8 + $0,x
	rts
end_procedure_AnimateMonsters
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateMonsters
	;    Procedure type : User-defined procedure
y_position	dc.b	0
x_position	dc.b	0
rowOffset	dc.b	0
UpdateMonsters_block4397
UpdateMonsters
	
; // Pre-calculate Y position to avoid repeated additions
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc rowOffset
	 ; end add / sub var with constant
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta y_position
	
; // Update sprites using incremental X positions instead of multiplications
	lda monster_base_x
	; Calling storevariable on generic assign expression
	sta x_position
	; Setting sprite position
	; isi-pisi: value is constant
	ldx #2
	sta $D000,x
UpdateMonsters_spritepos4398
	lda $D010
	and #%11111101
	sta $D010
UpdateMonsters_spriteposcontinue4399
	inx
	txa
	tay
	lda y_position
	sta $D000,y
	; Optimizer: a = a +/- b
	; Load16bitvariable : x_position
	lda x_position
	clc
	adc #$36
	sta x_position
	; Setting sprite position
	; isi-pisi: value is constant
	ldx #4
	sta $D000,x
UpdateMonsters_spritepos4400
	lda $D010
	and #%11111011
	sta $D010
UpdateMonsters_spriteposcontinue4401
	inx
	txa
	tay
	lda y_position
	sta $D000,y
	; Optimizer: a = a +/- b
	; Load16bitvariable : x_position
	lda x_position
	clc
	adc #$36
	sta x_position
	; Setting sprite position
	; isi-pisi: value is constant
	ldx #6
	sta $D000,x
UpdateMonsters_spritepos4402
	lda $D010
	and #%11110111
	sta $D010
UpdateMonsters_spriteposcontinue4403
	inx
	txa
	tay
	lda y_position
	sta $D000,y
	; Optimizer: a = a +/- b
	; Load16bitvariable : x_position
	lda x_position
	clc
	adc #$36
	sta x_position
	; Setting sprite position
	; isi-pisi: value is constant
	ldx #8
	sta $D000,x
UpdateMonsters_spritepos4404
	lda $D010
	and #%11101111
	sta $D010
UpdateMonsters_spriteposcontinue4405
	inx
	txa
	tay
	lda y_position
	sta $D000,y
	rts
end_procedure_UpdateMonsters
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ClearMonster
	;    Procedure type : User-defined procedure
sprite_data_ptr	= $24
frame1_sprite_index	dc.b	0
frame2_sprite_index	dc.b	0
sprite_offset_start	dc.b	0
enemy_horizontal_offset	dc.b	0
enemy_vertical_offset	dc.b	0
sprite_base_address	dc.w	0
blockIndex	dc.b	0
numBlocks	dc.b	0
enemyIndex	dc.b	0
ClearMonster_block4406
ClearMonster
	
; // Calculate sprite indices for both animation frames
; // Each block has 2 sprites (animation frames)
; // Block 0 = sprites 26-27, Block 1 = sprites 28-29, etc.
	; 8 bit binop
	; Add/sub where right value is constant number
	lda blockIndex
	asl
	clc
	adc #$1a
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta frame1_sprite_index
	
; // First animation frame
	; 8 bit binop
	; Add/sub where right value is constant number
	clc
	adc #$1
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta frame2_sprite_index
	
; // Second animation frame
; // Each block contains 6 enemies in a 3x2 grid (column-based indexing):
; // Column 0: Enemy 0(top), 1(bottom)
; // Column 1: Enemy 2(top), 3(bottom)
; // Column 2: Enemy 4(top), 5(bottom)
; // Each enemy is 5 pixels wide × 8 pixels tall
; // Calculate horizontal offset - which byte column (0, 1, or 2)
; // Enemy index: 0,1=col0, 2,3=col1, 4,5=col2
	lda enemyIndex
	lsr
	; Calling storevariable on generic assign expression
	sta enemy_horizontal_offset
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda enemyIndex
	and #$1
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq ClearMonster_eblock4409
ClearMonster_ctb4408: ;Main true block ;keep 
	
; // Divide by 2 to get column
; // Calculate vertical offset
; // Even indices (0,2,4): top row at offset 0
; // Odd indices (1,3,5): bottom row at offset 13 rows
; // 13 rows * 3 bytes = 39
	lda #$27
	; Calling storevariable on generic assign expression
	sta enemy_vertical_offset
	jmp ClearMonster_edblock4410
ClearMonster_eblock4409
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_vertical_offset
ClearMonster_edblock4410
	
; // Total offset within the 64-byte sprite
	; 8 bit binop
	; Add/sub where right value is constant number
	lda enemy_horizontal_offset
	clc
	adc enemy_vertical_offset
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta sprite_offset_start
	
; // Clear first animation frame (8 pixel rows)
	ldy #0 ; Fake 16 bit
	lda frame1_sprite_index
	; Calling storevariable on generic assign expression
	; Casting from byte to integer
	sta sprite_base_address
	sty sprite_base_address+1
	ldy sprite_base_address+1 ;keep
ClearMonster_tempVarShift_var4415 = $54
	sta ClearMonster_tempVarShift_var4415
	sty ClearMonster_tempVarShift_var4415+1
	; COUNT : 6
		asl ClearMonster_tempVarShift_var4415+0 ;keep
	rol ClearMonster_tempVarShift_var4415+1 ;keep

		asl ClearMonster_tempVarShift_var4415+0 ;keep
	rol ClearMonster_tempVarShift_var4415+1 ;keep

		asl ClearMonster_tempVarShift_var4415+0 ;keep
	rol ClearMonster_tempVarShift_var4415+1 ;keep

		asl ClearMonster_tempVarShift_var4415+0 ;keep
	rol ClearMonster_tempVarShift_var4415+1 ;keep

		asl ClearMonster_tempVarShift_var4415+0 ;keep
	rol ClearMonster_tempVarShift_var4415+1 ;keep

		asl ClearMonster_tempVarShift_var4415+0 ;keep
	rol ClearMonster_tempVarShift_var4415+1 ;keep

	lda ClearMonster_tempVarShift_var4415
	ldy ClearMonster_tempVarShift_var4415+1
	; Calling storevariable on generic assign expression
	sta sprite_base_address
	sty sprite_base_address+1
	
; // * 64
	; Generic 16 bit op
	ldy #0
	ldx #0 ; Fake 24 bit
	lda sprite_offset_start
ClearMonster_rightvarInteger_var4418 = $54
	sta ClearMonster_rightvarInteger_var4418
	sty ClearMonster_rightvarInteger_var4418+1
	; Generic 16 bit op
	ldy sprite_base_address+1 ;keep
	lda sprite_base_address
ClearMonster_rightvarInteger_var4421 = $56
	sta ClearMonster_rightvarInteger_var4421
	sty ClearMonster_rightvarInteger_var4421+1
	; Integer constant assigning
	; Load16bitvariable : #$2000
	ldy #$20
	lda #$00
	; Low bit binop:
	clc
	adc ClearMonster_rightvarInteger_var4421
ClearMonster_wordAdd4419
	sta ClearMonster_rightvarInteger_var4421
	; High-bit binop
	tya
	adc ClearMonster_rightvarInteger_var4421+1
	tay
	lda ClearMonster_rightvarInteger_var4421
	; Low bit binop:
	clc
	adc ClearMonster_rightvarInteger_var4418
ClearMonster_wordAdd4416
	sta ClearMonster_rightvarInteger_var4418
	; High-bit binop
	tya
	adc ClearMonster_rightvarInteger_var4418+1
	tay
	lda ClearMonster_rightvarInteger_var4418
	sta sprite_data_ptr
	sty sprite_data_ptr+1
	
; // Unrolled loop for 8 pixel rows - faster than loop overhead
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4422
	inc sprite_data_ptr+1
ClearMonster_WordAdd4422
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4423
	inc sprite_data_ptr+1
ClearMonster_WordAdd4423
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4424
	inc sprite_data_ptr+1
ClearMonster_WordAdd4424
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4425
	inc sprite_data_ptr+1
ClearMonster_WordAdd4425
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4426
	inc sprite_data_ptr+1
ClearMonster_WordAdd4426
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4427
	inc sprite_data_ptr+1
ClearMonster_WordAdd4427
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4428
	inc sprite_data_ptr+1
ClearMonster_WordAdd4428
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	
; // Clear second animation frame (8 pixel rows)
	ldy #0 ; Fake 16 bit
	lda frame2_sprite_index
	; Calling storevariable on generic assign expression
	; Casting from byte to integer
	sta sprite_base_address
	sty sprite_base_address+1
	ldy sprite_base_address+1 ;keep
ClearMonster_tempVarShift_var4429 = $54
	sta ClearMonster_tempVarShift_var4429
	sty ClearMonster_tempVarShift_var4429+1
	; COUNT : 6
		asl ClearMonster_tempVarShift_var4429+0 ;keep
	rol ClearMonster_tempVarShift_var4429+1 ;keep

		asl ClearMonster_tempVarShift_var4429+0 ;keep
	rol ClearMonster_tempVarShift_var4429+1 ;keep

		asl ClearMonster_tempVarShift_var4429+0 ;keep
	rol ClearMonster_tempVarShift_var4429+1 ;keep

		asl ClearMonster_tempVarShift_var4429+0 ;keep
	rol ClearMonster_tempVarShift_var4429+1 ;keep

		asl ClearMonster_tempVarShift_var4429+0 ;keep
	rol ClearMonster_tempVarShift_var4429+1 ;keep

		asl ClearMonster_tempVarShift_var4429+0 ;keep
	rol ClearMonster_tempVarShift_var4429+1 ;keep

	lda ClearMonster_tempVarShift_var4429
	ldy ClearMonster_tempVarShift_var4429+1
	; Calling storevariable on generic assign expression
	sta sprite_base_address
	sty sprite_base_address+1
	
; // * 64
	; Generic 16 bit op
	ldy #0
	ldx #0 ; Fake 24 bit
	lda sprite_offset_start
ClearMonster_rightvarInteger_var4432 = $54
	sta ClearMonster_rightvarInteger_var4432
	sty ClearMonster_rightvarInteger_var4432+1
	; Generic 16 bit op
	ldy sprite_base_address+1 ;keep
	lda sprite_base_address
ClearMonster_rightvarInteger_var4435 = $56
	sta ClearMonster_rightvarInteger_var4435
	sty ClearMonster_rightvarInteger_var4435+1
	; Integer constant assigning
	; Load16bitvariable : #$2000
	ldy #$20
	lda #$00
	; Low bit binop:
	clc
	adc ClearMonster_rightvarInteger_var4435
ClearMonster_wordAdd4433
	sta ClearMonster_rightvarInteger_var4435
	; High-bit binop
	tya
	adc ClearMonster_rightvarInteger_var4435+1
	tay
	lda ClearMonster_rightvarInteger_var4435
	; Low bit binop:
	clc
	adc ClearMonster_rightvarInteger_var4432
ClearMonster_wordAdd4430
	sta ClearMonster_rightvarInteger_var4432
	; High-bit binop
	tya
	adc ClearMonster_rightvarInteger_var4432+1
	tay
	lda ClearMonster_rightvarInteger_var4432
	sta sprite_data_ptr
	sty sprite_data_ptr+1
	
; // Unrolled loop for 8 pixel rows
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4436
	inc sprite_data_ptr+1
ClearMonster_WordAdd4436
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4437
	inc sprite_data_ptr+1
ClearMonster_WordAdd4437
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4438
	inc sprite_data_ptr+1
ClearMonster_WordAdd4438
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4439
	inc sprite_data_ptr+1
ClearMonster_WordAdd4439
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4440
	inc sprite_data_ptr+1
ClearMonster_WordAdd4440
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4441
	inc sprite_data_ptr+1
ClearMonster_WordAdd4441
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	lda sprite_data_ptr
	clc
	adc #$03
	sta sprite_data_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd4442
	inc sprite_data_ptr+1
ClearMonster_WordAdd4442
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	rts
end_procedure_ClearMonster
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MakeMonsters
	;    Procedure type : User-defined procedure
monster_sprite_color	dc.b	$03
MakeMonsters_block4443
MakeMonsters
	lda #$52
	; Calling storevariable on generic assign expression
	sta monster_base_y
	lda #$20
	; Calling storevariable on generic assign expression
	sta monster_base_x
	lda monster_sprite_color
	; Calling storevariable on generic assign expression
	sta $D027+$0
	
; // Set sprite colors
	; Calling storevariable on generic assign expression
	sta $D027+$1
	; Calling storevariable on generic assign expression
	sta $D027+$2
	; Calling storevariable on generic assign expression
	sta $D027+$3
	; Calling storevariable on generic assign expression
	sta $D027+$4
	
; // Enable all monster sprites
	; Toggle bit with constant
	lda $d015
	ora #%10
	sta $d015
	ldx #$1 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit4444
	cpx #0
	beq MakeMonsters_shiftbitdone4445
	asl
	dex
	jmp MakeMonsters_shiftbit4444
MakeMonsters_shiftbitdone4445
MakeMonsters_bitmask_var4446 = $54
	sta MakeMonsters_bitmask_var4446
	lda $d015
	ora MakeMonsters_bitmask_var4446
	sta $d015
	; Toggle bit with constant
	ora #%100
	sta $d015
	ldx #$2 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit4447
	cpx #0
	beq MakeMonsters_shiftbitdone4448
	asl
	dex
	jmp MakeMonsters_shiftbit4447
MakeMonsters_shiftbitdone4448
MakeMonsters_bitmask_var4449 = $54
	sta MakeMonsters_bitmask_var4449
	lda $d015
	ora MakeMonsters_bitmask_var4449
	sta $d015
	; Toggle bit with constant
	ora #%1000
	sta $d015
	ldx #$3 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit4450
	cpx #0
	beq MakeMonsters_shiftbitdone4451
	asl
	dex
	jmp MakeMonsters_shiftbit4450
MakeMonsters_shiftbitdone4451
MakeMonsters_bitmask_var4452 = $54
	sta MakeMonsters_bitmask_var4452
	lda $d015
	ora MakeMonsters_bitmask_var4452
	sta $d015
	; Toggle bit with constant
	ora #%10000
	sta $d015
	ldx #$4 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit4453
	cpx #0
	beq MakeMonsters_shiftbitdone4454
	asl
	dex
	jmp MakeMonsters_shiftbit4453
MakeMonsters_shiftbitdone4454
MakeMonsters_bitmask_var4455 = $54
	sta MakeMonsters_bitmask_var4455
	lda $d015
	ora MakeMonsters_bitmask_var4455
	sta $d015
	
; // Enable sprite stretching for wider monsters
	; Toggle bit with constant
	lda $d01d
	ora #%10
	sta $d01d
	ldx #$1 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit4456
	cpx #0
	beq MakeMonsters_shiftbitdone4457
	asl
	dex
	jmp MakeMonsters_shiftbit4456
MakeMonsters_shiftbitdone4457
MakeMonsters_bitmask_var4458 = $54
	sta MakeMonsters_bitmask_var4458
	lda $d01d
	ora MakeMonsters_bitmask_var4458
	sta $d01d
	; Toggle bit with constant
	ora #%100
	sta $d01d
	ldx #$2 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit4459
	cpx #0
	beq MakeMonsters_shiftbitdone4460
	asl
	dex
	jmp MakeMonsters_shiftbit4459
MakeMonsters_shiftbitdone4460
MakeMonsters_bitmask_var4461 = $54
	sta MakeMonsters_bitmask_var4461
	lda $d01d
	ora MakeMonsters_bitmask_var4461
	sta $d01d
	; Toggle bit with constant
	ora #%1000
	sta $d01d
	ldx #$3 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit4462
	cpx #0
	beq MakeMonsters_shiftbitdone4463
	asl
	dex
	jmp MakeMonsters_shiftbit4462
MakeMonsters_shiftbitdone4463
MakeMonsters_bitmask_var4464 = $54
	sta MakeMonsters_bitmask_var4464
	lda $d01d
	ora MakeMonsters_bitmask_var4464
	sta $d01d
	; Toggle bit with constant
	ora #%10000
	sta $d01d
	ldx #$4 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit4465
	cpx #0
	beq MakeMonsters_shiftbitdone4466
	asl
	dex
	jmp MakeMonsters_shiftbit4465
MakeMonsters_shiftbitdone4466
MakeMonsters_bitmask_var4467 = $54
	sta MakeMonsters_bitmask_var4467
	lda $d01d
	ora MakeMonsters_bitmask_var4467
	sta $d01d
	rts
end_procedure_MakeMonsters
	
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Main raster interrupt routines.
; // ---------------------------------------------------------------------------------------------------------------------------------
; // This interrupt is triggered one time pr raster cycle
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterRow1
	;    Procedure type : User-defined procedure
MainRasterRow1
	jsr ShowBullet
	
; //CheckBulletCollision();
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	
; //border_debug_color := peek(^$D01E, 0);
; //SCREEN_BG_COL := border_debug_color;
; //DisplayScore();
; // Clear sprite collision registers to remove garbage data
; //asm(" lda $D01E");
; //asm(" lda $D01F");
; // Update bullet position
	jsr UpdatePlayerBullet
	
; // Show bullet sprite in this region
; //if player_bullet_active <> 0 thenif player_bullet_active <> 0 then
; //	begin
; //		ShowBullet();
; //		
; //SCREEN_BG_COL := border_debug_color;
; //	end;
; //SCREEN_BG_COL:=BLACK;  
; // Do heavy work at start of frame where we have most time
; // Increment scoreScore += SCORE_INCREMENT;
; //	if (Score >= 10000) then begin
; //		Score := Score - 10000;
; //		Score2 += 1;
; //	end;
; // Heavy game logic - done here at top of frame
	jsr UpdateTick
	
; // Update first row of monsters
	lda #$0
	; Calling storevariable on generic assign expression
	sta rowOffset
	jsr UpdateMonsters
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemyRow
	jsr AnimateMonsters
	
; // Prepare sprites for row 1
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$61
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow2
	sta $fffe
	lda #>MainRasterRow2
	sta $ffff
	
; // Play music here - plenty of time after monsters
	jsr $1003
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRasterRow1
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterRow2
	;    Procedure type : User-defined procedure
MainRasterRow2
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	; Binary clause Simplified: EQUALS
	lda debug_enable_bgcol
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterRow2_edblock4473
MainRasterRow2_ctb4471: ;Main true block ;keep 
	lda #$6
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterRow2_edblock4473
	
; //ShowBullet();
; //border_debug_color := peek(^$D01E, 0);
; //SCREEN_BG_COL := border_debug_color;
; //DisplayScore();if player_bullet_active <> 0 then
; //	begin
; //		ShowBullet();
; //		
; //SCREEN_BG_COL := border_debug_color;
; //	end;
	lda #$1a
	; Calling storevariable on generic assign expression
	sta rowOffset
	jsr UpdateMonsters
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemyRow
	jsr AnimateMonsters
	
; // Prepare sprites for row 2
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$7e
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow3
	sta $fffe
	lda #>MainRasterRow3
	sta $ffff
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRasterRow2
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterRow3
	;    Procedure type : User-defined procedure
MainRasterRow3
	; Binary clause Simplified: EQUALS
	lda debug_enable_bgcol
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterRow3_edblock4480
MainRasterRow3_ctb4478: ;Main true block ;keep 
	
; //BorderDebug();
	lda #$5
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterRow3_edblock4480
	
; //ShowBullet();
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	
; //DisplayScore();if player_bullet_active <> 0 then
; //	begin
; //		showBullet();
; //		
; //SCREEN_BG_COL := border_debug_color;
; //	end;
	lda #$34
	; Calling storevariable on generic assign expression
	sta rowOffset
	jsr UpdateMonsters
	lda #$2
	; Calling storevariable on generic assign expression
	sta enemyRow
	jsr AnimateMonsters
	
; // Prepare sprites for row 3
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$9b
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterJoystick
	sta $fffe
	lda #>MainRasterJoystick
	sta $ffff
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRasterRow3
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterJoystick
	;    Procedure type : User-defined procedure
MainRasterJoystick
	; Binary clause Simplified: EQUALS
	lda debug_enable_bgcol
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterJoystick_edblock4487
MainRasterJoystick_ctb4485: ;Main true block ;keep 
	lda #$2
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterJoystick_edblock4487
	
; //BorderDebug();if player_bullet_active <> 0 then
; //	begin
; //		ShowBullet();
; //		
; //SCREEN_BG_COL := border_debug_color;
; //	end;
; //ShowBullet();
; //DisplayScore();if player_bullet_active <> 0 then
; //	begin
; //		ShowBullet();
; //		
; //SCREEN_BG_COL := border_debug_color;
; //	end;
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	; Binary clause Simplified: EQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterJoystick_edblock4493
MainRasterJoystick_ctb4491: ;Main true block ;keep 
	
; // Check collisions AFTER all sprite rows have been displayed
; // Only check when bullet is actively moving (not exploding)
	jsr CheckBulletCollision
MainRasterJoystick_edblock4493
	
; // Lightweight joystick and sprite update only
; //Memory::Fill(#joystickup,0,5);
	lda #%11111111  ; CIA#1 port A = outputs 
	sta $dc03             
	lda #%00000000  ; CIA#1 port B = inputs
	sta $dc02             
	lda $dc00
	sta $50
	jsr callJoystick
	; Binary clause Simplified: EQUALS
	lda joystickbutton
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterJoystick_eblock4498
MainRasterJoystick_ctb4497: ;Main true block ;keep 
	
; //inc(border_debug_color);
	; Binary clause Simplified: EQUALS
	clc
	lda previous_fire_state
	; cmp #$00 ignored
	bne MainRasterJoystick_edblock4513
MainRasterJoystick_localsuccess4515: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda player_bullet_active
	; cmp #$00 ignored
	bne MainRasterJoystick_edblock4513
MainRasterJoystick_ctb4511: ;Main true block ;keep 
	
; //UpdateSprite();
; // Check fire button with debounce (only fire on button press, not hold)	
	jsr FirePlayerBullet
MainRasterJoystick_edblock4513
	lda #$1
	; Calling storevariable on generic assign expression
	sta previous_fire_state
	jmp MainRasterJoystick_edblock4499
MainRasterJoystick_eblock4498
	lda #$0
	; Calling storevariable on generic assign expression
	sta previous_fire_state
MainRasterJoystick_edblock4499
	
; //poke(^$D019, 0, 0);
	; RasterIRQ : Hook a procedure
	lda #$e0
	sta $d012
	lda #<MainRasterPlayer
	sta $fffe
	lda #>MainRasterPlayer
	sta $ffff
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRasterJoystick
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterPlayer
	;    Procedure type : User-defined procedure
MainRasterPlayer
	jsr UpdateSprite
	; Binary clause Simplified: EQUALS
	lda debug_enable_bgcol
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterPlayer_edblock4522
MainRasterPlayer_ctb4520: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterPlayer_edblock4522
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	
; //border_debug_color := peek($D01E, 0);
; //SCREEN_BG_COL := border_debug_color;
; //asm(" lda $D01E");
; //asm(" lda $D01F");
; //border_debug_color := peek($D01E, 0);
; //SCREEN_BG_COL := border_debug_color;
; //SCREEN_BG_COL := border_debug_color;
; // Switch sprite 0 from bullet back to player
	; Set sprite location
	ldx #$0 ; optimized, look out for bugs
	lda #$80
	sta $07f8 + $0,x
	
; // Player sprite data
	; Setting sprite position
	; isi-pisi: value is constant
	lda player_sprite_x
	ldx #0
	sta $D000,x
MainRasterPlayer_spritepos4525
	lda $D010
	and #%11111110
	sta $D010
MainRasterPlayer_spriteposcontinue4526
	inx
	txa
	tay
	lda player_sprite_y
	sta $D000,y
	
; // Player position
; //togglebit(sprite_bitmask, useSprite, 1);  
; // Ensure sprite is enabled for player
	; RasterIRQ : Hook a procedure
	; Integer constant assigning
	; Load16bitvariable : #$107
	lda #$07
	sta $d012
	lda #<MainRasterStarfield
	sta $fffe
	lda #>MainRasterStarfield
	sta $ffff
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRasterPlayer
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterStarfield
	;    Procedure type : User-defined procedure
MainRasterStarfield
	
; //border_debug_color := peek($D01E, 0);
; //SCREEN_BG_COL := border_debug_color;
; //DisplayScore();
	; Test Inc dec D
	inc StarField_RasterCount
	jsr StarField_DoStarfield
	sei
	; Poke
	; Optimization: shift is zero
	lda #$0
	sta $d019
	; RasterIRQ : Hook a procedure
	sta $d012
	lda #<MainRasterRow1
	sta $fffe
	lda #>MainRasterRow1
	sta $ffff
	rti
end_procedure_MainRasterStarfield
block1
main_block_begin_
	
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Main program loop. Turn CIA interrupts off, copy the character set from ROM into RAM and tell the machine to look at CharSetLoc
; // for its character set, initialise the pointers and start the raster chain off.
; // ---------------------------------------------------------------------------------------------------------------------------------
	jsr MakeSprites
	jsr initializeMonsters
	
; //ClearMonster();
	jsr MakeMonsters
	; initsid
	lda #0
	tax
	tay
	jsr $1000
	; Disable interrupts
	ldy #$7f    ; $7f = %01111111
	sty $dc0d   ; Turn off CIAs Timer interrupts
	sty $dd0d   ; Turn off CIAs Timer interrupts
	; Set Memory Config
	lda $01
	and #%11111000
	ora #%101
	sta $01
	; Disable interrupts
	sty $dc0d   ; Turn off CIAs Timer interrupts
	sty $dd0d   ; Turn off CIAs Timer interrupts
	; Assigning memory location
	lda #$0
	; Calling storevariable on generic assign expression
	sta $d020
	; Assigning memory location
	; Calling storevariable on generic assign expression
	sta $d021
 lda $D01F
	
; // Clear sprite collision registers to remove garbage data
	jsr StarField_CreateStarScreen
	lda #$d0
	ldx #$31
	sta StarField_StarfieldPtr
	stx StarField_StarfieldPtr+1
	lda #$98
	ldx #$32
	sta StarField_StarfieldPtr2
	stx StarField_StarfieldPtr2+1
	lda #$40
	sta StarField_StarfieldPtr3
	stx StarField_StarfieldPtr3+1
	lda #$e0
	sta StarField_StarfieldPtr4
	stx StarField_StarfieldPtr4+1
	
; // IO area visible at $D000-$DFFF, RAM visible at $A000-$BFFF (NO BASIC) and RAM visible at $E000-$FFFF (NO KERNAL). 
; // This is the typical memory configuration for demo/game development. 
	; Set Memory Config
	lda $01
	and #%11111000
	ora #%101
	sta $01
	; Enable raster IRQ
	lda $d01a
	ora #$01
	sta $d01a
	lda #$1B
	sta $d011
	jsr DisplayText
	; RasterIRQ : Hook a procedure
	lda #$0
	sta $d012
	lda #<MainRasterRow1
	sta $fffe
	lda #>MainRasterRow1
	sta $ffff
	asl $d019
	cli
	jmp * ; loop like (�/%
main_block_end_
	; End of program
	; Ending memory block at $5810
DisplayText_stringassignstr3363		dc.b	" "
	dc.b	0
DisplayText_stringassignstr3365		dc.b	"  SCORE(1)"
	dc.b	0
DisplayText_stringassignstr3367		dc.b	"  HI-SCORE"
	dc.b	0
DisplayText_stringassignstr3369		dc.b	"      1740"
	dc.b	0
DisplayText_stringassignstr3371		dc.b	"  SCORE(2)"
	dc.b	0
DisplayText_stringassignstr3373		dc.b	"      1740"
	dc.b	0
DisplayText_stringassignstr3375		dc.b	"lmn"
	dc.b	0
DisplayText_stringassignstr3377		dc.b	"opq"
	dc.b	0
DisplayText_stringassignstr3379		dc.b	"rst"
	dc.b	0
DisplayText_stringassignstr3381		dc.b	"uvw"
	dc.b	0
DisplayText_stringassignstr3383		dc.b	"xyz"
	dc.b	0
DisplayText_stringassignstr3385		dc.b	"!#¤"
	dc.b	0
DisplayText_stringassignstr3387		dc.b	"¤%&"
	dc.b	0
DisplayText_stringassignstr3389		dc.b	"/+*"
	dc.b	0
DisplayText_stringassignstr3391		dc.b	"ooooooooooooooooooooooooooooo"
	dc.b	0
EndBlock5810:

