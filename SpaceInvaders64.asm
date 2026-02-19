
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
enemyMoveCounter	dc.b	$48
enemy_direction	dc.b	$01
numberOfEnemies	dc.b	$00
monster_vertical_adjustment	dc.b	$39
sequential_clear_counter	dc.b	$47
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
monster_animation_frame	dc.b	0
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterJoystick
	;    Procedure type : User-defined procedure
	rti
end_procedure_MainRasterJoystick
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
	; ***********  Defining procedure : ClearMonster
	;    Procedure type : User-defined procedure
sprite_data_ptr	= $24
frame1_sprite_index	dc.b	0
frame2_sprite_index	dc.b	0
sprite_offset_start	dc.b	0
enemy_horizontal_offset	dc.b	0
enemy_vertical_offset	dc.b	0
sprite_base_address	dc.w	0
enemy_mask	dc.b	0
was_alive	dc.b	0
blockIndex	dc.b	0
enemyIndex	dc.b	0
ClearMonster_block283
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
	beq ClearMonster_eblock286
ClearMonster_ctb285: ;Main true block ;keep 
	
; // Divide by 2 to get column
; // Calculate vertical offset
; // Even indices (0,2,4): top row at offset 0
; // Odd indices (1,3,5): bottom row at offset 13 rows
; // 13 rows * 3 bytes = 39
	lda #$27
	; Calling storevariable on generic assign expression
	sta enemy_vertical_offset
	jmp ClearMonster_edblock287
ClearMonster_eblock286
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_vertical_offset
ClearMonster_edblock287
	
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
ClearMonster_tempVarShift_var292 = $54
	sta ClearMonster_tempVarShift_var292
	sty ClearMonster_tempVarShift_var292+1
	; COUNT : 6
		asl ClearMonster_tempVarShift_var292+0 ;keep
	rol ClearMonster_tempVarShift_var292+1 ;keep

		asl ClearMonster_tempVarShift_var292+0 ;keep
	rol ClearMonster_tempVarShift_var292+1 ;keep

		asl ClearMonster_tempVarShift_var292+0 ;keep
	rol ClearMonster_tempVarShift_var292+1 ;keep

		asl ClearMonster_tempVarShift_var292+0 ;keep
	rol ClearMonster_tempVarShift_var292+1 ;keep

		asl ClearMonster_tempVarShift_var292+0 ;keep
	rol ClearMonster_tempVarShift_var292+1 ;keep

		asl ClearMonster_tempVarShift_var292+0 ;keep
	rol ClearMonster_tempVarShift_var292+1 ;keep

	lda ClearMonster_tempVarShift_var292
	ldy ClearMonster_tempVarShift_var292+1
	; Calling storevariable on generic assign expression
	sta sprite_base_address
	sty sprite_base_address+1
	
; // * 64
	; Generic 16 bit op
	ldy #0
	ldx #0 ; Fake 24 bit
	lda sprite_offset_start
ClearMonster_rightvarInteger_var295 = $54
	sta ClearMonster_rightvarInteger_var295
	sty ClearMonster_rightvarInteger_var295+1
	; Generic 16 bit op
	ldy sprite_base_address+1 ;keep
	lda sprite_base_address
ClearMonster_rightvarInteger_var298 = $56
	sta ClearMonster_rightvarInteger_var298
	sty ClearMonster_rightvarInteger_var298+1
	; Integer constant assigning
	; Load16bitvariable : #$2000
	ldy #$20
	lda #$00
	; Low bit binop:
	clc
	adc ClearMonster_rightvarInteger_var298
ClearMonster_wordAdd296
	sta ClearMonster_rightvarInteger_var298
	; High-bit binop
	tya
	adc ClearMonster_rightvarInteger_var298+1
	tay
	lda ClearMonster_rightvarInteger_var298
	; Low bit binop:
	clc
	adc ClearMonster_rightvarInteger_var295
ClearMonster_wordAdd293
	sta ClearMonster_rightvarInteger_var295
	; High-bit binop
	tya
	adc ClearMonster_rightvarInteger_var295+1
	tay
	lda ClearMonster_rightvarInteger_var295
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
	bcc ClearMonster_WordAdd299
	inc sprite_data_ptr+1
ClearMonster_WordAdd299
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
	bcc ClearMonster_WordAdd300
	inc sprite_data_ptr+1
ClearMonster_WordAdd300
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
	bcc ClearMonster_WordAdd301
	inc sprite_data_ptr+1
ClearMonster_WordAdd301
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
	bcc ClearMonster_WordAdd302
	inc sprite_data_ptr+1
ClearMonster_WordAdd302
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
	bcc ClearMonster_WordAdd303
	inc sprite_data_ptr+1
ClearMonster_WordAdd303
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
	bcc ClearMonster_WordAdd304
	inc sprite_data_ptr+1
ClearMonster_WordAdd304
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
	bcc ClearMonster_WordAdd305
	inc sprite_data_ptr+1
ClearMonster_WordAdd305
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
ClearMonster_tempVarShift_var306 = $54
	sta ClearMonster_tempVarShift_var306
	sty ClearMonster_tempVarShift_var306+1
	; COUNT : 6
		asl ClearMonster_tempVarShift_var306+0 ;keep
	rol ClearMonster_tempVarShift_var306+1 ;keep

		asl ClearMonster_tempVarShift_var306+0 ;keep
	rol ClearMonster_tempVarShift_var306+1 ;keep

		asl ClearMonster_tempVarShift_var306+0 ;keep
	rol ClearMonster_tempVarShift_var306+1 ;keep

		asl ClearMonster_tempVarShift_var306+0 ;keep
	rol ClearMonster_tempVarShift_var306+1 ;keep

		asl ClearMonster_tempVarShift_var306+0 ;keep
	rol ClearMonster_tempVarShift_var306+1 ;keep

		asl ClearMonster_tempVarShift_var306+0 ;keep
	rol ClearMonster_tempVarShift_var306+1 ;keep

	lda ClearMonster_tempVarShift_var306
	ldy ClearMonster_tempVarShift_var306+1
	; Calling storevariable on generic assign expression
	sta sprite_base_address
	sty sprite_base_address+1
	
; // * 64
	; Generic 16 bit op
	ldy #0
	ldx #0 ; Fake 24 bit
	lda sprite_offset_start
ClearMonster_rightvarInteger_var309 = $54
	sta ClearMonster_rightvarInteger_var309
	sty ClearMonster_rightvarInteger_var309+1
	; Generic 16 bit op
	ldy sprite_base_address+1 ;keep
	lda sprite_base_address
ClearMonster_rightvarInteger_var312 = $56
	sta ClearMonster_rightvarInteger_var312
	sty ClearMonster_rightvarInteger_var312+1
	; Integer constant assigning
	; Load16bitvariable : #$2000
	ldy #$20
	lda #$00
	; Low bit binop:
	clc
	adc ClearMonster_rightvarInteger_var312
ClearMonster_wordAdd310
	sta ClearMonster_rightvarInteger_var312
	; High-bit binop
	tya
	adc ClearMonster_rightvarInteger_var312+1
	tay
	lda ClearMonster_rightvarInteger_var312
	; Low bit binop:
	clc
	adc ClearMonster_rightvarInteger_var309
ClearMonster_wordAdd307
	sta ClearMonster_rightvarInteger_var309
	; High-bit binop
	tya
	adc ClearMonster_rightvarInteger_var309+1
	tay
	lda ClearMonster_rightvarInteger_var309
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
	bcc ClearMonster_WordAdd313
	inc sprite_data_ptr+1
ClearMonster_WordAdd313
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
	bcc ClearMonster_WordAdd314
	inc sprite_data_ptr+1
ClearMonster_WordAdd314
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
	bcc ClearMonster_WordAdd315
	inc sprite_data_ptr+1
ClearMonster_WordAdd315
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
	bcc ClearMonster_WordAdd316
	inc sprite_data_ptr+1
ClearMonster_WordAdd316
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
	bcc ClearMonster_WordAdd317
	inc sprite_data_ptr+1
ClearMonster_WordAdd317
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
	bcc ClearMonster_WordAdd318
	inc sprite_data_ptr+1
ClearMonster_WordAdd318
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
	bcc ClearMonster_WordAdd319
	inc sprite_data_ptr+1
ClearMonster_WordAdd319
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (sprite_data_ptr),y
	
; // Speed up as enemies decrease
; // Update block_enemies bitmask for this enemy and increment cleared count
	ldx enemyIndex ; optimized, look out for bugs
	lda #$1
	cpx #0
	beq ClearMonster_lblShiftDone321
ClearMonster_lblShift320
	asl
	dex
	cpx #0
	bne ClearMonster_lblShift320
ClearMonster_lblShiftDone321
	; Calling storevariable on generic assign expression
	sta enemy_mask
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx blockIndex
	lda block_enemies,x 
	and enemy_mask
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq ClearMonster_ctb322
	lda #$01
	jmp ClearMonster_cfb323
ClearMonster_ctb322: ;Main true block ;keep 
	lda #$00
ClearMonster_cfb323
	; Calling storevariable on generic assign expression
	sta was_alive
	; Binary clause Simplified: NOTEQUALS
	clc
	; cmp #$00 ignored
	beq ClearMonster_edblock327
ClearMonster_ctb325: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub right value is variable/expression
	; 8 bit binop
	; Add/sub where right value is constant number
	lda enemy_mask
	eor #$ff
	 ; end add / sub var with constant
ClearMonster_rightvarAddSub_var337 = $54
	sta ClearMonster_rightvarAddSub_var337
	; Load Byte array
	; CAST type NADA
	ldx blockIndex
	lda block_enemies,x 
	and ClearMonster_rightvarAddSub_var337
	; Calling storevariable on generic assign expression
	sta block_enemies,x
	; Binary clause Simplified: LESS
	lda numberOfEnemies
	; Compare with pure num / var optimization
	cmp #$48;keep
	bcs ClearMonster_edblock341
ClearMonster_ctb339: ;Main true block ;keep 
	; Test Inc dec D
	inc numberOfEnemies
ClearMonster_edblock341
ClearMonster_edblock327
	rts
end_procedure_ClearMonster
	; NodeProcedureDecl -1
	; ***********  Defining procedure : AnimateMonsters
	;    Procedure type : User-defined procedure
sprite_ptr_base	dc.b	0
current_sprite_ptr	dc.b	0
enemyRow	dc.b	0
AnimateMonsters_block344
AnimateMonsters
	
; // Calculate the base sprite pointer once for this row
; // Row 0: blocks 0-3 (sprites 26-33)
; // Row 1: blocks 4-7 (sprites 34-41)
; // Row 2: blocks 8-11 (sprites 42-49)
	; Generic 16 bit op
	ldy #0
	lda monster_animation_frame
AnimateMonsters_rightvarInteger_var347 = $54
	sta AnimateMonsters_rightvarInteger_var347
	sty AnimateMonsters_rightvarInteger_var347+1
	; Generic 16 bit op
	ldy #0
	lda #154
AnimateMonsters_rightvarInteger_var350 = $56
	sta AnimateMonsters_rightvarInteger_var350
	sty AnimateMonsters_rightvarInteger_var350+1
	lda enemyRow
	asl
	asl
	asl
	; Low bit binop:
	clc
	adc AnimateMonsters_rightvarInteger_var350
AnimateMonsters_wordAdd348
	sta AnimateMonsters_rightvarInteger_var350
	; High-bit binop
	tya
	adc AnimateMonsters_rightvarInteger_var350+1
	tay
	lda AnimateMonsters_rightvarInteger_var350
	; Low bit binop:
	clc
	adc AnimateMonsters_rightvarInteger_var347
AnimateMonsters_wordAdd345
	sta AnimateMonsters_rightvarInteger_var347
	; High-bit binop
	tya
	adc AnimateMonsters_rightvarInteger_var347+1
	tay
	lda AnimateMonsters_rightvarInteger_var347
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
UpdateMonsters_block351
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
UpdateMonsters_spritepos352
	lda $D010
	and #%11111101
	sta $D010
UpdateMonsters_spriteposcontinue353
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
UpdateMonsters_spritepos354
	lda $D010
	and #%11111011
	sta $D010
UpdateMonsters_spriteposcontinue355
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
UpdateMonsters_spritepos356
	lda $D010
	and #%11110111
	sta $D010
UpdateMonsters_spriteposcontinue357
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
UpdateMonsters_spritepos358
	lda $D010
	and #%11101111
	sta $D010
UpdateMonsters_spriteposcontinue359
	inx
	txa
	tay
	lda y_position
	sta $D000,y
	rts
end_procedure_UpdateMonsters
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
MakeSprites_shiftbit361
	cpx #0
	beq MakeSprites_shiftbitdone362
	asl
	dex
	jmp MakeSprites_shiftbit361
MakeSprites_shiftbitdone362
MakeSprites_bitmask_var363 = $54
	sta MakeSprites_bitmask_var363
	lda $d015
	ora MakeSprites_bitmask_var363
	sta $d015
	rts
end_procedure_MakeSprites
	
; // Clears all enemies in the leftmost column and bottom row
	; NodeProcedureDecl -1
	; ***********  Defining procedure : PreclearLeftmostAndBottomEnemies
	;    Procedure type : User-defined procedure
PreclearLeftmostAndBottomEnemies
	lda #$0
	; Calling storevariable on generic assign expression
	sta blockIndex
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$0
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$4
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$4
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$8
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$8
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$8
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$3
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$8
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$5
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$9
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$9
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$3
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$9
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$5
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$a
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$a
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$3
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$a
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$5
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$b
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$b
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$3
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	lda #$b
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda #$5
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	rts
end_procedure_PreclearLeftmostAndBottomEnemies
	
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
initializeMonsters_block365
initializeMonsters
	lda #$0
	; Calling storevariable on generic assign expression
	sta block_loop_counter
initializeMonsters_forloop366
	
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
initializeMonsters_rightvarInteger_var405 = $54
	sta initializeMonsters_rightvarInteger_var405
	sty initializeMonsters_rightvarInteger_var405+1
	; Right is PURE NUMERIC : Is word =1
	; 16 bit mul or div
	; Mul 16x8 setup
	; Generic 16 bit op
	ldy #0
	lda #$1a
initializeMonsters_rightvarInteger_var408 = $56
	sta initializeMonsters_rightvarInteger_var408
	sty initializeMonsters_rightvarInteger_var408+1
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
	adc initializeMonsters_rightvarInteger_var408
initializeMonsters_wordAdd406
	sta initializeMonsters_rightvarInteger_var408
	; High-bit binop
	tya
	adc initializeMonsters_rightvarInteger_var408+1
	tay
	lda initializeMonsters_rightvarInteger_var408
	sta mul16x8_num1
	sty mul16x8_num1Hi
	ldy #0   ; Force integer assignment, set y = 0 for values lower than 255
	lda #$40
	sta mul16x8_num2
	jsr mul16x8_procedure
	; Low bit binop:
	clc
	adc initializeMonsters_rightvarInteger_var405
initializeMonsters_wordAdd403
	sta initializeMonsters_rightvarInteger_var405
	; High-bit binop
	tya
	adc initializeMonsters_rightvarInteger_var405+1
	tay
	lda initializeMonsters_rightvarInteger_var405
	sta destination_sprite_ptr
	sty destination_sprite_ptr+1
	lda #$0
	; Calling storevariable on generic assign expression
	sta copy_loop_counter
initializeMonsters_forloop409
	
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
	bcc initializeMonsters_WordAdd416
	inc source_sprite_ptr+1
initializeMonsters_WordAdd416
	lda destination_sprite_ptr
	clc
	adc #$01
	sta destination_sprite_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc initializeMonsters_WordAdd417
	inc destination_sprite_ptr+1
initializeMonsters_WordAdd417
initializeMonsters_loopstart410
	; Compare is onpage
	; Test Inc dec D
	inc copy_loop_counter
	lda #$3f
	cmp copy_loop_counter ;keep
	bne initializeMonsters_forloop409
initializeMonsters_loopdone418: ;keep
initializeMonsters_loopend411
	
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
initializeMonsters_rightvarInteger_var421 = $54
	sta initializeMonsters_rightvarInteger_var421
	sty initializeMonsters_rightvarInteger_var421+1
	; Right is PURE NUMERIC : Is word =1
	; 16 bit mul or div
	; Mul 16x8 setup
	; Generic 16 bit op
	ldy #0
	lda #$1b
initializeMonsters_rightvarInteger_var424 = $56
	sta initializeMonsters_rightvarInteger_var424
	sty initializeMonsters_rightvarInteger_var424+1
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
	adc initializeMonsters_rightvarInteger_var424
initializeMonsters_wordAdd422
	sta initializeMonsters_rightvarInteger_var424
	; High-bit binop
	tya
	adc initializeMonsters_rightvarInteger_var424+1
	tay
	lda initializeMonsters_rightvarInteger_var424
	sta mul16x8_num1
	sty mul16x8_num1Hi
	ldy #0   ; Force integer assignment, set y = 0 for values lower than 255
	lda #$40
	sta mul16x8_num2
	jsr mul16x8_procedure
	; Low bit binop:
	clc
	adc initializeMonsters_rightvarInteger_var421
initializeMonsters_wordAdd419
	sta initializeMonsters_rightvarInteger_var421
	; High-bit binop
	tya
	adc initializeMonsters_rightvarInteger_var421+1
	tay
	lda initializeMonsters_rightvarInteger_var421
	sta destination_sprite_ptr
	sty destination_sprite_ptr+1
	lda #$0
	; Calling storevariable on generic assign expression
	sta copy_loop_counter
initializeMonsters_forloop425
	
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
	bcc initializeMonsters_WordAdd432
	inc source_sprite_ptr+1
initializeMonsters_WordAdd432
	lda destination_sprite_ptr
	clc
	adc #$01
	sta destination_sprite_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc initializeMonsters_WordAdd433
	inc destination_sprite_ptr+1
initializeMonsters_WordAdd433
initializeMonsters_loopstart426
	; Compare is onpage
	; Test Inc dec D
	inc copy_loop_counter
	lda #$3f
	cmp copy_loop_counter ;keep
	bne initializeMonsters_forloop425
initializeMonsters_loopdone434: ;keep
initializeMonsters_loopend427
initializeMonsters_loopstart367
	; Test Inc dec D
	inc block_loop_counter
	lda #$c
	cmp block_loop_counter ;keep
	beq initializeMonsters_loopdone435
initializeMonsters_loopnotdone436
	jmp initializeMonsters_forloop366
initializeMonsters_loopdone435
initializeMonsters_loopend368
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
	adc player_sprite_x
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
	sta player_sprite_x
	
; //player_sprite_x := pos_x;
; // Update the sprite position on screen for sprite number @useSprite	
	; Setting sprite position
	; isi-pisi: value is constant
	ldx #0
	sta $D000,x
UpdateSprite_spritepos438
	lda $D010
	and #%11111110
	sta $D010
UpdateSprite_spriteposcontinue439
	inx
	txa
	tay
	lda player_sprite_y
	sta $D000,y
	
; // Set left/right offset pointer for spriteif (joystickright) then
; //		player_joystick_direction := 1;
; //	if (joystickleft) then
; //		player_joystick_direction := 0;
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
ShowBullet_block441
ShowBullet
	
; //end;
; // else: sprite box would overlap raster 224 - leave sprite 0 as player
	; Binary clause Simplified: NOTEQUALS
	clc
	lda player_bullet_active
	; cmp #$00 ignored
	beq ShowBullet_edblock445
ShowBullet_ctb443: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne ShowBullet_eblock463
ShowBullet_ctb462: ;Main true block ;keep 
	
; // Only display bullet/explosion if the sprite box fits entirely above the player raster line.
; // The VIC-II triggers sprite DMA at the TOP of the sprite box (player_bullet_y), not at the
; // pixel content. DMA runs for SPRITE_HEIGHT (21) lines. If player_bullet_y + SPRITE_HEIGHT >= 224,
; // the DMA window overlaps MainRasterPlayer, which can no longer retrigger sprite 0 for the player
; // at Y=226 that frame -> ship disappears. The guard is: player_bullet_y <= 224 - SPRITE_HEIGHT.
; // (= 203). Note: EXPLOSION_PIXELS_FROM_TOP shifts lit pixels downward inside the box, so the
; // explosion is still visually correct even when the box top is well above the enemy.
; //if player_bullet_y <= 224 - SPRITE_HEIGHT then
; //begin
; // Select sprite based on bullet state: 1=normal bullet, 2=explosion
; // Explosion sprite
	lda #$2
	; Calling storevariable on generic assign expression
	sta bullet_sprite_index
	jmp ShowBullet_edblock464
ShowBullet_eblock463
	lda #$1
	; Calling storevariable on generic assign expression
	sta bullet_sprite_index
ShowBullet_edblock464
	
; // Normal bullet sprite
	; Set sprite location
	lda #$0
	sta $50
	; Generic 16 bit op
	ldy #0
	lda bullet_sprite_index
ShowBullet_rightvarInteger_var471 = $54
	sta ShowBullet_rightvarInteger_var471
	sty ShowBullet_rightvarInteger_var471+1
	lda #128
	ldy #0
	; Low bit binop:
	clc
	adc ShowBullet_rightvarInteger_var471
ShowBullet_wordAdd469
	sta ShowBullet_rightvarInteger_var471
	; High-bit binop
	tya
	adc ShowBullet_rightvarInteger_var471+1
	tay
	lda ShowBullet_rightvarInteger_var471
	ldx $50
	sta $07f8 + $0,x
	; Setting sprite position
	; isi-pisi: value is constant
	lda player_bullet_x
	ldx #0
	sta $D000,x
ShowBullet_spritepos472
	lda $D010
	and #%11111110
	sta $D010
ShowBullet_spriteposcontinue473
	inx
	txa
	tay
	lda player_bullet_y
	sta $D000,y
ShowBullet_edblock445
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
	bne UpdatePlayerBullet_eblock477
UpdatePlayerBullet_ctb476: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	lda player_bullet_y
	; Compare with pure num / var optimization
	cmp #$5;keep
	bcc UpdatePlayerBullet_eblock510
UpdatePlayerBullet_ctb509: ;Main true block ;keep 
	
; // Move bullet up
	; Optimizer: a = a +/- b
	; Load16bitvariable : player_bullet_y
	lda player_bullet_y
	sec
	sbc #$4
	sta player_bullet_y
	jmp UpdatePlayerBullet_edblock511
UpdatePlayerBullet_eblock510
	
; // Bullet reached top of screen, deactivate
	lda #$0
	; Calling storevariable on generic assign expression
	sta player_bullet_active
UpdatePlayerBullet_edblock511
	jmp UpdatePlayerBullet_edblock478
UpdatePlayerBullet_eblock477
	; Binary clause Simplified: EQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne UpdatePlayerBullet_edblock520
UpdatePlayerBullet_ctb518: ;Main true block ;keep 
	
; // Explosion animation - count frames
	; Test Inc dec D
	inc explosion_frame_counter
	; Binary clause Simplified: GREATEREQUAL
	lda explosion_frame_counter
	; Compare with pure num / var optimization
	cmp #$10;keep
	bcc UpdatePlayerBullet_edblock532
UpdatePlayerBullet_ctb530: ;Main true block ;keep 
	
; // Explosion finished, reset bullet
	lda #$0
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	; Calling storevariable on generic assign expression
	sta explosion_frame_counter
UpdatePlayerBullet_edblock532
UpdatePlayerBullet_edblock520
UpdatePlayerBullet_edblock478
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
CheckBulletCollision_block535
CheckBulletCollision
	lda #$1
	; Calling storevariable on generic assign expression
	sta should_check
	lda #$0
	; Calling storevariable on generic assign expression
	sta found_hit
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_y
	clc
	adc #$d
	 ; end add / sub var with constant
CheckBulletCollision_binary_clause_temp_var541 = $54
	sta CheckBulletCollision_binary_clause_temp_var541
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
CheckBulletCollision_binary_clause_temp_2_var542 = $56
	sta CheckBulletCollision_binary_clause_temp_2_var542
	lda CheckBulletCollision_binary_clause_temp_var541
	cmp CheckBulletCollision_binary_clause_temp_2_var542;keep
	bcs CheckBulletCollision_edblock539
CheckBulletCollision_ctb537: ;Main true block ;keep 
	
; // Early exit if bullet outside enemy formation area.
; // Lower bound: contact pixel (bullet_y + OFFSET) above the formation top -> skip.
	lda #$0
	; Calling storevariable on generic assign expression
	sta should_check
CheckBulletCollision_edblock539
	; Optimization: replacing a <= N with a <= N-1
	; Binary clause Simplified: LESS
	lda monster_vertical_adjustment
	; Compare with pure num / var optimization
	cmp #$5e;keep
	bcs CheckBulletCollision_edblock547
CheckBulletCollision_ctb545: ;Main true block ;keep 
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_vertical_adjustment
	clc
	adc #$a2
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp player_bullet_y;keep
	bcs CheckBulletCollision_edblock559
CheckBulletCollision_ctb557: ;Main true block ;keep 
	
; // Upper bound: bullet sprite top below the formation bottom -> skip.
; // BYTE OVERFLOW GUARD: monster_base_y(82) + monster_vertical_adjustment + 80 wraps after ~7 drops.
; // Fold the two constants: 82 + 80 = 162, so check becomes bullet_y > adj + 162.
; // adj + 162 overflows when adj > 93 (enemies already off-screen), so skip the guard in that case.
	lda #$0
	; Calling storevariable on generic assign expression
	sta should_check
CheckBulletCollision_edblock559
CheckBulletCollision_edblock547
	; Binary clause Simplified: NOTEQUALS
	clc
	lda should_check
	; cmp #$00 ignored
	beq CheckBulletCollision_localfailed3667
	jmp CheckBulletCollision_ctb563
CheckBulletCollision_localfailed3667
	jmp CheckBulletCollision_edblock565
CheckBulletCollision_ctb563: ;Main true block ;keep 
	
; // Calculate which block row (0-2) the bullet is in.
; // Use contact pixel Y to avoid byte underflow when sprite top is above the formation.
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_y
	clc
	adc #$d
	 ; end add / sub var with constant
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
	bcs CheckBulletCollision_eblock3671
CheckBulletCollision_ctb3670: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta block_row
	jmp CheckBulletCollision_edblock3672
CheckBulletCollision_eblock3671
	; Binary clause Simplified: LESS
	lda rel_y
	; Compare with pure num / var optimization
	cmp #$34;keep
	bcs CheckBulletCollision_eblock3687
CheckBulletCollision_ctb3686: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta block_row
	jmp CheckBulletCollision_edblock3688
CheckBulletCollision_eblock3687
	lda #$2
	; Calling storevariable on generic assign expression
	sta block_row
CheckBulletCollision_edblock3688
CheckBulletCollision_edblock3672
	
; // Check all 4 blocks in the bullet's row
	lda #$0
	; Calling storevariable on generic assign expression
	sta block_col
CheckBulletCollision_while3693
CheckBulletCollision_loopstart3697
	; Binary clause Simplified: LESS
	lda block_col
	; Compare with pure num / var optimization
	cmp #$4;keep
	bcs CheckBulletCollision_localfailed5233
CheckBulletCollision_localsuccess5234: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda found_hit
	; cmp #$00 ignored
	bne CheckBulletCollision_localfailed5233
	jmp CheckBulletCollision_ctb3694
CheckBulletCollision_localfailed5233
	jmp CheckBulletCollision_edblock3696
CheckBulletCollision_ctb3694: ;Main true block ;keep 
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
	beq CheckBulletCollision_localfailed6004
	jmp CheckBulletCollision_ctb5237
CheckBulletCollision_localfailed6004
	jmp CheckBulletCollision_edblock5239
CheckBulletCollision_ctb5237: ;Main true block ;keep 
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
	; Binary clause Simplified: LESSEQUAL
	; 8 bit binop
	; Add/sub where right value is constant number
	sec
	sbc #$b
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp player_bullet_x;keep
	beq CheckBulletCollision_ctb6009
	bcs CheckBulletCollision_localfailed6390
	jmp CheckBulletCollision_ctb6009
CheckBulletCollision_localfailed6390
	jmp CheckBulletCollision_edblock6011
CheckBulletCollision_ctb6009: ;Main true block ;keep 
	; Binary clause Simplified: GREATER
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda block_x
	clc
	adc #$30
	 ; end add / sub var with constant
	sec
	sbc #$b
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp player_bullet_x;keep
	bcc CheckBulletCollision_localfailed6582
	beq CheckBulletCollision_localfailed6582
	jmp CheckBulletCollision_ctb6393
CheckBulletCollision_localfailed6582
	jmp CheckBulletCollision_edblock6395
CheckBulletCollision_ctb6393: ;Main true block ;keep 
	
; // Quick horizontal range check
; // Bullet contact point is BULLET_X_CONTACT_REACH px into the sprite, so effective hit X = player_bullet_x + BULLET_X_CONTACT_REACH.
; // Range: contact point must fall within [block_x, block_x+48).
; // => player_bullet_x in [block_x-REACH, block_x+(48-REACH)). block_x >= 32 so left bound >= 20, no underflow.
; // rel_x = (player_bullet_x + REACH) - block_x; no underflow since player_bullet_x >= block_x-REACH
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_x
	sec
	sbc block_x
	 ; end add / sub var with constant
	clc
	adc #$b
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta rel_x
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
CheckBulletCollision_rightvarAddSub_var6586 = $54
	sta CheckBulletCollision_rightvarAddSub_var6586
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	clc
	adc CheckBulletCollision_rightvarAddSub_var6586
	; Calling storevariable on generic assign expression
	sta block_y
	
; // Add BULLET_Y_CONTACT_OFFSET to map sprite top position to actual contact pixel Y.
; // No underflow: bullet enters the row from below so player_bullet_y + offset >= block_y.
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_y
	clc
	adc #$d
	 ; end add / sub var with constant
	sec
	sbc block_y
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta rel_y
	; Binary clause Simplified: LESS
	lda rel_x
	; Compare with pure num / var optimization
	cmp #$c;keep
	bcs CheckBulletCollision_eblock6589
CheckBulletCollision_ctb6588: ;Main true block ;keep 
	
; // Determine enemy column (0-2) by X position
; // Each enemy is 12px wide with 6px gaps between them
; // Col 0: 0-11, Gap: 12-17, Col 1: 18-29, Gap: 30-35, Col 2: 36-47
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_col
	jmp CheckBulletCollision_edblock6590
CheckBulletCollision_eblock6589
	; Binary clause Simplified: LESS
	lda rel_x
	; Compare with pure num / var optimization
	cmp #$12;keep
	bcs CheckBulletCollision_eblock6653
CheckBulletCollision_ctb6652: ;Main true block ;keep 
	
; // gap
	lda #$ff
	; Calling storevariable on generic assign expression
	sta enemy_col
	jmp CheckBulletCollision_edblock6654
CheckBulletCollision_eblock6653
	; Binary clause Simplified: LESS
	lda rel_x
	; Compare with pure num / var optimization
	cmp #$1e;keep
	bcs CheckBulletCollision_eblock6685
CheckBulletCollision_ctb6684: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemy_col
	jmp CheckBulletCollision_edblock6686
CheckBulletCollision_eblock6685
	; Binary clause Simplified: LESS
	lda rel_x
	; Compare with pure num / var optimization
	cmp #$24;keep
	bcs CheckBulletCollision_eblock6701
CheckBulletCollision_ctb6700: ;Main true block ;keep 
	
; // gap
	lda #$ff
	; Calling storevariable on generic assign expression
	sta enemy_col
	jmp CheckBulletCollision_edblock6702
CheckBulletCollision_eblock6701
	lda #$2
	; Calling storevariable on generic assign expression
	sta enemy_col
CheckBulletCollision_edblock6702
CheckBulletCollision_edblock6686
CheckBulletCollision_edblock6654
CheckBulletCollision_edblock6590
	
; // Determine enemy row (0-1) by Y position
; // Each enemy is 8px tall with a 6px gap between rows (offsets 8-13 in the sprite).
; // BULLET_SPEED=4 can skip the 8-pixel bottom zone entirely when the formation is
; // very low: the bullet jumps from rel_y=13 (gap) to rel_y=9 (gap) to rel_y=5 (top),
; // never passing through range 14-21. Extending the bottom zone upward to rel_y>=8
; // closes the dead zone so odd-indexed (bottom) enemies are always hittable.
	lda #$ff
	; Calling storevariable on generic assign expression
	sta enemy_row
	; Binary clause Simplified: LESS
	lda rel_y
	; Compare with pure num / var optimization
	cmp #$8;keep
	bcs CheckBulletCollision_eblock6709
CheckBulletCollision_ctb6708: ;Main true block ;keep 
	
; // Invalid by default
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_row
	jmp CheckBulletCollision_edblock6710
CheckBulletCollision_eblock6709
	; Binary clause Simplified: GREATEREQUAL
	lda rel_y
	; Compare with pure num / var optimization
	cmp #$8;keep
	bcc CheckBulletCollision_edblock6725
CheckBulletCollision_localsuccess6727: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	lda rel_y
	; Compare with pure num / var optimization
	cmp #$16;keep
	bcs CheckBulletCollision_edblock6725
CheckBulletCollision_ctb6723: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemy_row
CheckBulletCollision_edblock6725
CheckBulletCollision_edblock6710
	; Binary clause Simplified: NOTEQUALS
	lda enemy_row
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CheckBulletCollision_localfailed6750
CheckBulletCollision_localsuccess6751: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: NOTEQUALS
	lda enemy_col
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CheckBulletCollision_localfailed6750
	jmp CheckBulletCollision_ctb6730
CheckBulletCollision_localfailed6750
	jmp CheckBulletCollision_edblock6732
CheckBulletCollision_ctb6730: ;Main true block ;keep 
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
	beq CheckBulletCollision_lblShiftDone6754
CheckBulletCollision_lblShift6753
	asl
	dex
	cpx #0
	bne CheckBulletCollision_lblShift6753
CheckBulletCollision_lblShiftDone6754
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
	beq CheckBulletCollision_edblock6758
CheckBulletCollision_ctb6756: ;Main true block ;keep 
	
; // Check if this enemy is alive
; // Hit! Clear enemy and trigger explosion
; // Clear sprite + update block_enemies handled inside ClearMonster
	lda block_index
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda hit_enemy_index
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	
; // Snap explosion sprite to enemy hitbox top-left.
; // enemy_col stride = 12px wide + 6px gap = 18px.
; // enemy_row stride = 8px tall + 6px gap = 14px.
; // Shift box upward by EXPLOSION_PIXELS_FROM_TOP so the lit pixels
; // (packed at the bottom of the sprite frame) land on the enemy visually.
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx enemy_col ; optimized, look out for bugs
	; Load right hand side
	lda #$12
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc block_x
	 ; end add / sub var with constant
	sec
	sbc #$6
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta player_bullet_x
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx enemy_row ; optimized, look out for bugs
	; Load right hand side
	lda #$e
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc block_y
	 ; end add / sub var with constant
	clc
	adc #$0
	 ; end add / sub var with constant
	sec
	sbc #$d
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta player_bullet_y
	lda #$2
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	lda #$0
	; Calling storevariable on generic assign expression
	sta explosion_frame_counter
	lda #$1
	; Calling storevariable on generic assign expression
	sta found_hit
CheckBulletCollision_edblock6758
CheckBulletCollision_edblock6732
CheckBulletCollision_edblock6395
CheckBulletCollision_edblock6011
CheckBulletCollision_edblock5239
	; Test Inc dec D
	inc block_col
	jmp CheckBulletCollision_while3693
CheckBulletCollision_edblock3696
CheckBulletCollision_loopend3698
CheckBulletCollision_edblock565
	rts
end_procedure_CheckBulletCollision
	; NodeProcedureDecl -1
	; ***********  Defining procedure : DisplayText
	;    Procedure type : User-defined procedure
DisplayText
	
; //moveto(29,1,hi(screen_char_loc));
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr6771
	ldy #>DisplayText_stringassignstr6771
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
	lda #<DisplayText_stringassignstr6773
	ldy #>DisplayText_stringassignstr6773
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
	lda #<DisplayText_stringassignstr6775
	ldy #>DisplayText_stringassignstr6775
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
	lda #<DisplayText_stringassignstr6777
	ldy #>DisplayText_stringassignstr6777
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
	lda #<DisplayText_stringassignstr6779
	ldy #>DisplayText_stringassignstr6779
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
	lda #<DisplayText_stringassignstr6781
	ldy #>DisplayText_stringassignstr6781
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
	lda #<DisplayText_stringassignstr6783
	ldy #>DisplayText_stringassignstr6783
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
	lda #<DisplayText_stringassignstr6785
	ldy #>DisplayText_stringassignstr6785
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
	lda #<DisplayText_stringassignstr6787
	ldy #>DisplayText_stringassignstr6787
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
	lda #<DisplayText_stringassignstr6789
	ldy #>DisplayText_stringassignstr6789
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
	lda #<DisplayText_stringassignstr6791
	ldy #>DisplayText_stringassignstr6791
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
	lda #<DisplayText_stringassignstr6793
	ldy #>DisplayText_stringassignstr6793
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
	lda #<DisplayText_stringassignstr6795
	ldy #>DisplayText_stringassignstr6795
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
	lda #<DisplayText_stringassignstr6797
	ldy #>DisplayText_stringassignstr6797
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
	lda #<DisplayText_stringassignstr6799
	ldy #>DisplayText_stringassignstr6799
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
temp_block_index	dc.b	$00
temp_enemy_index	dc.b	$00
ClearEnemyAtCounter_block6800
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
ClearEnemyAtCounter_rightvarAddSub_var6801 = $54
	sta ClearEnemyAtCounter_rightvarAddSub_var6801
	lda #$3
	sec
	sbc ClearEnemyAtCounter_rightvarAddSub_var6801
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
	
; // Map local sub-index to block row (0=top,1=middle,2=bottom)
	; Calling storevariable on generic assign expression
	sta Helpers_dividendInput
	lda #$2
	; Calling storevariable on generic assign expression
	sta Helpers_divisorInput
	jsr Helpers_Div
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
	bne ClearEnemyAtCounter_eblock6804
ClearEnemyAtCounter_ctb6803: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda enemy_sub
	; cmp #$00 ignored
	bne ClearEnemyAtCounter_eblock6859
ClearEnemyAtCounter_ctb6858: ;Main true block ;keep 
	
; // Column-based enemy indexing: Col0(0,1), Col1(2,3), Col2(4,5)
; // Clear from right to left, bottom then top within each column
	lda #$5
	; Calling storevariable on generic assign expression
	sta enemy_type
	jmp ClearEnemyAtCounter_edblock6860
ClearEnemyAtCounter_eblock6859
	lda #$4
	; Calling storevariable on generic assign expression
	sta enemy_type
ClearEnemyAtCounter_edblock6860
	jmp ClearEnemyAtCounter_edblock6805
ClearEnemyAtCounter_eblock6804
	
; // Left column
	; Binary clause Simplified: EQUALS
	lda pair_index
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne ClearEnemyAtCounter_eblock6868
ClearEnemyAtCounter_ctb6867: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda enemy_sub
	; cmp #$00 ignored
	bne ClearEnemyAtCounter_eblock6891
ClearEnemyAtCounter_ctb6890: ;Main true block ;keep 
	
; // Right column
	lda #$3
	; Calling storevariable on generic assign expression
	sta enemy_type
	jmp ClearEnemyAtCounter_edblock6892
ClearEnemyAtCounter_eblock6891
	lda #$2
	; Calling storevariable on generic assign expression
	sta enemy_type
ClearEnemyAtCounter_edblock6892
	jmp ClearEnemyAtCounter_edblock6869
ClearEnemyAtCounter_eblock6868
	; Binary clause Simplified: EQUALS
	clc
	lda enemy_sub
	; cmp #$00 ignored
	bne ClearEnemyAtCounter_eblock6900
ClearEnemyAtCounter_ctb6899: ;Main true block ;keep 
	
; // Middle column
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemy_type
	jmp ClearEnemyAtCounter_edblock6901
ClearEnemyAtCounter_eblock6900
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_type
ClearEnemyAtCounter_edblock6901
ClearEnemyAtCounter_edblock6869
ClearEnemyAtCounter_edblock6805
	lda enemy_type
	; Calling storevariable on generic assign expression
	sta temp_enemy_index
	
; // block_enemies is row-major with row 0 = TOP. The clearing sequence
; // should still clear bottom-first visually, so map the computed row
; // (0=top..2=bottom) to the block index accordingly.
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$2
	sec
	sbc clear_row
	 ; end add / sub var with constant
	asl
	asl
	clc
	adc clear_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta temp_block_index
	
; // Only clear if this enemy is still alive according to block_enemies
	ldx temp_enemy_index ; optimized, look out for bugs
	lda #$1
	cpx #0
	beq ClearEnemyAtCounter_lblShiftDone6907
ClearEnemyAtCounter_lblShift6906
	asl
	dex
	cpx #0
	bne ClearEnemyAtCounter_lblShift6906
ClearEnemyAtCounter_lblShiftDone6907
	; Calling storevariable on generic assign expression
	sta cec_enemy_mask
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx temp_block_index
	lda block_enemies,x 
	and cec_enemy_mask
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq ClearEnemyAtCounter_edblock6911
ClearEnemyAtCounter_ctb6909: ;Main true block ;keep 
	
; // ClearMonster will clear the sprite and update the block_enemies bitmask
	lda temp_block_index
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda temp_enemy_index
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
ClearEnemyAtCounter_edblock6911
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
GetRightmostEnemyOffset_block6914
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
GetRightmostEnemyOffset_while6915
GetRightmostEnemyOffset_loopstart6919
	; Binary clause Simplified: EQUALS
	clc
	lda rightmost_column_loop_done
	; cmp #$00 ignored
	bne GetRightmostEnemyOffset_localfailed7093
	jmp GetRightmostEnemyOffset_ctb6916
GetRightmostEnemyOffset_localfailed7093
	jmp GetRightmostEnemyOffset_edblock6918
GetRightmostEnemyOffset_ctb6916: ;Main true block ;keep 
	
; // Check all 3 rows for this block column
	lda #$0
	; Calling storevariable on generic assign expression
	sta rightmost_row_index
GetRightmostEnemyOffset_while7095
GetRightmostEnemyOffset_loopstart7099
	; Binary clause Simplified: LESS
	lda rightmost_row_index
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs GetRightmostEnemyOffset_localfailed7178
GetRightmostEnemyOffset_localsuccess7179: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda rightmost_found_flag
	; cmp #$00 ignored
	bne GetRightmostEnemyOffset_localfailed7178
	jmp GetRightmostEnemyOffset_ctb7096
GetRightmostEnemyOffset_localfailed7178
	jmp GetRightmostEnemyOffset_edblock7098
GetRightmostEnemyOffset_ctb7096: ;Main true block ;keep 
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
	beq GetRightmostEnemyOffset_eblock7183
GetRightmostEnemyOffset_ctb7182: ;Main true block ;keep 
	
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
	jmp GetRightmostEnemyOffset_edblock7184
GetRightmostEnemyOffset_eblock7183
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda rightmost_enemies_byte
	and #$c
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetRightmostEnemyOffset_eblock7227
GetRightmostEnemyOffset_ctb7226: ;Main true block ;keep 
	
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
	jmp GetRightmostEnemyOffset_edblock7228
GetRightmostEnemyOffset_eblock7227
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda rightmost_enemies_byte
	and #$3
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetRightmostEnemyOffset_edblock7250
GetRightmostEnemyOffset_ctb7248: ;Main true block ;keep 
	
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
GetRightmostEnemyOffset_edblock7250
GetRightmostEnemyOffset_edblock7228
GetRightmostEnemyOffset_edblock7184
	; Test Inc dec D
	inc rightmost_row_index
	jmp GetRightmostEnemyOffset_while7095
GetRightmostEnemyOffset_edblock7098
GetRightmostEnemyOffset_loopend7100
	; Binary clause Simplified: EQUALS
	lda rightmost_found_flag
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne GetRightmostEnemyOffset_localfailed7263
	jmp GetRightmostEnemyOffset_ctb7258
GetRightmostEnemyOffset_localfailed7263: ;keep
	; ; logical OR, second chance
	; Binary clause Simplified: EQUALS
	clc
	lda rightmost_block_column
	; cmp #$00 ignored
	bne GetRightmostEnemyOffset_eblock7259
GetRightmostEnemyOffset_ctb7258: ;Main true block ;keep 
	
; // Exit if found or if we've checked column 0
	lda #$1
	; Calling storevariable on generic assign expression
	sta rightmost_column_loop_done
	jmp GetRightmostEnemyOffset_edblock7260
GetRightmostEnemyOffset_eblock7259
	; Test Inc dec D
	dec rightmost_block_column
GetRightmostEnemyOffset_edblock7260
	jmp GetRightmostEnemyOffset_while6915
GetRightmostEnemyOffset_edblock6918
GetRightmostEnemyOffset_loopend6920
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
GetLeftmostEnemyOffset_block7266
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
GetLeftmostEnemyOffset_while7267
GetLeftmostEnemyOffset_loopstart7271
	; Binary clause Simplified: EQUALS
	clc
	lda leftmost_column_loop_done
	; cmp #$00 ignored
	bne GetLeftmostEnemyOffset_localfailed7445
	jmp GetLeftmostEnemyOffset_ctb7268
GetLeftmostEnemyOffset_localfailed7445
	jmp GetLeftmostEnemyOffset_edblock7270
GetLeftmostEnemyOffset_ctb7268: ;Main true block ;keep 
	
; // Check all 3 rows for this block column
	lda #$0
	; Calling storevariable on generic assign expression
	sta leftmost_row_index
GetLeftmostEnemyOffset_while7447
GetLeftmostEnemyOffset_loopstart7451
	; Binary clause Simplified: LESS
	lda leftmost_row_index
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs GetLeftmostEnemyOffset_localfailed7530
GetLeftmostEnemyOffset_localsuccess7531: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda leftmost_found_flag
	; cmp #$00 ignored
	bne GetLeftmostEnemyOffset_localfailed7530
	jmp GetLeftmostEnemyOffset_ctb7448
GetLeftmostEnemyOffset_localfailed7530
	jmp GetLeftmostEnemyOffset_edblock7450
GetLeftmostEnemyOffset_ctb7448: ;Main true block ;keep 
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
	beq GetLeftmostEnemyOffset_eblock7535
GetLeftmostEnemyOffset_ctb7534: ;Main true block ;keep 
	
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
	jmp GetLeftmostEnemyOffset_edblock7536
GetLeftmostEnemyOffset_eblock7535
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda leftmost_enemies_byte
	and #$c
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetLeftmostEnemyOffset_eblock7579
GetLeftmostEnemyOffset_ctb7578: ;Main true block ;keep 
	
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
	jmp GetLeftmostEnemyOffset_edblock7580
GetLeftmostEnemyOffset_eblock7579
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda leftmost_enemies_byte
	and #$30
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetLeftmostEnemyOffset_edblock7602
GetLeftmostEnemyOffset_ctb7600: ;Main true block ;keep 
	
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
GetLeftmostEnemyOffset_edblock7602
GetLeftmostEnemyOffset_edblock7580
GetLeftmostEnemyOffset_edblock7536
	; Test Inc dec D
	inc leftmost_row_index
	jmp GetLeftmostEnemyOffset_while7447
GetLeftmostEnemyOffset_edblock7450
GetLeftmostEnemyOffset_loopend7452
	; Binary clause Simplified: EQUALS
	lda leftmost_found_flag
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne GetLeftmostEnemyOffset_localfailed7615
	jmp GetLeftmostEnemyOffset_ctb7610
GetLeftmostEnemyOffset_localfailed7615: ;keep
	; ; logical OR, second chance
	; Binary clause Simplified: EQUALS
	lda leftmost_block_column
	; Compare with pure num / var optimization
	cmp #$3;keep
	bne GetLeftmostEnemyOffset_eblock7611
GetLeftmostEnemyOffset_ctb7610: ;Main true block ;keep 
	
; // Exit if found or if we've checked column 3
	lda #$1
	; Calling storevariable on generic assign expression
	sta leftmost_column_loop_done
	jmp GetLeftmostEnemyOffset_edblock7612
GetLeftmostEnemyOffset_eblock7611
	; Test Inc dec D
	inc leftmost_block_column
GetLeftmostEnemyOffset_edblock7612
	jmp GetLeftmostEnemyOffset_while7267
GetLeftmostEnemyOffset_edblock7270
GetLeftmostEnemyOffset_loopend7272
	lda leftmost_result_offset
	rts
end_procedure_GetLeftmostEnemyOffset
	
; // Returns 1 if any enemy remains in the specified row (0=top,1=middle,2=bottom)
	; NodeProcedureDecl -1
	; ***********  Defining procedure : RowHasMonsters
	;    Procedure type : User-defined procedure
col	dc.b	0
idx	dc.b	0
has_flag	dc.b	0
row	dc.b	0
RowHasMonsters_block7618
RowHasMonsters
	lda #$0
	; Calling storevariable on generic assign expression
	sta has_flag
	; Calling storevariable on generic assign expression
	sta col
RowHasMonsters_while7619
RowHasMonsters_loopstart7623
	; Binary clause Simplified: LESS
	lda col
	; Compare with pure num / var optimization
	cmp #$4;keep
	bcs RowHasMonsters_edblock7622
RowHasMonsters_ctb7620: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : row
	lda row
	asl
	asl
	clc
	adc col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta idx
	
; // break
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	ldx idx
	lda block_enemies,x 
	; cmp #$00 ignored
	beq RowHasMonsters_edblock7636
RowHasMonsters_ctb7634: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta has_flag
	lda #$4
	; Calling storevariable on generic assign expression
	sta col
RowHasMonsters_edblock7636
	; Test Inc dec D
	inc col
	jmp RowHasMonsters_while7619
RowHasMonsters_edblock7622
RowHasMonsters_loopend7624
	lda has_flag
	rts
end_procedure_RowHasMonsters
	
; // Returns the Y pixel coordinate of the bottom edge of the lowest alive enemy.
; // Scans monster rows bottom-to-top; byte underflow (dec past 0 -> 255) exits the loop naturally.
; // Used to clamp formation drops so enemies never reach the player.
	; NodeProcedureDecl -1
	; ***********  Defining procedure : GetLowestEnemyBottomY
	;    Procedure type : User-defined procedure
gleby_r	dc.b	0
gleby_b	dc.b	0
gleby_found	dc.b	0
gleby_lowest_row	dc.b	0
gleby_row_offset	dc.b	0
gleby_has_bottom_enemy	dc.b	0
gleby_bottom_in_sprite	dc.b	0
gleby_result	dc.b	0
GetLowestEnemyBottomY_block7639
GetLowestEnemyBottomY
	lda #$0
	; Calling storevariable on generic assign expression
	sta gleby_found
	; Calling storevariable on generic assign expression
	sta gleby_lowest_row
	lda #$2
	; Calling storevariable on generic assign expression
	sta gleby_r
	
; // at r=0 wraps to 255, exiting the while
GetLowestEnemyBottomY_while7640
GetLowestEnemyBottomY_loopstart7644
	; Optimization: replacing a <= N with a <= N-1
	; Binary clause Simplified: LESS
	lda gleby_r
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs GetLowestEnemyBottomY_edblock7643
GetLowestEnemyBottomY_localsuccess7674: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda gleby_found
	; cmp #$00 ignored
	bne GetLowestEnemyBottomY_edblock7643
GetLowestEnemyBottomY_ctb7641: ;Main true block ;keep 
	
; // Scan from bottom row (2) upward; dec past 0 wraps to 255 which exits 'r <= 2'
	lda #$0
	; Calling storevariable on generic assign expression
	sta gleby_b
GetLowestEnemyBottomY_while7676
GetLowestEnemyBottomY_loopstart7680
	; Binary clause Simplified: LESS
	lda gleby_b
	; Compare with pure num / var optimization
	cmp #$4;keep
	bcs GetLowestEnemyBottomY_edblock7679
GetLowestEnemyBottomY_localsuccess7689: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda gleby_found
	; cmp #$00 ignored
	bne GetLowestEnemyBottomY_edblock7679
GetLowestEnemyBottomY_ctb7677: ;Main true block ;keep 
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : gleby_r
	lda gleby_r
	asl
	asl
	clc
	adc gleby_b
	 ; end add / sub var with constant
	tax
	lda block_enemies,x 
	; cmp #$00 ignored
	beq GetLowestEnemyBottomY_edblock7694
GetLowestEnemyBottomY_ctb7692: ;Main true block ;keep 
	lda gleby_r
	; Calling storevariable on generic assign expression
	sta gleby_lowest_row
	lda #$1
	; Calling storevariable on generic assign expression
	sta gleby_found
GetLowestEnemyBottomY_edblock7694
	; Test Inc dec D
	inc gleby_b
	jmp GetLowestEnemyBottomY_while7676
GetLowestEnemyBottomY_edblock7679
GetLowestEnemyBottomY_loopend7681
	; Binary clause Simplified: EQUALS
	clc
	lda gleby_found
	; cmp #$00 ignored
	bne GetLowestEnemyBottomY_edblock7700
GetLowestEnemyBottomY_ctb7698: ;Main true block ;keep 
	; Test Inc dec D
	dec gleby_r
GetLowestEnemyBottomY_edblock7700
	jmp GetLowestEnemyBottomY_while7640
GetLowestEnemyBottomY_edblock7643
GetLowestEnemyBottomY_loopend7645
	; Binary clause Simplified: EQUALS
	clc
	lda gleby_lowest_row
	; cmp #$00 ignored
	bne GetLowestEnemyBottomY_eblock7705
GetLowestEnemyBottomY_ctb7704: ;Main true block ;keep 
	
; // Row Y offsets: row 0 = 0, row 1 = MONSTER_ROW_OFFSET, row 2 = MONSTER_ROW_OFFSET*2
	lda #$0
	; Calling storevariable on generic assign expression
	sta gleby_row_offset
	jmp GetLowestEnemyBottomY_edblock7706
GetLowestEnemyBottomY_eblock7705
	; Binary clause Simplified: EQUALS
	lda gleby_lowest_row
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne GetLowestEnemyBottomY_eblock7721
GetLowestEnemyBottomY_ctb7720: ;Main true block ;keep 
	lda #$1a
	; Calling storevariable on generic assign expression
	sta gleby_row_offset
	jmp GetLowestEnemyBottomY_edblock7722
GetLowestEnemyBottomY_eblock7721
	lda #$34
	; Calling storevariable on generic assign expression
	sta gleby_row_offset
GetLowestEnemyBottomY_edblock7722
GetLowestEnemyBottomY_edblock7706
	
; // Check whether any 'bottom' enemy (odd index; bits 1,3,5 = mask $2A) is alive in this row.
; // Bottom enemies occupy sprite pixel rows 13-20 (bottom pixel offset = 20).
; // Top-only enemies occupy rows 0-7 (bottom pixel offset = 7).
	lda #$0
	; Calling storevariable on generic assign expression
	sta gleby_has_bottom_enemy
	; Calling storevariable on generic assign expression
	sta gleby_b
GetLowestEnemyBottomY_while7727
GetLowestEnemyBottomY_loopstart7731
	; Optimization: replacing a <= N with a <= N-1
	; Binary clause Simplified: LESS
	lda gleby_b
	; Compare with pure num / var optimization
	cmp #$4;keep
	bcs GetLowestEnemyBottomY_edblock7730
GetLowestEnemyBottomY_ctb7728: ;Main true block ;keep 
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : gleby_lowest_row
	lda gleby_lowest_row
	asl
	asl
	clc
	adc gleby_b
	 ; end add / sub var with constant
	tax
	lda block_enemies,x 
	and #$2a
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetLowestEnemyBottomY_edblock7744
GetLowestEnemyBottomY_ctb7742: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta gleby_has_bottom_enemy
GetLowestEnemyBottomY_edblock7744
	; Test Inc dec D
	inc gleby_b
	jmp GetLowestEnemyBottomY_while7727
GetLowestEnemyBottomY_edblock7730
GetLowestEnemyBottomY_loopend7732
	; Binary clause Simplified: NOTEQUALS
	clc
	lda gleby_has_bottom_enemy
	; cmp #$00 ignored
	beq GetLowestEnemyBottomY_eblock7749
GetLowestEnemyBottomY_ctb7748: ;Main true block ;keep 
	lda #$14
	; Calling storevariable on generic assign expression
	sta gleby_bottom_in_sprite
	jmp GetLowestEnemyBottomY_edblock7750
GetLowestEnemyBottomY_eblock7749
	lda #$7
	; Calling storevariable on generic assign expression
	sta gleby_bottom_in_sprite
GetLowestEnemyBottomY_edblock7750
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc gleby_row_offset
	 ; end add / sub var with constant
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	clc
	adc gleby_bottom_in_sprite
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta gleby_result
	rts
end_procedure_GetLowestEnemyBottomY
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateTick
	;    Procedure type : User-defined procedure
should_move_enemy	dc.b	0
rightmost_offset	dc.b	0
leftmost_offset	dc.b	0
right_edge	dc.b	0
left_edge	dc.b	0
prev_direction	dc.b	0
UpdateTick_block7755
UpdateTick
	lda #$0
	; Calling storevariable on generic assign expression
	sta should_move_enemy
	; Binary clause Simplified: NOTEQUALS
	clc
	lda enemyMoveCounter
	; cmp #$00 ignored
	beq UpdateTick_localfailed7848
	jmp UpdateTick_ctb7757
UpdateTick_localfailed7848
	jmp UpdateTick_eblock7758
UpdateTick_ctb7757: ;Main true block ;keep 
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
	
; // Boundaries set so all enemy configurations bounce at the same visual offset from each wall (36px).
; // Left: bounce when leftmost enemy visual edge <= 36 (i.e. left_edge <= 36).
; // Right: symmetric restriction, 12px inward from original 254 = 242.
; // No byte overflow risk: right boundary caps monster_base_x low enough that left_edge sum stays < 255.
	lda enemy_direction
	; Calling storevariable on generic assign expression
	sta prev_direction
	; Binary clause Simplified: GREATEREQUAL
	lda right_edge
	; Compare with pure num / var optimization
	cmp #$f2;keep
	bcc UpdateTick_eblock7852
UpdateTick_ctb7851: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_direction
	jmp UpdateTick_edblock7853
UpdateTick_eblock7852
	; Binary clause Simplified: LESS
	lda left_edge
	; Compare with pure num / var optimization
	cmp #$25;keep
	bcs UpdateTick_edblock7867
UpdateTick_ctb7865: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemy_direction
UpdateTick_edblock7867
UpdateTick_edblock7853
	; Binary clause Simplified: NOTEQUALS
	lda prev_direction
	; Compare with pure num / var optimization
	cmp enemy_direction;keep
	beq UpdateTick_edblock7873
UpdateTick_ctb7871: ;Main true block ;keep 
	; Binary clause Simplified: NOTEQUALS
	clc
	lda #$1
	; cmp #$00 ignored
	beq UpdateTick_eblock7902
UpdateTick_ctb7901: ;Main true block ;keep 
	; Binary clause Simplified: LESS
	jsr GetLowestEnemyBottomY
UpdateTick_binary_clause_temp_var7920 = $54
	sta UpdateTick_binary_clause_temp_var7920
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_sprite_y
	sec
	sbc #$d
	 ; end add / sub var with constant
	sec
	sbc #$0
	 ; end add / sub var with constant
UpdateTick_binary_clause_temp_2_var7921 = $56
	sta UpdateTick_binary_clause_temp_2_var7921
	lda UpdateTick_binary_clause_temp_var7920
	cmp UpdateTick_binary_clause_temp_2_var7921;keep
	bcs UpdateTick_edblock7918
UpdateTick_ctb7916: ;Main true block ;keep 
	
; // If direction changed, drop the formation by MONSTER_DROP_AMOUNT pixels
; // ENABLE_DROP_FLOOR: only drop if the lowest enemy's bottom pixel, after the drop,
; // would still be at least 1 pixel above the player's top pixel.
; // Safe byte check: lowest_bottom_y < player_sprite_y - MONSTER_DROP_AMOUNT - 1
; // Adjust this to tune where the drops stop
	; Optimizer: a = a +/- b
	; Load16bitvariable : monster_vertical_adjustment
	lda monster_vertical_adjustment
	clc
	adc #$d
	sta monster_vertical_adjustment
UpdateTick_edblock7918
	jmp UpdateTick_edblock7903
UpdateTick_eblock7902
	; Optimizer: a = a +/- b
	; Load16bitvariable : monster_vertical_adjustment
	lda monster_vertical_adjustment
	clc
	adc #$d
	sta monster_vertical_adjustment
UpdateTick_edblock7903
UpdateTick_edblock7873
	; Binary clause Simplified: EQUALS
	lda enemyMoveCounter
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne UpdateTick_edblock7927
UpdateTick_ctb7925: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta should_move_enemy
UpdateTick_edblock7927
	jmp UpdateTick_edblock7759
UpdateTick_eblock7758
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
	cmp #$48;keep
	bcc UpdateTick_edblock7934
UpdateTick_ctb7932: ;Main true block ;keep 
	
; // Row 0 uses sprites based on row parameter
; // Clear enemies based on ENEMIES_TO_CLEAR constant
	jsr ClearEnemyAtCounter
	; Test Inc dec D
	dec sequential_clear_counter
UpdateTick_edblock7934
	lda #$1
	; Calling storevariable on generic assign expression
	sta should_move_enemy
UpdateTick_edblock7759
	; Binary clause Simplified: NOTEQUALS
	clc
	lda should_move_enemy
	; cmp #$00 ignored
	beq UpdateTick_edblock7940
UpdateTick_ctb7938: ;Main true block ;keep 
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$48
	sec
	sbc numberOfEnemies
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs UpdateTick_eblock7985
UpdateTick_ctb7984: ;Main true block ;keep 
	; Binary clause Simplified: NOTEQUALS
	clc
	lda enemy_direction
	; cmp #$00 ignored
	beq UpdateTick_eblock8008
UpdateTick_ctb8007: ;Main true block ;keep 
	
; // At maximum speed (moving every 1-2 frames), move 2 pixels to match player speed
; // At slower speeds, move 1 pixel
	; Optimizer: a = a +/- b
	; Load16bitvariable : monster_base_x
	lda monster_base_x
	clc
	adc #$2
	sta monster_base_x
	jmp UpdateTick_edblock8009
UpdateTick_eblock8008
	; Optimizer: a = a +/- b
	; Load16bitvariable : monster_base_x
	lda monster_base_x
	sec
	sbc #$2
	sta monster_base_x
UpdateTick_edblock8009
	jmp UpdateTick_edblock7986
UpdateTick_eblock7985
	; Binary clause Simplified: NOTEQUALS
	clc
	lda enemy_direction
	; cmp #$00 ignored
	beq UpdateTick_eblock8017
UpdateTick_ctb8016: ;Main true block ;keep 
	; Test Inc dec D
	inc monster_base_x
	jmp UpdateTick_edblock8018
UpdateTick_eblock8017
	; Test Inc dec D
	dec monster_base_x
UpdateTick_edblock8018
UpdateTick_edblock7986
UpdateTick_edblock7940
	rts
end_procedure_UpdateTick
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MakeMonsters
	;    Procedure type : User-defined procedure
monster_sprite_color	dc.b	$03
MakeMonsters_block8023
MakeMonsters
	lda #$52
	; Calling storevariable on generic assign expression
	sta monster_base_y
	lda #$12
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
MakeMonsters_shiftbit8024
	cpx #0
	beq MakeMonsters_shiftbitdone8025
	asl
	dex
	jmp MakeMonsters_shiftbit8024
MakeMonsters_shiftbitdone8025
MakeMonsters_bitmask_var8026 = $54
	sta MakeMonsters_bitmask_var8026
	lda $d015
	ora MakeMonsters_bitmask_var8026
	sta $d015
	; Toggle bit with constant
	ora #%100
	sta $d015
	ldx #$2 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit8027
	cpx #0
	beq MakeMonsters_shiftbitdone8028
	asl
	dex
	jmp MakeMonsters_shiftbit8027
MakeMonsters_shiftbitdone8028
MakeMonsters_bitmask_var8029 = $54
	sta MakeMonsters_bitmask_var8029
	lda $d015
	ora MakeMonsters_bitmask_var8029
	sta $d015
	; Toggle bit with constant
	ora #%1000
	sta $d015
	ldx #$3 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit8030
	cpx #0
	beq MakeMonsters_shiftbitdone8031
	asl
	dex
	jmp MakeMonsters_shiftbit8030
MakeMonsters_shiftbitdone8031
MakeMonsters_bitmask_var8032 = $54
	sta MakeMonsters_bitmask_var8032
	lda $d015
	ora MakeMonsters_bitmask_var8032
	sta $d015
	; Toggle bit with constant
	ora #%10000
	sta $d015
	ldx #$4 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit8033
	cpx #0
	beq MakeMonsters_shiftbitdone8034
	asl
	dex
	jmp MakeMonsters_shiftbit8033
MakeMonsters_shiftbitdone8034
MakeMonsters_bitmask_var8035 = $54
	sta MakeMonsters_bitmask_var8035
	lda $d015
	ora MakeMonsters_bitmask_var8035
	sta $d015
	
; // Enable sprite stretching for wider monsters
	; Toggle bit with constant
	lda $d01d
	ora #%10
	sta $d01d
	ldx #$1 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit8036
	cpx #0
	beq MakeMonsters_shiftbitdone8037
	asl
	dex
	jmp MakeMonsters_shiftbit8036
MakeMonsters_shiftbitdone8037
MakeMonsters_bitmask_var8038 = $54
	sta MakeMonsters_bitmask_var8038
	lda $d01d
	ora MakeMonsters_bitmask_var8038
	sta $d01d
	; Toggle bit with constant
	ora #%100
	sta $d01d
	ldx #$2 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit8039
	cpx #0
	beq MakeMonsters_shiftbitdone8040
	asl
	dex
	jmp MakeMonsters_shiftbit8039
MakeMonsters_shiftbitdone8040
MakeMonsters_bitmask_var8041 = $54
	sta MakeMonsters_bitmask_var8041
	lda $d01d
	ora MakeMonsters_bitmask_var8041
	sta $d01d
	; Toggle bit with constant
	ora #%1000
	sta $d01d
	ldx #$3 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit8042
	cpx #0
	beq MakeMonsters_shiftbitdone8043
	asl
	dex
	jmp MakeMonsters_shiftbit8042
MakeMonsters_shiftbitdone8043
MakeMonsters_bitmask_var8044 = $54
	sta MakeMonsters_bitmask_var8044
	lda $d01d
	ora MakeMonsters_bitmask_var8044
	sta $d01d
	; Toggle bit with constant
	ora #%10000
	sta $d01d
	ldx #$4 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit8045
	cpx #0
	beq MakeMonsters_shiftbitdone8046
	asl
	dex
	jmp MakeMonsters_shiftbit8045
MakeMonsters_shiftbitdone8046
MakeMonsters_bitmask_var8047 = $54
	sta MakeMonsters_bitmask_var8047
	lda $d01d
	ora MakeMonsters_bitmask_var8047
	sta $d01d
	rts
end_procedure_MakeMonsters
	
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Main raster interrupt routines.
; // ---------------------------------------------------------------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterChain
	;    Procedure type : User-defined procedure
MainRasterChain
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	; Binary clause Simplified: EQUALS
	lda #$1
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterChain_edblock8052
MainRasterChain_ctb8050: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterChain_edblock8052
	jsr ShowBullet
	
; //border_debug_color := peek(^$D01E, 0);
; //SCREEN_BG_COL := border_debug_color;
; //DisplayScore();
; // Clear sprite collision registers to remove garbage data
; //asm(" lda $D01E");
; //asm(" lda $D01F");
	jsr UpdatePlayerBullet
	
; // Lightweight joystick update only
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
	bne MainRasterChain_eblock8057
MainRasterChain_ctb8056: ;Main true block ;keep 
	
; //inc(border_debug_color);
	; Binary clause Simplified: EQUALS
	clc
	lda previous_fire_state
	; cmp #$00 ignored
	bne MainRasterChain_edblock8072
MainRasterChain_localsuccess8074: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda player_bullet_active
	; cmp #$00 ignored
	bne MainRasterChain_edblock8072
MainRasterChain_ctb8070: ;Main true block ;keep 
	
; // Check fire button with debounce (only fire on button press, not hold)	
	jsr FirePlayerBullet
MainRasterChain_edblock8072
	lda #$1
	; Calling storevariable on generic assign expression
	sta previous_fire_state
	jmp MainRasterChain_edblock8058
MainRasterChain_eblock8057
	lda #$0
	; Calling storevariable on generic assign expression
	sta previous_fire_state
MainRasterChain_edblock8058
	;if player_bullet_active <> 0 then
; //	begin	
; //		
; //SCREEN_BG_COL := border_debug_color;
; //	end;
; // Do heavy work at start of frame where we have most time
; // Increment scoreScore += SCORE_INCREMENT;
; //	if (Score >= 10000) then begin
; //		Score := Score - 10000;
; //		Score2 += 1;
; //	end;
; // Heavy game logic - done here at top of frame
	jsr UpdateTick
	; Binary clause Simplified: EQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterChain_edblock8080
MainRasterChain_ctb8078: ;Main true block ;keep 
	
; // Check collisions AFTER all sprite rows have been displayed
; // Only check when bullet is actively moving (not exploding)
	jsr CheckBulletCollision
MainRasterChain_edblock8080
	; Binary clause Simplified: NOTEQUALS
	clc
	lda #$0
	; Calling storevariable on generic assign expression
	sta row
	jsr RowHasMonsters
	; cmp #$00 ignored
	beq MainRasterChain_eblock8085
MainRasterChain_ctb8084: ;Main true block ;keep 
	; RasterIRQ : Hook a procedure
	lda #$51
	sta $d012
	lda #<MainRasterRow1
	sta $fffe
	lda #>MainRasterRow1
	sta $ffff
	jmp MainRasterChain_edblock8086
MainRasterChain_eblock8085
	; Binary clause Simplified: NOTEQUALS
	clc
	lda #$1
	; Calling storevariable on generic assign expression
	sta row
	jsr RowHasMonsters
	; cmp #$00 ignored
	beq MainRasterChain_eblock8117
MainRasterChain_ctb8116: ;Main true block ;keep 
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$60
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow2
	sta $fffe
	lda #>MainRasterRow2
	sta $ffff
	jmp MainRasterChain_edblock8118
MainRasterChain_eblock8117
	; Binary clause Simplified: NOTEQUALS
	clc
	lda #$2
	; Calling storevariable on generic assign expression
	sta row
	jsr RowHasMonsters
	; cmp #$00 ignored
	beq MainRasterChain_eblock8133
MainRasterChain_ctb8132: ;Main true block ;keep 
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$7a
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow3
	sta $fffe
	lda #>MainRasterRow3
	sta $ffff
	jmp MainRasterChain_edblock8134
MainRasterChain_eblock8133
	; RasterIRQ : Hook a procedure
	lda #$e0
	sta $d012
	lda #<MainRasterPlayer
	sta $fffe
	lda #>MainRasterPlayer
	sta $ffff
MainRasterChain_edblock8134
MainRasterChain_edblock8118
MainRasterChain_edblock8086
	
; // Play music here - called each frame from raster IRQ to advance SID playback
; //call(sidfile_1_play);
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRasterChain
	
; // This interrupt is triggered one time pr raster cycle
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterRow1
	;    Procedure type : User-defined procedure
MainRasterRow1
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	; Binary clause Simplified: EQUALS
	lda #$1
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterRow1_edblock8143
MainRasterRow1_ctb8141: ;Main true block ;keep 
	lda #$2
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterRow1_edblock8143
	
; // Prepare sprites for row 1
	; Binary clause Simplified: NOTEQUALS
	clc
	lda #$0
	; Calling storevariable on generic assign expression
	sta row
	jsr RowHasMonsters
	; cmp #$00 ignored
	beq MainRasterRow1_edblock8149
MainRasterRow1_ctb8147: ;Main true block ;keep 
	
; // Update first row of monsters only if there are monsters in that row
	lda #$0
	; Calling storevariable on generic assign expression
	sta rowOffset
	jsr UpdateMonsters
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemyRow
	jsr AnimateMonsters
MainRasterRow1_edblock8149
	; Binary clause Simplified: NOTEQUALS
	clc
	lda #$1
	; Calling storevariable on generic assign expression
	sta row
	jsr RowHasMonsters
	; cmp #$00 ignored
	beq MainRasterRow1_eblock8154
MainRasterRow1_ctb8153: ;Main true block ;keep 
	
; // Choose next raster handler based on which subsequent rows still have monsters
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$60
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow2
	sta $fffe
	lda #>MainRasterRow2
	sta $ffff
	jmp MainRasterRow1_edblock8155
MainRasterRow1_eblock8154
	; Binary clause Simplified: NOTEQUALS
	clc
	lda #$2
	; Calling storevariable on generic assign expression
	sta row
	jsr RowHasMonsters
	; cmp #$00 ignored
	beq MainRasterRow1_eblock8170
MainRasterRow1_ctb8169: ;Main true block ;keep 
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$7a
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow3
	sta $fffe
	lda #>MainRasterRow3
	sta $ffff
	jmp MainRasterRow1_edblock8171
MainRasterRow1_eblock8170
	; RasterIRQ : Hook a procedure
	lda #$e0
	sta $d012
	lda #<MainRasterPlayer
	sta $fffe
	lda #>MainRasterPlayer
	sta $ffff
MainRasterRow1_edblock8171
MainRasterRow1_edblock8155
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
	lda #$1
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterRow2_edblock8180
MainRasterRow2_ctb8178: ;Main true block ;keep 
	lda #$6
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterRow2_edblock8180
	
; // Prepare sprites for row 2
	; Binary clause Simplified: NOTEQUALS
	clc
	lda #$1
	; Calling storevariable on generic assign expression
	sta row
	jsr RowHasMonsters
	; cmp #$00 ignored
	beq MainRasterRow2_edblock8186
MainRasterRow2_ctb8184: ;Main true block ;keep 
	
; //ShowBullet();
; //border_debug_color := peek(^$D01E, 0);
; //SCREEN_BG_COL := border_debug_color;
; //DisplayScore();if player_bullet_active <> 0 then
; //	begin
; //		ShowBullet();
; //		
; //SCREEN_BG_COL := border_debug_color;
; //	end;
; // Update middle row only if it still contains monsters
	lda #$1a
	; Calling storevariable on generic assign expression
	sta rowOffset
	jsr UpdateMonsters
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemyRow
	jsr AnimateMonsters
MainRasterRow2_edblock8186
	; Binary clause Simplified: NOTEQUALS
	clc
	lda #$2
	; Calling storevariable on generic assign expression
	sta row
	jsr RowHasMonsters
	; cmp #$00 ignored
	beq MainRasterRow2_eblock8191
MainRasterRow2_ctb8190: ;Main true block ;keep 
	
; // If bottom row still has monsters, go to row3; otherwise skip to joystick handler
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$7a
	clc
	adc monster_vertical_adjustment
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow3
	sta $fffe
	lda #>MainRasterRow3
	sta $ffff
	jmp MainRasterRow2_edblock8192
MainRasterRow2_eblock8191
	; RasterIRQ : Hook a procedure
	lda #$e0
	sta $d012
	lda #<MainRasterPlayer
	sta $fffe
	lda #>MainRasterPlayer
	sta $ffff
MainRasterRow2_edblock8192
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
	lda #$1
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterRow3_edblock8201
MainRasterRow3_ctb8199: ;Main true block ;keep 
	
; //BorderDebug();
	lda #$5
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterRow3_edblock8201
	
; //ShowBullet();
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	
; // Prepare sprites for row 3
	; Binary clause Simplified: NOTEQUALS
	clc
	lda #$2
	; Calling storevariable on generic assign expression
	sta row
	jsr RowHasMonsters
	; cmp #$00 ignored
	beq MainRasterRow3_edblock8207
MainRasterRow3_ctb8205: ;Main true block ;keep 
	;if player_bullet_active <> 0 then
; //	begin
; //		
; //SCREEN_BG_COL := border_debug_color;
; //	end;
; // Update bottom row only if it still contains monsters
	lda #$34
	; Calling storevariable on generic assign expression
	sta rowOffset
	jsr UpdateMonsters
	lda #$2
	; Calling storevariable on generic assign expression
	sta enemyRow
	jsr AnimateMonsters
MainRasterRow3_edblock8207
	
; //RasterIRQ(MainRasterJoystick(), 155+monster_vertical_adjustment, @useKernal);
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
end_procedure_MainRasterRow3
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterPlayer
	;    Procedure type : User-defined procedure
MainRasterPlayer
	jsr UpdateSprite
	; Binary clause Simplified: EQUALS
	lda #$1
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterPlayer_edblock8214
MainRasterPlayer_ctb8212: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterPlayer_edblock8214
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
MainRasterPlayer_spritepos8217
	lda $D010
	and #%11111110
	sta $D010
MainRasterPlayer_spriteposcontinue8218
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
	lda #<MainRasterChain
	sta $fffe
	lda #>MainRasterChain
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
	jsr PreclearLeftmostAndBottomEnemies
	jsr MakeMonsters
	; initsid
	lda #0
	tax
	tay
	jsr $1000
	; Disable interrupts
	ldy #$7f    ; $7f = %01111111
	sty $dc0d   ; Turn off CIAs Timer interrupts ;keep
	sty $dd0d   ; Turn off CIAs Timer interrupts ;keep
	lda $dc0d   ; cancel all CIA-IRQs in queue/unprocessed ;keep
	lda $dd0d   ; cancel all CIA-IRQs in queue/unprocessed ;keep
	; Set Memory Config
	lda $01
	and #%11111000
	ora #%101
	sta $01
	; Disable interrupts
	sty $dc0d   ; Turn off CIAs Timer interrupts ;keep
	sty $dd0d   ; Turn off CIAs Timer interrupts ;keep
	lda $dc0d   ; cancel all CIA-IRQs in queue/unprocessed ;keep
	lda $dd0d   ; cancel all CIA-IRQs in queue/unprocessed ;keep
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
	
; // Non-IRQ SID playback (main context). This runs once during init and is safe
; // to execute outside the raster IRQ. Comment/uncomment to test.
; //call(sidfile_1_play); 
; // main-context playback (disabled)
; //call(sidfile_1_play); 
; // alternative: keep commented if you prefer raster IRQ playback
	jmp * ; loop like (�/%
main_block_end_
	; End of program
	; Ending memory block at $5810
DisplayText_stringassignstr6771		dc.b	" "
	dc.b	0
DisplayText_stringassignstr6773		dc.b	"  SCORE(1)"
	dc.b	0
DisplayText_stringassignstr6775		dc.b	"  HI-SCORE"
	dc.b	0
DisplayText_stringassignstr6777		dc.b	"      1740"
	dc.b	0
DisplayText_stringassignstr6779		dc.b	"  SCORE(2)"
	dc.b	0
DisplayText_stringassignstr6781		dc.b	"      1740"
	dc.b	0
DisplayText_stringassignstr6783		dc.b	"lmn"
	dc.b	0
DisplayText_stringassignstr6785		dc.b	"opq"
	dc.b	0
DisplayText_stringassignstr6787		dc.b	"rst"
	dc.b	0
DisplayText_stringassignstr6789		dc.b	"uvw"
	dc.b	0
DisplayText_stringassignstr6791		dc.b	"xyz"
	dc.b	0
DisplayText_stringassignstr6793		dc.b	"!#¤"
	dc.b	0
DisplayText_stringassignstr6795		dc.b	"¤%&"
	dc.b	0
DisplayText_stringassignstr6797		dc.b	"/+*"
	dc.b	0
DisplayText_stringassignstr6799		dc.b	"ooooooooooooooooooooooooooooo"
	dc.b	0
EndBlock5810:

