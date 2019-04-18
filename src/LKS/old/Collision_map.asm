
.MACRO LKS_COLLISION_MAP0
	lda LKS_BG.Addressc+2
	sta LKS_ZP+2
	lda LKS_BG.Addressc
	sta LKS_ZP
	
	lda LKS_SPRITE.PX,y
	clc
	adc #8<<2
	sta MEM_TEMP+2
	adc LKS_SPRITE.VX,y

	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	sta MEM_TEMP+0
	
	;-------
	lda MEM_TEMP+2

	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	sta MEM_TEMP+2
	
	;----------------
	lda LKS_SPRITE.PY,y
	clc
	adc #$10<<2
	sta MEM_TEMP+6
	adc LKS_SPRITE.VY,y
	asl
	asl
	and #$FF00
	ora #$0010
	sta WRMPYA
	
	lda MEM_TEMP+6
	asl
	asl
	and #$FF00
	ora #$0010
	sta MEM_TEMP+6
	
	lda RDMPYL
	asl
	asl
	sta MEM_TEMP+4
	
	
	;-----
	lda MEM_TEMP+6
	sta WRMPYA
	LKS_cycle8
	lda RDMPYL
	asl
	asl
	sta MEM_TEMP+6
	
.ENDM

.MACRO LKS_COLLISION_MAP1

	lda MEM_TEMP+(2*\1)
	clc
	adc MEM_TEMP+(2*\2)
	
	tay
	lda [LKS_ZP],y
	
	
.ENDM
.MACRO LKS_COLLISION_MAP2

	lda MEM_TEMP+(2*\1)
	clc
	adc MEM_TEMP+(2*\2)
	sta MEM_TEMP +8
	adc #64
	
	tay
	lda [LKS_ZP],y
	sta MEM_TEMP +10
		
	lda MEM_TEMP +8
	tay
	lda [LKS_ZP],y
	
	
.ENDM

LKS_Collision_Map:
	
	rep #$20
	tyx
	phy
	
	LKS_COLLISION_MAP0
	
	LKS_COLLISION_MAP2 0,3 ;vx
	bit #$101
	beq +
		lda #0
		sta LKS_SPRITE.VX,x
	/*
		lda MEM_TEMP+0
		dec a
		asl
		asl
		asl
		asl
		asl
		asl
		clc
		adc #8<<2
		sta LKS_SPRITE.PX,x
		*/
	+:
	
	lda MEM_TEMP+10
	bit #$101
	beq +
		lda #0
		sta LKS_SPRITE.VX,x
	+:
	
	LKS_COLLISION_MAP2 1,2 ;vy
	bit #$0101
	beq +
		lda #0
		sta LKS_SPRITE.VY,x
	+:

	lda MEM_TEMP+10
	bit #$101
	beq +
		lda #0
		sta LKS_SPRITE.VY,x
	+:

	
	ply
	sep #$20

	rtl
	
