

.MACRO LKS_SPRITE_DRAW

	ldx LKS_SPRITE.OAM
	
	lda LKS_SPRITE.X+($20*\1)
	sta LKS_BUF_OAML+0,x

	lda LKS_SPRITE.Y+($20*\1)
	sta LKS_BUF_OAML+1,x
	
	lda LKS_SPRITE.Tile+($20*\1)
	sta LKS_BUF_OAML+2,x
	
	lda LKS_SPRITE.Flip+($20*\1)
	sta LKS_BUF_OAML+3,x

.ENDM

.MACRO LKS_SPRITE_INIT

	rep #$20
	lda #\1
	sta LKS_SPRITE.X,x
	
	lda #\1<<2
	sta LKS_SPRITE.PX,x
	
	lda #\2
	sta LKS_SPRITE.Y,x
	
	lda #\2<<2
	sta LKS_SPRITE.PY,x
	
	lda #4*\6
	sta LKS_SPRITE.OAM,x
	
	sep #$20
	
	lda #\3
	sta LKS_SPRITE.Tile,x
	
	lda #$20+\4
	sta LKS_SPRITE.Flip,x
	
	lda #\5
	sta LKS_SPRITE.Ext,x
.ENDM

.MACRO LKS_SPRITE_ANIM_INIT

	stz LKS_SPRITE.Anim_i,x
	stz LKS_SPRITE.Anim_l,x
	stz LKS_SPRITE.Anim_old,x
	stz LKS_SPRITE.Anim_end,x
	
	lda #\1
	sta LKS_SPRITE.Anim_flg,x
	
	lda #\2
	sta LKS_SPRITE.Anim_act,x
	
	lda #\3
	sta LKS_SPRITE.Anim_v,x
	
	lda #\4
	sta LKS_SPRITE.Anim_n,x
.ENDM
