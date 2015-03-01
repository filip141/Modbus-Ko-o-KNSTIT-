   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  62                     ; 5 void UART_SendStr(const char *s)
  62                     ; 6 {
  64                     	switch	.text
  65  0000               _UART_SendStr:
  67  0000 89            	pushw	x
  68       00000000      OFST:	set	0
  71                     ; 8 	GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
  73  0001 4b08          	push	#8
  74  0003 ae5000        	ldw	x,#20480
  75  0006 cd0000        	call	_GPIO_WriteHigh
  77  0009 84            	pop	a
  79  000a 1e01          	ldw	x,(OFST+1,sp)
  80  000c 200d          	jra	L13
  81  000e               L72:
  82                     ; 11 	UART2_SendData8((uint8_t)(*s));
  84  000e cd0000        	call	_UART2_SendData8
  87  0011               L73:
  88                     ; 12 	while ((UART2->SR & UART2_SR_TXE ) != UART2_SR_TXE );
  90  0011 720f5240fb    	btjf	21056,#7,L73
  91                     ; 13 	s++;
  93  0016 1e01          	ldw	x,(OFST+1,sp)
  94  0018 5c            	incw	x
  95  0019 1f01          	ldw	(OFST+1,sp),x
  96  001b               L13:
  97                     ; 9 	while(*s)
  99  001b f6            	ld	a,(x)
 100  001c 26f0          	jrne	L72
 101                     ; 16 	GPIO_WriteLow(GPIOA, GPIO_PIN_3);
 103  001e 4b08          	push	#8
 104  0020 ae5000        	ldw	x,#20480
 105  0023 cd0000        	call	_GPIO_WriteLow
 107  0026 84            	pop	a
 108                     ; 17 }
 111  0027 85            	popw	x
 112  0028 81            	ret	
 147                     ; 20 void Modbus_Init(void)
 147                     ; 21 {
 148                     	switch	.text
 149  0029               _Modbus_Init:
 153                     ; 23 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 155  0029 4f            	clr	a
 156  002a cd0000        	call	_CLK_HSIPrescalerConfig
 158                     ; 25 	TIM2_DeInit();
 160  002d cd0000        	call	_TIM2_DeInit
 162                     ; 26 	GPIO_DeInit(GPIOA);
 164  0030 ae5000        	ldw	x,#20480
 165  0033 cd0000        	call	_GPIO_DeInit
 167                     ; 27 	UART2_DeInit();
 169  0036 cd0000        	call	_UART2_DeInit
 171                     ; 29 	TIM2_TimeBaseInit(TIM2_PRESCALER_2048, 78);
 173  0039 ae004e        	ldw	x,#78
 174  003c 89            	pushw	x
 175  003d a60b          	ld	a,#11
 176  003f cd0000        	call	_TIM2_TimeBaseInit
 178  0042 85            	popw	x
 179                     ; 30 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 181  0043 4be0          	push	#224
 182  0045 4b08          	push	#8
 183  0047 ae5000        	ldw	x,#20480
 184  004a cd0000        	call	_GPIO_Init
 186  004d 85            	popw	x
 187                     ; 31 	UART2_Init(BAUDRATE, UART2_WORDLENGTH_8D, UART2_STOPBITS_2,UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,UART2_MODE_TXRX_ENABLE );  
 189  004e 4b0c          	push	#12
 190  0050 4b80          	push	#128
 191  0052 4b00          	push	#0
 192  0054 4b20          	push	#32
 193  0056 4b00          	push	#0
 194  0058 ae4b00        	ldw	x,#19200
 195  005b 89            	pushw	x
 196  005c 5f            	clrw	x
 197  005d 89            	pushw	x
 198  005e cd0000        	call	_UART2_Init
 200  0061 5b09          	addw	sp,#9
 201                     ; 33 	TIM2_Cmd(ENABLE);
 203  0063 a601          	ld	a,#1
 204  0065 cd0000        	call	_TIM2_Cmd
 206                     ; 34 	UART2_Cmd(ENABLE);
 208  0068 a601          	ld	a,#1
 209  006a cd0000        	call	_UART2_Cmd
 211                     ; 36 	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
 213  006d ae0101        	ldw	x,#257
 214  0070 cd0000        	call	_TIM2_ITConfig
 216                     ; 37 	UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);
 218  0073 4b01          	push	#1
 219  0075 ae0205        	ldw	x,#517
 220  0078 cd0000        	call	_UART2_ITConfig
 222  007b 9a            	rim	
 223  007c 84            	pop	a
 224                     ; 40 	enableInterrupts();
 228                     ; 42 }
 232  007d 81            	ret	
 259                     ; 45 void Delay_Init(void)
 259                     ; 46 {
 260                     	switch	.text
 261  007e               _Delay_Init:
 265                     ; 48 	TIM3_DeInit();
 267  007e cd0000        	call	_TIM3_DeInit
 269                     ; 50 	TIM3_TimeBaseInit(TIM3_PRESCALER_16, 999);
 271  0081 ae03e7        	ldw	x,#999
 272  0084 89            	pushw	x
 273  0085 a604          	ld	a,#4
 274  0087 cd0000        	call	_TIM3_TimeBaseInit
 276  008a a601          	ld	a,#1
 277  008c 85            	popw	x
 278                     ; 52 	TIM3_Cmd(ENABLE);
 280  008d cd0000        	call	_TIM3_Cmd
 282                     ; 54 	TIM3_ITConfig(TIM3_IT_UPDATE, ENABLE);
 284  0090 ae0101        	ldw	x,#257
 286                     ; 59 }
 289  0093 cc0000        	jp	_TIM3_ITConfig
 324                     ; 62 void Delay(uint32_t time)
 324                     ; 63 {
 325                     	switch	.text
 326  0096               _Delay:
 328       00000000      OFST:	set	0
 331                     ; 64 	TimmingDelay = time;
 333  0096 1e05          	ldw	x,(OFST+5,sp)
 334  0098 bf02          	ldw	_TimmingDelay+2,x
 335  009a 1e03          	ldw	x,(OFST+3,sp)
 336  009c bf00          	ldw	_TimmingDelay,x
 338  009e ae0000        	ldw	x,#_TimmingDelay
 339  00a1               L501:
 340                     ; 65 	while(TimmingDelay != 0 );
 342  00a1 cd0000        	call	c_lzmp
 344  00a4 26fb          	jrne	L501
 345                     ; 66 }
 348  00a6 81            	ret	
 428                     ; 69 void ByteToHex(char *hexstring, uint8_t byte)
 428                     ; 70 {
 429                     	switch	.text
 430  00a7               _ByteToHex:
 432  00a7 89            	pushw	x
 433  00a8 5203          	subw	sp,#3
 434       00000003      OFST:	set	3
 437                     ; 73 	uint8_t fchar = (byte & 0b11110000) >> 4 ;
 439  00aa 7b08          	ld	a,(OFST+5,sp)
 440  00ac 4e            	swap	a
 441  00ad a40f          	and	a,#15
 442  00af 6b03          	ld	(OFST+0,sp),a
 443                     ; 74 	uint8_t lchar = (byte & 0b00001111) ; 
 445  00b1 7b08          	ld	a,(OFST+5,sp)
 446  00b3 a40f          	and	a,#15
 447  00b5 6b02          	ld	(OFST-1,sp),a
 448                     ; 76 	if( fchar >= 0 && fchar <= 9 )
 450  00b7 7b03          	ld	a,(OFST+0,sp)
 451  00b9 a10a          	cp	a,#10
 452  00bb 2404          	jruge	L351
 453                     ; 78 		fhex = (char)(fchar+48);
 455  00bd ab30          	add	a,#48
 457  00bf 2002          	jra	L551
 458  00c1               L351:
 459                     ; 82 		fhex = (char)(fchar+55);
 461  00c1 ab37          	add	a,#55
 462  00c3               L551:
 463  00c3 6b01          	ld	(OFST-2,sp),a
 464                     ; 84 		if( lchar >= 0 && lchar <= 9 )
 466  00c5 7b02          	ld	a,(OFST-1,sp)
 467  00c7 a10a          	cp	a,#10
 468  00c9 2404          	jruge	L751
 469                     ; 86 		lhex = (char)(lchar+48);
 471  00cb ab30          	add	a,#48
 473  00cd 2002          	jra	L161
 474  00cf               L751:
 475                     ; 90 		lhex = (char)(lchar+55);
 477  00cf ab37          	add	a,#55
 478  00d1               L161:
 479  00d1 6b03          	ld	(OFST+0,sp),a
 480                     ; 92 	hexstring[0] = fhex;
 482  00d3 1e04          	ldw	x,(OFST+1,sp)
 483  00d5 7b01          	ld	a,(OFST-2,sp)
 484  00d7 f7            	ld	(x),a
 485                     ; 93 	hexstring[1] = lhex;
 487  00d8 7b03          	ld	a,(OFST+0,sp)
 488  00da e701          	ld	(1,x),a
 489                     ; 94 }
 492  00dc 5b05          	addw	sp,#5
 493  00de 81            	ret	
 583                     ; 96 void HexToByte(char *hexstring, uint8_t *byte)
 583                     ; 97 {
 584                     	switch	.text
 585  00df               _HexToByte:
 587  00df 89            	pushw	x
 588  00e0 5205          	subw	sp,#5
 589       00000005      OFST:	set	5
 592                     ; 103 	fhex	= hexstring[0];
 594  00e2 f6            	ld	a,(x)
 595  00e3 6b05          	ld	(OFST+0,sp),a
 596                     ; 104 	lhex = hexstring[1];
 598  00e5 e601          	ld	a,(1,x)
 599  00e7 6b04          	ld	(OFST-1,sp),a
 600                     ; 105 	if( ((int)fhex) >= 48 && ((int)fhex) <= 57 )
 602  00e9 5f            	clrw	x
 603  00ea 7b05          	ld	a,(OFST+0,sp)
 604  00ec 97            	ld	xl,a
 605  00ed a30030        	cpw	x,#48
 606  00f0 2f0b          	jrslt	L132
 608  00f2 5f            	clrw	x
 609  00f3 97            	ld	xl,a
 610  00f4 a3003a        	cpw	x,#58
 611  00f7 2e04          	jrsge	L132
 612                     ; 107 		fchar = ((int)fhex) - 48; 
 614  00f9 a030          	sub	a,#48
 616  00fb 2002          	jra	L332
 617  00fd               L132:
 618                     ; 111 		fchar = ((int)fhex) - 55;
 620  00fd a037          	sub	a,#55
 621  00ff               L332:
 622  00ff 6b03          	ld	(OFST-2,sp),a
 623                     ; 113 		if( ((int)lhex) >= 48 && ((int)lhex) <= 57 )
 625  0101 5f            	clrw	x
 626  0102 7b04          	ld	a,(OFST-1,sp)
 627  0104 97            	ld	xl,a
 628  0105 a30030        	cpw	x,#48
 629  0108 2f0b          	jrslt	L532
 631  010a 5f            	clrw	x
 632  010b 97            	ld	xl,a
 633  010c a3003a        	cpw	x,#58
 634  010f 2e04          	jrsge	L532
 635                     ; 115 		lchar = ((int)lhex) - 48; 
 637  0111 a030          	sub	a,#48
 639  0113 2002          	jra	L732
 640  0115               L532:
 641                     ; 119 		lchar = ((int)lhex) - 55;
 643  0115 a037          	sub	a,#55
 644  0117               L732:
 645  0117 6b05          	ld	(OFST+0,sp),a
 646                     ; 121 	tmpb = ((fchar<<4) | lchar);
 648  0119 7b03          	ld	a,(OFST-2,sp)
 649  011b 97            	ld	xl,a
 650  011c a610          	ld	a,#16
 651  011e 42            	mul	x,a
 652  011f 01            	rrwa	x,a
 653  0120 1a05          	or	a,(OFST+0,sp)
 654  0122 02            	rlwa	x,a
 655  0123 1f01          	ldw	(OFST-4,sp),x
 656                     ; 122 	*byte =  (uint8_t)tmpb; 
 658  0125 1e0a          	ldw	x,(OFST+5,sp)
 659  0127 7b02          	ld	a,(OFST-3,sp)
 660  0129 f7            	ld	(x),a
 661                     ; 124 }
 664  012a 5b07          	addw	sp,#7
 665  012c 81            	ret	
 699                     ; 127 uint8_t __checkAddr(uint8_t address)
 699                     ; 128 {
 700                     	switch	.text
 701  012d               ___checkAddr:
 705                     ; 131 		return 1;
 707  012d a601          	ld	a,#1
 710  012f 81            	ret	
 744                     ; 139 uint8_t __checkFunc(uint8_t Function_Number)
 744                     ; 140 {
 745                     	switch	.text
 746  0130               ___checkFunc:
 750                     ; 141 	if(Function_Number == 1 || Function_Number == 2 || Function_Number == 3 || Function_Number == 5 || Function_Number == 6 || Function_Number == 16)
 752  0130 a101          	cp	a,#1
 753  0132 2714          	jreq	L772
 755  0134 a102          	cp	a,#2
 756  0136 2710          	jreq	L772
 758  0138 a103          	cp	a,#3
 759  013a 270c          	jreq	L772
 761  013c a105          	cp	a,#5
 762  013e 2708          	jreq	L772
 764  0140 a106          	cp	a,#6
 765  0142 2704          	jreq	L772
 767  0144 a110          	cp	a,#16
 768  0146 2603          	jrne	L572
 769  0148               L772:
 770                     ; 143 		return 1;
 772  0148 a601          	ld	a,#1
 775  014a 81            	ret	
 776  014b               L572:
 777                     ; 147 		return 0;
 779  014b 4f            	clr	a
 782  014c 81            	ret	
 818                     ; 151 void SetDevAddr(uint8_t Addr)
 818                     ; 152 {
 819                     	switch	.text
 820  014d               _SetDevAddr:
 822  014d 88            	push	a
 823       00000000      OFST:	set	0
 826                     ; 153 	if(__checkAddr(Addr))
 828  014e addd          	call	___checkAddr
 830  0150 4d            	tnz	a
 831  0151 2704          	jreq	L133
 832                     ; 155 	Address = Addr;
 834  0153 7b01          	ld	a,(OFST+1,sp)
 835  0155 b700          	ld	_Address,a
 836  0157               L133:
 837                     ; 157 }
 840  0157 84            	pop	a
 841  0158 81            	ret	
 895                     ; 159 void RewritingChars(char *destination, uint8_t from, uint8_t to)
 895                     ; 160 {
 896                     	switch	.text
 897  0159               _RewritingChars:
 899  0159 89            	pushw	x
 900       00000000      OFST:	set	0
 903                     ; 161 for(from; from<=to; ++from)
 906  015a 2017          	jra	L563
 907  015c               L163:
 908                     ; 163 	destination[from] = word[from];	
 910  015c 7b01          	ld	a,(OFST+1,sp)
 911  015e 97            	ld	xl,a
 912  015f 7b02          	ld	a,(OFST+2,sp)
 913  0161 1b05          	add	a,(OFST+5,sp)
 914  0163 2401          	jrnc	L67
 915  0165 5c            	incw	x
 916  0166               L67:
 917  0166 02            	rlwa	x,a
 918  0167 7b05          	ld	a,(OFST+5,sp)
 919  0169 905f          	clrw	y
 920  016b 9097          	ld	yl,a
 921  016d 90e600        	ld	a,(_word,y)
 922  0170 f7            	ld	(x),a
 923                     ; 161 for(from; from<=to; ++from)
 925  0171 0c05          	inc	(OFST+5,sp)
 926  0173               L563:
 929  0173 7b05          	ld	a,(OFST+5,sp)
 930  0175 1106          	cp	a,(OFST+6,sp)
 931  0177 23e3          	jrule	L163
 932                     ; 166 }
 935  0179 85            	popw	x
 936  017a 81            	ret	
1019                     ; 171 bool StateOfCoil(uint8_t NumberOfCoil, uint16_t registers[])
1019                     ; 172 {
1020                     	switch	.text
1021  017b               _StateOfCoil:
1023  017b 88            	push	a
1024  017c 5204          	subw	sp,#4
1025       00000004      OFST:	set	4
1028                     ; 174 	uint16_t Value = registers[NumberOfCoil/16];   
1030  017e 5f            	clrw	x
1031  017f 97            	ld	xl,a
1032  0180 57            	sraw	x
1033  0181 57            	sraw	x
1034  0182 57            	sraw	x
1035  0183 57            	sraw	x
1036  0184 58            	sllw	x
1037  0185 72fb08        	addw	x,(OFST+4,sp)
1038  0188 fe            	ldw	x,(x)
1039  0189 1f01          	ldw	(OFST-3,sp),x
1040                     ; 177 	uint16_t Compare = 1<<(NumberOfCoil%16);			
1042  018b ae0001        	ldw	x,#1
1043  018e a40f          	and	a,#15
1044  0190 2704          	jreq	L201
1045  0192               L401:
1046  0192 58            	sllw	x
1047  0193 4a            	dec	a
1048  0194 26fc          	jrne	L401
1049  0196               L201:
1050  0196 1f03          	ldw	(OFST-1,sp),x
1051                     ; 179 	if ((Value & Compare) == Compare  )
1053  0198 1e01          	ldw	x,(OFST-3,sp)
1054  019a 01            	rrwa	x,a
1055  019b 1404          	and	a,(OFST+0,sp)
1056  019d 01            	rrwa	x,a
1057  019e 1403          	and	a,(OFST-1,sp)
1058  01a0 01            	rrwa	x,a
1059  01a1 1303          	cpw	x,(OFST-1,sp)
1060  01a3 2604          	jrne	L334
1061                     ; 181 				return 1;
1063  01a5 a601          	ld	a,#1
1065  01a7 2001          	jra	L601
1066  01a9               L334:
1067                     ; 186 				return 0;
1069  01a9 4f            	clr	a
1071  01aa               L601:
1073  01aa 5b05          	addw	sp,#5
1074  01ac 81            	ret	
1236                     ; 190 void ReadCoilStatus(void)
1236                     ; 191 {
1237                     	switch	.text
1238  01ad               _ReadCoilStatus:
1240  01ad 5223          	subw	sp,#35
1241       00000023      OFST:	set	35
1244                     ; 194 uint8_t counter = 0;
1246                     ; 195 uint8_t counter2 = 0 ;
1248  01af 0f03          	clr	(OFST-32,sp)
1249                     ; 196 uint8_t TempSum=0;
1251  01b1 0f20          	clr	(OFST-3,sp)
1252                     ; 203 uint16_t n = 0;
1254                     ; 206 Input_Registers[0] = 0b111111000101;
1256  01b3 ae0fc5        	ldw	x,#4037
1257  01b6 bf00          	ldw	_Input_Registers,x
1258                     ; 211 RewritingChars(OutputFrame,0,4);
1260  01b8 4b04          	push	#4
1261  01ba 4b00          	push	#0
1262  01bc 96            	ldw	x,sp
1263  01bd 1c0011        	addw	x,#OFST-18
1264  01c0 ad97          	call	_RewritingChars
1266  01c2 b605          	ld	a,_word+5
1267  01c4 85            	popw	x
1268                     ; 214 temp4[0] = word[5];
1270  01c5 6b09          	ld	(OFST-26,sp),a
1271                     ; 215 temp4[1] = word[6];
1273  01c7 b606          	ld	a,_word+6
1274  01c9 6b0a          	ld	(OFST-25,sp),a
1275                     ; 216 temp4[2] = word[7];
1277  01cb b607          	ld	a,_word+7
1278  01cd 6b0b          	ld	(OFST-24,sp),a
1279                     ; 217 temp4[3] = word[8];
1281  01cf b608          	ld	a,_word+8
1282  01d1 6b0c          	ld	(OFST-23,sp),a
1283                     ; 218 HexToByte_4(temp4, &FirstCoil);
1285  01d3 96            	ldw	x,sp
1286  01d4 1c0004        	addw	x,#OFST-31
1287  01d7 89            	pushw	x
1288  01d8 1c0005        	addw	x,#5
1289  01db cd0516        	call	_HexToByte_4
1291  01de b605          	ld	a,_word+5
1292  01e0 85            	popw	x
1293                     ; 221 temp4[0] = word[5];
1295  01e1 6b09          	ld	(OFST-26,sp),a
1296                     ; 222 temp4[1] = word[6];
1298  01e3 b606          	ld	a,_word+6
1299  01e5 6b0a          	ld	(OFST-25,sp),a
1300                     ; 223 temp4[2] = word[7];
1302  01e7 b607          	ld	a,_word+7
1303  01e9 6b0b          	ld	(OFST-24,sp),a
1304                     ; 224 temp4[3] = word[8];
1306  01eb b608          	ld	a,_word+8
1307  01ed 6b0c          	ld	(OFST-23,sp),a
1308                     ; 225 HexToByte_4(temp4, &NumberOfCoils);
1310  01ef 96            	ldw	x,sp
1311  01f0 1c0006        	addw	x,#OFST-29
1312  01f3 89            	pushw	x
1313  01f4 1c0003        	addw	x,#3
1314  01f7 cd0516        	call	_HexToByte_4
1316  01fa 85            	popw	x
1317                     ; 228 if((NumberOfCoils%8)!=0)
1319  01fb 7b07          	ld	a,(OFST-28,sp)
1320  01fd a507          	bcp	a,#7
1321  01ff 2709          	jreq	L145
1322                     ; 230 	NumberOfDataBytes = ( NumberOfCoils/8)+1;
1324  0201 1e06          	ldw	x,(OFST-29,sp)
1325  0203 54            	srlw	x
1326  0204 54            	srlw	x
1327  0205 54            	srlw	x
1328  0206 01            	rrwa	x,a
1329  0207 4c            	inc	a
1331  0208 2006          	jra	L345
1332  020a               L145:
1333                     ; 234 	NumberOfDataBytes = NumberOfCoils/8;
1335  020a 1e06          	ldw	x,(OFST-29,sp)
1336  020c 54            	srlw	x
1337  020d 54            	srlw	x
1338  020e 54            	srlw	x
1339  020f 01            	rrwa	x,a
1340  0210               L345:
1341  0210 6b08          	ld	(OFST-27,sp),a
1342                     ; 238 ByteToHex(temp,NumberOfDataBytes);
1344  0212 88            	push	a
1345  0213 96            	ldw	x,sp
1346  0214 1c0022        	addw	x,#OFST-1
1347  0217 cd00a7        	call	_ByteToHex
1349  021a 84            	pop	a
1350                     ; 239 OutputFrame[5] = temp[0];
1352  021b 7b21          	ld	a,(OFST-2,sp)
1353  021d 6b14          	ld	(OFST-15,sp),a
1354                     ; 240 OutputFrame[6] = temp[1];
1356  021f 7b22          	ld	a,(OFST-1,sp)
1357  0221 6b15          	ld	(OFST-14,sp),a
1358                     ; 243 counter = 7; 
1360  0223 a607          	ld	a,#7
1361  0225 6b23          	ld	(OFST+0,sp),a
1362                     ; 244 Coil = FirstCoil;
1364  0227 1e04          	ldw	x,(OFST-31,sp)
1365  0229 1f1e          	ldw	(OFST-5,sp),x
1366                     ; 245 n = NumberOfCoils;
1368  022b 1e06          	ldw	x,(OFST-29,sp)
1369  022d 1f0d          	ldw	(OFST-22,sp),x
1371  022f cc02f8        	jra	L155
1372  0232               L545:
1373                     ; 248 		if(n>=8)                   //    changing 8bits to hex
1375  0232 a30008        	cpw	x,#8
1376  0235 255c          	jrult	L555
1377                     ; 250 						uint8_t pwr = 0;
1379                     ; 251 						for(pwr =0; pwr<8; pwr++,Coil++)
1381  0237 0f02          	clr	(OFST-33,sp)
1382  0239               L755:
1383                     ; 253 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
1385  0239 ae0000        	ldw	x,#_Input_Registers
1386  023c 89            	pushw	x
1387  023d 7b21          	ld	a,(OFST-2,sp)
1388  023f cd017b        	call	_StateOfCoil
1390  0242 85            	popw	x
1391  0243 6b01          	ld	(OFST-34,sp),a
1392  0245 5f            	clrw	x
1393  0246 7b02          	ld	a,(OFST-33,sp)
1394  0248 97            	ld	xl,a
1395  0249 a601          	ld	a,#1
1396  024b 5d            	tnzw	x
1397  024c 2704          	jreq	L421
1398  024e               L621:
1399  024e 48            	sll	a
1400  024f 5a            	decw	x
1401  0250 26fc          	jrne	L621
1402  0252               L421:
1403  0252 97            	ld	xl,a
1404  0253 7b01          	ld	a,(OFST-34,sp)
1405  0255 42            	mul	x,a
1406  0256 9f            	ld	a,xl
1407  0257 1b20          	add	a,(OFST-3,sp)
1408  0259 6b20          	ld	(OFST-3,sp),a
1409                     ; 254 								n--;
1411  025b 1e0d          	ldw	x,(OFST-22,sp)
1412  025d 5a            	decw	x
1413  025e 1f0d          	ldw	(OFST-22,sp),x
1414                     ; 251 						for(pwr =0; pwr<8; pwr++,Coil++)
1416  0260 0c02          	inc	(OFST-33,sp)
1417  0262 1e1e          	ldw	x,(OFST-5,sp)
1418  0264 5c            	incw	x
1419  0265 1f1e          	ldw	(OFST-5,sp),x
1422  0267 7b02          	ld	a,(OFST-33,sp)
1423  0269 a108          	cp	a,#8
1424  026b 25cc          	jrult	L755
1425                     ; 257 						ByteToHex(temp,TempSum);
1427  026d 7b20          	ld	a,(OFST-3,sp)
1428  026f 88            	push	a
1429  0270 96            	ldw	x,sp
1430  0271 1c0022        	addw	x,#OFST-1
1431  0274 cd00a7        	call	_ByteToHex
1433  0277 84            	pop	a
1434                     ; 258 						TempSum = 0;
1436  0278 0f20          	clr	(OFST-3,sp)
1437                     ; 259 						OutputFrame[counter] = temp[0];
1439  027a 96            	ldw	x,sp
1440  027b cd0351        	call	LC003
1441  027e 1b23          	add	a,(OFST+0,sp)
1442  0280 2401          	jrnc	L231
1443  0282 5c            	incw	x
1444  0283               L231:
1445  0283 02            	rlwa	x,a
1446  0284 7b21          	ld	a,(OFST-2,sp)
1447  0286 f7            	ld	(x),a
1448                     ; 260 						counter++;
1450                     ; 261 						OutputFrame[counter] = temp[1];
1452  0287 96            	ldw	x,sp
1453  0288 0c23          	inc	(OFST+0,sp)
1454  028a cd0351        	call	LC003
1455  028d 1b23          	add	a,(OFST+0,sp)
1456  028f 2461          	jrnc	L051
1457                     ; 262 						counter++;
1459  0291 205e          	jp	LC002
1460  0293               L555:
1461                     ; 267 						uint8_t pwr = 0;
1463                     ; 268 						uint8_t zm = n;
1465  0293 7b0e          	ld	a,(OFST-21,sp)
1466  0295 6b08          	ld	(OFST-27,sp),a
1467                     ; 269 						for(pwr =0; pwr<zm; pwr++,Coil++)
1469  0297 0f02          	clr	(OFST-33,sp)
1471  0299 202e          	jra	L375
1472  029b               L765:
1473                     ; 271 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
1475  029b ae0000        	ldw	x,#_Input_Registers
1476  029e 89            	pushw	x
1477  029f 7b21          	ld	a,(OFST-2,sp)
1478  02a1 cd017b        	call	_StateOfCoil
1480  02a4 85            	popw	x
1481  02a5 6b01          	ld	(OFST-34,sp),a
1482  02a7 5f            	clrw	x
1483  02a8 7b02          	ld	a,(OFST-33,sp)
1484  02aa 97            	ld	xl,a
1485  02ab a601          	ld	a,#1
1486  02ad 5d            	tnzw	x
1487  02ae 2704          	jreq	L041
1488  02b0               L241:
1489  02b0 48            	sll	a
1490  02b1 5a            	decw	x
1491  02b2 26fc          	jrne	L241
1492  02b4               L041:
1493  02b4 97            	ld	xl,a
1494  02b5 7b01          	ld	a,(OFST-34,sp)
1495  02b7 42            	mul	x,a
1496  02b8 9f            	ld	a,xl
1497  02b9 1b20          	add	a,(OFST-3,sp)
1498  02bb 6b20          	ld	(OFST-3,sp),a
1499                     ; 272 								n--;
1501  02bd 1e0d          	ldw	x,(OFST-22,sp)
1502  02bf 5a            	decw	x
1503  02c0 1f0d          	ldw	(OFST-22,sp),x
1504                     ; 269 						for(pwr =0; pwr<zm; pwr++,Coil++)
1506  02c2 0c02          	inc	(OFST-33,sp)
1507  02c4 1e1e          	ldw	x,(OFST-5,sp)
1508  02c6 5c            	incw	x
1509  02c7 1f1e          	ldw	(OFST-5,sp),x
1510  02c9               L375:
1513  02c9 7b02          	ld	a,(OFST-33,sp)
1514  02cb 1108          	cp	a,(OFST-27,sp)
1515  02cd 25cc          	jrult	L765
1516                     ; 274 						ByteToHex(temp,TempSum);
1518  02cf 7b20          	ld	a,(OFST-3,sp)
1519  02d1 88            	push	a
1520  02d2 96            	ldw	x,sp
1521  02d3 1c0022        	addw	x,#OFST-1
1522  02d6 cd00a7        	call	_ByteToHex
1524  02d9 84            	pop	a
1525                     ; 275 						TempSum = 0;
1527  02da 0f20          	clr	(OFST-3,sp)
1528                     ; 276 						OutputFrame[counter] = temp[0];
1530  02dc 96            	ldw	x,sp
1531  02dd ad72          	call	LC003
1532  02df 1b23          	add	a,(OFST+0,sp)
1533  02e1 2401          	jrnc	L641
1534  02e3 5c            	incw	x
1535  02e4               L641:
1536  02e4 02            	rlwa	x,a
1537  02e5 7b21          	ld	a,(OFST-2,sp)
1538  02e7 f7            	ld	(x),a
1539                     ; 277 						counter++;
1541                     ; 278 						OutputFrame[counter] = temp[1];
1543  02e8 96            	ldw	x,sp
1544  02e9 0c23          	inc	(OFST+0,sp)
1545  02eb ad64          	call	LC003
1546  02ed 1b23          	add	a,(OFST+0,sp)
1547  02ef 2401          	jrnc	L051
1548  02f1               LC002:
1549  02f1 5c            	incw	x
1550  02f2               L051:
1551                     ; 279 						counter++;
1553  02f2 02            	rlwa	x,a
1554  02f3 7b22          	ld	a,(OFST-1,sp)
1555  02f5 f7            	ld	(x),a
1557  02f6 0c23          	inc	(OFST+0,sp)
1558  02f8               L155:
1559                     ; 246 while(n>0)
1561  02f8 1e0d          	ldw	x,(OFST-22,sp)
1562  02fa 2703cc0232    	jrne	L545
1563                     ; 292 ByteToHex(temp,GetLRC(OutputFrame));
1565  02ff 96            	ldw	x,sp
1566  0300 1c000f        	addw	x,#OFST-20
1567  0303 cd04bb        	call	_GetLRC
1569  0306 88            	push	a
1570  0307 96            	ldw	x,sp
1571  0308 1c0022        	addw	x,#OFST-1
1572  030b cd00a7        	call	_ByteToHex
1574  030e 84            	pop	a
1575                     ; 293 OutputFrame[counter] = temp[0];
1577  030f 96            	ldw	x,sp
1578  0310 ad3f          	call	LC003
1579  0312 1b23          	add	a,(OFST+0,sp)
1580  0314 2401          	jrnc	L651
1581  0316 5c            	incw	x
1582  0317               L651:
1583  0317 02            	rlwa	x,a
1584  0318 7b21          	ld	a,(OFST-2,sp)
1585  031a f7            	ld	(x),a
1586                     ; 294 counter++;
1588                     ; 295 OutputFrame[counter] = temp[1];
1590  031b 96            	ldw	x,sp
1591  031c 0c23          	inc	(OFST+0,sp)
1592  031e ad31          	call	LC003
1593  0320 1b23          	add	a,(OFST+0,sp)
1594  0322 2401          	jrnc	L061
1595  0324 5c            	incw	x
1596  0325               L061:
1597  0325 02            	rlwa	x,a
1598  0326 7b22          	ld	a,(OFST-1,sp)
1599  0328 f7            	ld	(x),a
1600                     ; 296 counter++;
1602                     ; 297 OutputFrame[counter] = 0x0D;
1604  0329 96            	ldw	x,sp
1605  032a 0c23          	inc	(OFST+0,sp)
1606  032c ad23          	call	LC003
1607  032e 1b23          	add	a,(OFST+0,sp)
1608  0330 2401          	jrnc	L261
1609  0332 5c            	incw	x
1610  0333               L261:
1611  0333 02            	rlwa	x,a
1612  0334 a60d          	ld	a,#13
1613  0336 f7            	ld	(x),a
1614                     ; 298 counter++;
1616                     ; 299 OutputFrame[counter] = 0x0A;
1618  0337 96            	ldw	x,sp
1619  0338 0c23          	inc	(OFST+0,sp)
1620  033a ad15          	call	LC003
1621  033c 1b23          	add	a,(OFST+0,sp)
1622  033e 2401          	jrnc	L461
1623  0340 5c            	incw	x
1624  0341               L461:
1625  0341 02            	rlwa	x,a
1626  0342 a60a          	ld	a,#10
1627  0344 f7            	ld	(x),a
1628                     ; 300 counter++;
1630                     ; 302 UART_SendStr(OutputFrame); 
1632  0345 96            	ldw	x,sp
1633  0346 0c23          	inc	(OFST+0,sp)
1634  0348 1c000f        	addw	x,#OFST-20
1635  034b cd0000        	call	_UART_SendStr
1637                     ; 303 }
1640  034e 5b23          	addw	sp,#35
1641  0350 81            	ret	
1642  0351               LC003:
1643  0351 1c000f        	addw	x,#OFST-20
1644  0354 9f            	ld	a,xl
1645  0355 5e            	swapw	x
1646  0356 81            	ret	
1669                     ; 307 void ReadInputStatus(void)
1669                     ; 308 {
1670                     	switch	.text
1671  0357               _ReadInputStatus:
1675                     ; 311 }
1678  0357 81            	ret	
1786                     ; 314 void ReadHoldingRegisters(void)
1786                     ; 315 {
1787                     	switch	.text
1788  0358               _ReadHoldingRegisters:
1790  0358 521b          	subw	sp,#27
1791       0000001b      OFST:	set	27
1794                     ; 319 uint16_t FirstReg = 0;
1796  035a 5f            	clrw	x
1797  035b 1f01          	ldw	(OFST-26,sp),x
1798                     ; 320 uint16_t NumberOfRegs = 0;
1800  035d 1f03          	ldw	(OFST-24,sp),x
1801                     ; 321 uint8_t NumberOfBytes = 0 ;
1803                     ; 322 uint8_t ct = 0;
1805                     ; 323 uint8_t counter = 0;
1807                     ; 324 uint16_t Content_dec = 0;
1809                     ; 327 RewritingChars(OutputFrame,0,4);
1811  035f 4b04          	push	#4
1812  0361 4b00          	push	#0
1813  0363 96            	ldw	x,sp
1814  0364 1c000a        	addw	x,#OFST-17
1815  0367 cd0159        	call	_RewritingChars
1817  036a b605          	ld	a,_word+5
1818  036c 85            	popw	x
1819                     ; 330 temp[0] = word[5];
1821  036d 6b17          	ld	(OFST-4,sp),a
1822                     ; 331 temp[1] = word[6];
1824  036f b606          	ld	a,_word+6
1825  0371 6b18          	ld	(OFST-3,sp),a
1826                     ; 332 temp[2] = word[7];
1828  0373 b607          	ld	a,_word+7
1829  0375 6b19          	ld	(OFST-2,sp),a
1830                     ; 333 temp[3] = word[8];
1832  0377 b608          	ld	a,_word+8
1833  0379 6b1a          	ld	(OFST-1,sp),a
1834                     ; 334 HexToByte_4(temp, &FirstReg);
1836  037b 96            	ldw	x,sp
1837  037c 5c            	incw	x
1838  037d 89            	pushw	x
1839  037e 1c0016        	addw	x,#22
1840  0381 cd0516        	call	_HexToByte_4
1842  0384 b605          	ld	a,_word+5
1843  0386 85            	popw	x
1844                     ; 337 temp[0] = word[5];
1846  0387 6b17          	ld	(OFST-4,sp),a
1847                     ; 338 temp[1] = word[6];
1849  0389 b606          	ld	a,_word+6
1850  038b 6b18          	ld	(OFST-3,sp),a
1851                     ; 339 temp[2] = word[7];
1853  038d b607          	ld	a,_word+7
1854  038f 6b19          	ld	(OFST-2,sp),a
1855                     ; 340 temp[3] = word[8];
1857  0391 b608          	ld	a,_word+8
1858  0393 6b1a          	ld	(OFST-1,sp),a
1859                     ; 341 HexToByte_4(temp, &NumberOfRegs);
1861  0395 96            	ldw	x,sp
1862  0396 1c0003        	addw	x,#OFST-24
1863  0399 89            	pushw	x
1864  039a 1c0014        	addw	x,#20
1865  039d cd0516        	call	_HexToByte_4
1867  03a0 85            	popw	x
1868                     ; 344 NumberOfBytes = NumberOfRegs*2;
1870  03a1 7b04          	ld	a,(OFST-23,sp)
1871  03a3 48            	sll	a
1872  03a4 6b07          	ld	(OFST-20,sp),a
1873                     ; 347 ByteToHex(temp,NumberOfBytes);
1875  03a6 88            	push	a
1876  03a7 96            	ldw	x,sp
1877  03a8 1c0018        	addw	x,#OFST-3
1878  03ab cd00a7        	call	_ByteToHex
1880  03ae 84            	pop	a
1881                     ; 348 OutputFrame[5] = temp[0];
1883  03af 7b17          	ld	a,(OFST-4,sp)
1884  03b1 6b0d          	ld	(OFST-14,sp),a
1885                     ; 349 OutputFrame[6] = temp[1];
1887  03b3 7b18          	ld	a,(OFST-3,sp)
1888  03b5 6b0e          	ld	(OFST-13,sp),a
1889                     ; 351 counter = 7;
1891  03b7 a607          	ld	a,#7
1892  03b9 6b1b          	ld	(OFST+0,sp),a
1893                     ; 354 for(ct=FirstReg;ct<NumberOfRegs;ct++)
1895  03bb 7b02          	ld	a,(OFST-25,sp)
1896  03bd 6b07          	ld	(OFST-20,sp),a
1898  03bf 204e          	jra	L566
1899  03c1               L166:
1900                     ; 356 		Content_dec = Output_Registers[ct];
1902  03c1 5f            	clrw	x
1903  03c2 97            	ld	xl,a
1904  03c3 58            	sllw	x
1905  03c4 ee00          	ldw	x,(_Output_Registers,x)
1906  03c6 1f05          	ldw	(OFST-22,sp),x
1907                     ; 357 		ByteToHex_4(temp,Content_dec);
1909  03c8 89            	pushw	x
1910  03c9 96            	ldw	x,sp
1911  03ca 1c0019        	addw	x,#OFST-2
1912  03cd cd0574        	call	_ByteToHex_4
1914  03d0 85            	popw	x
1915                     ; 358 		OutputFrame[counter] = temp[0];
1917  03d1 96            	ldw	x,sp
1918  03d2 cd0467        	call	LC004
1919  03d5 1b1b          	add	a,(OFST+0,sp)
1920  03d7 2401          	jrnc	L602
1921  03d9 5c            	incw	x
1922  03da               L602:
1923  03da 02            	rlwa	x,a
1924  03db 7b17          	ld	a,(OFST-4,sp)
1925  03dd f7            	ld	(x),a
1926                     ; 359 		counter++;
1928                     ; 360 		OutputFrame[counter] = temp[1];
1930  03de 96            	ldw	x,sp
1931  03df 0c1b          	inc	(OFST+0,sp)
1932  03e1 cd0467        	call	LC004
1933  03e4 1b1b          	add	a,(OFST+0,sp)
1934  03e6 2401          	jrnc	L012
1935  03e8 5c            	incw	x
1936  03e9               L012:
1937  03e9 02            	rlwa	x,a
1938  03ea 7b18          	ld	a,(OFST-3,sp)
1939  03ec f7            	ld	(x),a
1940                     ; 361 		counter++;
1942                     ; 362 		OutputFrame[counter] = temp[2];
1944  03ed 96            	ldw	x,sp
1945  03ee 0c1b          	inc	(OFST+0,sp)
1946  03f0 ad75          	call	LC004
1947  03f2 1b1b          	add	a,(OFST+0,sp)
1948  03f4 2401          	jrnc	L212
1949  03f6 5c            	incw	x
1950  03f7               L212:
1951  03f7 02            	rlwa	x,a
1952  03f8 7b19          	ld	a,(OFST-2,sp)
1953  03fa f7            	ld	(x),a
1954                     ; 363 		counter++;
1956                     ; 364 		OutputFrame[counter] = temp[3];
1958  03fb 96            	ldw	x,sp
1959  03fc 0c1b          	inc	(OFST+0,sp)
1960  03fe ad67          	call	LC004
1961  0400 1b1b          	add	a,(OFST+0,sp)
1962  0402 2401          	jrnc	L412
1963  0404 5c            	incw	x
1964  0405               L412:
1965  0405 02            	rlwa	x,a
1966  0406 7b1a          	ld	a,(OFST-1,sp)
1967  0408 f7            	ld	(x),a
1968                     ; 365 		counter++;
1970  0409 0c1b          	inc	(OFST+0,sp)
1971                     ; 354 for(ct=FirstReg;ct<NumberOfRegs;ct++)
1973  040b 0c07          	inc	(OFST-20,sp)
1974  040d 7b07          	ld	a,(OFST-20,sp)
1975  040f               L566:
1978  040f 5f            	clrw	x
1979  0410 97            	ld	xl,a
1980  0411 1303          	cpw	x,(OFST-24,sp)
1981  0413 25ac          	jrult	L166
1982                     ; 370 ByteToHex(temp,GetLRC(OutputFrame));
1984  0415 96            	ldw	x,sp
1985  0416 1c0008        	addw	x,#OFST-19
1986  0419 cd04bb        	call	_GetLRC
1988  041c 88            	push	a
1989  041d 96            	ldw	x,sp
1990  041e 1c0018        	addw	x,#OFST-3
1991  0421 cd00a7        	call	_ByteToHex
1993  0424 84            	pop	a
1994                     ; 371 OutputFrame[counter] = temp[0];
1996  0425 96            	ldw	x,sp
1997  0426 ad3f          	call	LC004
1998  0428 1b1b          	add	a,(OFST+0,sp)
1999  042a 2401          	jrnc	L222
2000  042c 5c            	incw	x
2001  042d               L222:
2002  042d 02            	rlwa	x,a
2003  042e 7b17          	ld	a,(OFST-4,sp)
2004  0430 f7            	ld	(x),a
2005                     ; 372 counter++;
2007                     ; 373 OutputFrame[counter] = temp[1];
2009  0431 96            	ldw	x,sp
2010  0432 0c1b          	inc	(OFST+0,sp)
2011  0434 ad31          	call	LC004
2012  0436 1b1b          	add	a,(OFST+0,sp)
2013  0438 2401          	jrnc	L422
2014  043a 5c            	incw	x
2015  043b               L422:
2016  043b 02            	rlwa	x,a
2017  043c 7b18          	ld	a,(OFST-3,sp)
2018  043e f7            	ld	(x),a
2019                     ; 374 counter++;
2021                     ; 375 OutputFrame[counter] = 0x0D;
2023  043f 96            	ldw	x,sp
2024  0440 0c1b          	inc	(OFST+0,sp)
2025  0442 ad23          	call	LC004
2026  0444 1b1b          	add	a,(OFST+0,sp)
2027  0446 2401          	jrnc	L622
2028  0448 5c            	incw	x
2029  0449               L622:
2030  0449 02            	rlwa	x,a
2031  044a a60d          	ld	a,#13
2032  044c f7            	ld	(x),a
2033                     ; 376 counter++;
2035                     ; 377 OutputFrame[counter] = 0x0A;
2037  044d 96            	ldw	x,sp
2038  044e 0c1b          	inc	(OFST+0,sp)
2039  0450 ad15          	call	LC004
2040  0452 1b1b          	add	a,(OFST+0,sp)
2041  0454 2401          	jrnc	L032
2042  0456 5c            	incw	x
2043  0457               L032:
2044  0457 02            	rlwa	x,a
2045  0458 a60a          	ld	a,#10
2046  045a f7            	ld	(x),a
2047                     ; 378 counter++;
2049                     ; 380 UART_SendStr(OutputFrame); 
2051  045b 96            	ldw	x,sp
2052  045c 0c1b          	inc	(OFST+0,sp)
2053  045e 1c0008        	addw	x,#OFST-19
2054  0461 cd0000        	call	_UART_SendStr
2056                     ; 382 }
2059  0464 5b1b          	addw	sp,#27
2060  0466 81            	ret	
2061  0467               LC004:
2062  0467 1c0008        	addw	x,#OFST-19
2063  046a 9f            	ld	a,xl
2064  046b 5e            	swapw	x
2065  046c 81            	ret	
2088                     ; 383 void ReadInputRegisters(void)
2088                     ; 384 {
2089                     	switch	.text
2090  046d               _ReadInputRegisters:
2094                     ; 387 }
2097  046d 81            	ret	
2120                     ; 388 void ForceSingleCoil(void)
2120                     ; 389 {}
2121                     	switch	.text
2122  046e               _ForceSingleCoil:
2129  046e 81            	ret	
2153                     ; 390 void PresetSingleRegister(void)
2153                     ; 391 {}
2154                     	switch	.text
2155  046f               _PresetSingleRegister:
2162  046f 81            	ret	
2247                     ; 394 bool CheckLRC(char *frame)
2247                     ; 395 {
2248                     	switch	.text
2249  0470               _CheckLRC:
2251  0470 89            	pushw	x
2252  0471 5207          	subw	sp,#7
2253       00000007      OFST:	set	7
2256                     ; 396 	uint8_t a = 0;
2258  0473 0f07          	clr	(OFST+0,sp)
2259                     ; 399 	uint8_t tempSum = 0;
2261  0475 0f01          	clr	(OFST-6,sp)
2262                     ; 401 	uint8_t LRC_calculated = 0;
2264                     ; 403 	uint8_t LRC_dec_from_frame = 0;	
2266  0477 0f02          	clr	(OFST-5,sp)
2268  0479 2002          	jra	L767
2269  047b               L367:
2270                     ; 408 				a++;
2272  047b 0c07          	inc	(OFST+0,sp)
2273  047d               L767:
2274                     ; 406 	while(word[a] != '\r')
2276  047d 7b07          	ld	a,(OFST+0,sp)
2277  047f 5f            	clrw	x
2278  0480 97            	ld	xl,a
2279  0481 e600          	ld	a,(_word,x)
2280  0483 a10d          	cp	a,#13
2281  0485 26f4          	jrne	L367
2282                     ; 411 temp[1] = frame[a-1];
2284  0487 7b07          	ld	a,(OFST+0,sp)
2285  0489 5f            	clrw	x
2286  048a 97            	ld	xl,a
2287  048b 5a            	decw	x
2288  048c 72fb08        	addw	x,(OFST+1,sp)
2289  048f f6            	ld	a,(x)
2290  0490 6b04          	ld	(OFST-3,sp),a
2291                     ; 412 temp[0] = frame[a-2];
2293  0492 5f            	clrw	x
2294  0493 7b07          	ld	a,(OFST+0,sp)
2295  0495 97            	ld	xl,a
2296  0496 1d0002        	subw	x,#2
2297  0499 72fb08        	addw	x,(OFST+1,sp)
2298  049c f6            	ld	a,(x)
2299  049d 6b03          	ld	(OFST-4,sp),a
2300                     ; 414 HexToByte(temp,&LRC_dec_from_frame);
2302  049f 96            	ldw	x,sp
2303  04a0 1c0002        	addw	x,#OFST-5
2304  04a3 89            	pushw	x
2305  04a4 5c            	incw	x
2306  04a5 cd00df        	call	_HexToByte
2308  04a8 85            	popw	x
2309                     ; 418 LRC_calculated = GetLRC(frame);
2311  04a9 1e08          	ldw	x,(OFST+1,sp)
2312  04ab ad0e          	call	_GetLRC
2314  04ad 6b07          	ld	(OFST+0,sp),a
2315                     ; 420 if (LRC_calculated == LRC_dec_from_frame)
2317  04af 1102          	cp	a,(OFST-5,sp)
2318  04b1 2604          	jrne	L377
2319                     ; 423 		return 1;
2321  04b3 a601          	ld	a,#1
2323  04b5 2001          	jra	L052
2324  04b7               L377:
2325                     ; 427 		return 0;
2327  04b7 4f            	clr	a
2329  04b8               L052:
2331  04b8 5b09          	addw	sp,#9
2332  04ba 81            	ret	
2415                     ; 431 uint8_t GetLRC(char *frame)
2415                     ; 432 {
2416                     	switch	.text
2417  04bb               _GetLRC:
2419  04bb 5206          	subw	sp,#6
2420       00000006      OFST:	set	6
2423                     ; 433 uint8_t a=1;   // 1, because the first char is ':'
2425  04bd a601          	ld	a,#1
2426  04bf 6b06          	ld	(OFST+0,sp),a
2427                     ; 434 uint8_t k=2;
2429  04c1 4c            	inc	a
2430  04c2 6b05          	ld	(OFST-1,sp),a
2431                     ; 436 uint8_t temp_sum=0;
2433  04c4 0f01          	clr	(OFST-5,sp)
2434                     ; 437 uint8_t sum = 0;
2436  04c6 0f02          	clr	(OFST-4,sp)
2438  04c8 2002          	jra	L5401
2439  04ca               L1401:
2440                     ; 442 a++;
2442  04ca 0c06          	inc	(OFST+0,sp)
2443  04cc               L5401:
2444                     ; 440 while((word[a] != '\r')&(word[a] != '*'))
2446  04cc 7b06          	ld	a,(OFST+0,sp)
2447  04ce 5f            	clrw	x
2448  04cf 97            	ld	xl,a
2449  04d0 e600          	ld	a,(_word,x)
2450  04d2 a10d          	cp	a,#13
2451  04d4 270a          	jreq	L1501
2453  04d6 7b06          	ld	a,(OFST+0,sp)
2454  04d8 5f            	clrw	x
2455  04d9 97            	ld	xl,a
2456  04da e600          	ld	a,(_word,x)
2457  04dc a12a          	cp	a,#42
2458  04de 26ea          	jrne	L1401
2459  04e0               L1501:
2460                     ; 444 a = a - 2; 
2462  04e0 0a06          	dec	(OFST+0,sp)
2463  04e2 0a06          	dec	(OFST+0,sp)
2464                     ; 446 for( k; k<a; k+=2)
2467  04e4 2023          	jra	L7501
2468  04e6               L3501:
2469                     ; 448 temp[0] = word[k-1];
2471  04e6 5f            	clrw	x
2472  04e7 97            	ld	xl,a
2473  04e8 5a            	decw	x
2474  04e9 e600          	ld	a,(_word,x)
2475  04eb 6b03          	ld	(OFST-3,sp),a
2476                     ; 449 temp[1] = word[k];
2478  04ed 5f            	clrw	x
2479  04ee 7b05          	ld	a,(OFST-1,sp)
2480  04f0 97            	ld	xl,a
2481  04f1 e600          	ld	a,(_word,x)
2482  04f3 6b04          	ld	(OFST-2,sp),a
2483                     ; 450 HexToByte(temp, &temp_sum);
2485  04f5 96            	ldw	x,sp
2486  04f6 5c            	incw	x
2487  04f7 89            	pushw	x
2488  04f8 1c0002        	addw	x,#2
2489  04fb cd00df        	call	_HexToByte
2491  04fe 85            	popw	x
2492                     ; 451 sum += temp_sum;
2494  04ff 7b02          	ld	a,(OFST-4,sp)
2495  0501 1b01          	add	a,(OFST-5,sp)
2496  0503 6b02          	ld	(OFST-4,sp),a
2497                     ; 446 for( k; k<a; k+=2)
2499  0505 0c05          	inc	(OFST-1,sp)
2500  0507 0c05          	inc	(OFST-1,sp)
2501  0509               L7501:
2504  0509 7b05          	ld	a,(OFST-1,sp)
2505  050b 1106          	cp	a,(OFST+0,sp)
2506  050d 25d7          	jrult	L3501
2507                     ; 454 sum = (~sum) + 1;
2509  050f 7b02          	ld	a,(OFST-4,sp)
2510  0511 43            	cpl	a
2511  0512 4c            	inc	a
2512                     ; 455 return sum;
2516  0513 5b06          	addw	sp,#6
2517  0515 81            	ret	
2609                     ; 459 void HexToByte_4(char *hexstring_4, uint16_t *byte)
2609                     ; 460 {
2610                     	switch	.text
2611  0516               _HexToByte_4:
2613  0516 89            	pushw	x
2614  0517 5208          	subw	sp,#8
2615       00000008      OFST:	set	8
2618                     ; 462 uint8_t right_dec = 0;
2620  0519 0f01          	clr	(OFST-7,sp)
2621                     ; 463 uint8_t left_dec = 0;
2623  051b 0f02          	clr	(OFST-6,sp)
2624                     ; 464 uint16_t right_dec16 = 0;
2626  051d 5f            	clrw	x
2627  051e 1f03          	ldw	(OFST-5,sp),x
2628                     ; 465 uint16_t left_dec16 = 0;
2630  0520 1f05          	ldw	(OFST-3,sp),x
2631                     ; 467 tempp[0] = hexstring_4[0];
2633  0522 1e09          	ldw	x,(OFST+1,sp)
2634  0524 f6            	ld	a,(x)
2635  0525 6b07          	ld	(OFST-1,sp),a
2636                     ; 468 tempp[1] = hexstring_4[1];
2638  0527 e601          	ld	a,(1,x)
2639  0529 6b08          	ld	(OFST+0,sp),a
2640                     ; 469 HexToByte(tempp,&left_dec);
2642  052b 96            	ldw	x,sp
2643  052c 1c0002        	addw	x,#OFST-6
2644  052f 89            	pushw	x
2645  0530 1c0005        	addw	x,#5
2646  0533 cd00df        	call	_HexToByte
2648  0536 85            	popw	x
2649                     ; 471 tempp[0] = hexstring_4[2];
2651  0537 1e09          	ldw	x,(OFST+1,sp)
2652  0539 e602          	ld	a,(2,x)
2653  053b 6b07          	ld	(OFST-1,sp),a
2654                     ; 472 tempp[1] = hexstring_4[3];
2656  053d e603          	ld	a,(3,x)
2657  053f 6b08          	ld	(OFST+0,sp),a
2658                     ; 473 HexToByte(tempp,&right_dec);
2660  0541 96            	ldw	x,sp
2661  0542 5c            	incw	x
2662  0543 89            	pushw	x
2663  0544 1c0006        	addw	x,#6
2664  0547 cd00df        	call	_HexToByte
2666  054a 85            	popw	x
2667                     ; 475 left_dec16 = left_dec16 | left_dec;
2669  054b 7b02          	ld	a,(OFST-6,sp)
2670  054d 5f            	clrw	x
2671  054e 97            	ld	xl,a
2672  054f 01            	rrwa	x,a
2673  0550 1a06          	or	a,(OFST-2,sp)
2674  0552 01            	rrwa	x,a
2675  0553 1a05          	or	a,(OFST-3,sp)
2676  0555 01            	rrwa	x,a
2677  0556 1f05          	ldw	(OFST-3,sp),x
2678                     ; 476 right_dec16 = right_dec16 | right_dec;
2680  0558 5f            	clrw	x
2681  0559 7b01          	ld	a,(OFST-7,sp)
2682  055b 97            	ld	xl,a
2683  055c 01            	rrwa	x,a
2684  055d 1a04          	or	a,(OFST-4,sp)
2685  055f 01            	rrwa	x,a
2686  0560 1a03          	or	a,(OFST-5,sp)
2687  0562 01            	rrwa	x,a
2688  0563 1f03          	ldw	(OFST-5,sp),x
2689                     ; 478 *byte = (left_dec16 << 8) | right_dec16;
2691  0565 7b04          	ld	a,(OFST-4,sp)
2692  0567 1e05          	ldw	x,(OFST-3,sp)
2693  0569 01            	rrwa	x,a
2694  056a 1a03          	or	a,(OFST-5,sp)
2695  056c 160d          	ldw	y,(OFST+5,sp)
2696  056e 01            	rrwa	x,a
2697  056f 90ff          	ldw	(y),x
2698                     ; 479 }
2701  0571 5b0a          	addw	sp,#10
2702  0573 81            	ret	
2812                     ; 483 void ByteToHex_4(char *hexstring, uint16_t byte)
2812                     ; 484 {
2813                     	switch	.text
2814  0574               _ByteToHex_4:
2816  0574 89            	pushw	x
2817  0575 520b          	subw	sp,#11
2818       0000000b      OFST:	set	11
2821                     ; 487 	uint16_t D1 = byte >> 8;
2823  0577 1e10          	ldw	x,(OFST+5,sp)
2824  0579 4f            	clr	a
2825  057a 01            	rrwa	x,a
2826  057b 1f02          	ldw	(OFST-9,sp),x
2827                     ; 488   uint16_t D2 = byte & 255;
2829  057d 5f            	clrw	x
2830  057e 7b11          	ld	a,(OFST+6,sp)
2831  0580 02            	rlwa	x,a
2832  0581 1f04          	ldw	(OFST-7,sp),x
2833                     ; 489 	uint8_t D1_8 = 0;
2835  0583 0f06          	clr	(OFST-5,sp)
2836                     ; 490 	uint8_t D2_8 = 0;
2838  0585 0f07          	clr	(OFST-4,sp)
2839                     ; 491 	uint8_t ct = 0;
2841  0587 0f01          	clr	(OFST-10,sp)
2842                     ; 493 	D1_8 |= D1;
2844  0589 7b06          	ld	a,(OFST-5,sp)
2845  058b 1a03          	or	a,(OFST-8,sp)
2846  058d 6b06          	ld	(OFST-5,sp),a
2847                     ; 494 	D2_8 |= D2;
2849  058f 7b07          	ld	a,(OFST-4,sp)
2850  0591 1a05          	or	a,(OFST-6,sp)
2851  0593 6b07          	ld	(OFST-4,sp),a
2852                     ; 496 	ByteToHex(temp1, D1_8);
2854  0595 7b06          	ld	a,(OFST-5,sp)
2855  0597 88            	push	a
2856  0598 96            	ldw	x,sp
2857  0599 1c0009        	addw	x,#OFST-2
2858  059c cd00a7        	call	_ByteToHex
2860  059f 84            	pop	a
2861                     ; 497 	ByteToHex(temp2, D2_8);
2863  05a0 7b07          	ld	a,(OFST-4,sp)
2864  05a2 88            	push	a
2865  05a3 96            	ldw	x,sp
2866  05a4 1c000b        	addw	x,#OFST+0
2867  05a7 cd00a7        	call	_ByteToHex
2869  05aa 84            	pop	a
2870                     ; 499 	hexstring[0] = temp1[0];
2872  05ab 1e0c          	ldw	x,(OFST+1,sp)
2873  05ad 7b08          	ld	a,(OFST-3,sp)
2874  05af f7            	ld	(x),a
2875                     ; 500 	hexstring[1] = temp1[1];
2877  05b0 7b09          	ld	a,(OFST-2,sp)
2878  05b2 e701          	ld	(1,x),a
2879                     ; 501 	hexstring[2] = temp2[0];
2881  05b4 7b0a          	ld	a,(OFST-1,sp)
2882  05b6 e702          	ld	(2,x),a
2883                     ; 502 	hexstring[3] = temp2[1];
2885  05b8 7b0b          	ld	a,(OFST+0,sp)
2886  05ba e703          	ld	(3,x),a
2887                     ; 504 }
2890  05bc 5b0d          	addw	sp,#13
2891  05be 81            	ret	
2904                     	xref.b	_Output_Registers
2905                     	xref.b	_Input_Registers
2906                     	xref.b	_word
2907                     	xref.b	_Address
2908                     	xref.b	_TimmingDelay
2909                     	xdef	_StateOfCoil
2910                     	xdef	_RewritingChars
2911                     	xdef	_PresetSingleRegister
2912                     	xdef	_ForceSingleCoil
2913                     	xdef	_ReadInputRegisters
2914                     	xdef	_ReadHoldingRegisters
2915                     	xdef	_ReadInputStatus
2916                     	xdef	_ReadCoilStatus
2917                     	xdef	___checkFunc
2918                     	xdef	___checkAddr
2919                     	xdef	_ByteToHex_4
2920                     	xdef	_GetLRC
2921                     	xdef	_CheckLRC
2922                     	xdef	_SetDevAddr
2923                     	xdef	_HexToByte_4
2924                     	xdef	_HexToByte
2925                     	xdef	_ByteToHex
2926                     	xdef	_UART_SendStr
2927                     	xdef	_Modbus_Init
2928                     	xdef	_Delay
2929                     	xdef	_Delay_Init
2930                     	xref	_UART2_SendData8
2931                     	xref	_UART2_ITConfig
2932                     	xref	_UART2_Cmd
2933                     	xref	_UART2_Init
2934                     	xref	_UART2_DeInit
2935                     	xref	_TIM3_ITConfig
2936                     	xref	_TIM3_Cmd
2937                     	xref	_TIM3_TimeBaseInit
2938                     	xref	_TIM3_DeInit
2939                     	xref	_TIM2_ITConfig
2940                     	xref	_TIM2_Cmd
2941                     	xref	_TIM2_TimeBaseInit
2942                     	xref	_TIM2_DeInit
2943                     	xref	_GPIO_WriteLow
2944                     	xref	_GPIO_WriteHigh
2945                     	xref	_GPIO_Init
2946                     	xref	_GPIO_DeInit
2947                     	xref	_CLK_HSIPrescalerConfig
2966                     	xref	c_lzmp
2967                     	end
