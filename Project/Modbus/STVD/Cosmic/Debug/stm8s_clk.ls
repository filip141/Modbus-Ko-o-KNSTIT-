   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
   4                     ; Optimizer V4.3.6 - 29 Nov 2011
  19                     .const:	section	.text
  20  0000               _HSIDivFactor:
  21  0000 01            	dc.b	1
  22  0001 02            	dc.b	2
  23  0002 04            	dc.b	4
  24  0003 08            	dc.b	8
  25  0004               _CLKPrescTable:
  26  0004 01            	dc.b	1
  27  0005 02            	dc.b	2
  28  0006 04            	dc.b	4
  29  0007 08            	dc.b	8
  30  0008 0a            	dc.b	10
  31  0009 10            	dc.b	16
  32  000a 14            	dc.b	20
  33  000b 28            	dc.b	40
  62                     ; 66 void CLK_DeInit(void)
  62                     ; 67 {
  64                     	switch	.text
  65  0000               _CLK_DeInit:
  69                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  71  0000 350150c0      	mov	20672,#1
  72                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  74  0004 725f50c1      	clr	20673
  75                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  77  0008 35e150c4      	mov	20676,#225
  78                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  80  000c 725f50c5      	clr	20677
  81                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  83  0010 351850c6      	mov	20678,#24
  84                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  86  0014 35ff50c7      	mov	20679,#255
  87                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  89  0018 35ff50ca      	mov	20682,#255
  90                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  92  001c 725f50c8      	clr	20680
  93                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  95  0020 725f50c9      	clr	20681
  97  0024               L52:
  98                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
 100  0024 720050c9fb    	btjt	20681,#0,L52
 101                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 103  0029 725f50c9      	clr	20681
 104                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 106  002d 725f50cc      	clr	20684
 107                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 109  0031 725f50cd      	clr	20685
 110                     ; 84 }
 113  0035 81            	ret	
 169                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 169                     ; 96 {
 170                     	switch	.text
 171  0036               _CLK_FastHaltWakeUpCmd:
 175                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 177                     ; 101     if (NewState != DISABLE)
 179  0036 4d            	tnz	a
 180  0037 2705          	jreq	L75
 181                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 183  0039 721450c0      	bset	20672,#2
 186  003d 81            	ret	
 187  003e               L75:
 188                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 190  003e 721550c0      	bres	20672,#2
 191                     ; 112 }
 194  0042 81            	ret	
 229                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 229                     ; 120 {
 230                     	switch	.text
 231  0043               _CLK_HSECmd:
 235                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 237                     ; 125     if (NewState != DISABLE)
 239  0043 4d            	tnz	a
 240  0044 2705          	jreq	L101
 241                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 243  0046 721050c1      	bset	20673,#0
 246  004a 81            	ret	
 247  004b               L101:
 248                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 250  004b 721150c1      	bres	20673,#0
 251                     ; 136 }
 254  004f 81            	ret	
 289                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 289                     ; 144 {
 290                     	switch	.text
 291  0050               _CLK_HSICmd:
 295                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 297                     ; 149     if (NewState != DISABLE)
 299  0050 4d            	tnz	a
 300  0051 2705          	jreq	L321
 301                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 303  0053 721050c0      	bset	20672,#0
 306  0057 81            	ret	
 307  0058               L321:
 308                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 310  0058 721150c0      	bres	20672,#0
 311                     ; 160 }
 314  005c 81            	ret	
 349                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 349                     ; 168 {
 350                     	switch	.text
 351  005d               _CLK_LSICmd:
 355                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 357                     ; 173     if (NewState != DISABLE)
 359  005d 4d            	tnz	a
 360  005e 2705          	jreq	L541
 361                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 363  0060 721650c0      	bset	20672,#3
 366  0064 81            	ret	
 367  0065               L541:
 368                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 370  0065 721750c0      	bres	20672,#3
 371                     ; 184 }
 374  0069 81            	ret	
 409                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 409                     ; 193 {
 410                     	switch	.text
 411  006a               _CLK_CCOCmd:
 415                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 417                     ; 198     if (NewState != DISABLE)
 419  006a 4d            	tnz	a
 420  006b 2705          	jreq	L761
 421                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 423  006d 721050c9      	bset	20681,#0
 426  0071 81            	ret	
 427  0072               L761:
 428                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 430  0072 721150c9      	bres	20681,#0
 431                     ; 209 }
 434  0076 81            	ret	
 469                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 469                     ; 219 {
 470                     	switch	.text
 471  0077               _CLK_ClockSwitchCmd:
 475                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 477                     ; 224     if (NewState != DISABLE )
 479  0077 4d            	tnz	a
 480  0078 2705          	jreq	L112
 481                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 483  007a 721250c5      	bset	20677,#1
 486  007e 81            	ret	
 487  007f               L112:
 488                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 490  007f 721350c5      	bres	20677,#1
 491                     ; 235 }
 494  0083 81            	ret	
 530                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 530                     ; 246 {
 531                     	switch	.text
 532  0084               _CLK_SlowActiveHaltWakeUpCmd:
 536                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 538                     ; 251     if (NewState != DISABLE)
 540  0084 4d            	tnz	a
 541  0085 2705          	jreq	L332
 542                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 544  0087 721a50c0      	bset	20672,#5
 547  008b 81            	ret	
 548  008c               L332:
 549                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 551  008c 721b50c0      	bres	20672,#5
 552                     ; 262 }
 555  0090 81            	ret	
 714                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 714                     ; 273 {
 715                     	switch	.text
 716  0091               _CLK_PeripheralClockConfig:
 718  0091 89            	pushw	x
 719       00000000      OFST:	set	0
 722                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 724                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 726                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 728  0092 9e            	ld	a,xh
 729  0093 a510          	bcp	a,#16
 730  0095 2626          	jrne	L123
 731                     ; 281         if (NewState != DISABLE)
 733  0097 7b02          	ld	a,(OFST+2,sp)
 734  0099 270f          	jreq	L323
 735                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 737  009b 7b01          	ld	a,(OFST+1,sp)
 738  009d ad44          	call	LC003
 739  009f 2704          	jreq	L62
 740  00a1               L03:
 741  00a1 48            	sll	a
 742  00a2 5a            	decw	x
 743  00a3 26fc          	jrne	L03
 744  00a5               L62:
 745  00a5 ca50c7        	or	a,20679
 747  00a8 200e          	jp	LC002
 748  00aa               L323:
 749                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 751  00aa 7b01          	ld	a,(OFST+1,sp)
 752  00ac ad35          	call	LC003
 753  00ae 2704          	jreq	L23
 754  00b0               L43:
 755  00b0 48            	sll	a
 756  00b1 5a            	decw	x
 757  00b2 26fc          	jrne	L43
 758  00b4               L23:
 759  00b4 43            	cpl	a
 760  00b5 c450c7        	and	a,20679
 761  00b8               LC002:
 762  00b8 c750c7        	ld	20679,a
 763  00bb 2024          	jra	L723
 764  00bd               L123:
 765                     ; 294         if (NewState != DISABLE)
 767  00bd 7b02          	ld	a,(OFST+2,sp)
 768  00bf 270f          	jreq	L133
 769                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 771  00c1 7b01          	ld	a,(OFST+1,sp)
 772  00c3 ad1e          	call	LC003
 773  00c5 2704          	jreq	L63
 774  00c7               L04:
 775  00c7 48            	sll	a
 776  00c8 5a            	decw	x
 777  00c9 26fc          	jrne	L04
 778  00cb               L63:
 779  00cb ca50ca        	or	a,20682
 781  00ce 200e          	jp	LC001
 782  00d0               L133:
 783                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 785  00d0 7b01          	ld	a,(OFST+1,sp)
 786  00d2 ad0f          	call	LC003
 787  00d4 2704          	jreq	L24
 788  00d6               L44:
 789  00d6 48            	sll	a
 790  00d7 5a            	decw	x
 791  00d8 26fc          	jrne	L44
 792  00da               L24:
 793  00da 43            	cpl	a
 794  00db c450ca        	and	a,20682
 795  00de               LC001:
 796  00de c750ca        	ld	20682,a
 797  00e1               L723:
 798                     ; 306 }
 801  00e1 85            	popw	x
 802  00e2 81            	ret	
 803  00e3               LC003:
 804  00e3 a40f          	and	a,#15
 805  00e5 5f            	clrw	x
 806  00e6 97            	ld	xl,a
 807  00e7 a601          	ld	a,#1
 808  00e9 5d            	tnzw	x
 809  00ea 81            	ret	
 997                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
 997                     ; 320 {
 998                     	switch	.text
 999  00eb               _CLK_ClockSwitchConfig:
1001  00eb 89            	pushw	x
1002  00ec 5204          	subw	sp,#4
1003       00000004      OFST:	set	4
1006                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1008  00ee ae0491        	ldw	x,#1169
1009  00f1 1f03          	ldw	(OFST-1,sp),x
1010                     ; 324     ErrorStatus Swif = ERROR;
1012                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1014                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1016                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1018                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1020                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1022  00f3 c650c3        	ld	a,20675
1023  00f6 6b01          	ld	(OFST-3,sp),a
1024                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1026  00f8 7b05          	ld	a,(OFST+1,sp)
1027  00fa 4a            	dec	a
1028  00fb 262d          	jrne	L544
1029                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1031  00fd 721250c5      	bset	20677,#1
1032                     ; 343         if (ITState != DISABLE)
1034  0101 7b09          	ld	a,(OFST+5,sp)
1035  0103 2706          	jreq	L744
1036                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1038  0105 721450c5      	bset	20677,#2
1040  0109 2004          	jra	L154
1041  010b               L744:
1042                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1044  010b 721550c5      	bres	20677,#2
1045  010f               L154:
1046                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1048  010f 7b06          	ld	a,(OFST+2,sp)
1049  0111 c750c4        	ld	20676,a
1051  0114 2003          	jra	L754
1052  0116               L354:
1053                     ; 357             DownCounter--;
1055  0116 5a            	decw	x
1056  0117 1f03          	ldw	(OFST-1,sp),x
1057  0119               L754:
1058                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1060  0119 720150c504    	btjf	20677,#0,L364
1062  011e 1e03          	ldw	x,(OFST-1,sp)
1063  0120 26f4          	jrne	L354
1064  0122               L364:
1065                     ; 360         if (DownCounter != 0)
1067  0122 1e03          	ldw	x,(OFST-1,sp)
1068                     ; 362             Swif = SUCCESS;
1070  0124 2617          	jrne	LC004
1071                     ; 366             Swif = ERROR;
1073  0126 0f02          	clr	(OFST-2,sp)
1074  0128 2017          	jra	L174
1075  012a               L544:
1076                     ; 374         if (ITState != DISABLE)
1078  012a 7b09          	ld	a,(OFST+5,sp)
1079  012c 2706          	jreq	L374
1080                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1082  012e 721450c5      	bset	20677,#2
1084  0132 2004          	jra	L574
1085  0134               L374:
1086                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1088  0134 721550c5      	bres	20677,#2
1089  0138               L574:
1090                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1092  0138 7b06          	ld	a,(OFST+2,sp)
1093  013a c750c4        	ld	20676,a
1094                     ; 388         Swif = SUCCESS;
1096  013d               LC004:
1098  013d a601          	ld	a,#1
1099  013f 6b02          	ld	(OFST-2,sp),a
1100  0141               L174:
1101                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1103  0141 7b0a          	ld	a,(OFST+6,sp)
1104  0143 260c          	jrne	L774
1106  0145 7b01          	ld	a,(OFST-3,sp)
1107  0147 a1e1          	cp	a,#225
1108  0149 2606          	jrne	L774
1109                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1111  014b 721150c0      	bres	20672,#0
1113  014f 201e          	jra	L105
1114  0151               L774:
1115                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1117  0151 7b0a          	ld	a,(OFST+6,sp)
1118  0153 260c          	jrne	L305
1120  0155 7b01          	ld	a,(OFST-3,sp)
1121  0157 a1d2          	cp	a,#210
1122  0159 2606          	jrne	L305
1123                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1125  015b 721750c0      	bres	20672,#3
1127  015f 200e          	jra	L105
1128  0161               L305:
1129                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1131  0161 7b0a          	ld	a,(OFST+6,sp)
1132  0163 260a          	jrne	L105
1134  0165 7b01          	ld	a,(OFST-3,sp)
1135  0167 a1b4          	cp	a,#180
1136  0169 2604          	jrne	L105
1137                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1139  016b 721150c1      	bres	20673,#0
1140  016f               L105:
1141                     ; 406     return(Swif);
1143  016f 7b02          	ld	a,(OFST-2,sp)
1146  0171 5b06          	addw	sp,#6
1147  0173 81            	ret	
1285                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1285                     ; 417 {
1286                     	switch	.text
1287  0174               _CLK_HSIPrescalerConfig:
1289  0174 88            	push	a
1290       00000000      OFST:	set	0
1293                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1295                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1297  0175 c650c6        	ld	a,20678
1298  0178 a4e7          	and	a,#231
1299  017a c750c6        	ld	20678,a
1300                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1302  017d c650c6        	ld	a,20678
1303  0180 1a01          	or	a,(OFST+1,sp)
1304  0182 c750c6        	ld	20678,a
1305                     ; 428 }
1308  0185 84            	pop	a
1309  0186 81            	ret	
1444                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1444                     ; 440 {
1445                     	switch	.text
1446  0187               _CLK_CCOConfig:
1448  0187 88            	push	a
1449       00000000      OFST:	set	0
1452                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1454                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1456  0188 c650c9        	ld	a,20681
1457  018b a4e1          	and	a,#225
1458  018d c750c9        	ld	20681,a
1459                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1461  0190 c650c9        	ld	a,20681
1462  0193 1a01          	or	a,(OFST+1,sp)
1463  0195 c750c9        	ld	20681,a
1464                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1466                     ; 454 }
1469  0198 84            	pop	a
1470  0199 721050c9      	bset	20681,#0
1471  019d 81            	ret	
1536                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1536                     ; 465 {
1537                     	switch	.text
1538  019e               _CLK_ITConfig:
1540  019e 89            	pushw	x
1541       00000000      OFST:	set	0
1544                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1546                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1548                     ; 471     if (NewState != DISABLE)
1550  019f 9f            	ld	a,xl
1551  01a0 4d            	tnz	a
1552  01a1 2715          	jreq	L507
1553                     ; 473         switch (CLK_IT)
1555  01a3 9e            	ld	a,xh
1557                     ; 481         default:
1557                     ; 482             break;
1558  01a4 a00c          	sub	a,#12
1559  01a6 270a          	jreq	L146
1560  01a8 a010          	sub	a,#16
1561  01aa 2620          	jrne	L317
1562                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1562                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1564  01ac 721450c5      	bset	20677,#2
1565                     ; 477             break;
1567  01b0 201a          	jra	L317
1568  01b2               L146:
1569                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1569                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1571  01b2 721450c8      	bset	20680,#2
1572                     ; 480             break;
1574  01b6 2014          	jra	L317
1575                     ; 481         default:
1575                     ; 482             break;
1578  01b8               L507:
1579                     ; 487         switch (CLK_IT)
1581  01b8 7b01          	ld	a,(OFST+1,sp)
1583                     ; 495         default:
1583                     ; 496             break;
1584  01ba a00c          	sub	a,#12
1585  01bc 270a          	jreq	L746
1586  01be a010          	sub	a,#16
1587  01c0 260a          	jrne	L317
1588                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1588                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
1590  01c2 721550c5      	bres	20677,#2
1591                     ; 491             break;
1593  01c6 2004          	jra	L317
1594  01c8               L746:
1595                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1595                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
1597  01c8 721550c8      	bres	20680,#2
1598                     ; 494             break;
1599  01cc               L317:
1600                     ; 500 }
1603  01cc 85            	popw	x
1604  01cd 81            	ret	
1605                     ; 495         default:
1605                     ; 496             break;
1641                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
1641                     ; 508 {
1642                     	switch	.text
1643  01ce               _CLK_SYSCLKConfig:
1645  01ce 88            	push	a
1646       00000000      OFST:	set	0
1649                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
1651                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
1653  01cf a580          	bcp	a,#128
1654  01d1 260e          	jrne	L737
1655                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1657  01d3 c650c6        	ld	a,20678
1658  01d6 a4e7          	and	a,#231
1659  01d8 c750c6        	ld	20678,a
1660                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
1662  01db 7b01          	ld	a,(OFST+1,sp)
1663  01dd a418          	and	a,#24
1665  01df 200c          	jra	L147
1666  01e1               L737:
1667                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
1669  01e1 c650c6        	ld	a,20678
1670  01e4 a4f8          	and	a,#248
1671  01e6 c750c6        	ld	20678,a
1672                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
1674  01e9 7b01          	ld	a,(OFST+1,sp)
1675  01eb a407          	and	a,#7
1676  01ed               L147:
1677  01ed ca50c6        	or	a,20678
1678  01f0 c750c6        	ld	20678,a
1679                     ; 524 }
1682  01f3 84            	pop	a
1683  01f4 81            	ret	
1739                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
1739                     ; 532 {
1740                     	switch	.text
1741  01f5               _CLK_SWIMConfig:
1745                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
1747                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
1749  01f5 4d            	tnz	a
1750  01f6 2705          	jreq	L177
1751                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
1753  01f8 721050cd      	bset	20685,#0
1756  01fc 81            	ret	
1757  01fd               L177:
1758                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
1760  01fd 721150cd      	bres	20685,#0
1761                     ; 548 }
1764  0201 81            	ret	
1788                     ; 557 void CLK_ClockSecuritySystemEnable(void)
1788                     ; 558 {
1789                     	switch	.text
1790  0202               _CLK_ClockSecuritySystemEnable:
1794                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
1796  0202 721050c8      	bset	20680,#0
1797                     ; 561 }
1800  0206 81            	ret	
1825                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
1825                     ; 570 {
1826                     	switch	.text
1827  0207               _CLK_GetSYSCLKSource:
1831                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
1833  0207 c650c3        	ld	a,20675
1836  020a 81            	ret	
1899                     ; 579 uint32_t CLK_GetClockFreq(void)
1899                     ; 580 {
1900                     	switch	.text
1901  020b               _CLK_GetClockFreq:
1903  020b 5209          	subw	sp,#9
1904       00000009      OFST:	set	9
1907                     ; 582     uint32_t clockfrequency = 0;
1909                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
1911                     ; 584     uint8_t tmp = 0, presc = 0;
1915                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
1917  020d c650c3        	ld	a,20675
1918  0210 6b09          	ld	(OFST+0,sp),a
1919                     ; 589     if (clocksource == CLK_SOURCE_HSI)
1921  0212 a1e1          	cp	a,#225
1922  0214 2634          	jrne	L7401
1923                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
1925  0216 c650c6        	ld	a,20678
1926  0219 a418          	and	a,#24
1927  021b 44            	srl	a
1928  021c 44            	srl	a
1929  021d 44            	srl	a
1930                     ; 592         tmp = (uint8_t)(tmp >> 3);
1932                     ; 593         presc = HSIDivFactor[tmp];
1934  021e 5f            	clrw	x
1935  021f 97            	ld	xl,a
1936  0220 d60000        	ld	a,(_HSIDivFactor,x)
1937  0223 6b09          	ld	(OFST+0,sp),a
1938                     ; 594         clockfrequency = HSI_VALUE / presc;
1940  0225 b703          	ld	c_lreg+3,a
1941  0227 3f02          	clr	c_lreg+2
1942  0229 3f01          	clr	c_lreg+1
1943  022b 3f00          	clr	c_lreg
1944  022d 96            	ldw	x,sp
1945  022e 5c            	incw	x
1946  022f cd0000        	call	c_rtol
1948  0232 ae2400        	ldw	x,#9216
1949  0235 bf02          	ldw	c_lreg+2,x
1950  0237 ae00f4        	ldw	x,#244
1951  023a bf00          	ldw	c_lreg,x
1952  023c 96            	ldw	x,sp
1953  023d 5c            	incw	x
1954  023e cd0000        	call	c_ludv
1956  0241 96            	ldw	x,sp
1957  0242 1c0005        	addw	x,#OFST-4
1958  0245 cd0000        	call	c_rtol
1961  0248 2018          	jra	L1501
1962  024a               L7401:
1963                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
1965  024a a1d2          	cp	a,#210
1966  024c 260a          	jrne	L3501
1967                     ; 598         clockfrequency = LSI_VALUE;
1969  024e aef400        	ldw	x,#62464
1970  0251 1f07          	ldw	(OFST-2,sp),x
1971  0253 ae0001        	ldw	x,#1
1973  0256 2008          	jp	LC005
1974  0258               L3501:
1975                     ; 602         clockfrequency = HSE_VALUE;
1977  0258 ae2400        	ldw	x,#9216
1978  025b 1f07          	ldw	(OFST-2,sp),x
1979  025d ae00f4        	ldw	x,#244
1980  0260               LC005:
1981  0260 1f05          	ldw	(OFST-4,sp),x
1982  0262               L1501:
1983                     ; 605     return((uint32_t)clockfrequency);
1985  0262 96            	ldw	x,sp
1986  0263 1c0005        	addw	x,#OFST-4
1987  0266 cd0000        	call	c_ltor
1991  0269 5b09          	addw	sp,#9
1992  026b 81            	ret	
2091                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2091                     ; 617 {
2092                     	switch	.text
2093  026c               _CLK_AdjustHSICalibrationValue:
2095  026c 88            	push	a
2096       00000000      OFST:	set	0
2099                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2101                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2103  026d c650cc        	ld	a,20684
2104  0270 a4f8          	and	a,#248
2105  0272 1a01          	or	a,(OFST+1,sp)
2106  0274 c750cc        	ld	20684,a
2107                     ; 625 }
2110  0277 84            	pop	a
2111  0278 81            	ret	
2135                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2135                     ; 637 {
2136                     	switch	.text
2137  0279               _CLK_SYSCLKEmergencyClear:
2141                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2143  0279 721150c5      	bres	20677,#0
2144                     ; 639 }
2147  027d 81            	ret	
2300                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2300                     ; 649 {
2301                     	switch	.text
2302  027e               _CLK_GetFlagStatus:
2304  027e 89            	pushw	x
2305  027f 5203          	subw	sp,#3
2306       00000003      OFST:	set	3
2309                     ; 651     uint16_t statusreg = 0;
2311                     ; 652     uint8_t tmpreg = 0;
2313                     ; 653     FlagStatus bitstatus = RESET;
2315                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2317                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2319  0281 01            	rrwa	x,a
2320  0282 4f            	clr	a
2321  0283 02            	rlwa	x,a
2322  0284 1f01          	ldw	(OFST-2,sp),x
2323                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2325  0286 a30100        	cpw	x,#256
2326  0289 2605          	jrne	L1221
2327                     ; 664         tmpreg = CLK->ICKR;
2329  028b c650c0        	ld	a,20672
2331  028e 2021          	jra	L3221
2332  0290               L1221:
2333                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2335  0290 a30200        	cpw	x,#512
2336  0293 2605          	jrne	L5221
2337                     ; 668         tmpreg = CLK->ECKR;
2339  0295 c650c1        	ld	a,20673
2341  0298 2017          	jra	L3221
2342  029a               L5221:
2343                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2345  029a a30300        	cpw	x,#768
2346  029d 2605          	jrne	L1321
2347                     ; 672         tmpreg = CLK->SWCR;
2349  029f c650c5        	ld	a,20677
2351  02a2 200d          	jra	L3221
2352  02a4               L1321:
2353                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2355  02a4 a30400        	cpw	x,#1024
2356  02a7 2605          	jrne	L5321
2357                     ; 676         tmpreg = CLK->CSSR;
2359  02a9 c650c8        	ld	a,20680
2361  02ac 2003          	jra	L3221
2362  02ae               L5321:
2363                     ; 680         tmpreg = CLK->CCOR;
2365  02ae c650c9        	ld	a,20681
2366  02b1               L3221:
2367  02b1 6b03          	ld	(OFST+0,sp),a
2368                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2370  02b3 7b05          	ld	a,(OFST+2,sp)
2371  02b5 1503          	bcp	a,(OFST+0,sp)
2372  02b7 2704          	jreq	L1421
2373                     ; 685         bitstatus = SET;
2375  02b9 a601          	ld	a,#1
2377  02bb 2001          	jra	L3421
2378  02bd               L1421:
2379                     ; 689         bitstatus = RESET;
2381  02bd 4f            	clr	a
2382  02be               L3421:
2383                     ; 693     return((FlagStatus)bitstatus);
2387  02be 5b05          	addw	sp,#5
2388  02c0 81            	ret	
2434                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2434                     ; 704 {
2435                     	switch	.text
2436  02c1               _CLK_GetITStatus:
2438  02c1 88            	push	a
2439  02c2 88            	push	a
2440       00000001      OFST:	set	1
2443                     ; 706     ITStatus bitstatus = RESET;
2445                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
2447                     ; 711     if (CLK_IT == CLK_IT_SWIF)
2449  02c3 a11c          	cp	a,#28
2450  02c5 2609          	jrne	L7621
2451                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2453  02c7 c450c5        	and	a,20677
2454  02ca a10c          	cp	a,#12
2455  02cc 260f          	jrne	L7721
2456                     ; 716             bitstatus = SET;
2458  02ce 2009          	jp	LC007
2459                     ; 720             bitstatus = RESET;
2460  02d0               L7621:
2461                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2463  02d0 c650c8        	ld	a,20680
2464  02d3 1402          	and	a,(OFST+1,sp)
2465  02d5 a10c          	cp	a,#12
2466  02d7 2604          	jrne	L7721
2467                     ; 728             bitstatus = SET;
2469  02d9               LC007:
2471  02d9 a601          	ld	a,#1
2473  02db 2001          	jra	L5721
2474  02dd               L7721:
2475                     ; 732             bitstatus = RESET;
2478  02dd 4f            	clr	a
2479  02de               L5721:
2480                     ; 737     return bitstatus;
2484  02de 85            	popw	x
2485  02df 81            	ret	
2521                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2521                     ; 748 {
2522                     	switch	.text
2523  02e0               _CLK_ClearITPendingBit:
2527                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
2529                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
2531  02e0 a10c          	cp	a,#12
2532  02e2 2605          	jrne	L1231
2533                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
2535  02e4 721750c8      	bres	20680,#3
2538  02e8 81            	ret	
2539  02e9               L1231:
2540                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2542  02e9 721750c5      	bres	20677,#3
2543                     ; 764 }
2546  02ed 81            	ret	
2581                     	xdef	_CLKPrescTable
2582                     	xdef	_HSIDivFactor
2583                     	xdef	_CLK_ClearITPendingBit
2584                     	xdef	_CLK_GetITStatus
2585                     	xdef	_CLK_GetFlagStatus
2586                     	xdef	_CLK_GetSYSCLKSource
2587                     	xdef	_CLK_GetClockFreq
2588                     	xdef	_CLK_AdjustHSICalibrationValue
2589                     	xdef	_CLK_SYSCLKEmergencyClear
2590                     	xdef	_CLK_ClockSecuritySystemEnable
2591                     	xdef	_CLK_SWIMConfig
2592                     	xdef	_CLK_SYSCLKConfig
2593                     	xdef	_CLK_ITConfig
2594                     	xdef	_CLK_CCOConfig
2595                     	xdef	_CLK_HSIPrescalerConfig
2596                     	xdef	_CLK_ClockSwitchConfig
2597                     	xdef	_CLK_PeripheralClockConfig
2598                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
2599                     	xdef	_CLK_FastHaltWakeUpCmd
2600                     	xdef	_CLK_ClockSwitchCmd
2601                     	xdef	_CLK_CCOCmd
2602                     	xdef	_CLK_LSICmd
2603                     	xdef	_CLK_HSICmd
2604                     	xdef	_CLK_HSECmd
2605                     	xdef	_CLK_DeInit
2606                     	xref.b	c_lreg
2607                     	xref.b	c_x
2626                     	xref	c_ltor
2627                     	xref	c_ludv
2628                     	xref	c_rtol
2629                     	end
