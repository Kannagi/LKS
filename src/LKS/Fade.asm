
LKS_Fade_in:
	
	lda LKS_FADE.phase
	cmp #0
	beq +
		rtl
	+:

	lda LKS_FADE.brg
	sta INIDISP
		
	ldy LKS_FADE.timer
	cpy #2
	bne +
		ina
		stz LKS_FADE.timer
		bra ++
	+:
		inc LKS_FADE.timer
	++:
	cmp #$10
	bne +
		lda #$0F
		sta INIDISP
		inc LKS_FADE.phase
		stz LKS_FADE.timer
		
		rtl
	+:
	sta LKS_FADE.brg

	rtl
	
	
LKS_Fade_out:
	
	lda LKS_FADE.phase
	cmp #0
	bne +
		rtl
	+:

	lda LKS_FADE.brg
	sta INIDISP
		
	ldy LKS_FADE.timer
	cpy #2
	bne +
		dea
		stz LKS_FADE.timer
		bra ++
	+:
		inc LKS_FADE.timer
	++:
	cmp #-$1
	bne +
		lda #$00
		sta INIDISP
		inc LKS_FADE.phase
		stz LKS_FADE.timer
	
		rtl
	+:
	sta LKS_FADE.brg

	rtl
	

