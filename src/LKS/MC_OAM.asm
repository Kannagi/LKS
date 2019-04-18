

.MACRO LKS_OAM4_Clear

	sta LKS_BUF_OAML + $01 + (\1*$10)
	sta LKS_BUF_OAML + $05 + (\1*$10)
	sta LKS_BUF_OAML + $09 + (\1*$10)
	sta LKS_BUF_OAML + $0D + (\1*$10)
.ENDM
