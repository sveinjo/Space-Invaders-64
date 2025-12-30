
 processor 6502
	org $801
StartBlock801:
	; Starting new memory block at $801
	.byte $b ; lo byte of next line
	.byte $8 ; hi byte of next line
	.byte $0a, $00 ; line 10 (lo, hi)
	.byte $9e, $20 ; SYS token and a space
	.byte   $32,$30,$36,$34
	.byte $00, $00, $00 ; end of program
	; Ending memory block at $801
EndBlock801:
	org $810
StartBlock810:
	; Starting new memory block at $810
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
RasterCount	dc.b	0
StarfieldPtr	= $0B
StarfieldPtr2	= $0D
StarfieldPtr3	= $10
StarfieldPtr4	= $12
StaticStarPtr	= $22
StaticStarBlink	dc.b	0
StarfieldRow	dc.b $3a, $5c, $49, $40, $5b, $3e, $5d, $51
	dc.b $42, $5e, $56, $3b, $4f, $57, $50, $47
	dc.b $4c, $43, $52, $5f, $64, $4e, $63, $3c
	dc.b $4b, $3f, $54, $41, $53, $60, $44, $58
	dc.b $4a, $3d, $5a, $62, $55, $65, $61, $4d
StarfieldColours	dc.b $e, $a, $c, $f, $e, $d, $c, $b
	dc.b $a, $e, $e, $a, $e, $f, $e, $d
	dc.b $c, $b, $a, $c
sprite_x	dc.b	$16
sprite_y	dc.b	$e2
joystick_dir	dc.b	0
	; NodeProcedureDecl -1
	; ***********  Defining procedure : init16x8div
	;    Procedure type : Built-in function
	;    Requires initialization : no
initdiv16x8_divisor = $4C     ;$59 used for hi-byte
initdiv16x8_dividend = $4E	  ;$fc used for hi-byte
initdiv16x8_remainder = $50	  ;$fe used for hi-byte
initdiv16x8_result = $4E ;save memory by reusing divident to store the result
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
mul16x8_num1Hi = $4C
mul16x8_num1 = $4E
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
div8x8_c = $4C
div8x8_d = $4E
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
multiplier = $4C
multiplier_a = $4E
multiply_eightbit
	cpx #$00
	beq mul_end
	dex
	stx $4E
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
screen_x = $4C
screen_y = $4E
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
print_text = $4C
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
; //
; //
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
; // The colour values corresponding to the characters.
; // sprite_x is an integer since x values range between 0 and 320
; // joystick_dir is used to display either left or right-pointing sprite
; // sprite location is where we keep the sprite in the memory.
; // also used for setspriteloc that needs this value divided by 64
; // In this tuturial, we use sprite "0" as the default one
; // Use joystick port 2
; // Include the sprite binary file. The original 
; // image is located under sprites/sprites.flf 
; // Export all sprites automatically on each build
; //@export "resources/sprites/sprites.flf" "resources/sprites/sprites.bin" 256 	  	
; //sprites:incbin("resources/sprites/sprites.bin", 8192); 
	; NodeProcedureDecl -1
	; ***********  Defining procedure : InitSprites
	;    Procedure type : User-defined procedure
InitSprites
	
; // Set all sprites to be multicolor
	; Assigning memory location
	lda #$ff
	; Calling storevariable on generic assign expression
	sta $d01c
	
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
	lda #$a
	; Calling storevariable on generic assign expression
	sta $D027+$0
	
; // Turn on sprite 0 (or @useSprite)
	; Toggle bit with constant
	lda $d015
	ora #%1
	sta $d015
	ldx #$0 ; optimized, look out for bugs
	lda #1
InitSprites_shiftbit37
	cpx #0
	beq InitSprites_shiftbitdone38
	asl
	dex
	jmp InitSprites_shiftbit37
InitSprites_shiftbitdone38
InitSprites_bitmask_var39 = $54
	sta InitSprites_bitmask_var39
	lda $d015
	ora InitSprites_bitmask_var39
	sta $d015
	rts
end_procedure_InitSprites
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateSprite
	;    Procedure type : User-defined procedure
UpdateSprite
	
; // Update sprite position based on joystick values
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub right value is variable/expression
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : joystickleft
	lda joystickleft
	asl
UpdateSprite_rightvarAddSub_var41 = $54
	sta UpdateSprite_rightvarAddSub_var41
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : joystickright
	lda joystickright
	asl
	sec
	sbc UpdateSprite_rightvarAddSub_var41
	clc
	adc sprite_x
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta sprite_x
	
; //sprite_y+= joystickdown - joystickup;
; // Update the sprite position on screen for sprite number @useSprite	
	; Setting sprite position
	; isi-pisi: value is constant
	ldx #0
	sta $D000,x
UpdateSprite_spritepos42
	lda $D010
	and #%11111110
	sta $D010
UpdateSprite_spriteposcontinue43
	inx
	txa
	tay
	lda sprite_y
	sta $D000,y
	; Binary clause Simplified: NOTEQUALS
	clc
	lda joystickleft
	; cmp #$00 ignored
	beq UpdateSprite_edblock47
UpdateSprite_ctb45: ;Main true block ;keep 
	
; // Set left/right offset pointer for sprite
; //if (joystickright) then
; //	joystick_dir := 1;
	lda #$0
	; Calling storevariable on generic assign expression
	sta joystick_dir
UpdateSprite_edblock47
	rts
end_procedure_UpdateSprite
	
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Fills the entire character screen with the characters and colours defined in StarfieldRow\StarfieldColours.
; // ---------------------------------------------------------------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CreateStarScreen
	;    Procedure type : User-defined procedure
currentchar	dc.b	0
colourindex	dc.b	0
col	dc.b	0
row	dc.b	0
saddr	dc.w	 
	org saddr+50
caddr	dc.w	 
	org caddr+50
CreateStarScreen_block50
CreateStarScreen
	
; //offset : integer;
	; ----------
	; DefineAddressTable address, StartValue, IncrementValue, TableSize
	ldy #>$400
	lda #<$400
	ldx #0
	sta saddr,x   ; Address of table
	tya
	sta saddr+1,x
CreateStarScreen_dtloop51
	tay
	lda saddr,x
	inx
	inx
	clc
	adc #$28
	bcc CreateStarScreen_dtnooverflow52
	iny
CreateStarScreen_dtnooverflow52
	sta saddr,x
	tya
	sta saddr+1,x
	cpx #$30
	bcc CreateStarScreen_dtloop51
	
; // $0400 screen address, 40 characters per column, 25 rows
	; ----------
	; DefineAddressTable address, StartValue, IncrementValue, TableSize
	ldy #>$d800
	lda #<$d800
	ldx #0
	sta caddr,x   ; Address of table
	tya
	sta caddr+1,x
CreateStarScreen_dtloop53
	tay
	lda caddr,x
	inx
	inx
	clc
	adc #$28
	bcc CreateStarScreen_dtnooverflow54
	iny
CreateStarScreen_dtnooverflow54
	sta caddr,x
	tya
	sta caddr+1,x
	cpx #$30
	bcc CreateStarScreen_dtloop53
	
; // $D800 color address, 40 characters per column, 25 rows
	lda #$0
	; Calling storevariable on generic assign expression
	sta col
CreateStarScreen_while55
CreateStarScreen_loopstart59
	; Optimization: replacing a <= N with a <= N-1
	; Binary clause Simplified: LESS
	lda col
	; Compare with pure num / var optimization
	cmp #$1d;keep
	bcs CreateStarScreen_localfailed120
	jmp CreateStarScreen_ctb56
CreateStarScreen_localfailed120
	jmp CreateStarScreen_edblock58
CreateStarScreen_ctb56: ;Main true block ;keep 
	; Load Byte array
	; CAST type NADA
	ldx col
	lda StarfieldRow,x 
	; Calling storevariable on generic assign expression
	sta currentchar
	lda #$0
	; Calling storevariable on generic assign expression
	sta row
CreateStarScreen_while122
CreateStarScreen_loopstart126
	; Binary clause Simplified: LESS
	lda row
	; Compare with pure num / var optimization
	cmp #$13;keep
	bcs CreateStarScreen_edblock125
CreateStarScreen_ctb123: ;Main true block ;keep 
	; ----------
	; AddressTable address, xoffset, yoffset
	; yoffset is complex
	lda row
	asl ; *2
	tax
	lda saddr,x   ; Address of table lo
	ldy saddr+1,x   ; Address of table hi
	clc
	adc col
	bcc CreateStarScreen_dtnooverflow152
	iny  ; overflow into high byte
CreateStarScreen_dtnooverflow152
	sta screenmemory
	sty screenmemory+1
	lda currentchar
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (screenmemory),y
	; Test Inc dec D
	inc currentchar
	; Binary clause Simplified: EQUALS
	; Compare with pure num / var optimization
	cmp #$6b;keep
	bne CreateStarScreen_eblock155
CreateStarScreen_ctb154: ;Main true block ;keep 
	
; // 83 = heart, 58 = colon
	lda #$53
	; Calling storevariable on generic assign expression
	sta currentchar
	jmp CreateStarScreen_edblock156
CreateStarScreen_eblock155
	; Binary clause Simplified: EQUALS
	lda currentchar
	; Compare with pure num / var optimization
	cmp #$53;keep
	bne CreateStarScreen_edblock170
CreateStarScreen_ctb168: ;Main true block ;keep 
	
; //currentchar := 0;
	lda #$3a
	; Calling storevariable on generic assign expression
	sta currentchar
CreateStarScreen_edblock170
CreateStarScreen_edblock156
	; ----------
	; AddressTable address, xoffset, yoffset
	; yoffset is complex
	lda row
	asl ; *2
	tax
	lda caddr,x   ; Address of table lo
	ldy caddr+1,x   ; Address of table hi
	clc
	adc col
	bcc CreateStarScreen_dtnooverflow173
	iny  ; overflow into high byte
CreateStarScreen_dtnooverflow173
	sta colormemory
	sty colormemory+1
	; Load Byte array
	; CAST type NADA
	ldx colourindex
	lda StarfieldColours,x 
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (colormemory),y
	; Test Inc dec D
	inc row
	jmp CreateStarScreen_while122
CreateStarScreen_edblock125
CreateStarScreen_loopend127
	; Test Inc dec D
	inc colourindex
	; Binary clause Simplified: GREATEREQUAL
	lda colourindex
	; Compare with pure num / var optimization
	cmp #$14;keep
	bcc CreateStarScreen_edblock177
CreateStarScreen_ctb175: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta colourindex
CreateStarScreen_edblock177
	; Test Inc dec D
	inc col
	jmp CreateStarScreen_while55
CreateStarScreen_edblock58
CreateStarScreen_loopend60
	rts
end_procedure_CreateStarScreen
	
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Update the starfield by redefining bytes in the character set once per frame.
; // ---------------------------------------------------------------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : DoStarfield
	;    Procedure type : User-defined procedure
DoStarfield
	; Binary clause Simplified: EQUALS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda RasterCount
	and #$1
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne DoStarfield_edblock184
DoStarfield_ctb182: ;Main true block ;keep 
	
; // -- Star 1 updates every other frame.
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StarfieldPtr),y
	iny
	sta (StarfieldPtr),y
	lda StarfieldPtr
	clc
	adc #$01
	sta StarfieldPtr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc DoStarfield_WordAdd195
	inc StarfieldPtr+1
DoStarfield_WordAdd195
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	; Load pointer array
	lda (StarfieldPtr),y
	pha
	iny
	lda (StarfieldPtr),y
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
	sta (StarfieldPtr),y
	iny
	txa
	sta (StarfieldPtr),y
	; Binary clause INTEGER: EQUALS
	lda StarfieldPtr+1   ; compare high bytes
	cmp #$32 ;keep
	bne DoStarfield_edblock200
	lda StarfieldPtr
	cmp #$98 ;keep
	bne DoStarfield_edblock200
	jmp DoStarfield_ctb198
DoStarfield_ctb198: ;Main true block ;keep 
	lda #$d0
	ldx #$31
	sta StarfieldPtr
	stx StarfieldPtr+1
DoStarfield_edblock200
DoStarfield_edblock184
	
; // -- Star 2 updates every frame.
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StarfieldPtr2),y
	iny
	sta (StarfieldPtr2),y
	lda StarfieldPtr2
	clc
	adc #$01
	sta StarfieldPtr2+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc DoStarfield_WordAdd203
	inc StarfieldPtr2+1
DoStarfield_WordAdd203
	; Binary clause INTEGER: EQUALS
	lda StarfieldPtr2+1   ; compare high bytes
	cmp #$33 ;keep
	bne DoStarfield_edblock207
	lda StarfieldPtr2
	cmp #$60 ;keep
	bne DoStarfield_edblock207
	jmp DoStarfield_ctb205
DoStarfield_ctb205: ;Main true block ;keep 
	lda #$98
	ldx #$32
	sta StarfieldPtr2
	stx StarfieldPtr2+1
DoStarfield_edblock207
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	; Load pointer array
	lda (StarfieldPtr2),y
	pha
	iny
	lda (StarfieldPtr2),y
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
	sta (StarfieldPtr2),y
	iny
	txa
	sta (StarfieldPtr2),y
	; Binary clause Simplified: EQUALS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda RasterCount
	and #$1
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne DoStarfield_edblock214
DoStarfield_ctb212: ;Main true block ;keep 
	
; // -- Star 3 updates every other frame.
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StarfieldPtr3),y
	iny
	sta (StarfieldPtr3),y
	lda StarfieldPtr3
	clc
	adc #$01
	sta StarfieldPtr3+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc DoStarfield_WordAdd225
	inc StarfieldPtr3+1
DoStarfield_WordAdd225
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	; Load pointer array
	lda (StarfieldPtr3),y
	pha
	iny
	lda (StarfieldPtr3),y
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
	sta (StarfieldPtr3),y
	iny
	txa
	sta (StarfieldPtr3),y
	; Binary clause INTEGER: EQUALS
	lda StarfieldPtr3+1   ; compare high bytes
	cmp #$32 ;keep
	bne DoStarfield_edblock230
	lda StarfieldPtr3
	cmp #$98 ;keep
	bne DoStarfield_edblock230
	jmp DoStarfield_ctb228
DoStarfield_ctb228: ;Main true block ;keep 
	lda #$d0
	ldx #$31
	sta StarfieldPtr3
	stx StarfieldPtr3+1
DoStarfield_edblock230
DoStarfield_edblock214
	
; // -- Star 4 updates two pixels down every frame.
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StarfieldPtr4),y
	iny
	sta (StarfieldPtr4),y
	lda StarfieldPtr4
	clc
	adc #$01
	sta StarfieldPtr4+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc DoStarfield_WordAdd233
	inc StarfieldPtr4+1
DoStarfield_WordAdd233
	lda StarfieldPtr4
	clc
	adc #$01
	sta StarfieldPtr4+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc DoStarfield_WordAdd234
	inc StarfieldPtr4+1
DoStarfield_WordAdd234
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	; Load pointer array
	lda (StarfieldPtr4),y
	pha
	iny
	lda (StarfieldPtr4),y
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
	sta (StarfieldPtr4),y
	iny
	txa
	sta (StarfieldPtr4),y
	; Binary clause INTEGER: EQUALS
	lda StarfieldPtr4+1   ; compare high bytes
	cmp #$33 ;keep
	bne DoStarfield_edblock239
	lda StarfieldPtr4
	cmp #$60 ;keep
	bne DoStarfield_edblock239
	jmp DoStarfield_ctb237
DoStarfield_ctb237: ;Main true block ;keep 
	lda #$98
	ldx #$32
	sta StarfieldPtr4
	stx StarfieldPtr4+1
DoStarfield_edblock239
	
; // -- Two static blinking stars.
	lda #$50
	ldx #$32
	sta StaticStarPtr
	stx StaticStarPtr+1
	; Binary clause Simplified: LESS
	lda RasterCount
	; Compare with pure num / var optimization
	cmp #$e6;keep
	bcs DoStarfield_eblock244
DoStarfield_ctb243: ;Main true block ;keep 
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	; Load pointer array
	lda (StaticStarPtr),y
	pha
	iny
	lda (StaticStarPtr),y
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
	sta (StaticStarPtr),y
	iny
	txa
	sta (StaticStarPtr),y
	jmp DoStarfield_edblock245
DoStarfield_eblock244
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StaticStarPtr),y
	iny
	sta (StaticStarPtr),y
DoStarfield_edblock245
	; 8 bit binop
	; Add/sub where right value is constant number
	lda RasterCount
	ora #$80
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta StaticStarBlink
	lda #$e0
	ldx #$31
	sta StaticStarPtr
	stx StaticStarPtr+1
	; Binary clause Simplified: LESS
	lda RasterCount
	; Compare with pure num / var optimization
	cmp #$e6;keep
	bcs DoStarfield_eblock254
DoStarfield_ctb253: ;Main true block ;keep 
	; HandleVarBinopB16bit
	ldy #0 ; ::HandleVarBinopB16bit 0
	; RHS is pure, optimization
	; Load pointer array
	lda (StaticStarPtr),y
	pha
	iny
	lda (StaticStarPtr),y
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
	sta (StaticStarPtr),y
	iny
	txa
	sta (StaticStarPtr),y
	jmp DoStarfield_edblock255
DoStarfield_eblock254
	; Is simple pointer assigning : p[n] := expr
	ldy #0
	lda #$00
	sta (StaticStarPtr),y
	iny
	sta (StaticStarPtr),y
DoStarfield_edblock255
	; Assigning a string : Screen_p1
	;has array index
	lda #<DoStarfield_stringassignstr263
	ldy #>DoStarfield_stringassignstr263
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
	lda #<DoStarfield_stringassignstr265
	ldy #>DoStarfield_stringassignstr265
	sta Screen_p1
	sty Screen_p1+1
	lda #$1d
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$3
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<DoStarfield_stringassignstr267
	ldy #>DoStarfield_stringassignstr267
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
	lda #<DoStarfield_stringassignstr269
	ldy #>DoStarfield_stringassignstr269
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
	lda #<DoStarfield_stringassignstr271
	ldy #>DoStarfield_stringassignstr271
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
	lda #<DoStarfield_stringassignstr273
	ldy #>DoStarfield_stringassignstr273
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
	lda #<DoStarfield_stringassignstr275
	ldy #>DoStarfield_stringassignstr275
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
	lda #<DoStarfield_stringassignstr277
	ldy #>DoStarfield_stringassignstr277
	sta Screen_p1
	sty Screen_p1+1
	lda #$4
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
	lda #<DoStarfield_stringassignstr279
	ldy #>DoStarfield_stringassignstr279
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
	lda #<DoStarfield_stringassignstr281
	ldy #>DoStarfield_stringassignstr281
	sta Screen_p1
	sty Screen_p1+1
	lda #$a
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
	lda #<DoStarfield_stringassignstr283
	ldy #>DoStarfield_stringassignstr283
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
	lda #<DoStarfield_stringassignstr285
	ldy #>DoStarfield_stringassignstr285
	sta Screen_p1
	sty Screen_p1+1
	lda #$10
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
	lda #<DoStarfield_stringassignstr287
	ldy #>DoStarfield_stringassignstr287
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
	lda #<DoStarfield_stringassignstr289
	ldy #>DoStarfield_stringassignstr289
	sta Screen_p1
	sty Screen_p1+1
	lda #$16
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
	rts
end_procedure_DoStarfield
	
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Main raster interrupt routine.
; // ---------------------------------------------------------------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRaster
	;    Procedure type : User-defined procedure
MainRaster
	; StartIRQ
	asl $d019
	
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
	
; //closeirq();
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	
; // All code must be between StartIrq\CloseIrq
	; Test Inc dec D
	inc RasterCount
	
; // Debug
; //moveto(10,10,$04);
; //printnumber(RasterCount);
	jsr DoStarfield
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRaster
block1
main_block_begin_
	
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Main program loop. Turn CIA interrupts off, copy the character set from ROM into RAM and tell the machine to look at CharSetLoc
; // for its character set, initialise the pointers and start the raster chain off.
; // ---------------------------------------------------------------------------------------------------------------------------------
	jsr InitSprites
	
; //StartRasterChain(MainRasterSprite(),0,1);	
	; Disable interrupts
	ldy #$7f    ; $7f = %01111111
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
	lda $d018
	and #%11110001
	ora #12
	sta $d018
	; Copy charset from ROM
	sei 
	lda #$33 ;from rom - rom visible at d800
	sta $01
	ldy #$00
MainProgram_charsetcopy291
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
	bne MainProgram_charsetcopy291
	lda #$37
	sta $01
	jsr CreateStarScreen
	
; // -- Comment this line out to see the effect of the character set being overwritten.
; //ClearCharacterSet();
	lda #$d0
	ldx #$31
	sta StarfieldPtr
	stx StarfieldPtr+1
	lda #$98
	ldx #$32
	sta StarfieldPtr2
	stx StarfieldPtr2+1
	lda #$40
	sta StarfieldPtr3
	stx StarfieldPtr3+1
	lda #$e0
	sta StarfieldPtr4
	stx StarfieldPtr4+1
	
; // IO area visible at $D000-$DFFF, RAM visible at $A000-$BFFF (NO BASIC) and RAM visible at $E000-$FFFF (NO KERNAL). 
; // This is the typical memory configuration for demo/game development. 
	; Set Memory Config
	lda $01
	and #%11111000
	ora #%101
	sta $01
	sei
	; Disable interrupts
	ldy #$7f    ; $7f = %01111111
	sty $dc0d   ; Turn off CIAs Timer interrupts
	sty $dd0d   ; Turn off CIAs Timer interrupts
	; RasterIRQ : Hook a procedure
	lda #$dc
	sta $d012
	lda #<MainRaster
	sta $fffe
	lda #>MainRaster
	sta $ffff
	; Enable raster IRQ
	lda $d01a
	ora #$01
	sta $d01a
	lda #$1B
	sta $d011
	asl $d019
	cli
	;InitSprites();
; //	StartRasterChain(MainRasterSprite(),0,1);
	jmp * ; loop like (�/%
main_block_end_
	; End of program
	; Ending memory block at $810
DoStarfield_stringassignstr263		dc.b	"  SCORE(1)"
	dc.b	0
DoStarfield_stringassignstr265		dc.b	"      1740"
	dc.b	0
DoStarfield_stringassignstr267		dc.b	"  HI-SCORE"
	dc.b	0
DoStarfield_stringassignstr269		dc.b	"      1740"
	dc.b	0
DoStarfield_stringassignstr271		dc.b	"  SCORE(2)"
	dc.b	0
DoStarfield_stringassignstr273		dc.b	"      1740"
	dc.b	0
DoStarfield_stringassignstr275		dc.b	"AAA"
	dc.b	0
DoStarfield_stringassignstr277		dc.b	"AAA"
	dc.b	0
DoStarfield_stringassignstr279		dc.b	"BBB"
	dc.b	0
DoStarfield_stringassignstr281		dc.b	"BBB"
	dc.b	0
DoStarfield_stringassignstr283		dc.b	"CCC"
	dc.b	0
DoStarfield_stringassignstr285		dc.b	"CCC"
	dc.b	0
DoStarfield_stringassignstr287		dc.b	"DDD"
	dc.b	0
DoStarfield_stringassignstr289		dc.b	"DDD"
	dc.b	0
EndBlock810:

