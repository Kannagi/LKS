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
	
	jsl LKS_GAMELOOP_INIT
	Game:
		jsl LKS_Fade_in
		
		SNES_DMAX $00
		SNES_DMAX_BADD $80
		
		LKS_printf_setpal 0 ; select pal 0
		ldx	#text_s1 ;address text
		LKS_printfs 1,1 ; x,y
		
		
		LKS_printf_setpal 1 ; select pal 1
		ldx	#text_s1 ;address text
		LKS_printfs 1,2 ;x,y
		
		jsl WaitVBlank

	jmp Game
	
	

text_s1:
.db "hello world",0



	.include "libksIRQ.asm"
	

.bank 1 slot 0
.org 0
	.include "libks.asm"


	

	

