

.MACRO LKS_BULLET_INIT

	lda #-32
	sta LKS_BULLET.Y+1+(2*\1)
	
	lda #\2
	sta LKS_BULLET.Tile+\1
	
	lda #\3
	sta LKS_BULLET.Flip+\1
.ENDM

.MACRO LKS_BULLET_DRAW_BG

	rep #$20
	clc
	lda LKS_BULLET.X+(2*\1)
	adc LKS_BULLET.VX+(2*\1)
	sec 
	sbc LKS_BG.VScrollx
	sta LKS_BULLET.X+(2*\1)
	and #$F800
	cmp #$F800
	bne +
		lda #0
		sta LKS_BULLET.VX+(2*\1)
		sta LKS_BULLET.VY+(2*\1)
		
		lda #$E000
		sta LKS_BULLET.Y+(2*\1)
	+:
	
	
	lda LKS_BULLET.Y+(2*\1)
	cmp #$E000
	beq ++
		sec 
		sbc LKS_BG.VScrolly
		clc
		adc LKS_BULLET.VY+(2*\1)
		sta LKS_BULLET.Y+(2*\1)
	++:
	
	and #$F000
	cmp #$F000
	bne +
		lda #0
		sta LKS_BULLET.VX+(2*\1)
		sta LKS_BULLET.VY+(2*\1)
		
		lda #$E000
		sta LKS_BULLET.Y+(2*\1)
	+:
	sep #$20
	
	lda LKS_BULLET.X+1+(2*\1)
	sta LKS_BUF_OAML+($4*\1),x

	lda LKS_BULLET.Y+1+(2*\1)
	sta LKS_BUF_OAML+1+($4*\1),x
	
	lda LKS_BULLET.Tile+\1
	sta LKS_BUF_OAML+2+($4*\1),x
	
	lda LKS_BULLET.Flip+\1
	sta LKS_BUF_OAML+3+($4*\1),x
.ENDM

.MACRO LKS_BULLET_DRAW

	rep #$20
	clc
	lda LKS_BULLET.X+(2*\1)
	adc LKS_BULLET.VX+(2*\1)
	sta LKS_BULLET.X+(2*\1)
	and #$F800
	cmp #$F800
	bne +
		lda #0
		sta LKS_BULLET.VX+(2*\1)
		sta LKS_BULLET.VY+(2*\1)
		
		lda #$E000
		sta LKS_BULLET.Y+(2*\1)
	+:
	
	
	lda LKS_BULLET.Y+(2*\1)
	clc
	adc LKS_BULLET.VY+(2*\1)
	sta LKS_BULLET.Y+(2*\1)
	and #$F000
	cmp #$F000
	bne +
		lda #0
		sta LKS_BULLET.VX+(2*\1)
		sta LKS_BULLET.VY+(2*\1)
		
		lda #$E000
		sta LKS_BULLET.Y+(2*\1)
	+:
	sep #$20
	
	lda LKS_BULLET.X+1+(2*\1)
	sta LKS_BUF_OAML+($4*\1),x

	lda LKS_BULLET.Y+1+(2*\1)
	sta LKS_BUF_OAML+1+($4*\1),x
	
	lda LKS_BULLET.Tile+\1
	sta LKS_BUF_OAML+2+($4*\1),x
	
	lda LKS_BULLET.Flip+\1
	sta LKS_BUF_OAML+3+($4*\1),x
.ENDM

.MACRO LKS_BULLET_FIRE_INIT

	lda #0
	sta LKS_BULLET.i
	
	ldx #0
	-:
		inx
		inx
		cpx #2*\1
		beq ++++
		lda LKS_BULLET.Y+1-2,x
		cmp #$E0
	bne -
	++++:
	dex
	dex
		
.ENDM
