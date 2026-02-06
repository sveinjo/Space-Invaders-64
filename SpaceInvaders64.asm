
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
Score	dc.w	$26de
Score2	dc.w	$00
tic	dc.b	$37
direction	dc.b	$01
numberOfEnemies	dc.b	$00
offset	dc.b	$08
pos_x	dc.w	$13
sprite_x	dc.b	$13
sprite_y	dc.b	$e2
monster1_x	dc.b	0
monster1_y	dc.b	0
joystick_dir	dc.b	0
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
	; ***********  Defining procedure : initprintdecimal
	;    Procedure type : Built-in function
	;    Requires initialization : no
ipd_div_hi: dc.b 0
ipd_div_lo: dc.b 0
init_printdecimal_div10
	ldx #$11
	lda #$00
	clc
init_printdecimal_loop
	rol
	cmp #$0A
	bcc init_printdecimal_skip
	sbc #$0A
init_printdecimal_skip
	rol ipd_div_lo
	rol ipd_div_hi
	dex
	bne init_printdecimal_loop
	rts
end_procedure_initprintdecimal
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
	; NodeProcedureDecl -1
	; ***********  Defining procedure : Memory_Fill_override_2
	;    Procedure type : User-defined procedure
Memory_Fill_override_2_block35
Memory_Fill_override_2
	lda Memory_v
	ldy #0
memory_fill_loop:
	sta (Memory_p),y
	iny
	cpy Memory_v2
	bne memory_fill_loop
	
	rts
end_procedure_Memory_Fill_override_2
	
; //
; // galenciastars
; //
; // By Alan Bourke in 2021 using Turbo Rascal.
; //
; //	This is a conversion of Jason Aldred's Galencia starfield, taken from his
; //	game of the same name. Jason extracted the starfield ASM code into a standalone
; //	programme (see link below), and this is an Turbo Rascal recreation of that.
; //
; //
; // ---------------------------------------------------------------------------------------------------------------------------------
; // How It Works 
; // ---------------------------------------------------------------------------------------------------------------------------------
; // CreateStarScreen fills the entire character screen with the characters and colours defined in StarfieldRow\StarfieldColours.
; // The character screen starts at location $0400 and is 25 rows of 40 characters. The screen is filled in such a way that chars
; // that are in sequence in the character set will be placed in vertical rows down the screen. 
; // Once this procedure is finished the first 4 rows of the screen will have these characters:
; //
; // :.I..>.QB.V;OWPGLCR.DNC<K?TAS.DXJ=ZBUEAM
; // ;.JA.?.RC.W<PXQHMD:.EOD=L.UBTAEYK>.CVFBN
; // <.KB...:D.X=QYRINE;AFPE>MAVCUBFZL?.DWGCO
; // =.LC.A.;EAY>RZ:JOF<BGQF?NBWDVCG.M..EXHDP
; //
; // Note the ':' and the ';' below it at the top left. These two characters are numbers 58 and 59 in the character set. We have copied
; // the character set into RAM starting at location $3000 (12288 decimal) . 'Star1Ptr' starts off pointing at 'Star1Init', which is 
; // location $31D0 (12572 decimal). 12288 - 12572 = 464 bytes or 58 characters. Therefore 'Star1Ptr' starts off pointing at the first
; // byte\row of the ':' character in memory. From there the 'DoStarField()' loop will place a star shape into that memory location and 
; // on the next pass erase it and draw it one byte down. This produces the falling stars.
; //
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Resources
; // ---------------------------------------------------------------------------------------------------------------------------------
; // https:retrocomputing.stackexchange.com/questions/12678/get-exact-position-of-raster-beam-on-c64-c128
; // VICE monitor io d000
; // https:retrocomputing.stackexchange.com/questions/7528/commodore-8-bit-character-sets/8278
; // 
; // Jason Aldred's original Galencia starfield extracted to a standalone program.
; // https:
; //github.com/Jimmy2x2x/C64-Starfield/blob/master/starfield.asm
; //
; // Info about the C64 character set.
; // https:
; //github.com/neilsf/XC-BASIC/tree/master/examples/invaders
; // https:
; //www.c64-wiki.com/wiki/Character_set
; //
; // Info about the C64 memory map.
; // https:
; //www.pagetable.com/c64ref/c64mem/
; // https:
; //github.com/Project-64/reloaded/blob/master/c64/mapc64/MAPC6412.TXT
; //
; // GRay Defender's breakdown of how the original ASM works - WATCH THIS.
; // https:
; //www.youtube.com/watch?v=47LakVkR5lg&t=1251s
; //
; //
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
StarField_CreateStarScreen_block36
StarField_CreateStarScreen
	
; //offset : integer;
	; Clear screen with offset
	lda #$20
	ldx #$fa
StarField_CreateStarScreen_clearloop37
	dex
	sta $0000+$400,x
	sta $00fa+$400,x
	sta $01f4+$400,x
	sta $02ee+$400,x
	bne StarField_CreateStarScreen_clearloop37
	
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
StarField_CreateStarScreen_charsetcopy38
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
	bne StarField_CreateStarScreen_charsetcopy38
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
StarField_CreateStarScreen_dtloop39
	tay
	lda StarField_saddr,x
	inx
	inx
	clc
	adc #$28
	bcc StarField_CreateStarScreen_dtnooverflow40
	iny
StarField_CreateStarScreen_dtnooverflow40
	sta StarField_saddr,x
	tya
	sta StarField_saddr+1,x
	cpx #$30
	bcc StarField_CreateStarScreen_dtloop39
	
; // $0400 screen address, 40 characters per column, 25 rows
	; ----------
	; DefineAddressTable address, StartValue, IncrementValue, TableSize
	ldy #>$d800
	lda #<$d800
	ldx #0
	sta StarField_caddr,x   ; Address of table
	tya
	sta StarField_caddr+1,x
StarField_CreateStarScreen_dtloop41
	tay
	lda StarField_caddr,x
	inx
	inx
	clc
	adc #$28
	bcc StarField_CreateStarScreen_dtnooverflow42
	iny
StarField_CreateStarScreen_dtnooverflow42
	sta StarField_caddr,x
	tya
	sta StarField_caddr+1,x
	cpx #$30
	bcc StarField_CreateStarScreen_dtloop41
	
; // $D800 color address, 40 characters per column, 25 rows
	lda #$0
	; Calling storevariable on generic assign expression
	sta StarField_col
StarField_CreateStarScreen_while43
StarField_CreateStarScreen_loopstart47
	; Optimization: replacing a <= N with a <= N-1
	; Binary clause Simplified: LESS
	lda StarField_col
	; Compare with pure num / var optimization
	cmp #$1d;keep
	bcs StarField_CreateStarScreen_localfailed108
	jmp StarField_CreateStarScreen_ctb44
StarField_CreateStarScreen_localfailed108
	jmp StarField_CreateStarScreen_edblock46
StarField_CreateStarScreen_ctb44: ;Main true block ;keep 
	; Load Byte array
	; CAST type NADA
	ldx StarField_col
	lda StarField_StarfieldRow,x 
	; Calling storevariable on generic assign expression
	sta StarField_currentchar
	lda #$0
	; Calling storevariable on generic assign expression
	sta StarField_row
StarField_CreateStarScreen_while110
StarField_CreateStarScreen_loopstart114
	; Binary clause Simplified: LESS
	lda StarField_row
	; Compare with pure num / var optimization
	cmp #$12;keep
	bcs StarField_CreateStarScreen_edblock113
StarField_CreateStarScreen_ctb111: ;Main true block ;keep 
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
	bcc StarField_CreateStarScreen_dtnooverflow140
	iny  ; overflow into high byte
StarField_CreateStarScreen_dtnooverflow140
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
	bne StarField_CreateStarScreen_eblock143
StarField_CreateStarScreen_ctb142: ;Main true block ;keep 
	
; // 83 = heart, 58 = colon
	lda #$53
	; Calling storevariable on generic assign expression
	sta StarField_currentchar
	jmp StarField_CreateStarScreen_edblock144
StarField_CreateStarScreen_eblock143
	; Binary clause Simplified: EQUALS
	lda StarField_currentchar
	; Compare with pure num / var optimization
	cmp #$53;keep
	bne StarField_CreateStarScreen_edblock158
StarField_CreateStarScreen_ctb156: ;Main true block ;keep 
	
; //currentchar := 0;
	lda #$3a
	; Calling storevariable on generic assign expression
	sta StarField_currentchar
StarField_CreateStarScreen_edblock158
StarField_CreateStarScreen_edblock144
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
	bcc StarField_CreateStarScreen_dtnooverflow161
	iny  ; overflow into high byte
StarField_CreateStarScreen_dtnooverflow161
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
	jmp StarField_CreateStarScreen_while110
StarField_CreateStarScreen_edblock113
StarField_CreateStarScreen_loopend115
	; Test Inc dec D
	inc StarField_colourindex
	; Binary clause Simplified: GREATEREQUAL
	lda StarField_colourindex
	; Compare with pure num / var optimization
	cmp #$14;keep
	bcc StarField_CreateStarScreen_edblock165
StarField_CreateStarScreen_ctb163: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta StarField_colourindex
StarField_CreateStarScreen_edblock165
	; Test Inc dec D
	inc StarField_col
	jmp StarField_CreateStarScreen_while43
StarField_CreateStarScreen_edblock46
StarField_CreateStarScreen_loopend48
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
	bne StarField_DoStarfield_edblock172
StarField_DoStarfield_ctb170: ;Main true block ;keep 
	
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
	bcc StarField_DoStarfield_WordAdd183
	inc StarField_StarfieldPtr+1
StarField_DoStarfield_WordAdd183
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
	bne StarField_DoStarfield_edblock188
	lda StarField_StarfieldPtr
	cmp #$98 ;keep
	bne StarField_DoStarfield_edblock188
	jmp StarField_DoStarfield_ctb186
StarField_DoStarfield_ctb186: ;Main true block ;keep 
	lda #$d0
	ldx #$31
	sta StarField_StarfieldPtr
	stx StarField_StarfieldPtr+1
StarField_DoStarfield_edblock188
StarField_DoStarfield_edblock172
	
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
	bcc StarField_DoStarfield_WordAdd191
	inc StarField_StarfieldPtr2+1
StarField_DoStarfield_WordAdd191
	; Binary clause INTEGER: EQUALS
	lda StarField_StarfieldPtr2+1   ; compare high bytes
	cmp #$33 ;keep
	bne StarField_DoStarfield_edblock195
	lda StarField_StarfieldPtr2
	cmp #$60 ;keep
	bne StarField_DoStarfield_edblock195
	jmp StarField_DoStarfield_ctb193
StarField_DoStarfield_ctb193: ;Main true block ;keep 
	lda #$98
	ldx #$32
	sta StarField_StarfieldPtr2
	stx StarField_StarfieldPtr2+1
StarField_DoStarfield_edblock195
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
	bne StarField_DoStarfield_edblock202
StarField_DoStarfield_ctb200: ;Main true block ;keep 
	
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
	bcc StarField_DoStarfield_WordAdd213
	inc StarField_StarfieldPtr3+1
StarField_DoStarfield_WordAdd213
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
	bne StarField_DoStarfield_edblock218
	lda StarField_StarfieldPtr3
	cmp #$98 ;keep
	bne StarField_DoStarfield_edblock218
	jmp StarField_DoStarfield_ctb216
StarField_DoStarfield_ctb216: ;Main true block ;keep 
	lda #$d0
	ldx #$31
	sta StarField_StarfieldPtr3
	stx StarField_StarfieldPtr3+1
StarField_DoStarfield_edblock218
StarField_DoStarfield_edblock202
	
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
	bcc StarField_DoStarfield_WordAdd221
	inc StarField_StarfieldPtr4+1
StarField_DoStarfield_WordAdd221
	lda StarField_StarfieldPtr4
	clc
	adc #$01
	sta StarField_StarfieldPtr4+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc StarField_DoStarfield_WordAdd222
	inc StarField_StarfieldPtr4+1
StarField_DoStarfield_WordAdd222
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
	bne StarField_DoStarfield_edblock227
	lda StarField_StarfieldPtr4
	cmp #$60 ;keep
	bne StarField_DoStarfield_edblock227
	jmp StarField_DoStarfield_ctb225
StarField_DoStarfield_ctb225: ;Main true block ;keep 
	lda #$98
	ldx #$32
	sta StarField_StarfieldPtr4
	stx StarField_StarfieldPtr4+1
StarField_DoStarfield_edblock227
	
; // -- Two static blinking stars.
	lda #$50
	ldx #$32
	sta StarField_StaticStarPtr
	stx StarField_StaticStarPtr+1
	; Binary clause Simplified: LESS
	lda StarField_RasterCount
	; Compare with pure num / var optimization
	cmp #$e6;keep
	bcs StarField_DoStarfield_eblock232
StarField_DoStarfield_ctb231: ;Main true block ;keep 
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
	jmp StarField_DoStarfield_edblock233
StarField_DoStarfield_eblock232
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StarField_StaticStarPtr),y
	iny
	sta (StarField_StaticStarPtr),y
StarField_DoStarfield_edblock233
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
	bcs StarField_DoStarfield_eblock242
StarField_DoStarfield_ctb241: ;Main true block ;keep 
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
	jmp StarField_DoStarfield_edblock243
StarField_DoStarfield_eblock242
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StarField_StaticStarPtr),y
	iny
	sta (StarField_StaticStarPtr),y
StarField_DoStarfield_edblock243
	rts
end_procedure_StarField_DoStarfield
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MakeSprites
	;    Procedure type : User-defined procedure
MakeSprites
	
; // Set all sprites to be multicolor
; //sprite_multicolor:=$ff;	
; // Set common sprite multicolor #1 
	; Assigning memory location
	lda #$5
	; Calling storevariable on generic assign expression
	sta $d025
	
; // Set  common sprite multicolor #2 
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
MakeSprites_shiftbit251
	cpx #0
	beq MakeSprites_shiftbitdone252
	asl
	dex
	jmp MakeSprites_shiftbit251
MakeSprites_shiftbitdone252
MakeSprites_bitmask_var253 = $54
	sta MakeSprites_bitmask_var253
	lda $d015
	ora MakeSprites_bitmask_var253
	sta $d015
	rts
end_procedure_MakeSprites
	; NodeProcedureDecl -1
	; ***********  Defining procedure : DisplayScore
	;    Procedure type : User-defined procedure
DisplayScore
	; MoveTo optimization
	lda #$96
	sta screenmemory
	lda #>$400
	clc
	adc #$00
	sta screenmemory+1
	ldy Score2+1 ;keep
	lda Score2
	sta ipd_div_lo
	sty ipd_div_hi
	ldy #$4 ; optimized, look out for bugs
DisplayScore_printdecimal255
	jsr init_printdecimal_div10 
	ora #$30
	sta (screenmemory),y
	dey
	bpl DisplayScore_printdecimal255
	; MoveTo optimization
	lda #$9b
	sta screenmemory
	lda #>$400
	clc
	adc #$00
	sta screenmemory+1
	ldy Score+1 ;keep
	lda Score
	sta ipd_div_lo
	sty ipd_div_hi
	ldy #$3 ; optimized, look out for bugs
DisplayScore_printdecimal256
	jsr init_printdecimal_div10 
	ora #$30
	sta (screenmemory),y
	dey
	bpl DisplayScore_printdecimal256
	rts
end_procedure_DisplayScore
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateSprite
	;    Procedure type : User-defined procedure
UpdateSprite
	jsr DisplayScore
	
; // Player sprites	
	; Generic 16 bit op
	ldy pos_x+1 ;keep
	lda pos_x
UpdateSprite_rightvarInteger_var260 = $54
	sta UpdateSprite_rightvarInteger_var260
	sty UpdateSprite_rightvarInteger_var260+1
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	lda joystickright
	sec
	sbc joystickleft
	; Testing for byte:  #0
	; RHS is byte, optimization
	bcs UpdateSprite_skip262
	dey
UpdateSprite_skip262
	; Low bit binop:
	clc
	adc UpdateSprite_rightvarInteger_var260
UpdateSprite_wordAdd258
	sta UpdateSprite_rightvarInteger_var260
	; High-bit binop
	tya
	adc UpdateSprite_rightvarInteger_var260+1
	tay
	lda UpdateSprite_rightvarInteger_var260
	; Calling storevariable on generic assign expression
	sta pos_x
	sty pos_x+1
	; Binary clause INTEGER: LESS
	lda pos_x+1   ; compare high bytes
	cmp #$00 ;keep
	bcc UpdateSprite_ctb264
	bne UpdateSprite_eblock265
	lda pos_x
	cmp #$13 ;keep
	bcs UpdateSprite_eblock265
UpdateSprite_ctb264: ;Main true block ;keep 
	
; //pos_x+= (joystickright*2 - joystickleft*2);	
	ldy #0   ; Force integer assignment, set y = 0 for values lower than 255
	lda #$13
	; Calling storevariable on generic assign expression
	sta pos_x
	sty pos_x+1
	jmp UpdateSprite_edblock266
UpdateSprite_eblock265
	; Binary clause INTEGER: GREATER
	lda pos_x+1   ; compare high bytes
	cmp #$00 ;keep
	bcc UpdateSprite_edblock280
	bne UpdateSprite_ctb278
	lda pos_x
	cmp #$ee ;keep
	bcc UpdateSprite_edblock280
	beq UpdateSprite_edblock280
UpdateSprite_ctb278: ;Main true block ;keep 
	ldy #0   ; Force integer assignment, set y = 0 for values lower than 255
	lda #$ee
	; Calling storevariable on generic assign expression
	sta pos_x
	sty pos_x+1
UpdateSprite_edblock280
UpdateSprite_edblock266
	ldy pos_x+1 ;keep
	lda pos_x
	; Calling storevariable on generic assign expression
	sta sprite_x
	
; // Update the sprite position on screen for sprite number @useSprite	
	; Setting sprite position
	; isi-pisi: value is constant
	ldx #0
	sta $D000,x
UpdateSprite_spritepos283
	lda $D010
	and #%11111110
	sta $D010
UpdateSprite_spriteposcontinue284
	inx
	txa
	tay
	lda sprite_y
	sta $D000,y
	; Binary clause Simplified: NOTEQUALS
	clc
	lda joystickright
	; cmp #$00 ignored
	beq UpdateSprite_edblock288
UpdateSprite_ctb286: ;Main true block ;keep 
	
; // Set left/right offset pointer for sprite
	lda #$1
	; Calling storevariable on generic assign expression
	sta joystick_dir
UpdateSprite_edblock288
	; Binary clause Simplified: NOTEQUALS
	clc
	lda joystickleft
	; cmp #$00 ignored
	beq UpdateSprite_edblock294
UpdateSprite_ctb292: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta joystick_dir
UpdateSprite_edblock294
	
; // Set the sprite pointer to point to the sprite data + direction offset
	; Set sprite location
	ldx #$0 ; optimized, look out for bugs
	lda #$80
	sta $07f8 + $0,x
	; Set sprite location
	lda #$1
	sta $50
	; Generic 16 bit op
	ldy #0
	lda joystick_dir
UpdateSprite_rightvarInteger_var299 = $54
	sta UpdateSprite_rightvarInteger_var299
	sty UpdateSprite_rightvarInteger_var299+1
	lda #129
	ldy #0
	; Low bit binop:
	clc
	adc UpdateSprite_rightvarInteger_var299
UpdateSprite_wordAdd297
	sta UpdateSprite_rightvarInteger_var299
	; High-bit binop
	tya
	adc UpdateSprite_rightvarInteger_var299+1
	tay
	lda UpdateSprite_rightvarInteger_var299
	ldx $50
	sta $07f8 + $0,x
	; Set sprite location
	lda #$2
	sta $50
	; Generic 16 bit op
	ldy #0
	lda joystick_dir
UpdateSprite_rightvarInteger_var302 = $54
	sta UpdateSprite_rightvarInteger_var302
	sty UpdateSprite_rightvarInteger_var302+1
	lda #129
	ldy #0
	; Low bit binop:
	clc
	adc UpdateSprite_rightvarInteger_var302
UpdateSprite_wordAdd300
	sta UpdateSprite_rightvarInteger_var302
	; High-bit binop
	tya
	adc UpdateSprite_rightvarInteger_var302+1
	tay
	lda UpdateSprite_rightvarInteger_var302
	ldx $50
	sta $07f8 + $0,x
	; Set sprite location
	lda #$3
	sta $50
	; Generic 16 bit op
	ldy #0
	lda joystick_dir
UpdateSprite_rightvarInteger_var305 = $54
	sta UpdateSprite_rightvarInteger_var305
	sty UpdateSprite_rightvarInteger_var305+1
	lda #129
	ldy #0
	; Low bit binop:
	clc
	adc UpdateSprite_rightvarInteger_var305
UpdateSprite_wordAdd303
	sta UpdateSprite_rightvarInteger_var305
	; High-bit binop
	tya
	adc UpdateSprite_rightvarInteger_var305+1
	tay
	lda UpdateSprite_rightvarInteger_var305
	ldx $50
	sta $07f8 + $0,x
	; Set sprite location
	lda #$4
	sta $50
	; Generic 16 bit op
	ldy #0
	lda joystick_dir
UpdateSprite_rightvarInteger_var308 = $54
	sta UpdateSprite_rightvarInteger_var308
	sty UpdateSprite_rightvarInteger_var308+1
	lda #129
	ldy #0
	; Low bit binop:
	clc
	adc UpdateSprite_rightvarInteger_var308
UpdateSprite_wordAdd306
	sta UpdateSprite_rightvarInteger_var308
	; High-bit binop
	tya
	adc UpdateSprite_rightvarInteger_var308+1
	tay
	lda UpdateSprite_rightvarInteger_var308
	ldx $50
	sta $07f8 + $0,x
	rts
end_procedure_UpdateSprite
	; NodeProcedureDecl -1
	; ***********  Defining procedure : DisplayText
	;    Procedure type : User-defined procedure
DisplayText
	
; //moveto(29,1,hi(screen_char_loc));
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr311
	ldy #>DisplayText_stringassignstr311
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
	lda #<DisplayText_stringassignstr313
	ldy #>DisplayText_stringassignstr313
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
	lda #<DisplayText_stringassignstr315
	ldy #>DisplayText_stringassignstr315
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
	lda #<DisplayText_stringassignstr317
	ldy #>DisplayText_stringassignstr317
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
	lda #<DisplayText_stringassignstr319
	ldy #>DisplayText_stringassignstr319
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
	lda #<DisplayText_stringassignstr321
	ldy #>DisplayText_stringassignstr321
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
	lda #<DisplayText_stringassignstr323
	ldy #>DisplayText_stringassignstr323
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
	lda #<DisplayText_stringassignstr325
	ldy #>DisplayText_stringassignstr325
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
	lda #<DisplayText_stringassignstr327
	ldy #>DisplayText_stringassignstr327
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
	lda #<DisplayText_stringassignstr329
	ldy #>DisplayText_stringassignstr329
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
	lda #<DisplayText_stringassignstr331
	ldy #>DisplayText_stringassignstr331
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
	lda #<DisplayText_stringassignstr333
	ldy #>DisplayText_stringassignstr333
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
	lda #<DisplayText_stringassignstr335
	ldy #>DisplayText_stringassignstr335
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
	lda #<DisplayText_stringassignstr337
	ldy #>DisplayText_stringassignstr337
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
	lda #<DisplayText_stringassignstr339
	ldy #>DisplayText_stringassignstr339
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
	
; //Procedure DisplayText();
; //var
; //	TextCount : byte = 15;
; //	TextLines : array[15] of string = (
; //		" ",
; //		"  SCORE(1)",
; //		"  HI-SCORE",
; //		"      1740",
; //		"  SCORE(2)",
; //		"      1740",
; //		"lmn",
; //		"opq",
; //		"rst",
; //		"uvw",
; //		"xyz",
; //		"!#¤",
; //		"¤%&",
; //		"/+*",
; //		"ooooooooooooooooooooooooooooo"
; //	);
; //	TextX : array[15] of byte = (29,29,29,29,29,29,4,4,10,10,16,16,22,22,0);
; //	TextY : array[15] of byte = (0,1,11,13,21,23,19,20,19,20,19,20,19,20,24);
; //	i : byte;
; //begin	
; //moveto(29,1,hi(screen_char_loc));
; //	for i := 0 to TextCount - 1 do
; //		Screen::PrintString(TextLines[i], TextX[i], TextY[i], #Screen::screen0);
; //end;
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateTick
	;    Procedure type : User-defined procedure
moveNow	dc.b	0
UpdateTick_block340
UpdateTick
	lda #$0
	; Calling storevariable on generic assign expression
	sta moveNow
	; Binary clause Simplified: NOTEQUALS
	clc
	lda tic
	; cmp #$00 ignored
	beq UpdateTick_eblock343
UpdateTick_ctb342: ;Main true block ;keep 
	; Test Inc dec D
	dec tic
	; Binary clause Simplified: GREATEREQUAL
	lda monster1_x
	; Compare with pure num / var optimization
	cmp #$2e;keep
	bcc UpdateTick_eblock382
UpdateTick_ctb381: ;Main true block ;keep 
	
; //move := 0;
; //break;
	lda #$0
	; Calling storevariable on generic assign expression
	sta direction
	jmp UpdateTick_edblock383
UpdateTick_eblock382
	
; //offset := offset + 8;
	; Binary clause Simplified: LESS
	lda monster1_x
	; Compare with pure num / var optimization
	cmp #$19;keep
	bcs UpdateTick_edblock397
UpdateTick_ctb395: ;Main true block ;keep 
	
; //offset := offset + 8;
	lda #$1
	; Calling storevariable on generic assign expression
	sta direction
UpdateTick_edblock397
UpdateTick_edblock383
	; Binary clause Simplified: EQUALS
	lda tic
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne UpdateTick_edblock403
UpdateTick_ctb401: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta moveNow
UpdateTick_edblock403
	jmp UpdateTick_edblock344
UpdateTick_eblock343
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$37
	sec
	sbc numberOfEnemies
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta tic
	; Binary clause Simplified: LESS
	lda numberOfEnemies
	; Compare with pure num / var optimization
	cmp #$36;keep
	bcs UpdateTick_edblock410
UpdateTick_ctb408: ;Main true block ;keep 
	
; // Speed up as enemies decreses
	; Test Inc dec D
	inc numberOfEnemies
UpdateTick_edblock410
	
; //move := 2;
	; 8 bit binop
	; Add/sub where right value is constant number
	lda joystick_dir
	eor #$1
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta joystick_dir
	lda #$1
	; Calling storevariable on generic assign expression
	sta moveNow
UpdateTick_edblock344
	; Binary clause Simplified: NOTEQUALS
	clc
	lda moveNow
	; cmp #$00 ignored
	beq UpdateTick_edblock416
UpdateTick_ctb414: ;Main true block ;keep 
	
; // := monster1_x + 2;
; //dec(monster1_x);	
; //offset := offset + 8;
	; Binary clause Simplified: NOTEQUALS
	clc
	lda direction
	; cmp #$00 ignored
	beq UpdateTick_eblock429
UpdateTick_ctb428: ;Main true block ;keep 
	; Test Inc dec D
	inc monster1_x
	jmp UpdateTick_edblock430
UpdateTick_eblock429
	
; // := monster1_x + 2;
; //inc(monster1_x);
; //offset := offset + 8;
	; Test Inc dec D
	dec monster1_x
UpdateTick_edblock430
UpdateTick_edblock416
	rts
end_procedure_UpdateTick
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ClearMonster
	;    Procedure type : User-defined procedure
i	dc.b	0
X	dc.b	0
p	= $24
ClearMonster_block435
ClearMonster
	lda #$8
	; Calling storevariable on generic assign expression
	sta X
	
; //{ number of bytes to clear }
; //p := ($2000);
	lda #$40
	ldx #$20
	sta p
	stx p+1
	lda #$0
	; Calling storevariable on generic assign expression
	sta i
ClearMonster_forloop436
	lda #$0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (p),y
	
; //inc(p);
	lda p
	clc
	adc #$03
	sta p+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc ClearMonster_WordAdd442
	inc p+1
ClearMonster_WordAdd442
ClearMonster_loopstart437
	; Compare is onpage
	; Test Inc dec D
	inc i
	; 8 bit binop
	; Add/sub where right value is constant number
	lda X
	sec
	sbc #$0
	 ; end add / sub var with constant
	cmp i ;keep
	bne ClearMonster_forloop436
ClearMonster_loopdone443: ;keep
ClearMonster_loopend438
	rts
end_procedure_ClearMonster
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateMonsters
	;    Procedure type : User-defined procedure
UpdateMonsters
	
; // Update the sprite position on screen for sprite monsterSprite
	; Setting sprite position
	; isi-pisi: value is constant
	lda monster1_x
	ldx #2
	sta $D000,x
UpdateMonsters_spritepos445
	lda $D010
	and #%11111101
	sta $D010
UpdateMonsters_spriteposcontinue446
	inx
	txa
	tay
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_y
	clc
	adc offset
	 ; end add / sub var with constant
	sta $D000,y
	; Setting sprite position
	; isi-pisi: value is constant
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_x
	clc
	adc #$36
	 ; end add / sub var with constant
	ldx #4
	sta $D000,x
UpdateMonsters_spritepos447
	lda $D010
	and #%11111011
	sta $D010
UpdateMonsters_spriteposcontinue448
	inx
	txa
	tay
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_y
	clc
	adc offset
	 ; end add / sub var with constant
	sta $D000,y
	; Setting sprite position
	; isi-pisi: value is constant
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_x
	clc
	adc #$6c
	 ; end add / sub var with constant
	ldx #6
	sta $D000,x
UpdateMonsters_spritepos449
	lda $D010
	and #%11110111
	sta $D010
UpdateMonsters_spriteposcontinue450
	inx
	txa
	tay
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_y
	clc
	adc offset
	 ; end add / sub var with constant
	sta $D000,y
	; Setting sprite position
	; isi-pisi: value is constant
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_x
	clc
	adc #$a2
	 ; end add / sub var with constant
	ldx #8
	sta $D000,x
UpdateMonsters_spritepos451
	lda $D010
	and #%11101111
	sta $D010
UpdateMonsters_spriteposcontinue452
	inx
	txa
	tay
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_y
	clc
	adc offset
	 ; end add / sub var with constant
	sta $D000,y
	rts
end_procedure_UpdateMonsters
	
; //	
; // Set the sprite pointer to point to the sprite data + direction offset
; //	SetSpriteLoc(useSprite, 8192/64 + joystick_dir, useBank);
; //	
; // If any movement is detected, play a random sound
; //	if ((joystickright+joystickleft) or (joystickup+joystickdown)) then
; //		PlaySound(sid_channel1, 
; //		13,  
; // Volume
; //		20+Random()/16,  
; // Hi byte frequency
; //		0*16+0,  
; // Attack voice 1
; //		3*16 + 3,   
; // Sustain = 16*15 + release=6
; //		1 +sid_saw,  
; // Waveform
; //		sid_saw);  
; // waveform
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateMonsters2
	;    Procedure type : User-defined procedure
UpdateMonsters2
	; Setting sprite position
	; isi-pisi: value is constant
	lda monster1_x
	ldx #2
	sta $D000,x
UpdateMonsters2_spritepos454
	lda $D010
	and #%11111101
	sta $D010
UpdateMonsters2_spriteposcontinue455
	inx
	txa
	tay
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_y
	clc
	adc #$1a
	 ; end add / sub var with constant
	clc
	adc offset
	 ; end add / sub var with constant
	sta $D000,y
	; Setting sprite position
	; isi-pisi: value is constant
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_x
	clc
	adc #$36
	 ; end add / sub var with constant
	ldx #4
	sta $D000,x
UpdateMonsters2_spritepos456
	lda $D010
	and #%11111011
	sta $D010
UpdateMonsters2_spriteposcontinue457
	inx
	txa
	tay
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_y
	clc
	adc #$1a
	 ; end add / sub var with constant
	clc
	adc offset
	 ; end add / sub var with constant
	sta $D000,y
	; Setting sprite position
	; isi-pisi: value is constant
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_x
	clc
	adc #$6c
	 ; end add / sub var with constant
	ldx #6
	sta $D000,x
UpdateMonsters2_spritepos458
	lda $D010
	and #%11110111
	sta $D010
UpdateMonsters2_spriteposcontinue459
	inx
	txa
	tay
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_y
	clc
	adc #$1a
	 ; end add / sub var with constant
	clc
	adc offset
	 ; end add / sub var with constant
	sta $D000,y
	; Setting sprite position
	; isi-pisi: value is constant
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_x
	clc
	adc #$a2
	 ; end add / sub var with constant
	ldx #8
	sta $D000,x
UpdateMonsters2_spritepos460
	lda $D010
	and #%11101111
	sta $D010
UpdateMonsters2_spriteposcontinue461
	inx
	txa
	tay
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_y
	clc
	adc #$1a
	 ; end add / sub var with constant
	clc
	adc offset
	 ; end add / sub var with constant
	sta $D000,y
	rts
end_procedure_UpdateMonsters2
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateMonsters3
	;    Procedure type : User-defined procedure
UpdateMonsters3
	; Setting sprite position
	; isi-pisi: value is constant
	lda monster1_x
	ldx #2
	sta $D000,x
UpdateMonsters3_spritepos463
	lda $D010
	and #%11111101
	sta $D010
UpdateMonsters3_spriteposcontinue464
	inx
	txa
	tay
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_y
	clc
	adc #$34
	 ; end add / sub var with constant
	clc
	adc offset
	 ; end add / sub var with constant
	sta $D000,y
	; Setting sprite position
	; isi-pisi: value is constant
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_x
	clc
	adc #$36
	 ; end add / sub var with constant
	ldx #4
	sta $D000,x
UpdateMonsters3_spritepos465
	lda $D010
	and #%11111011
	sta $D010
UpdateMonsters3_spriteposcontinue466
	inx
	txa
	tay
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_y
	clc
	adc #$34
	 ; end add / sub var with constant
	clc
	adc offset
	 ; end add / sub var with constant
	sta $D000,y
	; Setting sprite position
	; isi-pisi: value is constant
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_x
	clc
	adc #$6c
	 ; end add / sub var with constant
	ldx #6
	sta $D000,x
UpdateMonsters3_spritepos467
	lda $D010
	and #%11110111
	sta $D010
UpdateMonsters3_spriteposcontinue468
	inx
	txa
	tay
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_y
	clc
	adc #$34
	 ; end add / sub var with constant
	clc
	adc offset
	 ; end add / sub var with constant
	sta $D000,y
	; Setting sprite position
	; isi-pisi: value is constant
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_x
	clc
	adc #$a2
	 ; end add / sub var with constant
	ldx #8
	sta $D000,x
UpdateMonsters3_spritepos469
	lda $D010
	and #%11101111
	sta $D010
UpdateMonsters3_spriteposcontinue470
	inx
	txa
	tay
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster1_y
	clc
	adc #$34
	 ; end add / sub var with constant
	clc
	adc offset
	 ; end add / sub var with constant
	sta $D000,y
	rts
end_procedure_UpdateMonsters3
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MakeMonsters
	;    Procedure type : User-defined procedure
monsterColour	dc.b	$03
MakeMonsters_block471
MakeMonsters
	
; //const P : address = $2000;
	lda #$52
	; Calling storevariable on generic assign expression
	sta monster1_y
	lda #$20
	; Calling storevariable on generic assign expression
	sta monster1_x
	
; // Set all sprites to be multicolor
; //sprite_multicolor:=$ff;
; // Set common sprite multicolor #1 
; //sprite_multicolor_reg1:=green;
; // Set  common sprite multicolor #2 
; //sprite_multicolor_reg2:=white;
; // Set sprite "0" individual color value 
	lda monsterColour
	; Calling storevariable on generic assign expression
	sta $D027+$1
	; Calling storevariable on generic assign expression
	sta $D027+$2
	; Calling storevariable on generic assign expression
	sta $D027+$3
	; Calling storevariable on generic assign expression
	sta $D027+$4
	
; // Mask sprite
	jsr ClearMonster
	;sprite_color[monsterSprite2]:=light_red;
; //	sprite_color[monsterSprite3]:=light_red;
; //	sprite_color[monsterSprite4]:=light_red;
; // Turn on sprite 0 (or @useSprite)
	; Toggle bit with constant
	lda $d015
	ora #%10
	sta $d015
	ldx #$1 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit472
	cpx #0
	beq MakeMonsters_shiftbitdone473
	asl
	dex
	jmp MakeMonsters_shiftbit472
MakeMonsters_shiftbitdone473
MakeMonsters_bitmask_var474 = $54
	sta MakeMonsters_bitmask_var474
	lda $d015
	ora MakeMonsters_bitmask_var474
	sta $d015
	; Toggle bit with constant
	ora #%100
	sta $d015
	ldx #$2 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit475
	cpx #0
	beq MakeMonsters_shiftbitdone476
	asl
	dex
	jmp MakeMonsters_shiftbit475
MakeMonsters_shiftbitdone476
MakeMonsters_bitmask_var477 = $54
	sta MakeMonsters_bitmask_var477
	lda $d015
	ora MakeMonsters_bitmask_var477
	sta $d015
	; Toggle bit with constant
	ora #%1000
	sta $d015
	ldx #$3 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit478
	cpx #0
	beq MakeMonsters_shiftbitdone479
	asl
	dex
	jmp MakeMonsters_shiftbit478
MakeMonsters_shiftbitdone479
MakeMonsters_bitmask_var480 = $54
	sta MakeMonsters_bitmask_var480
	lda $d015
	ora MakeMonsters_bitmask_var480
	sta $d015
	; Toggle bit with constant
	ora #%10000
	sta $d015
	ldx #$4 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit481
	cpx #0
	beq MakeMonsters_shiftbitdone482
	asl
	dex
	jmp MakeMonsters_shiftbit481
MakeMonsters_shiftbitdone482
MakeMonsters_bitmask_var483 = $54
	sta MakeMonsters_bitmask_var483
	lda $d015
	ora MakeMonsters_bitmask_var483
	sta $d015
	; Toggle bit with constant
	lda $d01d
	ora #%10
	sta $d01d
	ldx #$1 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit484
	cpx #0
	beq MakeMonsters_shiftbitdone485
	asl
	dex
	jmp MakeMonsters_shiftbit484
MakeMonsters_shiftbitdone485
MakeMonsters_bitmask_var486 = $54
	sta MakeMonsters_bitmask_var486
	lda $d01d
	ora MakeMonsters_bitmask_var486
	sta $d01d
	; Toggle bit with constant
	ora #%100
	sta $d01d
	ldx #$2 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit487
	cpx #0
	beq MakeMonsters_shiftbitdone488
	asl
	dex
	jmp MakeMonsters_shiftbit487
MakeMonsters_shiftbitdone488
MakeMonsters_bitmask_var489 = $54
	sta MakeMonsters_bitmask_var489
	lda $d01d
	ora MakeMonsters_bitmask_var489
	sta $d01d
	; Toggle bit with constant
	ora #%1000
	sta $d01d
	ldx #$3 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit490
	cpx #0
	beq MakeMonsters_shiftbitdone491
	asl
	dex
	jmp MakeMonsters_shiftbit490
MakeMonsters_shiftbitdone491
MakeMonsters_bitmask_var492 = $54
	sta MakeMonsters_bitmask_var492
	lda $d01d
	ora MakeMonsters_bitmask_var492
	sta $d01d
	; Toggle bit with constant
	ora #%10000
	sta $d01d
	ldx #$4 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit493
	cpx #0
	beq MakeMonsters_shiftbitdone494
	asl
	dex
	jmp MakeMonsters_shiftbit493
MakeMonsters_shiftbitdone494
MakeMonsters_bitmask_var495 = $54
	sta MakeMonsters_bitmask_var495
	lda $d01d
	ora MakeMonsters_bitmask_var495
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
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	
; // Score counter
	lda Score
	clc
	adc #$09
	sta Score+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc MainRasterRow1_WordAdd497
	inc Score+1
MainRasterRow1_WordAdd497
	; Binary clause INTEGER: GREATEREQUAL
	lda Score+1   ; compare high bytes
	cmp #$27 ;keep
	bcc MainRasterRow1_edblock501
	bne MainRasterRow1_ctb499
	lda Score
	cmp #$10 ;keep
	bcc MainRasterRow1_edblock501
MainRasterRow1_ctb499: ;Main true block ;keep 
	lda Score
	sec
	sbc #$10
	sta Score+0
	lda Score+1
	sbc #$27
	sta Score+1
	lda Score2
	clc
	adc #$01
	sta Score2+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc MainRasterRow1_WordAdd507
	inc Score2+1
MainRasterRow1_WordAdd507
MainRasterRow1_edblock501
	
; //SCREEN_BG_COL:=RED;
	jsr UpdateMonsters
	
; //Async version. Faster but less reliable.      
; //RasterIRQ(MainRasterRow2(),105+offset,@useKernal);
; // WaitForRaster version. First working copy.	
; //SCREEN_BG_COL:=RED;	
	; wait for raster
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$68
	clc
	adc offset
	 ; end add / sub var with constant
	tax
	cpx $d012
	bne *-3
	
; //SCREEN_BG_COL:=GREEN;
	jsr UpdateMonsters2
	; wait for raster
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$82
	clc
	adc offset
	 ; end add / sub var with constant
	tax
	cpx $d012
	bne *-3
	
; //SCREEN_BG_COL:=BLUE;
	jsr UpdateMonsters3
	; wait for raster
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$9d
	clc
	adc offset
	 ; end add / sub var with constant
	tax
	cpx $d012
	bne *-3
	
; //SCREEN_BG_COL:=BLACK;
; // Update joystick here
	lda #<joystickup
	ldx #>joystickup
	sta Memory_p
	stx Memory_p+1
	lda #$0
	; Calling storevariable on generic assign expression
	sta Memory_v
	lda #$5
	; Calling storevariable on generic assign expression
	sta Memory_v2
	jsr Memory_Fill_override_2
	lda #%11111111  ; CIA#1 port A = outputs 
	sta $dc03             
	lda #%00000000  ; CIA#1 port B = inputs
	sta $dc02             
	lda $dc00
	sta $50
	jsr callJoystick
	
; // Update sprites
	jsr UpdateSprite
	jsr $1003
	jsr UpdateTick
	; RasterIRQ : Hook a procedure
	lda #$0
	sta $d012
	lda #<MainRasterStarfield
	sta $fffe
	lda #>MainRasterStarfield
	sta $ffff
	
; //RasterIRQ(MainRasterRow1(),0,@useKernal);
; //RasterIRQ(MainRasterRow2(),105,@useKernal);
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRasterRow1
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterStarfield
	;    Procedure type : User-defined procedure
MainRasterStarfield
	
; //UpdateTick();
	; Test Inc dec D
	inc StarField_RasterCount
	jsr StarField_DoStarfield
	sei
	; RasterIRQ : Hook a procedure
	lda #$0
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
	
; //StartRasterChain(Raster1(),$500,useKernal);
; //call(sidfile_1_play);
; //StartRasterChain(MainRasterSprite(),0,1);	
	; Disable interrupts
	sty $dc0d   ; Turn off CIAs Timer interrupts
	sty $dd0d   ; Turn off CIAs Timer interrupts
	
; // Stop handling timer, joystick, keyboard ...
	; Assigning memory location
	lda #$0
	; Calling storevariable on generic assign expression
	sta $d020
	; Assigning memory location
	; Calling storevariable on generic assign expression
	sta $d021
	
; //DefineScreen();
; //SetCharsetLocation(STARFIELD_CHARSETLOC);
; //CopyCharsetFromRom(STARFIELD_CHARSETLOC);
	jsr StarField_CreateStarScreen
	
; // -- Comment this line out to see the effect of the character set being overwritten.
; //ClearCharacterSet();
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
	
; //PreventIRQ();
; //DisableCIAInterrupts();
	; Enable raster IRQ
	lda $d01a
	ora #$01
	sta $d01a
	lda #$1B
	sta $d011
	
; //StartIRQ(useKernal);
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
DisplayText_stringassignstr311		dc.b	" "
	dc.b	0
DisplayText_stringassignstr313		dc.b	"  SCORE(1)"
	dc.b	0
DisplayText_stringassignstr315		dc.b	"  HI-SCORE"
	dc.b	0
DisplayText_stringassignstr317		dc.b	"      1740"
	dc.b	0
DisplayText_stringassignstr319		dc.b	"  SCORE(2)"
	dc.b	0
DisplayText_stringassignstr321		dc.b	"      1740"
	dc.b	0
DisplayText_stringassignstr323		dc.b	"lmn"
	dc.b	0
DisplayText_stringassignstr325		dc.b	"opq"
	dc.b	0
DisplayText_stringassignstr327		dc.b	"rst"
	dc.b	0
DisplayText_stringassignstr329		dc.b	"uvw"
	dc.b	0
DisplayText_stringassignstr331		dc.b	"xyz"
	dc.b	0
DisplayText_stringassignstr333		dc.b	"!#¤"
	dc.b	0
DisplayText_stringassignstr335		dc.b	"¤%&"
	dc.b	0
DisplayText_stringassignstr337		dc.b	"/+*"
	dc.b	0
DisplayText_stringassignstr339		dc.b	"ooooooooooooooooooooooooooooo"
	dc.b	0
EndBlock5810:

