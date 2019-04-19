.include "header.asm"
.include "snes.asm"

.include "MC_libks.asm"



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
	
	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	;load font
	LKS_LOAD_VRAM $4000,$00,bpp_font,$400
	LKS_LOAD_CG $00,bpp_fontpal,$10
	
	;load Sprite pal
	LKS_LOAD_CG $80,Player_pal,$20
	
	;Sprite Engine
	ldx #$20*0 ; Sprite n'0
	LKS_SPRITE_INIT 40,40,0,$00,$AA,64 ; X,Y,Tile,Flip+PAL,Ext,OAM
	LKS_SPRITE_ANIM_INIT $18,0,9,4 ; Size,act,cadence,n
	LKS_DMA_INIT Player,$100,128,$6000,1 ;Data,Size,largeur,VRAM,Func DMA
	
	jsl LKS_GAMELOOP_INIT
	Game:
		jsl LKS_Fade_in
		
		SNES_DMAX $00
		SNES_DMAX_BADD $80
		
		jsl LKS_Joypad ; Read Joypad
		jsl LKS_OAM_Clear ; Clear Sprite
		
		;-------------
		ldy #$20*0 ; Target Sprite n'0
		lda #0
		sta LKS_SPRITE.VX+0,y
		sta LKS_SPRITE.VX+1,y
		sta LKS_SPRITE.VY+0,y
		sta LKS_SPRITE.VY+1,y
		
		
		lda LKS_STDCTRL+_UP
		cmp #2
		bne +
			rep #$20
			lda #-1<<2
			sta LKS_SPRITE.VY,y
			sep #$20
		+:
		lda LKS_STDCTRL+_DOWN
		cmp #2
		bne +
			rep #$20
			lda #1<<2
			sta LKS_SPRITE.VY,y
			sep #$20
		+:
		lda LKS_STDCTRL+_RIGHT
		cmp #2
		bne +
			rep #$20
			lda #1<<2
			sta LKS_SPRITE.VX,y
			sep #$20
		+:
		lda LKS_STDCTRL+_LEFT
		cmp #2
		bne +
			rep #$20
			lda #-1<<2
			sta LKS_SPRITE.VX,y
			sep #$20
		+:
		jsl LKS_Sprite_Move ;For move Sprite
		
		
		jsr Draw_Sprite_Anim
		jsr Draw_text
		;-------------
		jsl LKS_DMA_SORT ; prepares DMA transfer and sorting
		jsl WaitVBlank

	jmp Game

;2)
Draw_Sprite_Anim:
	
	jsl LKS_Sprite_Draw_32x32_2x2 ;meta sprite
	jsl LKS_Sprite_Anim ;animation sprite
	jsl LKS_Sprite_DMA  ;Enable DMA for sprite
	

	rts
	
;1) 
Draw_text:
	LKS_printf_setpal 0 ; select pal 0
	ldx	#text_s1 ;address text
	LKS_printfs 1,1 ; x,y
	
	
	LKS_printf_setpal 1 ; select pal 0
	ldx	#text_s1 ;address text
	LKS_printfs 1,2 ;x,y

	rts

text_s1:
.db "hello world",0



	.include "libksIRQ.asm"
	

.bank 1 slot 0
.org 0
	.include "libks.asm"


.bank 2 slot 0
.org 0
Player:
	.incbin "DATA/Player.spr"
	
Player_pal:
	.incbin "DATA/Player.pal"

