
.MACRO LKS_ZORDER12
	
	ldy #0
	
	lda LKS_OAMZ.y+(2*\1)
	
	.if \1 != 0
		cmp LKS_OAMZ.y+0
		bpl +
			iny
		+:
		.if \1 > 0
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 2	
		cmp LKS_OAMZ.y+2
		bpl +
			iny
		+:
		
		.if \1 > 2
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 4
		cmp LKS_OAMZ.y+4
		bpl +
			iny
		+:
		
		.if \1 > 4
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 6
		cmp LKS_OAMZ.y+6
		bpl +
			iny
		+:
		
		.if \1 > 6
		bne +
			iny
		+:
		.endif
	.endif
	
	
	
	.if \1 != 8
		cmp LKS_OAMZ.y+8
		bpl +
			iny
		+:
		
		.if \1 > 8
		bne +
			iny
		+:
		.endif
	.endif
	
	
	
	.if \1 != 10
		cmp LKS_OAMZ.y+10
		bpl +
			iny
		+:
		
		.if \1 > 10
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 12
		cmp LKS_OAMZ.y+12
		bpl +
			iny
		+:
		
		.if \1 > 12
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 14
		cmp LKS_OAMZ.y+14
		bpl +
			iny
		+:
		
		.if \1 > 14
		bne +
			iny
		+:
		.endif
	.endif
	
	
	.if \1 != 16
		cmp LKS_OAMZ.y+16
		bpl +
			iny
		+:
		
		.if \1 > 16
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 18
		cmp LKS_OAMZ.y+18
		bpl +
			iny
		+:
		
		.if \1 > 18
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 20
		cmp LKS_OAMZ.y+20
		bpl +
			iny
		+:
		
		.if \1 > 20
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 22
		cmp LKS_OAMZ.y+22
		bpl +
			iny
		+:
		
		.if \1 > 22
		bne +
			iny
		+:
		.endif
	.endif
	
	
	
	tya
	asl
	asl
	asl
	asl
	sta LKS_SPRITE.OAM+(2*\1)
	
.ENDM

.MACRO zorder_init
	
	
	ldx LKS_OAM+$10
	lda s_perso+_y,x
	sta MEM_TEMP
	
	ldx LKS_OAM+$10+2
	lda s_perso+_y,x
	sta MEM_TEMP+2
	
	ldx LKS_OAM+$10+4
	lda s_perso+_y,x
	sta MEM_TEMP+4
	
	ldx LKS_OAM+$10+6
	lda s_perso+_y,x
	sta MEM_TEMP+6
	
	ldx LKS_OAM+$10+8
	lda s_perso+_y,x
	sta MEM_TEMP+8
	
	ldx LKS_OAM+$10+10
	lda s_perso+_y,x
	sta MEM_TEMP+10
	
	.if \1 == 0
	
	ldx LKS_OAM+$10+12
	lda s_perso+_y,x
	sta MEM_TEMP+12
	
	ldx LKS_OAM+$10+14
	lda s_perso+_y,x
	sta MEM_TEMP+14
	
	ldx LKS_OAM+$10+16
	lda s_perso+_y,x
	sta MEM_TEMP+16
	
	ldx LKS_OAM+$10+18
	lda s_perso+_y,x
	sta MEM_TEMP+18
	
	ldx LKS_OAM+$10+20
	lda s_perso+_y,x
	sta MEM_TEMP+20
	
	ldx LKS_OAM+$10+22
	lda s_perso+_y,x
	sta MEM_TEMP+22
	
	.endif

.ENDM

Z_order_pnj:

	lda s_map+_mode
	cmp #0
	beq +
		rts
	+:
	phy
	
	rep #$20
	
	zorder_init 0

	zorder 0
	zorder 2
	zorder 4
	zorder 6
	
	zorder 8
	zorder 10
	zorder 12
	zorder 14
	
	zorder 16
	zorder 18
	zorder 20
	zorder 22
		
	sep #$20
	
	ply
	rts
	
.MACRO zorder2
	
	ldy #0
	
	lda MEM_TEMP+\1
	
	.if \1 != 0
		cmp MEM_TEMP+0
		bpl +
			iny
		+:
		.if \1 > 0
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 2	
		cmp MEM_TEMP+2
		bpl +
			iny
		+:
		
		.if \1 > 2
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 4
		cmp MEM_TEMP+4
		bpl +
			iny
		+:
		
		.if \1 > 4
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 6
		cmp MEM_TEMP+6
		bpl +
			iny
		+:
		
		.if \1 > 6
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 8
		cmp MEM_TEMP+8
		bpl +
			iny
		+:
		
		.if \1 > 8
		bne +
			iny
		+:
		.endif
	.endif
	
	.if \1 != 10
		cmp MEM_TEMP+10
		bpl +
			iny
		+:
		
		.if \1 > 10
		bne +
			iny
		+:
		.endif
	.endif
	
	lda MEM_TEMP
	asl
	asl
	asl
	asl
	asl
	
	ldx LKS_OAM+$10+\1
	clc
	adc #$100
	sta s_perso+_oam,x
	
.ENDM




Z_order_ennemi:

	lda s_map+_mode
	cmp #1
	beq +
		rts
	+:
	
	phy

	rep #$20
	
	zorder_init 1

	zorder2 0
	zorder2 2
	zorder2 4
	
	zorder2 6
	zorder2 8
	zorder2 10
	
	

	sep #$20
	
	ply
	
	rts
