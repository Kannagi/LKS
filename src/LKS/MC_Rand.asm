
.MACRO LKS_RAND
	lda #0
	xba
	lda LKS.rand

	rep #$20

	asl
	asl	; A *= 4
	
	clc
	adc LKS.rand
	
	clc
	adc #3
	
	and #$00ff
	clc
	
	sep #$20
	sta LKS.rand
.ENDM
