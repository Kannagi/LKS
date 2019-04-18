.include "header.asm"
.include "snes.asm"

.include "MC_libks.asm"

.include "variable.asm"

.MACRO LKS_SPRITE_MOVE_SPD

	clc
	lda LKS_SPRITE.PX,x
	adc LKS_SPRITE.VX,x
	sta LKS_SPRITE.PX,x
	
	clc
	lda LKS_SPRITE.PY,x
	adc LKS_SPRITE.VY,x
	sta LKS_SPRITE.PY,x
	
.ENDM

.MACRO	PAL_WRAM

	lda #:\1
	ldx #\1
	
	stx LKS_PAL+$10+(3*\2)
	sta LKS_PAL+$10+(3*\2)+2
	
.ENDM

.MACRO	LKS_INIT_BG

	lda #:\2
	ldx #\2
	
	stx LKS_BG.Address1+0
	sta LKS_BG.Address1+2
	
	lda #:\1
	ldx #\1
	
	stx LKS_BG.Address2+0
	sta LKS_BG.Address2+2
	
	ldx #$10*\3
	stx LKS_BG.limitex
	
	ldx #$20*\4
	stx LKS_BG.addy
	
	ldx #$10*\4
	stx LKS_BG.limitey
	
	ldx #2*\4
	stx LKS_BG.addyr
	
	lda #:\5
	ldx #\5
	
	stx LKS_BG.Addressc+0
	sta LKS_BG.Addressc+2
	
	
.ENDM

.MACRO LKS_SPRITE_DRAW

	ldx LKS_SPRITE.OAM
	
	lda LKS_SPRITE.X+($20*\1)
	sta LKS_BUF_OAML+0,x

	lda LKS_SPRITE.Y+($20*\1)
	sta LKS_BUF_OAML+1,x
	
	lda LKS_SPRITE.Tile+($20*\1)
	sta LKS_BUF_OAML+2,x
	
	lda LKS_SPRITE.Flip+($20*\1)
	sta LKS_BUF_OAML+3,x

.ENDM

.MACRO LKS_SPRITE_INIT

	rep #$20
	lda #\1
	sta LKS_SPRITE.X,x
	
	lda #\1<<2
	sta LKS_SPRITE.PX,x
	
	lda #\2
	sta LKS_SPRITE.Y,x
	
	lda #\2<<2
	sta LKS_SPRITE.PY,x
	
	lda #4*\6
	sta LKS_SPRITE.OAM,x
	
	sep #$20
	
	lda #\3
	sta LKS_SPRITE.Tile,x
	
	lda #$20+\4
	sta LKS_SPRITE.Flip,x
	
	lda #\5
	sta LKS_SPRITE.Ext,x
.ENDM

.MACRO LKS_SPRITE_ANIM_INIT

	stz LKS_SPRITE.Anim_i,x
	stz LKS_SPRITE.Anim_l,x
	stz LKS_SPRITE.Anim_old,x
	stz LKS_SPRITE.Anim_end,x
	
	lda #\1
	sta LKS_SPRITE.Anim_flg,x
	
	lda #\2
	sta LKS_SPRITE.Anim_act,x
	
	lda #\3
	sta LKS_SPRITE.Anim_v,x
	
	lda #\4
	sta LKS_SPRITE.Anim_n,x
.ENDM

.MACRO LKS_DMA_INIT

	lda #1
	sta LKS_DMA.Enable,x
	
	lda #:\1
	sta LKS_DMA.Bank,x
	
	rep #$20
	
	lda #\1
	sta LKS_SPRITE.Address,x
	sta LKS_DMA.Src1,x
	
	lda #\2/(1+\6)
	sta LKS_DMA.Size1,x
	
	lda #(\2/5.12)+18 + (5*\6)
	sta LKS_DMA.dmat,x
	
	lda #4*\3
	sta LKS_DMA.SrcR,x
	
	lda #\4
	sta LKS_DMA.Dst1,x
	
	lda #\5
	sta LKS_DMA.Func,x

	sep #$20
.ENDM

Int:
	
	rti
	
Main:
	SNES_INIT0
	rep #$10	;16 bit xy
	sep #$20	; 8 bit a

	SNES_INIDISP $8F
	SNES_NMITIMEN $00
	jsl LKS_Clear_RAM
	SNES_INIT
Start:

	jsl LKS_INIT

	LKS_Clear_VRAM
	
	jsl Map_Tile1
	SNES_TS $11
	    
	SNES_CGSWSEL $02
	SNES_CGADSUB $42
	
	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	LKS_INIT_BG map3_A,map3_B,64,64,Map1c
	
	LKS_INIT_BG map1,map2,64,64,Map1c
	
	jsl LKS_Background1
	jsl LKS_Background2

	;load font
	LKS_LOAD_VRAM $4000,$00,bpp_font,$400
	LKS_LOAD_CG $00,bpp_fontpal,$10
	
	;load sprite
	LKS_LOAD_CG $80,Papi_pal,$20

	ldx #0
	LKS_SPRITE_INIT 40,40,0,$00,$AA,64
	LKS_SPRITE_ANIM_INIT $10,0,9,4
	LKS_DMA_INIT Papi,$100,128,$6000,LKS_DMA_VRAM1x2,1

	ldx #$20*1
	LKS_SPRITE_INIT 240,80,8,$00,$AA,68
	LKS_SPRITE_ANIM_INIT $10,2,9,4
	LKS_DMA_INIT Papi,$100,128,$6080,LKS_DMA_VRAM1x2,1
	
	jsl LKS_GAMELOOP_INIT
	Game:
		;jsl LKS_Fade_in
		
		SNES_DMAX $00
		SNES_DMAX_BADD $80
		
		jsl LKS_Joypad
		
		jsl LKS_OAM_Clear
		
		
		
		ldx #0
		ldy #0
		
		lda LKS_STDCTRL+_UP
		cmp #2
		bne +
			ldx #-$04-2
			lda #1
			sta SCharacter.direction
			
			lda #2*2
			sta LKS_SPRITE.Anim_act
		+:
		
		lda LKS_STDCTRL+_DOWN
		cmp #2
		bne +
			ldx #$04+2
			lda #0
			sta SCharacter.direction
			
			lda #2*0
			sta LKS_SPRITE.Anim_act
		+:
		
		lda LKS_STDCTRL+_LEFT
		cmp #2
		bne +
			ldy #-$04-2
			lda #2
			sta SCharacter.direction
			
			lda #2*1
			sta LKS_SPRITE.Anim_act
			
			lda LKS_SPRITE.Flip
			and #$3F
			sta LKS_SPRITE.Flip
		+:
		
		
		lda LKS_STDCTRL+_RIGHT
		cmp #2
		bne +
			ldy #$04+2
			lda #3
			sta SCharacter.direction
			
			lda #2*1
			sta LKS_SPRITE.Anim_act
			
			lda LKS_SPRITE.Flip
			ora #$40
			sta LKS_SPRITE.Flip
		+:
		
		stx LKS_SPRITE.VY
		sty LKS_SPRITE.VX

		;Papi
		ldy #$20*0
		jsl LKS_Collision_Map
		jsl LKS_Sprite_Move
		jsl LKS_Background_Camera
		jsl LKS_Scrolling_limite
		
		jsl LKS_Sprite_Draw_32x32_2x2
		jsl LKS_Sprite_Anim
		jsl LKS_Sprite_DMA
		
		
		;ldx #9
		-:
			phx
			ldy #$20*1
			jsl LKS_Collision_Map
			jsl LKS_Sprite_Move
			jsl LKS_Sprite_Draw_32x32_2x2
			jsl LKS_Sprite_Anim
			jsl LKS_Sprite_DMA
			plx
			dex
			;cpx #1
		;bne -
		
		
		
		jsl LKS_Scrolling		
		
		jsr Text_draw
		
		jsl LKS_DMA_SORT
		
		jsl WaitVBlank

    jmp Game
    
.MACRO LKS_COLLISION_MAP
	

	lda LKS_SPRITE.PX,y
	clc
	adc #\2<<2
	.if \1 == 0
	adc LKS_SPRITE.VX,y
	.endif
	
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	sta MEM_TEMP
	
	
	lda LKS_SPRITE.PY,y
	clc
	adc #\3<<2
	
	.if \1 == 1
	adc LKS_SPRITE.VY,y
	.endif
	
	asl
	asl
	and #$FF00
	ora #$0010
	sta WRMPYA
	LKS_cycle8
	lda RDMPYL
	asl
	asl
	
	; xxxx xxxx xxxx xx.ff
	; $FFC0
	clc
	adc MEM_TEMP
	adc LKS_BG.Addressc
	sta MEM_TEMP
	
	
	
	lda LKS_BG.Addressc+2
	sta LKS_ZP+2 
	
	phy
	ldy MEM_TEMP
		
	lda [LKS_ZP],y
	sta MEM_TEMP
	
	ply
	
.ENDM

.MACRO LKS_COLLISION_MAP0
	lda LKS_BG.Addressc+2
	sta LKS_ZP+2
	lda LKS_BG.Addressc
	sta LKS_ZP
	
	lda LKS_SPRITE.PX,y
	clc
	adc #8<<2
	adc LKS_SPRITE.VX,y

	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	sta MEM_TEMP+0
	
	lda LKS_SPRITE.PX,y
	clc
	adc #8<<2

	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	sta MEM_TEMP+2
	
	;----------------
	lda LKS_SPRITE.PY,y
	clc
	adc #$10<<2
	adc LKS_SPRITE.VY,y
	asl
	asl
	and #$FF00
	ora #$0010
	sta WRMPYA
	LKS_cycle8
	lda RDMPYL
	asl
	asl
	sta MEM_TEMP+4
	
	lda LKS_SPRITE.PY,y
	clc
	adc #$10<<2
	asl
	asl
	and #$FF00
	ora #$0010
	sta WRMPYA
	LKS_cycle8
	lda RDMPYL
	asl
	asl
	sta MEM_TEMP+6
.ENDM



.MACRO LKS_COLLISION_MAP1

	lda MEM_TEMP+(2*\1)
	clc
	adc MEM_TEMP+(2*\2)
	sta MEM_TEMP +8
	adc #64
	
	tay
	lda [LKS_ZP],y
	sta MEM_TEMP +10
		
	lda MEM_TEMP +8
	tay
	lda [LKS_ZP],y
	
	
.ENDM
LKS_Collision_Map2:
	
	rep #$20
	tyx
	phy
	
	LKS_COLLISION_MAP0
	
	LKS_COLLISION_MAP1 0,3 ;vx
	bit #$101
	beq +
		lda #0
		sta LKS_SPRITE.VX,x
	+:
	
	lda MEM_TEMP+10
	bit #$101
	beq +
		lda #0
		sta LKS_SPRITE.VX,x
	+:
	lda LKS_SPRITE.VX,x
	
	LKS_COLLISION_MAP1 1,2 ;vy
	bit #$0101
	beq +
		lda #0
		sta LKS_SPRITE.VY,x
	+:

	lda MEM_TEMP+10
	bit #$101
	beq +
		lda #0
		sta LKS_SPRITE.VY,x
	+:

	
	ply
	sep #$20

	rtl
	
LKS_Collision_Map:
	
	rep #$20
	;X
	LKS_COLLISION_MAP 0,8,$1C
	bit #1
	beq +
		lda #0
		sta LKS_SPRITE.VX,y
	+:
	bit #$100
	beq +
		lda #0
		sta LKS_SPRITE.VX,y
	+:

	;Y
	LKS_COLLISION_MAP 1,8,$1C
	bit #1
	beq +
		lda #0
		sta LKS_SPRITE.VY,y
	+:
	bit #$100
	beq +
		lda #0
		sta LKS_SPRITE.VY,y
	+:
	
	sep #$20
	
	rtl
    
Draw_Game:



	rts
 
LKS_Sprite_Anim:

	tyx
	
	stz MEM_RETURN
	
	lda LKS_SPRITE.Anim_act,x
    cmp LKS_SPRITE.Anim_old,x
    beq +
		sta LKS_SPRITE.Anim_old,x
		stz LKS_SPRITE.Anim_l,x
		stz LKS_SPRITE.Anim_i,x
		lda #$80
		sta MEM_RETURN
    +:

	inc LKS_SPRITE.Anim_l,x
    lda LKS_SPRITE.Anim_l,x
    cmp LKS_SPRITE.Anim_v,x
    bne +
		stz LKS_SPRITE.Anim_l,x
		inc LKS_SPRITE.Anim_i,x
		lda #$80
		sta MEM_RETURN
    +:

    stz LKS_SPRITE.Anim_end,x
    lda LKS_SPRITE.Anim_i,x
    cmp LKS_SPRITE.Anim_n,x
    bne +
		stz LKS_SPRITE.Anim_l,x
		stz LKS_SPRITE.Anim_i,x
		sta LKS_SPRITE.Anim_end,x
		lda #$80
		sta MEM_RETURN
    +:
    
    
    lda LKS_SPRITE.Anim_flg,x
    and #$7F
    ora MEM_RETURN
    sta LKS_SPRITE.Anim_flg,x
 
	rtl
    
LKS_Sprite_DMA:

	lda LKS_SPRITE.Anim_flg,x
	bit #$80
	beq +
		rtl
	+:
	
    ;Anim Y
    lda LKS_SPRITE.Anim_act,x
    asl
    asl
    asl
	sta WRMPYA
	
	lda #$80
	sta WRMPYB
	
	rep #$20
	lda LKS_SPRITE.Anim_flg,x
	and #$30
	asl
	clc 
	adc #$20
	sta MEM_TEMP
	
	lda RDMPYL
	sta MEM_TEMP+4
	
	sep #$20
    
    ;Anim X
    lda LKS_SPRITE.Anim_i,x
	sta WRMPYA
	
	lda MEM_TEMP
	sta WRMPYB
	
	nop
	nop
	rep #$20
	stx MEM_TEMP

	lda RDMPYL
	asl
	sta MEM_TEMP+2
		
	;Send
	lda LKS_SPRITE.Address,x
	clc
	adc MEM_TEMP+2
	adc MEM_TEMP+4
	sta LKS_DMA.Src1,x
	
	lda LKS_DMA_SEND.i
	tax
	adc #2
	sta LKS_DMA_SEND.i
	
	lda MEM_TEMP
	sta LKS_DMA_SEND.index,x
	
	sep #$20
	
	rtl
  
Text_draw:

	LKS_printf_setpal 1 ; select pal 1
	ldx	#text_s1
	LKS_printfs 1,2
	
	LKS_printf_setpal 0 ; select pal 0
	ldx	#text_s1
	LKS_printfs 1,1
	
	lda LKS_CPU
	LKS_printf8u 1,3
	
	ldy LKS_DEBUG
	LKS_printf16u 1,5
	
	ldy LKS_VBLANK+_vbltime
	LKS_printf16u 1,0
	
	
	ldy LKS_DEBUG+2
	LKS_printf16h 1,6
	
	ldy #LKS_STDCTRL&$FFFF
	LKS_printf16h 8,0
	
	rts
	
text_s1:
	.db "hello world",0

    


	.include "libksbk.asm"
	.include "load_map.asm"
	.include "libks.asm"
	
bpp_font:
	.incbin "DATA/fontm.spr"
bpp_fontpal:
    .db $E7, $1C, $42, $08, $94, $52, $7b, $6f
    .db $E7, $1C, $80, $10, $08, $52, $60, $6f
   

.bank 1 slot 0
.org 0


	.include "data.asm"

	

