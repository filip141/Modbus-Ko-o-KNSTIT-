   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
   4                     ; Optimizer V4.3.6 - 29 Nov 2011
  47                     ; 45 void TIM3_DeInit(void)
  47                     ; 46 {
  49                     	switch	.text
  50  0000               _TIM3_DeInit:
  54                     ; 48     TIM3->CR1 = (uint8_t)TIM3_CR1_RESET_VALUE;
  56  0000 725f5320      	clr	21280
  57                     ; 49     TIM3->IER = (uint8_t)TIM3_IER_RESET_VALUE;
  59  0004 725f5321      	clr	21281
  60                     ; 50     TIM3->SR2 = (uint8_t)TIM3_SR2_RESET_VALUE;
  62  0008 725f5323      	clr	21283
  63                     ; 53     TIM3->CCER1 = (uint8_t)TIM3_CCER1_RESET_VALUE;
  65  000c 725f5327      	clr	21287
  66                     ; 56     TIM3->CCER1 = (uint8_t)TIM3_CCER1_RESET_VALUE;
  68  0010 725f5327      	clr	21287
  69                     ; 57     TIM3->CCMR1 = (uint8_t)TIM3_CCMR1_RESET_VALUE;
  71  0014 725f5325      	clr	21285
  72                     ; 58     TIM3->CCMR2 = (uint8_t)TIM3_CCMR2_RESET_VALUE;
  74  0018 725f5326      	clr	21286
  75                     ; 59     TIM3->CNTRH = (uint8_t)TIM3_CNTRH_RESET_VALUE;
  77  001c 725f5328      	clr	21288
  78                     ; 60     TIM3->CNTRL = (uint8_t)TIM3_CNTRL_RESET_VALUE;
  80  0020 725f5329      	clr	21289
  81                     ; 61     TIM3->PSCR = (uint8_t)TIM3_PSCR_RESET_VALUE;
  83  0024 725f532a      	clr	21290
  84                     ; 62     TIM3->ARRH  = (uint8_t)TIM3_ARRH_RESET_VALUE;
  86  0028 35ff532b      	mov	21291,#255
  87                     ; 63     TIM3->ARRL  = (uint8_t)TIM3_ARRL_RESET_VALUE;
  89  002c 35ff532c      	mov	21292,#255
  90                     ; 64     TIM3->CCR1H = (uint8_t)TIM3_CCR1H_RESET_VALUE;
  92  0030 725f532d      	clr	21293
  93                     ; 65     TIM3->CCR1L = (uint8_t)TIM3_CCR1L_RESET_VALUE;
  95  0034 725f532e      	clr	21294
  96                     ; 66     TIM3->CCR2H = (uint8_t)TIM3_CCR2H_RESET_VALUE;
  98  0038 725f532f      	clr	21295
  99                     ; 67     TIM3->CCR2L = (uint8_t)TIM3_CCR2L_RESET_VALUE;
 101  003c 725f5330      	clr	21296
 102                     ; 68     TIM3->SR1 = (uint8_t)TIM3_SR1_RESET_VALUE;
 104  0040 725f5322      	clr	21282
 105                     ; 69 }
 108  0044 81            	ret	
 276                     ; 78 void TIM3_TimeBaseInit( TIM3_Prescaler_TypeDef TIM3_Prescaler,
 276                     ; 79                         uint16_t TIM3_Period)
 276                     ; 80 {
 277                     	switch	.text
 278  0045               _TIM3_TimeBaseInit:
 280       00000000      OFST:	set	0
 283                     ; 82     TIM3->PSCR = (uint8_t)(TIM3_Prescaler);
 285  0045 c7532a        	ld	21290,a
 286  0048 88            	push	a
 287                     ; 84     TIM3->ARRH = (uint8_t)(TIM3_Period >> 8);
 289  0049 7b04          	ld	a,(OFST+4,sp)
 290  004b c7532b        	ld	21291,a
 291                     ; 85     TIM3->ARRL = (uint8_t)(TIM3_Period);
 293  004e 7b05          	ld	a,(OFST+5,sp)
 294  0050 c7532c        	ld	21292,a
 295                     ; 86 }
 298  0053 84            	pop	a
 299  0054 81            	ret	
 456                     ; 96 void TIM3_OC1Init(TIM3_OCMode_TypeDef TIM3_OCMode,
 456                     ; 97                   TIM3_OutputState_TypeDef TIM3_OutputState,
 456                     ; 98                   uint16_t TIM3_Pulse,
 456                     ; 99                   TIM3_OCPolarity_TypeDef TIM3_OCPolarity)
 456                     ; 100 {
 457                     	switch	.text
 458  0055               _TIM3_OC1Init:
 460  0055 89            	pushw	x
 461  0056 88            	push	a
 462       00000001      OFST:	set	1
 465                     ; 102     assert_param(IS_TIM3_OC_MODE_OK(TIM3_OCMode));
 467                     ; 103     assert_param(IS_TIM3_OUTPUT_STATE_OK(TIM3_OutputState));
 469                     ; 104     assert_param(IS_TIM3_OC_POLARITY_OK(TIM3_OCPolarity));
 471                     ; 107     TIM3->CCER1 &= (uint8_t)(~( TIM3_CCER1_CC1E | TIM3_CCER1_CC1P));
 473  0057 c65327        	ld	a,21287
 474  005a a4fc          	and	a,#252
 475  005c c75327        	ld	21287,a
 476                     ; 109     TIM3->CCER1 |= (uint8_t)((uint8_t)(TIM3_OutputState  & TIM3_CCER1_CC1E   ) | (uint8_t)(TIM3_OCPolarity   & TIM3_CCER1_CC1P   ));
 478  005f 7b08          	ld	a,(OFST+7,sp)
 479  0061 a402          	and	a,#2
 480  0063 6b01          	ld	(OFST+0,sp),a
 481  0065 9f            	ld	a,xl
 482  0066 a401          	and	a,#1
 483  0068 1a01          	or	a,(OFST+0,sp)
 484  006a ca5327        	or	a,21287
 485  006d c75327        	ld	21287,a
 486                     ; 112     TIM3->CCMR1 = (uint8_t)((uint8_t)(TIM3->CCMR1 & (uint8_t)(~TIM3_CCMR_OCM)) | (uint8_t)TIM3_OCMode);
 488  0070 c65325        	ld	a,21285
 489  0073 a48f          	and	a,#143
 490  0075 1a02          	or	a,(OFST+1,sp)
 491  0077 c75325        	ld	21285,a
 492                     ; 115     TIM3->CCR1H = (uint8_t)(TIM3_Pulse >> 8);
 494  007a 7b06          	ld	a,(OFST+5,sp)
 495  007c c7532d        	ld	21293,a
 496                     ; 116     TIM3->CCR1L = (uint8_t)(TIM3_Pulse);
 498  007f 7b07          	ld	a,(OFST+6,sp)
 499  0081 c7532e        	ld	21294,a
 500                     ; 117 }
 503  0084 5b03          	addw	sp,#3
 504  0086 81            	ret	
 568                     ; 128 void TIM3_OC2Init(TIM3_OCMode_TypeDef TIM3_OCMode,
 568                     ; 129                   TIM3_OutputState_TypeDef TIM3_OutputState,
 568                     ; 130                   uint16_t TIM3_Pulse,
 568                     ; 131                   TIM3_OCPolarity_TypeDef TIM3_OCPolarity)
 568                     ; 132 {
 569                     	switch	.text
 570  0087               _TIM3_OC2Init:
 572  0087 89            	pushw	x
 573  0088 88            	push	a
 574       00000001      OFST:	set	1
 577                     ; 134     assert_param(IS_TIM3_OC_MODE_OK(TIM3_OCMode));
 579                     ; 135     assert_param(IS_TIM3_OUTPUT_STATE_OK(TIM3_OutputState));
 581                     ; 136     assert_param(IS_TIM3_OC_POLARITY_OK(TIM3_OCPolarity));
 583                     ; 140     TIM3->CCER1 &= (uint8_t)(~( TIM3_CCER1_CC2E |  TIM3_CCER1_CC2P ));
 585  0089 c65327        	ld	a,21287
 586  008c a4cf          	and	a,#207
 587  008e c75327        	ld	21287,a
 588                     ; 142     TIM3->CCER1 |= (uint8_t)((uint8_t)(TIM3_OutputState  & TIM3_CCER1_CC2E   ) | (uint8_t)(TIM3_OCPolarity   & TIM3_CCER1_CC2P ));
 590  0091 7b08          	ld	a,(OFST+7,sp)
 591  0093 a420          	and	a,#32
 592  0095 6b01          	ld	(OFST+0,sp),a
 593  0097 9f            	ld	a,xl
 594  0098 a410          	and	a,#16
 595  009a 1a01          	or	a,(OFST+0,sp)
 596  009c ca5327        	or	a,21287
 597  009f c75327        	ld	21287,a
 598                     ; 146     TIM3->CCMR2 = (uint8_t)((uint8_t)(TIM3->CCMR2 & (uint8_t)(~TIM3_CCMR_OCM)) | (uint8_t)TIM3_OCMode);
 600  00a2 c65326        	ld	a,21286
 601  00a5 a48f          	and	a,#143
 602  00a7 1a02          	or	a,(OFST+1,sp)
 603  00a9 c75326        	ld	21286,a
 604                     ; 150     TIM3->CCR2H = (uint8_t)(TIM3_Pulse >> 8);
 606  00ac 7b06          	ld	a,(OFST+5,sp)
 607  00ae c7532f        	ld	21295,a
 608                     ; 151     TIM3->CCR2L = (uint8_t)(TIM3_Pulse);
 610  00b1 7b07          	ld	a,(OFST+6,sp)
 611  00b3 c75330        	ld	21296,a
 612                     ; 152 }
 615  00b6 5b03          	addw	sp,#3
 616  00b8 81            	ret	
 800                     ; 163 void TIM3_ICInit(TIM3_Channel_TypeDef TIM3_Channel,
 800                     ; 164                  TIM3_ICPolarity_TypeDef TIM3_ICPolarity,
 800                     ; 165                  TIM3_ICSelection_TypeDef TIM3_ICSelection,
 800                     ; 166                  TIM3_ICPSC_TypeDef TIM3_ICPrescaler,
 800                     ; 167                  uint8_t TIM3_ICFilter)
 800                     ; 168 {
 801                     	switch	.text
 802  00b9               _TIM3_ICInit:
 804  00b9 89            	pushw	x
 805       00000000      OFST:	set	0
 808                     ; 170     assert_param(IS_TIM3_CHANNEL_OK(TIM3_Channel));
 810                     ; 171     assert_param(IS_TIM3_IC_POLARITY_OK(TIM3_ICPolarity));
 812                     ; 172     assert_param(IS_TIM3_IC_SELECTION_OK(TIM3_ICSelection));
 814                     ; 173     assert_param(IS_TIM3_IC_PRESCALER_OK(TIM3_ICPrescaler));
 816                     ; 174     assert_param(IS_TIM3_IC_FILTER_OK(TIM3_ICFilter));
 818                     ; 176     if (TIM3_Channel != TIM3_CHANNEL_2)
 820  00ba 9e            	ld	a,xh
 821  00bb 4a            	dec	a
 822  00bc 2714          	jreq	L343
 823                     ; 179         TI1_Config((uint8_t)TIM3_ICPolarity,
 823                     ; 180                    (uint8_t)TIM3_ICSelection,
 823                     ; 181                    (uint8_t)TIM3_ICFilter);
 825  00be 7b07          	ld	a,(OFST+7,sp)
 826  00c0 88            	push	a
 827  00c1 7b06          	ld	a,(OFST+6,sp)
 828  00c3 97            	ld	xl,a
 829  00c4 7b03          	ld	a,(OFST+3,sp)
 830  00c6 95            	ld	xh,a
 831  00c7 cd032d        	call	L3_TI1_Config
 833  00ca 84            	pop	a
 834                     ; 184         TIM3_SetIC1Prescaler(TIM3_ICPrescaler);
 836  00cb 7b06          	ld	a,(OFST+6,sp)
 837  00cd cd0274        	call	_TIM3_SetIC1Prescaler
 840  00d0 2012          	jra	L543
 841  00d2               L343:
 842                     ; 189         TI2_Config((uint8_t)TIM3_ICPolarity,
 842                     ; 190                    (uint8_t)TIM3_ICSelection,
 842                     ; 191                    (uint8_t)TIM3_ICFilter);
 844  00d2 7b07          	ld	a,(OFST+7,sp)
 845  00d4 88            	push	a
 846  00d5 7b06          	ld	a,(OFST+6,sp)
 847  00d7 97            	ld	xl,a
 848  00d8 7b03          	ld	a,(OFST+3,sp)
 849  00da 95            	ld	xh,a
 850  00db cd035d        	call	L5_TI2_Config
 852  00de 84            	pop	a
 853                     ; 194         TIM3_SetIC2Prescaler(TIM3_ICPrescaler);
 855  00df 7b06          	ld	a,(OFST+6,sp)
 856  00e1 cd0281        	call	_TIM3_SetIC2Prescaler
 858  00e4               L543:
 859                     ; 196 }
 862  00e4 85            	popw	x
 863  00e5 81            	ret	
 959                     ; 206 void TIM3_PWMIConfig(TIM3_Channel_TypeDef TIM3_Channel,
 959                     ; 207                      TIM3_ICPolarity_TypeDef TIM3_ICPolarity,
 959                     ; 208                      TIM3_ICSelection_TypeDef TIM3_ICSelection,
 959                     ; 209                      TIM3_ICPSC_TypeDef TIM3_ICPrescaler,
 959                     ; 210                      uint8_t TIM3_ICFilter)
 959                     ; 211 {
 960                     	switch	.text
 961  00e6               _TIM3_PWMIConfig:
 963  00e6 89            	pushw	x
 964  00e7 89            	pushw	x
 965       00000002      OFST:	set	2
 968                     ; 212     uint8_t icpolarity = (uint8_t)TIM3_ICPOLARITY_RISING;
 970                     ; 213     uint8_t icselection = (uint8_t)TIM3_ICSELECTION_DIRECTTI;
 972                     ; 216     assert_param(IS_TIM3_PWMI_CHANNEL_OK(TIM3_Channel));
 974                     ; 217     assert_param(IS_TIM3_IC_POLARITY_OK(TIM3_ICPolarity));
 976                     ; 218     assert_param(IS_TIM3_IC_SELECTION_OK(TIM3_ICSelection));
 978                     ; 219     assert_param(IS_TIM3_IC_PRESCALER_OK(TIM3_ICPrescaler));
 980                     ; 222     if (TIM3_ICPolarity != TIM3_ICPOLARITY_FALLING)
 982  00e8 9f            	ld	a,xl
 983  00e9 a144          	cp	a,#68
 984  00eb 2706          	jreq	L514
 985                     ; 224         icpolarity = (uint8_t)TIM3_ICPOLARITY_FALLING;
 987  00ed a644          	ld	a,#68
 988  00ef 6b01          	ld	(OFST-1,sp),a
 990  00f1 2002          	jra	L714
 991  00f3               L514:
 992                     ; 228         icpolarity = (uint8_t)TIM3_ICPOLARITY_RISING;
 994  00f3 0f01          	clr	(OFST-1,sp)
 995  00f5               L714:
 996                     ; 232     if (TIM3_ICSelection == TIM3_ICSELECTION_DIRECTTI)
 998  00f5 7b07          	ld	a,(OFST+5,sp)
 999  00f7 4a            	dec	a
1000  00f8 2604          	jrne	L124
1001                     ; 234         icselection = (uint8_t)TIM3_ICSELECTION_INDIRECTTI;
1003  00fa a602          	ld	a,#2
1005  00fc 2002          	jra	L324
1006  00fe               L124:
1007                     ; 238         icselection = (uint8_t)TIM3_ICSELECTION_DIRECTTI;
1009  00fe a601          	ld	a,#1
1010  0100               L324:
1011  0100 6b02          	ld	(OFST+0,sp),a
1012                     ; 241     if (TIM3_Channel != TIM3_CHANNEL_2)
1014  0102 7b03          	ld	a,(OFST+1,sp)
1015  0104 4a            	dec	a
1016  0105 2726          	jreq	L524
1017                     ; 244         TI1_Config((uint8_t)TIM3_ICPolarity, (uint8_t)TIM3_ICSelection,
1017                     ; 245                    (uint8_t)TIM3_ICFilter);
1019  0107 7b09          	ld	a,(OFST+7,sp)
1020  0109 88            	push	a
1021  010a 7b08          	ld	a,(OFST+6,sp)
1022  010c 97            	ld	xl,a
1023  010d 7b05          	ld	a,(OFST+3,sp)
1024  010f 95            	ld	xh,a
1025  0110 cd032d        	call	L3_TI1_Config
1027  0113 84            	pop	a
1028                     ; 248         TIM3_SetIC1Prescaler(TIM3_ICPrescaler);
1030  0114 7b08          	ld	a,(OFST+6,sp)
1031  0116 cd0274        	call	_TIM3_SetIC1Prescaler
1033                     ; 251         TI2_Config(icpolarity, icselection, TIM3_ICFilter);
1035  0119 7b09          	ld	a,(OFST+7,sp)
1036  011b 88            	push	a
1037  011c 7b03          	ld	a,(OFST+1,sp)
1038  011e 97            	ld	xl,a
1039  011f 7b02          	ld	a,(OFST+0,sp)
1040  0121 95            	ld	xh,a
1041  0122 cd035d        	call	L5_TI2_Config
1043  0125 84            	pop	a
1044                     ; 254         TIM3_SetIC2Prescaler(TIM3_ICPrescaler);
1046  0126 7b08          	ld	a,(OFST+6,sp)
1047  0128 cd0281        	call	_TIM3_SetIC2Prescaler
1050  012b 2024          	jra	L724
1051  012d               L524:
1052                     ; 259         TI2_Config((uint8_t)TIM3_ICPolarity, (uint8_t)TIM3_ICSelection,
1052                     ; 260                    (uint8_t)TIM3_ICFilter);
1054  012d 7b09          	ld	a,(OFST+7,sp)
1055  012f 88            	push	a
1056  0130 7b08          	ld	a,(OFST+6,sp)
1057  0132 97            	ld	xl,a
1058  0133 7b05          	ld	a,(OFST+3,sp)
1059  0135 95            	ld	xh,a
1060  0136 cd035d        	call	L5_TI2_Config
1062  0139 84            	pop	a
1063                     ; 263         TIM3_SetIC2Prescaler(TIM3_ICPrescaler);
1065  013a 7b08          	ld	a,(OFST+6,sp)
1066  013c cd0281        	call	_TIM3_SetIC2Prescaler
1068                     ; 266         TI1_Config(icpolarity, icselection, TIM3_ICFilter);
1070  013f 7b09          	ld	a,(OFST+7,sp)
1071  0141 88            	push	a
1072  0142 7b03          	ld	a,(OFST+1,sp)
1073  0144 97            	ld	xl,a
1074  0145 7b02          	ld	a,(OFST+0,sp)
1075  0147 95            	ld	xh,a
1076  0148 cd032d        	call	L3_TI1_Config
1078  014b 84            	pop	a
1079                     ; 269         TIM3_SetIC1Prescaler(TIM3_ICPrescaler);
1081  014c 7b08          	ld	a,(OFST+6,sp)
1082  014e cd0274        	call	_TIM3_SetIC1Prescaler
1084  0151               L724:
1085                     ; 271 }
1088  0151 5b04          	addw	sp,#4
1089  0153 81            	ret	
1144                     ; 280 void TIM3_Cmd(FunctionalState NewState)
1144                     ; 281 {
1145                     	switch	.text
1146  0154               _TIM3_Cmd:
1150                     ; 283     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1152                     ; 286     if (NewState != DISABLE)
1154  0154 4d            	tnz	a
1155  0155 2705          	jreq	L754
1156                     ; 288         TIM3->CR1 |= (uint8_t)TIM3_CR1_CEN;
1158  0157 72105320      	bset	21280,#0
1161  015b 81            	ret	
1162  015c               L754:
1163                     ; 292         TIM3->CR1 &= (uint8_t)(~TIM3_CR1_CEN);
1165  015c 72115320      	bres	21280,#0
1166                     ; 294 }
1169  0160 81            	ret	
1241                     ; 309 void TIM3_ITConfig(TIM3_IT_TypeDef TIM3_IT, FunctionalState NewState)
1241                     ; 310 {
1242                     	switch	.text
1243  0161               _TIM3_ITConfig:
1245  0161 89            	pushw	x
1246       00000000      OFST:	set	0
1249                     ; 312     assert_param(IS_TIM3_IT_OK(TIM3_IT));
1251                     ; 313     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1253                     ; 315     if (NewState != DISABLE)
1255  0162 9f            	ld	a,xl
1256  0163 4d            	tnz	a
1257  0164 2706          	jreq	L715
1258                     ; 318         TIM3->IER |= (uint8_t)TIM3_IT;
1260  0166 9e            	ld	a,xh
1261  0167 ca5321        	or	a,21281
1263  016a 2006          	jra	L125
1264  016c               L715:
1265                     ; 323         TIM3->IER &= (uint8_t)(~TIM3_IT);
1267  016c 7b01          	ld	a,(OFST+1,sp)
1268  016e 43            	cpl	a
1269  016f c45321        	and	a,21281
1270  0172               L125:
1271  0172 c75321        	ld	21281,a
1272                     ; 325 }
1275  0175 85            	popw	x
1276  0176 81            	ret	
1312                     ; 334 void TIM3_UpdateDisableConfig(FunctionalState NewState)
1312                     ; 335 {
1313                     	switch	.text
1314  0177               _TIM3_UpdateDisableConfig:
1318                     ; 337     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1320                     ; 340     if (NewState != DISABLE)
1322  0177 4d            	tnz	a
1323  0178 2705          	jreq	L145
1324                     ; 342         TIM3->CR1 |= TIM3_CR1_UDIS;
1326  017a 72125320      	bset	21280,#1
1329  017e 81            	ret	
1330  017f               L145:
1331                     ; 346         TIM3->CR1 &= (uint8_t)(~TIM3_CR1_UDIS);
1333  017f 72135320      	bres	21280,#1
1334                     ; 348 }
1337  0183 81            	ret	
1395                     ; 358 void TIM3_UpdateRequestConfig(TIM3_UpdateSource_TypeDef TIM3_UpdateSource)
1395                     ; 359 {
1396                     	switch	.text
1397  0184               _TIM3_UpdateRequestConfig:
1401                     ; 361     assert_param(IS_TIM3_UPDATE_SOURCE_OK(TIM3_UpdateSource));
1403                     ; 364     if (TIM3_UpdateSource != TIM3_UPDATESOURCE_GLOBAL)
1405  0184 4d            	tnz	a
1406  0185 2705          	jreq	L375
1407                     ; 366         TIM3->CR1 |= TIM3_CR1_URS;
1409  0187 72145320      	bset	21280,#2
1412  018b 81            	ret	
1413  018c               L375:
1414                     ; 370         TIM3->CR1 &= (uint8_t)(~TIM3_CR1_URS);
1416  018c 72155320      	bres	21280,#2
1417                     ; 372 }
1420  0190 81            	ret	
1477                     ; 383 void TIM3_SelectOnePulseMode(TIM3_OPMode_TypeDef TIM3_OPMode)
1477                     ; 384 {
1478                     	switch	.text
1479  0191               _TIM3_SelectOnePulseMode:
1483                     ; 386     assert_param(IS_TIM3_OPM_MODE_OK(TIM3_OPMode));
1485                     ; 389     if (TIM3_OPMode != TIM3_OPMODE_REPETITIVE)
1487  0191 4d            	tnz	a
1488  0192 2705          	jreq	L526
1489                     ; 391         TIM3->CR1 |= TIM3_CR1_OPM;
1491  0194 72165320      	bset	21280,#3
1494  0198 81            	ret	
1495  0199               L526:
1496                     ; 395         TIM3->CR1 &= (uint8_t)(~TIM3_CR1_OPM);
1498  0199 72175320      	bres	21280,#3
1499                     ; 398 }
1502  019d 81            	ret	
1570                     ; 429 void TIM3_PrescalerConfig(TIM3_Prescaler_TypeDef Prescaler,
1570                     ; 430                           TIM3_PSCReloadMode_TypeDef TIM3_PSCReloadMode)
1570                     ; 431 {
1571                     	switch	.text
1572  019e               _TIM3_PrescalerConfig:
1576                     ; 433     assert_param(IS_TIM3_PRESCALER_RELOAD_OK(TIM3_PSCReloadMode));
1578                     ; 434     assert_param(IS_TIM3_PRESCALER_OK(Prescaler));
1580                     ; 437     TIM3->PSCR = (uint8_t)Prescaler;
1582  019e 9e            	ld	a,xh
1583  019f c7532a        	ld	21290,a
1584                     ; 440     TIM3->EGR = (uint8_t)TIM3_PSCReloadMode;
1586  01a2 9f            	ld	a,xl
1587  01a3 c75324        	ld	21284,a
1588                     ; 441 }
1591  01a6 81            	ret	
1649                     ; 452 void TIM3_ForcedOC1Config(TIM3_ForcedAction_TypeDef TIM3_ForcedAction)
1649                     ; 453 {
1650                     	switch	.text
1651  01a7               _TIM3_ForcedOC1Config:
1653  01a7 88            	push	a
1654       00000000      OFST:	set	0
1657                     ; 455     assert_param(IS_TIM3_FORCED_ACTION_OK(TIM3_ForcedAction));
1659                     ; 458     TIM3->CCMR1 =  (uint8_t)((uint8_t)(TIM3->CCMR1 & (uint8_t)(~TIM3_CCMR_OCM))  | (uint8_t)TIM3_ForcedAction);
1661  01a8 c65325        	ld	a,21285
1662  01ab a48f          	and	a,#143
1663  01ad 1a01          	or	a,(OFST+1,sp)
1664  01af c75325        	ld	21285,a
1665                     ; 459 }
1668  01b2 84            	pop	a
1669  01b3 81            	ret	
1705                     ; 470 void TIM3_ForcedOC2Config(TIM3_ForcedAction_TypeDef TIM3_ForcedAction)
1705                     ; 471 {
1706                     	switch	.text
1707  01b4               _TIM3_ForcedOC2Config:
1709  01b4 88            	push	a
1710       00000000      OFST:	set	0
1713                     ; 473     assert_param(IS_TIM3_FORCED_ACTION_OK(TIM3_ForcedAction));
1715                     ; 476     TIM3->CCMR2 =  (uint8_t)((uint8_t)(TIM3->CCMR2 & (uint8_t)(~TIM3_CCMR_OCM)) | (uint8_t)TIM3_ForcedAction);
1717  01b5 c65326        	ld	a,21286
1718  01b8 a48f          	and	a,#143
1719  01ba 1a01          	or	a,(OFST+1,sp)
1720  01bc c75326        	ld	21286,a
1721                     ; 477 }
1724  01bf 84            	pop	a
1725  01c0 81            	ret	
1761                     ; 486 void TIM3_ARRPreloadConfig(FunctionalState NewState)
1761                     ; 487 {
1762                     	switch	.text
1763  01c1               _TIM3_ARRPreloadConfig:
1767                     ; 489     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1769                     ; 492     if (NewState != DISABLE)
1771  01c1 4d            	tnz	a
1772  01c2 2705          	jreq	L547
1773                     ; 494         TIM3->CR1 |= TIM3_CR1_ARPE;
1775  01c4 721e5320      	bset	21280,#7
1778  01c8 81            	ret	
1779  01c9               L547:
1780                     ; 498         TIM3->CR1 &= (uint8_t)(~TIM3_CR1_ARPE);
1782  01c9 721f5320      	bres	21280,#7
1783                     ; 500 }
1786  01cd 81            	ret	
1822                     ; 509 void TIM3_OC1PreloadConfig(FunctionalState NewState)
1822                     ; 510 {
1823                     	switch	.text
1824  01ce               _TIM3_OC1PreloadConfig:
1828                     ; 512     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1830                     ; 515     if (NewState != DISABLE)
1832  01ce 4d            	tnz	a
1833  01cf 2705          	jreq	L767
1834                     ; 517         TIM3->CCMR1 |= TIM3_CCMR_OCxPE;
1836  01d1 72165325      	bset	21285,#3
1839  01d5 81            	ret	
1840  01d6               L767:
1841                     ; 521         TIM3->CCMR1 &= (uint8_t)(~TIM3_CCMR_OCxPE);
1843  01d6 72175325      	bres	21285,#3
1844                     ; 523 }
1847  01da 81            	ret	
1883                     ; 532 void TIM3_OC2PreloadConfig(FunctionalState NewState)
1883                     ; 533 {
1884                     	switch	.text
1885  01db               _TIM3_OC2PreloadConfig:
1889                     ; 535     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1891                     ; 538     if (NewState != DISABLE)
1893  01db 4d            	tnz	a
1894  01dc 2705          	jreq	L1101
1895                     ; 540         TIM3->CCMR2 |= TIM3_CCMR_OCxPE;
1897  01de 72165326      	bset	21286,#3
1900  01e2 81            	ret	
1901  01e3               L1101:
1902                     ; 544         TIM3->CCMR2 &= (uint8_t)(~TIM3_CCMR_OCxPE);
1904  01e3 72175326      	bres	21286,#3
1905                     ; 546 }
1908  01e7 81            	ret	
1973                     ; 557 void TIM3_GenerateEvent(TIM3_EventSource_TypeDef TIM3_EventSource)
1973                     ; 558 {
1974                     	switch	.text
1975  01e8               _TIM3_GenerateEvent:
1979                     ; 560     assert_param(IS_TIM3_EVENT_SOURCE_OK(TIM3_EventSource));
1981                     ; 563     TIM3->EGR = (uint8_t)TIM3_EventSource;
1983  01e8 c75324        	ld	21284,a
1984                     ; 564 }
1987  01eb 81            	ret	
2023                     ; 575 void TIM3_OC1PolarityConfig(TIM3_OCPolarity_TypeDef TIM3_OCPolarity)
2023                     ; 576 {
2024                     	switch	.text
2025  01ec               _TIM3_OC1PolarityConfig:
2029                     ; 578     assert_param(IS_TIM3_OC_POLARITY_OK(TIM3_OCPolarity));
2031                     ; 581     if (TIM3_OCPolarity != TIM3_OCPOLARITY_HIGH)
2033  01ec 4d            	tnz	a
2034  01ed 2705          	jreq	L3601
2035                     ; 583         TIM3->CCER1 |= TIM3_CCER1_CC1P;
2037  01ef 72125327      	bset	21287,#1
2040  01f3 81            	ret	
2041  01f4               L3601:
2042                     ; 587         TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1P);
2044  01f4 72135327      	bres	21287,#1
2045                     ; 589 }
2048  01f8 81            	ret	
2084                     ; 600 void TIM3_OC2PolarityConfig(TIM3_OCPolarity_TypeDef TIM3_OCPolarity)
2084                     ; 601 {
2085                     	switch	.text
2086  01f9               _TIM3_OC2PolarityConfig:
2090                     ; 603     assert_param(IS_TIM3_OC_POLARITY_OK(TIM3_OCPolarity));
2092                     ; 606     if (TIM3_OCPolarity != TIM3_OCPOLARITY_HIGH)
2094  01f9 4d            	tnz	a
2095  01fa 2705          	jreq	L5011
2096                     ; 608         TIM3->CCER1 |= TIM3_CCER1_CC2P;
2098  01fc 721a5327      	bset	21287,#5
2101  0200 81            	ret	
2102  0201               L5011:
2103                     ; 612         TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC2P);
2105  0201 721b5327      	bres	21287,#5
2106                     ; 614 }
2109  0205 81            	ret	
2154                     ; 627 void TIM3_CCxCmd(TIM3_Channel_TypeDef TIM3_Channel, FunctionalState NewState)
2154                     ; 628 {
2155                     	switch	.text
2156  0206               _TIM3_CCxCmd:
2158  0206 89            	pushw	x
2159       00000000      OFST:	set	0
2162                     ; 630     assert_param(IS_TIM3_CHANNEL_OK(TIM3_Channel));
2164                     ; 631     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2166                     ; 633     if (TIM3_Channel == TIM3_CHANNEL_1)
2168  0207 9e            	ld	a,xh
2169  0208 4d            	tnz	a
2170  0209 2610          	jrne	L3311
2171                     ; 636         if (NewState != DISABLE)
2173  020b 9f            	ld	a,xl
2174  020c 4d            	tnz	a
2175  020d 2706          	jreq	L5311
2176                     ; 638             TIM3->CCER1 |= TIM3_CCER1_CC1E;
2178  020f 72105327      	bset	21287,#0
2180  0213 2014          	jra	L1411
2181  0215               L5311:
2182                     ; 642             TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1E);
2184  0215 72115327      	bres	21287,#0
2185  0219 200e          	jra	L1411
2186  021b               L3311:
2187                     ; 649         if (NewState != DISABLE)
2189  021b 7b02          	ld	a,(OFST+2,sp)
2190  021d 2706          	jreq	L3411
2191                     ; 651             TIM3->CCER1 |= TIM3_CCER1_CC2E;
2193  021f 72185327      	bset	21287,#4
2195  0223 2004          	jra	L1411
2196  0225               L3411:
2197                     ; 655             TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC2E);
2199  0225 72195327      	bres	21287,#4
2200  0229               L1411:
2201                     ; 659 }
2204  0229 85            	popw	x
2205  022a 81            	ret	
2250                     ; 680 void TIM3_SelectOCxM(TIM3_Channel_TypeDef TIM3_Channel, TIM3_OCMode_TypeDef TIM3_OCMode)
2250                     ; 681 {
2251                     	switch	.text
2252  022b               _TIM3_SelectOCxM:
2254  022b 89            	pushw	x
2255       00000000      OFST:	set	0
2258                     ; 683     assert_param(IS_TIM3_CHANNEL_OK(TIM3_Channel));
2260                     ; 684     assert_param(IS_TIM3_OCM_OK(TIM3_OCMode));
2262                     ; 686     if (TIM3_Channel == TIM3_CHANNEL_1)
2264  022c 9e            	ld	a,xh
2265  022d 4d            	tnz	a
2266  022e 2610          	jrne	L1711
2267                     ; 689         TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1E);
2269  0230 72115327      	bres	21287,#0
2270                     ; 692         TIM3->CCMR1 = (uint8_t)((uint8_t)(TIM3->CCMR1 & (uint8_t)(~TIM3_CCMR_OCM)) | (uint8_t)TIM3_OCMode);
2272  0234 c65325        	ld	a,21285
2273  0237 a48f          	and	a,#143
2274  0239 1a02          	or	a,(OFST+2,sp)
2275  023b c75325        	ld	21285,a
2277  023e 200e          	jra	L3711
2278  0240               L1711:
2279                     ; 697         TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC2E);
2281  0240 72195327      	bres	21287,#4
2282                     ; 700         TIM3->CCMR2 = (uint8_t)((uint8_t)(TIM3->CCMR2 & (uint8_t)(~TIM3_CCMR_OCM)) | (uint8_t)TIM3_OCMode);
2284  0244 c65326        	ld	a,21286
2285  0247 a48f          	and	a,#143
2286  0249 1a02          	or	a,(OFST+2,sp)
2287  024b c75326        	ld	21286,a
2288  024e               L3711:
2289                     ; 702 }
2292  024e 85            	popw	x
2293  024f 81            	ret	
2327                     ; 711 void TIM3_SetCounter(uint16_t Counter)
2327                     ; 712 {
2328                     	switch	.text
2329  0250               _TIM3_SetCounter:
2333                     ; 714     TIM3->CNTRH = (uint8_t)(Counter >> 8);
2335  0250 9e            	ld	a,xh
2336  0251 c75328        	ld	21288,a
2337                     ; 715     TIM3->CNTRL = (uint8_t)(Counter);
2339  0254 9f            	ld	a,xl
2340  0255 c75329        	ld	21289,a
2341                     ; 717 }
2344  0258 81            	ret	
2378                     ; 726 void TIM3_SetAutoreload(uint16_t Autoreload)
2378                     ; 727 {
2379                     	switch	.text
2380  0259               _TIM3_SetAutoreload:
2384                     ; 729     TIM3->ARRH = (uint8_t)(Autoreload >> 8);
2386  0259 9e            	ld	a,xh
2387  025a c7532b        	ld	21291,a
2388                     ; 730     TIM3->ARRL = (uint8_t)(Autoreload);
2390  025d 9f            	ld	a,xl
2391  025e c7532c        	ld	21292,a
2392                     ; 731 }
2395  0261 81            	ret	
2429                     ; 740 void TIM3_SetCompare1(uint16_t Compare1)
2429                     ; 741 {
2430                     	switch	.text
2431  0262               _TIM3_SetCompare1:
2435                     ; 743     TIM3->CCR1H = (uint8_t)(Compare1 >> 8);
2437  0262 9e            	ld	a,xh
2438  0263 c7532d        	ld	21293,a
2439                     ; 744     TIM3->CCR1L = (uint8_t)(Compare1);
2441  0266 9f            	ld	a,xl
2442  0267 c7532e        	ld	21294,a
2443                     ; 745 }
2446  026a 81            	ret	
2480                     ; 754 void TIM3_SetCompare2(uint16_t Compare2)
2480                     ; 755 {
2481                     	switch	.text
2482  026b               _TIM3_SetCompare2:
2486                     ; 757     TIM3->CCR2H = (uint8_t)(Compare2 >> 8);
2488  026b 9e            	ld	a,xh
2489  026c c7532f        	ld	21295,a
2490                     ; 758     TIM3->CCR2L = (uint8_t)(Compare2);
2492  026f 9f            	ld	a,xl
2493  0270 c75330        	ld	21296,a
2494                     ; 759 }
2497  0273 81            	ret	
2533                     ; 772 void TIM3_SetIC1Prescaler(TIM3_ICPSC_TypeDef TIM3_IC1Prescaler)
2533                     ; 773 {
2534                     	switch	.text
2535  0274               _TIM3_SetIC1Prescaler:
2537  0274 88            	push	a
2538       00000000      OFST:	set	0
2541                     ; 775     assert_param(IS_TIM3_IC_PRESCALER_OK(TIM3_IC1Prescaler));
2543                     ; 778     TIM3->CCMR1 = (uint8_t)((uint8_t)(TIM3->CCMR1 & (uint8_t)(~TIM3_CCMR_ICxPSC)) | (uint8_t)TIM3_IC1Prescaler);
2545  0275 c65325        	ld	a,21285
2546  0278 a4f3          	and	a,#243
2547  027a 1a01          	or	a,(OFST+1,sp)
2548  027c c75325        	ld	21285,a
2549                     ; 779 }
2552  027f 84            	pop	a
2553  0280 81            	ret	
2589                     ; 791 void TIM3_SetIC2Prescaler(TIM3_ICPSC_TypeDef TIM3_IC2Prescaler)
2589                     ; 792 {
2590                     	switch	.text
2591  0281               _TIM3_SetIC2Prescaler:
2593  0281 88            	push	a
2594       00000000      OFST:	set	0
2597                     ; 794     assert_param(IS_TIM3_IC_PRESCALER_OK(TIM3_IC2Prescaler));
2599                     ; 797     TIM3->CCMR2 = (uint8_t)((uint8_t)(TIM3->CCMR2 & (uint8_t)(~TIM3_CCMR_ICxPSC)) | (uint8_t)TIM3_IC2Prescaler);
2601  0282 c65326        	ld	a,21286
2602  0285 a4f3          	and	a,#243
2603  0287 1a01          	or	a,(OFST+1,sp)
2604  0289 c75326        	ld	21286,a
2605                     ; 798 }
2608  028c 84            	pop	a
2609  028d 81            	ret	
2661                     ; 804 uint16_t TIM3_GetCapture1(void)
2661                     ; 805 {
2662                     	switch	.text
2663  028e               _TIM3_GetCapture1:
2665  028e 5204          	subw	sp,#4
2666       00000004      OFST:	set	4
2669                     ; 807     uint16_t tmpccr1 = 0;
2671                     ; 808     uint8_t tmpccr1l=0, tmpccr1h=0;
2675                     ; 810     tmpccr1h = TIM3->CCR1H;
2677  0290 c6532d        	ld	a,21293
2678  0293 6b02          	ld	(OFST-2,sp),a
2679                     ; 811     tmpccr1l = TIM3->CCR1L;
2681  0295 c6532e        	ld	a,21294
2682  0298 6b01          	ld	(OFST-3,sp),a
2683                     ; 813     tmpccr1 = (uint16_t)(tmpccr1l);
2685  029a 5f            	clrw	x
2686  029b 97            	ld	xl,a
2687  029c 1f03          	ldw	(OFST-1,sp),x
2688                     ; 814     tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
2690  029e 5f            	clrw	x
2691  029f 7b02          	ld	a,(OFST-2,sp)
2692  02a1 97            	ld	xl,a
2693  02a2 7b04          	ld	a,(OFST+0,sp)
2694  02a4 01            	rrwa	x,a
2695  02a5 1a03          	or	a,(OFST-1,sp)
2696  02a7 01            	rrwa	x,a
2697                     ; 816     return (uint16_t)tmpccr1;
2701  02a8 5b04          	addw	sp,#4
2702  02aa 81            	ret	
2754                     ; 824 uint16_t TIM3_GetCapture2(void)
2754                     ; 825 {
2755                     	switch	.text
2756  02ab               _TIM3_GetCapture2:
2758  02ab 5204          	subw	sp,#4
2759       00000004      OFST:	set	4
2762                     ; 827     uint16_t tmpccr2 = 0;
2764                     ; 828     uint8_t tmpccr2l=0, tmpccr2h=0;
2768                     ; 830     tmpccr2h = TIM3->CCR2H;
2770  02ad c6532f        	ld	a,21295
2771  02b0 6b02          	ld	(OFST-2,sp),a
2772                     ; 831     tmpccr2l = TIM3->CCR2L;
2774  02b2 c65330        	ld	a,21296
2775  02b5 6b01          	ld	(OFST-3,sp),a
2776                     ; 833     tmpccr2 = (uint16_t)(tmpccr2l);
2778  02b7 5f            	clrw	x
2779  02b8 97            	ld	xl,a
2780  02b9 1f03          	ldw	(OFST-1,sp),x
2781                     ; 834     tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
2783  02bb 5f            	clrw	x
2784  02bc 7b02          	ld	a,(OFST-2,sp)
2785  02be 97            	ld	xl,a
2786  02bf 7b04          	ld	a,(OFST+0,sp)
2787  02c1 01            	rrwa	x,a
2788  02c2 1a03          	or	a,(OFST-1,sp)
2789  02c4 01            	rrwa	x,a
2790                     ; 836     return (uint16_t)tmpccr2;
2794  02c5 5b04          	addw	sp,#4
2795  02c7 81            	ret	
2829                     ; 844 uint16_t TIM3_GetCounter(void)
2829                     ; 845 {
2830                     	switch	.text
2831  02c8               _TIM3_GetCounter:
2833  02c8 89            	pushw	x
2834       00000002      OFST:	set	2
2837                     ; 846    uint16_t tmpcntr = 0;
2839                     ; 848    tmpcntr = ((uint16_t)TIM3->CNTRH << 8);
2841  02c9 c65328        	ld	a,21288
2842  02cc 97            	ld	xl,a
2843  02cd 4f            	clr	a
2844  02ce 02            	rlwa	x,a
2845  02cf 1f01          	ldw	(OFST-1,sp),x
2846                     ; 850     return (uint16_t)( tmpcntr| (uint16_t)(TIM3->CNTRL));
2848  02d1 5f            	clrw	x
2849  02d2 c65329        	ld	a,21289
2850  02d5 97            	ld	xl,a
2851  02d6 01            	rrwa	x,a
2852  02d7 1a02          	or	a,(OFST+0,sp)
2853  02d9 01            	rrwa	x,a
2854  02da 1a01          	or	a,(OFST-1,sp)
2855  02dc 01            	rrwa	x,a
2858  02dd 5b02          	addw	sp,#2
2859  02df 81            	ret	
2883                     ; 859 TIM3_Prescaler_TypeDef TIM3_GetPrescaler(void)
2883                     ; 860 {
2884                     	switch	.text
2885  02e0               _TIM3_GetPrescaler:
2889                     ; 862     return (TIM3_Prescaler_TypeDef)(TIM3->PSCR);
2891  02e0 c6532a        	ld	a,21290
2894  02e3 81            	ret	
3019                     ; 877 FlagStatus TIM3_GetFlagStatus(TIM3_FLAG_TypeDef TIM3_FLAG)
3019                     ; 878 {
3020                     	switch	.text
3021  02e4               _TIM3_GetFlagStatus:
3023  02e4 89            	pushw	x
3024  02e5 89            	pushw	x
3025       00000002      OFST:	set	2
3028                     ; 879    FlagStatus bitstatus = RESET;
3030                     ; 880    uint8_t tim3_flag_l = 0, tim3_flag_h = 0;
3034                     ; 883     assert_param(IS_TIM3_GET_FLAG_OK(TIM3_FLAG));
3036                     ; 885     tim3_flag_l = (uint8_t)(TIM3->SR1 & (uint8_t)TIM3_FLAG);
3038  02e6 9f            	ld	a,xl
3039  02e7 c45322        	and	a,21282
3040  02ea 6b01          	ld	(OFST-1,sp),a
3041                     ; 886     tim3_flag_h = (uint8_t)((uint16_t)TIM3_FLAG >> 8);
3043  02ec 7b03          	ld	a,(OFST+1,sp)
3044  02ee 6b02          	ld	(OFST+0,sp),a
3045                     ; 888     if (((tim3_flag_l) | (uint8_t)(TIM3->SR2 & tim3_flag_h)) != (uint8_t)RESET )
3047  02f0 c45323        	and	a,21283
3048  02f3 1a01          	or	a,(OFST-1,sp)
3049  02f5 2702          	jreq	L3051
3050                     ; 890         bitstatus = SET;
3052  02f7 a601          	ld	a,#1
3054  02f9               L3051:
3055                     ; 894         bitstatus = RESET;
3057                     ; 896     return (FlagStatus)bitstatus;
3061  02f9 5b04          	addw	sp,#4
3062  02fb 81            	ret	
3097                     ; 911 void TIM3_ClearFlag(TIM3_FLAG_TypeDef TIM3_FLAG)
3097                     ; 912 {
3098                     	switch	.text
3099  02fc               _TIM3_ClearFlag:
3101  02fc 89            	pushw	x
3102       00000000      OFST:	set	0
3105                     ; 914     assert_param(IS_TIM3_CLEAR_FLAG_OK(TIM3_FLAG));
3107                     ; 917     TIM3->SR1 = (uint8_t)(~((uint8_t)(TIM3_FLAG)));
3109  02fd 9f            	ld	a,xl
3110  02fe 43            	cpl	a
3111  02ff c75322        	ld	21282,a
3112                     ; 918     TIM3->SR2 = (uint8_t)(~((uint8_t)((uint16_t)TIM3_FLAG >> 8)));
3114  0302 7b01          	ld	a,(OFST+1,sp)
3115  0304 43            	cpl	a
3116  0305 c75323        	ld	21283,a
3117                     ; 919 }
3120  0308 85            	popw	x
3121  0309 81            	ret	
3185                     ; 932 ITStatus TIM3_GetITStatus(TIM3_IT_TypeDef TIM3_IT)
3185                     ; 933 {
3186                     	switch	.text
3187  030a               _TIM3_GetITStatus:
3189  030a 88            	push	a
3190  030b 89            	pushw	x
3191       00000002      OFST:	set	2
3194                     ; 934     ITStatus bitstatus = RESET;
3196                     ; 935     uint8_t TIM3_itStatus = 0, TIM3_itEnable = 0;
3200                     ; 938     assert_param(IS_TIM3_GET_IT_OK(TIM3_IT));
3202                     ; 940     TIM3_itStatus = (uint8_t)(TIM3->SR1 & TIM3_IT);
3204  030c c45322        	and	a,21282
3205  030f 6b01          	ld	(OFST-1,sp),a
3206                     ; 942     TIM3_itEnable = (uint8_t)(TIM3->IER & TIM3_IT);
3208  0311 c65321        	ld	a,21281
3209  0314 1403          	and	a,(OFST+1,sp)
3210  0316 6b02          	ld	(OFST+0,sp),a
3211                     ; 944     if ((TIM3_itStatus != (uint8_t)RESET ) && (TIM3_itEnable != (uint8_t)RESET ))
3213  0318 7b01          	ld	a,(OFST-1,sp)
3214  031a 2708          	jreq	L7551
3216  031c 7b02          	ld	a,(OFST+0,sp)
3217  031e 2704          	jreq	L7551
3218                     ; 946         bitstatus = SET;
3220  0320 a601          	ld	a,#1
3222  0322 2001          	jra	L1651
3223  0324               L7551:
3224                     ; 950         bitstatus = RESET;
3226  0324 4f            	clr	a
3227  0325               L1651:
3228                     ; 952     return (ITStatus)(bitstatus);
3232  0325 5b03          	addw	sp,#3
3233  0327 81            	ret	
3269                     ; 965 void TIM3_ClearITPendingBit(TIM3_IT_TypeDef TIM3_IT)
3269                     ; 966 {
3270                     	switch	.text
3271  0328               _TIM3_ClearITPendingBit:
3275                     ; 968     assert_param(IS_TIM3_IT_OK(TIM3_IT));
3277                     ; 971     TIM3->SR1 = (uint8_t)(~TIM3_IT);
3279  0328 43            	cpl	a
3280  0329 c75322        	ld	21282,a
3281                     ; 972 }
3284  032c 81            	ret	
3336                     ; 991 static void TI1_Config(uint8_t TIM3_ICPolarity,
3336                     ; 992                        uint8_t TIM3_ICSelection,
3336                     ; 993                        uint8_t TIM3_ICFilter)
3336                     ; 994 {
3337                     	switch	.text
3338  032d               L3_TI1_Config:
3340  032d 89            	pushw	x
3341       00000001      OFST:	set	1
3344                     ; 996     TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1E);
3346  032e 72115327      	bres	21287,#0
3347  0332 88            	push	a
3348                     ; 999     TIM3->CCMR1 = (uint8_t)((uint8_t)(TIM3->CCMR1 & (uint8_t)(~( TIM3_CCMR_CCxS | TIM3_CCMR_ICxF))) | (uint8_t)(( (TIM3_ICSelection)) | ((uint8_t)( TIM3_ICFilter << 4))));
3350  0333 7b06          	ld	a,(OFST+5,sp)
3351  0335 97            	ld	xl,a
3352  0336 a610          	ld	a,#16
3353  0338 42            	mul	x,a
3354  0339 9f            	ld	a,xl
3355  033a 1a03          	or	a,(OFST+2,sp)
3356  033c 6b01          	ld	(OFST+0,sp),a
3357  033e c65325        	ld	a,21285
3358  0341 a40c          	and	a,#12
3359  0343 1a01          	or	a,(OFST+0,sp)
3360  0345 c75325        	ld	21285,a
3361                     ; 1002     if (TIM3_ICPolarity != TIM3_ICPOLARITY_RISING)
3363  0348 7b02          	ld	a,(OFST+1,sp)
3364  034a 2706          	jreq	L7261
3365                     ; 1004         TIM3->CCER1 |= TIM3_CCER1_CC1P;
3367  034c 72125327      	bset	21287,#1
3369  0350 2004          	jra	L1361
3370  0352               L7261:
3371                     ; 1008         TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1P);
3373  0352 72135327      	bres	21287,#1
3374  0356               L1361:
3375                     ; 1011     TIM3->CCER1 |= TIM3_CCER1_CC1E;
3377  0356 72105327      	bset	21287,#0
3378                     ; 1012 }
3381  035a 5b03          	addw	sp,#3
3382  035c 81            	ret	
3434                     ; 1031 static void TI2_Config(uint8_t TIM3_ICPolarity,
3434                     ; 1032                        uint8_t TIM3_ICSelection,
3434                     ; 1033                        uint8_t TIM3_ICFilter)
3434                     ; 1034 {
3435                     	switch	.text
3436  035d               L5_TI2_Config:
3438  035d 89            	pushw	x
3439       00000001      OFST:	set	1
3442                     ; 1036     TIM3->CCER1 &=  (uint8_t)(~TIM3_CCER1_CC2E);
3444  035e 72195327      	bres	21287,#4
3445  0362 88            	push	a
3446                     ; 1039     TIM3->CCMR2 = (uint8_t)((uint8_t)(TIM3->CCMR2 & (uint8_t)(~( TIM3_CCMR_CCxS |
3446                     ; 1040                   TIM3_CCMR_ICxF    ))) | (uint8_t)(( (TIM3_ICSelection)) | 
3446                     ; 1041                   ((uint8_t)( TIM3_ICFilter << 4))));
3448  0363 7b06          	ld	a,(OFST+5,sp)
3449  0365 97            	ld	xl,a
3450  0366 a610          	ld	a,#16
3451  0368 42            	mul	x,a
3452  0369 9f            	ld	a,xl
3453  036a 1a03          	or	a,(OFST+2,sp)
3454  036c 6b01          	ld	(OFST+0,sp),a
3455  036e c65326        	ld	a,21286
3456  0371 a40c          	and	a,#12
3457  0373 1a01          	or	a,(OFST+0,sp)
3458  0375 c75326        	ld	21286,a
3459                     ; 1044     if (TIM3_ICPolarity != TIM3_ICPOLARITY_RISING)
3461  0378 7b02          	ld	a,(OFST+1,sp)
3462  037a 2706          	jreq	L1661
3463                     ; 1046         TIM3->CCER1 |= TIM3_CCER1_CC2P;
3465  037c 721a5327      	bset	21287,#5
3467  0380 2004          	jra	L3661
3468  0382               L1661:
3469                     ; 1050         TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC2P);
3471  0382 721b5327      	bres	21287,#5
3472  0386               L3661:
3473                     ; 1054     TIM3->CCER1 |= TIM3_CCER1_CC2E;
3475  0386 72185327      	bset	21287,#4
3476                     ; 1056 }
3479  038a 5b03          	addw	sp,#3
3480  038c 81            	ret	
3493                     	xdef	_TIM3_ClearITPendingBit
3494                     	xdef	_TIM3_GetITStatus
3495                     	xdef	_TIM3_ClearFlag
3496                     	xdef	_TIM3_GetFlagStatus
3497                     	xdef	_TIM3_GetPrescaler
3498                     	xdef	_TIM3_GetCounter
3499                     	xdef	_TIM3_GetCapture2
3500                     	xdef	_TIM3_GetCapture1
3501                     	xdef	_TIM3_SetIC2Prescaler
3502                     	xdef	_TIM3_SetIC1Prescaler
3503                     	xdef	_TIM3_SetCompare2
3504                     	xdef	_TIM3_SetCompare1
3505                     	xdef	_TIM3_SetAutoreload
3506                     	xdef	_TIM3_SetCounter
3507                     	xdef	_TIM3_SelectOCxM
3508                     	xdef	_TIM3_CCxCmd
3509                     	xdef	_TIM3_OC2PolarityConfig
3510                     	xdef	_TIM3_OC1PolarityConfig
3511                     	xdef	_TIM3_GenerateEvent
3512                     	xdef	_TIM3_OC2PreloadConfig
3513                     	xdef	_TIM3_OC1PreloadConfig
3514                     	xdef	_TIM3_ARRPreloadConfig
3515                     	xdef	_TIM3_ForcedOC2Config
3516                     	xdef	_TIM3_ForcedOC1Config
3517                     	xdef	_TIM3_PrescalerConfig
3518                     	xdef	_TIM3_SelectOnePulseMode
3519                     	xdef	_TIM3_UpdateRequestConfig
3520                     	xdef	_TIM3_UpdateDisableConfig
3521                     	xdef	_TIM3_ITConfig
3522                     	xdef	_TIM3_Cmd
3523                     	xdef	_TIM3_PWMIConfig
3524                     	xdef	_TIM3_ICInit
3525                     	xdef	_TIM3_OC2Init
3526                     	xdef	_TIM3_OC1Init
3527                     	xdef	_TIM3_TimeBaseInit
3528                     	xdef	_TIM3_DeInit
3547                     	end
