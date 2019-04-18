
.MACRO LKS_HITBOX_INIT
	
	rep #$20

	lda LKS_SPRITE.X,y
	sec
	sbc #\3
	sta MEM_TEMP+4
	clc
	adc #\1+\3
	sta MEM_TEMP+6
	
	lda LKS_SPRITE.Y,y
	sec
	sbc #\4
	sta MEM_TEMP+0
	clc
	adc #\2+\4
	sta MEM_TEMP+2
	sep #$20
	
.ENDM

rep #$20
.MACRO LKS_HITBOX
	
	ldy LKS_SPRITE_CTRL.Address+(2*\1)
	lda LKS_SPRITE.Y,y
	
	cmp MEM_TEMP+0
	bmi +
	
	cmp MEM_TEMP+2
	bpl +
	
	lda LKS_SPRITE.X,y
	
	cmp MEM_TEMP+4
	bmi +
	
	cmp MEM_TEMP+6
	bpl +

	stz MEM_RETURN+0
	tyx
	stx MEM_RETURN+2
	rts
	+:
	
.ENDM


.MACRO LKS_HITBOX_BULLET
	
	lda LKS_BULLET.Y+1+(2*\1)
	and #$E0
	cmp #$E0
	beq +
	
	lda LKS_BULLET.Y+1+(2*\1)
	and #$FF
	adc LKS_BG.y
	cmp MEM_TEMP+0
	bmi +
	
	cmp MEM_TEMP+2
	bpl +
	
	lda LKS_BULLET.X+1+(2*\1)
	and #$FF
	adc LKS_BG.x
	cmp MEM_TEMP+4
	bmi +
	
	cmp MEM_TEMP+6
	bpl +

	stz MEM_RETURN+0
	ldx #(2*\1)
	stx MEM_RETURN+2
	
	rts
	+:
	
.ENDM
sep #$20
