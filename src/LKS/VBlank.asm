

VBlank0:
	
	;---------------------------
	jsl LKS_BackgroundX
	jsl LKS_BackgroundY  
	;---------------------------	

	LKS_DMA_VRAM 0
	LKS_DMA_VRAM 1
	LKS_DMA_VRAM 2
	LKS_DMA_VRAM 3
	
	LKS_DMA_VRAM 4

	;---------------------------
	
	jsl LKS_DMA_PAL

	LKS_BG_update
	rtl
	
WaitVBlank:

	lda LKS.clockf
	ina
	cmp #60
	bne +
		stz LKS.mcpu
		lda #0
	+:
	
	sta LKS.clockf
	SNES_DMA5 $00
	SNES_DMA5_BADD $22
	
	SNES_DMA4 $00
	SNES_DMA4_BADD $04
	
	lda SLHV
	lda OPVCT
	lsr
	cmp #12
	bmi ++
	cmp #28
	bpl +
		sec
		sbc #2
		bra ++
	+:
	cmp #28*2
	bpl +
		sec
		sbc #5
		bra ++
	+:
	cmp #28*3
	bpl +
		sec
		sbc #8
		bra ++
	+:
		sec
		sbc #12
	++:

	sta LKS.cpu
	cmp LKS.mcpu
	bcc +
		sta LKS.mcpu
	+:
	wai
	
	rtl
	
