
 processor 6502
	org $801
StartBlock801:
	; Starting new memory block at $801
	.byte $b ; lo byte of next line
	.byte $8 ; hi byte of next line
	.byte $0a, $00 ; line 10 (lo, hi)
	.byte $9e, $20 ; SYS token and a space
	.byte   $31,$38,$34,$33,$32
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
	org $4800
StartBlock4800:
	; Starting new memory block at $4800
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
StarField_StaticStarPtr	= $24
StarField_StarfieldRow	dc.b $3a, $5c, $49, $40, $5b, $3e, $5d, $51
	dc.b $42, $5e, $56, $3b, $4f, $57, $50, $47
	dc.b $4c, $43, $52, $5f, $64, $4e, $63, $3c
	dc.b $4b, $3f, $54, $41, $53
StarField_StarfieldColours	dc.b $6, $4, $c, $f, $6, $e, $c, $b
	dc.b $4, $6, $6, $4, $6, $f, $6, $e
	dc.b $c, $b, $4, $c
Helpers_temp	dc.w	0
Helpers_arcade_saucer_score_table	dc.b $a, $5, $5, $a, $f, $a, $a, $5
	dc.b $1e, $a, $a, $a, $5, $f, $a
Helpers_arcade_plunger_columns	dc.b $1, $7, $1, $1, $1, $4, $b, $1
	dc.b $6, $3, $1, $1, $b, $9, $2, $8
Helpers_arcade_squiggly_columns	dc.b $2, $b, $4, $7, $a, $5, $2, $5
	dc.b $4, $6, $7, $8, $a, $6, $a, $3
Helpers_arcade_speed_threshold	dc.b $32, $28, $1e, $14, $a, $5, $3, $2
	dc.b $1
Helpers_arcade_speed_delay	dc.b $32, $28, $1e, $14, $a, $5, $3, $2
	dc.b $1
advancelevel_palette_level	dc.b	0
flagGotoNextLevel	dc.b	$00
startUpDirty	dc.b	$01
highScore	dc.w	$00
highScoreDirty	dc.b	$01
score	dc.w	$00
score_dirty	dc.b	$01
level_dirty	dc.b	$01
enemyMoveCounter	dc.b	$47
current_speed_delay	dc.b	$32
enemy_direction	dc.b	$01
numberOfEnemies	dc.b	$00
current_level	dc.b	$00
total_level_counter	dc.b	$00
get_ready_mode	dc.b	$00
get_ready_prev_fire	dc.b	$00
startup_mode	dc.b	$01
startup_prev_inputs	dc.b	$00
startup_char_buffer	dc.b	 
	org startup_char_buffer+256
startup_color_buffer	dc.b	 
	org startup_color_buffer+256
level_advance_pending	dc.b	$00
level_advance_ready	dc.b	$00
pending_palette	dc.b	$00
pal_col1	dc.b	$00
pal_col2	dc.b	$00
pal_col3	dc.b	$00
pal_col4	dc.b	$00
pal_col5	dc.b	$00
pal_col6	dc.b	$00
get_ready_char_buffer	dc.b	 
	org get_ready_char_buffer+50
get_ready_color_buffer	dc.b	 
	org get_ready_color_buffer+50
ufo_x	dc.b	$18
ufo_direction	dc.b	$01
ufo_move_skip_counter	dc.b	$00
ufo_active	dc.b	$00
ufo_spawn_timer	dc.w	$600
player_shot_count	dc.b	$00
ufo_explode_counter	dc.b	$00
ufo_score_sprite	dc.b	$13
ufo_bullet_active	dc.b $0, $0, $0
ufo_bullet_x	dc.b $0, $0, $0
ufo_bullet_y	dc.b $0, $0, $0
ufo_bullet_anim_index	dc.b $0, $0, $0
ufo_bullet_anim_tick	dc.b $0, $0, $0
ufo_bullet_explode_counter	dc.b $0, $0, $0
ufo_bullet_sprite	dc.b $6, $5, $7
ufo_bullet_anim_start	dc.b $d, $9, $5
ufo_bullet_stagger_counter	dc.b	$00
SHIELD_X_MIN	dc.b $2d, $5d, $8d, $bd
SHIELD_X_MAX	dc.b $45, $75, $a5, $d5
SHIELD_DST	dc.w $3380, $33b0, $33e0, $3410
shield_glyph_stage	dc.b	 
	org shield_glyph_stage+48
ufo_bullet_next_to_fire	dc.b	$00
es_plunger_step	dc.b	$00
es_squiggly_step	dc.b	$00
player_bullet_active	dc.b	$00
player_bullet_x	dc.b	0
player_bullet_y	dc.b	0
explosion_frame_counter	dc.b	$00
previous_fire_state	dc.b	$00
shield_surface_top	dc.b $f, $f, $f, $f, $f, $f, $f, $f
	dc.b $f, $f, $f, $f
shield_surface_bot	dc.b $0, $0, $0, $0, $0, $0, $0, $0
	dc.b $0, $0, $0, $0
shield_top_eroded	dc.b $0, $0, $0, $0
pending_shield_erosion	dc.b	$00
pending_shield_idx	dc.b	$00
pending_byte_col	dc.b	$00
pending_erase_top	dc.b	$00
pending_erosion_dir	dc.b	$00
enemy_march_tick	dc.b	$00
cbc_found_hit	dc.b	$00
cesc_contact_done	dc.b	$00
player_sprite_x	dc.b	$27
player_sprite_y	dc.b	$e2
remaining_ships	dc.b	$03
lifeLostDirty	dc.b	$00
player_respawn_state	dc.b	$00
player_respawn_counter	dc.b	$00
player_explosion_anim_index	dc.b	$00
player_explosion_flash_counter	dc.b	$00
game_over_mode	dc.b	$00
game_over_prev_fire	dc.b	$00
game_over_char_buffer	dc.b	 
	org game_over_char_buffer+18
game_over_color_buffer	dc.b	 
	org game_over_color_buffer+18
monster_base_x	dc.b	0
monster_base_y	dc.b	0
cached_rightmost_offset	dc.b	$c6
cached_leftmost_offset	dc.b	$00
pending_edge_rescan	dc.b	$00
block_enemies	dc.b $3f, $3f, $3f, $3f, $3f, $3f, $3f, $3f
	dc.b $3f, $3f, $3f, $3f
row_has_monsters	dc.b $1, $1, $1
monster_animation_frame	dc.b	0
ufo_bullet_reload_timer	dc.b $0, $0, $0
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
	; ***********  Defining procedure : StarField_SetStarfieldColors
	;    Procedure type : User-defined procedure
StarField_colorPatternExt	dc.b	 
	org StarField_colorPatternExt+29
StarField_col1	dc.b	0
StarField_col2	dc.b	0
StarField_col3	dc.b	0
StarField_col4	dc.b	0
StarField_col5	dc.b	0
StarField_col6	dc.b	0
StarField_SetStarfieldColors_block35
StarField_SetStarfieldColors
	
; // Build the 29-column color lookup directly from the 6 input colors.
; // Entries 0-19 follow the predefined pattern; entries 20-28 wrap back to pattern[0-8].
	lda StarField_col1
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$0
	lda StarField_col2
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$1
	lda StarField_col3
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$2
	lda StarField_col4
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$3
	lda StarField_col1
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$4
	lda StarField_col5
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$5
	lda StarField_col3
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$6
	lda StarField_col6
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$7
	lda StarField_col2
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$8
	lda StarField_col1
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$9
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$a
	lda StarField_col2
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$b
	lda StarField_col1
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$c
	lda StarField_col4
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$d
	lda StarField_col1
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$e
	lda StarField_col5
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$f
	lda StarField_col3
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$10
	lda StarField_col6
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$11
	lda StarField_col2
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$12
	lda StarField_col3
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$13
	lda StarField_col1
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$14
	lda StarField_col2
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$15
	lda StarField_col3
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$16
	lda StarField_col4
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$17
	lda StarField_col1
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$18
	lda StarField_col5
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$19
	lda StarField_col3
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$1a
	lda StarField_col6
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$1b
	lda StarField_col2
	; Calling storevariable on generic assign expression
	sta StarField_colorPatternExt+$1c
        ldx #28
ssc_r0  lda StarField_colorPatternExt,x
        sta $D800,x
        dex
        bpl ssc_r0
        ldx #28
ssc_r1  lda StarField_colorPatternExt,x
        sta $D828,x
        dex
        bpl ssc_r1
        ldx #28
ssc_r2  lda StarField_colorPatternExt,x
        sta $D850,x
        dex
        bpl ssc_r2
        ldx #28
ssc_r3  lda StarField_colorPatternExt,x
        sta $D878,x
        dex
        bpl ssc_r3
        ldx #28
ssc_r4  lda StarField_colorPatternExt,x
        sta $D8A0,x
        dex
        bpl ssc_r4
        ldx #28
ssc_r5  lda StarField_colorPatternExt,x
        sta $D8C8,x
        dex
        bpl ssc_r5
        ldx #28
ssc_r6  lda StarField_colorPatternExt,x
        sta $D8F0,x
        dex
        bpl ssc_r6
        ldx #28
ssc_r7  lda StarField_colorPatternExt,x
        sta $D918,x
        dex
        bpl ssc_r7
        ldx #28
ssc_r8  lda StarField_colorPatternExt,x
        sta $D940,x
        dex
        bpl ssc_r8
        ldx #28
ssc_r9  lda StarField_colorPatternExt,x
        sta $D968,x
        dex
        bpl ssc_r9
        ldx #28
ssc_r10 lda StarField_colorPatternExt,x
        sta $D990,x
        dex
        bpl ssc_r10
        ldx #28
ssc_r11 lda StarField_colorPatternExt,x
        sta $D9B8,x
        dex
        bpl ssc_r11
        ldx #28
ssc_r12 lda StarField_colorPatternExt,x
        sta $D9E0,x
        dex
        bpl ssc_r12
        ldx #28
ssc_r13 lda StarField_colorPatternExt,x
        sta $DA08,x
        dex
        bpl ssc_r13
        ldx #28
ssc_r14 lda StarField_colorPatternExt,x
        sta $DA30,x
        dex
        bpl ssc_r14
        ldx #28
ssc_r15 lda StarField_colorPatternExt,x
        sta $DA58,x
        dex
        bpl ssc_r15
        ldx #28
ssc_r16 lda StarField_colorPatternExt,x
        sta $DA80,x
        dex
        bpl ssc_r16
        ldx #28
ssc_r17 lda StarField_colorPatternExt,x
        sta $DAA8,x
        dex
        bpl ssc_r17
	
	
; // Write all 18 rows x 29 columns to color RAM ($D800).
; // Row base = $D800 + row*40. X = 0..28 covers all 29 columns.
; // No ZP pointers used — fully IRQ-safe.
	lda #$6
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$0
	lda #$4
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$1
	lda #$c
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$2
	lda #$f
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$3
	lda #$6
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$4
	lda #$e
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$5
	lda #$c
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$6
	lda #$b
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$7
	lda #$4
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$8
	lda #$6
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$9
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$a
	lda #$4
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$b
	lda #$6
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$c
	lda #$f
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$d
	lda #$6
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$e
	lda #$e
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$f
	lda #$c
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$10
	lda #$b
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$11
	lda #$4
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$12
	lda #$c
	; Calling storevariable on generic assign expression
	sta StarField_StarfieldColours+$13
	rts
end_procedure_StarField_SetStarfieldColors
	
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
	org StarField_saddr+36
StarField_caddr	dc.w	 
	org StarField_caddr+36
StarField_screenmemory	= $22
StarField_colormemory	= $4b
StarField_CreateStarScreen_block36
StarField_CreateStarScreen
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
	cpx #$22
	bcc StarField_CreateStarScreen_dtloop39
	
; // $0400 screen address, 40 chars/row, 18 rows used
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
	cpx #$22
	bcc StarField_CreateStarScreen_dtloop41
	
; // $D800 color address, 40 chars/row, 18 rows used
	lda #$0
	; Calling storevariable on generic assign expression
	sta StarField_colourindex
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
StarField_DoStarfield_edblock202
	
; // -- Star 4 updates two bytes down every frame (fastest layer).
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
	
; // -- Two static blinking stars, visible when RasterCount < 230.
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
	; ***********  Defining procedure : Helpers_Clamp
	;    Procedure type : User-defined procedure
Helpers_value	dc.b	0
Helpers_minVal	dc.b	0
Helpers_maxVal	dc.b	0
Helpers_Clamp_block250
Helpers_Clamp
	; Binary clause Simplified: LESS
	lda Helpers_value
	; Compare with pure num / var optimization
	cmp Helpers_minVal;keep
	bcs Helpers_Clamp_eblock253
Helpers_Clamp_ctb252: ;Main true block ;keep 
	ldy #0 ; Fake 16 bit
	lda Helpers_minVal
	; Calling storevariable on generic assign expression
	; Casting from byte to integer
	sta Helpers_temp
	sty Helpers_temp+1
	jmp Helpers_Clamp_edblock254
Helpers_Clamp_eblock253
	; Binary clause Simplified: GREATER
	lda Helpers_value
	; Compare with pure num / var optimization
	cmp Helpers_maxVal;keep
	bcc Helpers_Clamp_eblock269
	beq Helpers_Clamp_eblock269
Helpers_Clamp_ctb268: ;Main true block ;keep 
	ldy #0 ; Fake 16 bit
	lda Helpers_maxVal
	; Calling storevariable on generic assign expression
	; Casting from byte to integer
	sta Helpers_temp
	sty Helpers_temp+1
	jmp Helpers_Clamp_edblock270
Helpers_Clamp_eblock269
	ldy #0 ; Fake 16 bit
	lda Helpers_value
	; Calling storevariable on generic assign expression
	; Casting from byte to integer
	sta Helpers_temp
	sty Helpers_temp+1
Helpers_Clamp_edblock270
Helpers_Clamp_edblock254
	ldy Helpers_temp+1 ;keep
	lda Helpers_temp
	rts
end_procedure_Helpers_Clamp
	
; // Modulo operation (dividend mod divisor)
; // ============================================================================
; //  2.  ORIGINAL ARCADE GAME CONSTANTS
; // ============================================================================
; //
; //  --- Screen Geometry (arcade hardware) ---
; //  Resolution:  256 x 224 pixels (monitor rotated 90 deg CCW)
; //  VRAM start:  $2400 (1 bit per pixel, column-major, 7 KB)
; //  Frame rate:  60 Hz (two interrupts per frame: mid-screen + vblank)
; //
; //  --- Alien Formation ---
; //  Layout: 5 rows x 11 columns = 55 aliens
; //    Row 1 (top):      Type C  'Octopus'   x 11    10 pts each
; //    Rows 2-3 (mid):   Type B  'Crab'      x 22    20 pts each
; //    Rows 4-5 (bot):   Type A  'Squid'     x 22    30 pts each
; //  Total value per full rack:  110 + 440 + 660 = 1210 points
; //
; //  Grid cell: 16 x 16 pixels (aliens centered within cell)
; //  Alien pixel widths: Type A = 12 px, Type B = 11 px, Type C = 8 px
; //  All sprites stored as 16 columns x 8 rows (rotated-screen format)
; //
; //  --- Extra Life ---
; //  Awarded once at 1500 points (DIP-switch selectable: 1000 or 1500)
; //
; // ============================================================================
; //  3.  SAUCER (MYSTERY SHIP) SCORING TABLE
; // ============================================================================
; //
; //  The saucer score is NOT random. It is determined by how many shots the
; //  player has fired during the current rack. The table cycles every 15 shots.
; //
; //  ROM address: $1D54  (16 BCD entries; index = shot_count mod 15)
; //
; //    Shot #   Score        Shot #   Score
; //    ------   -----        ------   -----
; //      1       100           9       300  <-- "trick shot"
; //      2        50          10       100
; //      3        50          11       100
; //      4       100          12       100
; //      5       150          13        50
; //      6       100          14       150
; //      7       100          15       100
; //      8        50          (repeats)
; //
; //  To always get 300, fire exactly 23 shots then hit the saucer.
; //
; // Saucer score lookup (points / 10, stored as byte to save RAM)
; // Index with: (player_shot_count - 1) mod 15
; // Multiply looked-up value by 10 to get actual score
; // ============================================================================
; //  4.  ALIEN SHOT SYSTEM — THREE SHOT TYPES
; // ============================================================================
; //
; //  The arcade fires up to 3 alien shots simultaneously, each a different type.
; //  Our C64 version maps these to sprite animation frames and hardware sprite
; //  slots as follows:
; //
; //  ┌────────────────┬────────────┬────────────────┬──────────────────────────┐
; //  │ Shot Type      │ Slot Index │ HW Sprite      │ Anim Frames (1-based)    │
; //  ├────────────────┼────────────┼────────────────┼──────────────────────────┤
; //  │ Plunger        │     0      │      6         │  13, 14, 15, 16          │
; //  │ Rolling/Teflon │     1      │      5         │   9, 10, 11, 12          │
; //  │ Squiggly       │     2      │      7         │   5,  6,  7,  8          │
; //  └────────────────┴────────────┴────────────────┴──────────────────────────┘
; //
; //  Arrays:  ufo_bullet_anim_start[3] = (13, 9, 5)   
; // first frame per slot
; //           ufo_bullet_sprite[3]     = ( 6, 5, 7)   
; // HW sprite per slot
; //
; //  ---- Plunger Shot (slot 0, anim 13-16) ----
; //  Fires from a PREDETERMINED column sequence (table below).
; //  Steps through the table sequentially; wraps after 16 entries.
; //  Finds the lowest alive alien in the selected column.
; //  Animation: staircase / diagonal stripe pattern.
; //  CAN be destroyed by the player's bullet (mutual destruction).
; //
; //  ---- Rolling Shot / "Teflon" Shot (slot 1, anim 9-12) ----
; //  ALWAYS targets the player's current X column.
; //  Finds the lowest alive alien in that column and fires from it.
; //  This is the "aimed" shot — the one that chases you.
; //  Animation: cross/plus pattern that rotates.
; //  CANNOT be destroyed by the player's bullet — but the player bullet
; //  IS destroyed on contact (asymmetric collision).
; //  This is the "Teflon" shot referenced in competitive play guides.
; //
; //  In the arcade ROM the Rolling shot's handler ($0644) draws to the
; //  framebuffer via $1491 but NEVER checks the collision flag $2061
; //  afterward.  The Plunger ($0617) and Squiggly ($05E9) handlers DO
; //  check $2061 and mark themselves for removal on overlap.
; //
; //  The player bullet's OWN collision routine ($14D8) runs separately
; //  from the game loop ($16EE).  It detects the Rolling shot's pixels
; //  in the framebuffer, tries to resolve an alien hit at that position,
; //  finds nothing ($151C: JZ $1530), and sets player shot status to 3
; //  (explosion, 16 frames).  The Rolling shot is completely unaware.
; //
; //  Result: player bullet destroyed with explosion, Rolling shot continues.
; //  The Rolling shot CAN still be blocked by shields
; //  (shield erosion applies to all shot types equally).
; //
; //  ---- Squiggly Shot (slot 2, anim 5-8) ----
; //  Same mechanism as Plunger but uses a DIFFERENT column table.
; //  The Squiggly shot is suppressed while the saucer is on screen.
; //  Animation: zigzag / sine-wave pattern.
; //  CAN be destroyed by the player's bullet (mutual destruction).
; //
; //  All three shot types share the same speed: 1 pixel per frame (4 px/step,
; //  with steps every 4 frames at 60 Hz).  The C64 version runs at 60 Hz NTSC,
; //  identical to the arcade, so shots also move exactly 1 px/frame with no
; //  speed adjustment needed.  No bonus pixel is added; the movement code is
; //  simply: bullet_y += 1 once per frame.
; //
; //  CAUTION: Do NOT apply a 50 Hz PAL correction here — this game targets NTSC.
; //
; //  Fire rate — arcade reload timer (RAM $206F, decremented each frame):
; //    Reload value at full rack = $30 = 48 frames @ 60 Hz — ~0.8 s between shots.
; //    Decreases as aliens die; the C64 version approximates this with the formula:
; //      reload = alive - ES_SHOT_RELOAD_OFFSET (= 7)
; //    giving 48 frames at 55 enemies and scaling linearly to ES_SHOT_RELOAD_MIN
; //    (8 frames) as the rack empties.
; //
; //  IMPORTANT: INITIAL_INVADER_COUNT in the main program is 71 (array-sizing
; //    convenience) but the game pre-clears 16 enemies at startup, so only 55
; //    aliens are alive at round start.  ALL fire-rate and speed calibrations
; //    must use 55 as the full-rack count, never 71.
; //
; //  ---- Shot-vs-Shot Collision Hitboxes ----
; //  Active pixels are positioned at the BOTTOM of the 24×21 sprite box,
; //  horizontally centered 1 pixel LEFT of the sprite's true centre
; //  (X offset 11 in a 24px-wide box).
; //
; //  ┌──────────────────┬───────┬────────┬──────────────────────────────────┐
; //  │ Bullet           │ Width │ Height │ Active area (sprite-local X, Y)  │
; //  ├──────────────────┼───────┼────────┼──────────────────────────────────┤
; //  │ Player bullet    │  1 px │  4 px  │ (11, 17) – (11, 20)             │
; //  │ Enemy shot       │  3 px │  7 px  │ (10, 14) – (12, 20)             │
; //  └──────────────────┴───────┴────────┴──────────────────────────────────┘
; //
; //  AABB overlap conditions (derived from the pixel positions above):
; //    X overlap:  |player_x - enemy_x|  <=  1
; //    Y overlap:  player_y  >=  enemy_y - 6   AND   player_y  <=  enemy_y + 3
; //
; //  ---- Shot-vs-Shot Hit Behaviour (C64 vs Arcade) ----
; //
; //  Three collision scenarios:
; //
; //  1. Plunger or Squiggly vs player bullet → MUTUAL DESTRUCTION
; //     Arcade: Both shots check framebuffer overlap ($2061). Both enter
; //             explosion state. Player bullet shows 16-frame cross explosion
; //             (status 3). Enemy shot is marked for removal (bit 0 of $2073).
; //     C64 LOCKOUT=0: enemy shot explodes (active:=2, ES_SHOT_EXPLODE_DURATION
; //             frames). Player bullet resets immediately (active:=0).
; //     C64 LOCKOUT=1: player bullet enters state 3 (active:=3,
; //             EXPLOSION_DURATION frames, shows enemy-shot explosion sprite).
; //             Enemy shot resets immediately (active:=0, pushed off-screen).
; //
; //  2. Rolling/Teflon vs player bullet → PLAYER BULLET DESTROYED ONLY
; //     Arcade: Rolling handler never checks $2061 so Rolling shot survives.
; //             Player bullet's collision routine ($14D8) detects the overlap,
; //             fails the alien lookup → status 3 (16-frame explosion).
; //     C64:    Player bullet enters state 3 (active:=3, EXPLOSION_DURATION
; //             frames, shows enemy-shot explosion sprite). Rolling shot is
; //             NOT affected — continues moving.
; //
; //  3. Rolling/Teflon vs player bullet (old behaviour, pre-fix) → PASS-THROUGH
; //     Previous C64 implementation skipped collision entirely for Rolling shots.
; //     This was incorrect: in the arcade the player bullet IS destroyed.
; //
; //  Enemy shot explosion duration:
; //    Arcade: ~3-5 frames.   C64: ES_SHOT_EXPLODE_DURATION = 4 frames.
; //
; // Plunger shot fire column table (ROM $1D00, 16 entries)
; // Values 1-11 represent alien formation columns (1 = leftmost)
; // Squiggly shot fire column table (ROM $1D10, 16 entries)
; // ============================================================================
; //  5.  SPEED CURVE — FORMATION MARCH TIMING
; // ============================================================================
; //
; //  The arcade has NO speed table.  Speed is purely emergent:
; //  each frame the game processes ONE alive alien, so a full formation
; //  sweep takes exactly N frames (N = aliens alive).  That sweep moves
; //  the reference position 2 px.  Perceived speed = 2/N px per frame.
; //
; //  On the C64 all aliens move in a single batch, so delay = N gives
; //  identical formation speed.  The table below bins nearby alien counts
; //  into brackets, giving a gentle staircase boost: within each bracket
; //  the delay equals the bracket minimum instead of the exact count.
; //  This compensates slightly for the C64's lack of the arcade's
; //  visual ripple (individual aliens drawn one per frame).
; //
; //    Bracket (alive)    Delay (frames)    Arcade linear
; //    ----------------   ---------------   -------------
; //         >= 50               50              50-54
; //         >= 40               40              40-49
; //         >= 30               30              30-39
; //         >= 20               20              20-29
; //         >= 10               10              10-19
; //         >= 5                 5               5-9
; //         >= 3                 3               3-4
; //         >= 2                 2               2
; //           1                  1               1
; //
; //  Toggle USE_SPEED_TABLE (in the main program) to compare.
; //
; // Speed table: (threshold, delay) pairs — delay = threshold for arcade parity.
; // Walk the table top-down; use the first entry where aliens_remaining >= threshold.
; // ============================================================================
; //  6.  FORMATION MARCH ALGORITHM
; // ============================================================================
; //
; //  The arcade's alien march works as follows (from the ROM at $00E3 onward):
; //
; //  State variables:
; //    refAlienX, refAlienY : position of the "reference alien" (bottom-left)
; //    rackDirection         : 0 = moving left, 1 = moving right
; //    rackDownDelta         : pixels to drop on next direction change
; //
; //  Each game tick:
; //    1. Advance to the next alive alien (column-major scan: bottom-up,
; //       left-to-right).  This means each "step" moves ONE alien, and
; //       it takes 55 steps (or fewer as aliens die) to complete one full
; //       march across the formation.
; //
; //    2. Draw the current alien at its calculated position:
; //         alienX = refAlienX + (column * 16)
; //         alienY = refAlienY + (row * 16)
; //
; //    3. After scanning all aliens (one full march), move the reference
; //       alien by +/-2 pixels horizontally.
; //
; //    4. Edge detection:
; //         If rightmost alien reaches X >= 198 → set direction = left, queue drop
; //         If leftmost alien reaches X <= 26  → set direction = right, queue drop
; //
; //    5. On direction change: drop the formation by rackDownDelta pixels
; //       (initially 8, increases to 10 after the first rack is cleared).
; //
; //    6. The four distinct march sounds (thump 1-4) cycle each full pass.
; //
; //  IMPORTANT: The arcade draws aliens one-at-a-time over multiple frames.
; //  Your C64 version draws entire rows per raster IRQ, which is more
; //  efficient but means the "step" timing maps differently.
; //
; // ============================================================================
; //  7.  ALIEN SHOT COLLISION — SHIELD EROSION
; // ============================================================================
; //
; //  When an alien shot or player shot hits a shield:
; //    1. The shot sprite is XORed with the shield bitmap at the collision point.
; //    2. This erases the shield pixels under the shot, creating a bite pattern.
; //    3. Alien shots erode shields from below; player shots erode from above.
; //    4. After sufficient hits, shots pass through the gap.
; //
; //  The arcade uses 4 shields, each 22 px wide x 16 px tall.
; //  Shield bitmap data is at ROM $1098 (44 bytes = 22 columns x 2 bytes each,
; //  stored in rotated-screen column format like all sprites).
; //
; //  Shield X positions (pixel coords, original 224-wide playfield):
; //    Shield 1:  36    Shield 2:  78    Shield 3: 120    Shield 4: 162
; //
; // ============================================================================
; //  8.  SAUCER BEHAVIOR
; // ============================================================================
; //
; //  ROM routines: $0993 (TimeToSaucer), $09CA (ThinkSaucer), $09E4 (SaucerMoving)
; //
; //  Trigger:
; //    A countdown timer (tillSaucerTime at RAM $206B) decrements each frame.
; //    Reset value = $0600 (1536 frames = ~25.6 seconds at 60 Hz).
; //    When it reaches zero and fewer than 8 aliens remain, it resets without
; //    spawning. Otherwise the saucer appears.
; //
; //  Direction:
; //    Determined by bit 0 of the player's shot count:
; //      Even shots → saucer enters from the LEFT  (moves right)
; //      Odd shots  → saucer enters from the RIGHT (moves left)
; //
; //  Speed: 2 pixels per step, one step every other frame = 1 px/frame average.
; //
; //  The saucer is suppressed while the Squiggly shot is active.
; //
; // frames between saucers
; // minimum aliens for saucer
; // pixels per movement step
; // ============================================================================
; //  9.  ORIGINAL SPRITE DATA (visual reference)
; // ============================================================================
; //
; //  All sprites from the arcade ROM rendered in their correct orientation.
; //  Each '#' = lit pixel, '.' = background. Stored in rotated-screen column
; //  format (each byte = 1 column of 8 vertical pixels, bit 7 = top row).
; //
; //  --- Alien Type C 'Octopus' Frame 1 (ROM $1C00, 10 pts) ---
; //     ......####......
; //     ...##########...
; //     ..############..
; //     ..###..##..###..
; //     ..############..
; //     .....##..##.....
; //     ....##.##.##....
; //     ..##........##..
; //
; //  --- Alien Type C 'Octopus' Frame 2 (ROM $1C10) ---
; //     .....#.....#....
; //     ...#..#...#..#..
; //     ...#.#######.#..
; //     ...###.###.###..
; //     ...###########..
; //     ....#########...
; //     .....#.....#....
; //     ....#.......#...
; //
; //  --- Alien Type A 'Squid' Frame 1 (ROM $1C20, 30 pts) ---
; //     .......##.......
; //     ......####......
; //     .....######.....
; //     ....##.##.##....
; //     ....########....
; //     ......#..#......
; //     .....#.##.#.....
; //     ....#.#..#.#....
; //
; //  --- Alien Type A 'Squid' Frame 2 (ROM $1C50) ---
; //     .......##.......
; //     ......####......
; //     .....######.....
; //     ....##.##.##....
; //     ....########....
; //     .....#.##.#.....
; //     ....#......#....
; //     .....#....#.....
; //
; //  --- Alien Type B 'Crab' Frame 1 (ROM $1C30, 20 pts) ---
; //     ......####......
; //     ...##########...
; //     ..############..
; //     ..###..##..###..
; //     ..############..
; //     ....###..###....
; //     ...##..##..##...
; //     ....##....##....
; //
; //  --- Alien Type B 'Crab' Frame 2 (ROM $1C40) ---
; //     .....#.....#....
; //     ......#...#.....
; //     .....#######....
; //     ....##.###.##...
; //     ...###########..
; //     ...#.#######.#..
; //     ...#.#.....#.#..
; //     ......##.##.....
; //
; //  --- Saucer / UFO (ROM $1C60) ---
; //     ........#.......
; //     .......###......
; //     .......###......
; //     ...###########..
; //     ..#############.
; //     ..#############.
; //     ..#############.
; //     ..#############.
; //
; //  --- Alien Explosion (ROM $1C70) ---
; //     ......#.........
; //     ...........#....
; //     ......#.#.#.....
; //     ...#..#.........
; //     .......##.##....
; //     .#...#.##.#.#...
; //     ...########..#..
; //     ..##########.#.#
; //
; //  --- Player Ship (ROM $1BA1) ---
; //     .........##.....
; //     ..#.....####....
; //     ..#....######...
; //     ..###.##.##.##..
; //     ..#..#########..
; //     .#.#...#.##.#...
; //     #...#.#......#..
; //     #...#..#....#...
; //
; //  --- Shot Explosion / Cross (ROM $1CC0) ---
; //     .....#...#......
; //     ..#...#.#...#...
; //     ...#.......#....
; //     ....#.....#.....
; //     .##.........##..
; //     ....#.....#.....
; //     ...#..#.#..#....
; //     ..#..#...#..#...
; //
; // ============================================================================
; //  10.  ARCADE RAM MAP (key variables from $2000-$20FF)
; // ============================================================================
; //
; //  $2002  alienCurIndex       Current alien being processed in the march
; //  $2006  refAlienY           Reference alien Y coordinate
; //  $2007  refAlienX           Reference alien X coordinate
; //  $2008  rackDirection       0 = moving left, 1 = moving right (was 0xFF/0x01)
; //  $2009  rackDownDelta       Pixels to drop on next edge hit (8 or 10)
; //  $200A  playerAlive         Non-zero = player is alive
; //  $2067  numAliens           Number of aliens currently alive
; //  $2068  saucerActive        Non-zero = saucer is on screen
; //  $206B  tillSaucerTime      Countdown timer to next saucer appearance
; //  $206F  shotCountdown       Frames until next alien shot can fire
; //  $2072  numCoins            Coin counter
; //  $2078  P1ScorL             Player 1 score (low BCD byte)
; //  $2079  P1ScorM             Player 1 score (mid BCD byte)
; //  $2084  numLives            Lives remaining
; //  $20C0  plyrShotStatus      0=inactive, 1=normal, 2=exploding, 5=alien-hit
; //  $20C3  plyrShotYr          Player shot Y coordinate (rotated)
; //  $20C7  plyrShotXr          Player shot X coordinate (rotated)
; //  $20EB  rolShotStatus       Rolling shot status
; //  $2100  pluShotStatus       Plunger shot status
; //  $2115  squShotStatus       Squiggly shot status
; //
; // ============================================================================
; //  11.  KEY ROM ROUTINE MAP
; // ============================================================================
; //
; //  Addr   Name                   Description
; //  ----   ----                   -----------
; //  $0000  RESET                  NOP;NOP;NOP; JMP PowerOnReset
; //  $0008  ScanLine96_ISR         Mid-screen interrupt (draws top half sprites)
; //  $0010  ScanLine224_ISR        Vblank interrupt (game logic + bottom sprites)
; //  $008F  DrawAlien              Draw one alien at current march position
; //  $00E3  MoveRefAlien           Advance reference alien position
; //  $0141  EraseSimpleSprite      Clear a sprite from VRAM
; //  $017A  DrawSpriteGeneric      XOR-draw a sprite into VRAM
; //  $01A1  PlayerShotHitAlien     Check if player bullet hit an alien
; //  $01C0  ReadInputs             Read coin/start/joystick input ports
; //  $0380  RemoveAlien            Remove alien from alive list & update score
; //  $03BB  PlayerShotHandler      Main player shot state machine
; //  $0550  ScoreForAlien          Calculate score for killed alien by type
; //  $05E9  SquigglyShotHandler    Squiggly alien shot state machine
; //  $0617  PlungerShotHandler     Plunger alien shot state machine
; //  $0644  RollingShotHandler     Rolling (aimed) alien shot state machine
; //  $0798  TimeToFire             Check if an alien shot should be fired
; //  $07BE  SaucerScoring          Determine saucer hit score from shot count
; //  $08D4  PowerOnReset           Hardware init: LXI SP,$2400; clear RAM; etc.
; //  $0935  ISR_MidScreen          Mid-screen game logic handler
; //  $0953  ISR_Vblank             Vblank game logic handler
; //  $0993  TimeToSaucer           Check countdown and spawn saucer
; //  $09E4  SaucerMoving           Move saucer across screen
; //  $0A07  InitAliens             Set up 55-alien formation for new rack
; //  $0AE0  RestoreShields         Copy shield template into VRAM (4 shields)
; //  $0B79  GameLoop               Main attract/play loop
; //  $0BED  MainPlayLoop           Core per-frame gameplay update
; //  $0CF4  PrintScore             Draw score digits to screen
; //  $0DC0  ClearPlayfield         Zero out playfield area of VRAM
; //  $1400  DrawAlienRow           Draw row of aliens during ISR
; //  $141C  CheckAlienReachedBottom Check if formation dropped to player level
; //  $14C0  CountAliens            Count remaining alive aliens
; //  $14CB  DrawShields            Render shield bitmaps
; //  $1538  SpriteShotCollision    Pixel-level collision detection
; //  $17C9  AdjScore               Add BCD score delta to player score
; //
; //  The full annotated disassembly is saved to:
; //    Assets/Intel8080/disassembly.txt
; //
; // ============================================================================
; //  12.  REUSABLE PROCEDURES — Arcade algorithms adapted for TRSE / C64
; // ============================================================================
; //
; // GetArcadeSaucerScore
; //   Returns the saucer score (divided by 10) based on the player's shot count.
; //   Multiply the result by 10 to get the actual point value.
; //   This replicates the original arcade's "mystery score" mechanic.
; //
	; NodeProcedureDecl -1
	; ***********  Defining procedure : Helpers_GetArcadeSaucerScore
	;    Procedure type : User-defined procedure
Helpers_saucer_table_index	dc.b	0
Helpers_saucer_result	dc.b	0
Helpers_player_shot_count	dc.b	0
Helpers_GetArcadeSaucerScore_block275
Helpers_GetArcadeSaucerScore
	; Binary clause Simplified: EQUALS
	clc
	lda Helpers_player_shot_count
	; cmp #$00 ignored
	bne Helpers_GetArcadeSaucerScore_eblock278
Helpers_GetArcadeSaucerScore_ctb277: ;Main true block ;keep 
	
; // shot_count starts at 1; table is 0-indexed and cycles every 15
	lda #$0
	; Calling storevariable on generic assign expression
	sta Helpers_saucer_table_index
	jmp Helpers_GetArcadeSaucerScore_edblock279
Helpers_GetArcadeSaucerScore_eblock278
	; 8 bit binop
	; Add/sub right value is variable/expression
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	; Right is PURE NUMERIC : Is word =0
	; 8 bit div
	; 8 bit binop
	; Add/sub where right value is constant number
	lda Helpers_player_shot_count
	sec
	sbc #$1
	 ; end add / sub var with constant
	sta div8x8_d
	; Load right hand side
	lda #$f
	sta div8x8_c
	jsr div8x8_procedure
	; Load right hand side
	tax
	lda #$f
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
Helpers_GetArcadeSaucerScore_rightvarAddSub_var293 = $54
	sta Helpers_GetArcadeSaucerScore_rightvarAddSub_var293
	; 8 bit binop
	; Add/sub where right value is constant number
	lda Helpers_player_shot_count
	sec
	sbc #$1
	 ; end add / sub var with constant
	sec
	sbc Helpers_GetArcadeSaucerScore_rightvarAddSub_var293
	; Calling storevariable on generic assign expression
	sta Helpers_saucer_table_index
Helpers_GetArcadeSaucerScore_edblock279
	; Load Byte array
	; CAST type NADA
	ldx Helpers_saucer_table_index
	lda Helpers_arcade_saucer_score_table,x 
	; Calling storevariable on generic assign expression
	sta Helpers_saucer_result
	rts
end_procedure_Helpers_GetArcadeSaucerScore
	
; //
; // GetArcadeSpeedDelay
; //   Given the number of aliens alive, returns the number of frames
; //   between formation march steps (from the arcade speed curve).
; //   Lower = faster.
; //
	; NodeProcedureDecl -1
	; ***********  Defining procedure : Helpers_GetArcadeSpeedDelay
	;    Procedure type : User-defined procedure
Helpers_speed_index	dc.b	0
Helpers_speed_found_flag	dc.b	0
Helpers_speed_result	dc.b	0
Helpers_aliens_alive	dc.b	0
Helpers_GetArcadeSpeedDelay_block294
Helpers_GetArcadeSpeedDelay
	lda #$0
	; Calling storevariable on generic assign expression
	sta Helpers_speed_found_flag
	; Load Byte array
	; CAST type NADA
	lda Helpers_arcade_speed_delay +$0 ; array with const index optimization 
	; Calling storevariable on generic assign expression
	sta Helpers_speed_result
	
; // default to slowest
	lda #$0
	; Calling storevariable on generic assign expression
	sta Helpers_speed_index
Helpers_GetArcadeSpeedDelay_while295
Helpers_GetArcadeSpeedDelay_loopstart299
	; Binary clause Simplified: LESS
	lda Helpers_speed_index
	; Compare with pure num / var optimization
	cmp #$9;keep
	bcs Helpers_GetArcadeSpeedDelay_edblock298
Helpers_GetArcadeSpeedDelay_localsuccess308: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda Helpers_speed_found_flag
	; cmp #$00 ignored
	bne Helpers_GetArcadeSpeedDelay_edblock298
Helpers_GetArcadeSpeedDelay_ctb296: ;Main true block ;keep 
	; Binary clause Simplified: LESSEQUAL
	; Load Byte array
	; CAST type NADA
	ldx Helpers_speed_index
	lda Helpers_arcade_speed_threshold,x 
	; Compare with pure num / var optimization
	cmp Helpers_aliens_alive;keep
	beq Helpers_GetArcadeSpeedDelay_ctb311
	bcs Helpers_GetArcadeSpeedDelay_edblock313
Helpers_GetArcadeSpeedDelay_ctb311: ;Main true block ;keep 
	; Load Byte array
	; CAST type NADA
	ldx Helpers_speed_index
	lda Helpers_arcade_speed_delay,x 
	; Calling storevariable on generic assign expression
	sta Helpers_speed_result
	lda #$1
	; Calling storevariable on generic assign expression
	sta Helpers_speed_found_flag
Helpers_GetArcadeSpeedDelay_edblock313
	; Test Inc dec D
	inc Helpers_speed_index
	jmp Helpers_GetArcadeSpeedDelay_while295
Helpers_GetArcadeSpeedDelay_edblock298
Helpers_GetArcadeSpeedDelay_loopend300
	; Binary clause Simplified: EQUALS
	clc
	lda Helpers_speed_found_flag
	; cmp #$00 ignored
	bne Helpers_GetArcadeSpeedDelay_edblock319
Helpers_GetArcadeSpeedDelay_ctb317: ;Main true block ;keep 
	
; // If no threshold matched (shouldn't happen), use fastest
	lda #$3
	; Calling storevariable on generic assign expression
	sta Helpers_speed_result
Helpers_GetArcadeSpeedDelay_edblock319
	lda Helpers_speed_result
	rts
end_procedure_Helpers_GetArcadeSpeedDelay
	
; //
; // GetPlungerFireColumn
; //   Returns the next alien column (1-11) for the plunger shot to fire from.
; //   Call this each time a plunger shot needs to be spawned.
; //   Pass in a counter that increments and wraps at 16.
; //
	; NodeProcedureDecl -1
	; ***********  Defining procedure : Helpers_GetPlungerFireColumn
	;    Procedure type : User-defined procedure
Helpers_plunger_column_result	dc.b	0
Helpers_plunger_step	dc.b	0
Helpers_GetPlungerFireColumn_block322
Helpers_GetPlungerFireColumn
	; Load Byte array
	; CAST type NADA
	; 8 bit binop
	; Add/sub where right value is constant number
	lda Helpers_plunger_step
	and #$f
	 ; end add / sub var with constant
	tax
	lda Helpers_arcade_plunger_columns,x 
	; Calling storevariable on generic assign expression
	sta Helpers_plunger_column_result
	rts
end_procedure_Helpers_GetPlungerFireColumn
	
; //
; // GetSquigglyFireColumn
; //   Same as above, but for the squiggly shot type.
; //
	; NodeProcedureDecl -1
	; ***********  Defining procedure : Helpers_GetSquigglyFireColumn
	;    Procedure type : User-defined procedure
Helpers_squiggly_column_result	dc.b	0
Helpers_squiggly_step	dc.b	0
Helpers_GetSquigglyFireColumn_block323
Helpers_GetSquigglyFireColumn
	; Load Byte array
	; CAST type NADA
	; 8 bit binop
	; Add/sub where right value is constant number
	lda Helpers_squiggly_step
	and #$f
	 ; end add / sub var with constant
	tax
	lda Helpers_arcade_squiggly_columns,x 
	; Calling storevariable on generic assign expression
	sta Helpers_squiggly_column_result
	rts
end_procedure_Helpers_GetSquigglyFireColumn
	; NodeProcedureDecl -1
	; ***********  Defining procedure : Helpers_WriteShieldRow
	;    Procedure type : User-defined procedure
Helpers_wsr_ptr	= $22
Helpers_wsr_addr	dc.w	0
Helpers_wsr_c0	dc.b	0
Helpers_wsr_c1	dc.b	0
Helpers_wsr_c2	dc.b	0
Helpers_WriteShieldRow_block324
Helpers_WriteShieldRow
	
; // Use pointer dereference (the starfield pattern).
	lda Helpers_wsr_addr
	ldx Helpers_wsr_addr+1
	sta Helpers_wsr_ptr
	stx Helpers_wsr_ptr+1
	lda Helpers_wsr_c0
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (Helpers_wsr_ptr),y
	lda Helpers_wsr_ptr
	clc
	adc #$01
	sta Helpers_wsr_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc Helpers_WriteShieldRow_WordAdd325
	inc Helpers_wsr_ptr+1
Helpers_WriteShieldRow_WordAdd325
	lda Helpers_wsr_c1
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (Helpers_wsr_ptr),y
	lda Helpers_wsr_ptr
	clc
	adc #$01
	sta Helpers_wsr_ptr+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc Helpers_WriteShieldRow_WordAdd326
	inc Helpers_wsr_ptr+1
Helpers_WriteShieldRow_WordAdd326
	lda Helpers_wsr_c2
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	ldy #$0
	sta (Helpers_wsr_ptr),y
	rts
end_procedure_Helpers_WriteShieldRow
	
; // ============================================================================
; //  SHIELD UTILITIES (from shields.tru)
; // ============================================================================
; // ---------------------------------------------------------------------------
; // WriteShieldRow
; //   Writes three consecutive char codes (c0, c1, c2) into screen RAM
; //   starting at a given integer address, using pointer dereferencing
; //   (the correct TRSE idiom — poke with an integer addr generates bad asm).
; // ---------------------------------------------------------------------------
; // ---------------------------------------------------------------------------
; // PlaceShieldBlock
; //   Writes a 3x2 shield block to screen RAM.
; //   psb_base_addr : integer address of the FIRST (top-left) screen cell.
; //   char_base     : first of 6 consecutive charset char codes.
; //     Top row    → char_base, char_base+1, char_base+2  at psb_base_addr
; //     Bottom row → char_base+3, char_base+4, char_base+5  at psb_base_addr+40
; //
; //   Pass a pre-computed integer constant for psb_base_addr to avoid
; //   byte-overflow from expressions like row*40 (e.g. 19*40=760 > 255).
; //   Formula (for reference): $0400 + screen_row*40 + col
; //     Shield 1 row 19 col 4  →  $0400 + 760 + 4 = $06FC
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : Helpers_PlaceShieldBlock
	;    Procedure type : User-defined procedure
Helpers_psb_addr	dc.w	0
Helpers_psb_base_addr	dc.w	0
Helpers_psb_char_base	dc.b	0
Helpers_PlaceShieldBlock_block327
Helpers_PlaceShieldBlock
	
; // Top row (3 chars at psb_base_addr)
	ldy Helpers_psb_base_addr+1 ;keep
	lda Helpers_psb_base_addr
	; Calling storevariable on generic assign expression
	sta Helpers_wsr_addr
	sty Helpers_wsr_addr+1
	lda Helpers_psb_char_base
	; Calling storevariable on generic assign expression
	sta Helpers_wsr_c0
	; 8 bit binop
	; Add/sub where right value is constant number
	clc
	adc #$1
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta Helpers_wsr_c1
	; Optimizer: a = a +/- b
	; Load16bitvariable : Helpers_psb_char_base
	lda Helpers_psb_char_base
	clc
	adc #$2
	sta Helpers_wsr_c2
	jsr Helpers_WriteShieldRow
	
; // Bottom row: one screen row lower = +40 bytes
	; INTEGER optimization: a=b+c 
	lda Helpers_psb_base_addr
	clc
	adc #$28
	sta Helpers_psb_addr+0
	lda Helpers_psb_base_addr+1
	adc #$00
	sta Helpers_psb_addr+1
	tay ; optimized y, look out for bugs L22 ORG 	ldy Helpers_psb_addr+1 ;keep
	lda Helpers_psb_addr
	; Calling storevariable on generic assign expression
	sta Helpers_wsr_addr
	sty Helpers_wsr_addr+1
	; Optimizer: a = a +/- b
	; Load16bitvariable : Helpers_psb_char_base
	lda Helpers_psb_char_base
	clc
	adc #$3
	sta Helpers_wsr_c0
	; Optimizer: a = a +/- b
	; Load16bitvariable : Helpers_psb_char_base
	lda Helpers_psb_char_base
	clc
	adc #$4
	sta Helpers_wsr_c1
	; Optimizer: a = a +/- b
	; Load16bitvariable : Helpers_psb_char_base
	lda Helpers_psb_char_base
	clc
	adc #$5
	sta Helpers_wsr_c2
	jsr Helpers_WriteShieldRow
	rts
end_procedure_Helpers_PlaceShieldBlock
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ShowUFO
	;    Procedure type : User-defined procedure
ShowUFO
	; Binary clause Simplified: EQUALS
	lda ufo_active
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne ShowUFO_localfailed370
	jmp ShowUFO_ctb331
ShowUFO_localfailed370
	jmp ShowUFO_eblock332
ShowUFO_ctb331: ;Main true block ;keep 
	
; // Sprite image index in the sprite binary
; // Normal crossing — show UFO sprite
	; Set sprite location
	ldx #$1 ; optimized, look out for bugs
	lda #$90
	sta $07f8 + $0,x
	; Setting sprite position
	; isi-pisi: value is constant
	lda ufo_x
	ldx #2
	sta $D000,x
ShowUFO_spritepos372
	lda $D010
	and #%11111101
	sta $D010
ShowUFO_spriteposcontinue373
	inx
	txa
	tay
	lda #$2c
	sta $D000,y
	; Toggle bit with constant
	lda $d01d
	and #%11111101
	sta $d01d
	ldx #$1 ; optimized, look out for bugs
	lda #1
ShowUFO_shiftbit374
	cpx #0
	beq ShowUFO_shiftbitdone375
	asl
	dex
	jmp ShowUFO_shiftbit374
ShowUFO_shiftbitdone375
ShowUFO_bitmask_var376 = $54
	sta ShowUFO_bitmask_var376
	lda #$FF
	eor ShowUFO_bitmask_var376
	sta ShowUFO_bitmask_var376
	lda $d01d
	and ShowUFO_bitmask_var376
	sta $d01d
	jmp ShowUFO_edblock333
ShowUFO_eblock332
	; Binary clause Simplified: EQUALS
	lda ufo_active
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne ShowUFO_localfailed394
	jmp ShowUFO_ctb379
ShowUFO_localfailed394
	jmp ShowUFO_eblock380
ShowUFO_ctb379: ;Main true block ;keep 
	
; // Exploding — show score display sprite frozen at hit position
	; Set sprite location
	lda #$1
	sta $50
	; Generic 16 bit op
	ldy #0
	lda ufo_score_sprite
ShowUFO_rightvarInteger_var398 = $54
	sta ShowUFO_rightvarInteger_var398
	sty ShowUFO_rightvarInteger_var398+1
	lda #128
	ldy #0
	; Low bit binop:
	clc
	adc ShowUFO_rightvarInteger_var398
ShowUFO_wordAdd396
	sta ShowUFO_rightvarInteger_var398
	; High-bit binop
	tya
	adc ShowUFO_rightvarInteger_var398+1
	tay
	lda ShowUFO_rightvarInteger_var398
	ldx $50
	sta $07f8 + $0,x
	; Setting sprite position
	; isi-pisi: value is constant
	lda ufo_x
	ldx #2
	sta $D000,x
ShowUFO_spritepos399
	lda $D010
	and #%11111101
	sta $D010
ShowUFO_spriteposcontinue400
	inx
	txa
	tay
	lda #$2c
	sta $D000,y
	; Toggle bit with constant
	lda $d01d
	and #%11111101
	sta $d01d
	ldx #$1 ; optimized, look out for bugs
	lda #1
ShowUFO_shiftbit401
	cpx #0
	beq ShowUFO_shiftbitdone402
	asl
	dex
	jmp ShowUFO_shiftbit401
ShowUFO_shiftbitdone402
ShowUFO_bitmask_var403 = $54
	sta ShowUFO_bitmask_var403
	lda #$FF
	eor ShowUFO_bitmask_var403
	sta ShowUFO_bitmask_var403
	lda $d01d
	and ShowUFO_bitmask_var403
	sta $d01d
	jmp ShowUFO_edblock381
ShowUFO_eblock380
	; Setting sprite position
	; isi-pisi: value is constant
	lda #$0
	ldx #2
	sta $D000,x
ShowUFO_spritepos405
	lda $D010
	and #%11111101
	sta $D010
ShowUFO_spriteposcontinue406
	inx
	txa
	tay
	lda #$ff
	sta $D000,y
ShowUFO_edblock381
ShowUFO_edblock333
	rts
end_procedure_ShowUFO
	
; // Off-screen when inactive
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateUFO
	;    Procedure type : User-defined procedure
ufo_aliens_alive	dc.b	0
UpdateUFO_block407
UpdateUFO
	; Binary clause Simplified: EQUALS
	lda ufo_active
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne UpdateUFO_localfailed709
	jmp UpdateUFO_ctb409
UpdateUFO_localfailed709
	jmp UpdateUFO_eblock410
UpdateUFO_ctb409: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	lda ufo_explode_counter
	; Compare with pure num / var optimization
	cmp #$1;keep
	bcc UpdateUFO_eblock713
UpdateUFO_ctb712: ;Main true block ;keep 
	
; // Left edge of play field
; // Right edge of play field
; // ~25.6 s at 60 Hz
; // Suppressed when fewer than 8 aliens alive
; // Score-display phase: count down then deactivate
	; Test Inc dec D
	dec ufo_explode_counter
	jmp UpdateUFO_edblock714
UpdateUFO_eblock713
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_active
	; Integer constant assigning
	; Load16bitvariable : #$600
	ldy #$06
	lda #$00
	; Calling storevariable on generic assign expression
	sta ufo_spawn_timer
	sty ufo_spawn_timer+1
UpdateUFO_edblock714
	jmp UpdateUFO_edblock411
UpdateUFO_eblock410
	; Binary clause Simplified: EQUALS
	lda ufo_active
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne UpdateUFO_localfailed865
	jmp UpdateUFO_ctb721
UpdateUFO_localfailed865
	jmp UpdateUFO_eblock722
UpdateUFO_ctb721: ;Main true block ;keep 
	
; // Active: move across screen; exit (deactivate) when edge reached.
	; Test Inc dec D
	inc ufo_move_skip_counter
	; Binary clause Simplified: GREATEREQUAL
	lda ufo_move_skip_counter
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcc UpdateUFO_eblock869
UpdateUFO_ctb868: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_move_skip_counter
	jmp UpdateUFO_edblock870
UpdateUFO_eblock869
	; Binary clause Simplified: NOTEQUALS
	clc
	lda ufo_direction
	; cmp #$00 ignored
	beq UpdateUFO_eblock917
UpdateUFO_ctb916: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	lda ufo_x
	; Compare with pure num / var optimization
	cmp #$e6;keep
	bcc UpdateUFO_eblock940
UpdateUFO_ctb939: ;Main true block ;keep 
	
; // Moving right — exit at right edge
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_active
	; Integer constant assigning
	; Load16bitvariable : #$600
	ldy #$06
	lda #$00
	; Calling storevariable on generic assign expression
	sta ufo_spawn_timer
	sty ufo_spawn_timer+1
	jmp UpdateUFO_edblock941
UpdateUFO_eblock940
	; Test Inc dec D
	inc ufo_x
UpdateUFO_edblock941
	jmp UpdateUFO_edblock918
UpdateUFO_eblock917
	; Binary clause Simplified: LESS
	lda ufo_x
	; Compare with pure num / var optimization
	cmp #$19;keep
	bcs UpdateUFO_eblock949
UpdateUFO_ctb948: ;Main true block ;keep 
	
; // Moving left — exit at left edge
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_active
	; Integer constant assigning
	; Load16bitvariable : #$600
	ldy #$06
	lda #$00
	; Calling storevariable on generic assign expression
	sta ufo_spawn_timer
	sty ufo_spawn_timer+1
	jmp UpdateUFO_edblock950
UpdateUFO_eblock949
	; Test Inc dec D
	dec ufo_x
UpdateUFO_edblock950
UpdateUFO_edblock918
UpdateUFO_edblock870
	jmp UpdateUFO_edblock723
UpdateUFO_eblock722
	
; // Inactive (ufo_active = 0): count down spawn timer.
	lda ufo_spawn_timer
	sec
	sbc #$01
	sta ufo_spawn_timer+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcs UpdateUFO_WordAdd956
	dec ufo_spawn_timer+1
UpdateUFO_WordAdd956
	; Binary clause INTEGER: LESSEQUAL
	lda ufo_spawn_timer+1   ; compare high bytes
	cmp #$00 ;keep
	bcc UpdateUFO_ctb958
	bne UpdateUFO_edblock960
	lda ufo_spawn_timer
	cmp #$00 ;keep
	beq UpdateUFO_ctb958
	bcs UpdateUFO_edblock960
UpdateUFO_ctb958: ;Main true block ;keep 
	; Integer constant assigning
	; Load16bitvariable : #$600
	ldy #$06
	lda #$00
	; Calling storevariable on generic assign expression
	sta ufo_spawn_timer
	sty ufo_spawn_timer+1
	
; // Reset whether or not we spawn
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$47
	sec
	sbc numberOfEnemies
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta ufo_aliens_alive
	; Binary clause Simplified: GREATEREQUAL
	; Compare with pure num / var optimization
	cmp #$8;keep
	bcc UpdateUFO_edblock988
UpdateUFO_ctb986: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_shot_count
	and #$1
	 ; end add / sub var with constant
	; cmp #$00 ignored
	bne UpdateUFO_eblock1001
UpdateUFO_ctb1000: ;Main true block ;keep 
	
; // Direction determined by player shot count parity (arcade rule)
; // Even shots → enters from left, moves right
	lda #$18
	; Calling storevariable on generic assign expression
	sta ufo_x
	lda #$1
	; Calling storevariable on generic assign expression
	sta ufo_direction
	jmp UpdateUFO_edblock1002
UpdateUFO_eblock1001
	
; // Odd shots → enters from right, moves left
	lda #$e6
	; Calling storevariable on generic assign expression
	sta ufo_x
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_direction
UpdateUFO_edblock1002
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_move_skip_counter
	lda #$1
	; Calling storevariable on generic assign expression
	sta ufo_active
UpdateUFO_edblock988
UpdateUFO_edblock960
UpdateUFO_edblock723
UpdateUFO_edblock411
	rts
end_procedure_UpdateUFO
	
; // ---------------------------------------------------------------------------
; // CheckUFOCollision
; //   AABB overlap: same style as CheckShotVsShotCollision.
; //
; //   UFO hitbox   — 16×8 px at sprite bottom:
; //     X offsets [ufo_x+4  ..  ufo_x+19]     (centred in 24px sprite)
; //     Y offsets [UFO_Y+13 ..  UFO_Y+20]  =  [57 .. 64]  (UFO_Y=44, fixed)
; //
; //   Player bullet active area (identical to shot-vs-shot convention):
; //     X offset  px+11  (1 px)
; //     Y offsets py+17 .. py+20  (4 px, bottom-aligned)
; //
; //   Reduced overlap conditions:
; //     X:  px+11 in [ux+4, ux+19]  →  px in [ux-7, ux+8]
; //         written as  NOT (px+7 < ux)  AND  NOT (px > ux+8)
; //         (px+7 form avoids byte underflow; UFO_X_MIN=24 so ux-7>=17 always)
; //     Y:  py+20 >= 57 AND py+17 <= 64  →  py in [37, 47]  (UFO_HIT_PX_LO / _HI)
; //
; //   On hit:
; //     • player_bullet_active := 0  (immediately ready to fire again)
; //     • Score += uc_score_raw * 10
; //     • ufo_score_sprite set from score table
; //     • ufo_active := 2, ufo_explode_counter := UFO_EXPLODE_DURATION
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CheckUFOCollision
	;    Procedure type : User-defined procedure
uc_score_raw	dc.b	0
uc_overlap	dc.b	0
CheckUFOCollision_block1007
CheckUFOCollision
	
; // ~1 s at 60 Hz — how long score sprite is shown
; // min player_bullet_y for Y overlap (UFO_Y+13-20)
; // max player_bullet_y for Y overlap (UFO_Y+20-17)
; // sprite image shown for  50 pts
; //                        100 pts
; //                        150 pts
; //                        300 pts
	lda #$1
	; Calling storevariable on generic assign expression
	sta uc_overlap
	; Binary clause Simplified: NOTEQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$1;keep
	beq CheckUFOCollision_edblock1011
CheckUFOCollision_ctb1009: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta uc_overlap
CheckUFOCollision_edblock1011
	; Binary clause Simplified: NOTEQUALS
	lda ufo_active
	; Compare with pure num / var optimization
	cmp #$1;keep
	beq CheckUFOCollision_edblock1017
CheckUFOCollision_ctb1015: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta uc_overlap
CheckUFOCollision_edblock1017
	; Binary clause Simplified: EQUALS
	lda uc_overlap
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CheckUFOCollision_edblock1023
CheckUFOCollision_ctb1021: ;Main true block ;keep 
	; Binary clause Simplified: LESS
	lda player_bullet_y
	; Compare with pure num / var optimization
	cmp #$25;keep
	bcs CheckUFOCollision_edblock1041
CheckUFOCollision_ctb1039: ;Main true block ;keep 
	
; // ---- Y overlap (early exit — cheapest check, UFO Y is constant) ----
; // Equivalent to: py+20 >= 57 AND py+17 <= 64
	lda #$0
	; Calling storevariable on generic assign expression
	sta uc_overlap
CheckUFOCollision_edblock1041
	; Binary clause Simplified: GREATEREQUAL
	lda player_bullet_y
	; Compare with pure num / var optimization
	cmp #$30;keep
	bcc CheckUFOCollision_edblock1047
CheckUFOCollision_ctb1045: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta uc_overlap
CheckUFOCollision_edblock1047
CheckUFOCollision_edblock1023
	; Binary clause Simplified: EQUALS
	lda uc_overlap
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CheckUFOCollision_edblock1053
CheckUFOCollision_ctb1051: ;Main true block ;keep 
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_x
	clc
	adc #$7
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp ufo_x;keep
	bcs CheckUFOCollision_edblock1071
CheckUFOCollision_ctb1069: ;Main true block ;keep 
	
; // ---- X overlap ----
; // px+11 must be in [ufo_x+4 .. ufo_x+19]
; //   left  edge: px+7 < ufo_x  →  miss left
; //   right edge: px > ufo_x+8  →  miss right
	lda #$0
	; Calling storevariable on generic assign expression
	sta uc_overlap
CheckUFOCollision_edblock1071
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda ufo_x
	clc
	adc #$8
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp player_bullet_x;keep
	bcs CheckUFOCollision_edblock1077
CheckUFOCollision_ctb1075: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta uc_overlap
CheckUFOCollision_edblock1077
CheckUFOCollision_edblock1053
	; Binary clause Simplified: EQUALS
	lda uc_overlap
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CheckUFOCollision_localfailed1144
	jmp CheckUFOCollision_ctb1081
CheckUFOCollision_localfailed1144
	jmp CheckUFOCollision_edblock1083
CheckUFOCollision_ctb1081: ;Main true block ;keep 
	
; // Hit!
	lda #$0
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	lda player_shot_count
	; Calling storevariable on generic assign expression
	sta Helpers_player_shot_count
	jsr Helpers_GetArcadeSaucerScore
	; Calling storevariable on generic assign expression
	sta uc_score_raw
	; Generic 16 bit op
	ldy score+1 ;keep
	lda score
CheckUFOCollision_rightvarInteger_var1148 = $54
	sta CheckUFOCollision_rightvarInteger_var1148
	sty CheckUFOCollision_rightvarInteger_var1148+1
	; Swapping nodes :  num * expr -> exp*num (mul only)
	; Right is PURE NUMERIC : Is word =1
	; 16 bit mul or div
	; Mul 16x8 setup
	; Load16bitvariable : uc_score_raw
	ldy #0
	lda uc_score_raw
	sta mul16x8_num1
	sty mul16x8_num1Hi
	lda #$a
	sta mul16x8_num2
	jsr mul16x8_procedure
	; Low bit binop:
	clc
	adc CheckUFOCollision_rightvarInteger_var1148
CheckUFOCollision_wordAdd1146
	sta CheckUFOCollision_rightvarInteger_var1148
	; High-bit binop
	tya
	adc CheckUFOCollision_rightvarInteger_var1148+1
	tay
	lda CheckUFOCollision_rightvarInteger_var1148
	; Calling storevariable on generic assign expression
	sta score
	sty score+1
	lda #$1
	; Calling storevariable on generic assign expression
	sta score_dirty
	; Binary clause Simplified: GREATEREQUAL
	lda uc_score_raw
	; Compare with pure num / var optimization
	cmp #$1e;keep
	bcc CheckUFOCollision_eblock1151
CheckUFOCollision_ctb1150: ;Main true block ;keep 
	lda #$16
	; Calling storevariable on generic assign expression
	sta ufo_score_sprite
	jmp CheckUFOCollision_edblock1152
CheckUFOCollision_eblock1151
	; Binary clause Simplified: GREATEREQUAL
	lda uc_score_raw
	; Compare with pure num / var optimization
	cmp #$f;keep
	bcc CheckUFOCollision_eblock1183
CheckUFOCollision_ctb1182: ;Main true block ;keep 
	lda #$15
	; Calling storevariable on generic assign expression
	sta ufo_score_sprite
	jmp CheckUFOCollision_edblock1184
CheckUFOCollision_eblock1183
	; Binary clause Simplified: GREATEREQUAL
	lda uc_score_raw
	; Compare with pure num / var optimization
	cmp #$a;keep
	bcc CheckUFOCollision_eblock1199
CheckUFOCollision_ctb1198: ;Main true block ;keep 
	lda #$14
	; Calling storevariable on generic assign expression
	sta ufo_score_sprite
	jmp CheckUFOCollision_edblock1200
CheckUFOCollision_eblock1199
	lda #$13
	; Calling storevariable on generic assign expression
	sta ufo_score_sprite
CheckUFOCollision_edblock1200
CheckUFOCollision_edblock1184
CheckUFOCollision_edblock1152
	lda #$2
	; Calling storevariable on generic assign expression
	sta ufo_active
	lda #$3c
	; Calling storevariable on generic assign expression
	sta ufo_explode_counter
CheckUFOCollision_edblock1083
	rts
end_procedure_CheckUFOCollision
	
; // Set to 1 to disable all enemy-shot firing
; // frames between UFO bullet fires
; // ── Nested: Fire enemy-shot slot from lowest alive alien in column ────────
	; NodeProcedureDecl -1
	; ***********  Defining procedure : SpawnShotFromColumn
	;    Procedure type : User-defined procedure
spawn_block_col	dc.b	0
spawn_enemy_col	dc.b	0
spawn_block_index	dc.b	0
spawn_enemy_index	dc.b	0
spawn_enemy_mask	dc.b	0
spawn_form_row	dc.b	0
spawn_sub_row	dc.b	0
spawn_found_flag	dc.b	0
spawn_x_calc	dc.b	0
spawn_y_calc	dc.b	0
spawn_col	dc.b	0
spawn_slot	dc.b	0
SpawnShotFromColumn_block1205
SpawnShotFromColumn
	; Right is PURE NUMERIC : Is word =0
	; 8 bit div
	lda spawn_col
	sta div8x8_d
	; Load right hand side
	lda #$3
	sta div8x8_c
	jsr div8x8_procedure
	; Calling storevariable on generic assign expression
	sta spawn_block_col
	; 8 bit binop
	; Add/sub right value is variable/expression
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	; Load right hand side
	tax
	lda #$3
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
SpawnShotFromColumn_rightvarAddSub_var1210 = $54
	sta SpawnShotFromColumn_rightvarAddSub_var1210
	lda spawn_col
	sec
	sbc SpawnShotFromColumn_rightvarAddSub_var1210
	; Calling storevariable on generic assign expression
	sta spawn_enemy_col
	lda #$0
	; Calling storevariable on generic assign expression
	sta spawn_found_flag
	lda #$2
	; Calling storevariable on generic assign expression
	sta spawn_form_row
SpawnShotFromColumn_while1211
SpawnShotFromColumn_loopstart1215
	; Optimization: replacing a <= N with a <= N-1
	; Binary clause Simplified: LESS
	lda spawn_form_row
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs SpawnShotFromColumn_localfailed1330
SpawnShotFromColumn_localsuccess1331: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda spawn_found_flag
	; cmp #$00 ignored
	bne SpawnShotFromColumn_localfailed1330
	jmp SpawnShotFromColumn_ctb1212
SpawnShotFromColumn_localfailed1330
	jmp SpawnShotFromColumn_edblock1214
SpawnShotFromColumn_ctb1212: ;Main true block ;keep 
	
; // start at bottom formation row
	lda #$1
	; Calling storevariable on generic assign expression
	sta spawn_sub_row
SpawnShotFromColumn_while1333
SpawnShotFromColumn_loopstart1337
	; Binary clause Simplified: LESS
	lda spawn_sub_row
	; Compare with pure num / var optimization
	cmp #$2;keep
	bcs SpawnShotFromColumn_localfailed1387
SpawnShotFromColumn_localsuccess1388: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda spawn_found_flag
	; cmp #$00 ignored
	bne SpawnShotFromColumn_localfailed1387
	jmp SpawnShotFromColumn_ctb1334
SpawnShotFromColumn_localfailed1387
	jmp SpawnShotFromColumn_edblock1336
SpawnShotFromColumn_ctb1334: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : spawn_form_row
	lda spawn_form_row
	asl
	asl
	clc
	adc spawn_block_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta spawn_block_index
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : spawn_enemy_col
	lda spawn_enemy_col
	asl
	clc
	adc spawn_sub_row
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta spawn_enemy_index
	tax ; optimized x, look out for bugs L22 ORG 	ldx spawn_enemy_index ; optimized, look out for bugs
	lda #$1
	cpx #0
	beq SpawnShotFromColumn_lblShiftDone1391
SpawnShotFromColumn_lblShift1390
	asl
	dex
	cpx #0
	bne SpawnShotFromColumn_lblShift1390
SpawnShotFromColumn_lblShiftDone1391
	; Calling storevariable on generic assign expression
	sta spawn_enemy_mask
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx spawn_block_index
	lda block_enemies,x 
	and spawn_enemy_mask
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq SpawnShotFromColumn_localfailed1412
	jmp SpawnShotFromColumn_ctb1393
SpawnShotFromColumn_localfailed1412
	jmp SpawnShotFromColumn_edblock1395
SpawnShotFromColumn_ctb1393: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub right value is variable/expression
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx spawn_enemy_col ; optimized, look out for bugs
	; Load right hand side
	lda #$12
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
SpawnShotFromColumn_rightvarAddSub_var1416 = $54
	sta SpawnShotFromColumn_rightvarAddSub_var1416
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx spawn_block_col ; optimized, look out for bugs
	; Load right hand side
	lda #$36
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc SpawnShotFromColumn_rightvarAddSub_var1416
	sec
	sbc #$6
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta spawn_x_calc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_x
	clc
	adc spawn_x_calc
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta spawn_x_calc
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx spawn_form_row ; optimized, look out for bugs
	; Load right hand side
	lda #$1a
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc monster_base_y
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta spawn_y_calc
	; Binary clause Simplified: EQUALS
	clc
	lda spawn_sub_row
	; cmp #$00 ignored
	bne SpawnShotFromColumn_eblock1423
SpawnShotFromColumn_ctb1422: ;Main true block ;keep 
	jmp SpawnShotFromColumn_edblock1424
SpawnShotFromColumn_eblock1423
	
; //dec(spawn_y_calc);
; //dec(spawn_y_calc);
	; Optimizer: a = a +/- b
	; Load16bitvariable : spawn_y_calc
	lda spawn_y_calc
	clc
	adc #$e
	sta spawn_y_calc
SpawnShotFromColumn_edblock1424
	lda spawn_x_calc
	; Calling storevariable on generic assign expression
	ldx spawn_slot ; optimized, look out for bugs
	sta ufo_bullet_x,x
	lda spawn_y_calc
	; Calling storevariable on generic assign expression
	sta ufo_bullet_y,x
	lda #$1
	; Calling storevariable on generic assign expression
	sta ufo_bullet_active,x
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_bullet_anim_index,x
	; Calling storevariable on generic assign expression
	sta ufo_bullet_anim_tick,x
	lda #$1
	; Calling storevariable on generic assign expression
	sta spawn_found_flag
SpawnShotFromColumn_edblock1395
	; Binary clause Simplified: EQUALS
	clc
	lda spawn_sub_row
	; cmp #$00 ignored
	bne SpawnShotFromColumn_eblock1431
SpawnShotFromColumn_ctb1430: ;Main true block ;keep 
	lda #$ff
	; Calling storevariable on generic assign expression
	sta spawn_sub_row
	jmp SpawnShotFromColumn_edblock1432
SpawnShotFromColumn_eblock1431
	; Test Inc dec D
	dec spawn_sub_row
SpawnShotFromColumn_edblock1432
	jmp SpawnShotFromColumn_while1333
SpawnShotFromColumn_edblock1336
SpawnShotFromColumn_loopend1338
	; Binary clause Simplified: EQUALS
	clc
	lda spawn_form_row
	; cmp #$00 ignored
	bne SpawnShotFromColumn_eblock1439
SpawnShotFromColumn_ctb1438: ;Main true block ;keep 
	lda #$ff
	; Calling storevariable on generic assign expression
	sta spawn_form_row
	jmp SpawnShotFromColumn_edblock1440
SpawnShotFromColumn_eblock1439
	; Test Inc dec D
	dec spawn_form_row
SpawnShotFromColumn_edblock1440
	jmp SpawnShotFromColumn_while1211
SpawnShotFromColumn_edblock1214
SpawnShotFromColumn_loopend1216
	rts
end_procedure_SpawnShotFromColumn
	
; // ---------------------------------------------------------------------------
; // SpawnShotFromColumn
; //   Fires enemy-shot slot `spawn_slot` from the LOWEST alive alien in the
; //   given global column index (0-11, left to right).
; //
; //   Formation geometry:
; //     12 columns total — 4 block-columns * 3 enemy-columns per block.
; //     Column pitch = 18 px (MONSTER_SPACING / 3 = 54/3 = 18).
; //     spawn_col 0-11  →  block_col = spawn_col/3,  enemy_col = spawn_col mod 3
; //     Screen X = monster_base_x + block_col*MONSTER_SPACING + enemy_col*18 - 6
; //     Screen Y uses per-sub-row offsets so shots appear just below visible alien pixels:
; //       sub_row 0 (top enemy):    monster_base_y + form_row*MONSTER_ROW_OFFSET - 2
; //       sub_row 1 (bottom enemy): monster_base_y + form_row*MONSTER_ROW_OFFSET + 11
; //
; //   Scan order: form_row 2→0 (bottom→top), sub_row 1→0 within each block row.
; //   Stops at the first (lowest) alive alien found and activates the shot slot.
; //   If no alive alien exists in the column the slot is left untouched.
; // ---------------------------------------------------------------------------
; // ---------------------------------------------------------------------------
; // TickEnemyShotFiring
; //   Manages the stagger timer and selects the correct column for each shot
; //   type, then calls SpawnShotFromColumn (nested — sole caller).
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : TickEnemyShotFiring
	;    Procedure type : User-defined procedure
tef_fire_col	dc.b	0
tef_player_rel_x	dc.b	0
TickEnemyShotFiring_block1445
TickEnemyShotFiring
	; Binary clause Simplified: EQUALS
	clc
	lda #$0
	; cmp #$00 ignored
	bne TickEnemyShotFiring_localfailed2770
	jmp TickEnemyShotFiring_ctb1447
TickEnemyShotFiring_localfailed2770
	jmp TickEnemyShotFiring_edblock1449
TickEnemyShotFiring_ctb1447: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda ufo_bullet_stagger_counter
	; cmp #$00 ignored
	bne TickEnemyShotFiring_localfailed3433
	jmp TickEnemyShotFiring_ctb2773
TickEnemyShotFiring_localfailed3433
	jmp TickEnemyShotFiring_eblock2774
TickEnemyShotFiring_ctb2773: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	ldx ufo_bullet_next_to_fire
	lda ufo_bullet_active,x 
	; cmp #$00 ignored
	bne TickEnemyShotFiring_localfailed3761
	jmp TickEnemyShotFiring_ctb3436
TickEnemyShotFiring_localfailed3761
	jmp TickEnemyShotFiring_edblock3438
TickEnemyShotFiring_ctb3436: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	ldx ufo_bullet_next_to_fire
	lda ufo_bullet_reload_timer,x 
	; cmp #$00 ignored
	bne TickEnemyShotFiring_localfailed3925
	jmp TickEnemyShotFiring_ctb3764
TickEnemyShotFiring_localfailed3925
	jmp TickEnemyShotFiring_edblock3766
TickEnemyShotFiring_ctb3764: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda ufo_bullet_next_to_fire
	; cmp #$00 ignored
	bne TickEnemyShotFiring_localfailed4007
	jmp TickEnemyShotFiring_ctb3928
TickEnemyShotFiring_localfailed4007
	jmp TickEnemyShotFiring_eblock3929
TickEnemyShotFiring_ctb3928: ;Main true block ;keep 
	
; // SpawnShotFromColumn
; // Debug gate: disable enemy firing entirely when DEBUG_DISABLE_ENEMY_FIRE = 1
; // Arcade reload gate: slot must have counted down its reload delay
; // before it can fire again.  Timer is set when the previous shot ends.
; // Plunger: predefined column sequence, arcade-accurate.
; // Arcade table is 1-indexed (1-11); subtract 1 for our 0-based columns.
	; 8 bit binop
	; Add/sub where right value is constant number
	lda es_plunger_step
	; Calling storevariable on generic assign expression
	sta Helpers_plunger_step
	jsr Helpers_GetPlungerFireColumn
	sec
	sbc #$1
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta tef_fire_col
	; Test Inc dec D
	inc es_plunger_step
	; Binary clause Simplified: GREATEREQUAL
	lda es_plunger_step
	; Compare with pure num / var optimization
	cmp #$10;keep
	bcc TickEnemyShotFiring_edblock4012
TickEnemyShotFiring_ctb4010: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta es_plunger_step
TickEnemyShotFiring_edblock4012
	jmp TickEnemyShotFiring_edblock3930
TickEnemyShotFiring_eblock3929
	; Binary clause Simplified: EQUALS
	lda ufo_bullet_next_to_fire
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne TickEnemyShotFiring_eblock4018
TickEnemyShotFiring_ctb4017: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	lda player_sprite_x
	; Compare with pure num / var optimization
	cmp monster_base_x;keep
	bcc TickEnemyShotFiring_eblock4055
TickEnemyShotFiring_ctb4054: ;Main true block ;keep 
	
; // Rolling/Teflon: target the column directly above the player.
; // Column = (player_x - formation_left) / 18, clamped to 0-11.
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_sprite_x
	sec
	sbc monster_base_x
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta tef_player_rel_x
	; Right is PURE NUMERIC : Is word =0
	; 8 bit div
	sta div8x8_d
	; Load right hand side
	lda #$12
	sta div8x8_c
	jsr div8x8_procedure
	; Calling storevariable on generic assign expression
	sta tef_fire_col
	; Binary clause Simplified: GREATEREQUAL
	; Compare with pure num / var optimization
	cmp #$c;keep
	bcc TickEnemyShotFiring_edblock4073
TickEnemyShotFiring_ctb4071: ;Main true block ;keep 
	lda #$b
	; Calling storevariable on generic assign expression
	sta tef_fire_col
TickEnemyShotFiring_edblock4073
	jmp TickEnemyShotFiring_edblock4056
TickEnemyShotFiring_eblock4055
	lda #$0
	; Calling storevariable on generic assign expression
	sta tef_fire_col
TickEnemyShotFiring_edblock4056
	jmp TickEnemyShotFiring_edblock4019
TickEnemyShotFiring_eblock4018
	
; // Squiggly: predefined column sequence, arcade-accurate.
	; 8 bit binop
	; Add/sub where right value is constant number
	lda es_squiggly_step
	; Calling storevariable on generic assign expression
	sta Helpers_squiggly_step
	jsr Helpers_GetSquigglyFireColumn
	sec
	sbc #$1
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta tef_fire_col
	; Test Inc dec D
	inc es_squiggly_step
	; Binary clause Simplified: GREATEREQUAL
	lda es_squiggly_step
	; Compare with pure num / var optimization
	cmp #$10;keep
	bcc TickEnemyShotFiring_edblock4081
TickEnemyShotFiring_ctb4079: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta es_squiggly_step
TickEnemyShotFiring_edblock4081
TickEnemyShotFiring_edblock4019
TickEnemyShotFiring_edblock3930
	lda tef_fire_col
	; Calling storevariable on generic assign expression
	sta spawn_col
	lda ufo_bullet_next_to_fire
	; Calling storevariable on generic assign expression
	sta spawn_slot
	jsr SpawnShotFromColumn
TickEnemyShotFiring_edblock3766
TickEnemyShotFiring_edblock3438
	
; // Advance to next slot (cycles 0→1→2→0)
	; Test Inc dec D
	inc ufo_bullet_next_to_fire
	; Binary clause Simplified: GREATEREQUAL
	lda ufo_bullet_next_to_fire
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcc TickEnemyShotFiring_edblock4087
TickEnemyShotFiring_ctb4085: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_bullet_next_to_fire
TickEnemyShotFiring_edblock4087
	lda #$1
	; Calling storevariable on generic assign expression
	sta ufo_bullet_stagger_counter
	jmp TickEnemyShotFiring_edblock2775
TickEnemyShotFiring_eblock2774
	; Test Inc dec D
	dec ufo_bullet_stagger_counter
TickEnemyShotFiring_edblock2775
TickEnemyShotFiring_edblock1449
	rts
end_procedure_TickEnemyShotFiring
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ShowUFOBullet
	;    Procedure type : User-defined procedure
sub_i	dc.b	0
ub_sprite_index	dc.b	0
ub_sprite	dc.b	0
ub_anim_offset	dc.b	0
ShowUFOBullet_block4091
ShowUFOBullet
	lda #$0
	; Calling storevariable on generic assign expression
	sta sub_i
ShowUFOBullet_while4092
ShowUFOBullet_loopstart4096
	; Optimization: replacing a <= N with a <= N-1
	; Binary clause Simplified: LESS
	lda sub_i
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs ShowUFOBullet_localfailed4252
	jmp ShowUFOBullet_ctb4093
ShowUFOBullet_localfailed4252
	jmp ShowUFOBullet_edblock4095
ShowUFOBullet_ctb4093: ;Main true block ;keep 
	; Load Byte array
	; CAST type NADA
	ldx sub_i
	lda ufo_bullet_sprite,x 
	; Calling storevariable on generic assign expression
	sta ub_sprite
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda ufo_bullet_active,x 
	; cmp #$00 ignored
	beq ShowUFOBullet_localfailed4332
	jmp ShowUFOBullet_ctb4255
ShowUFOBullet_localfailed4332
	jmp ShowUFOBullet_eblock4256
ShowUFOBullet_ctb4255: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	; Load Byte array
	; CAST type NADA
	ldx sub_i
	lda ufo_bullet_active,x 
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne ShowUFOBullet_eblock4336
ShowUFOBullet_ctb4335: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	lda sub_i
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne ShowUFOBullet_eblock4367
ShowUFOBullet_ctb4366: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	; Load Byte array
	; CAST type NADA
	ldx sub_i
	lda ufo_bullet_anim_index,x 
	; Compare with pure num / var optimization
	cmp #$3;keep
	bne ShowUFOBullet_eblock4382
ShowUFOBullet_ctb4381: ;Main true block ;keep 
	
; // Squiggly (slot 2): bounce animation 0→1→2→1 (frames 5,6,7,6)
; // Others: linear animation 0→1→2→3 (frames start+0,+1,+2,+3)
; // Map index 3 back to offset 1 for bounce
	lda #$1
	; Calling storevariable on generic assign expression
	sta ub_anim_offset
	jmp ShowUFOBullet_edblock4383
ShowUFOBullet_eblock4382
	; Load Byte array
	; CAST type NADA
	ldx sub_i
	lda ufo_bullet_anim_index,x 
	; Calling storevariable on generic assign expression
	sta ub_anim_offset
ShowUFOBullet_edblock4383
	jmp ShowUFOBullet_edblock4368
ShowUFOBullet_eblock4367
	; Load Byte array
	; CAST type NADA
	ldx sub_i
	lda ufo_bullet_anim_index,x 
	; Calling storevariable on generic assign expression
	sta ub_anim_offset
ShowUFOBullet_edblock4368
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx sub_i
	lda ufo_bullet_anim_start,x 
	clc
	adc ub_anim_offset
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta ub_sprite_index
	jmp ShowUFOBullet_edblock4337
ShowUFOBullet_eblock4336
	lda #$4
	; Calling storevariable on generic assign expression
	sta ub_sprite_index
ShowUFOBullet_edblock4337
	
; // Explosion frame
	; Set sprite location
	lda ub_sprite
	sta $50
	; Generic 16 bit op
	ldy #0
	lda #$1
ShowUFOBullet_rightvarInteger_var4392 = $54
	sta ShowUFOBullet_rightvarInteger_var4392
	sty ShowUFOBullet_rightvarInteger_var4392+1
	; Generic 16 bit op
	ldy #0
	lda ub_sprite_index
ShowUFOBullet_rightvarInteger_var4395 = $56
	sta ShowUFOBullet_rightvarInteger_var4395
	sty ShowUFOBullet_rightvarInteger_var4395+1
	lda #128
	ldy #0
	; Low bit binop:
	clc
	adc ShowUFOBullet_rightvarInteger_var4395
ShowUFOBullet_wordAdd4393
	sta ShowUFOBullet_rightvarInteger_var4395
	; High-bit binop
	tya
	adc ShowUFOBullet_rightvarInteger_var4395+1
	tay
	lda ShowUFOBullet_rightvarInteger_var4395
	; Low bit binop:
	sec
	sbc ShowUFOBullet_rightvarInteger_var4392
ShowUFOBullet_wordAdd4390
	sta ShowUFOBullet_rightvarInteger_var4392
	; High-bit binop
	tya
	sbc ShowUFOBullet_rightvarInteger_var4392+1
	tay
	lda ShowUFOBullet_rightvarInteger_var4392
	ldx $50
	sta $07f8 + $0,x
	; Setting sprite position
	; Load Byte array
	; CAST type NADA
	ldx sub_i
	lda ufo_bullet_x,x 
	pha
	lda ub_sprite
	pha
	tax
	lda #1
ShowUFOBullet_shiftbit4398
	cpx #0
	beq ShowUFOBullet_shiftbitdone4399
	asl
	dex
	jmp ShowUFOBullet_shiftbit4398
ShowUFOBullet_shiftbitdone4399
ShowUFOBullet_bitmask_var4400 = $54
	sta ShowUFOBullet_bitmask_var4400
	pla
	asl
	tax
	pla
	sta $D000,x
ShowUFOBullet_spritepos4396
	lda #$FF
	eor ShowUFOBullet_bitmask_var4400
	sta ShowUFOBullet_bitmask_var4400
	lda $D010
	and ShowUFOBullet_bitmask_var4400
	sta $D010
ShowUFOBullet_spriteposcontinue4397
	inx
	txa
	tay
	; Load Byte array
	; CAST type NADA
	ldx sub_i
	lda ufo_bullet_y,x 
	sta $D000,y
	jmp ShowUFOBullet_edblock4257
ShowUFOBullet_eblock4256
	; Setting sprite position
	lda #$0
	pha
	lda ub_sprite
	pha
	tax
	lda #1
ShowUFOBullet_shiftbit4404
	cpx #0
	beq ShowUFOBullet_shiftbitdone4405
	asl
	dex
	jmp ShowUFOBullet_shiftbit4404
ShowUFOBullet_shiftbitdone4405
ShowUFOBullet_bitmask_var4406 = $54
	sta ShowUFOBullet_bitmask_var4406
	pla
	asl
	tax
	pla
	sta $D000,x
ShowUFOBullet_spritepos4402
	lda #$FF
	eor ShowUFOBullet_bitmask_var4406
	sta ShowUFOBullet_bitmask_var4406
	lda $D010
	and ShowUFOBullet_bitmask_var4406
	sta $D010
ShowUFOBullet_spriteposcontinue4403
	inx
	txa
	tay
	lda #$ff
	sta $D000,y
ShowUFOBullet_edblock4257
	
; // Push off-screen when inactive
	; Test Inc dec D
	inc sub_i
	jmp ShowUFOBullet_while4092
ShowUFOBullet_edblock4095
ShowUFOBullet_loopend4097
	rts
end_procedure_ShowUFOBullet
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateUFOBullet
	;    Procedure type : User-defined procedure
ub_i	dc.b	0
ub_anim_fired	dc.b	0
ub_alive	dc.b	0
ub_reload	dc.b	0
UpdateUFOBullet_block4407
UpdateUFOBullet
	
; // frames each animation image is shown before advancing
; // frames enemy-shot explosion stays on screen
; // enemies_alive snapshot used for reload calculation
	lda #$0
	; Calling storevariable on generic assign expression
	sta ub_i
UpdateUFOBullet_while4408
UpdateUFOBullet_loopstart4412
	; Optimization: replacing a <= N with a <= N-1
	; Binary clause Simplified: LESS
	lda ub_i
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs UpdateUFOBullet_localfailed4810
	jmp UpdateUFOBullet_ctb4409
UpdateUFOBullet_localfailed4810
	jmp UpdateUFOBullet_edblock4411
UpdateUFOBullet_ctb4409: ;Main true block ;keep 
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	ldx ub_i
	lda ufo_bullet_active,x 
	; cmp #$00 ignored
	beq UpdateUFOBullet_localfailed5011
	jmp UpdateUFOBullet_ctb4813
UpdateUFOBullet_localfailed5011
	jmp UpdateUFOBullet_eblock4814
UpdateUFOBullet_ctb4813: ;Main true block ;keep 
	
; // Animation tick: advances frame every ES_SHOT_ANIM_HOLD_FRAMES frames
	lda #$0
	; Calling storevariable on generic assign expression
	sta ub_anim_fired
	; Test Inc dec D
	ldx ub_i
	; Optimize byte array inc 
	inc ufo_bullet_anim_tick,x
	; Binary clause Simplified: GREATEREQUAL
	; Load Byte array
	; CAST type NADA
	lda ufo_bullet_anim_tick,x 
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcc UpdateUFOBullet_edblock5016
UpdateUFOBullet_ctb5014: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	ldx ub_i ; optimized, look out for bugs
	sta ufo_bullet_anim_tick,x
	lda #$1
	; Calling storevariable on generic assign expression
	sta ub_anim_fired
UpdateUFOBullet_edblock5016
	; Binary clause Simplified: EQUALS
	; Load Byte array
	; CAST type NADA
	ldx ub_i
	lda ufo_bullet_active,x 
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne UpdateUFOBullet_localfailed5111
	jmp UpdateUFOBullet_ctb5020
UpdateUFOBullet_localfailed5111
	jmp UpdateUFOBullet_eblock5021
UpdateUFOBullet_ctb5020: ;Main true block ;keep 
	
; // 1 px per frame — exact arcade speed at 60 Hz NTSC.
; // (Arcade also runs 60 Hz; shots move 4 px every 4 frames = 1 px/frame.)
	; Test Inc dec D
	ldx ub_i
	; Optimize byte array inc 
	inc ufo_bullet_y,x
	; Binary clause Simplified: NOTEQUALS
	clc
	lda ub_anim_fired
	; cmp #$00 ignored
	beq UpdateUFOBullet_edblock5116
UpdateUFOBullet_ctb5114: ;Main true block ;keep 
	
; // Animation advances on its own tick
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx ub_i
	lda ufo_bullet_anim_index,x 
	clc
	adc #$1
	 ; end add / sub var with constant
	and #$3
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta ufo_bullet_anim_index,x
UpdateUFOBullet_edblock5116
	; Binary clause Simplified: GREATEREQUAL
	; Load Byte array
	; CAST type NADA
	ldx ub_i
	lda ufo_bullet_y,x 
	; Compare with pure num / var optimization
	cmp #$e4;keep
	bcc UpdateUFOBullet_edblock5122
UpdateUFOBullet_ctb5120: ;Main true block ;keep 
	
; // Check if hit bottom of screen
	lda #$2
	; Calling storevariable on generic assign expression
	ldx ub_i ; optimized, look out for bugs
	sta ufo_bullet_active,x
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_bullet_explode_counter,x
UpdateUFOBullet_edblock5122
	jmp UpdateUFOBullet_edblock5022
UpdateUFOBullet_eblock5021
	; Binary clause Simplified: EQUALS
	; Load Byte array
	; CAST type NADA
	ldx ub_i
	lda ufo_bullet_active,x 
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne UpdateUFOBullet_edblock5129
UpdateUFOBullet_ctb5127: ;Main true block ;keep 
	
; // Explosion frame
	; Test Inc dec D
	ldx ub_i
	; Optimize byte array inc 
	inc ufo_bullet_explode_counter,x
	; Binary clause Simplified: GREATEREQUAL
	; Load Byte array
	; CAST type NADA
	lda ufo_bullet_explode_counter,x 
	; Compare with pure num / var optimization
	cmp #$4;keep
	bcc UpdateUFOBullet_edblock5169
UpdateUFOBullet_ctb5167: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	ldx ub_i ; optimized, look out for bugs
	sta ufo_bullet_active,x
	
; // Arcade reload: alive - ES_SHOT_RELOAD_OFFSET, clamped to ES_SHOT_RELOAD_MIN.
; // 55 alive (full rack) - 7 = 48 frames = arcade's $30 reload value.
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$47
	sec
	sbc numberOfEnemies
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta ub_alive
	; Binary clause Simplified: GREATEREQUAL
	; Compare with pure num / var optimization
	cmp #$8;keep
	bcc UpdateUFOBullet_eblock5188
UpdateUFOBullet_ctb5187: ;Main true block ;keep 
	; Optimizer: a = a +/- b
	; Load16bitvariable : ub_alive
	lda ub_alive
	sec
	sbc #$7
	sta ub_reload
	jmp UpdateUFOBullet_edblock5189
UpdateUFOBullet_eblock5188
	lda #$0
	; Calling storevariable on generic assign expression
	sta ub_reload
UpdateUFOBullet_edblock5189
	; Binary clause Simplified: LESS
	lda ub_reload
	; Compare with pure num / var optimization
	cmp #$8;keep
	bcs UpdateUFOBullet_edblock5197
UpdateUFOBullet_ctb5195: ;Main true block ;keep 
	lda #$8
	; Calling storevariable on generic assign expression
	sta ub_reload
UpdateUFOBullet_edblock5197
	lda ub_reload
	; Calling storevariable on generic assign expression
	ldx ub_i ; optimized, look out for bugs
	sta ufo_bullet_reload_timer,x
UpdateUFOBullet_edblock5169
UpdateUFOBullet_edblock5129
UpdateUFOBullet_edblock5022
	jmp UpdateUFOBullet_edblock4815
UpdateUFOBullet_eblock4814
	; Binary clause Simplified: GREATEREQUAL
	; Load Byte array
	; CAST type NADA
	ldx ub_i
	lda ufo_bullet_reload_timer,x 
	; Compare with pure num / var optimization
	cmp #$1;keep
	bcc UpdateUFOBullet_edblock5204
UpdateUFOBullet_ctb5202: ;Main true block ;keep 
	
; // Slot inactive: tick down any remaining reload delay each frame.
	; Test Inc dec D
	ldx ub_i
	; Optimize byte array dec 
	dec ufo_bullet_reload_timer,x
UpdateUFOBullet_edblock5204
UpdateUFOBullet_edblock4815
	; Test Inc dec D
	inc ub_i
	jmp UpdateUFOBullet_while4408
UpdateUFOBullet_edblock4411
UpdateUFOBullet_loopend4413
	rts
end_procedure_UpdateUFOBullet
	
; // ---------------------------------------------------------------------------
; // Shot-vs-Shot collision: check if the player bullet overlaps any enemy bullet.
; // Plunger (slot 0) and Squiggly (slot 2): mutual destruction on contact.
; // Rolling / Teflon (slot 1): player bullet destroyed, Rolling shot continues.
; //   (Arcade: Rolling handler never checks framebuffer overlap,
; //    but the player bullet's own collision routine detects the
; //    Rolling shot's pixels and treats it as a missed-alien hit.)
; // ---------------------------------------------------------------------------
; // Pixel-accurate AABB hitboxes (active pixels positioned at bottom of the
; // 24x21 sprite box, horizontally centered 1px left of center at X offset 11):
; //   Player bullet: 1px wide x 4px tall — sprite offsets (11,17)-(11,20)
; //   Enemy shot:    3px wide x 7px tall — sprite offsets (10,14)-(12,20)
; //
; // Overlap conditions (derived from pixel positions):
; //   X:  |player_x - enemy_x|  <=  1
; //   Y:  player_y >= enemy_y - 6  AND  player_y <= enemy_y + 3
; //
; // On hit: player bullet resets immediately (active:=0, can fire again next
; // frame).  Enemy shot enters explosion state (active:=2) for
; // ES_SHOT_EXPLODE_DURATION frames.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CheckShotVsShotCollision
	;    Procedure type : User-defined procedure
sc_i	dc.b	0
sc_dx	dc.b	0
sc_overlap	dc.b	0
sc_alive	dc.b	0
sc_reload	dc.b	0
CheckShotVsShotCollision_block5207
CheckShotVsShotCollision
	; Binary clause Simplified: NOTEQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$1;keep
	beq CheckShotVsShotCollision_localfailed6761
	jmp CheckShotVsShotCollision_ctb5209
CheckShotVsShotCollision_localfailed6761
	jmp CheckShotVsShotCollision_eblock5210
CheckShotVsShotCollision_ctb5209: ;Main true block ;keep 
	
; // 1 = arcade-like (player bullet locked out)
; // max abs X distance for overlap
; // player can be up to 6px above enemy shot
; // player can be up to 3px below enemy shot
; // reload delay when Plunger/Squiggly is instantly destroyed
; // Only check when the player bullet is actively moving (state 1)
; // nothing to do but we need a statement here
	lda #$0
	; Calling storevariable on generic assign expression
	sta sc_overlap
	jmp CheckShotVsShotCollision_edblock5211
CheckShotVsShotCollision_eblock5210
	lda #$0
	; Calling storevariable on generic assign expression
	sta sc_i
CheckShotVsShotCollision_while6764
CheckShotVsShotCollision_loopstart6768
	; Binary clause Simplified: LESS
	lda sc_i
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs CheckShotVsShotCollision_localfailed7540
	jmp CheckShotVsShotCollision_ctb6765
CheckShotVsShotCollision_localfailed7540
	jmp CheckShotVsShotCollision_edblock6767
CheckShotVsShotCollision_ctb6765: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	; Load Byte array
	; CAST type NADA
	ldx sc_i
	lda ufo_bullet_active,x 
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CheckShotVsShotCollision_localfailed7928
	jmp CheckShotVsShotCollision_ctb7543
CheckShotVsShotCollision_localfailed7928
	jmp CheckShotVsShotCollision_edblock7545
CheckShotVsShotCollision_ctb7543: ;Main true block ;keep 
	; Binary clause Simplified: LESSEQUAL
	; Load Byte array
	; CAST type NADA
	ldx sc_i
	lda ufo_bullet_x,x 
	; Compare with pure num / var optimization
	cmp player_bullet_x;keep
	beq CheckShotVsShotCollision_ctb7931
	bcs CheckShotVsShotCollision_eblock7932
CheckShotVsShotCollision_ctb7931: ;Main true block ;keep 
	
; // Only test against actively moving enemy bullets (state 1)
; // ---- X overlap (pixel-accurate AABB) ----
; // Both active areas share the same X centre offset (pixel 11),
; // so the check reduces to |player_x - enemy_x| <= MAX_DX.
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_x
	sec
	; Load Byte array
	; CAST type NADA
	ldx sc_i
	sbc ufo_bullet_x,x 
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta sc_dx
	jmp CheckShotVsShotCollision_edblock7933
CheckShotVsShotCollision_eblock7932
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx sc_i
	lda ufo_bullet_x,x 
	sec
	sbc player_bullet_x
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta sc_dx
CheckShotVsShotCollision_edblock7933
	; Binary clause Simplified: LESS
	lda sc_dx
	; Compare with pure num / var optimization
	cmp #$2;keep
	bcs CheckShotVsShotCollision_localfailed8126
	jmp CheckShotVsShotCollision_ctb7939
CheckShotVsShotCollision_localfailed8126
	jmp CheckShotVsShotCollision_edblock7941
CheckShotVsShotCollision_ctb7939: ;Main true block ;keep 
	
; // ---- Y overlap (asymmetric AABB) ----
; // Player active Y: [py+17 .. py+20]  (4px, bottom-aligned)
; // Enemy  active Y: [ey+14 .. ey+20]  (7px, bottom-aligned)
; // Overlap iff: py >= ey - Y_ABOVE  AND  py <= ey + Y_BELOW
	lda #$1
	; Calling storevariable on generic assign expression
	sta sc_overlap
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_y
	clc
	adc #$6
	 ; end add / sub var with constant
CheckShotVsShotCollision_binary_clause_temp_var8133 = $54
	sta CheckShotVsShotCollision_binary_clause_temp_var8133
	; Load Byte array
	; CAST type NADA
	ldx sc_i
	lda ufo_bullet_y,x 
CheckShotVsShotCollision_binary_clause_temp_2_var8134 = $56
	sta CheckShotVsShotCollision_binary_clause_temp_2_var8134
	lda CheckShotVsShotCollision_binary_clause_temp_var8133
	cmp CheckShotVsShotCollision_binary_clause_temp_2_var8134;keep
	bcs CheckShotVsShotCollision_edblock8131
CheckShotVsShotCollision_ctb8129: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta sc_overlap
CheckShotVsShotCollision_edblock8131
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx sc_i
	lda ufo_bullet_y,x 
	clc
	adc #$3
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp player_bullet_y;keep
	bcs CheckShotVsShotCollision_edblock8139
CheckShotVsShotCollision_ctb8137: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta sc_overlap
CheckShotVsShotCollision_edblock8139
	; Binary clause Simplified: EQUALS
	lda sc_overlap
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CheckShotVsShotCollision_localfailed8228
	jmp CheckShotVsShotCollision_ctb8143
CheckShotVsShotCollision_localfailed8228
	jmp CheckShotVsShotCollision_edblock8145
CheckShotVsShotCollision_ctb8143: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	lda sc_i
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CheckShotVsShotCollision_localfailed8272
	jmp CheckShotVsShotCollision_ctb8231
CheckShotVsShotCollision_localfailed8272
	jmp CheckShotVsShotCollision_eblock8232
CheckShotVsShotCollision_ctb8231: ;Main true block ;keep 
	
; // Hit detected!
; // Rolling / "Teflon" — arcade asymmetric:
; // The Rolling handler never checks for pixel overlap
; // so it continues. The player bullet DOES detect the
; // overlap and is destroyed (status 3 → explosion).
	lda #$3
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	
; // enemy-shot explosion sprite
	lda #$0
	; Calling storevariable on generic assign expression
	sta explosion_frame_counter
	jmp CheckShotVsShotCollision_edblock8233
CheckShotVsShotCollision_eblock8232
	; Binary clause Simplified: EQUALS
	lda #$1
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CheckShotVsShotCollision_eblock8277
CheckShotVsShotCollision_ctb8276: ;Main true block ;keep 
	
; // Rolling shot keeps moving — do NOT touch ufo_bullet_active
; // Plunger / Squiggly — mutual destruction
; // Arcade-like: player bullet locked out (explosion on player sprite)
	lda #$3
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	
; // enemy-shot explosion sprite
	lda #$0
	; Calling storevariable on generic assign expression
	sta explosion_frame_counter
	
; // Enemy shot resets immediately — skips explosion state so
; // UpdateUFOBullet never sees state 2; set reload timer here.
	; Calling storevariable on generic assign expression
	ldx sc_i ; optimized, look out for bugs
	sta ufo_bullet_active,x
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$47
	sec
	sbc numberOfEnemies
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta sc_alive
	; Binary clause Simplified: GREATEREQUAL
	; Compare with pure num / var optimization
	cmp #$8;keep
	bcc CheckShotVsShotCollision_eblock8298
CheckShotVsShotCollision_ctb8297: ;Main true block ;keep 
	; Optimizer: a = a +/- b
	; Load16bitvariable : sc_alive
	lda sc_alive
	sec
	sbc #$7
	sta sc_reload
	jmp CheckShotVsShotCollision_edblock8299
CheckShotVsShotCollision_eblock8298
	lda #$0
	; Calling storevariable on generic assign expression
	sta sc_reload
CheckShotVsShotCollision_edblock8299
	; Binary clause Simplified: LESS
	lda sc_reload
	; Compare with pure num / var optimization
	cmp #$8;keep
	bcs CheckShotVsShotCollision_edblock8307
CheckShotVsShotCollision_ctb8305: ;Main true block ;keep 
	lda #$8
	; Calling storevariable on generic assign expression
	sta sc_reload
CheckShotVsShotCollision_edblock8307
	lda sc_reload
	; Calling storevariable on generic assign expression
	ldx sc_i ; optimized, look out for bugs
	sta ufo_bullet_reload_timer,x
	jmp CheckShotVsShotCollision_edblock8278
CheckShotVsShotCollision_eblock8277
	
; // Default: enemy shot explodes (explosion on enemy sprite)
	lda #$2
	; Calling storevariable on generic assign expression
	ldx sc_i ; optimized, look out for bugs
	sta ufo_bullet_active,x
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_bullet_explode_counter,x
	
; // Player bullet resets immediately — can fire again next frame
	; Calling storevariable on generic assign expression
	sta player_bullet_active
CheckShotVsShotCollision_edblock8278
CheckShotVsShotCollision_edblock8233
CheckShotVsShotCollision_edblock8145
CheckShotVsShotCollision_edblock7941
CheckShotVsShotCollision_edblock7545
	; Test Inc dec D
	inc sc_i
	jmp CheckShotVsShotCollision_while6764
CheckShotVsShotCollision_edblock6767
CheckShotVsShotCollision_loopend6769
CheckShotVsShotCollision_edblock5211
	rts
end_procedure_CheckShotVsShotCollision
	
; // ---------------------------------------------------------------------------
; // CheckEnemyShotPlayerCollision
; //   Checks if any enemy bullet (state 1 = actively moving) overlaps the player ship.
; //   Hitbox logic matches CheckUFOCollision pattern for consistency.
; //   
; //   Player ship hitbox (13×8 px):
; //     X offsets: [player_x+5 .. player_x+18] (centered with 5px left, 6px right margin)
; //     Y offsets: [player_y+0 .. player_y+8] (at TOP of sprite, 8px tall)
; //
; //   Enemy bullet hitbox (3×6 px at BOTTOM of 21px-tall sprite):
; //     X offsets: [bullet_x+10 .. bullet_x+13] (centered with 10px left, 11px right margin)
; //     Y offsets: [bullet_y+15 .. bullet_y+21] (bottom 6px of sprite)
; //
; //   Y overlap occurs when: bullet_y in [player_y-21 .. player_y-7]
; //     For PLAYER_POS_Y=226: bullet_y in [205 .. 219]
; //   X overlap occurs when: |player_x - bullet_x| <= 8
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CheckEnemyShotPlayerCollision
	;    Procedure type : User-defined procedure
cesp_i	dc.b	0
cesp_dx	dc.b	0
cesp_y_overlap	dc.b	0
cesp_x_overlap	dc.b	0
CheckEnemyShotPlayerCollision_block8311
CheckEnemyShotPlayerCollision
	; Binary clause Simplified: EQUALS
	clc
	lda player_respawn_state
	; cmp #$00 ignored
	bne CheckEnemyShotPlayerCollision_localfailed8568
	jmp CheckEnemyShotPlayerCollision_ctb8313
CheckEnemyShotPlayerCollision_localfailed8568
	jmp CheckEnemyShotPlayerCollision_edblock8315
CheckEnemyShotPlayerCollision_ctb8313: ;Main true block ;keep 
	
; // Only check if player is not already respawning/dead
	lda #$0
	; Calling storevariable on generic assign expression
	sta cesp_i
CheckEnemyShotPlayerCollision_while8570
CheckEnemyShotPlayerCollision_loopstart8574
	; Binary clause Simplified: LESS
	lda cesp_i
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs CheckEnemyShotPlayerCollision_localfailed8698
	jmp CheckEnemyShotPlayerCollision_ctb8571
CheckEnemyShotPlayerCollision_localfailed8698
	jmp CheckEnemyShotPlayerCollision_edblock8573
CheckEnemyShotPlayerCollision_ctb8571: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	; Load Byte array
	; CAST type NADA
	ldx cesp_i
	lda ufo_bullet_active,x 
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CheckEnemyShotPlayerCollision_localfailed8762
	jmp CheckEnemyShotPlayerCollision_ctb8701
CheckEnemyShotPlayerCollision_localfailed8762
	jmp CheckEnemyShotPlayerCollision_edblock8703
CheckEnemyShotPlayerCollision_ctb8701: ;Main true block ;keep 
	
; // Only test against actively moving enemy bullets (state 1)
; // ---- Y overlap check first (early rejection) ----
; // Player hitbox Y:  [player_y, player_y+8]
; // Bullet hitbox Y:  [bullet_y+15, bullet_y+21]
; // Overlap when: bullet_y + 15 <= player_y + 8 AND player_y <= bullet_y + 21
; // Simplifies to: bullet_y <= player_y-7 AND bullet_y >= player_y-21cesp_y_overlap := 0;
; //				if ((ufo_bullet_y[cesp_i] >= player_sprite_y - 21) and
; //				   (ufo_bullet_y[cesp_i] <= player_sprite_y - 7)) then
; //					cesp_y_overlap := 1;
	lda #$0
	; Calling storevariable on generic assign expression
	sta cesp_y_overlap
	; Binary clause Simplified: GREATEREQUAL
	; Load Byte array
	; CAST type NADA
	ldx cesp_i
	lda ufo_bullet_y,x 
CheckEnemyShotPlayerCollision_binary_clause_temp_var8770 = $54
	sta CheckEnemyShotPlayerCollision_binary_clause_temp_var8770
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_sprite_y
	sec
	sbc #$15
	 ; end add / sub var with constant
CheckEnemyShotPlayerCollision_binary_clause_temp_2_var8771 = $56
	sta CheckEnemyShotPlayerCollision_binary_clause_temp_2_var8771
	lda CheckEnemyShotPlayerCollision_binary_clause_temp_var8770
	cmp CheckEnemyShotPlayerCollision_binary_clause_temp_2_var8771;keep
	bcc CheckEnemyShotPlayerCollision_edblock8767
CheckEnemyShotPlayerCollision_localsuccess8769: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESSEQUAL
	; Load Byte array
	; CAST type NADA
	ldx cesp_i
	lda ufo_bullet_y,x 
CheckEnemyShotPlayerCollision_binary_clause_temp_var8772 = $54
	sta CheckEnemyShotPlayerCollision_binary_clause_temp_var8772
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_sprite_y
	sec
	sbc #$d
	 ; end add / sub var with constant
CheckEnemyShotPlayerCollision_binary_clause_temp_2_var8773 = $56
	sta CheckEnemyShotPlayerCollision_binary_clause_temp_2_var8773
	lda CheckEnemyShotPlayerCollision_binary_clause_temp_var8772
	cmp CheckEnemyShotPlayerCollision_binary_clause_temp_2_var8773;keep
	beq CheckEnemyShotPlayerCollision_ctb8765
	bcs CheckEnemyShotPlayerCollision_edblock8767
CheckEnemyShotPlayerCollision_ctb8765: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta cesp_y_overlap
CheckEnemyShotPlayerCollision_edblock8767
	; Binary clause Simplified: EQUALS
	lda cesp_y_overlap
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CheckEnemyShotPlayerCollision_edblock8778
CheckEnemyShotPlayerCollision_ctb8776: ;Main true block ;keep 
	
; // ---- X overlap check ----
; // Player hitbox X:  [player_x+5, player_x+18]
; // Bullet hitbox X:  [bullet_x+10, bullet_x+13]
; // Overlap when: |player_x - bullet_x| <= 8
	lda #$0
	; Calling storevariable on generic assign expression
	sta cesp_x_overlap
	; Binary clause Simplified: LESSEQUAL
	; Load Byte array
	; CAST type NADA
	ldx cesp_i
	lda ufo_bullet_x,x 
	; Compare with pure num / var optimization
	cmp player_sprite_x;keep
	beq CheckEnemyShotPlayerCollision_ctb8802
	bcs CheckEnemyShotPlayerCollision_eblock8803
CheckEnemyShotPlayerCollision_ctb8802: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_sprite_x
	sec
	; Load Byte array
	; CAST type NADA
	ldx cesp_i
	sbc ufo_bullet_x,x 
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta cesp_dx
	jmp CheckEnemyShotPlayerCollision_edblock8804
CheckEnemyShotPlayerCollision_eblock8803
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx cesp_i
	lda ufo_bullet_x,x 
	sec
	sbc player_sprite_x
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta cesp_dx
CheckEnemyShotPlayerCollision_edblock8804
	; Binary clause Simplified: LESS
	lda cesp_dx
	; Compare with pure num / var optimization
	cmp #$9;keep
	bcs CheckEnemyShotPlayerCollision_edblock8812
CheckEnemyShotPlayerCollision_ctb8810: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta cesp_x_overlap
CheckEnemyShotPlayerCollision_edblock8812
	
; // Force loop exit
	; Binary clause Simplified: EQUALS
	lda cesp_x_overlap
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CheckEnemyShotPlayerCollision_edblock8818
CheckEnemyShotPlayerCollision_ctb8816: ;Main true block ;keep 
	
; // Hit! Kill the player
	lda #$1
	; Calling storevariable on generic assign expression
	sta player_respawn_state
	
; // Enter explosion state
	lda #$89
	; Calling storevariable on generic assign expression
	sta player_respawn_counter
	
; // 136 frames + 1 for initialization
	lda #$0
	; Calling storevariable on generic assign expression
	sta player_explosion_anim_index
	; Calling storevariable on generic assign expression
	sta player_explosion_flash_counter
	; Test Inc dec D
	dec remaining_ships
	lda #$1
	; Calling storevariable on generic assign expression
	sta lifeLostDirty
	
; // Flag to update lives display
; // Deactivate the enemy shot
	lda #$0
	; Calling storevariable on generic assign expression
	ldx cesp_i ; optimized, look out for bugs
	sta ufo_bullet_active,x
	
; // Exit after first hit
	lda #$3
	; Calling storevariable on generic assign expression
	sta cesp_i
CheckEnemyShotPlayerCollision_edblock8818
CheckEnemyShotPlayerCollision_edblock8778
CheckEnemyShotPlayerCollision_edblock8703
	; Test Inc dec D
	inc cesp_i
	jmp CheckEnemyShotPlayerCollision_while8570
CheckEnemyShotPlayerCollision_edblock8573
CheckEnemyShotPlayerCollision_loopend8575
CheckEnemyShotPlayerCollision_edblock8315
	rts
end_procedure_CheckEnemyShotPlayerCollision
	
; // ---------------------------------------------------------------------------
; // AnimateMonsters — sets sprite image pointers for the 4 block-column sprites.
; // IRQ-SAFE inline ASM: no ZP touched, no temp vars.
; //   base = 8192/64 + 26 + enemyRow*8 + monster_animation_frame
; //        = 154 + enemyRow*8 + monster_animation_frame
; //   Writes: $07F9/$07FA/$07FB/$07FC (sprite 1-4 pointer slots in screen RAM)
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : AnimateMonsters
	;    Procedure type : User-defined procedure
enemyRow	dc.b	0
AnimateMonsters_block8821
AnimateMonsters
        lda enemyRow
        asl
        asl
        asl
        clc
        adc #154
        clc
        adc monster_animation_frame
        sta $07F9
        clc
        adc #2
        sta $07FA
        clc
        adc #2
        sta $07FB
        clc
        adc #2
        sta $07FC
	rts
end_procedure_AnimateMonsters
	
; // ---------------------------------------------------------------------------
; // ENEMY FORMATION PROCEDURES — Sprites 1-4 for current row display
; // ---------------------------------------------------------------------------
; // UpdateMonsters: Sets sprite positions for a row (Y + rowOffset)
; // AnimateMonsters: Updates sprite image pointers for current animation frame
; // MakeMonsters: Resets block_enemies bits to fully alive state (55 of 72 total)
; // ClearMonster: Marks enemy dead in block_enemies; rescans formation edges; queues level-end check
; // PreclearLeftmostAndBottomEnemies: Clears initial 16 enemies at startup (reduces 72 to 55)
; // ---------------------------------------------------------------------------
; // ---------------------------------------------------------------------------
; // UpdateMonsters — sets sprite X/Y screen positions for the 4 block-column sprites.
; // IRQ-SAFE inline ASM: no ZP touched, no temp vars.
; //   Consolidates the 4 separate $D010 9th-bit clears into one AND mask.
; //   X: monster_base_x, +54, +108, +162 → $D002,$D004,$D006,$D008
; //   Y: monster_base_y + rowOffset (same for all 4) → $D003,$D005,$D007,$D009
; //   $D010 bits 1-4 (sprites 1-4): always clear — monsters never exceed 255px X.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateMonsters
	;    Procedure type : User-defined procedure
rowOffset	dc.b	0
UpdateMonsters_block8822
UpdateMonsters
        lda $D010
        and #$E1
        sta $D010
        lda monster_base_x
        sta $D002
        clc
        adc #54
        sta $D004
        clc
        adc #54
        sta $D006
        clc
        adc #54
        sta $D008
        lda monster_base_y
        clc
        adc rowOffset
        sta $D003
        sta $D005
        sta $D007
        sta $D009
	rts
end_procedure_UpdateMonsters
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MakeSprites
	;    Procedure type : User-defined procedure
MakeSprites
	
; // Set common sprite multicolor registers
; //sprite_multicolor_reg1:=green;
; //sprite_multicolor_reg2:=white;
; // Set sprite "0" individual color value 
	lda #$e
	; Calling storevariable on generic assign expression
	sta $D027+$0
	
; // Turn on sprite 0 (or @useSprite)
; //togglebit(sprite_bitmask,useSprite,1);
; // Enable enemy-shot hardware sprites and set color
	lda #$3
	; Calling storevariable on generic assign expression
	sta $D027+$6
	; Calling storevariable on generic assign expression
	sta $D027+$5
	; Calling storevariable on generic assign expression
	sta $D027+$7
	rts
end_procedure_MakeSprites
	
; //togglebit(sprite_bitmask,ES_SHOT_SPRITE1,1);
; //togglebit(sprite_bitmask,ES_SHOT_SPRITE2,1);
; //togglebit(sprite_bitmask,ES_SHOT_SPRITE3,1);
; // UFO uses hardware sprite 2 (shared with monsterSprite2 via raster mux).
; // The sprite is already enabled by MakeMonsters via monsterSprite2, but set
; // its color here so it is distinct at the top of the screen.
; //sprite_color[UFO_HW_SPRITE] := light_red;
; // ── Nested: Restore buffered starfield chars beneath get-ready text ───────
; // ---------------------------------------------------------------------------
; // HideGetReadyText
; //   Restores the buffered starfield characters and colors to remove the "Get ready" text.
; //
; //   IRQ-SAFE: uses absolute indexed addressing on the buffer arrays whose ASM
; //   labels match their TRSE names exactly (confirmed from compiled ASM).
; //   No ZP pointers — X register only.
; //     Line 1: get_ready_char/color_buffer[0..12]  → screen $05E8, color $D9E8
; //     Line 2: get_ready_char/color_buffer[13..20] → screen $0613, color $DA13
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : HideGetReadyText
	;    Procedure type : User-defined procedure
HideGetReadyText
        ldx #12
hgrt_l1 lda get_ready_char_buffer,x
        sta $05E8,x
        lda get_ready_color_buffer,x
        sta $D9E8,x
        dex
        bpl hgrt_l1
        ldx #7
hgrt_l2 lda get_ready_char_buffer+13,x
        sta $0613,x
        lda get_ready_color_buffer+13,x
        sta $DA13,x
        dex
        bpl hgrt_l2
	
	rts
end_procedure_HideGetReadyText
	
; // HideGetReadyText
; // ---------------------------------------------------------------------------
; // ShowGameOverText
; //   Displays "GAME OVER" centered on screen row 12.  Buffers the starfield
; //   characters/colors underneath for later restoration. Uses the same pattern
; //   as ShowGetReadyText with IRQ-SAFE inline ASM for character/color buffering.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ShowGameOverText
	;    Procedure type : User-defined procedure
sgot_text_msg		dc.b	"GAME OVER"
	dc.b	0
ShowGameOverText_block8825
ShowGameOverText
	
; // Disable all sprites  during game over screen
	; Assigning memory location
	lda #$0
	; Calling storevariable on generic assign expression
	sta $d015
        ldx #8
sgot_buf lda $05EA,x
        sta game_over_char_buffer,x
        lda $D9EA,x
        sta game_over_color_buffer,x
        dex
        bpl sgot_buf
	
	
; // ── Buffer screen chars+colors (9 chars centered at col 10 on row 12) ────
; // "GAME OVER" is 9 chars. Screen row 12 base = $05E0.
; // For STARTUP playfield-centering we print at col 10, so address = $05EA.
	lda #<sgot_text_msg
	ldx #>sgot_text_msg
	sta Screen_p1
	stx Screen_p1+1
	lda #$a
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$c
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
        ldx #8
        lda #$0E
sgot_col sta $D9EA,x
        dex
        bpl sgot_col
	
	; Binary clause INTEGER: GREATEREQUAL
	lda score+1   ; compare high bytes
	cmp highScore+1 ;keep
	bcc ShowGameOverText_edblock8829
	bne ShowGameOverText_ctb8827
	lda score
	cmp highScore ;keep
	bcc ShowGameOverText_edblock8829
ShowGameOverText_ctb8827: ;Main true block ;keep 
	ldy score+1 ;keep
	lda score
	; Calling storevariable on generic assign expression
	sta highScore
	sty highScore+1
	lda #$1
	; Calling storevariable on generic assign expression
	sta highScoreDirty
ShowGameOverText_edblock8829
	rts
end_procedure_ShowGameOverText
	
; // ---------------------------------------------------------------------------
; // HideGameOverText
; //   Restores the buffered starfield characters and colors to remove "GAME OVER" text.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : HideGameOverText
	;    Procedure type : User-defined procedure
HideGameOverText
        ldx #8
hgot_lp lda game_over_char_buffer,x
	sta $05EA,x
        lda game_over_color_buffer,x
	sta $D9EA,x
        dex
        bpl hgot_lp
	
	rts
end_procedure_HideGameOverText
	
; // ---------------------------------------------------------------------------
; // Startup text helpers
; //   Draw/restore startup screen text while preserving starfield chars+colors.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateStartupLevelSelectDigit
	;    Procedure type : User-defined procedure
UpdateStartupLevelSelectDigit
	
; // Display level digit at column 20 of row 17 (between parentheses in "LEVEL SELECT ( )")
; // Row 17 starts at $06A8, text starts at column 6 ($06AE), digit position is +14 = $06BC
	; Poke
	; Optimization: shift is zero
	; 8 bit binop
	; Add/sub where right value is constant number
	lda current_level
	clc
	adc #$30
	 ; end add / sub var with constant
	sta $6bc
	; Poke
	; Optimization: shift is zero
	lda #$e
	sta $dabc
	rts
end_procedure_UpdateStartupLevelSelectDigit
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ShowStartupText
	;    Procedure type : User-defined procedure
ShowStartupText
	// Save art block (rows 1-9) at column 2 - all lines centered at same column
	// Row 1: col 2-26 (25 chars, max width line)
	ldx #24
r1_loop lda $042A,x
	sta startup_char_buffer+0,x
	lda $D82A,x
	sta startup_color_buffer+0,x
	dex
	bpl r1_loop
	
	// Row 2: col 2-26 (25 chars)
	ldx #24
r2_loop lda $0452,x
	sta startup_char_buffer+25,x
	lda $D852,x
	sta startup_color_buffer+25,x
	dex
	bpl r2_loop
	
	// Row 3: col 2-26 (25 chars)
	ldx #24
r3_loop lda $047A,x
	sta startup_char_buffer+50,x
	lda $D87A,x
	sta startup_color_buffer+50,x
	dex
	bpl r3_loop
	
	// Row 4: col 2-26 (25 chars)
	ldx #24
r4_loop lda $04A2,x
	sta startup_char_buffer+75,x
	lda $D8A2,x
	sta startup_color_buffer+75,x
	dex
	bpl r4_loop
	
	// Row 5: col 2-26 (25 chars)
	ldx #24
r5_loop lda $04CA,x
	sta startup_char_buffer+100,x
	lda $D8CA,x
	sta startup_color_buffer+100,x
	dex
	bpl r5_loop
	
	// Row 6: col 2-26 (25 chars)
	ldx #24
r6_loop lda $04F2,x
	sta startup_char_buffer+125,x
	lda $D8F2,x
	sta startup_color_buffer+125,x
	dex
	bpl r6_loop
	
	// Row 7: col 2-26 (25 chars)
	ldx #24
r7_loop lda $051A,x
	sta startup_char_buffer+150,x
	lda $D91A,x
	sta startup_color_buffer+150,x
	dex
	bpl r7_loop
	
	// Row 8: col 2-26 (25 chars)
	ldx #24
r8_loop lda $0542,x
	sta startup_char_buffer+175,x
	lda $D942,x
	sta startup_color_buffer+175,x
	dex
	bpl r8_loop
	
	// Row 9: col 2-26 (25 chars)
	ldx #24
r9_loop lda $056A,x
	sta startup_char_buffer+200,x
	lda $D96A,x
	sta startup_color_buffer+200,x
	dex
	bpl r9_loop
	
	// Save row 13 (startup_line2) - col 4-23 (20 chars)
	ldx #19
buf13_loop lda $060C,x
	sta startup_char_buffer+225,x
	lda $DA0C,x
	sta startup_color_buffer+225,x
	dex
	bpl buf13_loop
	
	// Save row 17 (startup_line3) - col 6-21 (16 chars)
	ldx #15
buf17_loop lda $06AE,x
	sta startup_char_buffer+245,x
	lda $DAAE,x
	sta startup_color_buffer+245,x
	dex
	bpl buf17_loop
	
	
; // Draw ASCII-art sparsely: write only non-space runs so starfield chars remain in gaps.
; // Row 1: "nnnnnnnn      nnnnnn"
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8836
	ldy #>ShowStartupText_stringassignstr8836
	sta Screen_p1
	sty Screen_p1+1
	lda #$2
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
	lda #<ShowStartupText_stringassignstr8838
	ldy #>ShowStartupText_stringassignstr8838
	sta Screen_p1
	sty Screen_p1+1
	lda #$10
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
	
; // Row 2: "nn          nnnnnnnnnn"
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8840
	ldy #>ShowStartupText_stringassignstr8840
	sta Screen_p1
	sty Screen_p1+1
	lda #$2
	; Calling storevariable on generic assign expression
	sta Screen_x
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8842
	ldy #>ShowStartupText_stringassignstr8842
	sta Screen_p1
	sty Screen_p1+1
	lda #$e
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$2
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	
; // Row 3: "           nnnnnnnnnnnn"
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8844
	ldy #>ShowStartupText_stringassignstr8844
	sta Screen_p1
	sty Screen_p1+1
	lda #$d
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
	
; // Row 4: "nnnnnnnn  nn nn nn nn nn"
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8846
	ldy #>ShowStartupText_stringassignstr8846
	sta Screen_p1
	sty Screen_p1+1
	lda #$2
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$4
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8848
	ldy #>ShowStartupText_stringassignstr8848
	sta Screen_p1
	sty Screen_p1+1
	lda #$c
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$4
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8850
	ldy #>ShowStartupText_stringassignstr8850
	sta Screen_p1
	sty Screen_p1+1
	lda #$f
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$4
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8852
	ldy #>ShowStartupText_stringassignstr8852
	sta Screen_p1
	sty Screen_p1+1
	lda #$12
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$4
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8854
	ldy #>ShowStartupText_stringassignstr8854
	sta Screen_p1
	sty Screen_p1+1
	lda #$15
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$4
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8856
	ldy #>ShowStartupText_stringassignstr8856
	sta Screen_p1
	sty Screen_p1+1
	lda #$18
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$4
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	
; // Row 5: "nn    nn nnnnnnnnnnnnnnnn"
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8858
	ldy #>ShowStartupText_stringassignstr8858
	sta Screen_p1
	sty Screen_p1+1
	lda #$2
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$5
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8860
	ldy #>ShowStartupText_stringassignstr8860
	sta Screen_p1
	sty Screen_p1+1
	lda #$8
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$5
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8862
	ldy #>ShowStartupText_stringassignstr8862
	sta Screen_p1
	sty Screen_p1+1
	lda #$b
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$5
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	
; // Row 6: "nnnnnnnn   nnn  nn  nnn"
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8864
	ldy #>ShowStartupText_stringassignstr8864
	sta Screen_p1
	sty Screen_p1+1
	lda #$2
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$6
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8866
	ldy #>ShowStartupText_stringassignstr8866
	sta Screen_p1
	sty Screen_p1+1
	lda #$d
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$6
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8868
	ldy #>ShowStartupText_stringassignstr8868
	sta Screen_p1
	sty Screen_p1+1
	lda #$12
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$6
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8870
	ldy #>ShowStartupText_stringassignstr8870
	sta Screen_p1
	sty Screen_p1+1
	lda #$16
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$6
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	
; // Row 7: "      nn    n        n"
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8872
	ldy #>ShowStartupText_stringassignstr8872
	sta Screen_p1
	sty Screen_p1+1
	lda #$8
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$7
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8874
	ldy #>ShowStartupText_stringassignstr8874
	sta Screen_p1
	sty Screen_p1+1
	lda #$e
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$7
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8876
	ldy #>ShowStartupText_stringassignstr8876
	sta Screen_p1
	sty Screen_p1+1
	lda #$17
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$7
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	
; // Row 8: "nn    nn"
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8878
	ldy #>ShowStartupText_stringassignstr8878
	sta Screen_p1
	sty Screen_p1+1
	lda #$2
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$8
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8880
	ldy #>ShowStartupText_stringassignstr8880
	sta Screen_p1
	sty Screen_p1+1
	lda #$8
	; Calling storevariable on generic assign expression
	sta Screen_x
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	
; // Row 9: "nnnnnnnn INVADERS MMXXVI"
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8882
	ldy #>ShowStartupText_stringassignstr8882
	sta Screen_p1
	sty Screen_p1+1
	lda #$2
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$9
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8884
	ldy #>ShowStartupText_stringassignstr8884
	sta Screen_p1
	sty Screen_p1+1
	lda #$b
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$9
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8886
	ldy #>ShowStartupText_stringassignstr8886
	sta Screen_p1
	sty Screen_p1+1
	lda #$14
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$9
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	
; // Startup helper lines, sparse segments (preserve starfield chars in spaces).
; // Row 13: "FIRE BUTTON TO START"
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8888
	ldy #>ShowStartupText_stringassignstr8888
	sta Screen_p1
	sty Screen_p1+1
	lda #$4
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
	lda #<ShowStartupText_stringassignstr8890
	ldy #>ShowStartupText_stringassignstr8890
	sta Screen_p1
	sty Screen_p1+1
	lda #$9
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
	lda #<ShowStartupText_stringassignstr8892
	ldy #>ShowStartupText_stringassignstr8892
	sta Screen_p1
	sty Screen_p1+1
	lda #$10
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
	lda #<ShowStartupText_stringassignstr8894
	ldy #>ShowStartupText_stringassignstr8894
	sta Screen_p1
	sty Screen_p1+1
	lda #$13
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
	
; // Row 17: "LEVEL SELECT ( )"
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8896
	ldy #>ShowStartupText_stringassignstr8896
	sta Screen_p1
	sty Screen_p1+1
	lda #$6
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$11
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8898
	ldy #>ShowStartupText_stringassignstr8898
	sta Screen_p1
	sty Screen_p1+1
	lda #$c
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$11
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8900
	ldy #>ShowStartupText_stringassignstr8900
	sta Screen_p1
	sty Screen_p1+1
	lda #$13
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$11
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	; Assigning a string : Screen_p1
	;has array index
	lda #<ShowStartupText_stringassignstr8902
	ldy #>ShowStartupText_stringassignstr8902
	sta Screen_p1
	sty Screen_p1+1
	lda #$15
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$11
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	// Row 1 segments
	ldx #7
	lda #$0E
	sta $D82A,x
	dex
	bpl *-6
	ldx #5
	lda #$0E
	sta $D838,x
	dex
	bpl *-6
	// Row 2 segments
	ldx #1
	lda #$0E
	sta $D852,x
	dex
	bpl *-6
	ldx #9
	lda #$0E
	sta $D85E,x
	dex
	bpl *-6
	// Row 3 segment
	ldx #11
	lda #$0E
	sta $D885,x
	dex
	bpl *-6
	// Row 4 segments
	ldx #7
	lda #$0E
	sta $D8A2,x
	dex
	bpl *-6
	ldx #1
	lda #$0E
	sta $D8AC,x
	dex
	bpl *-6
	ldx #1
	lda #$0E
	sta $D8AF,x
	dex
	bpl *-6
	ldx #1
	lda #$0E
	sta $D8B2,x
	dex
	bpl *-6
	ldx #1
	lda #$0E
	sta $D8B5,x
	dex
	bpl *-6
	ldx #1
	lda #$0E
	sta $D8B8,x
	dex
	bpl *-6
	// Row 5 segments
	ldx #1
	lda #$0E
	sta $D8CA,x
	dex
	bpl *-6
	ldx #1
	lda #$0E
	sta $D8D0,x
	dex
	bpl *-6
	ldx #15
	lda #$0E
	sta $D8D3,x
	dex
	bpl *-6
	// Row 6 segments
	ldx #7
	lda #$0E
	sta $D8F2,x
	dex
	bpl *-6
	ldx #2
	lda #$0E
	sta $D8FD,x
	dex
	bpl *-6
	ldx #1
	lda #$0E
	sta $D902,x
	dex
	bpl *-6
	ldx #2
	lda #$0E
	sta $D906,x
	dex
	bpl *-6
	// Row 7 segments
	ldx #1
	lda #$0E
	sta $D920,x
	dex
	bpl *-6
	lda #$0E
	sta $D926
	sta $D92F
	// Row 8 segments
	ldx #1
	lda #$0E
	sta $D942,x
	dex
	bpl *-6
	ldx #1
	lda #$0E
	sta $D948,x
	dex
	bpl *-6
	// Row 9 segments
	ldx #7
	lda #$0E
	sta $D96A,x
	dex
	bpl *-6
	ldx #7
	lda #$0E
	sta $D973,x
	dex
	bpl *-6
	ldx #5
	lda #$0E
	sta $D97C,x
	dex
	bpl *-6
	// Row 13: FIRE BUTTON TO START (sparse)
	ldx #3
	lda #$0E
	sta $DA0C,x
	dex
	bpl *-6
	ldx #5
	lda #$0E
	sta $DA11,x
	dex
	bpl *-6
	ldx #1
	lda #$0E
	sta $DA18,x
	dex
	bpl *-6
	ldx #4
	lda #$0E
	sta $DA1B,x
	dex
	bpl *-6
	
	// Row 17: LEVEL SELECT ( ) (sparse)
	ldx #4
	lda #$0E
	sta $DAAE,x
	dex
	bpl *-6
	ldx #5
	lda #$0E
	sta $DAB4,x
	dex
	bpl *-6
	lda #$0E
	sta $DABB
	sta $DABC
	sta $DABD
	
	
; // Set colors for all startup segments (ASCII art + helper lines), light_blue.
	jsr UpdateStartupLevelSelectDigit
	rts
end_procedure_ShowStartupText
	; NodeProcedureDecl -1
	; ***********  Defining procedure : HideStartupText
	;    Procedure type : User-defined procedure
HideStartupText
	// Restore art block (rows 1-9) at column 2
	ldx #24
hst_r1 lda startup_char_buffer+0,x
	sta $042A,x
	lda startup_color_buffer+0,x
	sta $D82A,x
	dex
	bpl hst_r1
	
	ldx #24
hst_r2 lda startup_char_buffer+25,x
	sta $0452,x
	lda startup_color_buffer+25,x
	sta $D852,x
	dex
	bpl hst_r2
	
	ldx #24
hst_r3 lda startup_char_buffer+50,x
	sta $047A,x
	lda startup_color_buffer+50,x
	sta $D87A,x
	dex
	bpl hst_r3
	
	ldx #24
hst_r4 lda startup_char_buffer+75,x
	sta $04A2,x
	lda startup_color_buffer+75,x
	sta $D8A2,x
	dex
	bpl hst_r4
	
	ldx #24
hst_r5 lda startup_char_buffer+100,x
	sta $04CA,x
	lda startup_color_buffer+100,x
	sta $D8CA,x
	dex
	bpl hst_r5
	
	ldx #24
hst_r6 lda startup_char_buffer+125,x
	sta $04F2,x
	lda startup_color_buffer+125,x
	sta $D8F2,x
	dex
	bpl hst_r6
	
	ldx #24
hst_r7 lda startup_char_buffer+150,x
	sta $051A,x
	lda startup_color_buffer+150,x
	sta $D91A,x
	dex
	bpl hst_r7
	
	ldx #24
hst_r8 lda startup_char_buffer+175,x
	sta $0542,x
	lda startup_color_buffer+175,x
	sta $D942,x
	dex
	bpl hst_r8
	
	ldx #24
hst_r9 lda startup_char_buffer+200,x
	sta $056A,x
	lda startup_color_buffer+200,x
	sta $D96A,x
	dex
	bpl hst_r9
	
	// Restore row 13 (startup_line2)
	ldx #19
hst_r13 lda startup_char_buffer+225,x
	sta $060C,x
	lda startup_color_buffer+225,x
	sta $DA0C,x
	dex
	bpl hst_r13
	
	// Restore row 17 (startup_line3)
	ldx #15
hst_r17 lda startup_char_buffer+245,x
	sta $06AE,x
	lda startup_color_buffer+245,x
	sta $DAAE,x
	dex
	bpl hst_r17
	
	rts
end_procedure_HideStartupText
	
; // ---------------------------------------------------------------------------
; // ResetGameState
; //   Initializes/resets all game state variables to a clean state.
; //   Called at both initial startup and when restarting after game over.
; //   Encapsulates all the state setup so changes are made in one place.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ResetGameState
	;    Procedure type : User-defined procedure
ResetGameState
	
; // Reset score
	ldy #0   ; Force integer assignment, set y = 0 for values lower than 255
	lda #$0
	; Calling storevariable on generic assign expression
	sta score
	sty score+1
	lda #$1
	; Calling storevariable on generic assign expression
	sta score_dirty
	
; // Reset level progression
	lda #$0
	; Calling storevariable on generic assign expression
	sta current_level
	; Calling storevariable on generic assign expression
	sta total_level_counter
	lda #$1
	; Calling storevariable on generic assign expression
	sta startup_mode
	
; // Reset player state
	lda #$4
	; Calling storevariable on generic assign expression
	sta remaining_ships
	lda #$0
	; Calling storevariable on generic assign expression
	sta lifeLostDirty
	; Calling storevariable on generic assign expression
	sta player_respawn_state
	; Calling storevariable on generic assign expression
	sta player_respawn_counter
	; Calling storevariable on generic assign expression
	sta player_explosion_anim_index
	; Calling storevariable on generic assign expression
	sta player_explosion_flash_counter
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	lda #$27
	; Calling storevariable on generic assign expression
	sta player_sprite_x
	lda #$e2
	; Calling storevariable on generic assign expression
	sta player_sprite_y
	
; // Reset enemy formation state
	lda #$0
	; Calling storevariable on generic assign expression
	sta numberOfEnemies
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemy_direction
	lda #$47
	; Calling storevariable on generic assign expression
	sta enemyMoveCounter
	lda #$32
	; Calling storevariable on generic assign expression
	sta current_speed_delay
	lda #$0
	; Calling storevariable on generic assign expression
	sta pending_edge_rescan
	; Calling storevariable on generic assign expression
	sta enemy_march_tick
	; Calling storevariable on generic assign expression
	sta monster_animation_frame
	
; // Reset UFO state
	; Calling storevariable on generic assign expression
	sta ufo_active
	; Integer constant assigning
	; Load16bitvariable : #$600
	ldy #$06
	lda #$00
	; Calling storevariable on generic assign expression
	sta ufo_spawn_timer
	sty ufo_spawn_timer+1
	
; // Reset intermission flags
	lda #$0
	; Calling storevariable on generic assign expression
	sta get_ready_mode
	; Calling storevariable on generic assign expression
	sta get_ready_prev_fire
	; Calling storevariable on generic assign expression
	sta game_over_mode
	; Calling storevariable on generic assign expression
	sta game_over_prev_fire
	; Calling storevariable on generic assign expression
	sta level_advance_pending
	; Calling storevariable on generic assign expression
	sta level_advance_ready
	lda #$1
	; Calling storevariable on generic assign expression
	sta startup_prev_inputs
	
; // Mark fire as already processed to prevent immediate re-trigger
; // Clear sprite_bitmask first, then enable all sprites for gameplay
; // This ensures consistent state regardless of previous sprite_bitmask valuesprite_bitmask := 0;
; //	togglebit(sprite_bitmask, useSprite, 1);
; //	togglebit(sprite_bitmask, monsterSprite1, 1);
; //	togglebit(sprite_bitmask, monsterSprite2, 1);
; //	togglebit(sprite_bitmask, monsterSprite3, 1);
; //	togglebit(sprite_bitmask, monsterSprite4, 1);
; //	togglebit(sprite_bitmask, ES_SHOT_SPRITE1, 1);
; //	togglebit(sprite_bitmask, ES_SHOT_SPRITE2, 1);
; //	togglebit(sprite_bitmask, ES_SHOT_SPRITE3, 1);
	; Calling storevariable on generic assign expression
	sta lifeLostDirty
	; Calling storevariable on generic assign expression
	sta startUpDirty
	rts
end_procedure_ResetGameState
	
; // ---------------------------------------------------------------------------
; // LevelStart
; //   Called from IntermissionChain when the player presses fire.
; //   HideGetReadyText nested inside — sole caller.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : LevelStart
	;    Procedure type : User-defined procedure
LevelStart
	jsr HideGetReadyText
	jsr UpdateShieldDisplayForCurrentLevel
	
; // Reset player position to far left
	lda #$27
	; Calling storevariable on generic assign expression
	sta player_sprite_x
	
; //	 Re-enable all sprites for gameplay
; //	togglebit(sprite_bitmask, useSprite, 1);
; //	togglebit(sprite_bitmask, monsterSprite1, 1);
; //	togglebit(sprite_bitmask, monsterSprite2, 1);
; //	togglebit(sprite_bitmask, monsterSprite3, 1);
; //	togglebit(sprite_bitmask, monsterSprite4, 1);
; //	togglebit(sprite_bitmask, ES_SHOT_SPRITE1, 1);
; //	togglebit(sprite_bitmask, ES_SHOT_SPRITE2, 1);
; //	togglebit(sprite_bitmask, ES_SHOT_SPRITE3, 1);
; // Exit intermission mode — IntermissionChain will see this and switch to the game chain
	lda #$0
	; Calling storevariable on generic assign expression
	sta get_ready_mode
	
; // Reset fire button debounce to prevent immediate fire if button is still held
	lda #$1
	; Calling storevariable on generic assign expression
	sta previous_fire_state
	
; // Re-enable all sprites for gameplay
	; Toggle bit with constant
	lda $d015
	ora #%1
	sta $d015
	ldx #$0 ; optimized, look out for bugs
	lda #1
LevelStart_shiftbit8906
	cpx #0
	beq LevelStart_shiftbitdone8907
	asl
	dex
	jmp LevelStart_shiftbit8906
LevelStart_shiftbitdone8907
LevelStart_bitmask_var8908 = $54
	sta LevelStart_bitmask_var8908
	lda $d015
	ora LevelStart_bitmask_var8908
	sta $d015
	; Toggle bit with constant
	ora #%10
	sta $d015
	ldx #$1 ; optimized, look out for bugs
	lda #1
LevelStart_shiftbit8909
	cpx #0
	beq LevelStart_shiftbitdone8910
	asl
	dex
	jmp LevelStart_shiftbit8909
LevelStart_shiftbitdone8910
LevelStart_bitmask_var8911 = $54
	sta LevelStart_bitmask_var8911
	lda $d015
	ora LevelStart_bitmask_var8911
	sta $d015
	; Toggle bit with constant
	ora #%100
	sta $d015
	ldx #$2 ; optimized, look out for bugs
	lda #1
LevelStart_shiftbit8912
	cpx #0
	beq LevelStart_shiftbitdone8913
	asl
	dex
	jmp LevelStart_shiftbit8912
LevelStart_shiftbitdone8913
LevelStart_bitmask_var8914 = $54
	sta LevelStart_bitmask_var8914
	lda $d015
	ora LevelStart_bitmask_var8914
	sta $d015
	; Toggle bit with constant
	ora #%1000
	sta $d015
	ldx #$3 ; optimized, look out for bugs
	lda #1
LevelStart_shiftbit8915
	cpx #0
	beq LevelStart_shiftbitdone8916
	asl
	dex
	jmp LevelStart_shiftbit8915
LevelStart_shiftbitdone8916
LevelStart_bitmask_var8917 = $54
	sta LevelStart_bitmask_var8917
	lda $d015
	ora LevelStart_bitmask_var8917
	sta $d015
	; Toggle bit with constant
	ora #%10000
	sta $d015
	ldx #$4 ; optimized, look out for bugs
	lda #1
LevelStart_shiftbit8918
	cpx #0
	beq LevelStart_shiftbitdone8919
	asl
	dex
	jmp LevelStart_shiftbit8918
LevelStart_shiftbitdone8919
LevelStart_bitmask_var8920 = $54
	sta LevelStart_bitmask_var8920
	lda $d015
	ora LevelStart_bitmask_var8920
	sta $d015
	; Toggle bit with constant
	ora #%1000000
	sta $d015
	ldx #$6 ; optimized, look out for bugs
	lda #1
LevelStart_shiftbit8921
	cpx #0
	beq LevelStart_shiftbitdone8922
	asl
	dex
	jmp LevelStart_shiftbit8921
LevelStart_shiftbitdone8922
LevelStart_bitmask_var8923 = $54
	sta LevelStart_bitmask_var8923
	lda $d015
	ora LevelStart_bitmask_var8923
	sta $d015
	; Toggle bit with constant
	ora #%100000
	sta $d015
	ldx #$5 ; optimized, look out for bugs
	lda #1
LevelStart_shiftbit8924
	cpx #0
	beq LevelStart_shiftbitdone8925
	asl
	dex
	jmp LevelStart_shiftbit8924
LevelStart_shiftbitdone8925
LevelStart_bitmask_var8926 = $54
	sta LevelStart_bitmask_var8926
	lda $d015
	ora LevelStart_bitmask_var8926
	sta $d015
	; Toggle bit with constant
	ora #%10000000
	sta $d015
	ldx #$7 ; optimized, look out for bugs
	lda #1
LevelStart_shiftbit8927
	cpx #0
	beq LevelStart_shiftbitdone8928
	asl
	dex
	jmp LevelStart_shiftbit8927
LevelStart_shiftbitdone8928
LevelStart_bitmask_var8929 = $54
	sta LevelStart_bitmask_var8929
	lda $d015
	ora LevelStart_bitmask_var8929
	sta $d015
	rts
end_procedure_LevelStart
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ClearMonster
	;    Procedure type : User-defined procedure
sprite_data_ptr	= $22
frame1_sprite_index	dc.b	0
frame2_sprite_index	dc.b	0
sprite_offset_start	dc.b	0
enemy_horizontal_offset	dc.b	0
enemy_vertical_offset	dc.b	0
sprite_base_address	dc.w	0
enemy_mask	dc.b	0
was_alive	dc.b	0
cm_row	dc.b	0
cm_base	dc.b	0
cm_any	dc.b	0
blockIndex	dc.b	0
enemyIndex	dc.b	0
ClearMonster_block8930
ClearMonster
	
; // row index (0-2) of the cleared block
; // first block index of that row (row << 2)
; // OR of all 4 block_enemies bytes in the row
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
	beq ClearMonster_eblock8933
ClearMonster_ctb8932: ;Main true block ;keep 
	
; // Divide by 2 to get column
; // Calculate vertical offset
; // Even indices (0,2,4): top row at offset 0
; // Odd indices (1,3,5): bottom row at offset 13 rows
; // 13 rows * 3 bytes = 39
	lda #$27
	; Calling storevariable on generic assign expression
	sta enemy_vertical_offset
	jmp ClearMonster_edblock8934
ClearMonster_eblock8933
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_vertical_offset
ClearMonster_edblock8934
	
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
ClearMonster_tempVarShift_var8939 = $54
	sta ClearMonster_tempVarShift_var8939
	sty ClearMonster_tempVarShift_var8939+1
	; COUNT : 6
		asl ClearMonster_tempVarShift_var8939+0 ;keep
	rol ClearMonster_tempVarShift_var8939+1 ;keep

		asl ClearMonster_tempVarShift_var8939+0 ;keep
	rol ClearMonster_tempVarShift_var8939+1 ;keep

		asl ClearMonster_tempVarShift_var8939+0 ;keep
	rol ClearMonster_tempVarShift_var8939+1 ;keep

		asl ClearMonster_tempVarShift_var8939+0 ;keep
	rol ClearMonster_tempVarShift_var8939+1 ;keep

		asl ClearMonster_tempVarShift_var8939+0 ;keep
	rol ClearMonster_tempVarShift_var8939+1 ;keep

		asl ClearMonster_tempVarShift_var8939+0 ;keep
	rol ClearMonster_tempVarShift_var8939+1 ;keep

	lda ClearMonster_tempVarShift_var8939
	ldy ClearMonster_tempVarShift_var8939+1
	; Calling storevariable on generic assign expression
	sta sprite_base_address
	sty sprite_base_address+1
	
; // * 64
	; Generic 16 bit op
	ldy #0
	ldx #0 ; Fake 24 bit
	lda sprite_offset_start
ClearMonster_rightvarInteger_var8942 = $54
	sta ClearMonster_rightvarInteger_var8942
	sty ClearMonster_rightvarInteger_var8942+1
	; Generic 16 bit op
	ldy sprite_base_address+1 ;keep
	lda sprite_base_address
ClearMonster_rightvarInteger_var8945 = $56
	sta ClearMonster_rightvarInteger_var8945
	sty ClearMonster_rightvarInteger_var8945+1
	; Integer constant assigning
	; Load16bitvariable : #$2000
	ldy #$20
	lda #$00
	; Low bit binop:
	clc
	adc ClearMonster_rightvarInteger_var8945
ClearMonster_wordAdd8943
	sta ClearMonster_rightvarInteger_var8945
	; High-bit binop
	tya
	adc ClearMonster_rightvarInteger_var8945+1
	tay
	lda ClearMonster_rightvarInteger_var8945
	; Low bit binop:
	clc
	adc ClearMonster_rightvarInteger_var8942
ClearMonster_wordAdd8940
	sta ClearMonster_rightvarInteger_var8942
	; High-bit binop
	tya
	adc ClearMonster_rightvarInteger_var8942+1
	tay
	lda ClearMonster_rightvarInteger_var8942
	sta sprite_data_ptr
	sty sprite_data_ptr+1
        lda #0
        ldy #0
        sta (sprite_data_ptr),y
        ldy #3
        sta (sprite_data_ptr),y
        ldy #6
        sta (sprite_data_ptr),y
        ldy #9
        sta (sprite_data_ptr),y
        ldy #12
        sta (sprite_data_ptr),y
        ldy #15
        sta (sprite_data_ptr),y
        ldy #18
        sta (sprite_data_ptr),y
        ldy #21
        sta (sprite_data_ptr),y
	
	
; // Y-indexed zero stores — no pointer advances needed.
; // Clear second animation frame — sprite index is frame1+1, address is frame2_sprite_index*64
	ldy #0 ; Fake 16 bit
	lda frame2_sprite_index
	; Calling storevariable on generic assign expression
	; Casting from byte to integer
	sta sprite_base_address
	sty sprite_base_address+1
	ldy sprite_base_address+1 ;keep
ClearMonster_tempVarShift_var8946 = $54
	sta ClearMonster_tempVarShift_var8946
	sty ClearMonster_tempVarShift_var8946+1
	; COUNT : 6
		asl ClearMonster_tempVarShift_var8946+0 ;keep
	rol ClearMonster_tempVarShift_var8946+1 ;keep

		asl ClearMonster_tempVarShift_var8946+0 ;keep
	rol ClearMonster_tempVarShift_var8946+1 ;keep

		asl ClearMonster_tempVarShift_var8946+0 ;keep
	rol ClearMonster_tempVarShift_var8946+1 ;keep

		asl ClearMonster_tempVarShift_var8946+0 ;keep
	rol ClearMonster_tempVarShift_var8946+1 ;keep

		asl ClearMonster_tempVarShift_var8946+0 ;keep
	rol ClearMonster_tempVarShift_var8946+1 ;keep

		asl ClearMonster_tempVarShift_var8946+0 ;keep
	rol ClearMonster_tempVarShift_var8946+1 ;keep

	lda ClearMonster_tempVarShift_var8946
	ldy ClearMonster_tempVarShift_var8946+1
	; Calling storevariable on generic assign expression
	sta sprite_base_address
	sty sprite_base_address+1
	
; // * 64
	; Generic 16 bit op
	ldy #0
	ldx #0 ; Fake 24 bit
	lda sprite_offset_start
ClearMonster_rightvarInteger_var8949 = $54
	sta ClearMonster_rightvarInteger_var8949
	sty ClearMonster_rightvarInteger_var8949+1
	; Generic 16 bit op
	ldy sprite_base_address+1 ;keep
	lda sprite_base_address
ClearMonster_rightvarInteger_var8952 = $56
	sta ClearMonster_rightvarInteger_var8952
	sty ClearMonster_rightvarInteger_var8952+1
	; Integer constant assigning
	; Load16bitvariable : #$2000
	ldy #$20
	lda #$00
	; Low bit binop:
	clc
	adc ClearMonster_rightvarInteger_var8952
ClearMonster_wordAdd8950
	sta ClearMonster_rightvarInteger_var8952
	; High-bit binop
	tya
	adc ClearMonster_rightvarInteger_var8952+1
	tay
	lda ClearMonster_rightvarInteger_var8952
	; Low bit binop:
	clc
	adc ClearMonster_rightvarInteger_var8949
ClearMonster_wordAdd8947
	sta ClearMonster_rightvarInteger_var8949
	; High-bit binop
	tya
	adc ClearMonster_rightvarInteger_var8949+1
	tay
	lda ClearMonster_rightvarInteger_var8949
	sta sprite_data_ptr
	sty sprite_data_ptr+1
        lda #0
        ldy #0
        sta (sprite_data_ptr),y
        ldy #3
        sta (sprite_data_ptr),y
        ldy #6
        sta (sprite_data_ptr),y
        ldy #9
        sta (sprite_data_ptr),y
        ldy #12
        sta (sprite_data_ptr),y
        ldy #15
        sta (sprite_data_ptr),y
        ldy #18
        sta (sprite_data_ptr),y
        ldy #21
        sta (sprite_data_ptr),y
	
	
; // Speed up as enemies decrease
; // Update block_enemies bitmask for this enemy and increment cleared count
	ldx enemyIndex ; optimized, look out for bugs
	lda #$1
	cpx #0
	beq ClearMonster_lblShiftDone8954
ClearMonster_lblShift8953
	asl
	dex
	cpx #0
	bne ClearMonster_lblShift8953
ClearMonster_lblShiftDone8954
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
	beq ClearMonster_ctb8955
	lda #$01
	jmp ClearMonster_cfb8956
ClearMonster_ctb8955: ;Main true block ;keep 
	lda #$00
ClearMonster_cfb8956
	; Calling storevariable on generic assign expression
	sta was_alive
	; Binary clause Simplified: NOTEQUALS
	clc
	; cmp #$00 ignored
	beq ClearMonster_localfailed9155
	jmp ClearMonster_ctb8958
ClearMonster_localfailed9155
	jmp ClearMonster_edblock8960
ClearMonster_ctb8958: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub right value is variable/expression
	; 8 bit binop
	; Add/sub where right value is constant number
	lda enemy_mask
	eor #$ff
	 ; end add / sub var with constant
ClearMonster_rightvarAddSub_var9157 = $54
	sta ClearMonster_rightvarAddSub_var9157
	; Load Byte array
	; CAST type NADA
	ldx blockIndex
	lda block_enemies,x 
	and ClearMonster_rightvarAddSub_var9157
	; Calling storevariable on generic assign expression
	sta block_enemies,x
	; Binary clause Simplified: LESS
	lda numberOfEnemies
	; Compare with pure num / var optimization
	cmp #$47;keep
	bcs ClearMonster_edblock9161
ClearMonster_ctb9159: ;Main true block ;keep 
	; Test Inc dec D
	inc numberOfEnemies
ClearMonster_edblock9161
	
; // Defer edge-cache refresh to the next UpdateTick so the scan loops
; // don't land on the same frame as the sprite clear.
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_edge_rescan
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	ldx blockIndex
	lda block_enemies,x 
	; cmp #$00 ignored
	bne ClearMonster_edblock9167
ClearMonster_ctb9165: ;Main true block ;keep 
	
; // Update row-present cache when this block just became empty.
	lda blockIndex
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta cm_row
	asl
	asl
	; Calling storevariable on generic assign expression
	sta cm_base
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx cm_base
	lda block_enemies,x 
	; Calling storevariable on generic assign expression
	sta cm_any
	; Test Inc dec D
	inc cm_base
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx cm_base
	ora block_enemies,x 
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta cm_any
	; Test Inc dec D
	inc cm_base
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx cm_base
	ora block_enemies,x 
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta cm_any
	; Test Inc dec D
	inc cm_base
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx cm_base
	ora block_enemies,x 
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta cm_any
	; Binary clause Simplified: EQUALS
	clc
	; cmp #$00 ignored
	bne ClearMonster_edblock9263
ClearMonster_ctb9261: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	ldx cm_row ; optimized, look out for bugs
	sta row_has_monsters,x
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda row_has_monsters +$0 ; array with const index optimization 
	; cmp #$00 ignored
	bne ClearMonster_edblock9311
ClearMonster_ctb9309: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda row_has_monsters +$1 ; array with const index optimization 
	; cmp #$00 ignored
	bne ClearMonster_edblock9335
ClearMonster_ctb9333: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda row_has_monsters +$2 ; array with const index optimization 
	; cmp #$00 ignored
	bne ClearMonster_edblock9347
ClearMonster_ctb9345: ;Main true block ;keep 
	
; // If all three rows just cleared, advance to next level.
	lda #$1
	; Calling storevariable on generic assign expression
	sta flagGotoNextLevel
ClearMonster_edblock9347
ClearMonster_edblock9335
ClearMonster_edblock9311
ClearMonster_edblock9263
ClearMonster_edblock9167
ClearMonster_edblock8960
	rts
end_procedure_ClearMonster
	
; // ---------------------------------------------------------------------------
; // PreclearLeftmostAndBottomEnemies
; //   Calls ClearMonster for each of the 17 pre-removed enemies.  ClearMonster
; //   zeroes the sprite pixel data in both animation frames, clears the
; //   block_enemies bit, increments numberOfEnemies, and sets
; //   pending_edge_rescan — all handled correctly by its normal path.
; //   No block ever becomes fully empty here (each retains ≥2 enemies), so
; //   the LevelAdvance() branch inside ClearMonster never fires.
; //
; //   Enemies removed (reduces effective count from 72 to 55):
; //     Block  0: enemies 0,1
; //     Block  4: enemies 0,1
; //     Block  8: enemies 0,1,3,5
; //     Blocks 9,10,11: enemies 1,3,5
; //
; //   ClearMonster uses sprite_data_ptr at ZP $22 (verify after each recompile).
; //   Safe to call with IRQs enabled as long as SID player does not use ZP $22.
; // ---------------------------------------------------------------------------
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
	
; // ---------------------------------------------------------------------------
; // DisplayScore
; //   Refreshes the score display only when score_dirty = 1 (i.e. score just
; //   changed).  Cost when unchanged: 1 branch = ~4 cycles.  Cost on a kill
; //   frame: moveto + PrintDecimal, which is fine since kills are infrequent.
; //   Position: row 3, col 35 — 5-char field at the far right of the screen.
; // ---------------------------------------------------------------------------Procedure DisplayScore();
; //var
; //	ds_score_snapshot : integer;
; // 	ds_should_draw    : byte;
; //Begin
; //	ds_should_draw := 0;
; //	PreventIRQ();
; //	if score_dirty <> 0 then
; //	begin
; //		ds_score_snapshot := score;
; //		score_dirty := 0;
; //		ds_should_draw := 1;
; //	end;
; //	EnableIRQ();
; //
; //	if ds_should_draw <> 0 then
; //	begin
; //		moveto(33, 3, hi(screen_char_loc));
; //		PrintDecimal(ds_score_snapshot, 5);
; //	end;
; //end;
; //
; //if (score_dirty = 1) then
	; NodeProcedureDecl -1
	; ***********  Defining procedure : DisplayScore
	;    Procedure type : User-defined procedure
ds_val	dc.w	0
ds_div	dc.b	0
DisplayScore_block9351
DisplayScore
	; Binary clause Simplified: EQUALS
	lda score_dirty
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne DisplayScore_localfailed9397
	jmp DisplayScore_ctb9353
DisplayScore_localfailed9397
	jmp DisplayScore_edblock9355
DisplayScore_ctb9353: ;Main true block ;keep 
	ldy score+1 ;keep
	lda score
	; Calling storevariable on generic assign expression
	sta ds_val
	sty ds_val+1
	
; // Ten-thousands place
	lda #$0
	; Calling storevariable on generic assign expression
	sta ds_div
DisplayScore_while9399
DisplayScore_loopstart9403
	; Binary clause INTEGER: GREATEREQUAL
	lda ds_val+1   ; compare high bytes
	cmp #$27 ;keep
	bcc DisplayScore_edblock9402
	bne DisplayScore_ctb9400
	lda ds_val
	cmp #$10 ;keep
	bcc DisplayScore_edblock9402
DisplayScore_ctb9400: ;Main true block ;keep 
	lda ds_val
	sec
	sbc #$10
	sta ds_val+0
	lda ds_val+1
	sbc #$27
	sta ds_val+1
	; Test Inc dec D
	inc ds_div
	jmp DisplayScore_while9399
DisplayScore_edblock9402
DisplayScore_loopend9404
			lda ds_div
			ora #$30
			sta $058A
		
	
; // Thousands place
	lda #$0
	; Calling storevariable on generic assign expression
	sta ds_div
DisplayScore_while9409
DisplayScore_loopstart9413
	; Binary clause INTEGER: GREATEREQUAL
	lda ds_val+1   ; compare high bytes
	cmp #$03 ;keep
	bcc DisplayScore_edblock9412
	bne DisplayScore_ctb9410
	lda ds_val
	cmp #$e8 ;keep
	bcc DisplayScore_edblock9412
DisplayScore_ctb9410: ;Main true block ;keep 
	lda ds_val
	sec
	sbc #$e8
	sta ds_val+0
	lda ds_val+1
	sbc #$03
	sta ds_val+1
	; Test Inc dec D
	inc ds_div
	jmp DisplayScore_while9409
DisplayScore_edblock9412
DisplayScore_loopend9414
			lda ds_div
			ora #$30
			sta $058B
		
	
; // Hundreds place
	lda #$0
	; Calling storevariable on generic assign expression
	sta ds_div
DisplayScore_while9419
DisplayScore_loopstart9423
	; Binary clause INTEGER: GREATEREQUAL
	lda ds_val+1   ; compare high bytes
	cmp #$00 ;keep
	bcc DisplayScore_edblock9422
	bne DisplayScore_ctb9420
	lda ds_val
	cmp #$64 ;keep
	bcc DisplayScore_edblock9422
DisplayScore_ctb9420: ;Main true block ;keep 
	lda ds_val
	sec
	sbc #$64
	sta ds_val+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcs DisplayScore_WordAdd9428
	dec ds_val+1
DisplayScore_WordAdd9428
	; Test Inc dec D
	inc ds_div
	jmp DisplayScore_while9419
DisplayScore_edblock9422
DisplayScore_loopend9424
			lda ds_div
			ora #$30
			sta $058C
		
	
; // Tens place
	lda #$0
	; Calling storevariable on generic assign expression
	sta ds_div
DisplayScore_while9429
DisplayScore_loopstart9433
	; Binary clause INTEGER: GREATEREQUAL
	lda ds_val+1   ; compare high bytes
	cmp #$00 ;keep
	bcc DisplayScore_edblock9432
	bne DisplayScore_ctb9430
	lda ds_val
	cmp #$0a ;keep
	bcc DisplayScore_edblock9432
DisplayScore_ctb9430: ;Main true block ;keep 
	lda ds_val
	sec
	sbc #$0a
	sta ds_val+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcs DisplayScore_WordAdd9438
	dec ds_val+1
DisplayScore_WordAdd9438
	; Test Inc dec D
	inc ds_div
	jmp DisplayScore_while9429
DisplayScore_edblock9432
DisplayScore_loopend9434
			lda ds_div
			ora #$30
			sta $058D
		
			lda ds_val
			ora #$30
			sta $058E
		
	
; // Ones place (remainder)
	lda #$0
	; Calling storevariable on generic assign expression
	sta score_dirty
DisplayScore_edblock9355
	rts
end_procedure_DisplayScore
	; NodeProcedureDecl -1
	; ***********  Defining procedure : DisplayLevel
	;    Procedure type : User-defined procedure
DisplayLevel
	; Binary clause Simplified: NOTEQUALS
	clc
	lda level_dirty
	; cmp #$00 ignored
	beq DisplayLevel_edblock9443
DisplayLevel_ctb9441: ;Main true block ;keep 
	; MoveTo optimization
	lda #$a5
	sta screenmemory
	lda #>$400
	clc
	adc #$02
	sta screenmemory+1
	ldy #0
	lda total_level_counter
	sta ipd_div_lo
	sty ipd_div_hi
	ldy #$1 ; optimized, look out for bugs
DisplayLevel_printdecimal9447
	jsr init_printdecimal_div10 
	ora #$30
	sta (screenmemory),y
	dey
	bpl DisplayLevel_printdecimal9447
	lda #$0
	; Calling storevariable on generic assign expression
	sta level_dirty
DisplayLevel_edblock9443
	rts
end_procedure_DisplayLevel
	; NodeProcedureDecl -1
	; ***********  Defining procedure : DisplayLives
	;    Procedure type : User-defined procedure
DisplayLives
	; Binary clause Simplified: EQUALS
	lda lifeLostDirty
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne DisplayLives_edblock9452
DisplayLives_ctb9450: ;Main true block ;keep 
	
; // Display remaining_ships as a single character at row 23, col 29
	; MoveTo optimization
	lda #$be
	sta screenmemory
	lda #>$400
	clc
	adc #$03
	sta screenmemory+1
	ldy #0
	lda remaining_ships
	sta ipd_div_lo
	sty ipd_div_hi
	ldy #$0 ; optimized, look out for bugs
DisplayLives_printdecimal9456
	jsr init_printdecimal_div10 
	ora #$30
	sta (screenmemory),y
	dey
	bpl DisplayLives_printdecimal9456
	lda #$0
	; Calling storevariable on generic assign expression
	sta lifeLostDirty
DisplayLives_edblock9452
	rts
end_procedure_DisplayLives
	; NodeProcedureDecl -1
	; ***********  Defining procedure : DisplayHighScore
	;    Procedure type : User-defined procedure
DisplayHighScore
	; Binary clause Simplified: EQUALS
	lda highScoreDirty
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne DisplayHighScore_edblock9461
DisplayHighScore_ctb9459: ;Main true block ;keep 
	; MoveTo optimization
	lda #$72
	sta screenmemory
	lda #>$400
	clc
	adc #$00
	sta screenmemory+1
	ldy highScore+1 ;keep
	lda highScore
	sta ipd_div_lo
	sty ipd_div_hi
	ldy #$4 ; optimized, look out for bugs
DisplayHighScore_printdecimal9465
	jsr init_printdecimal_div10 
	ora #$30
	sta (screenmemory),y
	dey
	bpl DisplayHighScore_printdecimal9465
	lda #$0
	; Calling storevariable on generic assign expression
	sta highScoreDirty
DisplayHighScore_edblock9461
	rts
end_procedure_DisplayHighScore
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ReadyMonsters
	;    Procedure type : User-defined procedure
ReadyMonsters
        ldx #63
rm_b0f1 lda $2600,x
        sta $2680,x
        dex
        bpl rm_b0f1
        ldx #63
rm_b0f2 lda $2640,x
        sta $26C0,x
        dex
        bpl rm_b0f2
        ldx #63
rm_b1f1 lda $2600,x
        sta $2700,x
        dex
        bpl rm_b1f1
        ldx #63
rm_b1f2 lda $2640,x
        sta $2740,x
        dex
        bpl rm_b1f2
        ldx #63
rm_b2f1 lda $2600,x
        sta $2780,x
        dex
        bpl rm_b2f1
        ldx #63
rm_b2f2 lda $2640,x
        sta $27C0,x
        dex
        bpl rm_b2f2
        ldx #63
rm_b3f1 lda $2600,x
        sta $2800,x
        dex
        bpl rm_b3f1
        ldx #63
rm_b3f2 lda $2640,x
        sta $2840,x
        dex
        bpl rm_b3f2
        ldx #63
rm_b4f1 lda $2600,x
        sta $2880,x
        dex
        bpl rm_b4f1
        ldx #63
rm_b4f2 lda $2640,x
        sta $28C0,x
        dex
        bpl rm_b4f2
        ldx #63
rm_b5f1 lda $2600,x
        sta $2900,x
        dex
        bpl rm_b5f1
        ldx #63
rm_b5f2 lda $2640,x
        sta $2940,x
        dex
        bpl rm_b5f2
        ldx #63
rm_b6f1 lda $2600,x
        sta $2980,x
        dex
        bpl rm_b6f1
        ldx #63
rm_b6f2 lda $2640,x
        sta $29C0,x
        dex
        bpl rm_b6f2
        ldx #63
rm_b7f1 lda $2600,x
        sta $2A00,x
        dex
        bpl rm_b7f1
        ldx #63
rm_b7f2 lda $2640,x
        sta $2A40,x
        dex
        bpl rm_b7f2
        ldx #63
rm_b8f1 lda $2600,x
        sta $2A80,x
        dex
        bpl rm_b8f1
        ldx #63
rm_b8f2 lda $2640,x
        sta $2AC0,x
        dex
        bpl rm_b8f2
        ldx #63
rm_b9f1 lda $2600,x
        sta $2B00,x
        dex
        bpl rm_b9f1
        ldx #63
rm_b9f2 lda $2640,x
        sta $2B40,x
        dex
        bpl rm_b9f2
        ldx #63
rm_bAf1 lda $2600,x
        sta $2B80,x
        dex
        bpl rm_bAf1
        ldx #63
rm_bAf2 lda $2640,x
        sta $2BC0,x
        dex
        bpl rm_bAf2
        ldx #63
rm_bBf1 lda $2600,x
        sta $2C00,x
        dex
        bpl rm_bBf1
        ldx #63
rm_bBf2 lda $2640,x
        sta $2C40,x
        dex
        bpl rm_bBf2
        ldx #63
rm_bCf1 lda $2600,x
        sta $2C80,x
        dex
        bpl rm_bCf1
        ldx #63
rm_bCf2 lda $2640,x
        sta $2CC0,x
        dex
        bpl rm_bCf2
	
	
; // ---------------------------------------------------------------------------
; // Copy master enemy sprite templates into all 13 block sprite pairs.
; //   Frame 1 master: sprite 24 @ $2600  →  sprites 26,28,30,...,50  (even slots)
; //   Frame 2 master: sprite 25 @ $2640  →  sprites 27,29,31,...,51  (odd slots)
; //   Sprite N base address: $2000 + N*64.  Block B: frame1=$2680+B*$80, frame2=$26C0+B*$80
; //
; // IRQ-SAFE: uses absolute indexed addressing (lda $abs,x / sta $abs,x).
; //   No ZP pointers used — X register only.  ZP $24/$68 never touched.
; //   PreventIRQ()/EnableIRQ() no longer required at the call site.
; // ---------------------------------------------------------------------------
; // Reset enemy grid to full rack
	lda #$3f
	; Calling storevariable on generic assign expression
	sta block_enemies+$0
	; Calling storevariable on generic assign expression
	sta block_enemies+$1
	; Calling storevariable on generic assign expression
	sta block_enemies+$2
	; Calling storevariable on generic assign expression
	sta block_enemies+$3
	; Calling storevariable on generic assign expression
	sta block_enemies+$4
	; Calling storevariable on generic assign expression
	sta block_enemies+$5
	; Calling storevariable on generic assign expression
	sta block_enemies+$6
	; Calling storevariable on generic assign expression
	sta block_enemies+$7
	; Calling storevariable on generic assign expression
	sta block_enemies+$8
	; Calling storevariable on generic assign expression
	sta block_enemies+$9
	; Calling storevariable on generic assign expression
	sta block_enemies+$a
	; Calling storevariable on generic assign expression
	sta block_enemies+$b
	lda #$0
	; Calling storevariable on generic assign expression
	sta numberOfEnemies
	
; // Reset march / movement state
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemy_direction
	lda #$47
	; Calling storevariable on generic assign expression
	sta enemyMoveCounter
	lda #$32
	; Calling storevariable on generic assign expression
	sta current_speed_delay
	lda #$0
	; Calling storevariable on generic assign expression
	sta pending_edge_rescan
	; Calling storevariable on generic assign expression
	sta enemy_march_tick
	; Calling storevariable on generic assign expression
	sta monster_animation_frame
	
; // Reset enemy shot state
	; Calling storevariable on generic assign expression
	sta ufo_bullet_active+$0
	; Calling storevariable on generic assign expression
	sta ufo_bullet_active+$1
	; Calling storevariable on generic assign expression
	sta ufo_bullet_active+$2
	; Calling storevariable on generic assign expression
	sta ufo_bullet_reload_timer+$0
	; Calling storevariable on generic assign expression
	sta ufo_bullet_reload_timer+$1
	; Calling storevariable on generic assign expression
	sta ufo_bullet_reload_timer+$2
	; Calling storevariable on generic assign expression
	sta ufo_bullet_next_to_fire
	; Calling storevariable on generic assign expression
	sta ufo_bullet_stagger_counter
	; Calling storevariable on generic assign expression
	sta es_plunger_step
	; Calling storevariable on generic assign expression
	sta es_squiggly_step
	
; // Reset player bullet
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	
; // Reset UFO
	; Calling storevariable on generic assign expression
	sta ufo_active
	; Integer constant assigning
	; Load16bitvariable : #$600
	ldy #$06
	lda #$00
	; Calling storevariable on generic assign expression
	sta ufo_spawn_timer
	sty ufo_spawn_timer+1
	rts
end_procedure_ReadyMonsters
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdateSprite
	;    Procedure type : User-defined procedure
UpdateSprite
	; Binary clause Simplified: EQUALS
	clc
	lda player_respawn_state
	; cmp #$00 ignored
	bne UpdateSprite_edblock9471
UpdateSprite_ctb9469: ;Main true block ;keep 
	
; // Update player position based on joystick input (disabled during respawn)
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
UpdateSprite_edblock9471
	
; // Update the sprite position on screen for sprite number @useSprite	
	; Setting sprite position
	; isi-pisi: value is constant
	lda player_sprite_x
	ldx #0
	sta $D000,x
UpdateSprite_spritepos9474
	lda $D010
	and #%11111110
	sta $D010
UpdateSprite_spriteposcontinue9475
	inx
	txa
	tay
	lda player_sprite_y
	sta $D000,y
	lda #$3
	; Calling storevariable on generic assign expression
	sta $D027+$0
	; Binary clause Simplified: EQUALS
	lda player_respawn_state
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne UpdateSprite_localfailed9510
	jmp UpdateSprite_ctb9477
UpdateSprite_localfailed9510
	jmp UpdateSprite_eblock9478
UpdateSprite_ctb9477: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_explosion_anim_index
	and #$1
	 ; end add / sub var with constant
	; cmp #$00 ignored
	bne UpdateSprite_eblock9514
UpdateSprite_ctb9513: ;Main true block ;keep 
	
; // Display explosion animation or normal player sprite
; // During explosion (state 1), show alternating sprites 18 and 7
	; Set sprite location
	ldx #$0 ; optimized, look out for bugs
	lda #$92
	sta $07f8 + $0,x
	jmp UpdateSprite_edblock9515
UpdateSprite_eblock9514
	; Set sprite location
	ldx #$0 ; optimized, look out for bugs
	lda #$87
	sta $07f8 + $0,x
UpdateSprite_edblock9515
	jmp UpdateSprite_edblock9479
UpdateSprite_eblock9478
	; Binary clause Simplified: EQUALS
	lda player_respawn_state
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne UpdateSprite_eblock9523
UpdateSprite_ctb9522: ;Main true block ;keep 
	
; // Waiting to respawn (state 2): hide sprite while counter expires
	; Toggle bit with constant
	lda $d015
	and #%11111110
	sta $d015
	ldx #$0 ; optimized, look out for bugs
	lda #1
UpdateSprite_shiftbit9534
	cpx #0
	beq UpdateSprite_shiftbitdone9535
	asl
	dex
	jmp UpdateSprite_shiftbit9534
UpdateSprite_shiftbitdone9535
UpdateSprite_bitmask_var9536 = $54
	sta UpdateSprite_bitmask_var9536
	lda #$FF
	eor UpdateSprite_bitmask_var9536
	sta UpdateSprite_bitmask_var9536
	lda $d015
	and UpdateSprite_bitmask_var9536
	sta $d015
	jmp UpdateSprite_edblock9524
UpdateSprite_eblock9523
	
; // Disable sprite 0
; // Normal play: show player ship
	; Toggle bit with constant
	lda $d015
	ora #%1
	sta $d015
	ldx #$0 ; optimized, look out for bugs
	lda #1
UpdateSprite_shiftbit9538
	cpx #0
	beq UpdateSprite_shiftbitdone9539
	asl
	dex
	jmp UpdateSprite_shiftbit9538
UpdateSprite_shiftbitdone9539
UpdateSprite_bitmask_var9540 = $54
	sta UpdateSprite_bitmask_var9540
	lda $d015
	ora UpdateSprite_bitmask_var9540
	sta $d015
	
; // Ensure sprite 0 is enabled
	; Set sprite location
	ldx #$0 ; optimized, look out for bugs
	lda #$80
	sta $07f8 + $0,x
UpdateSprite_edblock9524
UpdateSprite_edblock9479
	rts
end_procedure_UpdateSprite
	
; // ---------------------------------------------------------------------------
; // PLAYER BULLET PROCEDURES — Sprite 0 reserved for player bullet
; // ---------------------------------------------------------------------------
; // FirePlayerBullet: Spawns player bullet; increments shot counter (affects UFO spawn direction)
; // ShowBullet: Positions and displays player bullet sprite; handles explosion animation
; // CheckBulletCollision: Detects player bullet vs enemy formation (unrolled 4 columns)
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : FirePlayerBullet
	;    Procedure type : User-defined procedure
FirePlayerBullet
	
; //peek(^$D01F, 0);
	; Poke
	; Optimization: shift is zero
	lda #$0
	sta $d01f
	; Test Inc dec D
	inc player_shot_count
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
bullet_color	dc.b	0
ShowBullet_block9542
ShowBullet
	; Toggle bit with constant
	lda $d015
	ora #%1
	sta $d015
	ldx #$0 ; optimized, look out for bugs
	lda #1
ShowBullet_shiftbit9543
	cpx #0
	beq ShowBullet_shiftbitdone9544
	asl
	dex
	jmp ShowBullet_shiftbit9543
ShowBullet_shiftbitdone9544
ShowBullet_bitmask_var9545 = $54
	sta ShowBullet_bitmask_var9545
	lda $d015
	ora ShowBullet_bitmask_var9545
	sta $d015
	
; // Update score display after all score-changing events this frame.
; //DisplayScore();
	; Binary clause Simplified: NOTEQUALS
	clc
	lda player_bullet_active
	; cmp #$00 ignored
	beq ShowBullet_edblock9549
ShowBullet_ctb9547: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne ShowBullet_eblock9583
ShowBullet_ctb9582: ;Main true block ;keep 
	
; // Only display bullet/explosion if the sprite box fits entirely above the player raster line.
; // The VIC-II triggers sprite DMA at the TOP of the sprite box (player_bullet_y), not at the
; // pixel content. DMA runs for SPRITE_HEIGHT (21) lines. If player_bullet_y + SPRITE_HEIGHT >= 224,
; // the DMA window overlaps MainRasterPlayer, which can no longer retrigger sprite 0 for the player
; // at Y=226 that frame -> ship disappears. The guard is: player_bullet_y <= 224 - SPRITE_HEIGHT.
; // (= 203). Note: EXPLOSION_PIXELS_FROM_TOP shifts lit pixels downward inside the box, so the
; // explosion is still visually correct even when the box top is well above the enemy.
; // Select sprite based on bullet state:
; //   1 = normal bullet
; //   2 = alien-hit explosion (sprite 2)
; //   3 = enemy-shot explosion (sprite 3)
; // Alternate color each frame while showing alien-hit explosionif player_bullet_color_toggle = 0 then
; //				bullet_color := light_blue
; //			else
; //				bullet_color := cyan;
; //			sprite_color[1] := bullet_color;
; //			sprite_color[2] := bullet_color;
; //			sprite_color[3] := bullet_color;
; //			sprite_color[4] := bullet_color;
; //			if player_bullet_color_toggle = 0 then
; //				player_bullet_color_toggle := 1
; //			else
; //				player_bullet_color_toggle := 0;
; // Alien-hit explosion sprite
	lda #$2
	; Calling storevariable on generic assign expression
	sta bullet_sprite_index
	jmp ShowBullet_edblock9584
ShowBullet_eblock9583
	; Binary clause Simplified: EQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$3;keep
	bne ShowBullet_eblock9599
ShowBullet_ctb9598: ;Main true block ;keep 
	
; // Enemy-shot explosion sprite
	lda #$17
	; Calling storevariable on generic assign expression
	sta bullet_sprite_index
	jmp ShowBullet_edblock9600
ShowBullet_eblock9599
	lda #$1
	; Calling storevariable on generic assign expression
	sta bullet_sprite_index
ShowBullet_edblock9600
ShowBullet_edblock9584
	
; // Normal bullet sprite
	; Set sprite location
	lda #$0
	sta $50
	; Generic 16 bit op
	ldy #0
	lda bullet_sprite_index
ShowBullet_rightvarInteger_var9607 = $54
	sta ShowBullet_rightvarInteger_var9607
	sty ShowBullet_rightvarInteger_var9607+1
	lda #128
	ldy #0
	; Low bit binop:
	clc
	adc ShowBullet_rightvarInteger_var9607
ShowBullet_wordAdd9605
	sta ShowBullet_rightvarInteger_var9607
	; High-bit binop
	tya
	adc ShowBullet_rightvarInteger_var9607+1
	tay
	lda ShowBullet_rightvarInteger_var9607
	ldx $50
	sta $07f8 + $0,x
	; Setting sprite position
	; isi-pisi: value is constant
	lda player_bullet_x
	ldx #0
	sta $D000,x
ShowBullet_spritepos9608
	lda $D010
	and #%11111110
	sta $D010
ShowBullet_spriteposcontinue9609
	inx
	txa
	tay
	lda player_bullet_y
	sta $D000,y
ShowBullet_edblock9549
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
	bne UpdatePlayerBullet_eblock9613
UpdatePlayerBullet_ctb9612: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	lda player_bullet_y
	; Compare with pure num / var optimization
	cmp #$5;keep
	bcc UpdatePlayerBullet_eblock9646
UpdatePlayerBullet_ctb9645: ;Main true block ;keep 
	
; // Pixels per frame upward
; // Frames to show explosion
; // Move bullet up
	; Optimizer: a = a +/- b
	; Load16bitvariable : player_bullet_y
	lda player_bullet_y
	sec
	sbc #$4
	sta player_bullet_y
	jmp UpdatePlayerBullet_edblock9647
UpdatePlayerBullet_eblock9646
	
; // Bullet reached top of screen, deactivate
	lda #$0
	; Calling storevariable on generic assign expression
	sta player_bullet_active
UpdatePlayerBullet_edblock9647
	jmp UpdatePlayerBullet_edblock9614
UpdatePlayerBullet_eblock9613
	; Binary clause Simplified: GREATEREQUAL
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$2;keep
	bcc UpdatePlayerBullet_edblock9656
UpdatePlayerBullet_ctb9654: ;Main true block ;keep 
	
; // Explosion animation (state 2 = alien hit, state 3 = enemy shot hit)
	; Test Inc dec D
	inc explosion_frame_counter
	; Binary clause Simplified: GREATEREQUAL
	lda explosion_frame_counter
	; Compare with pure num / var optimization
	cmp #$10;keep
	bcc UpdatePlayerBullet_edblock9668
UpdatePlayerBullet_ctb9666: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	; Calling storevariable on generic assign expression
	sta explosion_frame_counter
UpdatePlayerBullet_edblock9668
UpdatePlayerBullet_edblock9656
UpdatePlayerBullet_edblock9614
	rts
end_procedure_UpdatePlayerBullet
	
; // ---------------------------------------------------------------------------
; // UpdatePlayerRespawn
; //   Manages the player respawn sequence after being hit.
; //   Respawn state 1:  Explosion animation (55 frames total, 11 frames * 5 frames each)
; //   Respawn state 2:  Respawn cooldown (81 frames remaining after explosion)
; //   Total: 136 frames before ship reappears at starting position
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : UpdatePlayerRespawn
	;    Procedure type : User-defined procedure
UpdatePlayerRespawn
	; Binary clause Simplified: NOTEQUALS
	clc
	lda player_respawn_state
	; cmp #$00 ignored
	beq UpdatePlayerRespawn_edblock9675
UpdatePlayerRespawn_ctb9673: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	lda player_respawn_counter
	; Compare with pure num / var optimization
	cmp #$1;keep
	bcc UpdatePlayerRespawn_eblock9788
UpdatePlayerRespawn_ctb9787: ;Main true block ;keep 
	; Test Inc dec D
	dec player_respawn_counter
	; Binary clause Simplified: EQUALS
	lda player_respawn_state
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne UpdatePlayerRespawn_edblock9846
UpdatePlayerRespawn_ctb9844: ;Main true block ;keep 
	
; // Explosion animation state (first 55 frames)
	; Test Inc dec D
	inc player_explosion_flash_counter
	; Binary clause Simplified: GREATEREQUAL
	lda player_explosion_flash_counter
	; Compare with pure num / var optimization
	cmp #$5;keep
	bcc UpdatePlayerRespawn_edblock9870
UpdatePlayerRespawn_ctb9868: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta player_explosion_flash_counter
	; Test Inc dec D
	inc player_explosion_anim_index
	; Binary clause Simplified: GREATEREQUAL
	lda player_explosion_anim_index
	; Compare with pure num / var optimization
	cmp #$b;keep
	bcc UpdatePlayerRespawn_edblock9882
UpdatePlayerRespawn_ctb9880: ;Main true block ;keep 
	
; // 11 frames: 0-10
; // Transition to respawn state
	lda #$2
	; Calling storevariable on generic assign expression
	sta player_respawn_state
	lda #$0
	; Calling storevariable on generic assign expression
	sta player_explosion_anim_index
UpdatePlayerRespawn_edblock9882
UpdatePlayerRespawn_edblock9870
UpdatePlayerRespawn_edblock9846
	jmp UpdatePlayerRespawn_edblock9789
UpdatePlayerRespawn_eblock9788
	; Binary clause Simplified: EQUALS
	clc
	lda remaining_ships
	; cmp #$00 ignored
	bne UpdatePlayerRespawn_eblock9888
UpdatePlayerRespawn_ctb9887: ;Main true block ;keep 
	
; // Respawn complete: reset player and return to normal state
; // No lives left: trigger game over
; // Disable all sprites IMMEDIATELY to prevent visual corruption during transition
	lda #$0
	; Calling storevariable on generic assign expression
	sta $d015
	lda #$1
	; Calling storevariable on generic assign expression
	sta game_over_mode
	; Calling storevariable on generic assign expression
	sta get_ready_mode
	
; // Use intermission screen framework
; // Signal IntermissionChain to display game over text and set palette
	; Calling storevariable on generic assign expression
	sta pending_palette
	jmp UpdatePlayerRespawn_edblock9889
UpdatePlayerRespawn_eblock9888
	
; // Set a neutral palette for game over screen
; //pal_col1:=BLUE;   pal_col2:=PURPLE; pal_col3:=GREY;
; //pal_col4:=LIGHT_GREY; pal_col5:=LIGHT_BLUE; pal_col6:=DARK_GREY;
; // Lives remaining: respawn ship
	lda #$27
	; Calling storevariable on generic assign expression
	sta player_sprite_x
	lda #$e2
	; Calling storevariable on generic assign expression
	sta player_sprite_y
	lda #$0
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	; Calling storevariable on generic assign expression
	sta player_respawn_state
	; Calling storevariable on generic assign expression
	sta player_explosion_anim_index
	; Calling storevariable on generic assign expression
	sta player_explosion_flash_counter
UpdatePlayerRespawn_edblock9889
UpdatePlayerRespawn_edblock9789
UpdatePlayerRespawn_edblock9675
	rts
end_procedure_UpdatePlayerRespawn
	
; // ── Nested: Check one block column for bullet collision ──────────────────
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CBC_CheckBlockColumn
	;    Procedure type : User-defined procedure
cbcc_block_index	dc.b	0
cbcc_enemy_alive	dc.b	0
cbcc_rel_x	dc.b	0
cbcc_enemy_col	dc.b	0
cbcc_enemy_row	dc.b	0
cbcc_hit_enemy_index	dc.b	0
cbcc_enemy_mask	dc.b	0
cbcc_block_col	dc.b	0
cbcc_block_row_base	dc.b	0
cbcc_block_x	dc.b	0
cbcc_block_y	dc.b	0
cbcc_rel_y	dc.b	0
CBC_CheckBlockColumn_block9894
CBC_CheckBlockColumn
	; Binary clause Simplified: EQUALS
	clc
	lda cbc_found_hit
	; cmp #$00 ignored
	bne CBC_CheckBlockColumn_localfailed11437
	jmp CBC_CheckBlockColumn_ctb9896
CBC_CheckBlockColumn_localfailed11437
	jmp CBC_CheckBlockColumn_edblock9898
CBC_CheckBlockColumn_ctb9896: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	lda cbcc_block_row_base
	clc
	adc cbcc_block_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta cbcc_block_index
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx cbcc_block_index
	lda block_enemies,x 
	; Calling storevariable on generic assign expression
	sta cbcc_enemy_alive
	; Binary clause Simplified: NOTEQUALS
	clc
	; cmp #$00 ignored
	beq CBC_CheckBlockColumn_localfailed12209
	jmp CBC_CheckBlockColumn_ctb11440
CBC_CheckBlockColumn_localfailed12209
	jmp CBC_CheckBlockColumn_edblock11442
CBC_CheckBlockColumn_ctb11440: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_x
	clc
	adc #$b
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp cbcc_block_x;keep
	bcc CBC_CheckBlockColumn_localfailed12595
	jmp CBC_CheckBlockColumn_ctb12212
CBC_CheckBlockColumn_localfailed12595
	jmp CBC_CheckBlockColumn_edblock12214
CBC_CheckBlockColumn_ctb12212: ;Main true block ;keep 
	; Binary clause Simplified: GREATER
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda cbcc_block_x
	clc
	adc #$30
	 ; end add / sub var with constant
	sec
	sbc #$b
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp player_bullet_x;keep
	bcc CBC_CheckBlockColumn_localfailed12788
	beq CBC_CheckBlockColumn_localfailed12788
	jmp CBC_CheckBlockColumn_ctb12598
CBC_CheckBlockColumn_localfailed12788
	jmp CBC_CheckBlockColumn_edblock12600
CBC_CheckBlockColumn_ctb12598: ;Main true block ;keep 
	
; // Horizontal range check: contact point within [block_x, block_x+48).
; // Addition form avoids byte underflow when cbcc_block_x < BULLET_X_CONTACT_REACH.
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_x
	sec
	sbc cbcc_block_x
	 ; end add / sub var with constant
	clc
	adc #$b
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta cbcc_rel_x
	; Binary clause Simplified: LESS
	; Compare with pure num / var optimization
	cmp #$c;keep
	bcs CBC_CheckBlockColumn_eblock12792
CBC_CheckBlockColumn_ctb12791: ;Main true block ;keep 
	
; // Enemy column within block (0-2): 12px wide, 6px gaps.
	lda #$0
	; Calling storevariable on generic assign expression
	sta cbcc_enemy_col
	jmp CBC_CheckBlockColumn_edblock12793
CBC_CheckBlockColumn_eblock12792
	; Binary clause Simplified: LESS
	lda cbcc_rel_x
	; Compare with pure num / var optimization
	cmp #$12;keep
	bcs CBC_CheckBlockColumn_eblock12856
CBC_CheckBlockColumn_ctb12855: ;Main true block ;keep 
	
; // gap
	lda #$ff
	; Calling storevariable on generic assign expression
	sta cbcc_enemy_col
	jmp CBC_CheckBlockColumn_edblock12857
CBC_CheckBlockColumn_eblock12856
	; Binary clause Simplified: LESS
	lda cbcc_rel_x
	; Compare with pure num / var optimization
	cmp #$1e;keep
	bcs CBC_CheckBlockColumn_eblock12888
CBC_CheckBlockColumn_ctb12887: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta cbcc_enemy_col
	jmp CBC_CheckBlockColumn_edblock12889
CBC_CheckBlockColumn_eblock12888
	; Binary clause Simplified: LESS
	lda cbcc_rel_x
	; Compare with pure num / var optimization
	cmp #$24;keep
	bcs CBC_CheckBlockColumn_eblock12904
CBC_CheckBlockColumn_ctb12903: ;Main true block ;keep 
	
; // gap
	lda #$ff
	; Calling storevariable on generic assign expression
	sta cbcc_enemy_col
	jmp CBC_CheckBlockColumn_edblock12905
CBC_CheckBlockColumn_eblock12904
	lda #$2
	; Calling storevariable on generic assign expression
	sta cbcc_enemy_col
CBC_CheckBlockColumn_edblock12905
CBC_CheckBlockColumn_edblock12889
CBC_CheckBlockColumn_edblock12857
CBC_CheckBlockColumn_edblock12793
	
; // Enemy row within block (0=top, 1=bottom).
	lda #$ff
	; Calling storevariable on generic assign expression
	sta cbcc_enemy_row
	; Binary clause Simplified: LESS
	lda cbcc_rel_y
	; Compare with pure num / var optimization
	cmp #$8;keep
	bcs CBC_CheckBlockColumn_eblock12912
CBC_CheckBlockColumn_ctb12911: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta cbcc_enemy_row
	jmp CBC_CheckBlockColumn_edblock12913
CBC_CheckBlockColumn_eblock12912
	; Binary clause Simplified: GREATEREQUAL
	lda cbcc_rel_y
	; Compare with pure num / var optimization
	cmp #$8;keep
	bcc CBC_CheckBlockColumn_edblock12928
CBC_CheckBlockColumn_localsuccess12930: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	lda cbcc_rel_y
	; Compare with pure num / var optimization
	cmp #$16;keep
	bcs CBC_CheckBlockColumn_edblock12928
CBC_CheckBlockColumn_ctb12926: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta cbcc_enemy_row
CBC_CheckBlockColumn_edblock12928
CBC_CheckBlockColumn_edblock12913
	; Binary clause Simplified: NOTEQUALS
	lda cbcc_enemy_row
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CBC_CheckBlockColumn_localfailed12955
CBC_CheckBlockColumn_localsuccess12956: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: NOTEQUALS
	lda cbcc_enemy_col
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CBC_CheckBlockColumn_localfailed12955
	jmp CBC_CheckBlockColumn_ctb12933
CBC_CheckBlockColumn_localfailed12955
	jmp CBC_CheckBlockColumn_edblock12935
CBC_CheckBlockColumn_ctb12933: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : cbcc_enemy_col
	lda cbcc_enemy_col
	asl
	clc
	adc cbcc_enemy_row
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta cbcc_hit_enemy_index
	tax ; optimized x, look out for bugs L22 ORG 	ldx cbcc_hit_enemy_index ; optimized, look out for bugs
	lda #$1
	cpx #0
	beq CBC_CheckBlockColumn_lblShiftDone12959
CBC_CheckBlockColumn_lblShift12958
	asl
	dex
	cpx #0
	bne CBC_CheckBlockColumn_lblShift12958
CBC_CheckBlockColumn_lblShiftDone12959
	; Calling storevariable on generic assign expression
	sta cbcc_enemy_mask
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda cbcc_enemy_alive
	and cbcc_enemy_mask
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq CBC_CheckBlockColumn_edblock12963
CBC_CheckBlockColumn_ctb12961: ;Main true block ;keep 
	lda cbcc_block_index
	; Calling storevariable on generic assign expression
	sta blockIndex
	lda cbcc_hit_enemy_index
	; Calling storevariable on generic assign expression
	sta enemyIndex
	jsr ClearMonster
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx cbcc_enemy_col ; optimized, look out for bugs
	; Load right hand side
	lda #$12
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc cbcc_block_x
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
	ldx cbcc_enemy_row ; optimized, look out for bugs
	; Load right hand side
	lda #$e
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc cbcc_block_y
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
	sta cbc_found_hit
	
; // Award points for the kill and flag the display for refresh.
	lda score
	clc
	adc #$0c
	sta score+0
	; Optimization : A := A op 8 bit - var and bvar are the same - perform inc
	bcc CBC_CheckBlockColumn_WordAdd12975
	inc score+1
CBC_CheckBlockColumn_WordAdd12975
	lda #$1
	; Calling storevariable on generic assign expression
	sta score_dirty
CBC_CheckBlockColumn_edblock12963
CBC_CheckBlockColumn_edblock12935
CBC_CheckBlockColumn_edblock12600
CBC_CheckBlockColumn_edblock12214
CBC_CheckBlockColumn_edblock11442
CBC_CheckBlockColumn_edblock9898
	rts
end_procedure_CBC_CheckBlockColumn
	
; // ---------------------------------------------------------------------------
; // CheckBulletCollision
; //   Checks player bullet collision against enemy formation blocks.
; //   CBC_CheckBlockColumn nested inside — sole caller.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CheckBulletCollision
	;    Procedure type : User-defined procedure
cbc_block_row	dc.b	0
cbc_should_check	dc.b	0
cbc_block_row_base	dc.b	0
cbc_block_y	dc.b	0
cbc_rel_y	dc.b	0
cbc_block_x	dc.b	0
CheckBulletCollision_block12976
CheckBulletCollision
	
; // CBC_CheckBlockColumn
	lda #$1
	; Calling storevariable on generic assign expression
	sta cbc_should_check
	lda #$0
	; Calling storevariable on generic assign expression
	sta cbc_found_hit
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_y
	clc
	adc #$d
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp monster_base_y;keep
	bcs CheckBulletCollision_edblock12980
CheckBulletCollision_ctb12978: ;Main true block ;keep 
	
; // Early exit if bullet outside enemy formation area.
	lda #$0
	; Calling storevariable on generic assign expression
	sta cbc_should_check
CheckBulletCollision_edblock12980
	; Optimization: replacing a <= N with a <= N-1
	; Binary clause Simplified: LESS
	lda monster_base_y
	; Compare with pure num / var optimization
	cmp #$b0;keep
	bcs CheckBulletCollision_edblock12986
CheckBulletCollision_ctb12984: ;Main true block ;keep 
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc #$50
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp player_bullet_y;keep
	bcs CheckBulletCollision_edblock12998
CheckBulletCollision_ctb12996: ;Main true block ;keep 
	
; // BYTE OVERFLOW GUARD: monster_base_y + 80 wraps when monster_base_y > 175.
	lda #$0
	; Calling storevariable on generic assign expression
	sta cbc_should_check
CheckBulletCollision_edblock12998
CheckBulletCollision_edblock12986
	; Binary clause Simplified: NOTEQUALS
	clc
	lda cbc_should_check
	; cmp #$00 ignored
	beq CheckBulletCollision_localfailed13032
	jmp CheckBulletCollision_ctb13002
CheckBulletCollision_localfailed13032
	jmp CheckBulletCollision_edblock13004
CheckBulletCollision_ctb13002: ;Main true block ;keep 
	
; // Determine block row (0-2) from bullet Y.
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
	; Calling storevariable on generic assign expression
	sta cbc_rel_y
	; Binary clause Simplified: LESS
	; Compare with pure num / var optimization
	cmp #$1a;keep
	bcs CheckBulletCollision_eblock13036
CheckBulletCollision_ctb13035: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta cbc_block_row
	jmp CheckBulletCollision_edblock13037
CheckBulletCollision_eblock13036
	; Binary clause Simplified: LESS
	lda cbc_rel_y
	; Compare with pure num / var optimization
	cmp #$34;keep
	bcs CheckBulletCollision_eblock13052
CheckBulletCollision_ctb13051: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta cbc_block_row
	jmp CheckBulletCollision_edblock13053
CheckBulletCollision_eblock13052
	lda #$2
	; Calling storevariable on generic assign expression
	sta cbc_block_row
CheckBulletCollision_edblock13053
CheckBulletCollision_edblock13037
	
; // Precompute row-constant values ONCE before the column scan.
	lda cbc_block_row
	asl
	asl
	; Calling storevariable on generic assign expression
	sta cbc_block_row_base
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx cbc_block_row ; optimized, look out for bugs
	; Load right hand side
	lda #$1a
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc monster_base_y
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta cbc_block_y
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_y
	clc
	adc #$d
	 ; end add / sub var with constant
	sec
	sbc cbc_block_y
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta cbc_rel_y
	
; // Check all 4 block columns (unrolled loop)
	lda monster_base_x
	; Calling storevariable on generic assign expression
	sta cbc_block_x
	lda #$0
	; Calling storevariable on generic assign expression
	sta cbcc_block_col
	lda cbc_block_row_base
	; Calling storevariable on generic assign expression
	sta cbcc_block_row_base
	lda cbc_block_x
	; Calling storevariable on generic assign expression
	sta cbcc_block_x
	lda cbc_block_y
	; Calling storevariable on generic assign expression
	sta cbcc_block_y
	lda cbc_rel_y
	; Calling storevariable on generic assign expression
	sta cbcc_rel_y
	jsr CBC_CheckBlockColumn
	; Optimizer: a = a +/- b
	; Load16bitvariable : cbc_block_x
	lda cbc_block_x
	clc
	adc #$36
	sta cbc_block_x
	lda #$1
	; Calling storevariable on generic assign expression
	sta cbcc_block_col
	lda cbc_block_row_base
	; Calling storevariable on generic assign expression
	sta cbcc_block_row_base
	lda cbc_block_x
	; Calling storevariable on generic assign expression
	sta cbcc_block_x
	lda cbc_block_y
	; Calling storevariable on generic assign expression
	sta cbcc_block_y
	lda cbc_rel_y
	; Calling storevariable on generic assign expression
	sta cbcc_rel_y
	jsr CBC_CheckBlockColumn
	; Optimizer: a = a +/- b
	; Load16bitvariable : cbc_block_x
	lda cbc_block_x
	clc
	adc #$36
	sta cbc_block_x
	lda #$2
	; Calling storevariable on generic assign expression
	sta cbcc_block_col
	lda cbc_block_row_base
	; Calling storevariable on generic assign expression
	sta cbcc_block_row_base
	lda cbc_block_x
	; Calling storevariable on generic assign expression
	sta cbcc_block_x
	lda cbc_block_y
	; Calling storevariable on generic assign expression
	sta cbcc_block_y
	lda cbc_rel_y
	; Calling storevariable on generic assign expression
	sta cbcc_rel_y
	jsr CBC_CheckBlockColumn
	; Optimizer: a = a +/- b
	; Load16bitvariable : cbc_block_x
	lda cbc_block_x
	clc
	adc #$36
	sta cbc_block_x
	lda #$3
	; Calling storevariable on generic assign expression
	sta cbcc_block_col
	lda cbc_block_row_base
	; Calling storevariable on generic assign expression
	sta cbcc_block_row_base
	lda cbc_block_x
	; Calling storevariable on generic assign expression
	sta cbcc_block_x
	lda cbc_block_y
	; Calling storevariable on generic assign expression
	sta cbcc_block_y
	lda cbc_rel_y
	; Calling storevariable on generic assign expression
	sta cbcc_rel_y
	jsr CBC_CheckBlockColumn
CheckBulletCollision_edblock13004
	rts
end_procedure_CheckBulletCollision
	
; // ── Nested: Test enemy X against all 4 shields ──────────────────────────────
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CESC_TryAllShields_Unrolled
	;    Procedure type : User-defined procedure
tas_byte_col	dc.b	0
tas_col_idx	dc.b	0
tas_enemy_x	dc.b	0
CESC_TryAllShields_Unrolled_block13060
CESC_TryAllShields_Unrolled
	; Binary clause Simplified: EQUALS
	clc
	lda cesc_contact_done
	; cmp #$00 ignored
	bne CESC_TryAllShields_Unrolled_localfailed13103
CESC_TryAllShields_Unrolled_localsuccess13104: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda shield_top_eroded +$0 ; array with const index optimization 
	; cmp #$00 ignored
	bne CESC_TryAllShields_Unrolled_localfailed13103
	jmp CESC_TryAllShields_Unrolled_ctb13062
CESC_TryAllShields_Unrolled_localfailed13103
	jmp CESC_TryAllShields_Unrolled_edblock13064
CESC_TryAllShields_Unrolled_ctb13062: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	; 8 bit binop
	; Add/sub where right value is constant number
	lda tas_enemy_x
	clc
	adc #$b
	 ; end add / sub var with constant
CESC_TryAllShields_Unrolled_binary_clause_temp_var13126 = $54
	sta CESC_TryAllShields_Unrolled_binary_clause_temp_var13126
	; Load Byte array
	; CAST type NADA
	lda SHIELD_X_MIN +$0 ; array with const index optimization 
CESC_TryAllShields_Unrolled_binary_clause_temp_2_var13127 = $56
	sta CESC_TryAllShields_Unrolled_binary_clause_temp_2_var13127
	lda CESC_TryAllShields_Unrolled_binary_clause_temp_var13126
	cmp CESC_TryAllShields_Unrolled_binary_clause_temp_2_var13127;keep
	bcc CESC_TryAllShields_Unrolled_edblock13109
CESC_TryAllShields_Unrolled_localsuccess13125: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: GREATER
	; Load Byte array
	; CAST type NADA
	lda SHIELD_X_MAX +$0 ; array with const index optimization 
	; Compare with pure num / var optimization
	cmp tas_enemy_x;keep
	bcc CESC_TryAllShields_Unrolled_edblock13109
	beq CESC_TryAllShields_Unrolled_edblock13109
CESC_TryAllShields_Unrolled_ctb13107: ;Main true block ;keep 
	; Binary clause Simplified: LESSEQUAL
	; Load Byte array
	; CAST type NADA
	lda SHIELD_X_MIN +$0 ; array with const index optimization 
	; Compare with pure num / var optimization
	cmp tas_enemy_x;keep
	beq CESC_TryAllShields_Unrolled_ctb13130
	bcs CESC_TryAllShields_Unrolled_eblock13131
CESC_TryAllShields_Unrolled_ctb13130: ;Main true block ;keep 
	
; // Try Shield 0
	; 8 bit binop
	; Add/sub where right value is constant number
	lda tas_enemy_x
	sec
	; Load Byte array
	; CAST type NADA
	sbc  SHIELD_X_MIN +$0 ; array with const index optimization 
	 ; end add / sub var with constant
	lsr
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta tas_byte_col
	jmp CESC_TryAllShields_Unrolled_edblock13132
CESC_TryAllShields_Unrolled_eblock13131
	lda #$0
	; Calling storevariable on generic assign expression
	sta tas_byte_col
CESC_TryAllShields_Unrolled_edblock13132
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #0
	clc
	adc tas_byte_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta tas_col_idx
	; Binary clause Simplified: NOTEQUALS
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx tas_col_idx
	lda shield_surface_bot,x 
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CESC_TryAllShields_Unrolled_edblock13140
CESC_TryAllShields_Unrolled_ctb13138: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	lda #$0
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	lda tas_byte_col
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	; Load Byte array
	; CAST type NADA
	ldx tas_col_idx
	lda shield_surface_bot,x 
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	lda #$1
	; Calling storevariable on generic assign expression
	sta cesc_contact_done
CESC_TryAllShields_Unrolled_edblock13140
CESC_TryAllShields_Unrolled_edblock13109
CESC_TryAllShields_Unrolled_edblock13064
	; Binary clause Simplified: EQUALS
	clc
	lda cesc_contact_done
	; cmp #$00 ignored
	bne CESC_TryAllShields_Unrolled_localfailed13185
CESC_TryAllShields_Unrolled_localsuccess13186: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda shield_top_eroded +$1 ; array with const index optimization 
	; cmp #$00 ignored
	bne CESC_TryAllShields_Unrolled_localfailed13185
	jmp CESC_TryAllShields_Unrolled_ctb13144
CESC_TryAllShields_Unrolled_localfailed13185
	jmp CESC_TryAllShields_Unrolled_edblock13146
CESC_TryAllShields_Unrolled_ctb13144: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	; 8 bit binop
	; Add/sub where right value is constant number
	lda tas_enemy_x
	clc
	adc #$b
	 ; end add / sub var with constant
CESC_TryAllShields_Unrolled_binary_clause_temp_var13208 = $54
	sta CESC_TryAllShields_Unrolled_binary_clause_temp_var13208
	; Load Byte array
	; CAST type NADA
	lda SHIELD_X_MIN +$1 ; array with const index optimization 
CESC_TryAllShields_Unrolled_binary_clause_temp_2_var13209 = $56
	sta CESC_TryAllShields_Unrolled_binary_clause_temp_2_var13209
	lda CESC_TryAllShields_Unrolled_binary_clause_temp_var13208
	cmp CESC_TryAllShields_Unrolled_binary_clause_temp_2_var13209;keep
	bcc CESC_TryAllShields_Unrolled_edblock13191
CESC_TryAllShields_Unrolled_localsuccess13207: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: GREATER
	; Load Byte array
	; CAST type NADA
	lda SHIELD_X_MAX +$1 ; array with const index optimization 
	; Compare with pure num / var optimization
	cmp tas_enemy_x;keep
	bcc CESC_TryAllShields_Unrolled_edblock13191
	beq CESC_TryAllShields_Unrolled_edblock13191
CESC_TryAllShields_Unrolled_ctb13189: ;Main true block ;keep 
	; Binary clause Simplified: LESSEQUAL
	; Load Byte array
	; CAST type NADA
	lda SHIELD_X_MIN +$1 ; array with const index optimization 
	; Compare with pure num / var optimization
	cmp tas_enemy_x;keep
	beq CESC_TryAllShields_Unrolled_ctb13212
	bcs CESC_TryAllShields_Unrolled_eblock13213
CESC_TryAllShields_Unrolled_ctb13212: ;Main true block ;keep 
	
; // Try Shield 1
	; 8 bit binop
	; Add/sub where right value is constant number
	lda tas_enemy_x
	sec
	; Load Byte array
	; CAST type NADA
	sbc  SHIELD_X_MIN +$1 ; array with const index optimization 
	 ; end add / sub var with constant
	lsr
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta tas_byte_col
	jmp CESC_TryAllShields_Unrolled_edblock13214
CESC_TryAllShields_Unrolled_eblock13213
	lda #$0
	; Calling storevariable on generic assign expression
	sta tas_byte_col
CESC_TryAllShields_Unrolled_edblock13214
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #3
	clc
	adc tas_byte_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta tas_col_idx
	; Binary clause Simplified: NOTEQUALS
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx tas_col_idx
	lda shield_surface_bot,x 
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CESC_TryAllShields_Unrolled_edblock13222
CESC_TryAllShields_Unrolled_ctb13220: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	lda tas_byte_col
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	; Load Byte array
	; CAST type NADA
	ldx tas_col_idx
	lda shield_surface_bot,x 
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	lda #$1
	; Calling storevariable on generic assign expression
	sta cesc_contact_done
CESC_TryAllShields_Unrolled_edblock13222
CESC_TryAllShields_Unrolled_edblock13191
CESC_TryAllShields_Unrolled_edblock13146
	; Binary clause Simplified: EQUALS
	clc
	lda cesc_contact_done
	; cmp #$00 ignored
	bne CESC_TryAllShields_Unrolled_localfailed13267
CESC_TryAllShields_Unrolled_localsuccess13268: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda shield_top_eroded +$2 ; array with const index optimization 
	; cmp #$00 ignored
	bne CESC_TryAllShields_Unrolled_localfailed13267
	jmp CESC_TryAllShields_Unrolled_ctb13226
CESC_TryAllShields_Unrolled_localfailed13267
	jmp CESC_TryAllShields_Unrolled_edblock13228
CESC_TryAllShields_Unrolled_ctb13226: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	; 8 bit binop
	; Add/sub where right value is constant number
	lda tas_enemy_x
	clc
	adc #$b
	 ; end add / sub var with constant
CESC_TryAllShields_Unrolled_binary_clause_temp_var13290 = $54
	sta CESC_TryAllShields_Unrolled_binary_clause_temp_var13290
	; Load Byte array
	; CAST type NADA
	lda SHIELD_X_MIN +$2 ; array with const index optimization 
CESC_TryAllShields_Unrolled_binary_clause_temp_2_var13291 = $56
	sta CESC_TryAllShields_Unrolled_binary_clause_temp_2_var13291
	lda CESC_TryAllShields_Unrolled_binary_clause_temp_var13290
	cmp CESC_TryAllShields_Unrolled_binary_clause_temp_2_var13291;keep
	bcc CESC_TryAllShields_Unrolled_edblock13273
CESC_TryAllShields_Unrolled_localsuccess13289: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: GREATER
	; Load Byte array
	; CAST type NADA
	lda SHIELD_X_MAX +$2 ; array with const index optimization 
	; Compare with pure num / var optimization
	cmp tas_enemy_x;keep
	bcc CESC_TryAllShields_Unrolled_edblock13273
	beq CESC_TryAllShields_Unrolled_edblock13273
CESC_TryAllShields_Unrolled_ctb13271: ;Main true block ;keep 
	; Binary clause Simplified: LESSEQUAL
	; Load Byte array
	; CAST type NADA
	lda SHIELD_X_MIN +$2 ; array with const index optimization 
	; Compare with pure num / var optimization
	cmp tas_enemy_x;keep
	beq CESC_TryAllShields_Unrolled_ctb13294
	bcs CESC_TryAllShields_Unrolled_eblock13295
CESC_TryAllShields_Unrolled_ctb13294: ;Main true block ;keep 
	
; // Try Shield 2
	; 8 bit binop
	; Add/sub where right value is constant number
	lda tas_enemy_x
	sec
	; Load Byte array
	; CAST type NADA
	sbc  SHIELD_X_MIN +$2 ; array with const index optimization 
	 ; end add / sub var with constant
	lsr
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta tas_byte_col
	jmp CESC_TryAllShields_Unrolled_edblock13296
CESC_TryAllShields_Unrolled_eblock13295
	lda #$0
	; Calling storevariable on generic assign expression
	sta tas_byte_col
CESC_TryAllShields_Unrolled_edblock13296
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #6
	clc
	adc tas_byte_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta tas_col_idx
	; Binary clause Simplified: NOTEQUALS
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx tas_col_idx
	lda shield_surface_bot,x 
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CESC_TryAllShields_Unrolled_edblock13304
CESC_TryAllShields_Unrolled_ctb13302: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	lda #$2
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	lda tas_byte_col
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	; Load Byte array
	; CAST type NADA
	ldx tas_col_idx
	lda shield_surface_bot,x 
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	lda #$1
	; Calling storevariable on generic assign expression
	sta cesc_contact_done
CESC_TryAllShields_Unrolled_edblock13304
CESC_TryAllShields_Unrolled_edblock13273
CESC_TryAllShields_Unrolled_edblock13228
	; Binary clause Simplified: EQUALS
	clc
	lda cesc_contact_done
	; cmp #$00 ignored
	bne CESC_TryAllShields_Unrolled_localfailed13349
CESC_TryAllShields_Unrolled_localsuccess13350: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda shield_top_eroded +$3 ; array with const index optimization 
	; cmp #$00 ignored
	bne CESC_TryAllShields_Unrolled_localfailed13349
	jmp CESC_TryAllShields_Unrolled_ctb13308
CESC_TryAllShields_Unrolled_localfailed13349
	jmp CESC_TryAllShields_Unrolled_edblock13310
CESC_TryAllShields_Unrolled_ctb13308: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	; 8 bit binop
	; Add/sub where right value is constant number
	lda tas_enemy_x
	clc
	adc #$b
	 ; end add / sub var with constant
CESC_TryAllShields_Unrolled_binary_clause_temp_var13372 = $54
	sta CESC_TryAllShields_Unrolled_binary_clause_temp_var13372
	; Load Byte array
	; CAST type NADA
	lda SHIELD_X_MIN +$3 ; array with const index optimization 
CESC_TryAllShields_Unrolled_binary_clause_temp_2_var13373 = $56
	sta CESC_TryAllShields_Unrolled_binary_clause_temp_2_var13373
	lda CESC_TryAllShields_Unrolled_binary_clause_temp_var13372
	cmp CESC_TryAllShields_Unrolled_binary_clause_temp_2_var13373;keep
	bcc CESC_TryAllShields_Unrolled_edblock13355
CESC_TryAllShields_Unrolled_localsuccess13371: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: GREATER
	; Load Byte array
	; CAST type NADA
	lda SHIELD_X_MAX +$3 ; array with const index optimization 
	; Compare with pure num / var optimization
	cmp tas_enemy_x;keep
	bcc CESC_TryAllShields_Unrolled_edblock13355
	beq CESC_TryAllShields_Unrolled_edblock13355
CESC_TryAllShields_Unrolled_ctb13353: ;Main true block ;keep 
	; Binary clause Simplified: LESSEQUAL
	; Load Byte array
	; CAST type NADA
	lda SHIELD_X_MIN +$3 ; array with const index optimization 
	; Compare with pure num / var optimization
	cmp tas_enemy_x;keep
	beq CESC_TryAllShields_Unrolled_ctb13376
	bcs CESC_TryAllShields_Unrolled_eblock13377
CESC_TryAllShields_Unrolled_ctb13376: ;Main true block ;keep 
	
; // Try Shield 3
	; 8 bit binop
	; Add/sub where right value is constant number
	lda tas_enemy_x
	sec
	; Load Byte array
	; CAST type NADA
	sbc  SHIELD_X_MIN +$3 ; array with const index optimization 
	 ; end add / sub var with constant
	lsr
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta tas_byte_col
	jmp CESC_TryAllShields_Unrolled_edblock13378
CESC_TryAllShields_Unrolled_eblock13377
	lda #$0
	; Calling storevariable on generic assign expression
	sta tas_byte_col
CESC_TryAllShields_Unrolled_edblock13378
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #9
	clc
	adc tas_byte_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta tas_col_idx
	; Binary clause Simplified: NOTEQUALS
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx tas_col_idx
	lda shield_surface_bot,x 
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CESC_TryAllShields_Unrolled_edblock13386
CESC_TryAllShields_Unrolled_ctb13384: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	lda #$3
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	lda tas_byte_col
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	; Load Byte array
	; CAST type NADA
	ldx tas_col_idx
	lda shield_surface_bot,x 
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	lda #$1
	; Calling storevariable on generic assign expression
	sta cesc_contact_done
CESC_TryAllShields_Unrolled_edblock13386
CESC_TryAllShields_Unrolled_edblock13355
CESC_TryAllShields_Unrolled_edblock13310
	rts
end_procedure_CESC_TryAllShields_Unrolled
	
; // CESC_TryAllShields_Unrolled
; // ── Nested: Check one enemy column (0, 1, or 2) ─────────────────────────────
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CESC_CheckColumn
	;    Procedure type : User-defined procedure
cc_block_byte	dc.b	0
cc_col_mask	dc.b	0
cc_bot_mask	dc.b	0
cc_enemy_x	dc.b	0
cc_row	dc.b	0
cc_block_col	dc.b	0
cc_enemy_col	dc.b	0
cc_row_offset	dc.b	0
CESC_CheckColumn_block13389
CESC_CheckColumn
	; Binary clause Simplified: EQUALS
	clc
	lda cesc_contact_done
	; cmp #$00 ignored
	bne CESC_CheckColumn_localfailed13491
	jmp CESC_CheckColumn_ctb13391
CESC_CheckColumn_localfailed13491
	jmp CESC_CheckColumn_edblock13393
CESC_CheckColumn_ctb13391: ;Main true block ;keep 
	
; // CESC_CheckColumn
	; Load Byte array
	; CAST type NADA
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : cc_row
	lda cc_row
	asl
	asl
	clc
	adc cc_block_col
	 ; end add / sub var with constant
	tax
	lda block_enemies,x 
	; Calling storevariable on generic assign expression
	sta cc_block_byte
	; Binary clause Simplified: EQUALS
	clc
	lda cc_enemy_col
	; cmp #$00 ignored
	bne CESC_CheckColumn_eblock13495
CESC_CheckColumn_ctb13494: ;Main true block ;keep 
	
; // Unrolled column masks for efficiency
	lda #$3
	; Calling storevariable on generic assign expression
	sta cc_col_mask
	lda #$2
	; Calling storevariable on generic assign expression
	sta cc_bot_mask
	jmp CESC_CheckColumn_edblock13496
CESC_CheckColumn_eblock13495
	; Binary clause Simplified: EQUALS
	lda cc_enemy_col
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CESC_CheckColumn_eblock13511
CESC_CheckColumn_ctb13510: ;Main true block ;keep 
	lda #$c
	; Calling storevariable on generic assign expression
	sta cc_col_mask
	lda #$8
	; Calling storevariable on generic assign expression
	sta cc_bot_mask
	jmp CESC_CheckColumn_edblock13512
CESC_CheckColumn_eblock13511
	lda #$30
	; Calling storevariable on generic assign expression
	sta cc_col_mask
	lda #$20
	; Calling storevariable on generic assign expression
	sta cc_bot_mask
CESC_CheckColumn_edblock13512
CESC_CheckColumn_edblock13496
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda cc_block_byte
	and cc_col_mask
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq CESC_CheckColumn_edblock13520
CESC_CheckColumn_ctb13518: ;Main true block ;keep 
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda cc_block_byte
	and cc_bot_mask
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq CESC_CheckColumn_localfailed13574
	jmp CESC_CheckColumn_ctb13557
CESC_CheckColumn_localfailed13574: ;keep
	; ; logical OR, second chance
	; Binary clause Simplified: GREATEREQUAL
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc cc_row_offset
	 ; end add / sub var with constant
	clc
	adc #$7
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$c7;keep
	bcc CESC_CheckColumn_edblock13559
CESC_CheckColumn_ctb13557: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub right value is variable/expression
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx cc_enemy_col ; optimized, look out for bugs
	; Load right hand side
	lda #$12
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
CESC_CheckColumn_rightvarAddSub_var13578 = $54
	sta CESC_CheckColumn_rightvarAddSub_var13578
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx cc_block_col ; optimized, look out for bugs
	; Load right hand side
	lda #$36
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc monster_base_x
	 ; end add / sub var with constant
	clc
	adc CESC_CheckColumn_rightvarAddSub_var13578
	; Calling storevariable on generic assign expression
	sta cc_enemy_x
	; Binary clause Simplified: GREATEREQUAL
	; Compare with pure num / var optimization
	cmp #$6;keep
	bcc CESC_CheckColumn_eblock13583
CESC_CheckColumn_ctb13582: ;Main true block ;keep 
	; Optimizer: a = a +/- b
	; Load16bitvariable : cc_enemy_x
	lda cc_enemy_x
	sec
	sbc #$6
	sta cc_enemy_x
	jmp CESC_CheckColumn_edblock13584
CESC_CheckColumn_eblock13583
	lda #$0
	; Calling storevariable on generic assign expression
	sta cc_enemy_x
CESC_CheckColumn_edblock13584
	lda cc_enemy_x
	; Calling storevariable on generic assign expression
	sta tas_enemy_x
	jsr CESC_TryAllShields_Unrolled
CESC_CheckColumn_edblock13559
CESC_CheckColumn_edblock13520
CESC_CheckColumn_edblock13393
	rts
end_procedure_CESC_CheckColumn
	
; // CESC_CheckColumn
; // ── Nested: Check all 3 columns in one block ────────────────────────────────
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CESC_CheckBlock
	;    Procedure type : User-defined procedure
cb_row	dc.b	0
cb_block_col	dc.b	0
cb_row_offset	dc.b	0
CESC_CheckBlock_block13589
CESC_CheckBlock
	
; // CESC_CheckBlock
	lda cb_row
	; Calling storevariable on generic assign expression
	sta cc_row
	lda cb_block_col
	; Calling storevariable on generic assign expression
	sta cc_block_col
	lda #$0
	; Calling storevariable on generic assign expression
	sta cc_enemy_col
	lda cb_row_offset
	; Calling storevariable on generic assign expression
	sta cc_row_offset
	jsr CESC_CheckColumn
	lda cb_row
	; Calling storevariable on generic assign expression
	sta cc_row
	lda cb_block_col
	; Calling storevariable on generic assign expression
	sta cc_block_col
	lda #$1
	; Calling storevariable on generic assign expression
	sta cc_enemy_col
	lda cb_row_offset
	; Calling storevariable on generic assign expression
	sta cc_row_offset
	jsr CESC_CheckColumn
	lda cb_row
	; Calling storevariable on generic assign expression
	sta cc_row
	lda cb_block_col
	; Calling storevariable on generic assign expression
	sta cc_block_col
	lda #$2
	; Calling storevariable on generic assign expression
	sta cc_enemy_col
	lda cb_row_offset
	; Calling storevariable on generic assign expression
	sta cc_row_offset
	jsr CESC_CheckColumn
	rts
end_procedure_CESC_CheckBlock
	
; // CESC_CheckBlock
; // ── Nested: Check all blocks (0-3) in one formation row ─────────────────────
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CESC_CheckRow
	;    Procedure type : User-defined procedure
cr_row	dc.b	0
cr_row_offset	dc.b	0
CESC_CheckRow_block13590
CESC_CheckRow
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : cr_row
	lda cr_row
	asl
	asl
	clc
	adc #$0
	 ; end add / sub var with constant
	tax
	lda block_enemies,x 
	; cmp #$00 ignored
	beq CESC_CheckRow_edblock13594
CESC_CheckRow_ctb13592: ;Main true block ;keep 
	
; // CESC_CheckRow
	lda cr_row
	; Calling storevariable on generic assign expression
	sta cb_row
	lda #$0
	; Calling storevariable on generic assign expression
	sta cb_block_col
	lda cr_row_offset
	; Calling storevariable on generic assign expression
	sta cb_row_offset
	jsr CESC_CheckBlock
CESC_CheckRow_edblock13594
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : cr_row
	lda cr_row
	asl
	asl
	clc
	adc #$1
	 ; end add / sub var with constant
	tax
	lda block_enemies,x 
	; cmp #$00 ignored
	beq CESC_CheckRow_edblock13600
CESC_CheckRow_ctb13598: ;Main true block ;keep 
	lda cr_row
	; Calling storevariable on generic assign expression
	sta cb_row
	lda #$1
	; Calling storevariable on generic assign expression
	sta cb_block_col
	lda cr_row_offset
	; Calling storevariable on generic assign expression
	sta cb_row_offset
	jsr CESC_CheckBlock
CESC_CheckRow_edblock13600
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : cr_row
	lda cr_row
	asl
	asl
	clc
	adc #$2
	 ; end add / sub var with constant
	tax
	lda block_enemies,x 
	; cmp #$00 ignored
	beq CESC_CheckRow_edblock13606
CESC_CheckRow_ctb13604: ;Main true block ;keep 
	lda cr_row
	; Calling storevariable on generic assign expression
	sta cb_row
	lda #$2
	; Calling storevariable on generic assign expression
	sta cb_block_col
	lda cr_row_offset
	; Calling storevariable on generic assign expression
	sta cb_row_offset
	jsr CESC_CheckBlock
CESC_CheckRow_edblock13606
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul of power 2
	; Load16bitvariable : cr_row
	lda cr_row
	asl
	asl
	clc
	adc #$3
	 ; end add / sub var with constant
	tax
	lda block_enemies,x 
	; cmp #$00 ignored
	beq CESC_CheckRow_edblock13612
CESC_CheckRow_ctb13610: ;Main true block ;keep 
	lda cr_row
	; Calling storevariable on generic assign expression
	sta cb_row
	lda #$3
	; Calling storevariable on generic assign expression
	sta cb_block_col
	lda cr_row_offset
	; Calling storevariable on generic assign expression
	sta cb_row_offset
	jsr CESC_CheckBlock
CESC_CheckRow_edblock13612
	rts
end_procedure_CESC_CheckRow
	
; // ---------------------------------------------------------------------------
; // CheckEnemyShieldContact
; //   Called once per march step (gated on enemy_march_tick).
; //   Scans formation rows bottom-to-top; for each alive enemy sub-column whose
; //   actual pixels overlap the tuned shield band, queues one top-down erosion
; //   event via the pending_* pipeline and exits.
; //   Y: bottom sub-row alive -> row 20;  top-only -> row 7.
; //      Row fast skip uses row 20; per-sub-col refines for top-only enemies.
; //   X: sub-col 12px wide. right edge (X+11) >= SHIELD_X_MIN, left edge < SHIELD_X_MAX.
; //      CONTACT_X_NUDGE shifts X left; shield matched via SHIELD_X_MIN/MAX arrays.
; // ---------------------------------------------------------------------------
; // ---------------------------------------------------------------------------
; // SHIELD SYSTEM PROCEDURES — Charset-based erosion + surface caching
; // ---------------------------------------------------------------------------
; // CheckEnemyShieldContact: Detects enemies overlapping shields; queues erosion
; // CheckEnemyShieldCollision: Detects enemy bullets hitting shields
; // CheckBulletCollision: Detects player bullets hitting shields
; // ApplyShieldErosion: Applies queued erosion stencils to charset bytes; updates surface caches
; // CopyShieldSprites: Resets shield charsets to pristine (called per level, plus game start)
; //
; // Refactoring Notes:
; //   - CESC_CheckRow/Block/Column/TryAllShields nested inside CheckEnemyShieldContact
; //   - CBC_CheckBlockColumn nested inside CheckBulletCollision
; //   - Each flag (cesc_contact_done, cbc_found_hit) is a global var (nested procs can't access outer-proc locals)
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CheckEnemyShieldContact
	;    Procedure type : User-defined procedure
cesc_row_offset	dc.b	0
CheckEnemyShieldContact_block13615
CheckEnemyShieldContact
	; Binary clause Simplified: NOTEQUALS
	clc
	lda enemy_march_tick
	; cmp #$00 ignored
	beq CheckEnemyShieldContact_localfailed13722
	jmp CheckEnemyShieldContact_ctb13617
CheckEnemyShieldContact_localfailed13722
	jmp CheckEnemyShieldContact_edblock13619
CheckEnemyShieldContact_ctb13617: ;Main true block ;keep 
	
; // CESC_CheckRow
; // CheckEnemyShieldContact
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_march_tick
	; Binary clause Simplified: EQUALS
	clc
	lda pending_shield_erosion
	; cmp #$00 ignored
	bne CheckEnemyShieldContact_localfailed13776
	jmp CheckEnemyShieldContact_ctb13725
CheckEnemyShieldContact_localfailed13776
	jmp CheckEnemyShieldContact_edblock13727
CheckEnemyShieldContact_ctb13725: ;Main true block ;keep 
	sei
	lda #$0
	; Calling storevariable on generic assign expression
	sta cesc_contact_done
	
; // Check formation row 2
	lda #$34
	; Calling storevariable on generic assign expression
	sta cesc_row_offset
	; Binary clause Simplified: GREATEREQUAL
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc cesc_row_offset
	 ; end add / sub var with constant
	clc
	adc #$14
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$c7;keep
	bcc CheckEnemyShieldContact_edblock13781
CheckEnemyShieldContact_localsuccess13783: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc cesc_row_offset
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$c9;keep
	bcs CheckEnemyShieldContact_edblock13781
CheckEnemyShieldContact_ctb13779: ;Main true block ;keep 
	lda #$2
	; Calling storevariable on generic assign expression
	sta cr_row
	lda cesc_row_offset
	; Calling storevariable on generic assign expression
	sta cr_row_offset
	jsr CESC_CheckRow
CheckEnemyShieldContact_edblock13781
	; Binary clause Simplified: EQUALS
	clc
	lda cesc_contact_done
	; cmp #$00 ignored
	bne CheckEnemyShieldContact_edblock13788
CheckEnemyShieldContact_ctb13786: ;Main true block ;keep 
	
; // Check formation row 1
	lda #$1a
	; Calling storevariable on generic assign expression
	sta cesc_row_offset
	; Binary clause Simplified: GREATEREQUAL
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc cesc_row_offset
	 ; end add / sub var with constant
	clc
	adc #$14
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$c7;keep
	bcc CheckEnemyShieldContact_edblock13801
CheckEnemyShieldContact_localsuccess13803: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc cesc_row_offset
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$c9;keep
	bcs CheckEnemyShieldContact_edblock13801
CheckEnemyShieldContact_ctb13799: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta cr_row
	lda cesc_row_offset
	; Calling storevariable on generic assign expression
	sta cr_row_offset
	jsr CESC_CheckRow
CheckEnemyShieldContact_edblock13801
CheckEnemyShieldContact_edblock13788
	; Binary clause Simplified: EQUALS
	clc
	lda cesc_contact_done
	; cmp #$00 ignored
	bne CheckEnemyShieldContact_edblock13808
CheckEnemyShieldContact_ctb13806: ;Main true block ;keep 
	
; // Check formation row 0
	lda #$0
	; Calling storevariable on generic assign expression
	sta cesc_row_offset
	; Binary clause Simplified: GREATEREQUAL
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc cesc_row_offset
	 ; end add / sub var with constant
	clc
	adc #$14
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$c7;keep
	bcc CheckEnemyShieldContact_edblock13821
CheckEnemyShieldContact_localsuccess13823: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc cesc_row_offset
	 ; end add / sub var with constant
	; Compare with pure num / var optimization
	cmp #$c9;keep
	bcs CheckEnemyShieldContact_edblock13821
CheckEnemyShieldContact_ctb13819: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta cr_row
	lda cesc_row_offset
	; Calling storevariable on generic assign expression
	sta cr_row_offset
	jsr CESC_CheckRow
CheckEnemyShieldContact_edblock13821
CheckEnemyShieldContact_edblock13808
	asl $d019
	cli
CheckEnemyShieldContact_edblock13727
CheckEnemyShieldContact_edblock13619
	rts
end_procedure_CheckEnemyShieldContact
	
; // CheckEnemyShieldContact
; // ---------------------------------------------------------------------------
; // CheckEnemyShieldCollision
; //   Checks all 3 enemy bullet slots against the 4 shields.
; //   Enemy bullets travel downward so they erode from the top (dir=1).
; //   On hit: bullet transitions to explode state; erosion queued for
; //   ApplyShieldErosion to drain next frame (if no prior erosion pending).
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CheckEnemyShieldCollision
	;    Procedure type : User-defined procedure
esc_i	dc.b	0
esc_byte_col	dc.b	0
esc_col_idx	dc.b	0
esc_hit_row	dc.b	0
CheckEnemyShieldCollision_block13825
CheckEnemyShieldCollision
	; Binary clause Simplified: EQUALS
	clc
	lda pending_shield_erosion
	; cmp #$00 ignored
	bne CheckEnemyShieldCollision_localfailed19214
	jmp CheckEnemyShieldCollision_ctb13827
CheckEnemyShieldCollision_localfailed19214
	jmp CheckEnemyShieldCollision_edblock13829
CheckEnemyShieldCollision_ctb13827: ;Main true block ;keep 
	
; // bullet slot 0-2
; // (bullet_x - shield_base) >> 3
; // shield_idx*3 + byte_col
; // surface cache result; 255 = fully eroded
	lda #$0
	; Calling storevariable on generic assign expression
	sta esc_i
CheckEnemyShieldCollision_while19216
CheckEnemyShieldCollision_loopstart19220
	; Binary clause Simplified: LESS
	lda esc_i
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs CheckEnemyShieldCollision_localfailed21910
	jmp CheckEnemyShieldCollision_ctb19217
CheckEnemyShieldCollision_localfailed21910
	jmp CheckEnemyShieldCollision_edblock19219
CheckEnemyShieldCollision_ctb19217: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_active,x 
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CheckEnemyShieldCollision_localfailed23257
	jmp CheckEnemyShieldCollision_ctb21913
CheckEnemyShieldCollision_localfailed23257
	jmp CheckEnemyShieldCollision_edblock21915
CheckEnemyShieldCollision_ctb21913: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_y,x 
	; Compare with pure num / var optimization
	cmp #$b9;keep
	bcc CheckEnemyShieldCollision_localfailed23930
CheckEnemyShieldCollision_localsuccess23931: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_y,x 
	; Compare with pure num / var optimization
	cmp #$c9;keep
	bcs CheckEnemyShieldCollision_localfailed23930
	jmp CheckEnemyShieldCollision_ctb23260
CheckEnemyShieldCollision_localfailed23930
	jmp CheckEnemyShieldCollision_edblock23262
CheckEnemyShieldCollision_ctb23260: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_x,x 
	; Compare with pure num / var optimization
	cmp #$2d;keep
	bcc CheckEnemyShieldCollision_localfailed24267
CheckEnemyShieldCollision_localsuccess24268: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_x,x 
	; Compare with pure num / var optimization
	cmp #$45;keep
	bcs CheckEnemyShieldCollision_localfailed24267
	jmp CheckEnemyShieldCollision_ctb23934
CheckEnemyShieldCollision_localfailed24267
	jmp CheckEnemyShieldCollision_eblock23935
CheckEnemyShieldCollision_ctb23934: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda shield_top_eroded +$0 ; array with const index optimization 
	; cmp #$00 ignored
	bne CheckEnemyShieldCollision_edblock24273
CheckEnemyShieldCollision_ctb24271: ;Main true block ;keep 
	
; // Y check first — bullets spend most travel outside the shield band.
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_x,x 
	sec
	sbc #$2d
	 ; end add / sub var with constant
	lsr
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta esc_byte_col
	; Calling storevariable on generic assign expression
	sta esc_col_idx
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx esc_col_idx
	lda shield_surface_bot,x 
	; Calling storevariable on generic assign expression
	sta esc_hit_row
	; Binary clause Simplified: NOTEQUALS
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CheckEnemyShieldCollision_edblock24285
CheckEnemyShieldCollision_ctb24283: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	lda #$0
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	lda esc_byte_col
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	lda esc_hit_row
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	lda #$2
	; Calling storevariable on generic assign expression
	ldx esc_i ; optimized, look out for bugs
	sta ufo_bullet_active,x
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_bullet_explode_counter,x
CheckEnemyShieldCollision_edblock24285
CheckEnemyShieldCollision_edblock24273
	jmp CheckEnemyShieldCollision_edblock23936
CheckEnemyShieldCollision_eblock23935
	; Binary clause Simplified: GREATEREQUAL
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_x,x 
	; Compare with pure num / var optimization
	cmp #$5d;keep
	bcc CheckEnemyShieldCollision_localfailed24445
CheckEnemyShieldCollision_localsuccess24446: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_x,x 
	; Compare with pure num / var optimization
	cmp #$75;keep
	bcs CheckEnemyShieldCollision_localfailed24445
	jmp CheckEnemyShieldCollision_ctb24290
CheckEnemyShieldCollision_localfailed24445
	jmp CheckEnemyShieldCollision_eblock24291
CheckEnemyShieldCollision_ctb24290: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda shield_top_eroded +$1 ; array with const index optimization 
	; cmp #$00 ignored
	bne CheckEnemyShieldCollision_edblock24451
CheckEnemyShieldCollision_ctb24449: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_x,x 
	sec
	sbc #$5d
	 ; end add / sub var with constant
	lsr
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta esc_byte_col
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$3
	clc
	adc esc_byte_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta esc_col_idx
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx esc_col_idx
	lda shield_surface_bot,x 
	; Calling storevariable on generic assign expression
	sta esc_hit_row
	; Binary clause Simplified: NOTEQUALS
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CheckEnemyShieldCollision_edblock24463
CheckEnemyShieldCollision_ctb24461: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	lda esc_byte_col
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	lda esc_hit_row
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	lda #$2
	; Calling storevariable on generic assign expression
	ldx esc_i ; optimized, look out for bugs
	sta ufo_bullet_active,x
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_bullet_explode_counter,x
CheckEnemyShieldCollision_edblock24463
CheckEnemyShieldCollision_edblock24451
	jmp CheckEnemyShieldCollision_edblock24292
CheckEnemyShieldCollision_eblock24291
	; Binary clause Simplified: GREATEREQUAL
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_x,x 
	; Compare with pure num / var optimization
	cmp #$8d;keep
	bcc CheckEnemyShieldCollision_localfailed24534
CheckEnemyShieldCollision_localsuccess24535: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_x,x 
	; Compare with pure num / var optimization
	cmp #$a5;keep
	bcs CheckEnemyShieldCollision_localfailed24534
	jmp CheckEnemyShieldCollision_ctb24468
CheckEnemyShieldCollision_localfailed24534
	jmp CheckEnemyShieldCollision_eblock24469
CheckEnemyShieldCollision_ctb24468: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda shield_top_eroded +$2 ; array with const index optimization 
	; cmp #$00 ignored
	bne CheckEnemyShieldCollision_edblock24540
CheckEnemyShieldCollision_ctb24538: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_x,x 
	sec
	sbc #$8d
	 ; end add / sub var with constant
	lsr
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta esc_byte_col
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$6
	clc
	adc esc_byte_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta esc_col_idx
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx esc_col_idx
	lda shield_surface_bot,x 
	; Calling storevariable on generic assign expression
	sta esc_hit_row
	; Binary clause Simplified: NOTEQUALS
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CheckEnemyShieldCollision_edblock24552
CheckEnemyShieldCollision_ctb24550: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	lda #$2
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	lda esc_byte_col
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	lda esc_hit_row
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	lda #$2
	; Calling storevariable on generic assign expression
	ldx esc_i ; optimized, look out for bugs
	sta ufo_bullet_active,x
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_bullet_explode_counter,x
CheckEnemyShieldCollision_edblock24552
CheckEnemyShieldCollision_edblock24540
	jmp CheckEnemyShieldCollision_edblock24470
CheckEnemyShieldCollision_eblock24469
	; Binary clause Simplified: GREATEREQUAL
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_x,x 
	; Compare with pure num / var optimization
	cmp #$bd;keep
	bcc CheckEnemyShieldCollision_edblock24559
CheckEnemyShieldCollision_localsuccess24579: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_x,x 
	; Compare with pure num / var optimization
	cmp #$d5;keep
	bcs CheckEnemyShieldCollision_edblock24559
CheckEnemyShieldCollision_ctb24557: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda shield_top_eroded +$3 ; array with const index optimization 
	; cmp #$00 ignored
	bne CheckEnemyShieldCollision_edblock24584
CheckEnemyShieldCollision_ctb24582: ;Main true block ;keep 
	; 8 bit binop
	; Add/sub where right value is constant number
	; Load Byte array
	; CAST type NADA
	ldx esc_i
	lda ufo_bullet_x,x 
	sec
	sbc #$bd
	 ; end add / sub var with constant
	lsr
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta esc_byte_col
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$9
	clc
	adc esc_byte_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta esc_col_idx
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx esc_col_idx
	lda shield_surface_bot,x 
	; Calling storevariable on generic assign expression
	sta esc_hit_row
	; Binary clause Simplified: NOTEQUALS
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CheckEnemyShieldCollision_edblock24596
CheckEnemyShieldCollision_ctb24594: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	lda #$3
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	lda esc_byte_col
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	lda esc_hit_row
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	lda #$2
	; Calling storevariable on generic assign expression
	ldx esc_i ; optimized, look out for bugs
	sta ufo_bullet_active,x
	lda #$0
	; Calling storevariable on generic assign expression
	sta ufo_bullet_explode_counter,x
CheckEnemyShieldCollision_edblock24596
CheckEnemyShieldCollision_edblock24584
CheckEnemyShieldCollision_edblock24559
CheckEnemyShieldCollision_edblock24470
CheckEnemyShieldCollision_edblock24292
CheckEnemyShieldCollision_edblock23936
CheckEnemyShieldCollision_edblock23262
CheckEnemyShieldCollision_edblock21915
	; Test Inc dec D
	inc esc_i
	jmp CheckEnemyShieldCollision_while19216
CheckEnemyShieldCollision_edblock19219
CheckEnemyShieldCollision_loopend19221
CheckEnemyShieldCollision_edblock13829
	rts
end_procedure_CheckEnemyShieldCollision
	
; // ---------------------------------------------------------------------------
; // CheckShieldCollision - DETECTION PHASE ONLY (fast)
; //   Just detects collision and queues erosion work for later application.
; //   Nested inside MainRasterPlayer — sole caller.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CheckShieldCollision
	;    Procedure type : User-defined procedure
csc_byte_col	dc.b	0
csc_col_idx	dc.b	0
csc_hit_row	dc.b	0
CheckShieldCollision_block24599
CheckShieldCollision
	; Binary clause Simplified: EQUALS
	clc
	lda pending_shield_erosion
	; cmp #$00 ignored
	bne CheckShieldCollision_localfailed25852
	jmp CheckShieldCollision_ctb24601
CheckShieldCollision_localfailed25852
	jmp CheckShieldCollision_edblock24603
CheckShieldCollision_ctb24601: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne CheckShieldCollision_localfailed26479
	jmp CheckShieldCollision_ctb25855
CheckShieldCollision_localfailed26479
	jmp CheckShieldCollision_edblock25857
CheckShieldCollision_ctb25855: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	lda player_bullet_y
	; Compare with pure num / var optimization
	cmp #$b9;keep
	bcc CheckShieldCollision_localfailed26792
CheckShieldCollision_localsuccess26793: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	lda player_bullet_y
	; Compare with pure num / var optimization
	cmp #$c9;keep
	bcs CheckShieldCollision_localfailed26792
	jmp CheckShieldCollision_ctb26482
CheckShieldCollision_localfailed26792
	jmp CheckShieldCollision_edblock26484
CheckShieldCollision_ctb26482: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	lda player_bullet_x
	; Compare with pure num / var optimization
	cmp #$2d;keep
	bcc CheckShieldCollision_localfailed26949
CheckShieldCollision_localsuccess26950: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	lda player_bullet_x
	; Compare with pure num / var optimization
	cmp #$45;keep
	bcs CheckShieldCollision_localfailed26949
	jmp CheckShieldCollision_ctb26796
CheckShieldCollision_localfailed26949
	jmp CheckShieldCollision_eblock26797
CheckShieldCollision_ctb26796: ;Main true block ;keep 
	
; // (bullet_x - shield_base) >> 3
; // shield_idx*3 + byte_col (index into surface cache)
; // surface cache result; 255 = fully eroded
; // Y check ONCE at the top — bullet spends most of its travel above the
; // shield band, so this bails out cheaply before any X work is done.
; // Determine which shield to check based on X position (only one can match).
; // csc_byte_col: byte column within the shield sprite (0-2).
; // csc_hit_row: scan result (0-15 = surface row, 254 = fully eroded).
; // Shield 1
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_x
	sec
	sbc #$2d
	 ; end add / sub var with constant
	lsr
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta csc_byte_col
	; Calling storevariable on generic assign expression
	sta csc_col_idx
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx csc_col_idx
	lda shield_surface_top,x 
	; Calling storevariable on generic assign expression
	sta csc_hit_row
	; Binary clause Simplified: NOTEQUALS
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CheckShieldCollision_edblock26955
CheckShieldCollision_ctb26953: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	lda #$0
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	lda csc_byte_col
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	lda csc_hit_row
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	lda #$3
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	lda #$0
	; Calling storevariable on generic assign expression
	sta explosion_frame_counter
CheckShieldCollision_edblock26955
	jmp CheckShieldCollision_edblock26798
CheckShieldCollision_eblock26797
	; Binary clause Simplified: GREATEREQUAL
	lda player_bullet_x
	; Compare with pure num / var optimization
	cmp #$5d;keep
	bcc CheckShieldCollision_localfailed27031
CheckShieldCollision_localsuccess27032: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	lda player_bullet_x
	; Compare with pure num / var optimization
	cmp #$75;keep
	bcs CheckShieldCollision_localfailed27031
	jmp CheckShieldCollision_ctb26960
CheckShieldCollision_localfailed27031
	jmp CheckShieldCollision_eblock26961
CheckShieldCollision_ctb26960: ;Main true block ;keep 
	
; // Shield 2
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_x
	sec
	sbc #$5d
	 ; end add / sub var with constant
	lsr
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta csc_byte_col
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$3
	clc
	adc csc_byte_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta csc_col_idx
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx csc_col_idx
	lda shield_surface_top,x 
	; Calling storevariable on generic assign expression
	sta csc_hit_row
	; Binary clause Simplified: NOTEQUALS
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CheckShieldCollision_edblock27037
CheckShieldCollision_ctb27035: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	lda #$0
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	lda csc_byte_col
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	lda csc_hit_row
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	lda #$3
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	lda #$0
	; Calling storevariable on generic assign expression
	sta explosion_frame_counter
CheckShieldCollision_edblock27037
	jmp CheckShieldCollision_edblock26962
CheckShieldCollision_eblock26961
	; Binary clause Simplified: GREATEREQUAL
	lda player_bullet_x
	; Compare with pure num / var optimization
	cmp #$8d;keep
	bcc CheckShieldCollision_localfailed27072
CheckShieldCollision_localsuccess27073: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	lda player_bullet_x
	; Compare with pure num / var optimization
	cmp #$a5;keep
	bcs CheckShieldCollision_localfailed27072
	jmp CheckShieldCollision_ctb27042
CheckShieldCollision_localfailed27072
	jmp CheckShieldCollision_eblock27043
CheckShieldCollision_ctb27042: ;Main true block ;keep 
	
; // Shield 3
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_x
	sec
	sbc #$8d
	 ; end add / sub var with constant
	lsr
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta csc_byte_col
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$6
	clc
	adc csc_byte_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta csc_col_idx
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx csc_col_idx
	lda shield_surface_top,x 
	; Calling storevariable on generic assign expression
	sta csc_hit_row
	; Binary clause Simplified: NOTEQUALS
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CheckShieldCollision_edblock27078
CheckShieldCollision_ctb27076: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	lda #$0
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	lda #$2
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	lda csc_byte_col
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	lda csc_hit_row
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	lda #$3
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	lda #$0
	; Calling storevariable on generic assign expression
	sta explosion_frame_counter
CheckShieldCollision_edblock27078
	jmp CheckShieldCollision_edblock27044
CheckShieldCollision_eblock27043
	; Binary clause Simplified: GREATEREQUAL
	lda player_bullet_x
	; Compare with pure num / var optimization
	cmp #$bd;keep
	bcc CheckShieldCollision_edblock27085
CheckShieldCollision_localsuccess27093: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: LESS
	lda player_bullet_x
	; Compare with pure num / var optimization
	cmp #$d5;keep
	bcs CheckShieldCollision_edblock27085
CheckShieldCollision_ctb27083: ;Main true block ;keep 
	
; // Shield 4
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_bullet_x
	sec
	sbc #$bd
	 ; end add / sub var with constant
	lsr
	lsr
	lsr
	; Calling storevariable on generic assign expression
	sta csc_byte_col
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$9
	clc
	adc csc_byte_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta csc_col_idx
	; Load Byte array
	; CAST type NADA
	tax ; optimized x, look out for bugs L22 ORG 	ldx csc_col_idx
	lda shield_surface_top,x 
	; Calling storevariable on generic assign expression
	sta csc_hit_row
	; Binary clause Simplified: NOTEQUALS
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq CheckShieldCollision_edblock27098
CheckShieldCollision_ctb27096: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	lda #$0
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	lda #$3
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	lda csc_byte_col
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	lda csc_hit_row
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	lda #$3
	; Calling storevariable on generic assign expression
	sta player_bullet_active
	lda #$0
	; Calling storevariable on generic assign expression
	sta explosion_frame_counter
CheckShieldCollision_edblock27098
CheckShieldCollision_edblock27085
CheckShieldCollision_edblock27044
CheckShieldCollision_edblock26962
CheckShieldCollision_edblock26798
CheckShieldCollision_edblock26484
CheckShieldCollision_edblock25857
CheckShieldCollision_edblock24603
	rts
end_procedure_CheckShieldCollision
	
; // ---------------------------------------------------------------------------
; // ApplyShieldErosion - EROSION PHASE
; //   AND-NOTs the stencil directly into charset bytes and advances the surface
; //   caches deterministically.  Nested inside MainRasterChain — sole caller.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ApplyShieldErosion
	;    Procedure type : User-defined procedure
ase_charset_base	dc.w	0
ase_charset_addr	dc.w	0
ase_chr_ptr	= $22
ase_row	dc.b	0
ase_stencil	dc.b	0
ase_bc_off	dc.b	0
ase_row_adj	dc.b	0
ase_i	dc.b	0
ase_col_idx	dc.b	0
ase_new_surface	dc.b	0
ApplyShieldErosion_block27101
ApplyShieldErosion
	; Binary clause Simplified: EQUALS
	lda pending_shield_erosion
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne ApplyShieldErosion_localfailed27673
	jmp ApplyShieldErosion_ctb27103
ApplyShieldErosion_localfailed27673
	jmp ApplyShieldErosion_edblock27105
ApplyShieldErosion_ctb27103: ;Main true block ;keep 
	
; // pending_byte_col * 8
; // ase_row - 8 for bottom charset band
; // pending_shield_idx*3 + pending_byte_col
	; Load Integer array
	; CAST type INTEGER
	lda pending_shield_idx
	asl
	tax
	lda SHIELD_DST,x 
	ldy SHIELD_DST+1,x 
	; Calling storevariable on generic assign expression
	sta ase_charset_base
	sty ase_charset_base+1
	lda pending_byte_col
	asl
	asl
	asl
	; Calling storevariable on generic assign expression
	sta ase_bc_off
	lda pending_erase_top
	; Calling storevariable on generic assign expression
	sta ase_row
	lda #$0
	; Calling storevariable on generic assign expression
	sta ase_i
ApplyShieldErosion_while27675
ApplyShieldErosion_loopstart27679
	; Binary clause Simplified: LESS
	lda ase_i
	; Compare with pure num / var optimization
	cmp #$4;keep
	bcs ApplyShieldErosion_localfailed27780
	jmp ApplyShieldErosion_ctb27676
ApplyShieldErosion_localfailed27780
	jmp ApplyShieldErosion_edblock27678
ApplyShieldErosion_ctb27676: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda ase_i
	; cmp #$00 ignored
	bne ApplyShieldErosion_edblock27785
ApplyShieldErosion_ctb27783: ;Main true block ;keep 
	lda #$ff
	; Calling storevariable on generic assign expression
	sta ase_stencil
ApplyShieldErosion_edblock27785
	; Binary clause Simplified: EQUALS
	lda ase_i
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne ApplyShieldErosion_edblock27791
ApplyShieldErosion_ctb27789: ;Main true block ;keep 
	lda #$ff
	; Calling storevariable on generic assign expression
	sta ase_stencil
ApplyShieldErosion_edblock27791
	; Binary clause Simplified: EQUALS
	lda ase_i
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne ApplyShieldErosion_edblock27797
ApplyShieldErosion_ctb27795: ;Main true block ;keep 
	lda #$3c
	; Calling storevariable on generic assign expression
	sta ase_stencil
ApplyShieldErosion_edblock27797
	; Binary clause Simplified: EQUALS
	lda ase_i
	; Compare with pure num / var optimization
	cmp #$3;keep
	bne ApplyShieldErosion_edblock27803
ApplyShieldErosion_ctb27801: ;Main true block ;keep 
	lda #$18
	; Calling storevariable on generic assign expression
	sta ase_stencil
ApplyShieldErosion_edblock27803
	; Binary clause Simplified: LESS
	lda ase_row
	; Compare with pure num / var optimization
	cmp #$8;keep
	bcs ApplyShieldErosion_localfailed27824
	jmp ApplyShieldErosion_ctb27807
ApplyShieldErosion_localfailed27824
	jmp ApplyShieldErosion_eblock27808
ApplyShieldErosion_ctb27807: ;Main true block ;keep 
	
; // AND-NOT stencil directly into the charset byte (no sprite round-trip)
; // Rows 0-7:  SHIELD_DST[s] + bc*8 + row
; // Rows 8-15: SHIELD_DST[s] + 24 + bc*8 + (row-8)
	; Generic 16 bit op
	ldy #0
	lda ase_row
ApplyShieldErosion_rightvarInteger_var27828 = $54
	sta ApplyShieldErosion_rightvarInteger_var27828
	sty ApplyShieldErosion_rightvarInteger_var27828+1
	; HandleVarBinopB16bit
	; RHS is pure, optimization
	ldy ase_charset_base+1 ;keep
	lda ase_charset_base
	clc
	adc ase_bc_off
	; Testing for byte:  #0
	; RHS is byte, optimization
	bcc ApplyShieldErosion_skip27830
	iny
ApplyShieldErosion_skip27830
	; Low bit binop:
	clc
	adc ApplyShieldErosion_rightvarInteger_var27828
ApplyShieldErosion_wordAdd27826
	sta ApplyShieldErosion_rightvarInteger_var27828
	; High-bit binop
	tya
	adc ApplyShieldErosion_rightvarInteger_var27828+1
	tay
	lda ApplyShieldErosion_rightvarInteger_var27828
	; Calling storevariable on generic assign expression
	sta ase_charset_addr
	sty ase_charset_addr+1
	jmp ApplyShieldErosion_edblock27809
ApplyShieldErosion_eblock27808
	; Optimizer: a = a +/- b
	; Load16bitvariable : ase_row
	lda ase_row
	sec
	sbc #$8
	sta ase_row_adj
	; Generic 16 bit op
	ldy #0
ApplyShieldErosion_rightvarInteger_var27834 = $54
	sta ApplyShieldErosion_rightvarInteger_var27834
	sty ApplyShieldErosion_rightvarInteger_var27834+1
	; Generic 16 bit op
	ldy #0
	lda ase_bc_off
ApplyShieldErosion_rightvarInteger_var27837 = $56
	sta ApplyShieldErosion_rightvarInteger_var27837
	sty ApplyShieldErosion_rightvarInteger_var27837+1
	; HandleVarBinopB16bit
	; RHS is pure, optimization
	ldy ase_charset_base+1 ;keep
	lda ase_charset_base
	clc
	adc #$18
	; Testing for byte:  #$00
	; RHS is word, no optimization
	pha 
	tya 
	adc #$00
	tay 
	pla 
	; Low bit binop:
	clc
	adc ApplyShieldErosion_rightvarInteger_var27837
ApplyShieldErosion_wordAdd27835
	sta ApplyShieldErosion_rightvarInteger_var27837
	; High-bit binop
	tya
	adc ApplyShieldErosion_rightvarInteger_var27837+1
	tay
	lda ApplyShieldErosion_rightvarInteger_var27837
	; Low bit binop:
	clc
	adc ApplyShieldErosion_rightvarInteger_var27834
ApplyShieldErosion_wordAdd27832
	sta ApplyShieldErosion_rightvarInteger_var27834
	; High-bit binop
	tya
	adc ApplyShieldErosion_rightvarInteger_var27834+1
	tay
	lda ApplyShieldErosion_rightvarInteger_var27834
	; Calling storevariable on generic assign expression
	sta ase_charset_addr
	sty ase_charset_addr+1
ApplyShieldErosion_edblock27809
	lda ase_charset_addr
	ldx ase_charset_addr+1
	sta ase_chr_ptr
	stx ase_chr_ptr+1
	; 8 bit binop
	; Add/sub right value is variable/expression
	; 8 bit binop
	; Add/sub where right value is constant number
	lda ase_stencil
	eor #$ff
	 ; end add / sub var with constant
ApplyShieldErosion_rightvarAddSub_var27839 = $54
	sta ApplyShieldErosion_rightvarAddSub_var27839
	; Load pointer array
	ldy #$0
	lda (ase_chr_ptr),y
	and ApplyShieldErosion_rightvarAddSub_var27839
	; Calling storevariable on generic assign expression
	; Storing to a pointer
	sta (ase_chr_ptr),y
	; Binary clause Simplified: EQUALS
	clc
	lda pending_erosion_dir
	; cmp #$00 ignored
	bne ApplyShieldErosion_eblock27842
ApplyShieldErosion_ctb27841: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda ase_row
	; cmp #$00 ignored
	bne ApplyShieldErosion_eblock27865
ApplyShieldErosion_ctb27864: ;Main true block ;keep 
	
; // Advance row inward; clamp at boundary
	lda #$4
	; Calling storevariable on generic assign expression
	sta ase_i
	jmp ApplyShieldErosion_edblock27866
ApplyShieldErosion_eblock27865
	; Test Inc dec D
	dec ase_row
ApplyShieldErosion_edblock27866
	jmp ApplyShieldErosion_edblock27843
ApplyShieldErosion_eblock27842
	; Binary clause Simplified: GREATEREQUAL
	lda ase_row
	; Compare with pure num / var optimization
	cmp #$f;keep
	bcc ApplyShieldErosion_eblock27874
ApplyShieldErosion_ctb27873: ;Main true block ;keep 
	lda #$4
	; Calling storevariable on generic assign expression
	sta ase_i
	jmp ApplyShieldErosion_edblock27875
ApplyShieldErosion_eblock27874
	; Test Inc dec D
	inc ase_row
ApplyShieldErosion_edblock27875
ApplyShieldErosion_edblock27843
	; Test Inc dec D
	inc ase_i
	jmp ApplyShieldErosion_while27675
ApplyShieldErosion_edblock27678
ApplyShieldErosion_loopend27680
	
; // Update caches deterministically: stencils 0+1 are $FF so surface
; // always advances by exactly 2 rows — no pixel rescan needed.
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda pending_shield_idx
	clc
	adc pending_shield_idx
	 ; end add / sub var with constant
	clc
	adc pending_shield_idx
	 ; end add / sub var with constant
	clc
	adc pending_byte_col
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta ase_col_idx
	; Binary clause Simplified: EQUALS
	clc
	lda pending_erosion_dir
	; cmp #$00 ignored
	bne ApplyShieldErosion_localfailed28062
	jmp ApplyShieldErosion_ctb27881
ApplyShieldErosion_localfailed28062
	jmp ApplyShieldErosion_eblock27882
ApplyShieldErosion_ctb27881: ;Main true block ;keep 
	; Binary clause Simplified: LESS
	lda pending_erase_top
	; Compare with pure num / var optimization
	cmp #$2;keep
	bcs ApplyShieldErosion_eblock28066
ApplyShieldErosion_ctb28065: ;Main true block ;keep 
	
; // Player bullet (bottom-up): surface moves toward row 0
	lda #$ff
	; Calling storevariable on generic assign expression
	sta ase_new_surface
	jmp ApplyShieldErosion_edblock28067
ApplyShieldErosion_eblock28066
	; Optimizer: a = a +/- b
	; Load16bitvariable : pending_erase_top
	lda pending_erase_top
	sec
	sbc #$2
	sta ase_new_surface
ApplyShieldErosion_edblock28067
	; Binary clause Simplified: NOTEQUALS
	lda ase_new_surface
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq ApplyShieldErosion_edblock28075
ApplyShieldErosion_ctb28073: ;Main true block ;keep 
	; Binary clause Simplified: GREATER
	; Load Byte array
	; CAST type NADA
	ldx ase_col_idx
	lda shield_surface_bot,x 
	; Compare with pure num / var optimization
	cmp ase_new_surface;keep
	bcc ApplyShieldErosion_edblock28087
	beq ApplyShieldErosion_edblock28087
ApplyShieldErosion_ctb28085: ;Main true block ;keep 
	
; // Cross-check: if the updated bottom surface is now above the enemy's top
; // surface, the two erosion fronts have met — column is fully tunnelled.
	lda #$ff
	; Calling storevariable on generic assign expression
	sta ase_new_surface
ApplyShieldErosion_edblock28087
ApplyShieldErosion_edblock28075
	lda ase_new_surface
	; Calling storevariable on generic assign expression
	ldx ase_col_idx ; optimized, look out for bugs
	sta shield_surface_top,x
	; Binary clause Simplified: EQUALS
	; Compare with pure num / var optimization
	cmp #$ff;keep
	bne ApplyShieldErosion_edblock28093
ApplyShieldErosion_ctb28091: ;Main true block ;keep 
	lda #$ff
	; Calling storevariable on generic assign expression
	ldx ase_col_idx ; optimized, look out for bugs
	sta shield_surface_bot,x
ApplyShieldErosion_edblock28093
	jmp ApplyShieldErosion_edblock27883
ApplyShieldErosion_eblock27882
	; Binary clause Simplified: GREATEREQUAL
	lda pending_erase_top
	; Compare with pure num / var optimization
	cmp #$e;keep
	bcc ApplyShieldErosion_eblock28099
ApplyShieldErosion_ctb28098: ;Main true block ;keep 
	
; // Enemy bullet (top-down): surface moves toward row 15
	lda #$ff
	; Calling storevariable on generic assign expression
	sta ase_new_surface
	jmp ApplyShieldErosion_edblock28100
ApplyShieldErosion_eblock28099
	; Optimizer: a = a +/- b
	; Load16bitvariable : pending_erase_top
	lda pending_erase_top
	clc
	adc #$2
	sta ase_new_surface
ApplyShieldErosion_edblock28100
	; Binary clause Simplified: NOTEQUALS
	lda ase_new_surface
	; Compare with pure num / var optimization
	cmp #$ff;keep
	beq ApplyShieldErosion_edblock28108
ApplyShieldErosion_ctb28106: ;Main true block ;keep 
	; Binary clause Simplified: LESS
	; Load Byte array
	; CAST type NADA
	ldx ase_col_idx
	lda shield_surface_top,x 
	; Compare with pure num / var optimization
	cmp ase_new_surface;keep
	bcs ApplyShieldErosion_edblock28120
ApplyShieldErosion_ctb28118: ;Main true block ;keep 
	
; // Cross-check: if the updated top surface is now below the player's bottom
; // surface, the two erosion fronts have met — column is fully tunnelled.
	lda #$ff
	; Calling storevariable on generic assign expression
	sta ase_new_surface
ApplyShieldErosion_edblock28120
ApplyShieldErosion_edblock28108
	lda ase_new_surface
	; Calling storevariable on generic assign expression
	ldx ase_col_idx ; optimized, look out for bugs
	sta shield_surface_bot,x
	; Binary clause Simplified: EQUALS
	; Compare with pure num / var optimization
	cmp #$ff;keep
	bne ApplyShieldErosion_edblock28126
ApplyShieldErosion_ctb28124: ;Main true block ;keep 
	lda #$ff
	; Calling storevariable on generic assign expression
	ldx ase_col_idx ; optimized, look out for bugs
	sta shield_surface_top,x
	; Binary clause Simplified: EQUALS
	; Load Byte array
	; CAST type NADA
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx pending_shield_idx ; optimized, look out for bugs
	; Load right hand side
	lda #$3
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	tax
	lda shield_surface_bot,x 
	; Compare with pure num / var optimization
	cmp #$ff;keep
	bne ApplyShieldErosion_edblock28188
ApplyShieldErosion_ctb28186: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	; Load Byte array
	; CAST type NADA
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx pending_shield_idx ; optimized, look out for bugs
	; Load right hand side
	lda #$3
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc #$1
	 ; end add / sub var with constant
	tax
	lda shield_surface_bot,x 
	; Compare with pure num / var optimization
	cmp #$ff;keep
	bne ApplyShieldErosion_edblock28220
ApplyShieldErosion_ctb28218: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	; Load Byte array
	; CAST type NADA
	; 8 bit binop
	; Add/sub where right value is constant number
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx pending_shield_idx ; optimized, look out for bugs
	; Load right hand side
	lda #$3
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
	clc
	adc #$2
	 ; end add / sub var with constant
	tax
	lda shield_surface_bot,x 
	; Compare with pure num / var optimization
	cmp #$ff;keep
	bne ApplyShieldErosion_edblock28236
ApplyShieldErosion_ctb28234: ;Main true block ;keep 
	
; // If all 3 columns of this shield are now fully tunnelled from the top,
; // raise the skip flag so both bullet and contact checks bypass it entirely.
	lda #$1
	; Calling storevariable on generic assign expression
	ldx pending_shield_idx ; optimized, look out for bugs
	sta shield_top_eroded,x
ApplyShieldErosion_edblock28236
ApplyShieldErosion_edblock28220
ApplyShieldErosion_edblock28188
ApplyShieldErosion_edblock28126
ApplyShieldErosion_edblock27883
	lda #$0
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
ApplyShieldErosion_edblock27105
	rts
end_procedure_ApplyShieldErosion
	
; // ---------------------------------------------------------------------------
; //   Copies the pristine shield sprite (17 at $2440) to 4 shield charset ranges.
; //   IRQ-SAFE rewrite:
; //     Glyph copy (4 shields × 48 bytes): inline ASM, no ZP touched.
; //       Template stride-3 bytes are first staged into shield_glyph_stage[0..47]
; //       using explicit absolute lda/sta pairs, then copied to all 4 shield
; //       charset destinations with 4 indexed ldx/lda/sta/dex/bpl loops.
; //     Surface scan (≤ 32 iters × 3 cols): wrapped in PreventIRQ/EnableIRQ.
; //       css_scan_ptr still uses ZP $24 — critical section is short.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CopyShieldSprites
	;    Procedure type : User-defined procedure
css_scan_addr	dc.w	0
css_scan_ptr	= $22
css_row	dc.b	0
css_bc	dc.b	0
css_found	dc.b	0
CopyShieldSprites_block28241
CopyShieldSprites
        lda $2440
        sta shield_glyph_stage+0
        lda $2443
        sta shield_glyph_stage+1
        lda $2446
        sta shield_glyph_stage+2
        lda $2449
        sta shield_glyph_stage+3
        lda $244C
        sta shield_glyph_stage+4
        lda $244F
        sta shield_glyph_stage+5
        lda $2452
        sta shield_glyph_stage+6
        lda $2455
        sta shield_glyph_stage+7
        lda $2441
        sta shield_glyph_stage+8
        lda $2444
        sta shield_glyph_stage+9
        lda $2447
        sta shield_glyph_stage+10
        lda $244A
        sta shield_glyph_stage+11
        lda $244D
        sta shield_glyph_stage+12
        lda $2450
        sta shield_glyph_stage+13
        lda $2453
        sta shield_glyph_stage+14
        lda $2456
        sta shield_glyph_stage+15
        lda $2442
        sta shield_glyph_stage+16
        lda $2445
        sta shield_glyph_stage+17
        lda $2448
        sta shield_glyph_stage+18
        lda $244B
        sta shield_glyph_stage+19
        lda $244E
        sta shield_glyph_stage+20
        lda $2451
        sta shield_glyph_stage+21
        lda $2454
        sta shield_glyph_stage+22
        lda $2457
        sta shield_glyph_stage+23
        lda $2458
        sta shield_glyph_stage+24
        lda $245B
        sta shield_glyph_stage+25
        lda $245E
        sta shield_glyph_stage+26
        lda $2461
        sta shield_glyph_stage+27
        lda $2464
        sta shield_glyph_stage+28
        lda $2467
        sta shield_glyph_stage+29
        lda $246A
        sta shield_glyph_stage+30
        lda $246D
        sta shield_glyph_stage+31
        lda $2459
        sta shield_glyph_stage+32
        lda $245C
        sta shield_glyph_stage+33
        lda $245F
        sta shield_glyph_stage+34
        lda $2462
        sta shield_glyph_stage+35
        lda $2465
        sta shield_glyph_stage+36
        lda $2468
        sta shield_glyph_stage+37
        lda $246B
        sta shield_glyph_stage+38
        lda $246E
        sta shield_glyph_stage+39
        lda $245A
        sta shield_glyph_stage+40
        lda $245D
        sta shield_glyph_stage+41
        lda $2460
        sta shield_glyph_stage+42
        lda $2463
        sta shield_glyph_stage+43
        lda $2466
        sta shield_glyph_stage+44
        lda $2469
        sta shield_glyph_stage+45
        lda $246C
        sta shield_glyph_stage+46
        lda $246F
        sta shield_glyph_stage+47
        ldx #47
csg_s0  lda shield_glyph_stage,x
        sta $3380,x
        dex
        bpl csg_s0
        ldx #47
csg_s1  lda shield_glyph_stage,x
        sta $33B0,x
        dex
        bpl csg_s1
        ldx #47
csg_s2  lda shield_glyph_stage,x
        sta $33E0,x
        dex
        bpl csg_s2
        ldx #47
csg_s3  lda shield_glyph_stage,x
        sta $3410,x
        dex
        bpl csg_s3
	
	
; // sprite 17 (pristine, read-only)
; // ── Glyph copy: linearise 48 stride-3 template bytes into stage, ───────
; // then blast stage to each shield destination with a single indexed loop.
; // Template layout: 3 bytes/row × 16 rows starting at $2440.
; // Stage layout: [0-7] col0 top, [8-15] col1 top, [16-23] col2 top,
; //               [24-31] col0 bot, [32-39] col1 bot, [40-47] col2 bot.
; // ── Surface scan: css_scan_ptr uses ZP $24 — protect with PreventIRQ ────
	sei
	
; // Scan the template once per column (all shields identical at startup).
; // Replicate each result to the 4 shields' cache slots.
	lda #$0
	; Calling storevariable on generic assign expression
	sta css_bc
CopyShieldSprites_while28242
CopyShieldSprites_loopstart28246
	; Binary clause Simplified: LESS
	lda css_bc
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs CopyShieldSprites_localfailed28399
	jmp CopyShieldSprites_ctb28243
CopyShieldSprites_localfailed28399
	jmp CopyShieldSprites_edblock28245
CopyShieldSprites_ctb28243: ;Main true block ;keep 
	
; // Bottom-up scan → shield_surface_top
	lda #$f
	; Calling storevariable on generic assign expression
	sta css_row
	lda #$ff
	; Calling storevariable on generic assign expression
	sta css_found
CopyShieldSprites_while28401
CopyShieldSprites_loopstart28405
	; Binary clause Simplified: EQUALS
	lda css_found
	; Compare with pure num / var optimization
	cmp #$ff;keep
	bne CopyShieldSprites_localfailed28438
	jmp CopyShieldSprites_ctb28402
CopyShieldSprites_localfailed28438
	jmp CopyShieldSprites_edblock28404
CopyShieldSprites_ctb28402: ;Main true block ;keep 
	; Generic 16 bit op
	ldy #0
	lda css_bc
CopyShieldSprites_rightvarInteger_var28442 = $54
	sta CopyShieldSprites_rightvarInteger_var28442
	sty CopyShieldSprites_rightvarInteger_var28442+1
	; Generic 16 bit op
	; Integer constant assigning
	; Load16bitvariable : #$2440
	ldy #$24
	lda #$40
CopyShieldSprites_rightvarInteger_var28445 = $56
	sta CopyShieldSprites_rightvarInteger_var28445
	sty CopyShieldSprites_rightvarInteger_var28445+1
	; Right is PURE NUMERIC : Is word =1
	; 16 bit mul or div
	; Mul 16x8 setup
	; Load16bitvariable : css_row
	ldy #0
	lda css_row
	sta mul16x8_num1
	sty mul16x8_num1Hi
	lda #$3
	sta mul16x8_num2
	jsr mul16x8_procedure
	; Low bit binop:
	clc
	adc CopyShieldSprites_rightvarInteger_var28445
CopyShieldSprites_wordAdd28443
	sta CopyShieldSprites_rightvarInteger_var28445
	; High-bit binop
	tya
	adc CopyShieldSprites_rightvarInteger_var28445+1
	tay
	lda CopyShieldSprites_rightvarInteger_var28445
	; Low bit binop:
	clc
	adc CopyShieldSprites_rightvarInteger_var28442
CopyShieldSprites_wordAdd28440
	sta CopyShieldSprites_rightvarInteger_var28442
	; High-bit binop
	tya
	adc CopyShieldSprites_rightvarInteger_var28442+1
	tay
	lda CopyShieldSprites_rightvarInteger_var28442
	; Calling storevariable on generic assign expression
	sta css_scan_addr
	sty css_scan_addr+1
	ldx css_scan_addr+1
	sta css_scan_ptr
	stx css_scan_ptr+1
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load pointer array
	ldy #$0
	lda (css_scan_ptr),y
	; cmp #$00 ignored
	beq CopyShieldSprites_eblock28448
CopyShieldSprites_ctb28447: ;Main true block ;keep 
	lda css_row
	; Calling storevariable on generic assign expression
	sta css_found
	jmp CopyShieldSprites_edblock28449
CopyShieldSprites_eblock28448
	; Binary clause Simplified: EQUALS
	clc
	lda css_row
	; cmp #$00 ignored
	bne CopyShieldSprites_eblock28464
CopyShieldSprites_ctb28463: ;Main true block ;keep 
	lda #$fe
	; Calling storevariable on generic assign expression
	sta css_found
	jmp CopyShieldSprites_edblock28465
CopyShieldSprites_eblock28464
	; Test Inc dec D
	dec css_row
CopyShieldSprites_edblock28465
CopyShieldSprites_edblock28449
	jmp CopyShieldSprites_while28401
CopyShieldSprites_edblock28404
CopyShieldSprites_loopend28406
	; Binary clause Simplified: GREATEREQUAL
	lda css_found
	; Compare with pure num / var optimization
	cmp #$10;keep
	bcc CopyShieldSprites_edblock28473
CopyShieldSprites_ctb28471: ;Main true block ;keep 
	lda #$ff
	; Calling storevariable on generic assign expression
	sta css_found
CopyShieldSprites_edblock28473
	lda css_found
	; Calling storevariable on generic assign expression
	ldx css_bc ; optimized, look out for bugs
	sta shield_surface_top,x
	; Calling storevariable on generic assign expression
	pha
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$3
	clc
	adc css_bc
	 ; end add / sub var with constant
	tax
	pla
	sta shield_surface_top,x
	lda css_found
	; Calling storevariable on generic assign expression
	pha
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$6
	clc
	adc css_bc
	 ; end add / sub var with constant
	tax
	pla
	sta shield_surface_top,x
	lda css_found
	; Calling storevariable on generic assign expression
	pha
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$9
	clc
	adc css_bc
	 ; end add / sub var with constant
	tax
	pla
	sta shield_surface_top,x
	
; // Top-down scan → shield_surface_bot
	lda #$0
	; Calling storevariable on generic assign expression
	sta css_row
	lda #$ff
	; Calling storevariable on generic assign expression
	sta css_found
CopyShieldSprites_while28476
CopyShieldSprites_loopstart28480
	; Binary clause Simplified: EQUALS
	lda css_found
	; Compare with pure num / var optimization
	cmp #$ff;keep
	bne CopyShieldSprites_localfailed28513
	jmp CopyShieldSprites_ctb28477
CopyShieldSprites_localfailed28513
	jmp CopyShieldSprites_edblock28479
CopyShieldSprites_ctb28477: ;Main true block ;keep 
	; Generic 16 bit op
	ldy #0
	lda css_bc
CopyShieldSprites_rightvarInteger_var28517 = $54
	sta CopyShieldSprites_rightvarInteger_var28517
	sty CopyShieldSprites_rightvarInteger_var28517+1
	; Generic 16 bit op
	; Integer constant assigning
	; Load16bitvariable : #$2440
	ldy #$24
	lda #$40
CopyShieldSprites_rightvarInteger_var28520 = $56
	sta CopyShieldSprites_rightvarInteger_var28520
	sty CopyShieldSprites_rightvarInteger_var28520+1
	; Right is PURE NUMERIC : Is word =1
	; 16 bit mul or div
	; Mul 16x8 setup
	; Load16bitvariable : css_row
	ldy #0
	lda css_row
	sta mul16x8_num1
	sty mul16x8_num1Hi
	lda #$3
	sta mul16x8_num2
	jsr mul16x8_procedure
	; Low bit binop:
	clc
	adc CopyShieldSprites_rightvarInteger_var28520
CopyShieldSprites_wordAdd28518
	sta CopyShieldSprites_rightvarInteger_var28520
	; High-bit binop
	tya
	adc CopyShieldSprites_rightvarInteger_var28520+1
	tay
	lda CopyShieldSprites_rightvarInteger_var28520
	; Low bit binop:
	clc
	adc CopyShieldSprites_rightvarInteger_var28517
CopyShieldSprites_wordAdd28515
	sta CopyShieldSprites_rightvarInteger_var28517
	; High-bit binop
	tya
	adc CopyShieldSprites_rightvarInteger_var28517+1
	tay
	lda CopyShieldSprites_rightvarInteger_var28517
	; Calling storevariable on generic assign expression
	sta css_scan_addr
	sty css_scan_addr+1
	ldx css_scan_addr+1
	sta css_scan_ptr
	stx css_scan_ptr+1
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load pointer array
	ldy #$0
	lda (css_scan_ptr),y
	; cmp #$00 ignored
	beq CopyShieldSprites_eblock28523
CopyShieldSprites_ctb28522: ;Main true block ;keep 
	lda css_row
	; Calling storevariable on generic assign expression
	sta css_found
	jmp CopyShieldSprites_edblock28524
CopyShieldSprites_eblock28523
	; Binary clause Simplified: GREATEREQUAL
	lda css_row
	; Compare with pure num / var optimization
	cmp #$f;keep
	bcc CopyShieldSprites_eblock28539
CopyShieldSprites_ctb28538: ;Main true block ;keep 
	lda #$fe
	; Calling storevariable on generic assign expression
	sta css_found
	jmp CopyShieldSprites_edblock28540
CopyShieldSprites_eblock28539
	; Test Inc dec D
	inc css_row
CopyShieldSprites_edblock28540
CopyShieldSprites_edblock28524
	jmp CopyShieldSprites_while28476
CopyShieldSprites_edblock28479
CopyShieldSprites_loopend28481
	; Binary clause Simplified: GREATEREQUAL
	lda css_found
	; Compare with pure num / var optimization
	cmp #$10;keep
	bcc CopyShieldSprites_edblock28548
CopyShieldSprites_ctb28546: ;Main true block ;keep 
	lda #$ff
	; Calling storevariable on generic assign expression
	sta css_found
CopyShieldSprites_edblock28548
	lda css_found
	; Calling storevariable on generic assign expression
	ldx css_bc ; optimized, look out for bugs
	sta shield_surface_bot,x
	; Calling storevariable on generic assign expression
	pha
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$3
	clc
	adc css_bc
	 ; end add / sub var with constant
	tax
	pla
	sta shield_surface_bot,x
	lda css_found
	; Calling storevariable on generic assign expression
	pha
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$6
	clc
	adc css_bc
	 ; end add / sub var with constant
	tax
	pla
	sta shield_surface_bot,x
	lda css_found
	; Calling storevariable on generic assign expression
	pha
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$9
	clc
	adc css_bc
	 ; end add / sub var with constant
	tax
	pla
	sta shield_surface_bot,x
	; Test Inc dec D
	inc css_bc
	jmp CopyShieldSprites_while28242
CopyShieldSprites_edblock28245
CopyShieldSprites_loopend28247
	asl $d019
	cli
	
; // Reset per-shield top-eroded skip flags (all shields freshly painted = none eroded).
	lda #$0
	; Calling storevariable on generic assign expression
	sta shield_top_eroded+$0
	; Calling storevariable on generic assign expression
	sta shield_top_eroded+$1
	; Calling storevariable on generic assign expression
	sta shield_top_eroded+$2
	; Calling storevariable on generic assign expression
	sta shield_top_eroded+$3
	rts
end_procedure_CopyShieldSprites
	
; // ---------------------------------------------------------------------------
; // DisableShieldLogic
; //   Marks all shield columns as fully eroded so collision/erosion checks
; //   bypass shields entirely when they are not displayed.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : DisableShieldLogic
	;    Procedure type : User-defined procedure
dsl_idx	dc.b	0
DisableShieldLogic_block28551
DisableShieldLogic
	lda #$0
	; Calling storevariable on generic assign expression
	sta dsl_idx
DisableShieldLogic_while28552
DisableShieldLogic_loopstart28556
	; Binary clause Simplified: LESS
	lda dsl_idx
	; Compare with pure num / var optimization
	cmp #$c;keep
	bcs DisableShieldLogic_edblock28555
DisableShieldLogic_ctb28553: ;Main true block ;keep 
	lda #$ff
	; Calling storevariable on generic assign expression
	ldx dsl_idx ; optimized, look out for bugs
	sta shield_surface_top,x
	; Calling storevariable on generic assign expression
	sta shield_surface_bot,x
	; Test Inc dec D
	inc dsl_idx
	jmp DisableShieldLogic_while28552
DisableShieldLogic_edblock28555
DisableShieldLogic_loopend28557
	lda #$1
	; Calling storevariable on generic assign expression
	sta shield_top_eroded+$0
	; Calling storevariable on generic assign expression
	sta shield_top_eroded+$1
	; Calling storevariable on generic assign expression
	sta shield_top_eroded+$2
	; Calling storevariable on generic assign expression
	sta shield_top_eroded+$3
	lda #$0
	; Calling storevariable on generic assign expression
	sta pending_shield_erosion
	; Calling storevariable on generic assign expression
	sta pending_shield_idx
	; Calling storevariable on generic assign expression
	sta pending_byte_col
	; Calling storevariable on generic assign expression
	sta pending_erase_top
	; Calling storevariable on generic assign expression
	sta pending_erosion_dir
	rts
end_procedure_DisableShieldLogic
	; NodeProcedureDecl -1
	; ***********  Defining procedure : DisplayText
	;    Procedure type : User-defined procedure
test_ptr	= $22
DisplayText_block28560
DisplayText
	;asm ("
; //		lda #$01     ; WHITE letters
; //        sta $0286    ; Set color
; //        ");
; //moveto(29,1,hi(screen_char_loc));	
; //PrintString("HELLO", 0, 10);
; //Screen::PrintString(" ",29,0,#Screen::screen0);
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr28562
	ldy #>DisplayText_stringassignstr28562
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
	
; //Screen::PrintString("     00000",29,2,#Screen::screen0);		
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr28564
	ldy #>DisplayText_stringassignstr28564
	sta Screen_p1
	sty Screen_p1+1
	lda #$1d
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$7
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	
; //Screen::PrintString("     00000",29,9,#Screen::screen0);
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr28566
	ldy #>DisplayText_stringassignstr28566
	sta Screen_p1
	sty Screen_p1+1
	lda #$1d
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$e
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
	
; //Screen::PrintString("         1",29,17,#Screen::screen0);
; //Screen::PrintString("CODE MUSIC",29,16,#Screen::screen0);
; //Screen::PrintString(" SG UCTUMI",29,18,#Screen::screen0);
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr28568
	ldy #>DisplayText_stringassignstr28568
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
	
; //Screen::PrintString("         3",29,23,#Screen::screen0);
; //Screen::PrintString("¤¤¤",4,18,#Screen::screen0);
; //Screen::PrintString("lmn",4,19,#Screen::screen0);
; //Screen::PrintString("opq",4,20,#Screen::screen0);
; //Screen::PrintString("rst",10,19,#Screen::screen0);
; //Screen::PrintString("uvw",10,20,#Screen::screen0);
; //Screen::PrintString("xyz",16,19,#Screen::screen0);
; //Screen::PrintString("!#¤",16,20,#Screen::screen0);
; //Screen::PrintString("¤%&",22,19,#Screen::screen0);
; //Screen::PrintString("/+*",22,20,#Screen::screen0);
; // Keep startup screen shield-free. LevelStart() places/clears shields for the selected level.
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr28570
	ldy #>DisplayText_stringassignstr28570
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
	lda #<DisplayText_stringassignstr28572
	ldy #>DisplayText_stringassignstr28572
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
	lda #<DisplayText_stringassignstr28574
	ldy #>DisplayText_stringassignstr28574
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
	lda #<DisplayText_stringassignstr28576
	ldy #>DisplayText_stringassignstr28576
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
	lda #<DisplayText_stringassignstr28578
	ldy #>DisplayText_stringassignstr28578
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
	lda #<DisplayText_stringassignstr28580
	ldy #>DisplayText_stringassignstr28580
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
	lda #<DisplayText_stringassignstr28582
	ldy #>DisplayText_stringassignstr28582
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
	lda #<DisplayText_stringassignstr28584
	ldy #>DisplayText_stringassignstr28584
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
	jsr DisableShieldLogic
	
; // Update dynamic elements (lives display, etc.)
; //UpdateLivesDisplay();
	; Assigning a string : Screen_p1
	;has array index
	lda #<DisplayText_stringassignstr28586
	ldy #>DisplayText_stringassignstr28586
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
	; ***********  Defining procedure : UpdateShieldDisplayForCurrentLevel
	;    Procedure type : User-defined procedure
UpdateShieldDisplayForCurrentLevel
	; Binary clause Simplified: LESS
	lda total_level_counter
	; Compare with pure num / var optimization
	cmp #$7;keep
	bcs UpdateShieldDisplayForCurrentLevel_edblock28591
UpdateShieldDisplayForCurrentLevel_localsuccess28593: ;keep
	; ; logical AND, second requirement
	; Optimization: replacing a > N with a >= N+1
	; Binary clause Simplified: GREATEREQUAL
	lda total_level_counter
	; Compare with pure num / var optimization
	cmp #$1;keep
	bcc UpdateShieldDisplayForCurrentLevel_edblock28591
UpdateShieldDisplayForCurrentLevel_ctb28589: ;Main true block ;keep 
	sei
	; Integer constant assigning
	; Load16bitvariable : #$6fc
	ldy #$06
	lda #$fc
	; Calling storevariable on generic assign expression
	sta Helpers_psb_base_addr
	sty Helpers_psb_base_addr+1
	lda #$70
	; Calling storevariable on generic assign expression
	sta Helpers_psb_char_base
	jsr Helpers_PlaceShieldBlock
	; Integer constant assigning
	; Load16bitvariable : #$702
	ldy #$07
	lda #$02
	; Calling storevariable on generic assign expression
	sta Helpers_psb_base_addr
	sty Helpers_psb_base_addr+1
	lda #$76
	; Calling storevariable on generic assign expression
	sta Helpers_psb_char_base
	jsr Helpers_PlaceShieldBlock
	; Integer constant assigning
	; Load16bitvariable : #$708
	ldy #$07
	lda #$08
	; Calling storevariable on generic assign expression
	sta Helpers_psb_base_addr
	sty Helpers_psb_base_addr+1
	lda #$7c
	; Calling storevariable on generic assign expression
	sta Helpers_psb_char_base
	jsr Helpers_PlaceShieldBlock
	; Integer constant assigning
	; Load16bitvariable : #$70e
	ldy #$07
	lda #$0e
	; Calling storevariable on generic assign expression
	sta Helpers_psb_base_addr
	sty Helpers_psb_base_addr+1
	lda #$82
	; Calling storevariable on generic assign expression
	sta Helpers_psb_char_base
	jsr Helpers_PlaceShieldBlock
	asl $d019
	cli
UpdateShieldDisplayForCurrentLevel_edblock28591
	rts
end_procedure_UpdateShieldDisplayForCurrentLevel
	
; // ---------------------------------------------------------------------------
; // ShowGetReadyText
; //   Displays "GET READY FOR LEVEL X" centered on screen rows 12-13.
; //   Buffers the starfield characters/colors underneath for later restoration.
; //
; //   IRQ-SAFE: buffer reads and color fills use inline ASM with absolute indexed
; //   addressing — no ZP pointers touched.  Screen::PrintString uses ZP $02-$09
; //   (Screen unit), not the shared pool.  Level-number digit logic stays Pascal.
; //
; //   Address constants (baked in — do not change GET_READY_ROW/COL without updating):
; //     Line 1 screen $05E8...$05F4  ($0400 + 12*40 + 8,  13 chars)
; //     Line 1 color  $D9E8...$D9F4
; //     Line 2 screen $0613...$061A  ($0400 + 13*40 + 11,  8 chars)
; //     Line 2 color  $DA13...$DA1A
; //     Level digit   $0619...$061B  (col 17, 1-3 digits)
; //     Level d.color $DA19...$DA1B
; //     GET_READY_COLOR = light_blue = $0E
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : ShowGetReadyText
	;    Procedure type : User-defined procedure
sgrt_level_char	dc.b	0
sgrt_temp	dc.b	0
sgrt_text_msg1		dc.b	"GET READY FOR"
	dc.b	0
sgrt_text_msg2		dc.b	"LEVEL "
	dc.b	0
ShowGetReadyText_block28595
ShowGetReadyText
	
; // Disable all sprites to hide them during intermission
	; Assigning memory location
	lda #$0
	; Calling storevariable on generic assign expression
	sta $d015
        ldx #12
sgrt_buf1 lda $05E8,x
        sta get_ready_char_buffer,x
        lda $D9E8,x
        sta get_ready_color_buffer,x
        dex
        bpl sgrt_buf1
	
	
; // ── Buffer line 1 (13 chars+colors) then print it ────────────────────────
	lda #<sgrt_text_msg1
	ldx #>sgrt_text_msg1
	sta Screen_p1
	stx Screen_p1+1
	lda #$8
	; Calling storevariable on generic assign expression
	sta Screen_x
	lda #$c
	; Calling storevariable on generic assign expression
	sta Screen_y
	lda #$00
	ldx #$04
	sta Screen_p2
	stx Screen_p2+1
	jsr Screen_PrintString
        ldx #12
        lda #$0E
sgrt_col1 sta $D9E8,x
        dex
        bpl sgrt_col1
	
        ldx #7
sgrt_buf2 lda $0613,x
        sta get_ready_char_buffer+13,x
        lda $DA13,x
        sta get_ready_color_buffer+13,x
        dex
        bpl sgrt_buf2
	
	
; // ── Buffer line 2 (8 chars+colors) then print it ─────────────────────────
	lda #<sgrt_text_msg2
	ldx #>sgrt_text_msg2
	sta Screen_p1
	stx Screen_p1+1
	lda #$b
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
	
; // ── Level number at col 17 ($0619) — computed, stays Pascal ─────────────
	lda total_level_counter
	; Calling storevariable on generic assign expression
	sta sgrt_temp
	; Binary clause Simplified: GREATEREQUAL
	; Compare with pure num / var optimization
	cmp #$64;keep
	bcc ShowGetReadyText_localfailed28630
	jmp ShowGetReadyText_ctb28597
ShowGetReadyText_localfailed28630
	jmp ShowGetReadyText_eblock28598
ShowGetReadyText_ctb28597: ;Main true block ;keep 
	; Right is PURE NUMERIC : Is word =0
	; 8 bit div
	lda sgrt_temp
	sta div8x8_d
	; Load right hand side
	lda #$64
	sta div8x8_c
	jsr div8x8_procedure
	; Calling storevariable on generic assign expression
	sta sgrt_level_char
	; Poke
	; Optimization: shift is zero
	; 8 bit binop
	; Add/sub where right value is constant number
	clc
	adc #$30
	 ; end add / sub var with constant
	sta $619
	; Poke
	; Optimization: shift is zero
	lda #$e
	sta $da19
	; 8 bit binop
	; Add/sub right value is variable/expression
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx sgrt_level_char ; optimized, look out for bugs
	; Load right hand side
	lda #$64
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
ShowGetReadyText_rightvarAddSub_var28636 = $54
	sta ShowGetReadyText_rightvarAddSub_var28636
	lda sgrt_temp
	sec
	sbc ShowGetReadyText_rightvarAddSub_var28636
	; Calling storevariable on generic assign expression
	sta sgrt_temp
	; Right is PURE NUMERIC : Is word =0
	; 8 bit div
	sta div8x8_d
	; Load right hand side
	lda #$a
	sta div8x8_c
	jsr div8x8_procedure
	; Calling storevariable on generic assign expression
	sta sgrt_level_char
	; Poke
	; Optimization: shift is zero
	; 8 bit binop
	; Add/sub where right value is constant number
	clc
	adc #$30
	 ; end add / sub var with constant
	sta $61a
	; Poke
	; Optimization: shift is zero
	lda #$e
	sta $da1a
	; 8 bit binop
	; Add/sub right value is variable/expression
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx sgrt_level_char ; optimized, look out for bugs
	; Load right hand side
	lda #$a
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
ShowGetReadyText_rightvarAddSub_var28641 = $54
	sta ShowGetReadyText_rightvarAddSub_var28641
	lda sgrt_temp
	sec
	sbc ShowGetReadyText_rightvarAddSub_var28641
	; Calling storevariable on generic assign expression
	sta sgrt_temp
	; Poke
	; Optimization: shift is zero
	; 8 bit binop
	; Add/sub where right value is constant number
	clc
	adc #$30
	 ; end add / sub var with constant
	sta $61b
	; Poke
	; Optimization: shift is zero
	lda #$e
	sta $da1b
	jmp ShowGetReadyText_edblock28599
ShowGetReadyText_eblock28598
	; Binary clause Simplified: GREATEREQUAL
	lda total_level_counter
	; Compare with pure num / var optimization
	cmp #$a;keep
	bcc ShowGetReadyText_eblock28645
ShowGetReadyText_ctb28644: ;Main true block ;keep 
	; Right is PURE NUMERIC : Is word =0
	; 8 bit div
	lda sgrt_temp
	sta div8x8_d
	; Load right hand side
	lda #$a
	sta div8x8_c
	jsr div8x8_procedure
	; Calling storevariable on generic assign expression
	sta sgrt_level_char
	; Poke
	; Optimization: shift is zero
	; 8 bit binop
	; Add/sub where right value is constant number
	clc
	adc #$30
	 ; end add / sub var with constant
	sta $619
	; Poke
	; Optimization: shift is zero
	lda #$e
	sta $da19
	; 8 bit binop
	; Add/sub right value is variable/expression
	; Right is PURE NUMERIC : Is word =0
	; 8 bit mul
	ldx sgrt_level_char ; optimized, look out for bugs
	; Load right hand side
	lda #$a
	jsr multiply_eightbit
	txa
	ldy #0 ; ::EightbitMul
ShowGetReadyText_rightvarAddSub_var28659 = $54
	sta ShowGetReadyText_rightvarAddSub_var28659
	lda sgrt_temp
	sec
	sbc ShowGetReadyText_rightvarAddSub_var28659
	; Calling storevariable on generic assign expression
	sta sgrt_temp
	; Poke
	; Optimization: shift is zero
	; 8 bit binop
	; Add/sub where right value is constant number
	clc
	adc #$30
	 ; end add / sub var with constant
	sta $61a
	; Poke
	; Optimization: shift is zero
	lda #$e
	sta $da1a
	jmp ShowGetReadyText_edblock28646
ShowGetReadyText_eblock28645
	; Poke
	; Optimization: shift is zero
	; 8 bit binop
	; Add/sub where right value is constant number
	lda total_level_counter
	clc
	adc #$30
	 ; end add / sub var with constant
	sta $619
	; Poke
	; Optimization: shift is zero
	lda #$e
	sta $da19
ShowGetReadyText_edblock28646
ShowGetReadyText_edblock28599
        ldx #5
        lda #$0E
sgrt_col2 sta $DA13,x
        dex
        bpl sgrt_col2
	
	rts
end_procedure_ShowGetReadyText
	
; // ── Line 2 color for "LEVEL " prefix (6 chars $DA13-$DA18) ─────────────
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
GetRightmostEnemyOffset_block28661
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
GetRightmostEnemyOffset_while28662
GetRightmostEnemyOffset_loopstart28666
	; Binary clause Simplified: EQUALS
	clc
	lda rightmost_column_loop_done
	; cmp #$00 ignored
	bne GetRightmostEnemyOffset_localfailed28840
	jmp GetRightmostEnemyOffset_ctb28663
GetRightmostEnemyOffset_localfailed28840
	jmp GetRightmostEnemyOffset_edblock28665
GetRightmostEnemyOffset_ctb28663: ;Main true block ;keep 
	
; // Check all 3 rows for this block column
	lda #$0
	; Calling storevariable on generic assign expression
	sta rightmost_row_index
GetRightmostEnemyOffset_while28842
GetRightmostEnemyOffset_loopstart28846
	; Binary clause Simplified: LESS
	lda rightmost_row_index
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs GetRightmostEnemyOffset_localfailed28925
GetRightmostEnemyOffset_localsuccess28926: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda rightmost_found_flag
	; cmp #$00 ignored
	bne GetRightmostEnemyOffset_localfailed28925
	jmp GetRightmostEnemyOffset_ctb28843
GetRightmostEnemyOffset_localfailed28925
	jmp GetRightmostEnemyOffset_edblock28845
GetRightmostEnemyOffset_ctb28843: ;Main true block ;keep 
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
	beq GetRightmostEnemyOffset_eblock28930
GetRightmostEnemyOffset_ctb28929: ;Main true block ;keep 
	
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
	jmp GetRightmostEnemyOffset_edblock28931
GetRightmostEnemyOffset_eblock28930
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda rightmost_enemies_byte
	and #$c
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetRightmostEnemyOffset_eblock28974
GetRightmostEnemyOffset_ctb28973: ;Main true block ;keep 
	
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
	jmp GetRightmostEnemyOffset_edblock28975
GetRightmostEnemyOffset_eblock28974
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda rightmost_enemies_byte
	and #$3
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetRightmostEnemyOffset_edblock28997
GetRightmostEnemyOffset_ctb28995: ;Main true block ;keep 
	
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
GetRightmostEnemyOffset_edblock28997
GetRightmostEnemyOffset_edblock28975
GetRightmostEnemyOffset_edblock28931
	; Test Inc dec D
	inc rightmost_row_index
	jmp GetRightmostEnemyOffset_while28842
GetRightmostEnemyOffset_edblock28845
GetRightmostEnemyOffset_loopend28847
	; Binary clause Simplified: EQUALS
	lda rightmost_found_flag
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne GetRightmostEnemyOffset_localfailed29010
	jmp GetRightmostEnemyOffset_ctb29005
GetRightmostEnemyOffset_localfailed29010: ;keep
	; ; logical OR, second chance
	; Binary clause Simplified: EQUALS
	clc
	lda rightmost_block_column
	; cmp #$00 ignored
	bne GetRightmostEnemyOffset_eblock29006
GetRightmostEnemyOffset_ctb29005: ;Main true block ;keep 
	
; // Exit if found or if we've checked column 0
	lda #$1
	; Calling storevariable on generic assign expression
	sta rightmost_column_loop_done
	jmp GetRightmostEnemyOffset_edblock29007
GetRightmostEnemyOffset_eblock29006
	; Test Inc dec D
	dec rightmost_block_column
GetRightmostEnemyOffset_edblock29007
	jmp GetRightmostEnemyOffset_while28662
GetRightmostEnemyOffset_edblock28665
GetRightmostEnemyOffset_loopend28667
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
GetLeftmostEnemyOffset_block29013
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
GetLeftmostEnemyOffset_while29014
GetLeftmostEnemyOffset_loopstart29018
	; Binary clause Simplified: EQUALS
	clc
	lda leftmost_column_loop_done
	; cmp #$00 ignored
	bne GetLeftmostEnemyOffset_localfailed29192
	jmp GetLeftmostEnemyOffset_ctb29015
GetLeftmostEnemyOffset_localfailed29192
	jmp GetLeftmostEnemyOffset_edblock29017
GetLeftmostEnemyOffset_ctb29015: ;Main true block ;keep 
	
; // Check all 3 rows for this block column
	lda #$0
	; Calling storevariable on generic assign expression
	sta leftmost_row_index
GetLeftmostEnemyOffset_while29194
GetLeftmostEnemyOffset_loopstart29198
	; Binary clause Simplified: LESS
	lda leftmost_row_index
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs GetLeftmostEnemyOffset_localfailed29277
GetLeftmostEnemyOffset_localsuccess29278: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda leftmost_found_flag
	; cmp #$00 ignored
	bne GetLeftmostEnemyOffset_localfailed29277
	jmp GetLeftmostEnemyOffset_ctb29195
GetLeftmostEnemyOffset_localfailed29277
	jmp GetLeftmostEnemyOffset_edblock29197
GetLeftmostEnemyOffset_ctb29195: ;Main true block ;keep 
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
	beq GetLeftmostEnemyOffset_eblock29282
GetLeftmostEnemyOffset_ctb29281: ;Main true block ;keep 
	
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
	jmp GetLeftmostEnemyOffset_edblock29283
GetLeftmostEnemyOffset_eblock29282
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda leftmost_enemies_byte
	and #$c
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetLeftmostEnemyOffset_eblock29326
GetLeftmostEnemyOffset_ctb29325: ;Main true block ;keep 
	
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
	jmp GetLeftmostEnemyOffset_edblock29327
GetLeftmostEnemyOffset_eblock29326
	; Binary clause Simplified: NOTEQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda leftmost_enemies_byte
	and #$30
	 ; end add / sub var with constant
	; cmp #$00 ignored
	beq GetLeftmostEnemyOffset_edblock29349
GetLeftmostEnemyOffset_ctb29347: ;Main true block ;keep 
	
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
GetLeftmostEnemyOffset_edblock29349
GetLeftmostEnemyOffset_edblock29327
GetLeftmostEnemyOffset_edblock29283
	; Test Inc dec D
	inc leftmost_row_index
	jmp GetLeftmostEnemyOffset_while29194
GetLeftmostEnemyOffset_edblock29197
GetLeftmostEnemyOffset_loopend29199
	; Binary clause Simplified: EQUALS
	lda leftmost_found_flag
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne GetLeftmostEnemyOffset_localfailed29362
	jmp GetLeftmostEnemyOffset_ctb29357
GetLeftmostEnemyOffset_localfailed29362: ;keep
	; ; logical OR, second chance
	; Binary clause Simplified: EQUALS
	lda leftmost_block_column
	; Compare with pure num / var optimization
	cmp #$3;keep
	bne GetLeftmostEnemyOffset_eblock29358
GetLeftmostEnemyOffset_ctb29357: ;Main true block ;keep 
	
; // Exit if found or if we've checked column 3
	lda #$1
	; Calling storevariable on generic assign expression
	sta leftmost_column_loop_done
	jmp GetLeftmostEnemyOffset_edblock29359
GetLeftmostEnemyOffset_eblock29358
	; Test Inc dec D
	inc leftmost_block_column
GetLeftmostEnemyOffset_edblock29359
	jmp GetLeftmostEnemyOffset_while29014
GetLeftmostEnemyOffset_edblock29017
GetLeftmostEnemyOffset_loopend29019
	lda leftmost_result_offset
	rts
end_procedure_GetLeftmostEnemyOffset
	
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
GetLowestEnemyBottomY_block29365
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
GetLowestEnemyBottomY_while29366
GetLowestEnemyBottomY_loopstart29370
	; Optimization: replacing a <= N with a <= N-1
	; Binary clause Simplified: LESS
	lda gleby_r
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs GetLowestEnemyBottomY_edblock29369
GetLowestEnemyBottomY_localsuccess29400: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda gleby_found
	; cmp #$00 ignored
	bne GetLowestEnemyBottomY_edblock29369
GetLowestEnemyBottomY_ctb29367: ;Main true block ;keep 
	
; // Scan from bottom row (2) upward; dec past 0 wraps to 255 which exits 'r <= 2'
	lda #$0
	; Calling storevariable on generic assign expression
	sta gleby_b
GetLowestEnemyBottomY_while29402
GetLowestEnemyBottomY_loopstart29406
	; Binary clause Simplified: LESS
	lda gleby_b
	; Compare with pure num / var optimization
	cmp #$4;keep
	bcs GetLowestEnemyBottomY_edblock29405
GetLowestEnemyBottomY_localsuccess29415: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	clc
	lda gleby_found
	; cmp #$00 ignored
	bne GetLowestEnemyBottomY_edblock29405
GetLowestEnemyBottomY_ctb29403: ;Main true block ;keep 
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
	beq GetLowestEnemyBottomY_edblock29420
GetLowestEnemyBottomY_ctb29418: ;Main true block ;keep 
	lda gleby_r
	; Calling storevariable on generic assign expression
	sta gleby_lowest_row
	lda #$1
	; Calling storevariable on generic assign expression
	sta gleby_found
GetLowestEnemyBottomY_edblock29420
	; Test Inc dec D
	inc gleby_b
	jmp GetLowestEnemyBottomY_while29402
GetLowestEnemyBottomY_edblock29405
GetLowestEnemyBottomY_loopend29407
	; Binary clause Simplified: EQUALS
	clc
	lda gleby_found
	; cmp #$00 ignored
	bne GetLowestEnemyBottomY_edblock29426
GetLowestEnemyBottomY_ctb29424: ;Main true block ;keep 
	; Test Inc dec D
	dec gleby_r
GetLowestEnemyBottomY_edblock29426
	jmp GetLowestEnemyBottomY_while29366
GetLowestEnemyBottomY_edblock29369
GetLowestEnemyBottomY_loopend29371
	; Binary clause Simplified: EQUALS
	clc
	lda gleby_lowest_row
	; cmp #$00 ignored
	bne GetLowestEnemyBottomY_eblock29431
GetLowestEnemyBottomY_ctb29430: ;Main true block ;keep 
	
; // Row Y offsets: row 0 = 0, row 1 = MONSTER_ROW_OFFSET, row 2 = 52
	lda #$0
	; Calling storevariable on generic assign expression
	sta gleby_row_offset
	jmp GetLowestEnemyBottomY_edblock29432
GetLowestEnemyBottomY_eblock29431
	; Binary clause Simplified: EQUALS
	lda gleby_lowest_row
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne GetLowestEnemyBottomY_eblock29447
GetLowestEnemyBottomY_ctb29446: ;Main true block ;keep 
	lda #$1a
	; Calling storevariable on generic assign expression
	sta gleby_row_offset
	jmp GetLowestEnemyBottomY_edblock29448
GetLowestEnemyBottomY_eblock29447
	lda #$34
	; Calling storevariable on generic assign expression
	sta gleby_row_offset
GetLowestEnemyBottomY_edblock29448
GetLowestEnemyBottomY_edblock29432
	
; // Check whether any 'bottom' enemy (odd index; bits 1,3,5 = mask $2A) is alive in this row.
; // Bottom enemies occupy sprite pixel rows 13-20 (bottom pixel offset = 20).
; // Top-only enemies occupy rows 0-7 (bottom pixel offset = 7).
	lda #$0
	; Calling storevariable on generic assign expression
	sta gleby_has_bottom_enemy
	; Calling storevariable on generic assign expression
	sta gleby_b
GetLowestEnemyBottomY_while29453
GetLowestEnemyBottomY_loopstart29457
	; Optimization: replacing a <= N with a <= N-1
	; Binary clause Simplified: LESS
	lda gleby_b
	; Compare with pure num / var optimization
	cmp #$4;keep
	bcs GetLowestEnemyBottomY_edblock29456
GetLowestEnemyBottomY_ctb29454: ;Main true block ;keep 
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
	beq GetLowestEnemyBottomY_edblock29470
GetLowestEnemyBottomY_ctb29468: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta gleby_has_bottom_enemy
GetLowestEnemyBottomY_edblock29470
	; Test Inc dec D
	inc gleby_b
	jmp GetLowestEnemyBottomY_while29453
GetLowestEnemyBottomY_edblock29456
GetLowestEnemyBottomY_loopend29458
	; Binary clause Simplified: NOTEQUALS
	clc
	lda gleby_has_bottom_enemy
	; cmp #$00 ignored
	beq GetLowestEnemyBottomY_eblock29475
GetLowestEnemyBottomY_ctb29474: ;Main true block ;keep 
	lda #$14
	; Calling storevariable on generic assign expression
	sta gleby_bottom_in_sprite
	jmp GetLowestEnemyBottomY_edblock29476
GetLowestEnemyBottomY_eblock29475
	lda #$7
	; Calling storevariable on generic assign expression
	sta gleby_bottom_in_sprite
GetLowestEnemyBottomY_edblock29476
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	clc
	adc gleby_row_offset
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
enemy_count_diff	dc.b	0
right_edge	dc.b	0
left_edge	dc.b	0
prev_direction	dc.b	0
UpdateTick_block29481
UpdateTick
	; Binary clause Simplified: EQUALS
	clc
	lda player_respawn_state
	; cmp #$00 ignored
	bne UpdateTick_localfailed29846
	jmp UpdateTick_ctb29483
UpdateTick_localfailed29846
	jmp UpdateTick_edblock29485
UpdateTick_ctb29483: ;Main true block ;keep 
	; Binary clause Simplified: NOTEQUALS
	clc
	lda pending_edge_rescan
	; cmp #$00 ignored
	beq UpdateTick_edblock29851
UpdateTick_ctb29849: ;Main true block ;keep 
	
; // 1 = table lookup, 0 = pure linear (arcade-accurate)
; // 1 = prevent formation from dropping into player
; // pixels to drop per direction change
; // Skip all animation and movement updates during player respawn sequence
; // Drain deferred edge rescan from the previous kill frame.
; // Running here means the cached values are fresh before right_edge/left_edge are read below.
	jsr GetRightmostEnemyOffset
	; Calling storevariable on generic assign expression
	sta cached_rightmost_offset
	jsr GetLeftmostEnemyOffset
	; Calling storevariable on generic assign expression
	sta cached_leftmost_offset
	lda #$0
	; Calling storevariable on generic assign expression
	sta pending_edge_rescan
UpdateTick_edblock29851
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$47
	sec
	sbc numberOfEnemies
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta enemy_count_diff
	lda #$0
	; Calling storevariable on generic assign expression
	sta should_move_enemy
	; Binary clause Simplified: NOTEQUALS
	clc
	lda enemyMoveCounter
	; cmp #$00 ignored
	beq UpdateTick_eblock29856
UpdateTick_ctb29855: ;Main true block ;keep 
	; Test Inc dec D
	dec enemyMoveCounter
	; Binary clause Simplified: EQUALS
	lda enemyMoveCounter
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne UpdateTick_edblock29902
UpdateTick_ctb29900: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	lda current_speed_delay
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcc UpdateTick_edblock29914
UpdateTick_ctb29912: ;Main true block ;keep 
	
; // Premove: fires 2 frames before the main tick to smooth out the
; // direction-change transition. Suppressed when delay <= 2 because
; // at that speed premove can't fire before the main tick.
	lda #$1
	; Calling storevariable on generic assign expression
	sta should_move_enemy
UpdateTick_edblock29914
UpdateTick_edblock29902
	jmp UpdateTick_edblock29857
UpdateTick_eblock29856
	; Binary clause Simplified: NOTEQUALS
	clc
	lda #$0
	; cmp #$00 ignored
	beq UpdateTick_eblock29920
UpdateTick_ctb29919: ;Main true block ;keep 
	
; // Reload delay.
; // USE_SPEED_TABLE=1: table lookup capped to linear (gentle staircase boost).
; // USE_SPEED_TABLE=0: pure linear (delay = aliens alive, arcade-accurate).
	lda enemy_count_diff
	; Calling storevariable on generic assign expression
	sta Helpers_aliens_alive
	jsr Helpers_GetArcadeSpeedDelay
	; Calling storevariable on generic assign expression
	sta current_speed_delay
	; Binary clause Simplified: LESS
	lda enemy_count_diff
	; Compare with pure num / var optimization
	cmp current_speed_delay;keep
	bcs UpdateTick_edblock29934
UpdateTick_ctb29932: ;Main true block ;keep 
	lda enemy_count_diff
	; Calling storevariable on generic assign expression
	sta current_speed_delay
UpdateTick_edblock29934
	jmp UpdateTick_edblock29921
UpdateTick_eblock29920
	lda enemy_count_diff
	; Calling storevariable on generic assign expression
	sta current_speed_delay
UpdateTick_edblock29921
	lda current_speed_delay
	; Calling storevariable on generic assign expression
	sta enemyMoveCounter
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_animation_frame
	eor #$1
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta monster_animation_frame
	
; // Note: AnimateMonsters is NOT called here. All three rows are handled
; // exclusively in their respective raster IRQs (Row1/2/3), which fire
; // after the beam has passed UFO_Y but before each enemy row is scanned.
; // This keeps sprite 1's image pointer owned solely by ShowUFO() until
; // Row1 takes over, eliminating the UFO flash.
	lda #$1
	; Calling storevariable on generic assign expression
	sta should_move_enemy
UpdateTick_edblock29857
	; Binary clause Simplified: NOTEQUALS
	clc
	lda should_move_enemy
	; cmp #$00 ignored
	beq UpdateTick_localfailed30074
	jmp UpdateTick_ctb29939
UpdateTick_localfailed30074
	jmp UpdateTick_edblock29941
UpdateTick_ctb29939: ;Main true block ;keep 
	
; // Read cached edge offsets — updated in ClearMonster, so O(1) cost here
; // every tick regardless of enemy count.
	; 8 bit binop
	; Add/sub where right value is constant number
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_x
	clc
	adc cached_rightmost_offset
	 ; end add / sub var with constant
	clc
	adc #$a
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta right_edge
	
; // +10 for double-width enemy
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_x
	clc
	adc cached_leftmost_offset
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta left_edge
	lda enemy_direction
	; Calling storevariable on generic assign expression
	sta prev_direction
	; Binary clause Simplified: GREATEREQUAL
	lda right_edge
	; Compare with pure num / var optimization
	cmp #$f2;keep
	bcc UpdateTick_eblock30078
UpdateTick_ctb30077: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemy_direction
	jmp UpdateTick_edblock30079
UpdateTick_eblock30078
	; Binary clause Simplified: LESS
	lda left_edge
	; Compare with pure num / var optimization
	cmp #$25;keep
	bcs UpdateTick_edblock30093
UpdateTick_ctb30091: ;Main true block ;keep 
	
; // 47 = 36 + BULLET_X_CONTACT_REACH; ensures cbcc_block_x >= 11 for leftmost survivors
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemy_direction
UpdateTick_edblock30093
UpdateTick_edblock30079
	; Binary clause Simplified: NOTEQUALS
	lda prev_direction
	; Compare with pure num / var optimization
	cmp enemy_direction;keep
	beq UpdateTick_localfailed30153
	jmp UpdateTick_ctb30097
UpdateTick_localfailed30153
	jmp UpdateTick_eblock30098
UpdateTick_ctb30097: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda #$1
	; cmp #$00 ignored
	bne UpdateTick_localfailed30161
	jmp UpdateTick_ctb30156
UpdateTick_localfailed30161: ;keep
	; ; logical OR, second chance
	; Binary clause Simplified: LESS
	jsr GetLowestEnemyBottomY
UpdateTick_binary_clause_temp_var30162 = $54
	sta UpdateTick_binary_clause_temp_var30162
	; 8 bit binop
	; Add/sub where right value is constant number
	lda player_sprite_y
	sec
	sbc #$6
	 ; end add / sub var with constant
UpdateTick_binary_clause_temp_2_var30163 = $56
	sta UpdateTick_binary_clause_temp_2_var30163
	lda UpdateTick_binary_clause_temp_var30162
	cmp UpdateTick_binary_clause_temp_2_var30163;keep
	bcs UpdateTick_eblock30157
UpdateTick_ctb30156: ;Main true block ;keep 
	
; // If direction changed, drop instead of moving horizontally this tick.
; // This keeps movement flow clean: one tick = one action (drop OR move, never both).
	; Optimizer: a = a +/- b
	; Load16bitvariable : monster_base_y
	lda monster_base_y
	clc
	adc #$6
	sta monster_base_y
	jmp UpdateTick_edblock30158
UpdateTick_eblock30157
	
; // Formation reached player floor: immediate game over.
; // TODO: Perhaps add a little more ceremony here. Also maybe make this variable dependent for debugging.
	lda #$0
	; Calling storevariable on generic assign expression
	sta $d015
	lda #$1
	; Calling storevariable on generic assign expression
	sta game_over_mode
	; Calling storevariable on generic assign expression
	sta get_ready_mode
	; Calling storevariable on generic assign expression
	sta pending_palette
UpdateTick_edblock30158
	jmp UpdateTick_edblock30099
UpdateTick_eblock30098
	; Binary clause Simplified: LESS
	lda current_speed_delay
	; Compare with pure num / var optimization
	cmp #$3;keep
	bcs UpdateTick_eblock30169
UpdateTick_ctb30168: ;Main true block ;keep 
	; Binary clause Simplified: NOTEQUALS
	clc
	lda enemy_direction
	; cmp #$00 ignored
	beq UpdateTick_eblock30192
UpdateTick_ctb30191: ;Main true block ;keep 
	
; // No direction change: move horizontally.
; // When premove is suppressed (delay <= 2), the main tick must move
; // 2px to maintain the arcade's 2px-per-cycle rate.
	; Optimizer: a = a +/- b
	; Load16bitvariable : monster_base_x
	lda monster_base_x
	clc
	adc #$2
	sta monster_base_x
	jmp UpdateTick_edblock30193
UpdateTick_eblock30192
	; Optimizer: a = a +/- b
	; Load16bitvariable : monster_base_x
	lda monster_base_x
	sec
	sbc #$2
	sta monster_base_x
UpdateTick_edblock30193
	jmp UpdateTick_edblock30170
UpdateTick_eblock30169
	; Binary clause Simplified: NOTEQUALS
	clc
	lda enemy_direction
	; cmp #$00 ignored
	beq UpdateTick_eblock30201
UpdateTick_ctb30200: ;Main true block ;keep 
	; Test Inc dec D
	inc monster_base_x
	jmp UpdateTick_edblock30202
UpdateTick_eblock30201
	; Test Inc dec D
	dec monster_base_x
UpdateTick_edblock30202
UpdateTick_edblock30170
UpdateTick_edblock30099
	
; // Signal contact-erosion check: run once per march step, not per frame.
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemy_march_tick
UpdateTick_edblock29941
UpdateTick_edblock29485
	rts
end_procedure_UpdateTick
	
; // End: if player_respawn_state = 0
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MakeMonsters
	;    Procedure type : User-defined procedure
monster_sprite_color	dc.b	$03
lm_level	dc.b	0
lm_offset	dc.b	0
MakeMonsters_block30207
MakeMonsters
	
; // counter for level loop
; // accumulated Y offset for current level
; // Compute starting Y: level 1 = LEVEL_START_Y, each level adds LEVEL_Y_STEP.
; // Loop avoids a runtime multiply (max 8 iterations).
	lda #$0
	; Calling storevariable on generic assign expression
	sta lm_offset
	lda #$1
	; Calling storevariable on generic assign expression
	sta lm_level
MakeMonsters_while30208
MakeMonsters_loopstart30212
	; Binary clause Simplified: LESS
	lda lm_level
	; Compare with pure num / var optimization
	cmp current_level;keep
	bcs MakeMonsters_edblock30211
MakeMonsters_ctb30209: ;Main true block ;keep 
	; Optimizer: a = a +/- b
	; Load16bitvariable : lm_offset
	lda lm_offset
	clc
	adc #$6
	sta lm_offset
	; Test Inc dec D
	inc lm_level
	jmp MakeMonsters_while30208
MakeMonsters_edblock30211
MakeMonsters_loopend30213
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$66
	clc
	adc lm_offset
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta monster_base_y
	lda #$12
	; Calling storevariable on generic assign expression
	sta monster_base_x
	
; // Reset row-present cache for new game.
	lda #$1
	; Calling storevariable on generic assign expression
	sta row_has_monsters+$0
	; Calling storevariable on generic assign expression
	sta row_has_monsters+$1
	; Calling storevariable on generic assign expression
	sta row_has_monsters+$2
	
; // Sync cached edges with the formation state after pre-clearing.
	jsr GetRightmostEnemyOffset
	; Calling storevariable on generic assign expression
	sta cached_rightmost_offset
	jsr GetLeftmostEnemyOffset
	; Calling storevariable on generic assign expression
	sta cached_leftmost_offset
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
; //togglebit(sprite_bitmask,monsterSprite1,1);
; //togglebit(sprite_bitmask,monsterSprite2,1);
; //togglebit(sprite_bitmask,monsterSprite3,1);
; //togglebit(sprite_bitmask,monsterSprite4,1);
; // Enable sprite stretching for wider monsters
	; Toggle bit with constant
	lda $d01d
	ora #%10
	sta $d01d
	ldx #$1 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit30216
	cpx #0
	beq MakeMonsters_shiftbitdone30217
	asl
	dex
	jmp MakeMonsters_shiftbit30216
MakeMonsters_shiftbitdone30217
MakeMonsters_bitmask_var30218 = $54
	sta MakeMonsters_bitmask_var30218
	lda $d01d
	ora MakeMonsters_bitmask_var30218
	sta $d01d
	; Toggle bit with constant
	ora #%100
	sta $d01d
	ldx #$2 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit30219
	cpx #0
	beq MakeMonsters_shiftbitdone30220
	asl
	dex
	jmp MakeMonsters_shiftbit30219
MakeMonsters_shiftbitdone30220
MakeMonsters_bitmask_var30221 = $54
	sta MakeMonsters_bitmask_var30221
	lda $d01d
	ora MakeMonsters_bitmask_var30221
	sta $d01d
	; Toggle bit with constant
	ora #%1000
	sta $d01d
	ldx #$3 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit30222
	cpx #0
	beq MakeMonsters_shiftbitdone30223
	asl
	dex
	jmp MakeMonsters_shiftbit30222
MakeMonsters_shiftbitdone30223
MakeMonsters_bitmask_var30224 = $54
	sta MakeMonsters_bitmask_var30224
	lda $d01d
	ora MakeMonsters_bitmask_var30224
	sta $d01d
	; Toggle bit with constant
	ora #%10000
	sta $d01d
	ldx #$4 ; optimized, look out for bugs
	lda #1
MakeMonsters_shiftbit30225
	cpx #0
	beq MakeMonsters_shiftbitdone30226
	asl
	dex
	jmp MakeMonsters_shiftbit30225
MakeMonsters_shiftbitdone30226
MakeMonsters_bitmask_var30227 = $54
	sta MakeMonsters_bitmask_var30227
	lda $d01d
	ora MakeMonsters_bitmask_var30227
	sta $d01d
	
; // Enable UFO bullet sprites
	lda #$3
	; Calling storevariable on generic assign expression
	sta $D027+$6
	
; //togglebit(sprite_bitmask,ES_SHOT_SPRITE1,1);
	; Calling storevariable on generic assign expression
	sta $D027+$5
	
; //togglebit(sprite_bitmask,ES_SHOT_SPRITE2,1);
	; Calling storevariable on generic assign expression
	sta $D027+$7
	rts
end_procedure_MakeMonsters
	
; //togglebit(sprite_bitmask,ES_SHOT_SPRITE3,1);
; // ---------------------------------------------------------------------------------------------------------------------------------
; // RASTER INTERRUPT HANDLERS — Scheduled chain manages all game logic timing
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Architecture:
; //
; // Full game chain (normal play):
; //   MainRasterPlayer (raster 0):    Updates sprite positions; schedules Starfield
; //   MainRasterStarfield (raster 0): Updates starfield sprite; schedules Row3
; //   MainRasterRow3 (row 2 monsters): Animates/positions row 2; schedules Row2 or Player
; //   MainRasterRow2 (row 1 monsters): Animates/positions row 1; schedules Row1 or Player
; //   MainRasterRow1 (row 0 monsters): Animates/positions row 0; schedules MainRasterChain
; //   MainRasterChain (raster 53):     Main game logic (physics, collisions, UI)
; //
; // Intermission chain (get-ready screen):
; //   IntermissionChain (raster 0):    Music playback, button polling; schedules Starfield
; //   IntermissionStarfield (raster 0): Starfield animation; loops back to IntermissionChain
; //
; // Raster Mux: Sprites 1-4 repurposed per row context (enemy formation display)
; // Forward Declarations: MainRasterChain (scheduled by both Player and Row1)
; // ---------------------------------------------------------------------------------------------------------------------------------
; // ---------------------------------------------------------------------------
; // INTERMISSION RASTER CHAIN
; // ---------------------------------------------------------------------------
; // Simplified raster chain for get-ready screen: only music, starfield, and input.
; // No monster logic, no collision detection, no sprite updates.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : IntermissionChain
	;    Procedure type : User-defined procedure
IntermissionChain
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	; Binary clause Simplified: EQUALS
	lda pending_palette
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne IntermissionChain_edblock30232
IntermissionChain_ctb30230: ;Main true block ;keep 
	
; // Flush deferred palette update before advancing the SID engine.
; // Running at I=1 here (inside interrupt) — immune to the SID play routine
; // corrupting ZP $24 (StarField_color_mem).  Clear the flag first so a
; // concurrently-written pending_palette := 1 from LevelAdvance() is never lost.
	lda #$0
	; Calling storevariable on generic assign expression
	sta pending_palette
	lda pal_col1
	; Calling storevariable on generic assign expression
	sta StarField_col1
	lda pal_col2
	; Calling storevariable on generic assign expression
	sta StarField_col2
	lda pal_col3
	; Calling storevariable on generic assign expression
	sta StarField_col3
	lda pal_col4
	; Calling storevariable on generic assign expression
	sta StarField_col4
	lda pal_col5
	; Calling storevariable on generic assign expression
	sta StarField_col5
	lda pal_col6
	; Calling storevariable on generic assign expression
	sta StarField_col6
	jsr StarField_SetStarfieldColors
	; Binary clause Simplified: EQUALS
	lda game_over_mode
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne IntermissionChain_eblock30245
IntermissionChain_ctb30244: ;Main true block ;keep 
	
; // Show appropriate text based on mode
	jsr ShowGameOverText
	jmp IntermissionChain_edblock30246
IntermissionChain_eblock30245
	jsr ShowGetReadyText
IntermissionChain_edblock30246
IntermissionChain_edblock30232
	; Binary clause Simplified: EQUALS
	clc
	lda #$0
	; cmp #$00 ignored
	bne IntermissionChain_edblock30254
IntermissionChain_ctb30252: ;Main true block ;keep 
	
; // Play music during intermission
	jsr $1003
IntermissionChain_edblock30254
	
; // Check fire button to proceed
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
	bne IntermissionChain_eblock30259
IntermissionChain_ctb30258: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	lda game_over_mode
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne IntermissionChain_eblock30300
IntermissionChain_ctb30299: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda game_over_prev_fire
	; cmp #$00 ignored
	bne IntermissionChain_edblock30321
IntermissionChain_ctb30319: ;Main true block ;keep 
	
; // Game over screen: return to startup on fire
	jsr HideGameOverText
	lda #$1
	; Calling storevariable on generic assign expression
	sta game_over_prev_fire
	
; // Reset all game state for clean return to startup
	jsr ResetGameState
	
; // After reset, set startup_mode to trigger startup screen
	lda #$1
	; Calling storevariable on generic assign expression
	sta startup_mode
IntermissionChain_edblock30321
	jmp IntermissionChain_edblock30301
IntermissionChain_eblock30300
	; Binary clause Simplified: EQUALS
	clc
	lda get_ready_prev_fire
	; cmp #$00 ignored
	bne IntermissionChain_edblock30328
IntermissionChain_localsuccess30330: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	lda level_advance_ready
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne IntermissionChain_edblock30328
IntermissionChain_ctb30326: ;Main true block ;keep 
	jsr LevelStart
	
; // Exits intermission, switches to full game chain
	lda #$1
	; Calling storevariable on generic assign expression
	sta get_ready_prev_fire
IntermissionChain_edblock30328
IntermissionChain_edblock30301
	jmp IntermissionChain_edblock30260
IntermissionChain_eblock30259
	lda #$0
	; Calling storevariable on generic assign expression
	sta get_ready_prev_fire
	; Calling storevariable on generic assign expression
	sta game_over_prev_fire
IntermissionChain_edblock30260
	; Binary clause Simplified: EQUALS
	lda get_ready_mode
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne IntermissionChain_localfailed30347
	jmp IntermissionChain_ctb30334
IntermissionChain_localfailed30347: ;keep
	; ; logical OR, second chance
	; Binary clause Simplified: EQUALS
	lda game_over_mode
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne IntermissionChain_eblock30335
IntermissionChain_ctb30334: ;Main true block ;keep 
	
; // Schedule next step based on current mode.
; // If LevelStart() just ran, get_ready_mode is now 0 and we must not overwrite
; // the game-chain handoff with another intermission IRQ.
	; RasterIRQ : Hook a procedure
	lda #$fa
	sta $d012
	lda #<IntermissionStarfield
	sta $fffe
	lda #>IntermissionStarfield
	sta $ffff
	jmp IntermissionChain_edblock30336
IntermissionChain_eblock30335
	; Binary clause Simplified: EQUALS
	lda startup_mode
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne IntermissionChain_eblock30352
IntermissionChain_ctb30351: ;Main true block ;keep 
	; RasterIRQ : Hook a procedure
	lda #$0
	sta $d012
	lda #<StartupChain
	sta $fffe
	lda #>StartupChain
	sta $ffff
	jmp IntermissionChain_edblock30353
IntermissionChain_eblock30352
	; RasterIRQ : Hook a procedure
	lda #$0
	sta $d012
	lda #<MainRasterChain
	sta $fffe
	lda #>MainRasterChain
	sta $ffff
IntermissionChain_edblock30353
IntermissionChain_edblock30336
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_IntermissionChain
	; NodeProcedureDecl -1
	; ***********  Defining procedure : IntermissionStarfield
	;    Procedure type : User-defined procedure
IntermissionStarfield
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	
; // Animate starfield
	; Test Inc dec D
	inc StarField_RasterCount
	jsr StarField_DoStarfield
	
; // Loop back to intermission chain for next frame
	; RasterIRQ : Hook a procedure
	lda #$0
	sta $d012
	lda #<IntermissionChain
	sta $fffe
	lda #>IntermissionChain
	sta $ffff
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_IntermissionStarfield
	; NodeProcedureDecl -1
	; ***********  Defining procedure : StartupChain
	;    Procedure type : User-defined procedure
StartupChain
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	; Binary clause Simplified: EQUALS
	clc
	lda #$0
	; cmp #$00 ignored
	bne StartupChain_edblock30363
StartupChain_ctb30361: ;Main true block ;keep 
	jsr $1003
StartupChain_edblock30363
	lda #%11111111  ; CIA#1 port A = outputs 
	sta $dc03             
	lda #%00000000  ; CIA#1 port B = inputs
	sta $dc02             
	lda $dc00
	sta $50
	jsr callJoystick
	; Binary clause Simplified: EQUALS
	lda joystickleft
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne StartupChain_eblock30368
StartupChain_ctb30367: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda startup_prev_inputs
	and #$2
	 ; end add / sub var with constant
	; cmp #$00 ignored
	bne StartupChain_edblock30398
StartupChain_ctb30396: ;Main true block ;keep 
	; Binary clause Simplified: GREATEREQUAL
	lda current_level
	; Compare with pure num / var optimization
	cmp #$2;keep
	bcc StartupChain_eblock30411
StartupChain_ctb30410: ;Main true block ;keep 
	; Test Inc dec D
	dec current_level
	jmp StartupChain_edblock30412
StartupChain_eblock30411
	lda #$9
	; Calling storevariable on generic assign expression
	sta current_level
StartupChain_edblock30412
	jsr UpdateStartupLevelSelectDigit
	; 8 bit binop
	; Add/sub where right value is constant number
	lda startup_prev_inputs
	ora #$2
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta startup_prev_inputs
StartupChain_edblock30398
	jmp StartupChain_edblock30369
StartupChain_eblock30368
	; 8 bit binop
	; Add/sub where right value is constant number
	lda startup_prev_inputs
	and #$fd
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta startup_prev_inputs
StartupChain_edblock30369
	; Binary clause Simplified: EQUALS
	lda joystickright
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne StartupChain_eblock30420
StartupChain_ctb30419: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda startup_prev_inputs
	and #$4
	 ; end add / sub var with constant
	; cmp #$00 ignored
	bne StartupChain_edblock30450
StartupChain_ctb30448: ;Main true block ;keep 
	; Binary clause Simplified: LESS
	lda current_level
	; Compare with pure num / var optimization
	cmp #$9;keep
	bcs StartupChain_eblock30463
StartupChain_ctb30462: ;Main true block ;keep 
	; Test Inc dec D
	inc current_level
	jmp StartupChain_edblock30464
StartupChain_eblock30463
	lda #$1
	; Calling storevariable on generic assign expression
	sta current_level
StartupChain_edblock30464
	jsr UpdateStartupLevelSelectDigit
	; 8 bit binop
	; Add/sub where right value is constant number
	lda startup_prev_inputs
	ora #$4
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta startup_prev_inputs
StartupChain_edblock30450
	jmp StartupChain_edblock30421
StartupChain_eblock30420
	; 8 bit binop
	; Add/sub where right value is constant number
	lda startup_prev_inputs
	and #$fb
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta startup_prev_inputs
StartupChain_edblock30421
	; Binary clause Simplified: EQUALS
	lda joystickbutton
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne StartupChain_eblock30472
StartupChain_ctb30471: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	; 8 bit binop
	; Add/sub where right value is constant number
	lda startup_prev_inputs
	and #$1
	 ; end add / sub var with constant
	; cmp #$00 ignored
	bne StartupChain_edblock30486
StartupChain_ctb30484: ;Main true block ;keep 
	jsr HideStartupText
	lda #$0
	; Calling storevariable on generic assign expression
	sta startup_mode
	lda current_level
	; Calling storevariable on generic assign expression
	sta total_level_counter
	; Test Inc dec D
	dec total_level_counter
	; Test Inc dec D
	dec current_level
	jsr LevelAdvance
	lda #$1
	; Calling storevariable on generic assign expression
	sta get_ready_prev_fire
	; 8 bit binop
	; Add/sub where right value is constant number
	lda startup_prev_inputs
	ora #$1
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta startup_prev_inputs
StartupChain_edblock30486
	jmp StartupChain_edblock30473
StartupChain_eblock30472
	; 8 bit binop
	; Add/sub where right value is constant number
	lda startup_prev_inputs
	and #$fe
	 ; end add / sub var with constant
	; Calling storevariable on generic assign expression
	sta startup_prev_inputs
StartupChain_edblock30473
	; Binary clause Simplified: EQUALS
	lda startup_mode
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne StartupChain_eblock30492
StartupChain_ctb30491: ;Main true block ;keep 
	; RasterIRQ : Hook a procedure
	lda #$fa
	sta $d012
	lda #<StartupStarfield
	sta $fffe
	lda #>StartupStarfield
	sta $ffff
	jmp StartupChain_edblock30493
StartupChain_eblock30492
	; Binary clause Simplified: EQUALS
	lda get_ready_mode
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne StartupChain_eblock30508
StartupChain_ctb30507: ;Main true block ;keep 
	; RasterIRQ : Hook a procedure
	lda #$0
	sta $d012
	lda #<IntermissionChain
	sta $fffe
	lda #>IntermissionChain
	sta $ffff
	jmp StartupChain_edblock30509
StartupChain_eblock30508
	; RasterIRQ : Hook a procedure
	lda #$0
	sta $d012
	lda #<MainRasterChain
	sta $fffe
	lda #>MainRasterChain
	sta $ffff
StartupChain_edblock30509
StartupChain_edblock30493
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_StartupChain
	; NodeProcedureDecl -1
	; ***********  Defining procedure : StartupStarfield
	;    Procedure type : User-defined procedure
StartupStarfield
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	; Test Inc dec D
	inc StarField_RasterCount
	jsr StarField_DoStarfield
	; RasterIRQ : Hook a procedure
	lda #$0
	sta $d012
	lda #<StartupChain
	sta $fffe
	lda #>StartupChain
	sta $ffff
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_StartupStarfield
	
; // ---------------------------------------------------------------------------
; // MAIN GAME RASTER CHAIN
; // ---------------------------------------------------------------------------
; // Full raster chain for active gameplay.
; // Order: Player → Starfield → Row3 → Row2 → Row1 → Chain
; //   Only MainRasterChain needs a forward declaration (Player + Starfield schedule it).
; //   Each Row handler only schedules already-defined interrupts (Row3→Player,
; //   Row2→Row3/Player, Row1→Row2/Row3/Player). Chain schedules all four, all defined above.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterPlayer
	;    Procedure type : User-defined procedure
MainRasterPlayer
	jsr UpdateSprite
	; Binary clause Simplified: EQUALS
	clc
	lda #$0
	; cmp #$00 ignored
	bne MainRasterPlayer_eblock30518
MainRasterPlayer_ctb30517: ;Main true block ;keep 
	jsr $1003
	jmp MainRasterPlayer_edblock30519
MainRasterPlayer_eblock30518
	lda #$0
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterPlayer_edblock30519
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	; Binary clause Simplified: EQUALS
	lda get_ready_mode
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterPlayer_localfailed30530
	jmp MainRasterPlayer_ctb30525
MainRasterPlayer_localfailed30530: ;keep
	; ; logical OR, second chance
	; Binary clause Simplified: EQUALS
	lda game_over_mode
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterPlayer_eblock30526
MainRasterPlayer_ctb30525: ;Main true block ;keep 
	
; // Schedule MainRasterChain FIRST — same logic as the RasterIRQ-before-heavy-work
; // pattern in MainRasterChain.  CheckBulletCollision (kill frame), UpdateTick
; // (edge-rescan frame), and DoStarfield can all overrun.  If the latch is written
; // after line 0 has passed the beam we lose a full frame on the chain.
	; RasterIRQ : Hook a procedure
	lda #$0
	sta $d012
	lda #<IntermissionChain
	sta $fffe
	lda #>IntermissionChain
	sta $ffff
	jmp MainRasterPlayer_edblock30527
MainRasterPlayer_eblock30526
	; RasterIRQ : Hook a procedure
	lda #$0
	sta $d012
	lda #<MainRasterChain
	sta $fffe
	lda #>MainRasterChain
	sta $ffff
MainRasterPlayer_edblock30527
	
; // Run game logic unconditionally — intermission uses separate chain
	jsr CheckShieldCollision
	jsr UpdateTick
	; Binary clause Simplified: EQUALS
	lda player_bullet_active
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterPlayer_edblock30536
MainRasterPlayer_ctb30534: ;Main true block ;keep 
	
; // Check collisions AFTER all sprite rows have been displayed
; // Only check when bullet is actively moving (not exploding)
	jsr CheckBulletCollision
MainRasterPlayer_edblock30536
	
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
MainRasterPlayer_spritepos30539
	lda $D010
	and #%11111110
	sta $D010
MainRasterPlayer_spriteposcontinue30540
	inx
	txa
	tay
	lda player_sprite_y
	sta $D000,y
	
; // Player position
; //togglebit(sprite_bitmask, useSprite, 1);  
; // Ensure sprite is enabled for player
; //RasterIRQ(MainRasterStarfield(),253,@useKernal);
; //border_debug_color := peek($D01E, 0);
; //SCREEN_BG_COL := border_debug_color;
; //DisplayScore();
	; Test Inc dec D
	inc StarField_RasterCount
	jsr StarField_DoStarfield
	
; //poke(^$D019, 0, 0);  	
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRasterPlayer
	; NodeProcedureDecl -1
	; ***********  Defining procedure : MainRasterRow3
	;    Procedure type : User-defined procedure
MainRasterRow3
	; StartIRQ
	pha
	txa
	pha
	tya
	pha
	asl $d019
	
; // Set image pointers for row 2
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda row_has_monsters +$2 ; array with const index optimization 
	; cmp #$00 ignored
	beq MainRasterRow3_edblock30545
MainRasterRow3_ctb30543: ;Main true block ;keep 
	
; // Update bottom row only if it still contains monsters
	lda #$34
	; Calling storevariable on generic assign expression
	sta rowOffset
	jsr UpdateMonsters
	
; // Set screen positions for row 2
	lda #$2
	; Calling storevariable on generic assign expression
	sta enemyRow
	jsr AnimateMonsters
MainRasterRow3_edblock30545
	; RasterIRQ : Hook a procedure
	lda #$de
	sta $d012
	lda #<MainRasterPlayer
	sta $fffe
	lda #>MainRasterPlayer
	sta $ffff
	; Binary clause Simplified: EQUALS
	lda #$0
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterRow3_edblock30551
MainRasterRow3_ctb30549: ;Main true block ;keep 
	lda #$5
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterRow3_edblock30551
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRasterRow3
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
	
; // Set image pointers for row 1
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda row_has_monsters +$1 ; array with const index optimization 
	; cmp #$00 ignored
	beq MainRasterRow2_edblock30558
MainRasterRow2_ctb30556: ;Main true block ;keep 
	
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
	
; // Set screen positions for row 1
	lda #$1
	; Calling storevariable on generic assign expression
	sta enemyRow
	jsr AnimateMonsters
MainRasterRow2_edblock30558
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda row_has_monsters +$2 ; array with const index optimization 
	; cmp #$00 ignored
	beq MainRasterRow2_eblock30563
MainRasterRow2_ctb30562: ;Main true block ;keep 
	
; // If bottom row still has monsters, go to row3; otherwise skip to joystick handler
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$2d
	clc
	adc monster_base_y
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow3
	sta $fffe
	lda #>MainRasterRow3
	sta $ffff
	jmp MainRasterRow2_edblock30564
MainRasterRow2_eblock30563
	; RasterIRQ : Hook a procedure
	lda #$de
	sta $d012
	lda #<MainRasterPlayer
	sta $fffe
	lda #>MainRasterPlayer
	sta $ffff
MainRasterRow2_edblock30564
	; Binary clause Simplified: EQUALS
	lda #$0
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterRow2_edblock30572
MainRasterRow2_ctb30570: ;Main true block ;keep 
	lda #$6
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterRow2_edblock30572
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRasterRow2
	
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
	; Toggle bit with constant
	lda $d01d
	ora #%10
	sta $d01d
	ldx #$1 ; optimized, look out for bugs
	lda #1
MainRasterRow1_shiftbit30576
	cpx #0
	beq MainRasterRow1_shiftbitdone30577
	asl
	dex
	jmp MainRasterRow1_shiftbit30576
MainRasterRow1_shiftbitdone30577
MainRasterRow1_bitmask_var30578 = $54
	sta MainRasterRow1_bitmask_var30578
	lda $d01d
	ora MainRasterRow1_bitmask_var30578
	sta $d01d
	
; // Set image pointers for row 0 — also transitions sprite 1 from UFO to enemy
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda row_has_monsters +$0 ; array with const index optimization 
	; cmp #$00 ignored
	beq MainRasterRow1_edblock30582
MainRasterRow1_ctb30580: ;Main true block ;keep 
	
; // Update first row of monsters only if there are monsters in that row
	lda #$0
	; Calling storevariable on generic assign expression
	sta rowOffset
	jsr UpdateMonsters
	
; // Set screen positions for row 0
	lda #$0
	; Calling storevariable on generic assign expression
	sta enemyRow
	jsr AnimateMonsters
MainRasterRow1_edblock30582
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda row_has_monsters +$1 ; array with const index optimization 
	; cmp #$00 ignored
	beq MainRasterRow1_eblock30587
MainRasterRow1_ctb30586: ;Main true block ;keep 
	
; // Choose next raster handler based on which subsequent rows still have monsters
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$13
	clc
	adc monster_base_y
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow2
	sta $fffe
	lda #>MainRasterRow2
	sta $ffff
	jmp MainRasterRow1_edblock30588
MainRasterRow1_eblock30587
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda row_has_monsters +$2 ; array with const index optimization 
	; cmp #$00 ignored
	beq MainRasterRow1_eblock30603
MainRasterRow1_ctb30602: ;Main true block ;keep 
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$2d
	clc
	adc monster_base_y
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow3
	sta $fffe
	lda #>MainRasterRow3
	sta $ffff
	jmp MainRasterRow1_edblock30604
MainRasterRow1_eblock30603
	; RasterIRQ : Hook a procedure
	lda #$de
	sta $d012
	lda #<MainRasterPlayer
	sta $fffe
	lda #>MainRasterPlayer
	sta $ffff
MainRasterRow1_edblock30604
MainRasterRow1_edblock30588
	; Binary clause Simplified: EQUALS
	lda #$0
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterRow1_edblock30612
MainRasterRow1_ctb30610: ;Main true block ;keep 
	lda #$2
	; Calling storevariable on generic assign expression
	sta $d020
MainRasterRow1_edblock30612
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRasterRow1
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
	lda flagGotoNextLevel
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainRasterChain_eblock30618
MainRasterChain_ctb30617: ;Main true block ;keep 
	
; // Schedule the next raster IRQ FIRST — before the SID player, before any game logic.
; // Reason: call(sidfile_1_play) takes 1000–3000 cycles (16–50 raster lines) and varies
; // per note.  If it runs before the RasterIRQ write and the target line is already past,
; // Row1/2/3 fires a full frame late → sprites show stale positions → visible flicker.
; // All inputs (flagGotoNextLevel, row_has_monsters, monster_base_y) are stable here:
; // UpdateTick and ClearMonster ran in MainRasterPlayer, which has already completed.
	lda #$0
	; Calling storevariable on generic assign expression
	sta flagGotoNextLevel
	jsr LevelAdvance
	jmp MainRasterChain_edblock30619
MainRasterChain_eblock30618
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda row_has_monsters +$0 ; array with const index optimization 
	; cmp #$00 ignored
	beq MainRasterChain_eblock30682
MainRasterChain_ctb30681: ;Main true block ;keep 
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda monster_base_y
	sec
	sbc #$4
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow1
	sta $fffe
	lda #>MainRasterRow1
	sta $ffff
	jmp MainRasterChain_edblock30683
MainRasterChain_eblock30682
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda row_has_monsters +$1 ; array with const index optimization 
	; cmp #$00 ignored
	beq MainRasterChain_eblock30714
MainRasterChain_ctb30713: ;Main true block ;keep 
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$13
	clc
	adc monster_base_y
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow2
	sta $fffe
	lda #>MainRasterRow2
	sta $ffff
	jmp MainRasterChain_edblock30715
MainRasterChain_eblock30714
	; Binary clause Simplified: NOTEQUALS
	clc
	; Load Byte array
	; CAST type NADA
	lda row_has_monsters +$2 ; array with const index optimization 
	; cmp #$00 ignored
	beq MainRasterChain_eblock30730
MainRasterChain_ctb30729: ;Main true block ;keep 
	; RasterIRQ : Hook a procedure
	; 8 bit binop
	; Add/sub where right value is constant number
	lda #$2d
	clc
	adc monster_base_y
	 ; end add / sub var with constant
	sta $d012
	lda #<MainRasterRow3
	sta $fffe
	lda #>MainRasterRow3
	sta $ffff
	jmp MainRasterChain_edblock30731
MainRasterChain_eblock30730
	; RasterIRQ : Hook a procedure
	lda #$de
	sta $d012
	lda #<MainRasterPlayer
	sta $fffe
	lda #>MainRasterPlayer
	sta $ffff
MainRasterChain_edblock30731
MainRasterChain_edblock30715
MainRasterChain_edblock30683
MainRasterChain_edblock30619
	
; // Game logic runs unconditionally — intermission uses separate chain
	jsr ShowBullet
	
; // Apply erosion every frame — now just a charset write, fast enough to run unconditionally.
	jsr ApplyShieldErosion
	
; // Position and animate the UFO BEFORE Row1 fires, so sprite 1 registers hold the
; // UFO values while the VIC-II scans through UFO_Y.
	jsr ShowUFO
	jsr UpdateUFO
	jsr ShowUFOBullet
	jsr UpdateUFOBullet
	jsr CheckEnemyShieldCollision
	jsr CheckEnemyShieldContact
	
; // Fire enemy shots from alien positions (column-table / player-tracking logic)
	jsr TickEnemyShotFiring
	
; //border_debug_color := peek(^$D01E, 0);
; //SCREEN_BG_COL := border_debug_color;
; //DisplayScore();
; // Clear sprite collision registers to remove garbage data
; //asm(" lda $D01E");
; //asm(" lda $D01F");
	jsr UpdatePlayerBullet
	
; // Update enemy shot movement/animation
; //UpdateEnemyShot();
; // Show enemy shot sprite if active
; //ShowEnemyShot();
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
	bne MainRasterChain_eblock30738
MainRasterChain_ctb30737: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda previous_fire_state
	; cmp #$00 ignored
	bne MainRasterChain_edblock30788
MainRasterChain_ctb30786: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda player_bullet_active
	; cmp #$00 ignored
	bne MainRasterChain_edblock30812
MainRasterChain_ctb30810: ;Main true block ;keep 
	
; //inc(border_debug_color);
	; Binary clause Simplified: EQUALS
	clc
	lda player_respawn_state
	; cmp #$00 ignored
	bne MainRasterChain_edblock30824
MainRasterChain_ctb30822: ;Main true block ;keep 
	
; // Check fire button with debounce (only fire on button press, not hold)
; // Disabled during player respawn sequence
	jsr FirePlayerBullet
MainRasterChain_edblock30824
MainRasterChain_edblock30812
MainRasterChain_edblock30788
	lda #$1
	; Calling storevariable on generic assign expression
	sta previous_fire_state
	jmp MainRasterChain_edblock30739
MainRasterChain_eblock30738
	lda #$0
	; Calling storevariable on generic assign expression
	sta previous_fire_state
MainRasterChain_edblock30739
	
; // Check player bullet vs UFO — must run after UpdatePlayerBullet so bullet position is current.
	jsr CheckUFOCollision
	
; // Check player bullet vs enemy bullets (shot-vs-shot collision)
; // Must run after both UpdatePlayerBullet and UpdateUFOBullet so positions are current.
; // Rolling/Teflon shot (slot 1) is immune; Plunger and Squiggly are destroyable.
	jsr CheckShotVsShotCollision
	
; // Check enemy bullets vs player ship — triggers respawn on hit
	jsr CheckEnemyShotPlayerCollision
	
; // Update player respawn/explosion animation
	jsr UpdatePlayerRespawn
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
; // Heavy game logic - UpdateTick may change monster_base_y (drop), but the Row
; // handlers always use the global monster_base_y when they fire, so sprites track
; // the updated position correctly even though the latch was written with the old value.
; //UpdateTick();
	; CloseIRQ
	pla
	tay
	pla
	tax
	pla
	rti
end_procedure_MainRasterChain
	
; // ---------------------------------------------------------------------------
; // LevelAdvance
; //   Called when all enemies are cleared.  Cycles current_level (1→9→1),
; //   resets board/bullet/march state, and repositions the formation for
; //   the new level (each level starts LEVEL_Y_STEP pixels lower).
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : LevelAdvance
	;    Procedure type : User-defined procedure
LevelAdvance
	
; // Increment both the display level (wraps at 9) and the persistent counter (never wraps)
	; Test Inc dec D
	inc current_level
	; Optimization: replacing a > N with a >= N+1
	; Binary clause Simplified: GREATEREQUAL
	lda current_level
	; Compare with pure num / var optimization
	cmp #$a;keep
	bcc LevelAdvance_edblock30832
LevelAdvance_ctb30830: ;Main true block ;keep 
	lda #$1
	; Calling storevariable on generic assign expression
	sta current_level
LevelAdvance_edblock30832
	; Test Inc dec D
	inc total_level_counter
	
; // Disable all sprites during intermission; LevelStart() re-enables them when
; // the player presses fire.
	; Assigning memory location
	lda #$0
	; Calling storevariable on generic assign expression
	sta $d015
	
; // -----------------------------------------------------------------------
; // All three calls below use ZP $24 / $68 for pointer variables (confirmed
; // in compiled ASM).  They MUST run here at I=1 (inside the IRQ handler)
; // so the SID play routine called from IntermissionChain every frame cannot
; // fire between pointer-low and pointer-high byte writes and corrupt them.
; // -----------------------------------------------------------------------
; // Pick starfield palette for the incoming level, repeating every 10 levels.
; // Stage the 6 colour bytes into globals and set pending_palette := 1.
; // IntermissionChain will call SetStarfieldColors at I=1 on the next frame,
; // avoiding the ZP $24 (StarField_color_mem) collision with the SID play routine.
	lda total_level_counter
	; Calling storevariable on generic assign expression
	sta advancelevel_palette_level
LevelAdvance_while30835
LevelAdvance_loopstart30839
	; Optimization: replacing a > N with a >= N+1
	; Binary clause Simplified: GREATEREQUAL
	lda advancelevel_palette_level
	; Compare with pure num / var optimization
	cmp #$a;keep
	bcc LevelAdvance_edblock30838
LevelAdvance_ctb30836: ;Main true block ;keep 
	; Optimizer: a = a +/- b
	; Load16bitvariable : advancelevel_palette_level
	lda advancelevel_palette_level
	sec
	sbc #$9
	sta advancelevel_palette_level
	jmp LevelAdvance_while30835
LevelAdvance_edblock30838
LevelAdvance_loopend30840
	; Binary clause Simplified: EQUALS
	lda advancelevel_palette_level
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne LevelAdvance_localfailed32664
	jmp LevelAdvance_ctb30844
LevelAdvance_localfailed32664
	jmp LevelAdvance_eblock30845
LevelAdvance_ctb30844: ;Main true block ;keep 
	lda #$6
	; Calling storevariable on generic assign expression
	sta pal_col1
	lda #$4
	; Calling storevariable on generic assign expression
	sta pal_col2
	lda #$c
	; Calling storevariable on generic assign expression
	sta pal_col3
	lda #$f
	; Calling storevariable on generic assign expression
	sta pal_col4
	lda #$e
	; Calling storevariable on generic assign expression
	sta pal_col5
	lda #$b
	; Calling storevariable on generic assign expression
	sta pal_col6
	jmp LevelAdvance_edblock30846
LevelAdvance_eblock30845
	; Binary clause Simplified: EQUALS
	lda advancelevel_palette_level
	; Compare with pure num / var optimization
	cmp #$2;keep
	bne LevelAdvance_localfailed33576
	jmp LevelAdvance_ctb32668
LevelAdvance_localfailed33576
	jmp LevelAdvance_eblock32669
LevelAdvance_ctb32668: ;Main true block ;keep 
	
; // Purple Haze
	lda #$b
	; Calling storevariable on generic assign expression
	sta pal_col1
	lda #$5
	; Calling storevariable on generic assign expression
	sta pal_col2
	lda #$e
	; Calling storevariable on generic assign expression
	sta pal_col3
	lda #$1
	; Calling storevariable on generic assign expression
	sta pal_col4
	lda #$7
	; Calling storevariable on generic assign expression
	sta pal_col5
	lda #$6
	; Calling storevariable on generic assign expression
	sta pal_col6
	jmp LevelAdvance_edblock32670
LevelAdvance_eblock32669
	; Binary clause Simplified: EQUALS
	lda advancelevel_palette_level
	; Compare with pure num / var optimization
	cmp #$3;keep
	bne LevelAdvance_localfailed34032
	jmp LevelAdvance_ctb33580
LevelAdvance_localfailed34032
	jmp LevelAdvance_eblock33581
LevelAdvance_ctb33580: ;Main true block ;keep 
	
; // RGB
	lda #$2
	; Calling storevariable on generic assign expression
	sta pal_col1
	lda #$4
	; Calling storevariable on generic assign expression
	sta pal_col2
	lda #$7
	; Calling storevariable on generic assign expression
	sta pal_col3
	lda #$1
	; Calling storevariable on generic assign expression
	sta pal_col4
	lda #$e
	; Calling storevariable on generic assign expression
	sta pal_col5
	lda #$6
	; Calling storevariable on generic assign expression
	sta pal_col6
	jmp LevelAdvance_edblock33582
LevelAdvance_eblock33581
	; Binary clause Simplified: EQUALS
	lda advancelevel_palette_level
	; Compare with pure num / var optimization
	cmp #$4;keep
	bne LevelAdvance_localfailed34260
	jmp LevelAdvance_ctb34036
LevelAdvance_localfailed34260
	jmp LevelAdvance_eblock34037
LevelAdvance_ctb34036: ;Main true block ;keep 
	
; // Various			
	lda #$6
	; Calling storevariable on generic assign expression
	sta pal_col1
	lda #$5
	; Calling storevariable on generic assign expression
	sta pal_col2
	lda #$c
	; Calling storevariable on generic assign expression
	sta pal_col3
	lda #$f
	; Calling storevariable on generic assign expression
	sta pal_col4
	lda #$d
	; Calling storevariable on generic assign expression
	sta pal_col5
	lda #$b
	; Calling storevariable on generic assign expression
	sta pal_col6
	jmp LevelAdvance_edblock34038
LevelAdvance_eblock34037
	; Binary clause Simplified: EQUALS
	lda advancelevel_palette_level
	; Compare with pure num / var optimization
	cmp #$5;keep
	bne LevelAdvance_localfailed34374
	jmp LevelAdvance_ctb34264
LevelAdvance_localfailed34374
	jmp LevelAdvance_eblock34265
LevelAdvance_ctb34264: ;Main true block ;keep 
	
; // Jungle Green				
	lda #$2
	; Calling storevariable on generic assign expression
	sta pal_col1
	lda #$8
	; Calling storevariable on generic assign expression
	sta pal_col2
	lda #$c
	; Calling storevariable on generic assign expression
	sta pal_col3
	lda #$1
	; Calling storevariable on generic assign expression
	sta pal_col4
	lda #$7
	; Calling storevariable on generic assign expression
	sta pal_col5
	lda #$9
	; Calling storevariable on generic assign expression
	sta pal_col6
	jmp LevelAdvance_edblock34266
LevelAdvance_eblock34265
	; Binary clause Simplified: EQUALS
	lda advancelevel_palette_level
	; Compare with pure num / var optimization
	cmp #$6;keep
	bne LevelAdvance_localfailed34431
	jmp LevelAdvance_ctb34378
LevelAdvance_localfailed34431
	jmp LevelAdvance_eblock34379
LevelAdvance_ctb34378: ;Main true block ;keep 
	
; // Lava		
	lda #$6
	; Calling storevariable on generic assign expression
	sta pal_col1
	lda #$e
	; Calling storevariable on generic assign expression
	sta pal_col2
	lda #$c
	; Calling storevariable on generic assign expression
	sta pal_col3
	lda #$1
	; Calling storevariable on generic assign expression
	sta pal_col4
	lda #$3
	; Calling storevariable on generic assign expression
	sta pal_col5
	lda #$b
	; Calling storevariable on generic assign expression
	sta pal_col6
	jmp LevelAdvance_edblock34380
LevelAdvance_eblock34379
	; Binary clause Simplified: EQUALS
	lda advancelevel_palette_level
	; Compare with pure num / var optimization
	cmp #$7;keep
	bne LevelAdvance_eblock34436
LevelAdvance_ctb34435: ;Main true block ;keep 
	
; // Ice Blue					
	lda #$2
	; Calling storevariable on generic assign expression
	sta pal_col1
	lda #$8
	; Calling storevariable on generic assign expression
	sta pal_col2
	lda #$1
	; Calling storevariable on generic assign expression
	sta pal_col3
	lda #$7
	; Calling storevariable on generic assign expression
	sta pal_col4
	; Calling storevariable on generic assign expression
	sta pal_col5
	lda #$9
	; Calling storevariable on generic assign expression
	sta pal_col6
	jmp LevelAdvance_edblock34437
LevelAdvance_eblock34436
	; Binary clause Simplified: EQUALS
	lda advancelevel_palette_level
	; Compare with pure num / var optimization
	cmp #$8;keep
	bne LevelAdvance_eblock34464
LevelAdvance_ctb34463: ;Main true block ;keep 
	
; // Gold
	lda #$b
	; Calling storevariable on generic assign expression
	sta pal_col1
	lda #$e
	; Calling storevariable on generic assign expression
	sta pal_col2
	lda #$c
	; Calling storevariable on generic assign expression
	sta pal_col3
	lda #$1
	; Calling storevariable on generic assign expression
	sta pal_col4
	lda #$f
	; Calling storevariable on generic assign expression
	sta pal_col5
	lda #$b
	; Calling storevariable on generic assign expression
	sta pal_col6
	jmp LevelAdvance_edblock34465
LevelAdvance_eblock34464
	
; // Red
	; Binary clause Simplified: EQUALS
	lda advancelevel_palette_level
	; Compare with pure num / var optimization
	cmp #$9;keep
	bne LevelAdvance_edblock34479
LevelAdvance_ctb34477: ;Main true block ;keep 
	
; // Christmas		
	lda #$2
	; Calling storevariable on generic assign expression
	sta pal_col1
	lda #$4
	; Calling storevariable on generic assign expression
	sta pal_col2
	lda #$c
	; Calling storevariable on generic assign expression
	sta pal_col3
	lda #$f
	; Calling storevariable on generic assign expression
	sta pal_col4
	lda #$a
	; Calling storevariable on generic assign expression
	sta pal_col5
	lda #$9
	; Calling storevariable on generic assign expression
	sta pal_col6
LevelAdvance_edblock34479
LevelAdvance_edblock34465
LevelAdvance_edblock34437
LevelAdvance_edblock34380
LevelAdvance_edblock34266
LevelAdvance_edblock34038
LevelAdvance_edblock33582
LevelAdvance_edblock32670
LevelAdvance_edblock30846
	lda #$1
	; Calling storevariable on generic assign expression
	sta pending_palette
	; Binary clause Simplified: LESS
	lda total_level_counter
	; Compare with pure num / var optimization
	cmp #$7;keep
	bcs LevelAdvance_edblock34485
LevelAdvance_ctb34483: ;Main true block ;keep 
	
; // Restore shields — IRQ-safe: glyph copies use inline ASM (no ZP);
; // surface scan wrapped in PreventIRQ/EnableIRQ inside CopyShieldSprites.
	jsr CopyShieldSprites
LevelAdvance_edblock34485
	
; // Signal the main-context polling loop to run ReadyMonsters + MakeMonsters.
; // Those are wrapped in PreventIRQ/EnableIRQ there to protect ZP $24/$68 from
; // the SID play routine that fires every frame via IntermissionChain.
	lda #$0
	; Calling storevariable on generic assign expression
	sta level_advance_ready
	lda #$1
	; Calling storevariable on generic assign expression
	sta level_advance_pending
	
; // Enter intermission mode.
	; Calling storevariable on generic assign expression
	sta get_ready_mode
	lda #$0
	; Calling storevariable on generic assign expression
	sta get_ready_prev_fire
	lda #$1
	; Calling storevariable on generic assign expression
	sta level_dirty
	
; // Install intermission raster chain — music resumes on the very next frame.
	; RasterIRQ : Hook a procedure
	lda #$0
	sta $d012
	lda #<IntermissionChain
	sta $fffe
	lda #>IntermissionChain
	sta $ffff
	rts
end_procedure_LevelAdvance
	
; // ---------------------------------------------------------------------------
; // CreateSolidBlock
; //   Fills character code 108 completely with lit pixels ($FF) to create
; //   a solid block character. Character 108 is at charset_base + 108*8.
; //   Using standard C64 charset at $3000: character 108 = $3360.
; // ---------------------------------------------------------------------------
	; NodeProcedureDecl -1
	; ***********  Defining procedure : CreateSolidBlock
	;    Procedure type : User-defined procedure
CreateSolidBlock
        lda #$FF
        ldx #7
csb_loop sta $3370,x
        dex
        bpl csb_loop
	
	rts
end_procedure_CreateSolidBlock
block1
main_block_begin_
	
; // ---------------------------------------------------------------------------------------------------------------------------------
; // Main program loop. Turn CIA interrupts off, copy the character set from ROM into RAM and tell the machine to look at CharSetLoc
; // for its character set, initialise the pointers and start the raster chain off.
; // ---------------------------------------------------------------------------------------------------------------------------------
	; Clear screen with offset
	lda #$e
	ldx #$fa
MainProgram_clearloop34489
	dex
	sta $0000+$d800,x
	sta $00fa+$d800,x
	sta $01f4+$d800,x
	sta $02ee+$d800,x
	bne MainProgram_clearloop34489
	;MakeSprites();
; //	
; //	InitSid(sidfile_1_init);
; //	DisableCIAInterrupts();
; //	SetMemoryConfig(1, 0, 0);
; //	
; //	SCREEN_BG_COL:=BLACK;
; //    SCREEN_FG_COL:=BLACK;
; //	
; //	
; // Clear sprite collision registers to remove garbage data
; //	asm(" lda $D01E");
; //	asm(" lda $D01F");
; //		
; //	
; //	StarField::CreateStarScreen();
; //	
; //	EnableRasterIrq();	
; //	DisplayText();
; //	
; //	
; // Show "Get Ready" screen for the first level before starting play.
; //	
; // AdvanceLevel will increment current_level from 0 to 1, display intermission screen,
; //	
; // and install the IntermissionChain raster handler.
; //	
; //dec(current_level);
; //	
; //dec(total_level_counter);
; //	
; //	
; //	
; // AdvanceLevel installed IntermissionChain, now safe to enable IRQs
; //	RasterIRQ(MainRasterChain(),0,0);
; //	
; //RasterIRQ(IntermissionChain(), 0, 0);
; //	
; //	enableirq();
; //
; //	
; // Non-IRQ SID playback (main context). This runs once during init and is safe
; //	
; // to execute outside the raster IRQ. Comment/uncomment to test.
; //	
; //call(sidfile_1_play); 
; // main-context playback (disabled)
; //	
; //call(sidfile_1_play); 
; // alternative: keep commented if you prefer raster IRQ playback
; //
; //	Loop();
	jsr MakeSprites
	; initsid
	lda #0
	tax
	tay
	jsr $1000
	
; //disableciainterrupts();
; //setmemoryconfig(1,0,0);
	; Disable interrupts
	ldy #$7f    ; $7f = %01111111
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
	
; // Clear sprite collision registers to remove garbage data
; //asm(" lda $D01E");
; //asm(" lda $D01F");
	jsr StarField_CreateStarScreen
	;const StarColour1 : byte = 6;   
; // Blue
; //	const StarColour2 : byte = 4;   
; // Purple
; //	const StarColour3 : byte = 12;  
; // Grey 
; //	const StarColour4 : byte = 15;  
; // Light_Grey
; //	const StarColour5 : byte = 14;  
; // Light Blue
; //	const StarColour6 : byte = 11;  
; // Grey Dark
; // IO area visible at $D000-$DFFF, RAM visible at $A000-$BFFF (NO BASIC) and RAM visible at $E000-$FFFF (NO KERNAL). 
; // This is the typical memory configuration for demo/game development. 
	; Set Memory Config
	lda $01
	and #%11111000
	ora #%101
	sta $01
	
; // SEI: keep I=1 for the entire init sequence.
; // InitSid (jsr $1000) is opaque SID machine code that may call CLI internally.
; // We must ensure I=1 from here until we have a valid IRQ handler installed,
; // otherwise any raster interrupt (once armed) jumps through a garbage $FFFE/$FFFF
; // vector (Kernal is banked out, that address is uninitialized RAM) and crashes.
; //PreventIRQ();
	jsr DisplayText
	jsr ResetGameState
	; RasterIRQ : Hook a procedure
	lda #$0
	sta $d012
	lda #<StartupChain
	sta $fffe
	lda #>StartupChain
	sta $ffff
	
; // ONLY NOW arm the VIC raster IRQ hardware, and ONLY NOW open the CPU interrupt gate.
; // This order is mandatory: vector first, hardware enable second, CLI last.
	; Enable raster IRQ
	lda $d01a
	ora #$01
	sta $d01a
	lda #$1B
	sta $d011
	asl $d019
	cli
	
; // CLI — first raster interrupt fires safely into IntermissionChain
; // Non-IRQ SID playback (main context). This runs once during init and is safe
; // to execute outside the raster IRQ. Comment/uncomment to test.
; //call(sidfile_1_play); 
; // main-context playback (disabled)
; //call(sidfile_1_play); 
; // alternative: keep commented if you prefer raster IRQ playback
	jsr CreateSolidBlock
MainProgram_while34490
MainProgram_loopstart34494
	; Binary clause Simplified: NOTEQUALS
	clc
	lda #$1
	; cmp #$00 ignored
	beq MainProgram_edblock34493
MainProgram_ctb34491: ;Main true block ;keep 
	; Binary clause Simplified: EQUALS
	clc
	lda total_level_counter
	; cmp #$00 ignored
	bne MainProgram_edblock34514
MainProgram_localsuccess34516: ;keep
	; ; logical AND, second requirement
	; Binary clause Simplified: EQUALS
	lda startUpDirty
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainProgram_edblock34514
MainProgram_ctb34512: ;Main true block ;keep 
	
; //loop();
; // Main context spin-loop: raster IRQs preempt freely here, so music advances
; // every frame while MakeMonsters() is executing.
; // Startup menu starts at level 0 and lets player pick level 1-9.
	lda #$1
	; Calling storevariable on generic assign expression
	sta startup_mode
	; Calling storevariable on generic assign expression
	sta current_level
	lda #$0
	; Calling storevariable on generic assign expression
	sta total_level_counter
	lda #$1
	; Calling storevariable on generic assign expression
	sta startup_prev_inputs
	lda #$0
	; Calling storevariable on generic assign expression
	sta startUpDirty
	jsr ShowStartupText
MainProgram_edblock34514
	
; // ungate fire-to-start in IntermissionChain
	; Binary clause Simplified: EQUALS
	lda level_advance_pending
	; Compare with pure num / var optimization
	cmp #$1;keep
	bne MainProgram_edblock34521
MainProgram_ctb34519: ;Main true block ;keep 
	lda #$0
	; Calling storevariable on generic assign expression
	sta level_advance_pending
	
; // Palette, ShowGetReadyText, and CopyShieldSprites were moved to LevelAdvance()
; // so they run at I=1 — immune to the SID play routine corrupting ZP $24/$68.
; //
; // ReadyMonsters uses inline ASM with absolute indexed addressing — no ZP
; // pointers touched, fully IRQ-safe. PreventIRQ/EnableIRQ no longer needed.
	jsr ReadyMonsters
	
; //PreventIRQ();
	jsr PreclearLeftmostAndBottomEnemies
	
; //EnableIRQ();
; // MakeMonsters uses no ZP pointer variables — runs safely with IRQs enabled.
	jsr MakeMonsters
	lda #$1
	; Calling storevariable on generic assign expression
	sta level_advance_ready
MainProgram_edblock34521
	
; //if (score_dirty = 1) then
	jsr DisplayScore
	; Disable interrupts
	ldy #$7f    ; $7f = %01111111
	sty $dc0d   ; Turn off CIAs Timer interrupts ;keep
	sty $dd0d   ; Turn off CIAs Timer interrupts ;keep
	lda $dc0d   ; cancel all CIA-IRQs in queue/unprocessed ;keep
	lda $dd0d   ; cancel all CIA-IRQs in queue/unprocessed ;keep
	jsr DisplayHighScore
	jsr DisplayLevel
	jsr DisplayLives
	asl $d019
	cli
	jmp MainProgram_while34490
MainProgram_edblock34493
MainProgram_loopend34495
main_block_end_
	; End of program
	; Ending memory block at $4800
ShowStartupText_stringassignstr8836		dc.b	"nnnnnnnn"
	dc.b	0
ShowStartupText_stringassignstr8838		dc.b	"nnnnnn"
	dc.b	0
ShowStartupText_stringassignstr8840		dc.b	"nn"
	dc.b	0
ShowStartupText_stringassignstr8842		dc.b	"nnnnnnnnnn"
	dc.b	0
ShowStartupText_stringassignstr8844		dc.b	"nnnnnnnnnnnn"
	dc.b	0
ShowStartupText_stringassignstr8846		dc.b	"nnnnnnnn"
	dc.b	0
ShowStartupText_stringassignstr8848		dc.b	"nn"
	dc.b	0
ShowStartupText_stringassignstr8850		dc.b	"nn"
	dc.b	0
ShowStartupText_stringassignstr8852		dc.b	"nn"
	dc.b	0
ShowStartupText_stringassignstr8854		dc.b	"nn"
	dc.b	0
ShowStartupText_stringassignstr8856		dc.b	"nn"
	dc.b	0
ShowStartupText_stringassignstr8858		dc.b	"nn"
	dc.b	0
ShowStartupText_stringassignstr8860		dc.b	"nn"
	dc.b	0
ShowStartupText_stringassignstr8862		dc.b	"nnnnnnnnnnnnnnnn"
	dc.b	0
ShowStartupText_stringassignstr8864		dc.b	"nnnnnnnn"
	dc.b	0
ShowStartupText_stringassignstr8866		dc.b	"nnn"
	dc.b	0
ShowStartupText_stringassignstr8868		dc.b	"nn"
	dc.b	0
ShowStartupText_stringassignstr8870		dc.b	"nnn"
	dc.b	0
ShowStartupText_stringassignstr8872		dc.b	"nn"
	dc.b	0
ShowStartupText_stringassignstr8874		dc.b	"n"
	dc.b	0
ShowStartupText_stringassignstr8876		dc.b	"n"
	dc.b	0
ShowStartupText_stringassignstr8878		dc.b	"nn"
	dc.b	0
ShowStartupText_stringassignstr8880		dc.b	"nn"
	dc.b	0
ShowStartupText_stringassignstr8882		dc.b	"nnnnnnnn"
	dc.b	0
ShowStartupText_stringassignstr8884		dc.b	"INVADERS"
	dc.b	0
ShowStartupText_stringassignstr8886		dc.b	"MMXXVI"
	dc.b	0
ShowStartupText_stringassignstr8888		dc.b	"FIRE"
	dc.b	0
ShowStartupText_stringassignstr8890		dc.b	"BUTTON"
	dc.b	0
ShowStartupText_stringassignstr8892		dc.b	"TO"
	dc.b	0
ShowStartupText_stringassignstr8894		dc.b	"START"
	dc.b	0
ShowStartupText_stringassignstr8896		dc.b	"LEVEL"
	dc.b	0
ShowStartupText_stringassignstr8898		dc.b	"SELECT"
	dc.b	0
ShowStartupText_stringassignstr8900		dc.b	"("
	dc.b	0
ShowStartupText_stringassignstr8902		dc.b	")"
	dc.b	0
DisplayText_stringassignstr28562		dc.b	"  HI-SCORE"
	dc.b	0
DisplayText_stringassignstr28564		dc.b	"     SCORE"
	dc.b	0
DisplayText_stringassignstr28566		dc.b	"     LEVEL"
	dc.b	0
DisplayText_stringassignstr28568		dc.b	"     LIVES"
	dc.b	0
DisplayText_stringassignstr28570		dc.b	"   "
	dc.b	0
DisplayText_stringassignstr28572		dc.b	"   "
	dc.b	0
DisplayText_stringassignstr28574		dc.b	"   "
	dc.b	0
DisplayText_stringassignstr28576		dc.b	"   "
	dc.b	0
DisplayText_stringassignstr28578		dc.b	"   "
	dc.b	0
DisplayText_stringassignstr28580		dc.b	"   "
	dc.b	0
DisplayText_stringassignstr28582		dc.b	"   "
	dc.b	0
DisplayText_stringassignstr28584		dc.b	"   "
	dc.b	0
DisplayText_stringassignstr28586		dc.b	"ooooooooooooooooooooooooooooo"
	dc.b	0
EndBlock4800:

