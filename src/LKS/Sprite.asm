
LKS_Sprite_limite:
	
	
	rep #$20
		
	lda LKS_SPRITE.X,y
	cmp #0
	bpl +
		lda #0
		sta LKS_SPRITE.X,y
		sta LKS_SPRITE.PX,y
	+:
	
	lda LKS_SPRITE.X,y
	clc
	adc #32
	cmp LKS_BG.limitex
	bmi +
		lda LKS_BG.limitex
		sec
		sbc #32
		sta LKS_SPRITE.X,y
		
		lda LKS_BG.limitex
		asl
		asl
		sec
		sbc #32<<2
		sta LKS_SPRITE.PX,y
	+:
	
	lda LKS_SPRITE.Y,y
	cmp #0
	bpl +
		lda #0
		sta LKS_SPRITE.Y,y
		sta LKS_SPRITE.PY,y
	+:
	
	lda LKS_SPRITE.Y,y
	clc
	adc #32
	cmp LKS_BG.limitey
	bmi +
		lda LKS_BG.limitey
		sec
		sbc #$32
		sta LKS_SPRITE.Y,y
		
		lda LKS_BG.limitey
		asl
		asl
		sec
		sbc #32<<2
		sta LKS_SPRITE.PY,y
	+:
	
	sep #$20
	
	rtl
	
LKS_Sprite_Anim:

	tyx
	
	stz MEM_RETURN
	
	lda LKS_SPRITE.Anim_type,x
	bit #$80
	bne +
	lda LKS_SPRITE.Anim_act,x
    cmp LKS_SPRITE.Anim_old,x
    beq +
		sta LKS_SPRITE.Anim_old,x
		stz LKS_SPRITE.Anim_l,x
		stz LKS_SPRITE.Anim_i,x
		lda #$80
		sta MEM_RETURN
    +:

	inc LKS_SPRITE.Anim_l,x
    lda LKS_SPRITE.Anim_l,x
    cmp LKS_SPRITE.Anim_v,x
    bne +
		stz LKS_SPRITE.Anim_l,x
		inc LKS_SPRITE.Anim_i,x
		lda #$80
		sta MEM_RETURN
    +:

    stz LKS_SPRITE.Anim_end,x
    lda LKS_SPRITE.Anim_i,x
    cmp LKS_SPRITE.Anim_n,x
    bne +
		stz LKS_SPRITE.Anim_l,x
		stz LKS_SPRITE.Anim_i,x
		lda #$80
		sta LKS_SPRITE.Anim_end,x
		sta MEM_RETURN
    +:
    
    lda LKS_SPRITE.Anim_type,x
	and #$40
	cmp #0
	beq +
		lda #$80
		sta MEM_RETURN
		lda LKS_SPRITE.Anim_type,x
		and #$FF-$40
		sta LKS_SPRITE.Anim_type,x
	+:
    
    
    lda LKS_SPRITE.Anim_flg,x
    and #$7F
    ora MEM_RETURN
    sta LKS_SPRITE.Anim_flg,x
 
	rtl
	


LKS_Sprite_DMA:
	tyx
	
	lda LKS_SPRITE.Anim_flg,x
	bit #$80
	bne +
		rtl
	+:
	
	lda LKS_SPRITE.Anim_act,x
	sta MEM_TEMP+8
	
	lda LKS_SPRITE.Anim_type,x
	and #$3F
	cmp #0
	beq +
		sta MEM_TEMP
		lda LKS_SPRITE.Anim_i,x
		sta MEM_TEMP+10
		cmp #4
		bmi ++
			sec
			sbc #4
			sta MEM_TEMP+10
			lda MEM_TEMP+8
			clc
			adc MEM_TEMP
			sta MEM_TEMP+8
		bra ++
	+:
		lda LKS_SPRITE.Anim_i,x
		sta MEM_TEMP+10
	++:
	
	

    ;Anim Y
    lda MEM_TEMP+8
    asl
    asl
    asl
	sta WRMPYA
	
	lda LKS_SPRITE.Anim_flg,x
	sta MEM_TEMP+6
	and #$0F
    asl
    asl
    asl
    asl
	sta WRMPYB
	
	lda MEM_TEMP+6
	and #$30
	asl
	clc 
	adc #$20
	sta MEM_TEMP
	rep #$20
	
	lda RDMPYL
	sta MEM_TEMP+4
	
	sep #$20
    
    ;Anim X
	lda MEM_TEMP+10
	sta WRMPYA
	
	lda MEM_TEMP
	sta WRMPYB
	
	nop
	nop
	rep #$20
	stx MEM_TEMP

	lda RDMPYL
	asl
	sta MEM_TEMP+2
	sep #$20
	
	;Send
	rep #$20
	lda LKS_SPRITE.Address,x
	clc
	adc MEM_TEMP+2
	adc MEM_TEMP+4
	sta LKS_DMA.Src1,x
	
	lda LKS_DMA_SEND.i
	tax
	adc #2
	sta LKS_DMA_SEND.i
	
	lda MEM_TEMP
	sta LKS_DMA_SEND.index,x
	
	sep #$20
	
	rtl
	
LKS_Sprite_Move:
	tyx

	rep #$20
	clc
	lda LKS_SPRITE.PX,x
	adc LKS_SPRITE.VX,x
	sta LKS_SPRITE.PX,x
	bit #$8000
	beq +
		lsr
		lsr 
		ora #$C000
		sta LKS_SPRITE.X,x
		bra ++
	+:
		lsr
		lsr 
		sta LKS_SPRITE.X,x
	++:

	clc
	lda LKS_SPRITE.PY,x
	adc LKS_SPRITE.VY,x
	sta LKS_SPRITE.PY,x
	bit #$8000
	beq +
		lsr
		lsr 
		ora #$C000
		sta LKS_SPRITE.Y,x
		bra ++
	+:
		lsr
		lsr 
		sta LKS_SPRITE.Y,x
	++:
	sep #$20
	
	rtl
	
LKS_Sprite_Draw_32x32_2x2:

	
	lda #0
	sta LKS_SPRITE.Screen,y
	
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
		lda #1
		sta LKS_SPRITE.Screen,y
		rtl
	+:
	
	;X Right
	lda MEM_TEMP+4+1
	cmp #$01
	bmi +
		lda #1
		sta LKS_SPRITE.Screen,y
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
		lda #1
		sta LKS_SPRITE.Screen,y
		rtl
	+:
	
	
	;Draw
	ldx LKS_SPRITE.OAM,y
	
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
