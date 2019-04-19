
.MACRO LKS_DMA_VRAM_MC 
	ldx MEM_TEMPFUNC
	
	rep #$20
	
	lda LKS_DMA.Dst1,x
	sta MEM_TEMP+0
	
	lda LKS_DMA.Src1,x
	sta MEM_TEMP+2
	
	
	lda LKS_DMA.Size1,x
	tay
	
	ldx MEM_TEMPFUNC+2
	clc
.ENDM

	
;$X bloc
LKS_DMA_VRAM1:

	LKS_DMA_VRAM_MC
	
	;--------------
	lda MEM_TEMP+0
	sta VMADDL
	
	lda MEM_TEMP+2

	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL 
	
	SNES_MDMAEN $01
   
	;--------------
	lda MEM_TEMP+0
	adc #$100
	sta VMADDL
	
	lda MEM_TEMP+2
	adc MEM_TEMPFUNC+4
	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL 
	
	SNES_MDMAEN $01
	
	sep #$20
	
	rts
	

;$X bloc2
LKS_DMA_VRAM1x2:

	LKS_DMA_VRAM_MC
	
	;--------------
	lda MEM_TEMP+0
	sta VMADDL
	
	lda MEM_TEMP+2
	
	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL 
	
	adc MEM_TEMPFUNC+4
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK+$10
	sta DMA_ADDL+$10
	sty DMA_SIZEL+$10
	
	SNES_MDMAEN $03
   
	;--------------
	lda MEM_TEMP+0
	adc #$100
	sta VMADDL
	
	lda MEM_TEMP+2
	adc MEM_TEMPFUNC+4
	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL 
	
	adc MEM_TEMPFUNC+4
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK+$10
	sta DMA_ADDL+$10
	sty DMA_SIZEL+$10
	
	SNES_MDMAEN $03
	
	sep #$20
	
	rts
	
LKS_DMA_VRAM1x3:

	LKS_DMA_VRAM_MC
	
	;--------------
	lda MEM_TEMP+0
	sta VMADDL
	
	lda MEM_TEMP+2
	
	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL 
	
	adc MEM_TEMPFUNC+4
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK+$10
	sta DMA_ADDL+$10
	sty DMA_SIZEL+$10
	
	adc MEM_TEMPFUNC+4
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK+$20
	sta DMA_ADDL+$20
	sty DMA_SIZEL+$20
	
	SNES_MDMAEN $07
   
	;--------------
	lda MEM_TEMP+0
	adc #$100
	sta VMADDL
	
	lda MEM_TEMP+2
	adc MEM_TEMPFUNC+4
	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL 
	
	adc MEM_TEMPFUNC+4
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK+$10
	sta DMA_ADDL+$10
	sty DMA_SIZEL+$10
	
	adc MEM_TEMPFUNC+4
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK+$20
	sta DMA_ADDL+$20
	sty DMA_SIZEL+$20
	
	SNES_MDMAEN $07
	
	sep #$20
	
	rts
	
	
LKS_DMA_VRAM1x4:

	LKS_DMA_VRAM_MC
	
	;--------------
	lda MEM_TEMP+0
	sta VMADDL
	
	lda MEM_TEMP+2
	
	
	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL 
	
	adc MEM_TEMPFUNC+4
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK+$10
	sta DMA_ADDL+$10
	sty DMA_SIZEL+$10
	
	adc MEM_TEMPFUNC+4
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK+$20
	sta DMA_ADDL+$20
	sty DMA_SIZEL+$20
	
	adc MEM_TEMPFUNC+4
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK+$30
	sta DMA_ADDL+$30
	sty DMA_SIZEL+$30
	
	SNES_MDMAEN $0F
   
	;--------------
	lda MEM_TEMP+0
	adc #$100
	sta VMADDL
	
	lda MEM_TEMP+2
	adc MEM_TEMPFUNC+4
	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL 
	
	adc MEM_TEMPFUNC+4
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK+$10
	sta DMA_ADDL+$10
	sty DMA_SIZEL+$10
	
	adc MEM_TEMPFUNC+4
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK+$20
	sta DMA_ADDL+$20
	sty DMA_SIZEL+$20
	
	adc MEM_TEMPFUNC+4
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK+$30
	sta DMA_ADDL+$30
	sty DMA_SIZEL+$30
	
	SNES_MDMAEN $0F
	
	sep #$20
	
	rts
	
;$XLoop
LKS_DMA_VRAM2:

	ldx MEM_TEMPFUNC
		
	lda LKS_DMA.Enable,x
	sta MEM_TEMP+4
	stz MEM_TEMP+5
	rep #$20
	

	-:
	lda LKS_DMA.Size1,x
	tay
	
	
	lda LKS_DMA.Src1,x
	sta MEM_TEMP+2
	
	lda LKS_DMA.Dst1,x
	sta MEM_TEMP+6
	sta VMADDL
	
	;---------
	phx
	
	lda MEM_TEMP+2
	ldx MEM_TEMPFUNC+2
	
	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL 
	
	SNES_MDMAEN $01
	
	lda MEM_TEMP+6
	clc
	adc #$100
	sta VMADDL
	
	lda MEM_TEMP+2
	adc MEM_TEMPFUNC+4
	
	stx DMA_BANK
	sta DMA_ADDL
	sty DMA_SIZEL
	
	SNES_MDMAEN $01
	
	plx
	
	txa
	clc
	adc #6
	tax
	
	dec MEM_TEMP+4
	lda MEM_TEMP+4
	cmp #0
	bne -
	
	sep #$20

	rts
