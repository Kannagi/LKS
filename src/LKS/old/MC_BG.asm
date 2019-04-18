
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

.MACRO LKS_BG1_update

	lda LKS_BG.1x
	sta BG1H0FS
	lda LKS_BG.1x+1
	sta BG1H0FS
	
	lda LKS_BG.1y
	sta BG1V0FS
	lda LKS_BG.1y+1
	sta BG1V0FS
	
.ENDM

.MACRO LKS_BG3_update

	lda LKS_BG.3x
	sta BG3H0FS
	lda LKS_BG.3x+1
	sta BG3H0FS
	
	lda LKS_BG.3y
	sta BG3V0FS
	lda LKS_BG.3y+1
	sta BG3V0FS
	
.ENDM

.MACRO LKS_BG4_update

	lda LKS_BG.4x
	sta BG4H0FS
	lda LKS_BG.4x+1
	sta BG4H0FS
	
	lda LKS_BG.4y
	sta BG4V0FS
	lda LKS_BG.4y+1
	sta BG4V0FS
	
.ENDM

.MACRO LKS_BG2_update

	lda LKS_BG.2x
	sta BG2H0FS
	lda LKS_BG.2x+1
	sta BG2H0FS
	
	lda LKS_BG.2y
	sta BG2V0FS
	lda LKS_BG.2y+1
	sta BG2V0FS
	
.ENDM

.MACRO LKS_BG1_cpy_BG2

	ldx LKS_BG.1x
	stx LKS_BG.2x
	
	ldx LKS_BG.1y
	stx LKS_BG.2y
	
.ENDM

.MACRO LKS_BG1_set

	ldx \1
	stx LKS_BG.1x
	
	ldx \2
	stx LKS_BG.1y
	
.ENDM

.MACRO LKS_BG2_set

	ldx \1
	stx LKS_BG.2x
	
	ldx \2
	stx LKS_BG.2y
	
.ENDM
