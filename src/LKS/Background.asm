

.MACRO draw_bg_ligne
    
    ldy #\1
    sty VMADDL
    
    ldy #$0020
    
    stx DMA_BANK + $00
    sta DMA_ADDL + $00
    sty DMA_SIZEL + $00
    
    ldy #$01
    sty MDMAEN
    
	adc LKS_BG.addyr
	
.ENDM


.MACRO background ARGS _addsc
	
    rep #$20
    
    clc
	txa
	
	ldx MEM_TEMPFUNC
	
    ;colonne 0 
    draw_bg_ligne _addsc + $0
    
    ;colonne 1
    draw_bg_ligne _addsc + $20

	;colonne 2
    draw_bg_ligne _addsc + $40
	
	;colonne 3
    draw_bg_ligne _addsc + $60
	
	;colonne 4
    draw_bg_ligne _addsc + $80
	
	;colonne 5
    draw_bg_ligne _addsc + $A0
	
	;colonne 6
    draw_bg_ligne _addsc + $C0
	
	;colonne 7
    draw_bg_ligne _addsc + $E0
	
	;colonne 8
    draw_bg_ligne _addsc + $100
	
	;colonne 9
    draw_bg_ligne _addsc + $120
	
	;colonne 10
    draw_bg_ligne _addsc + $140
	
	;colonne 11
    draw_bg_ligne _addsc + $160
	
	;colonne 12
    draw_bg_ligne _addsc + $180
	
	;colonne 13
    draw_bg_ligne _addsc + $1A0
    
    ;colonne 14
    draw_bg_ligne _addsc + $1C0
    
    ;colonne 15
    draw_bg_ligne _addsc + $1E0
    
	
	sep #$20
.ENDM

LKS_Background1:
	lda LKS_BG.Address1+2
	sta MEM_TEMPFUNC
	
	ldx	LKS_BG.Address1
	background $5000
	
	rtl
	
LKS_Background2:
	lda LKS_BG.Address2+2
	sta MEM_TEMPFUNC
	
	ldx	LKS_BG.Address2
	background $5400
	
	rtl
	
LKS_Background_Camera:

	stz LKS_BG.EnableX
	stz LKS_BG.EnableY
	
	rep #$20
	stz LKS_BG.VScrollx+1
	stz LKS_BG.VScrolly+1
	
	lda LKS_SPRITE.X,y
	sec
	sbc LKS_BG.x
	sta MEM_TEMP
	
	lda LKS_SPRITE.Y,y
	sec
	sbc LKS_BG.y
	sta MEM_TEMP+2
	
	sep #$20
	
	ldx MEM_TEMP
	cpx #$60
	bpl +
		rep #$20
		lda MEM_TEMP
		sec
		sbc #$60
		sta LKS_BG.VScrollx+1
		clc
		adc LKS_BG.x
		sta LKS_BG.x
		sep #$20
		
		lda LKS_BG.Enablelim
		bit #1
		bne +
		
		inc LKS_BG.EnableX
		inc LKS_BG.EnableX
	+:
	
	
	ldx MEM_TEMP
	cpx #$80
	beq +
	bmi +
		rep #$20
		lda MEM_TEMP
		sec
		sbc #$80
		sta LKS_BG.VScrollx+1
		clc
		adc LKS_BG.x
		sta LKS_BG.x
		sep #$20
		
		lda LKS_BG.Enablelim
		bit #1
		bne +
		
		inc LKS_BG.EnableX
	+:
	
	
	ldx MEM_TEMP+2
	cpx #$50
	bpl +
		rep #$20
		lda MEM_TEMP+2
		sec
		sbc #$50
		sta LKS_BG.VScrolly+1
		clc
		adc LKS_BG.y
		sta LKS_BG.y
		sep #$20
		
		lda LKS_BG.Enablelim
		bit #2
		bne +
		
		inc LKS_BG.EnableY
		inc LKS_BG.EnableY
	+:
	
	ldx MEM_TEMP+2
	cpx #$70
	beq +
	bmi +
		rep #$20
		lda MEM_TEMP+2
		sec
		sbc #$70
		sta LKS_BG.VScrolly+1
		clc
		adc LKS_BG.y
		sta LKS_BG.y
		sep #$20
		
		lda LKS_BG.Enablelim
		bit #2
		bne +
		
		inc LKS_BG.EnableY
	+:
	
	
	lda LKS_BG.EnableX
	cmp #0
	bne +
		stz LKS_BG.VScrollx+1
	+:
	
	lda LKS_BG.EnableY
	cmp #0
	bne +
		stz LKS_BG.VScrolly+1
	+:
	rtl

.MACRO Background_bloc

	tay
	pha
	
	lda [LKS_ZP],y
	sta $7E0000+(\1*2),x

	pla
	
	adc LKS_BG.addyr
	
.ENDM

rep #$20
BLOC_DRAM:

	stz LKS_ZP+0
	lda MEM_TEMP+10
	sta LKS_ZP+2
	
	lda MEM_TEMPFUNC
	clc
	
	Background_bloc 0
	Background_bloc 1
	Background_bloc 2
	Background_bloc 3
	
	Background_bloc 4
	Background_bloc 5
	Background_bloc 6
	Background_bloc 7
	
	Background_bloc 8
	Background_bloc 9
	Background_bloc 10
	Background_bloc 11
	
	Background_bloc 12
	Background_bloc 13
	Background_bloc 14
	Background_bloc 15

	rtl

BLOC_DRAM2:
	
	lda MEM_TEMPFUNC
	clc
	adc LKS_BG.addy
		
	
	Background_bloc 16
	Background_bloc 17
	Background_bloc 18
	Background_bloc 19
	
	Background_bloc 20
	Background_bloc 21
	Background_bloc 22
	Background_bloc 23
	
	Background_bloc 24
	Background_bloc 25
	Background_bloc 26
	Background_bloc 27
	
	Background_bloc 28
	Background_bloc 29
	Background_bloc 30
	Background_bloc 31

	rtl
sep #$20

	
	
LKS_Scrolling_limite:
	
	
	
	rep #$20
	
	stz LKS_BG.Enablelim
	
	lda LKS_BG.x
	cmp #0
	bpl +
		lda #0
		sta LKS_BG.x
		inc LKS_BG.Enablelim
	+:
	
	lda LKS_BG.x
	clc
	adc #$100
	cmp LKS_BG.limitex
	bmi +
		lda LKS_BG.limitex
		sec
		sbc #$100
		sta LKS_BG.x
		inc LKS_BG.Enablelim
	+:
	
	lda LKS_BG.y
	cmp #0
	bpl +
		lda #0
		sta LKS_BG.y
		inc LKS_BG.Enablelim
		inc LKS_BG.Enablelim
	+:
	
	lda LKS_BG.y
	clc
	adc #$E1
	cmp LKS_BG.limitey
	bmi +
		lda LKS_BG.limitey
		sec
		sbc #$E1
		sta LKS_BG.y
		inc LKS_BG.Enablelim
		inc LKS_BG.Enablelim
	+:
	
	
	sep #$20
	
	rtl
	
	

	
LKS_Scrolling:


	
	
	rep #$20
	
	;precalcul BGX
	lda #$10
	sta MEM_TEMP+2

	lda LKS_BG.EnableX
	and #$FF
	cmp #2
	bne +
		lda #$0
		sta MEM_TEMP+2
	+:
	
	;precalcul BGY
	lda #$1E0
	sta MEM_TEMP+8


	lda LKS_BG.EnableY
	and #$FF
	cmp #2
	bne +
	
		lda #$0
		sta MEM_TEMP+8
	+:
	
	
	;calcul HSCROLLING
	lda LKS_BG.x
	
	lsr
	lsr
	lsr
	lsr
	
	sta LKS_BG.H
	
	;calcul VMADD
	
	clc
	adc MEM_TEMP+2
	and #$1F
	clc
	adc #$5000
	sta LKS_BG.H_vadd1
	
	adc #$400
	sta LKS_BG.H_vadd2
	
	;calcul VSCROLLING
	lda LKS_BG.y
	
	lsr
	lsr
	lsr
	lsr
	
	sta LKS_BG.V
	
	;calcul VMADD
	asl
	asl
	asl
	asl
	asl
	
	clc
	adc MEM_TEMP+8
	sta MEM_TEMP+10
	and #$3FF

	
	clc
	adc #$5000
	sta LKS_BG.V_vadd1
	adc #$400
	sta LKS_BG.V_vadd2
	
	;----------------
	lda MEM_TEMP+10
	
	ldx LKS_BG.addyr
	cpx #$40 ;512 / 32
	bmi +
		asl
	+:
	
	cpx #$80 ;1024 /64
	bmi +
		asl
	+:
	cpx #$100 ;2048 /128
	bmi +
		asl
	+:
	
	cpx #$200 ;4096 /256
	bmi +
		asl
	+:
	
	cpx #$400 ;8000 /512
	bmi +
		asl
	+:
	
	
	
	sta MEM_TEMP+10
	clc
	adc LKS_BG.Address2
	sta LKS_BG.Dadd1_2
	
	clc
	adc #$20
	sta LKS_BG.Dadd2_2
	
	lda MEM_TEMP+10
	clc
	adc LKS_BG.Address1
	sta LKS_BG.Dadd1_1
	
	clc
	adc #$20
	sta LKS_BG.Dadd2_1
	
	;----------
	
	;calcul
	
	lda #$0
	sta MEM_TEMP+4
	sta MEM_TEMP+6
	
	lda LKS_BG.V
	clc
	adc #$10
	and #$FFE0
	cmp #0
	beq +
		lsr
		lsr
		clc
		adc LKS_BG.addy
		sta WRMPYA
		LKS_cycle8
		lda RDMPYL
		asl a
		asl a
		asl a
		asl a
		asl a
		asl a
		sta MEM_TEMP+4
	+:
	
	lda LKS_BG.V
	and #$FFE0
	cmp #0
	beq +
		lsr
		lsr
		clc
		adc LKS_BG.addy
		sta WRMPYA
		LKS_cycle8
		lda RDMPYL
		asl a
		asl a
		asl a
		asl a
		asl a
		asl a
		sta MEM_TEMP+6
	+:
	
	;BG1
	lda LKS_BG.H
	clc
	adc MEM_TEMP+2
	asl
	clc
	adc LKS_BG.Address1
	sta MEM_TEMP
	adc MEM_TEMP+4
	sta MEM_TEMPFUNC
	;
	
	ldx #LKS_BUF_BGS1&$FFFF
	
	lda LKS_BG.Address1+2
	sta MEM_TEMP+10
	stz MEM_TEMP+11
	jsl BLOC_DRAM
	
	lda MEM_TEMP
	adc MEM_TEMP+6
	sta MEM_TEMPFUNC
	jsl BLOC_DRAM2
	
	;BG2
	lda LKS_BG.H
	clc
	adc MEM_TEMP+2
	asl
	clc
	adc LKS_BG.Address2
	sta MEM_TEMP
	adc MEM_TEMP+4
	sta MEM_TEMPFUNC
	
	ldx #LKS_BUF_BGS2&$FFFF
	
	lda LKS_BG.Address2+2
	sta MEM_TEMP+10
	stz MEM_TEMP+11
	jsl BLOC_DRAM
	
	lda MEM_TEMP
	adc MEM_TEMP+6
	sta MEM_TEMPFUNC
	jsl BLOC_DRAM2
	
	;-------

	
	lda #$0
	sta MEM_TEMP+4
	sta MEM_TEMP+6
	
	lda LKS_BG.H
	clc
	adc #$10
	and #$FFE0
	cmp #0
	beq +
		
		asl a
		sta MEM_TEMP+4
	+:
	
	lda LKS_BG.H
	and #$FFE0
	cmp #0
	beq +
		asl a
		sta MEM_TEMP+6
	+:
	
	lda LKS_BG.Dadd1_2
	clc
	adc MEM_TEMP+4
	sta LKS_BG.Dadd1_2
	
	lda LKS_BG.Dadd2_2
	clc
	adc MEM_TEMP+6
	sta LKS_BG.Dadd2_2
	
	lda LKS_BG.Dadd1_1
	clc
	adc MEM_TEMP+4
	sta LKS_BG.Dadd1_1
	
	lda LKS_BG.Dadd2_1
	clc
	adc MEM_TEMP+6
	sta LKS_BG.Dadd2_1
    
	
	sep #$20
	
	rtl
	
