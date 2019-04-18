
LKS_Sprite_Move:
	clc
	lda LKS_SPRITE.PX
	adc LKS_SPRITE.VX
	sta LKS_SPRITE.PX
	lsr
	lsr 
	sta LKS_SPRITE.X
	
	lda LKS_SPRITE.PY
	adc LKS_SPRITE.VY
	sta LKS_SPRITE.PY
	lsr
	lsr 
	sta LKS_SPRITE.PY
	
	
	rtl
	
LKS_Sprite_Draw_32x32_2x2:

	ldx LKS_SPRITE.OAM
	
	rep #$20
	
	lda LKS_SPRITE.X,y
	sec
	sbc LKS_BG.x
	sta MEM_TEMP+4
	
	lda LKS_SPRITE.Y,y
	sec
	sbc LKS_BG.y
	sta MEM_TEMP+6
	
	clc
	adc #32
	sta MEM_TEMP
	sep #$20
	
	lda MEM_TEMP+1
	cmp #$00
	beq +
		lda #-32
		sta LKS_BUF_OAML+1,x
		sta LKS_BUF_OAML+5,x
		sta LKS_BUF_OAML+9,x
		sta LKS_BUF_OAML+13,x
		rtl
	+:
	
	;X Right
	lda MEM_TEMP+4+1
	cmp #$01
	bmi +
		lda #-32
		sta LKS_BUF_OAML+1,x
		sta LKS_BUF_OAML+5,x
		sta LKS_BUF_OAML+9,x
		sta LKS_BUF_OAML+13,x
		rtl
	+:
	
	;X Left
	rep #$20
	stz MEM_TEMP+2
	lda MEM_TEMP+4
	clc
	adc #16
	bcc +
		ldx #$01+$04
		stx MEM_TEMP+2
	+:
	clc
	adc #16
	bcc +
		ldx #$01+$04+$10+$40
		stx MEM_TEMP+2
	+:
	sta MEM_TEMP
	sep #$20
		
	lda MEM_TEMP+1
	cmp #$0
	bpl +
		ldx LKS_SPRITE.OAM
		lda #-32
		sta LKS_BUF_OAML+1,x
		sta LKS_BUF_OAML+5,x
		sta LKS_BUF_OAML+9,x
		sta LKS_BUF_OAML+13,x
		rtl
	+:
	
	
	;Draw
	ldx LKS_SPRITE.OAM
	
	lda MEM_TEMP+6
	sta LKS_BUF_OAML+1,x
	sta LKS_BUF_OAML+9,x
	clc
	adc #$10
	sta LKS_BUF_OAML+5,x
	sta LKS_BUF_OAML+13,x
	
	
	lda MEM_TEMP+4
	sta LKS_BUF_OAML+0,x
	sta LKS_BUF_OAML+4,x
	clc
	adc #$10
	sta LKS_BUF_OAML+8,x
	sta LKS_BUF_OAML+12,x
	bcc +
		lda MEM_TEMP+2
		cmp #0
		bne +
			lda #-32
			sta LKS_BUF_OAML+9,x
			sta LKS_BUF_OAML+13,x		
	+:
	
	lda LKS_SPRITE.Flip,y
	sta LKS_BUF_OAML+3,x
	sta LKS_BUF_OAML+11,x
	sta LKS_BUF_OAML+7,x
	sta LKS_BUF_OAML+15,x
	
	
	bit #$40
	beq + 
		bit #$80
		beq +++ 
			;flipx&y
			clc
			lda LKS_SPRITE.Tile,y
			sta LKS_BUF_OAML+14,x
			adc #$2
			sta LKS_BUF_OAML+6,x
			adc #$2
			sta LKS_BUF_OAML+10,x
			adc #$2
			sta LKS_BUF_OAML+2,x
			bra ++
		+++:
		;flipx
		clc
		lda LKS_SPRITE.Tile,y
		sta LKS_BUF_OAML+10,x
		adc #$2
		sta LKS_BUF_OAML+2,x
		adc #$2
		sta LKS_BUF_OAML+14,x
		adc #$2
		sta LKS_BUF_OAML+6,x
		bra ++
	+:
		bit #$80
		beq +
			; flipy
			clc
			lda LKS_SPRITE.Tile,y
			sta LKS_BUF_OAML+6,x
			adc #$2
			sta LKS_BUF_OAML+14,x
			adc #$2
			sta LKS_BUF_OAML+2,x
			adc #$2
			sta LKS_BUF_OAML+10,x
			bra ++
		+:
			;no flip
			clc
			lda LKS_SPRITE.Tile,y
			sta LKS_BUF_OAML+2,x
			adc #$2
			sta LKS_BUF_OAML+10,x
			adc #$2
			sta LKS_BUF_OAML+6,x
			adc #$2
			sta LKS_BUF_OAML+14,x
	++:
	
	
	
	;end
	rep #$20
	txa
	lsr
	lsr
	lsr
	lsr
	tax
	sep #$20
	
	lda LKS_SPRITE.Ext,y
	ora MEM_TEMP+2
	sta LKS_BUF_OAMH,x
	
	rtl
