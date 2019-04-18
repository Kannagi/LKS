

LKS_OAM4_Clear:
	
	
	sta LKS_BUF_OAML + 1,x
	sta LKS_BUF_OAML + 5,x
	sta LKS_BUF_OAML + 9,x
	sta LKS_BUF_OAML + 13,x
	
	rtl
	

LKS_OAM_Clear:


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
