
.MACRO LKS_BG_update

	lda LKS_BG.x
	sta BG1H0FS
	lda LKS_BG.x+1
	sta BG1H0FS 
	
	lda LKS_BG.y
	sta BG1V0FS
	lda LKS_BG.y+1
	sta BG1V0FS
	
	lda LKS_BG.x
	sta BG2H0FS
	lda LKS_BG.x+1
	sta BG2H0FS 
	
	lda LKS_BG.y
	sta BG2V0FS
	lda LKS_BG.y+1
	sta BG2V0FS
	
.ENDM

.MACRO	LKS_INIT_BG

	lda #:\2
	ldx #\2
	
	stx LKS_BG.Address1+0
	sta LKS_BG.Address1+2
	
	lda #:\1
	ldx #\1
	
	stx LKS_BG.Address2+0
	sta LKS_BG.Address2+2
	
	ldx #$10*\3
	stx LKS_BG.limitex
	
	ldx #2*\3
	stx LKS_BG.addyr
	
	ldx #$20*\3
	stx LKS_BG.addy
	
	ldx #$10*\4
	stx LKS_BG.limitey
	

	lda #:\5
	ldx #\5
	
	stx LKS_BG.Addressc+0
	sta LKS_BG.Addressc+2
	
	
.ENDM
