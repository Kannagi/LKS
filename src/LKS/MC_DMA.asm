
.MACRO LKS_DMA_INIT ARGS _Bank,_Size,_SrcR,_Dst,_Func

	lda #1
	sta LKS_DMA.Enable,x
	
	lda #:\1
	sta LKS_DMA.Bank,x
	
	rep #$20
	
	lda #\1
	sta LKS_DMA.Src1,x
	sta LKS_SPRITE.Address,x
	
.DEFINE LKSDMA_SIZE 0

	lda #\2/(1+\5)
	sta LKS_DMA.Size1,x
	
	lda #(\2/5.12)+18 + (5*\5)
	sta LKS_DMA.dmat,x
	
	lda #4*\3
	sta LKS_DMA.SrcR,x
	
	lda #\4
	sta LKS_DMA.Dst1,x
	
	lda #LKS_DMA_VRAM1
	sta LKS_DMA.Func,x
	
.IF _Func == 1
 	lda #LKS_DMA_VRAM1x2
	sta LKS_DMA.Func,x
.ENDIF

.IF _Func == 2
 	lda #LKS_DMA_VRAM1x3
	sta LKS_DMA.Func,x
.ENDIF

.IF _Func == 3
 	lda #LKS_DMA_VRAM1x4
	sta LKS_DMA.Func,x
.ENDIF

.IF _Func == 4
 	lda #LKS_DMA_VRAM2
	sta LKS_DMA.Func,x
.ENDIF
	sep #$20
	
.UNDEFINE LKSDMA_SIZE
.ENDM

.MACRO LKS_DMA_VRAM

	lda LKS_DMA_SEND.Enable+(2*\1)
	cmp #0
	beq +
		rep #$20
		
		lda LKS_DMA_SEND.dma+(2*\1)
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
		
		jsr (0,x)
		
		lda #0
		sta LKS_DMA_SEND.Enable+(2*\1)
	+:
	
.ENDM

.MACRO LKS_DMA_BG3_bloc
	cmp #\1
	bne +
		ldx #LKS_BUF_BG3&$FFFF+($200*\1)
		ldy #$5800+($100*\1)
	+:
.ENDM
