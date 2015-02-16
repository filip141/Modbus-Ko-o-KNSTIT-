   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
   4                     ; Optimizer V4.3.6 - 29 Nov 2011
  47                     ; 47 void UART2_DeInit(void)
  47                     ; 48 {
  49                     	switch	.text
  50  0000               _UART2_DeInit:
  54                     ; 51     (void) UART2->SR;
  56  0000 c65240        	ld	a,21056
  57                     ; 52     (void)UART2->DR;
  59  0003 c65241        	ld	a,21057
  60                     ; 54     UART2->BRR2 = UART2_BRR2_RESET_VALUE;  /*  Set UART2_BRR2 to reset value 0x00 */
  62  0006 725f5243      	clr	21059
  63                     ; 55     UART2->BRR1 = UART2_BRR1_RESET_VALUE;  /*  Set UART2_BRR1 to reset value 0x00 */
  65  000a 725f5242      	clr	21058
  66                     ; 57     UART2->CR1 = UART2_CR1_RESET_VALUE; /*  Set UART2_CR1 to reset value 0x00  */
  68  000e 725f5244      	clr	21060
  69                     ; 58     UART2->CR2 = UART2_CR2_RESET_VALUE; /*  Set UART2_CR2 to reset value 0x00  */
  71  0012 725f5245      	clr	21061
  72                     ; 59     UART2->CR3 = UART2_CR3_RESET_VALUE; /*  Set UART2_CR3 to reset value 0x00  */
  74  0016 725f5246      	clr	21062
  75                     ; 60     UART2->CR4 = UART2_CR4_RESET_VALUE; /*  Set UART2_CR4 to reset value 0x00  */
  77  001a 725f5247      	clr	21063
  78                     ; 61     UART2->CR5 = UART2_CR5_RESET_VALUE; /*  Set UART2_CR5 to reset value 0x00  */
  80  001e 725f5248      	clr	21064
  81                     ; 62     UART2->CR6 = UART2_CR6_RESET_VALUE; /*  Set UART2_CR6 to reset value 0x00  */
  83  0022 725f5249      	clr	21065
  84                     ; 64 }
  87  0026 81            	ret	
 408                     .const:	section	.text
 409  0000               L41:
 410  0000 00000064      	dc.l	100
 411                     ; 80 void UART2_Init(uint32_t BaudRate, UART2_WordLength_TypeDef WordLength, UART2_StopBits_TypeDef StopBits, UART2_Parity_TypeDef Parity, UART2_SyncMode_TypeDef SyncMode, UART2_Mode_TypeDef Mode)
 411                     ; 81 {
 412                     	switch	.text
 413  0027               _UART2_Init:
 415       0000000e      OFST:	set	14
 418                     ; 82     uint8_t BRR2_1 = 0, BRR2_2 = 0;
 422                     ; 83     uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 426                     ; 86     assert_param(IS_UART2_BAUDRATE_OK(BaudRate));
 428                     ; 87     assert_param(IS_UART2_WORDLENGTH_OK(WordLength));
 430                     ; 88     assert_param(IS_UART2_STOPBITS_OK(StopBits));
 432                     ; 89     assert_param(IS_UART2_PARITY_OK(Parity));
 434                     ; 90     assert_param(IS_UART2_MODE_OK((uint8_t)Mode));
 436                     ; 91     assert_param(IS_UART2_SYNCMODE_OK((uint8_t)SyncMode));
 438                     ; 94     UART2->CR1 &= (uint8_t)(~UART2_CR1_M);
 440  0027 72195244      	bres	21060,#4
 441  002b 520e          	subw	sp,#14
 442                     ; 96     UART2->CR1 |= (uint8_t)WordLength; 
 444  002d c65244        	ld	a,21060
 445  0030 1a15          	or	a,(OFST+7,sp)
 446  0032 c75244        	ld	21060,a
 447                     ; 99     UART2->CR3 &= (uint8_t)(~UART2_CR3_STOP);
 449  0035 c65246        	ld	a,21062
 450  0038 a4cf          	and	a,#207
 451  003a c75246        	ld	21062,a
 452                     ; 101     UART2->CR3 |= (uint8_t)StopBits; 
 454  003d c65246        	ld	a,21062
 455  0040 1a16          	or	a,(OFST+8,sp)
 456  0042 c75246        	ld	21062,a
 457                     ; 104     UART2->CR1 &= (uint8_t)(~(UART2_CR1_PCEN | UART2_CR1_PS  ));
 459  0045 c65244        	ld	a,21060
 460  0048 a4f9          	and	a,#249
 461  004a c75244        	ld	21060,a
 462                     ; 106     UART2->CR1 |= (uint8_t)Parity;
 464  004d c65244        	ld	a,21060
 465  0050 1a17          	or	a,(OFST+9,sp)
 466  0052 c75244        	ld	21060,a
 467                     ; 109     UART2->BRR1 &= (uint8_t)(~UART2_BRR1_DIVM);
 469  0055 725f5242      	clr	21058
 470                     ; 111     UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVM);
 472  0059 c65243        	ld	a,21059
 473  005c a40f          	and	a,#15
 474  005e c75243        	ld	21059,a
 475                     ; 113     UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVF);
 477  0061 c65243        	ld	a,21059
 478  0064 a4f0          	and	a,#240
 479  0066 c75243        	ld	21059,a
 480                     ; 116     BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 482  0069 96            	ldw	x,sp
 483  006a cd013d        	call	LC001
 485  006d 96            	ldw	x,sp
 486  006e 5c            	incw	x
 487  006f cd0000        	call	c_rtol
 489  0072 cd0000        	call	_CLK_GetClockFreq
 491  0075 96            	ldw	x,sp
 492  0076 5c            	incw	x
 493  0077 cd0000        	call	c_ludv
 495  007a 96            	ldw	x,sp
 496  007b 1c000b        	addw	x,#OFST-3
 497  007e cd0000        	call	c_rtol
 499                     ; 117     BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 501  0081 96            	ldw	x,sp
 502  0082 cd013d        	call	LC001
 504  0085 96            	ldw	x,sp
 505  0086 5c            	incw	x
 506  0087 cd0000        	call	c_rtol
 508  008a cd0000        	call	_CLK_GetClockFreq
 510  008d a664          	ld	a,#100
 511  008f cd0000        	call	c_smul
 513  0092 96            	ldw	x,sp
 514  0093 5c            	incw	x
 515  0094 cd0000        	call	c_ludv
 517  0097 96            	ldw	x,sp
 518  0098 1c0007        	addw	x,#OFST-7
 519  009b cd0000        	call	c_rtol
 521                     ; 121     BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 521                     ; 122                         << 4) / 100) & (uint8_t)0x0F); 
 523  009e 96            	ldw	x,sp
 524  009f 1c000b        	addw	x,#OFST-3
 525  00a2 cd0000        	call	c_ltor
 527  00a5 a664          	ld	a,#100
 528  00a7 cd0000        	call	c_smul
 530  00aa 96            	ldw	x,sp
 531  00ab 5c            	incw	x
 532  00ac cd0000        	call	c_rtol
 534  00af 96            	ldw	x,sp
 535  00b0 1c0007        	addw	x,#OFST-7
 536  00b3 cd0000        	call	c_ltor
 538  00b6 96            	ldw	x,sp
 539  00b7 5c            	incw	x
 540  00b8 cd0000        	call	c_lsub
 542  00bb a604          	ld	a,#4
 543  00bd cd0000        	call	c_llsh
 545  00c0 ae0000        	ldw	x,#L41
 546  00c3 cd0000        	call	c_ludv
 548  00c6 b603          	ld	a,c_lreg+3
 549  00c8 a40f          	and	a,#15
 550  00ca 6b05          	ld	(OFST-9,sp),a
 551                     ; 123     BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 553  00cc 96            	ldw	x,sp
 554  00cd 1c000b        	addw	x,#OFST-3
 555  00d0 cd0000        	call	c_ltor
 557  00d3 a604          	ld	a,#4
 558  00d5 cd0000        	call	c_lursh
 560  00d8 b603          	ld	a,c_lreg+3
 561  00da a4f0          	and	a,#240
 562  00dc b703          	ld	c_lreg+3,a
 563  00de 3f02          	clr	c_lreg+2
 564  00e0 3f01          	clr	c_lreg+1
 565  00e2 3f00          	clr	c_lreg
 566  00e4 6b06          	ld	(OFST-8,sp),a
 567                     ; 125     UART2->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 569  00e6 1a05          	or	a,(OFST-9,sp)
 570  00e8 c75243        	ld	21059,a
 571                     ; 127     UART2->BRR1 = (uint8_t)BaudRate_Mantissa;           
 573  00eb 7b0e          	ld	a,(OFST+0,sp)
 574  00ed c75242        	ld	21058,a
 575                     ; 130     UART2->CR2 &= (uint8_t)~(UART2_CR2_TEN | UART2_CR2_REN);
 577  00f0 c65245        	ld	a,21061
 578  00f3 a4f3          	and	a,#243
 579  00f5 c75245        	ld	21061,a
 580                     ; 132     UART2->CR3 &= (uint8_t)~(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL);
 582  00f8 c65246        	ld	a,21062
 583  00fb a4f8          	and	a,#248
 584  00fd c75246        	ld	21062,a
 585                     ; 134     UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART2_CR3_CPOL | \
 585                     ; 135                                               UART2_CR3_CPHA | UART2_CR3_LBCL));
 587  0100 7b18          	ld	a,(OFST+10,sp)
 588  0102 a407          	and	a,#7
 589  0104 ca5246        	or	a,21062
 590  0107 c75246        	ld	21062,a
 591                     ; 137     if ((uint8_t)(Mode & UART2_MODE_TX_ENABLE))
 593  010a 7b19          	ld	a,(OFST+11,sp)
 594  010c a504          	bcp	a,#4
 595  010e 2706          	jreq	L302
 596                     ; 140         UART2->CR2 |= (uint8_t)UART2_CR2_TEN;
 598  0110 72165245      	bset	21061,#3
 600  0114 2004          	jra	L502
 601  0116               L302:
 602                     ; 145         UART2->CR2 &= (uint8_t)(~UART2_CR2_TEN);
 604  0116 72175245      	bres	21061,#3
 605  011a               L502:
 606                     ; 147     if ((uint8_t)(Mode & UART2_MODE_RX_ENABLE))
 608  011a a508          	bcp	a,#8
 609  011c 2706          	jreq	L702
 610                     ; 150         UART2->CR2 |= (uint8_t)UART2_CR2_REN;
 612  011e 72145245      	bset	21061,#2
 614  0122 2004          	jra	L112
 615  0124               L702:
 616                     ; 155         UART2->CR2 &= (uint8_t)(~UART2_CR2_REN);
 618  0124 72155245      	bres	21061,#2
 619  0128               L112:
 620                     ; 159     if ((uint8_t)(SyncMode & UART2_SYNCMODE_CLOCK_DISABLE))
 622  0128 7b18          	ld	a,(OFST+10,sp)
 623  012a 2a06          	jrpl	L312
 624                     ; 162         UART2->CR3 &= (uint8_t)(~UART2_CR3_CKEN); 
 626  012c 72175246      	bres	21062,#3
 628  0130 2008          	jra	L512
 629  0132               L312:
 630                     ; 166         UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & UART2_CR3_CKEN);
 632  0132 a408          	and	a,#8
 633  0134 ca5246        	or	a,21062
 634  0137 c75246        	ld	21062,a
 635  013a               L512:
 636                     ; 168 }
 639  013a 5b0e          	addw	sp,#14
 640  013c 81            	ret	
 641  013d               LC001:
 642  013d 1c0011        	addw	x,#OFST+3
 643  0140 cd0000        	call	c_ltor
 645  0143 a604          	ld	a,#4
 646  0145 cc0000        	jp	c_llsh
 701                     ; 176 void UART2_Cmd(FunctionalState NewState)
 701                     ; 177 {
 702                     	switch	.text
 703  0148               _UART2_Cmd:
 707                     ; 179     if (NewState != DISABLE)
 709  0148 4d            	tnz	a
 710  0149 2705          	jreq	L542
 711                     ; 182         UART2->CR1 &= (uint8_t)(~UART2_CR1_UARTD);
 713  014b 721b5244      	bres	21060,#5
 716  014f 81            	ret	
 717  0150               L542:
 718                     ; 187         UART2->CR1 |= UART2_CR1_UARTD; 
 720  0150 721a5244      	bset	21060,#5
 721                     ; 189 }
 724  0154 81            	ret	
 856                     ; 206 void UART2_ITConfig(UART2_IT_TypeDef UART2_IT, FunctionalState NewState)
 856                     ; 207 {
 857                     	switch	.text
 858  0155               _UART2_ITConfig:
 860  0155 89            	pushw	x
 861  0156 89            	pushw	x
 862       00000002      OFST:	set	2
 865                     ; 208     uint8_t uartreg = 0, itpos = 0x00;
 869                     ; 211     assert_param(IS_UART2_CONFIG_IT_OK(UART2_IT));
 871                     ; 212     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 873                     ; 215     uartreg = (uint8_t)((uint16_t)UART2_IT >> 0x08);
 875  0157 9e            	ld	a,xh
 876  0158 6b01          	ld	(OFST-1,sp),a
 877                     ; 218     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
 879  015a 9f            	ld	a,xl
 880  015b a40f          	and	a,#15
 881  015d 5f            	clrw	x
 882  015e 97            	ld	xl,a
 883  015f a601          	ld	a,#1
 884  0161 5d            	tnzw	x
 885  0162 2704          	jreq	L22
 886  0164               L42:
 887  0164 48            	sll	a
 888  0165 5a            	decw	x
 889  0166 26fc          	jrne	L42
 890  0168               L22:
 891  0168 6b02          	ld	(OFST+0,sp),a
 892                     ; 220     if (NewState != DISABLE)
 894  016a 7b07          	ld	a,(OFST+5,sp)
 895  016c 272a          	jreq	L133
 896                     ; 223         if (uartreg == 0x01)
 898  016e 7b01          	ld	a,(OFST-1,sp)
 899  0170 a101          	cp	a,#1
 900  0172 2607          	jrne	L333
 901                     ; 225             UART2->CR1 |= itpos;
 903  0174 c65244        	ld	a,21060
 904  0177 1a02          	or	a,(OFST+0,sp)
 906  0179 2029          	jp	LC004
 907  017b               L333:
 908                     ; 227         else if (uartreg == 0x02)
 910  017b a102          	cp	a,#2
 911  017d 2607          	jrne	L733
 912                     ; 229             UART2->CR2 |= itpos;
 914  017f c65245        	ld	a,21061
 915  0182 1a02          	or	a,(OFST+0,sp)
 917  0184 202d          	jp	LC003
 918  0186               L733:
 919                     ; 231         else if (uartreg == 0x03)
 921  0186 a103          	cp	a,#3
 922  0188 2607          	jrne	L343
 923                     ; 233             UART2->CR4 |= itpos;
 925  018a c65247        	ld	a,21063
 926  018d 1a02          	or	a,(OFST+0,sp)
 928  018f 2031          	jp	LC005
 929  0191               L343:
 930                     ; 237             UART2->CR6 |= itpos;
 932  0191 c65249        	ld	a,21065
 933  0194 1a02          	or	a,(OFST+0,sp)
 934  0196 2035          	jp	LC002
 935  0198               L133:
 936                     ; 243         if (uartreg == 0x01)
 938  0198 7b01          	ld	a,(OFST-1,sp)
 939  019a a101          	cp	a,#1
 940  019c 260b          	jrne	L153
 941                     ; 245             UART2->CR1 &= (uint8_t)(~itpos);
 943  019e 7b02          	ld	a,(OFST+0,sp)
 944  01a0 43            	cpl	a
 945  01a1 c45244        	and	a,21060
 946  01a4               LC004:
 947  01a4 c75244        	ld	21060,a
 949  01a7 2027          	jra	L743
 950  01a9               L153:
 951                     ; 247         else if (uartreg == 0x02)
 953  01a9 a102          	cp	a,#2
 954  01ab 260b          	jrne	L553
 955                     ; 249             UART2->CR2 &= (uint8_t)(~itpos);
 957  01ad 7b02          	ld	a,(OFST+0,sp)
 958  01af 43            	cpl	a
 959  01b0 c45245        	and	a,21061
 960  01b3               LC003:
 961  01b3 c75245        	ld	21061,a
 963  01b6 2018          	jra	L743
 964  01b8               L553:
 965                     ; 251         else if (uartreg == 0x03)
 967  01b8 a103          	cp	a,#3
 968  01ba 260b          	jrne	L163
 969                     ; 253             UART2->CR4 &= (uint8_t)(~itpos);
 971  01bc 7b02          	ld	a,(OFST+0,sp)
 972  01be 43            	cpl	a
 973  01bf c45247        	and	a,21063
 974  01c2               LC005:
 975  01c2 c75247        	ld	21063,a
 977  01c5 2009          	jra	L743
 978  01c7               L163:
 979                     ; 257             UART2->CR6 &= (uint8_t)(~itpos);
 981  01c7 7b02          	ld	a,(OFST+0,sp)
 982  01c9 43            	cpl	a
 983  01ca c45249        	and	a,21065
 984  01cd               LC002:
 985  01cd c75249        	ld	21065,a
 986  01d0               L743:
 987                     ; 260 }
 990  01d0 5b04          	addw	sp,#4
 991  01d2 81            	ret	
1048                     ; 267 void UART2_IrDAConfig(UART2_IrDAMode_TypeDef UART2_IrDAMode)
1048                     ; 268 {
1049                     	switch	.text
1050  01d3               _UART2_IrDAConfig:
1054                     ; 269     assert_param(IS_UART2_IRDAMODE_OK(UART2_IrDAMode));
1056                     ; 271     if (UART2_IrDAMode != UART2_IRDAMODE_NORMAL)
1058  01d3 4d            	tnz	a
1059  01d4 2705          	jreq	L314
1060                     ; 273         UART2->CR5 |= UART2_CR5_IRLP;
1062  01d6 72145248      	bset	21064,#2
1065  01da 81            	ret	
1066  01db               L314:
1067                     ; 277         UART2->CR5 &= ((uint8_t)~UART2_CR5_IRLP);
1069  01db 72155248      	bres	21064,#2
1070                     ; 279 }
1073  01df 81            	ret	
1108                     ; 287 void UART2_IrDACmd(FunctionalState NewState)
1108                     ; 288 {
1109                     	switch	.text
1110  01e0               _UART2_IrDACmd:
1114                     ; 290     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1116                     ; 292     if (NewState != DISABLE)
1118  01e0 4d            	tnz	a
1119  01e1 2705          	jreq	L534
1120                     ; 295         UART2->CR5 |= UART2_CR5_IREN;
1122  01e3 72125248      	bset	21064,#1
1125  01e7 81            	ret	
1126  01e8               L534:
1127                     ; 300         UART2->CR5 &= ((uint8_t)~UART2_CR5_IREN);
1129  01e8 72135248      	bres	21064,#1
1130                     ; 302 }
1133  01ec 81            	ret	
1192                     ; 311 void UART2_LINBreakDetectionConfig(UART2_LINBreakDetectionLength_TypeDef UART2_LINBreakDetectionLength)
1192                     ; 312 {
1193                     	switch	.text
1194  01ed               _UART2_LINBreakDetectionConfig:
1198                     ; 314     assert_param(IS_UART2_LINBREAKDETECTIONLENGTH_OK(UART2_LINBreakDetectionLength));
1200                     ; 316     if (UART2_LINBreakDetectionLength != UART2_LINBREAKDETECTIONLENGTH_10BITS)
1202  01ed 4d            	tnz	a
1203  01ee 2705          	jreq	L764
1204                     ; 318         UART2->CR4 |= UART2_CR4_LBDL;
1206  01f0 721a5247      	bset	21063,#5
1209  01f4 81            	ret	
1210  01f5               L764:
1211                     ; 322         UART2->CR4 &= ((uint8_t)~UART2_CR4_LBDL);
1213  01f5 721b5247      	bres	21063,#5
1214                     ; 324 }
1217  01f9 81            	ret	
1338                     ; 336 void UART2_LINConfig(UART2_LinMode_TypeDef UART2_Mode, 
1338                     ; 337                      UART2_LinAutosync_TypeDef UART2_Autosync, 
1338                     ; 338                      UART2_LinDivUp_TypeDef UART2_DivUp)
1338                     ; 339 {
1339                     	switch	.text
1340  01fa               _UART2_LINConfig:
1342  01fa 89            	pushw	x
1343       00000000      OFST:	set	0
1346                     ; 341     assert_param(IS_UART2_SLAVE_OK(UART2_Mode));
1348                     ; 342     assert_param(IS_UART2_AUTOSYNC_OK(UART2_Autosync));
1350                     ; 343     assert_param(IS_UART2_DIVUP_OK(UART2_DivUp));
1352                     ; 345     if (UART2_Mode != UART2_LIN_MODE_MASTER)
1354  01fb 9e            	ld	a,xh
1355  01fc 4d            	tnz	a
1356  01fd 2706          	jreq	L155
1357                     ; 347         UART2->CR6 |=  UART2_CR6_LSLV;
1359  01ff 721a5249      	bset	21065,#5
1361  0203 2004          	jra	L355
1362  0205               L155:
1363                     ; 351         UART2->CR6 &= ((uint8_t)~UART2_CR6_LSLV);
1365  0205 721b5249      	bres	21065,#5
1366  0209               L355:
1367                     ; 354     if (UART2_Autosync != UART2_LIN_AUTOSYNC_DISABLE)
1369  0209 7b02          	ld	a,(OFST+2,sp)
1370  020b 2706          	jreq	L555
1371                     ; 356         UART2->CR6 |=  UART2_CR6_LASE ;
1373  020d 72185249      	bset	21065,#4
1375  0211 2004          	jra	L755
1376  0213               L555:
1377                     ; 360         UART2->CR6 &= ((uint8_t)~ UART2_CR6_LASE );
1379  0213 72195249      	bres	21065,#4
1380  0217               L755:
1381                     ; 363     if (UART2_DivUp != UART2_LIN_DIVUP_LBRR1)
1383  0217 7b05          	ld	a,(OFST+5,sp)
1384  0219 2706          	jreq	L165
1385                     ; 365         UART2->CR6 |=  UART2_CR6_LDUM;
1387  021b 721e5249      	bset	21065,#7
1389  021f 2004          	jra	L365
1390  0221               L165:
1391                     ; 369         UART2->CR6 &= ((uint8_t)~ UART2_CR6_LDUM);
1393  0221 721f5249      	bres	21065,#7
1394  0225               L365:
1395                     ; 371 }
1398  0225 85            	popw	x
1399  0226 81            	ret	
1434                     ; 379 void UART2_LINCmd(FunctionalState NewState)
1434                     ; 380 {
1435                     	switch	.text
1436  0227               _UART2_LINCmd:
1440                     ; 381     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1442                     ; 383     if (NewState != DISABLE)
1444  0227 4d            	tnz	a
1445  0228 2705          	jreq	L306
1446                     ; 386         UART2->CR3 |= UART2_CR3_LINEN;
1448  022a 721c5246      	bset	21062,#6
1451  022e 81            	ret	
1452  022f               L306:
1453                     ; 391         UART2->CR3 &= ((uint8_t)~UART2_CR3_LINEN);
1455  022f 721d5246      	bres	21062,#6
1456                     ; 393 }
1459  0233 81            	ret	
1494                     ; 400 void UART2_SmartCardCmd(FunctionalState NewState)
1494                     ; 401 {
1495                     	switch	.text
1496  0234               _UART2_SmartCardCmd:
1500                     ; 403     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1502                     ; 405     if (NewState != DISABLE)
1504  0234 4d            	tnz	a
1505  0235 2705          	jreq	L526
1506                     ; 408         UART2->CR5 |= UART2_CR5_SCEN;
1508  0237 721a5248      	bset	21064,#5
1511  023b 81            	ret	
1512  023c               L526:
1513                     ; 413         UART2->CR5 &= ((uint8_t)(~UART2_CR5_SCEN));
1515  023c 721b5248      	bres	21064,#5
1516                     ; 415 }
1519  0240 81            	ret	
1555                     ; 423 void UART2_SmartCardNACKCmd(FunctionalState NewState)
1555                     ; 424 {
1556                     	switch	.text
1557  0241               _UART2_SmartCardNACKCmd:
1561                     ; 426     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1563                     ; 428     if (NewState != DISABLE)
1565  0241 4d            	tnz	a
1566  0242 2705          	jreq	L746
1567                     ; 431         UART2->CR5 |= UART2_CR5_NACK;
1569  0244 72185248      	bset	21064,#4
1572  0248 81            	ret	
1573  0249               L746:
1574                     ; 436         UART2->CR5 &= ((uint8_t)~(UART2_CR5_NACK));
1576  0249 72195248      	bres	21064,#4
1577                     ; 438 }
1580  024d 81            	ret	
1637                     ; 446 void UART2_WakeUpConfig(UART2_WakeUp_TypeDef UART2_WakeUp)
1637                     ; 447 {
1638                     	switch	.text
1639  024e               _UART2_WakeUpConfig:
1643                     ; 448     assert_param(IS_UART2_WAKEUP_OK(UART2_WakeUp));
1645                     ; 450     UART2->CR1 &= ((uint8_t)~UART2_CR1_WAKE);
1647  024e 72175244      	bres	21060,#3
1648                     ; 451     UART2->CR1 |= (uint8_t)UART2_WakeUp;
1650  0252 ca5244        	or	a,21060
1651  0255 c75244        	ld	21060,a
1652                     ; 452 }
1655  0258 81            	ret	
1691                     ; 460 void UART2_ReceiverWakeUpCmd(FunctionalState NewState)
1691                     ; 461 {
1692                     	switch	.text
1693  0259               _UART2_ReceiverWakeUpCmd:
1697                     ; 462     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1699                     ; 464     if (NewState != DISABLE)
1701  0259 4d            	tnz	a
1702  025a 2705          	jreq	L717
1703                     ; 467         UART2->CR2 |= UART2_CR2_RWU;
1705  025c 72125245      	bset	21061,#1
1708  0260 81            	ret	
1709  0261               L717:
1710                     ; 472         UART2->CR2 &= ((uint8_t)~UART2_CR2_RWU);
1712  0261 72135245      	bres	21061,#1
1713                     ; 474 }
1716  0265 81            	ret	
1739                     ; 481 uint8_t UART2_ReceiveData8(void)
1739                     ; 482 {
1740                     	switch	.text
1741  0266               _UART2_ReceiveData8:
1745                     ; 483     return ((uint8_t)UART2->DR);
1747  0266 c65241        	ld	a,21057
1750  0269 81            	ret	
1784                     ; 491 uint16_t UART2_ReceiveData9(void)
1784                     ; 492 {
1785                     	switch	.text
1786  026a               _UART2_ReceiveData9:
1788  026a 89            	pushw	x
1789       00000002      OFST:	set	2
1792                     ; 493   uint16_t temp = 0;
1794                     ; 495   temp = ((uint16_t)(((uint16_t)((uint16_t)UART2->CR1 & (uint16_t)UART2_CR1_R8)) << 1));
1796  026b c65244        	ld	a,21060
1797  026e a480          	and	a,#128
1798  0270 5f            	clrw	x
1799  0271 02            	rlwa	x,a
1800  0272 58            	sllw	x
1801  0273 1f01          	ldw	(OFST-1,sp),x
1802                     ; 497   return (uint16_t)((((uint16_t)UART2->DR) | temp) & ((uint16_t)0x01FF));
1804  0275 5f            	clrw	x
1805  0276 c65241        	ld	a,21057
1806  0279 97            	ld	xl,a
1807  027a 01            	rrwa	x,a
1808  027b 1a02          	or	a,(OFST+0,sp)
1809  027d 01            	rrwa	x,a
1810  027e 1a01          	or	a,(OFST-1,sp)
1811  0280 a401          	and	a,#1
1812  0282 01            	rrwa	x,a
1815  0283 5b02          	addw	sp,#2
1816  0285 81            	ret	
1850                     ; 505 void UART2_SendData8(uint8_t Data)
1850                     ; 506 {
1851                     	switch	.text
1852  0286               _UART2_SendData8:
1856                     ; 508     UART2->DR = Data;
1858  0286 c75241        	ld	21057,a
1859                     ; 509 }
1862  0289 81            	ret	
1896                     ; 516 void UART2_SendData9(uint16_t Data)
1896                     ; 517 {
1897                     	switch	.text
1898  028a               _UART2_SendData9:
1900  028a 89            	pushw	x
1901       00000000      OFST:	set	0
1904                     ; 519     UART2->CR1 &= ((uint8_t)~UART2_CR1_T8);                  
1906  028b 721d5244      	bres	21060,#6
1907                     ; 522     UART2->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART2_CR1_T8); 
1909  028f 54            	srlw	x
1910  0290 54            	srlw	x
1911  0291 9f            	ld	a,xl
1912  0292 a440          	and	a,#64
1913  0294 ca5244        	or	a,21060
1914  0297 c75244        	ld	21060,a
1915                     ; 525     UART2->DR   = (uint8_t)(Data);                    
1917  029a 7b02          	ld	a,(OFST+2,sp)
1918  029c c75241        	ld	21057,a
1919                     ; 527 }
1922  029f 85            	popw	x
1923  02a0 81            	ret	
1946                     ; 534 void UART2_SendBreak(void)
1946                     ; 535 {
1947                     	switch	.text
1948  02a1               _UART2_SendBreak:
1952                     ; 536     UART2->CR2 |= UART2_CR2_SBK;
1954  02a1 72105245      	bset	21061,#0
1955                     ; 537 }
1958  02a5 81            	ret	
1992                     ; 544 void UART2_SetAddress(uint8_t UART2_Address)
1992                     ; 545 {
1993                     	switch	.text
1994  02a6               _UART2_SetAddress:
1996  02a6 88            	push	a
1997       00000000      OFST:	set	0
2000                     ; 547     assert_param(IS_UART2_ADDRESS_OK(UART2_Address));
2002                     ; 550     UART2->CR4 &= ((uint8_t)~UART2_CR4_ADD);
2004  02a7 c65247        	ld	a,21063
2005  02aa a4f0          	and	a,#240
2006  02ac c75247        	ld	21063,a
2007                     ; 552     UART2->CR4 |= UART2_Address;
2009  02af c65247        	ld	a,21063
2010  02b2 1a01          	or	a,(OFST+1,sp)
2011  02b4 c75247        	ld	21063,a
2012                     ; 553 }
2015  02b7 84            	pop	a
2016  02b8 81            	ret	
2050                     ; 561 void UART2_SetGuardTime(uint8_t UART2_GuardTime)
2050                     ; 562 {
2051                     	switch	.text
2052  02b9               _UART2_SetGuardTime:
2056                     ; 564     UART2->GTR = UART2_GuardTime;
2058  02b9 c7524a        	ld	21066,a
2059                     ; 565 }
2062  02bc 81            	ret	
2096                     ; 589 void UART2_SetPrescaler(uint8_t UART2_Prescaler)
2096                     ; 590 {
2097                     	switch	.text
2098  02bd               _UART2_SetPrescaler:
2102                     ; 592     UART2->PSCR = UART2_Prescaler;
2104  02bd c7524b        	ld	21067,a
2105                     ; 593 }
2108  02c0 81            	ret	
2265                     ; 601 FlagStatus UART2_GetFlagStatus(UART2_Flag_TypeDef UART2_FLAG)
2265                     ; 602 {
2266                     	switch	.text
2267  02c1               _UART2_GetFlagStatus:
2269  02c1 89            	pushw	x
2270  02c2 88            	push	a
2271       00000001      OFST:	set	1
2274                     ; 603     FlagStatus status = RESET;
2276                     ; 606     assert_param(IS_UART2_FLAG_OK(UART2_FLAG));
2278                     ; 609     if (UART2_FLAG == UART2_FLAG_LBDF)
2280  02c3 a30210        	cpw	x,#528
2281  02c6 2608          	jrne	L5511
2282                     ; 611         if ((UART2->CR4 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2284  02c8 9f            	ld	a,xl
2285  02c9 c45247        	and	a,21063
2286  02cc 2728          	jreq	L3611
2287                     ; 614             status = SET;
2289  02ce 2021          	jp	LC008
2290                     ; 619             status = RESET;
2291  02d0               L5511:
2292                     ; 622     else if (UART2_FLAG == UART2_FLAG_SBK)
2294  02d0 1e02          	ldw	x,(OFST+1,sp)
2295  02d2 a30101        	cpw	x,#257
2296  02d5 2609          	jrne	L5611
2297                     ; 624         if ((UART2->CR2 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2299  02d7 c65245        	ld	a,21061
2300  02da 1503          	bcp	a,(OFST+2,sp)
2301  02dc 2717          	jreq	L1021
2302                     ; 627             status = SET;
2304  02de 2011          	jp	LC008
2305                     ; 632             status = RESET;
2306  02e0               L5611:
2307                     ; 635     else if ((UART2_FLAG == UART2_FLAG_LHDF) || (UART2_FLAG == UART2_FLAG_LSF))
2309  02e0 a30302        	cpw	x,#770
2310  02e3 2705          	jreq	L7711
2312  02e5 a30301        	cpw	x,#769
2313  02e8 260f          	jrne	L5711
2314  02ea               L7711:
2315                     ; 637         if ((UART2->CR6 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2317  02ea c65249        	ld	a,21065
2318  02ed 1503          	bcp	a,(OFST+2,sp)
2319  02ef 2704          	jreq	L1021
2320                     ; 640             status = SET;
2322  02f1               LC008:
2326  02f1 a601          	ld	a,#1
2329  02f3 2001          	jra	L3611
2330  02f5               L1021:
2331                     ; 645             status = RESET;
2335  02f5 4f            	clr	a
2336  02f6               L3611:
2337                     ; 663     return  status;
2341  02f6 5b03          	addw	sp,#3
2342  02f8 81            	ret	
2343  02f9               L5711:
2344                     ; 650         if ((UART2->SR & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2346  02f9 c65240        	ld	a,21056
2347  02fc 1503          	bcp	a,(OFST+2,sp)
2348  02fe 27f5          	jreq	L1021
2349                     ; 653             status = SET;
2351  0300 20ef          	jp	LC008
2352                     ; 658             status = RESET;
2387                     ; 693 void UART2_ClearFlag(UART2_Flag_TypeDef UART2_FLAG)
2387                     ; 694 {
2388                     	switch	.text
2389  0302               _UART2_ClearFlag:
2391  0302 89            	pushw	x
2392       00000000      OFST:	set	0
2395                     ; 695     assert_param(IS_UART2_CLEAR_FLAG_OK(UART2_FLAG));
2397                     ; 698     if (UART2_FLAG == UART2_FLAG_RXNE)
2399  0303 a30020        	cpw	x,#32
2400  0306 2606          	jrne	L1321
2401                     ; 700         UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2403  0308 35df5240      	mov	21056,#223
2405  030c 201c          	jra	L3321
2406  030e               L1321:
2407                     ; 703     else if (UART2_FLAG == UART2_FLAG_LBDF)
2409  030e 1e01          	ldw	x,(OFST+1,sp)
2410  0310 a30210        	cpw	x,#528
2411  0313 2606          	jrne	L5321
2412                     ; 705         UART2->CR4 &= (uint8_t)(~UART2_CR4_LBDF);
2414  0315 72195247      	bres	21063,#4
2416  0319 200f          	jra	L3321
2417  031b               L5321:
2418                     ; 708     else if (UART2_FLAG == UART2_FLAG_LHDF)
2420  031b a30302        	cpw	x,#770
2421  031e 2606          	jrne	L1421
2422                     ; 710         UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2424  0320 72135249      	bres	21065,#1
2426  0324 2004          	jra	L3321
2427  0326               L1421:
2428                     ; 715         UART2->CR6 &= (uint8_t)(~UART2_CR6_LSF);
2430  0326 72115249      	bres	21065,#0
2431  032a               L3321:
2432                     ; 717 }
2435  032a 85            	popw	x
2436  032b 81            	ret	
2518                     ; 732 ITStatus UART2_GetITStatus(UART2_IT_TypeDef UART2_IT)
2518                     ; 733 {
2519                     	switch	.text
2520  032c               _UART2_GetITStatus:
2522  032c 89            	pushw	x
2523  032d 89            	pushw	x
2524       00000002      OFST:	set	2
2527                     ; 734     ITStatus pendingbitstatus = RESET;
2529                     ; 735     uint8_t itpos = 0;
2531                     ; 736     uint8_t itmask1 = 0;
2533                     ; 737     uint8_t itmask2 = 0;
2535                     ; 738     uint8_t enablestatus = 0;
2537                     ; 741     assert_param(IS_UART2_GET_IT_OK(UART2_IT));
2539                     ; 744     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
2541  032e 9f            	ld	a,xl
2542  032f a40f          	and	a,#15
2543  0331 5f            	clrw	x
2544  0332 97            	ld	xl,a
2545  0333 a601          	ld	a,#1
2546  0335 5d            	tnzw	x
2547  0336 2704          	jreq	L67
2548  0338               L001:
2549  0338 48            	sll	a
2550  0339 5a            	decw	x
2551  033a 26fc          	jrne	L001
2552  033c               L67:
2553  033c 6b01          	ld	(OFST-1,sp),a
2554                     ; 746     itmask1 = (uint8_t)((uint8_t)UART2_IT >> (uint8_t)4);
2556  033e 7b04          	ld	a,(OFST+2,sp)
2557  0340 4e            	swap	a
2558  0341 a40f          	and	a,#15
2559  0343 6b02          	ld	(OFST+0,sp),a
2560                     ; 748     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2562  0345 5f            	clrw	x
2563  0346 97            	ld	xl,a
2564  0347 a601          	ld	a,#1
2565  0349 5d            	tnzw	x
2566  034a 2704          	jreq	L201
2567  034c               L401:
2568  034c 48            	sll	a
2569  034d 5a            	decw	x
2570  034e 26fc          	jrne	L401
2571  0350               L201:
2572  0350 6b02          	ld	(OFST+0,sp),a
2573                     ; 751     if (UART2_IT == UART2_IT_PE)
2575  0352 1e03          	ldw	x,(OFST+1,sp)
2576  0354 a30100        	cpw	x,#256
2577  0357 260c          	jrne	L7031
2578                     ; 754         enablestatus = (uint8_t)((uint8_t)UART2->CR1 & itmask2);
2580  0359 c65244        	ld	a,21060
2581  035c 1402          	and	a,(OFST+0,sp)
2582  035e 6b02          	ld	(OFST+0,sp),a
2583                     ; 757         if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2585  0360 c65240        	ld	a,21056
2587                     ; 760             pendingbitstatus = SET;
2589  0363 2020          	jp	LC011
2590                     ; 765             pendingbitstatus = RESET;
2591  0365               L7031:
2592                     ; 768     else if (UART2_IT == UART2_IT_LBDF)
2594  0365 a30346        	cpw	x,#838
2595  0368 260c          	jrne	L7131
2596                     ; 771         enablestatus = (uint8_t)((uint8_t)UART2->CR4 & itmask2);
2598  036a c65247        	ld	a,21063
2599  036d 1402          	and	a,(OFST+0,sp)
2600  036f 6b02          	ld	(OFST+0,sp),a
2601                     ; 773         if (((UART2->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2603  0371 c65247        	ld	a,21063
2605                     ; 776             pendingbitstatus = SET;
2607  0374 200f          	jp	LC011
2608                     ; 781             pendingbitstatus = RESET;
2609  0376               L7131:
2610                     ; 784     else if (UART2_IT == UART2_IT_LHDF)
2612  0376 a30412        	cpw	x,#1042
2613  0379 2616          	jrne	L7231
2614                     ; 787         enablestatus = (uint8_t)((uint8_t)UART2->CR6 & itmask2);
2616  037b c65249        	ld	a,21065
2617  037e 1402          	and	a,(OFST+0,sp)
2618  0380 6b02          	ld	(OFST+0,sp),a
2619                     ; 789         if (((UART2->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
2621  0382 c65249        	ld	a,21065
2623  0385               LC011:
2624  0385 1501          	bcp	a,(OFST-1,sp)
2625  0387 271a          	jreq	L7331
2626  0389 7b02          	ld	a,(OFST+0,sp)
2627  038b 2716          	jreq	L7331
2628                     ; 792             pendingbitstatus = SET;
2630  038d               LC010:
2634  038d a601          	ld	a,#1
2636  038f 2013          	jra	L5131
2637                     ; 797             pendingbitstatus = RESET;
2638  0391               L7231:
2639                     ; 803         enablestatus = (uint8_t)((uint8_t)UART2->CR2 & itmask2);
2641  0391 c65245        	ld	a,21061
2642  0394 1402          	and	a,(OFST+0,sp)
2643  0396 6b02          	ld	(OFST+0,sp),a
2644                     ; 805         if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2646  0398 c65240        	ld	a,21056
2647  039b 1501          	bcp	a,(OFST-1,sp)
2648  039d 2704          	jreq	L7331
2650  039f 7b02          	ld	a,(OFST+0,sp)
2651                     ; 808             pendingbitstatus = SET;
2653  03a1 26ea          	jrne	LC010
2654  03a3               L7331:
2655                     ; 813             pendingbitstatus = RESET;
2660  03a3 4f            	clr	a
2661  03a4               L5131:
2662                     ; 817     return  pendingbitstatus;
2666  03a4 5b04          	addw	sp,#4
2667  03a6 81            	ret	
2703                     ; 846 void UART2_ClearITPendingBit(UART2_IT_TypeDef UART2_IT)
2703                     ; 847 {
2704                     	switch	.text
2705  03a7               _UART2_ClearITPendingBit:
2707  03a7 89            	pushw	x
2708       00000000      OFST:	set	0
2711                     ; 848     assert_param(IS_UART2_CLEAR_IT_OK(UART2_IT));
2713                     ; 851     if (UART2_IT == UART2_IT_RXNE)
2715  03a8 a30255        	cpw	x,#597
2716  03ab 2606          	jrne	L1631
2717                     ; 853         UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2719  03ad 35df5240      	mov	21056,#223
2721  03b1 2011          	jra	L3631
2722  03b3               L1631:
2723                     ; 856     else if (UART2_IT == UART2_IT_LBDF)
2725  03b3 1e01          	ldw	x,(OFST+1,sp)
2726  03b5 a30346        	cpw	x,#838
2727  03b8 2606          	jrne	L5631
2728                     ; 858         UART2->CR4 &= (uint8_t)~(UART2_CR4_LBDF);
2730  03ba 72195247      	bres	21063,#4
2732  03be 2004          	jra	L3631
2733  03c0               L5631:
2734                     ; 863         UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2736  03c0 72135249      	bres	21065,#1
2737  03c4               L3631:
2738                     ; 865 }
2741  03c4 85            	popw	x
2742  03c5 81            	ret	
2755                     	xdef	_UART2_ClearITPendingBit
2756                     	xdef	_UART2_GetITStatus
2757                     	xdef	_UART2_ClearFlag
2758                     	xdef	_UART2_GetFlagStatus
2759                     	xdef	_UART2_SetPrescaler
2760                     	xdef	_UART2_SetGuardTime
2761                     	xdef	_UART2_SetAddress
2762                     	xdef	_UART2_SendBreak
2763                     	xdef	_UART2_SendData9
2764                     	xdef	_UART2_SendData8
2765                     	xdef	_UART2_ReceiveData9
2766                     	xdef	_UART2_ReceiveData8
2767                     	xdef	_UART2_ReceiverWakeUpCmd
2768                     	xdef	_UART2_WakeUpConfig
2769                     	xdef	_UART2_SmartCardNACKCmd
2770                     	xdef	_UART2_SmartCardCmd
2771                     	xdef	_UART2_LINCmd
2772                     	xdef	_UART2_LINConfig
2773                     	xdef	_UART2_LINBreakDetectionConfig
2774                     	xdef	_UART2_IrDACmd
2775                     	xdef	_UART2_IrDAConfig
2776                     	xdef	_UART2_ITConfig
2777                     	xdef	_UART2_Cmd
2778                     	xdef	_UART2_Init
2779                     	xdef	_UART2_DeInit
2780                     	xref	_CLK_GetClockFreq
2781                     	xref.b	c_lreg
2782                     	xref.b	c_x
2801                     	xref	c_lursh
2802                     	xref	c_lsub
2803                     	xref	c_smul
2804                     	xref	c_ludv
2805                     	xref	c_rtol
2806                     	xref	c_llsh
2807                     	xref	c_ltor
2808                     	end
