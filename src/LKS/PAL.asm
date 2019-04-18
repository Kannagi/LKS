
LKS_PAL_Anim:

	inc LKS_PAL.l
	lda LKS_PAL.l
	cmp MEM_TEMPFUNC+6
	bmi +
		lda LKS_PAL.i
		clc
		adc #2
		cmp MEM_TEMPFUNC+2
		bmi ++
			lda #0
		
		++:
		sta LKS_PAL.i
		stz LKS_PAL.l
	+:
	
	rep #$20
	lda MEM_TEMPFUNC
	clc
	adc LKS_PAL.i
	tax
	sep #$20  
	
	ldy MEM_TEMPFUNC+2 
	lda MEM_TEMPFUNC+4


	stx DMA_ADDL+$30
	sta DMA_BANK+$30
	sty DMA_SIZEL+$30

	SNES_MDMAEN $08

	rtl
	
