
LKS_BackgroundY:

	lda LKS_BG.EnableY
	cmp #0
	bne +
		rtl
	+:
	
	;BG1
	ldx LKS_BG.V_vadd1
	stx VMADDL
	
	ldx LKS_BG.Dadd1_1
    lda LKS_BG.Address1+2
	ldy #$20
	
	stx DMA_ADDL+$00
	sta DMA_BANK+$00
	sty DMA_SIZEL+$00
	 
    ldx LKS_BG.Dadd2_1
	
    stx DMA_ADDL+$10
	sta DMA_BANK+$10
	sty DMA_SIZEL+$10
	
    SNES_MDMAEN $03
    
    ;BG2
    ldx LKS_BG.V_vadd2
	stx VMADDL
	
	ldx LKS_BG.Dadd1_2
    lda LKS_BG.Address2+2
	
	stx DMA_ADDL+$00
	sta DMA_BANK+$00
	sty DMA_SIZEL+$00
	 
    ldx LKS_BG.Dadd2_2
	
    stx DMA_ADDL+$10
	sta DMA_BANK+$10
	sty DMA_SIZEL+$10
	
    SNES_MDMAEN $03

		
	rtl

LKS_BackgroundX:

	lda LKS_BG.EnableX
	cmp #0
	bne +
		rtl
	+:

	SNES_VMAINC $81
	
	ldx LKS_BG.H_vadd1
	stx VMADDL
    
    lda #$7E
	ldx #LKS_BUF_BGS1&$FFFF
	ldy #$40
	
	sta DMA_BANK
	stx DMA_ADDL
	sty DMA_SIZEL
	
    SNES_MDMAEN $01
    
    ldx LKS_BG.Address2Haddsc
	stx VMADDL
    
    lda #$7E
	ldx #LKS_BUF_BGS2&$FFFF
	
	sta DMA_BANK
	stx DMA_ADDL
	sty DMA_SIZEL
	
    SNES_MDMAEN $01
	
	SNES_VMAINC $80

	
	rtl


LKS_Background1X:

	lda LKS_BG.EnableX
	cmp #0
	bne +
		rtl
	+:

	SNES_VMAINC $81
	
	ldx LKS_BG.H_vadd1
	stx VMADDL
    
    lda #$7E
	ldx #LKS_BUF_BGS1&$FFFF
	ldy #$40
	
	sta DMA_BANK
	stx DMA_ADDL
	sty DMA_SIZEL
	
    SNES_MDMAEN $01
	
	SNES_VMAINC $80
	
	lda LKS_DMAT
    adc #$10
    sta LKS_DMAT
	
	rtl
	
LKS_Background1Y:

	lda LKS_BG.EnableY
	cmp #0
	bne +
		rtl
	+:
	
	ldx LKS_BG.V_vadd1
	stx VMADDL
	
	ldx LKS_BG.1add1
    lda LKS_BG.Address1+2
	ldy #$20
	
	stx DMA_ADDL
	sta DMA_BANK
	sty DMA_SIZEL
	 
    ldx LKS_BG.1add2
	
    stx DMA_ADDL+$10
	sta DMA_BANK+$10
	sty DMA_SIZEL+$10
	
	
    SNES_MDMAEN $03
    
    lda LKS_DMAT
    adc #$10
    sta LKS_DMAT
		
	rtl
	
LKS_Background2X:

	lda LKS_BG.EnableX
	cmp #0
	bne +
		rtl
	+:

	SNES_VMAINC $81
	
	ldx LKS_BG.Address2Haddsc
	stx VMADDL
    
    lda #$7E
	ldx #LKS_BUF_BGS2&$FFFF
	ldy #$40
	
	sta DMA_BANK
	stx DMA_ADDL
	sty DMA_SIZEL
	
    SNES_MDMAEN $01
	
	SNES_VMAINC $80
	
	lda LKS_DMAT
    adc #$10
    sta LKS_DMAT
	
	rtl
	
LKS_Background2Y:

	
	lda LKS_BG.EnableY
	cmp #0
	bne +
		rtl
	+:
	
	ldx LKS_BG.V_vadd2
	stx VMADDL
	
	ldx LKS_BG.Dadd1_2
    lda LKS_BG.Address2+2
	ldy #$20
	
	stx DMA_ADDL+$0
	sta DMA_BANK+$0
	sty DMA_SIZEL+$0
	 
    ldx LKS_BG.Dadd2_2
	
    stx DMA_ADDL+$10
	sta DMA_BANK+$10
	sty DMA_SIZEL+$10
	
	
    SNES_MDMAEN $03
    
    lda LKS_DMAT
    adc #$10
    sta LKS_DMAT
		
	rtl
