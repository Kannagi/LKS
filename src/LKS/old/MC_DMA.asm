

.MACRO LKS_DMA_PORTX 


	lda #1
	sta LKS_DMA.Enable,x
	
	
	lda \1
	sta LKS_DMA.Bank,x
	
	rep #$20
	
	lda #\2
	sta LKS_DMA.SrcR,x
	
	lda \3
	sta LKS_DMA.Src1,x
	
	lda #\4
	sta LKS_DMA.Dst1,x
	
	sep #$20
	
	lda #\5
	sta LKS_DMA.Type1,x
	
	
	
.ENDM

.MACRO LKS_DMA_VRAM2

	lda LKS_DMA_SEND.Enable+\1
	cmp #0
	beq +
		rep #$20
		
		lda LKS_DMA_SEND.dma+\1
		tax
		stx MEM_TEMPFUNC+0
		
		lda LKS_DMA.Bank,x
		sta MEM_TEMPFUNC+2
		
		lda LKS_DMA.SrcR,x
		sta MEM_TEMPFUNC+4
		
		lda LKS_DMA.Func,x
		sta 0
		
		sep #$20
		
		ldx #0
		
		;jsr (0,x)
		
		lda #0
		sta LKS_DMA.Enable+$20*\1
	+:
	
.ENDM

.MACRO LKS_DMA_VRAM

	lda LKS_DMA.Enable+$20*\1
	cmp #0
	beq +
		ldx #$20*\1
		stx MEM_TEMPFUNC
		
				
		lda LKS_DMA.Bank+$20*\1
		sta MEM_TEMPFUNC+2
		
		rep #$20
		
		lda LKS_DMA.SrcR+$20*\1
		sta MEM_TEMPFUNC+4
		
		lda LKS_DMA.Func+$20*\1
		sta 0
		
		sep #$20
		
		ldx #0
		
		jsr (0,x)
		
		lda #0
		sta LKS_DMA.Enable+$20*\1
	+:
	
.ENDM

