
VBlank:
	phd
	php
	phb
	pha
    phx
    phy
    
    rep #$10	;16 bit xy
	sep #$20	; 8 bit a
    
    lda RDNMI
    jsl LKS_DMA_OAM
    
	SNES_DMAX4 $01
	SNES_DMAX4_BADD $18

	jsl LKS_DMA_BG3

	jsl VBlank0
	
	ldy #0
	
	-:
		lda HVBJOY
		and #$01
    bne -
    jsl LKS_NMI_Joypad
    
     
    -:
		iny
		
		lda	HVBJOY
		and #$80		
	bne -
	sty LKS.VBlankTime
    
	ply
	plx
	pla
	plb
	
	plp
	pld

	rti

HVSync:

	rti

Int:
	
	rti
	
