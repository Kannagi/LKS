

LKS_OAM4_Clear:
	
	sta LKS_BUF_OAML + 1,x
	sta LKS_BUF_OAML + 5,x
	sta LKS_BUF_OAML + 9,x
	sta LKS_BUF_OAML + 13,x
	
	rtl
	
LKS_OAM_ClearH
	;Clear OAM
	lda #0
	rep #$20
	sta LKS_BUF_OAMH +$10
	sta LKS_BUF_OAMH +$12
	sta LKS_BUF_OAMH +$14
	sta LKS_BUF_OAMH +$16
	sta LKS_BUF_OAMH +$18
	sta LKS_BUF_OAMH +$1A
	sta LKS_BUF_OAMH +$1C
	sta LKS_BUF_OAMH +$1E
	sep #$20
	
	lda #-32
	
	LKS_OAM4_Clear $10
	LKS_OAM4_Clear $11
	LKS_OAM4_Clear $12
	LKS_OAM4_Clear $13
	LKS_OAM4_Clear $14
	LKS_OAM4_Clear $15
	LKS_OAM4_Clear $16
	LKS_OAM4_Clear $17
	LKS_OAM4_Clear $18
	LKS_OAM4_Clear $19
	LKS_OAM4_Clear $1A
	LKS_OAM4_Clear $1B
	LKS_OAM4_Clear $1C
	LKS_OAM4_Clear $1D
	LKS_OAM4_Clear $1E
	LKS_OAM4_Clear $1F

	rtl
	
LKS_OAM_Clear:

	stz LKS_OAM
	stz LKS_OAM+1
	
	;Clear OAM
	rep #$20
	lda #0
	sta LKS_BUF_OAMH +$00
	sta LKS_BUF_OAMH +$02
	sta LKS_BUF_OAMH +$04
	sta LKS_BUF_OAMH +$06
	sta LKS_BUF_OAMH +$08
	sta LKS_BUF_OAMH +$0A
	sta LKS_BUF_OAMH +$0C
	sta LKS_BUF_OAMH +$0E
	sta LKS_BUF_OAMH +$10
	sta LKS_BUF_OAMH +$12
	sta LKS_BUF_OAMH +$14
	sta LKS_BUF_OAMH +$16
	sta LKS_BUF_OAMH +$18
	sta LKS_BUF_OAMH +$1A
	sta LKS_BUF_OAMH +$1C
	sta LKS_BUF_OAMH +$1E
	sep #$20
	
	
	lda #-32
	
	LKS_OAM4_Clear $00
	LKS_OAM4_Clear $01
	LKS_OAM4_Clear $02
	LKS_OAM4_Clear $03
	LKS_OAM4_Clear $04
	LKS_OAM4_Clear $05
	LKS_OAM4_Clear $06
	LKS_OAM4_Clear $07
	LKS_OAM4_Clear $08
	LKS_OAM4_Clear $09
	LKS_OAM4_Clear $0A
	LKS_OAM4_Clear $0B
	LKS_OAM4_Clear $0C
	LKS_OAM4_Clear $0D
	LKS_OAM4_Clear $0E
	LKS_OAM4_Clear $0F
	
	LKS_OAM4_Clear $10
	LKS_OAM4_Clear $11
	LKS_OAM4_Clear $12
	LKS_OAM4_Clear $13
	LKS_OAM4_Clear $14
	LKS_OAM4_Clear $15
	LKS_OAM4_Clear $16
	LKS_OAM4_Clear $17
	LKS_OAM4_Clear $18
	LKS_OAM4_Clear $19
	LKS_OAM4_Clear $1A
	LKS_OAM4_Clear $1B
	LKS_OAM4_Clear $1C
	LKS_OAM4_Clear $1D
	LKS_OAM4_Clear $1E
	LKS_OAM4_Clear $1F
	
	rtl
	

LKS_OAM_Draw:

	;Y
	rep #$20
	lda LKS_OAM+_sprsz
	and #$FE
	clc
	adc LKS_OAM+_spry
	sta LKS_OAM+_sprtmp1
	sep #$20
	
	lda LKS_OAM+_sprtmp1+1
	cmp #$00
	beq +
		iny
		iny
		iny
		iny
		rtl
	+:
	
	;X droite
	lda LKS_OAM+_sprx+1
	cmp #$01
	bmi +
		iny
		iny
		iny
		iny
		rtl
	+:
	
	;X gauche
	rep #$20
	lda LKS_OAM+_sprsz
	and #$FE
	clc
	adc LKS_OAM+_sprx
	sta LKS_OAM+_sprtmp1
	sta LKS_OAM+_sprtmp2
	sep #$20
		
	lda LKS_OAM+_sprtmp1+1
	cmp #$0
	bpl +
		iny
		iny
		iny
		iny
		rtl
	+:

	phx
	rep #$20
	tya
	phy
	
	sta LKS_OAM+_sprtmp1
	
	lsr
	lsr
	lsr
	lsr
	
	tay
	sep #$20
	
	lda LKS_OAM+_sprtmp1
	and #$0F
	cmp #$00
	bne +
		lda #$01
		bra ++
	+:
	cmp #$04
	bne +
		lda #$04
		bra ++
	+:
	cmp #$08
	bne +
		lda #$10
		bra ++
	+:
	cmp #$0C
	bne +
		lda #$40
		bra ++
	+:
	++:
	sta LKS_OAM+_sprtmp1
	asl
	sta LKS_OAM+_sprtmp1+1
	
	
	tyx
	
	lda LKS_OAM+_sprsz
	bit #1
	beq +
		lda LKS_BUF_OAMH,x
		ora LKS_OAM+_sprtmp1+1
		sta LKS_BUF_OAMH,x
	+:
	
	lda LKS_OAM+_sprtmp2+1
	cmp #$1
	beq +
	;clipping
	lda LKS_OAM+_sprsz
	and #$FE
	clc
	adc LKS_OAM+_sprx
	bcc +
		lda LKS_BUF_OAMH,x
		ora LKS_OAM+_sprtmp1
		sta LKS_BUF_OAMH,x
		
	+:
	
	
	ply
	;--------
	
	
	tyx
	lda LKS_OAM+_sprx
	sta LKS_BUF_OAML,x
	inx
	
	
	lda LKS_OAM+_spry
	sta LKS_BUF_OAML,x
	inx
	
	lda LKS_OAM+_sprtile
	sta LKS_BUF_OAML,x
	inx
	
	lda LKS_OAM+_sprext
	sta LKS_BUF_OAML,x
	inx
	
	txy
	plx
	
	rtl
	
	
;-------------------------------------------------
LKS_OAM_Draw_Meta:

	
	
	rtl
	

LKS_OAM_Draw_Meta2x1:
		

		rtl
