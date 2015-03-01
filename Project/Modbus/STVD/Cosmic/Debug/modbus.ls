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
1240  01ad 522d          	subw	sp,#45
1241       0000002d      OFST:	set	45
1244                     ; 194 uint8_t counter = 0;
1246                     ; 195 uint8_t counter2 = 0 ;
1248  01af 0f03          	clr	(OFST-42,sp)
1249                     ; 196 uint8_t TempSum=0;
1251  01b1 0f2a          	clr	(OFST-3,sp)
1252                     ; 203 uint16_t n = 0;
1254                     ; 206 Input_Registers[0] = 0b111111000101;
1256  01b3 ae0fc5        	ldw	x,#4037
1257  01b6 bf00          	ldw	_Input_Registers,x
1258                     ; 211 RewritingChars(OutputFrame,0,4);
1260  01b8 4b04          	push	#4
1261  01ba 4b00          	push	#0
1262  01bc 96            	ldw	x,sp
1263  01bd 1c0011        	addw	x,#OFST-28
1264  01c0 ad97          	call	_RewritingChars
1266  01c2 b605          	ld	a,_word+5
1267  01c4 85            	popw	x
1268                     ; 214 temp4[0] = word[5];
1270  01c5 6b09          	ld	(OFST-36,sp),a
1271                     ; 215 temp4[1] = word[6];
1273  01c7 b606          	ld	a,_word+6
1274  01c9 6b0a          	ld	(OFST-35,sp),a
1275                     ; 216 temp4[2] = word[7];
1277  01cb b607          	ld	a,_word+7
1278  01cd 6b0b          	ld	(OFST-34,sp),a
1279                     ; 217 temp4[3] = word[8];
1281  01cf b608          	ld	a,_word+8
1282  01d1 6b0c          	ld	(OFST-33,sp),a
1283                     ; 218 HexToByte_4(temp4, &FirstCoil);
1285  01d3 96            	ldw	x,sp
1286  01d4 1c0004        	addw	x,#OFST-41
1287  01d7 89            	pushw	x
1288  01d8 1c0005        	addw	x,#5
1289  01db cd0523        	call	_HexToByte_4
1291  01de b609          	ld	a,_word+9
1292  01e0 85            	popw	x
1293                     ; 221 temp4[0] = word[9];
1295  01e1 6b09          	ld	(OFST-36,sp),a
1296                     ; 222 temp4[1] = word[10];
1298  01e3 b60a          	ld	a,_word+10
1299  01e5 6b0a          	ld	(OFST-35,sp),a
1300                     ; 223 temp4[2] = word[11];
1302  01e7 b60b          	ld	a,_word+11
1303  01e9 6b0b          	ld	(OFST-34,sp),a
1304                     ; 224 temp4[3] = word[12];
1306  01eb b60c          	ld	a,_word+12
1307  01ed 6b0c          	ld	(OFST-33,sp),a
1308                     ; 225 HexToByte_4(temp4, &NumberOfCoils);
1310  01ef 96            	ldw	x,sp
1311  01f0 1c0006        	addw	x,#OFST-39
1312  01f3 89            	pushw	x
1313  01f4 1c0003        	addw	x,#3
1314  01f7 cd0523        	call	_HexToByte_4
1316  01fa 85            	popw	x
1317                     ; 228 if((NumberOfCoils%8)!=0)
1319  01fb 7b07          	ld	a,(OFST-38,sp)
1320  01fd a507          	bcp	a,#7
1321  01ff 2709          	jreq	L145
1322                     ; 230 	NumberOfDataBytes = ( NumberOfCoils/8)+1;
1324  0201 1e06          	ldw	x,(OFST-39,sp)
1325  0203 54            	srlw	x
1326  0204 54            	srlw	x
1327  0205 54            	srlw	x
1328  0206 01            	rrwa	x,a
1329  0207 4c            	inc	a
1331  0208 2006          	jra	L345
1332  020a               L145:
1333                     ; 234 	NumberOfDataBytes = NumberOfCoils/8;
1335  020a 1e06          	ldw	x,(OFST-39,sp)
1336  020c 54            	srlw	x
1337  020d 54            	srlw	x
1338  020e 54            	srlw	x
1339  020f 01            	rrwa	x,a
1340  0210               L345:
1341  0210 6b08          	ld	(OFST-37,sp),a
1342                     ; 238 ByteToHex(temp,NumberOfDataBytes);
1344  0212 88            	push	a
1345  0213 96            	ldw	x,sp
1346  0214 1c002c        	addw	x,#OFST-1
1347  0217 cd00a7        	call	_ByteToHex
1349  021a 84            	pop	a
1350                     ; 239 OutputFrame[5] = temp[0];
1352  021b 7b2b          	ld	a,(OFST-2,sp)
1353  021d 6b14          	ld	(OFST-25,sp),a
1354                     ; 240 OutputFrame[6] = temp[1];
1356  021f 7b2c          	ld	a,(OFST-1,sp)
1357  0221 6b15          	ld	(OFST-24,sp),a
1358                     ; 243 counter = 7; 
1360  0223 a607          	ld	a,#7
1361  0225 6b2d          	ld	(OFST+0,sp),a
1362                     ; 244 Coil = FirstCoil;
1364  0227 1e04          	ldw	x,(OFST-41,sp)
1365  0229 1f28          	ldw	(OFST-5,sp),x
1366                     ; 245 n = NumberOfCoils;
1368  022b 1e06          	ldw	x,(OFST-39,sp)
1369  022d 1f0d          	ldw	(OFST-32,sp),x
1371  022f cc02f8        	jra	L155
1372  0232               L545:
1373                     ; 248 		if(n>=8)                   //    changing 8bits to hex
1375  0232 a30008        	cpw	x,#8
1376  0235 255c          	jrult	L555
1377                     ; 250 						uint8_t pwr = 0;
1379                     ; 251 						for(pwr =0; pwr<8; pwr++,Coil++)
1381  0237 0f02          	clr	(OFST-43,sp)
1382  0239               L755:
1383                     ; 253 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
1385  0239 ae0000        	ldw	x,#_Input_Registers
1386  023c 89            	pushw	x
1387  023d 7b2b          	ld	a,(OFST-2,sp)
1388  023f cd017b        	call	_StateOfCoil
1390  0242 85            	popw	x
1391  0243 6b01          	ld	(OFST-44,sp),a
1392  0245 5f            	clrw	x
1393  0246 7b02          	ld	a,(OFST-43,sp)
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
1404  0253 7b01          	ld	a,(OFST-44,sp)
1405  0255 42            	mul	x,a
1406  0256 9f            	ld	a,xl
1407  0257 1b2a          	add	a,(OFST-3,sp)
1408  0259 6b2a          	ld	(OFST-3,sp),a
1409                     ; 254 								n--;
1411  025b 1e0d          	ldw	x,(OFST-32,sp)
1412  025d 5a            	decw	x
1413  025e 1f0d          	ldw	(OFST-32,sp),x
1414                     ; 251 						for(pwr =0; pwr<8; pwr++,Coil++)
1416  0260 0c02          	inc	(OFST-43,sp)
1417  0262 1e28          	ldw	x,(OFST-5,sp)
1418  0264 5c            	incw	x
1419  0265 1f28          	ldw	(OFST-5,sp),x
1422  0267 7b02          	ld	a,(OFST-43,sp)
1423  0269 a108          	cp	a,#8
1424  026b 25cc          	jrult	L755
1425                     ; 257 						ByteToHex(temp,TempSum);
1427  026d 7b2a          	ld	a,(OFST-3,sp)
1428  026f 88            	push	a
1429  0270 96            	ldw	x,sp
1430  0271 1c002c        	addw	x,#OFST-1
1431  0274 cd00a7        	call	_ByteToHex
1433  0277 84            	pop	a
1434                     ; 258 						TempSum = 0;
1436  0278 0f2a          	clr	(OFST-3,sp)
1437                     ; 259 						OutputFrame[counter] = temp[0];
1439  027a 96            	ldw	x,sp
1440  027b cd0351        	call	LC003
1441  027e 1b2d          	add	a,(OFST+0,sp)
1442  0280 2401          	jrnc	L231
1443  0282 5c            	incw	x
1444  0283               L231:
1445  0283 02            	rlwa	x,a
1446  0284 7b2b          	ld	a,(OFST-2,sp)
1447  0286 f7            	ld	(x),a
1448                     ; 260 						counter++;
1450                     ; 261 						OutputFrame[counter] = temp[1];
1452  0287 96            	ldw	x,sp
1453  0288 0c2d          	inc	(OFST+0,sp)
1454  028a cd0351        	call	LC003
1455  028d 1b2d          	add	a,(OFST+0,sp)
1456  028f 2461          	jrnc	L051
1457                     ; 262 						counter++;
1459  0291 205e          	jp	LC002
1460  0293               L555:
1461                     ; 267 						uint8_t pwr = 0;
1463                     ; 268 						uint8_t zm = n;
1465  0293 7b0e          	ld	a,(OFST-31,sp)
1466  0295 6b08          	ld	(OFST-37,sp),a
1467                     ; 269 						for(pwr =0; pwr<zm; pwr++,Coil++)
1469  0297 0f02          	clr	(OFST-43,sp)
1471  0299 202e          	jra	L375
1472  029b               L765:
1473                     ; 271 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
1475  029b ae0000        	ldw	x,#_Input_Registers
1476  029e 89            	pushw	x
1477  029f 7b2b          	ld	a,(OFST-2,sp)
1478  02a1 cd017b        	call	_StateOfCoil
1480  02a4 85            	popw	x
1481  02a5 6b01          	ld	(OFST-44,sp),a
1482  02a7 5f            	clrw	x
1483  02a8 7b02          	ld	a,(OFST-43,sp)
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
1494  02b5 7b01          	ld	a,(OFST-44,sp)
1495  02b7 42            	mul	x,a
1496  02b8 9f            	ld	a,xl
1497  02b9 1b2a          	add	a,(OFST-3,sp)
1498  02bb 6b2a          	ld	(OFST-3,sp),a
1499                     ; 272 								n--;
1501  02bd 1e0d          	ldw	x,(OFST-32,sp)
1502  02bf 5a            	decw	x
1503  02c0 1f0d          	ldw	(OFST-32,sp),x
1504                     ; 269 						for(pwr =0; pwr<zm; pwr++,Coil++)
1506  02c2 0c02          	inc	(OFST-43,sp)
1507  02c4 1e28          	ldw	x,(OFST-5,sp)
1508  02c6 5c            	incw	x
1509  02c7 1f28          	ldw	(OFST-5,sp),x
1510  02c9               L375:
1513  02c9 7b02          	ld	a,(OFST-43,sp)
1514  02cb 1108          	cp	a,(OFST-37,sp)
1515  02cd 25cc          	jrult	L765
1516                     ; 274 						ByteToHex(temp,TempSum);
1518  02cf 7b2a          	ld	a,(OFST-3,sp)
1519  02d1 88            	push	a
1520  02d2 96            	ldw	x,sp
1521  02d3 1c002c        	addw	x,#OFST-1
1522  02d6 cd00a7        	call	_ByteToHex
1524  02d9 84            	pop	a
1525                     ; 275 						TempSum = 0;
1527  02da 0f2a          	clr	(OFST-3,sp)
1528                     ; 276 						OutputFrame[counter] = temp[0];
1530  02dc 96            	ldw	x,sp
1531  02dd ad72          	call	LC003
1532  02df 1b2d          	add	a,(OFST+0,sp)
1533  02e1 2401          	jrnc	L641
1534  02e3 5c            	incw	x
1535  02e4               L641:
1536  02e4 02            	rlwa	x,a
1537  02e5 7b2b          	ld	a,(OFST-2,sp)
1538  02e7 f7            	ld	(x),a
1539                     ; 277 						counter++;
1541                     ; 278 						OutputFrame[counter] = temp[1];
1543  02e8 96            	ldw	x,sp
1544  02e9 0c2d          	inc	(OFST+0,sp)
1545  02eb ad64          	call	LC003
1546  02ed 1b2d          	add	a,(OFST+0,sp)
1547  02ef 2401          	jrnc	L051
1548  02f1               LC002:
1549  02f1 5c            	incw	x
1550  02f2               L051:
1551                     ; 279 						counter++;
1553  02f2 02            	rlwa	x,a
1554  02f3 7b2c          	ld	a,(OFST-1,sp)
1555  02f5 f7            	ld	(x),a
1557  02f6 0c2d          	inc	(OFST+0,sp)
1558  02f8               L155:
1559                     ; 246 while(n>0)
1561  02f8 1e0d          	ldw	x,(OFST-32,sp)
1562  02fa 2703cc0232    	jrne	L545
1563                     ; 292 ByteToHex(temp,GetLRC(OutputFrame));
1565  02ff 96            	ldw	x,sp
1566  0300 1c000f        	addw	x,#OFST-30
1567  0303 cd04c8        	call	_GetLRC
1569  0306 88            	push	a
1570  0307 96            	ldw	x,sp
1571  0308 1c002c        	addw	x,#OFST-1
1572  030b cd00a7        	call	_ByteToHex
1574  030e 84            	pop	a
1575                     ; 293 OutputFrame[counter] = temp[0];
1577  030f 96            	ldw	x,sp
1578  0310 ad3f          	call	LC003
1579  0312 1b2d          	add	a,(OFST+0,sp)
1580  0314 2401          	jrnc	L651
1581  0316 5c            	incw	x
1582  0317               L651:
1583  0317 02            	rlwa	x,a
1584  0318 7b2b          	ld	a,(OFST-2,sp)
1585  031a f7            	ld	(x),a
1586                     ; 294 counter++;
1588                     ; 295 OutputFrame[counter] = temp[1];
1590  031b 96            	ldw	x,sp
1591  031c 0c2d          	inc	(OFST+0,sp)
1592  031e ad31          	call	LC003
1593  0320 1b2d          	add	a,(OFST+0,sp)
1594  0322 2401          	jrnc	L061
1595  0324 5c            	incw	x
1596  0325               L061:
1597  0325 02            	rlwa	x,a
1598  0326 7b2c          	ld	a,(OFST-1,sp)
1599  0328 f7            	ld	(x),a
1600                     ; 296 counter++;
1602                     ; 297 OutputFrame[counter] = 0x0D;
1604  0329 96            	ldw	x,sp
1605  032a 0c2d          	inc	(OFST+0,sp)
1606  032c ad23          	call	LC003
1607  032e 1b2d          	add	a,(OFST+0,sp)
1608  0330 2401          	jrnc	L261
1609  0332 5c            	incw	x
1610  0333               L261:
1611  0333 02            	rlwa	x,a
1612  0334 a60d          	ld	a,#13
1613  0336 f7            	ld	(x),a
1614                     ; 298 counter++;
1616                     ; 299 OutputFrame[counter] = 0x0A;
1618  0337 96            	ldw	x,sp
1619  0338 0c2d          	inc	(OFST+0,sp)
1620  033a ad15          	call	LC003
1621  033c 1b2d          	add	a,(OFST+0,sp)
1622  033e 2401          	jrnc	L461
1623  0340 5c            	incw	x
1624  0341               L461:
1625  0341 02            	rlwa	x,a
1626  0342 a60a          	ld	a,#10
1627  0344 f7            	ld	(x),a
1628                     ; 300 counter++;
1630                     ; 302 UART_SendStr(OutputFrame); 
1632  0345 96            	ldw	x,sp
1633  0346 0c2d          	inc	(OFST+0,sp)
1634  0348 1c000f        	addw	x,#OFST-30
1635  034b cd0000        	call	_UART_SendStr
1637                     ; 303 }
1640  034e 5b2d          	addw	sp,#45
1641  0350 81            	ret	
1642  0351               LC003:
1643  0351 1c000f        	addw	x,#OFST-30
1644  0354 9f            	ld	a,xl
1645  0355 5e            	swapw	x
1646  0356 81            	ret	
1669                     ; 307 void ReadInputStatus(void)
1669                     ; 308 {
1670                     	switch	.text
1671  0357               _ReadInputStatus:
1675                     ; 311 }
1678  0357 81            	ret	
1805                     ; 314 void ReadHoldingRegisters(void)
1805                     ; 315 {
1806                     	switch	.text
1807  0358               _ReadHoldingRegisters:
1809  0358 5228          	subw	sp,#40
1810       00000028      OFST:	set	40
1813                     ; 320 uint16_t FirstReg = 0;
1815  035a 5f            	clrw	x
1816  035b 1f01          	ldw	(OFST-39,sp),x
1817                     ; 321 uint16_t NumberOfRegs = 0;
1819  035d 1f05          	ldw	(OFST-35,sp),x
1820                     ; 322 uint8_t NumberOfBytes = 0 ;
1822                     ; 323 uint8_t ct = 0;
1824                     ; 324 uint8_t k = 0;
1826                     ; 325 uint8_t counter = 0;
1828                     ; 326 uint16_t Content_dec = 0;
1830                     ; 329 RewritingChars(OutputFrame,0,4);
1832  035f 4b04          	push	#4
1833  0361 4b00          	push	#0
1834  0363 96            	ldw	x,sp
1835  0364 1c000d        	addw	x,#OFST-27
1836  0367 cd0159        	call	_RewritingChars
1838  036a b605          	ld	a,_word+5
1839  036c 85            	popw	x
1840                     ; 332 temp[0] = word[5];
1842  036d 6b24          	ld	(OFST-4,sp),a
1843                     ; 333 temp[1] = word[6];
1845  036f b606          	ld	a,_word+6
1846  0371 6b25          	ld	(OFST-3,sp),a
1847                     ; 334 temp[2] = word[7];
1849  0373 b607          	ld	a,_word+7
1850  0375 6b26          	ld	(OFST-2,sp),a
1851                     ; 335 temp[3] = word[8];
1853  0377 b608          	ld	a,_word+8
1854  0379 6b27          	ld	(OFST-1,sp),a
1855                     ; 336 HexToByte_4(temp, &FirstReg);
1857  037b 96            	ldw	x,sp
1858  037c 5c            	incw	x
1859  037d 89            	pushw	x
1860  037e 1c0023        	addw	x,#35
1861  0381 cd0523        	call	_HexToByte_4
1863  0384 b609          	ld	a,_word+9
1864  0386 85            	popw	x
1865                     ; 339 temp[0] = word[9];
1867  0387 6b24          	ld	(OFST-4,sp),a
1868                     ; 340 temp[1] = word[10];
1870  0389 b60a          	ld	a,_word+10
1871  038b 6b25          	ld	(OFST-3,sp),a
1872                     ; 341 temp[2] = word[11];
1874  038d b60b          	ld	a,_word+11
1875  038f 6b26          	ld	(OFST-2,sp),a
1876                     ; 342 temp[3] = word[12];
1878  0391 b60c          	ld	a,_word+12
1879  0393 6b27          	ld	(OFST-1,sp),a
1880                     ; 343 HexToByte_4(temp, &NumberOfRegs);
1882  0395 96            	ldw	x,sp
1883  0396 1c0005        	addw	x,#OFST-35
1884  0399 89            	pushw	x
1885  039a 1c001f        	addw	x,#31
1886  039d cd0523        	call	_HexToByte_4
1888  03a0 85            	popw	x
1889                     ; 346 NumberOfBytes = NumberOfRegs*2;
1891  03a1 7b06          	ld	a,(OFST-34,sp)
1892  03a3 48            	sll	a
1893  03a4 6b0a          	ld	(OFST-30,sp),a
1894                     ; 349 ByteToHex(temp,NumberOfBytes);
1896  03a6 88            	push	a
1897  03a7 96            	ldw	x,sp
1898  03a8 1c0025        	addw	x,#OFST-3
1899  03ab cd00a7        	call	_ByteToHex
1901  03ae 84            	pop	a
1902                     ; 350 OutputFrame[5] = temp[0];
1904  03af 7b24          	ld	a,(OFST-4,sp)
1905  03b1 6b10          	ld	(OFST-24,sp),a
1906                     ; 351 OutputFrame[6] = temp[1];
1908  03b3 7b25          	ld	a,(OFST-3,sp)
1909  03b5 6b11          	ld	(OFST-23,sp),a
1910                     ; 353 counter = 7;
1912  03b7 a607          	ld	a,#7
1913  03b9 6b28          	ld	(OFST+0,sp),a
1914                     ; 354 k = FirstReg;
1916  03bb 7b02          	ld	a,(OFST-38,sp)
1917  03bd 6b09          	ld	(OFST-31,sp),a
1918                     ; 356 Output_Registers[1] = 65535;
1920  03bf aeffff        	ldw	x,#65535
1921  03c2 bf02          	ldw	_Output_Registers+2,x
1922                     ; 357 Output_Registers[2] = 65535;
1924  03c4 bf04          	ldw	_Output_Registers+4,x
1925                     ; 359 for(ct=0;ct<NumberOfRegs;ct++)
1927  03c6 0f0a          	clr	(OFST-30,sp)
1929  03c8 2050          	jra	L576
1930  03ca               L176:
1931                     ; 361 		Content_dec = Output_Registers[k];
1933  03ca 7b09          	ld	a,(OFST-31,sp)
1934  03cc 5f            	clrw	x
1935  03cd 97            	ld	xl,a
1936  03ce 58            	sllw	x
1937  03cf ee00          	ldw	x,(_Output_Registers,x)
1938  03d1 1f07          	ldw	(OFST-33,sp),x
1939                     ; 362 		ByteToHex_4(temp,Content_dec);
1941  03d3 89            	pushw	x
1942  03d4 96            	ldw	x,sp
1943  03d5 1c0026        	addw	x,#OFST-2
1944  03d8 cd0581        	call	_ByteToHex_4
1946  03db 85            	popw	x
1947                     ; 363 		OutputFrame[counter] = temp[0];
1949  03dc 96            	ldw	x,sp
1950  03dd cd0474        	call	LC004
1951  03e0 1b28          	add	a,(OFST+0,sp)
1952  03e2 2401          	jrnc	L602
1953  03e4 5c            	incw	x
1954  03e5               L602:
1955  03e5 02            	rlwa	x,a
1956  03e6 7b24          	ld	a,(OFST-4,sp)
1957  03e8 f7            	ld	(x),a
1958                     ; 364 		counter++;
1960                     ; 365 		OutputFrame[counter] = temp[1];
1962  03e9 96            	ldw	x,sp
1963  03ea 0c28          	inc	(OFST+0,sp)
1964  03ec cd0474        	call	LC004
1965  03ef 1b28          	add	a,(OFST+0,sp)
1966  03f1 2401          	jrnc	L012
1967  03f3 5c            	incw	x
1968  03f4               L012:
1969  03f4 02            	rlwa	x,a
1970  03f5 7b25          	ld	a,(OFST-3,sp)
1971  03f7 f7            	ld	(x),a
1972                     ; 366 		counter++;
1974                     ; 367 		OutputFrame[counter] = temp[2];
1976  03f8 96            	ldw	x,sp
1977  03f9 0c28          	inc	(OFST+0,sp)
1978  03fb ad77          	call	LC004
1979  03fd 1b28          	add	a,(OFST+0,sp)
1980  03ff 2401          	jrnc	L212
1981  0401 5c            	incw	x
1982  0402               L212:
1983  0402 02            	rlwa	x,a
1984  0403 7b26          	ld	a,(OFST-2,sp)
1985  0405 f7            	ld	(x),a
1986                     ; 368 		counter++;
1988                     ; 369 		OutputFrame[counter] = temp[3];
1990  0406 96            	ldw	x,sp
1991  0407 0c28          	inc	(OFST+0,sp)
1992  0409 ad69          	call	LC004
1993  040b 1b28          	add	a,(OFST+0,sp)
1994  040d 2401          	jrnc	L412
1995  040f 5c            	incw	x
1996  0410               L412:
1997  0410 02            	rlwa	x,a
1998  0411 7b27          	ld	a,(OFST-1,sp)
1999  0413 f7            	ld	(x),a
2000                     ; 370 		counter++;
2002  0414 0c28          	inc	(OFST+0,sp)
2003                     ; 371 		k++;
2005  0416 0c09          	inc	(OFST-31,sp)
2006                     ; 359 for(ct=0;ct<NumberOfRegs;ct++)
2008  0418 0c0a          	inc	(OFST-30,sp)
2009  041a               L576:
2012  041a 7b0a          	ld	a,(OFST-30,sp)
2013  041c 5f            	clrw	x
2014  041d 97            	ld	xl,a
2015  041e 1305          	cpw	x,(OFST-35,sp)
2016  0420 25a8          	jrult	L176
2017                     ; 376 ByteToHex(temp2,GetLRC(OutputFrame));
2019  0422 96            	ldw	x,sp
2020  0423 1c000b        	addw	x,#OFST-29
2021  0426 cd04c8        	call	_GetLRC
2023  0429 88            	push	a
2024  042a 96            	ldw	x,sp
2025  042b 1c0004        	addw	x,#OFST-36
2026  042e cd00a7        	call	_ByteToHex
2028  0431 84            	pop	a
2029                     ; 377 OutputFrame[counter] = temp2[0];
2031  0432 96            	ldw	x,sp
2032  0433 ad3f          	call	LC004
2033  0435 1b28          	add	a,(OFST+0,sp)
2034  0437 2401          	jrnc	L222
2035  0439 5c            	incw	x
2036  043a               L222:
2037  043a 02            	rlwa	x,a
2038  043b 7b03          	ld	a,(OFST-37,sp)
2039  043d f7            	ld	(x),a
2040                     ; 378 counter++;
2042                     ; 379 OutputFrame[counter] = temp2[1];
2044  043e 96            	ldw	x,sp
2045  043f 0c28          	inc	(OFST+0,sp)
2046  0441 ad31          	call	LC004
2047  0443 1b28          	add	a,(OFST+0,sp)
2048  0445 2401          	jrnc	L422
2049  0447 5c            	incw	x
2050  0448               L422:
2051  0448 02            	rlwa	x,a
2052  0449 7b04          	ld	a,(OFST-36,sp)
2053  044b f7            	ld	(x),a
2054                     ; 380 counter++;
2056                     ; 381 OutputFrame[counter] = 0x0D;
2058  044c 96            	ldw	x,sp
2059  044d 0c28          	inc	(OFST+0,sp)
2060  044f ad23          	call	LC004
2061  0451 1b28          	add	a,(OFST+0,sp)
2062  0453 2401          	jrnc	L622
2063  0455 5c            	incw	x
2064  0456               L622:
2065  0456 02            	rlwa	x,a
2066  0457 a60d          	ld	a,#13
2067  0459 f7            	ld	(x),a
2068                     ; 382 counter++;
2070                     ; 383 OutputFrame[counter] = 0x0A;
2072  045a 96            	ldw	x,sp
2073  045b 0c28          	inc	(OFST+0,sp)
2074  045d ad15          	call	LC004
2075  045f 1b28          	add	a,(OFST+0,sp)
2076  0461 2401          	jrnc	L032
2077  0463 5c            	incw	x
2078  0464               L032:
2079  0464 02            	rlwa	x,a
2080  0465 a60a          	ld	a,#10
2081  0467 f7            	ld	(x),a
2082                     ; 384 counter++;
2084                     ; 386 UART_SendStr(OutputFrame); 
2086  0468 96            	ldw	x,sp
2087  0469 0c28          	inc	(OFST+0,sp)
2088  046b 1c000b        	addw	x,#OFST-29
2089  046e cd0000        	call	_UART_SendStr
2091                     ; 388 }
2094  0471 5b28          	addw	sp,#40
2095  0473 81            	ret	
2096  0474               LC004:
2097  0474 1c000b        	addw	x,#OFST-29
2098  0477 9f            	ld	a,xl
2099  0478 5e            	swapw	x
2100  0479 81            	ret	
2123                     ; 389 void ReadInputRegisters(void)
2123                     ; 390 {
2124                     	switch	.text
2125  047a               _ReadInputRegisters:
2129                     ; 393 }
2132  047a 81            	ret	
2155                     ; 394 void ForceSingleCoil(void)
2155                     ; 395 {}
2156                     	switch	.text
2157  047b               _ForceSingleCoil:
2164  047b 81            	ret	
2188                     ; 396 void PresetSingleRegister(void)
2188                     ; 397 {}
2189                     	switch	.text
2190  047c               _PresetSingleRegister:
2197  047c 81            	ret	
2282                     ; 400 bool CheckLRC(char *frame)
2282                     ; 401 {
2283                     	switch	.text
2284  047d               _CheckLRC:
2286  047d 89            	pushw	x
2287  047e 5207          	subw	sp,#7
2288       00000007      OFST:	set	7
2291                     ; 402 	uint8_t a = 0;
2293  0480 0f07          	clr	(OFST+0,sp)
2294                     ; 405 	uint8_t tempSum = 0;
2296  0482 0f01          	clr	(OFST-6,sp)
2297                     ; 407 	uint8_t LRC_calculated = 0;
2299                     ; 409 	uint8_t LRC_dec_from_frame = 0;	
2301  0484 0f02          	clr	(OFST-5,sp)
2303  0486 2002          	jra	L777
2304  0488               L377:
2305                     ; 414 				a++;
2307  0488 0c07          	inc	(OFST+0,sp)
2308  048a               L777:
2309                     ; 412 	while(word[a] != '\r')
2311  048a 7b07          	ld	a,(OFST+0,sp)
2312  048c 5f            	clrw	x
2313  048d 97            	ld	xl,a
2314  048e e600          	ld	a,(_word,x)
2315  0490 a10d          	cp	a,#13
2316  0492 26f4          	jrne	L377
2317                     ; 417 temp[1] = frame[a-1];
2319  0494 7b07          	ld	a,(OFST+0,sp)
2320  0496 5f            	clrw	x
2321  0497 97            	ld	xl,a
2322  0498 5a            	decw	x
2323  0499 72fb08        	addw	x,(OFST+1,sp)
2324  049c f6            	ld	a,(x)
2325  049d 6b04          	ld	(OFST-3,sp),a
2326                     ; 418 temp[0] = frame[a-2];
2328  049f 5f            	clrw	x
2329  04a0 7b07          	ld	a,(OFST+0,sp)
2330  04a2 97            	ld	xl,a
2331  04a3 1d0002        	subw	x,#2
2332  04a6 72fb08        	addw	x,(OFST+1,sp)
2333  04a9 f6            	ld	a,(x)
2334  04aa 6b03          	ld	(OFST-4,sp),a
2335                     ; 420 HexToByte(temp,&LRC_dec_from_frame);
2337  04ac 96            	ldw	x,sp
2338  04ad 1c0002        	addw	x,#OFST-5
2339  04b0 89            	pushw	x
2340  04b1 5c            	incw	x
2341  04b2 cd00df        	call	_HexToByte
2343  04b5 85            	popw	x
2344                     ; 424 LRC_calculated = GetLRC(frame);
2346  04b6 1e08          	ldw	x,(OFST+1,sp)
2347  04b8 ad0e          	call	_GetLRC
2349  04ba 6b07          	ld	(OFST+0,sp),a
2350                     ; 426 if (LRC_calculated == LRC_dec_from_frame)
2352  04bc 1102          	cp	a,(OFST-5,sp)
2353  04be 2604          	jrne	L3001
2354                     ; 429 		return 1;
2356  04c0 a601          	ld	a,#1
2358  04c2 2001          	jra	L052
2359  04c4               L3001:
2360                     ; 433 		return 0;
2362  04c4 4f            	clr	a
2364  04c5               L052:
2366  04c5 5b09          	addw	sp,#9
2367  04c7 81            	ret	
2450                     ; 437 uint8_t GetLRC(char *frame)
2450                     ; 438 {
2451                     	switch	.text
2452  04c8               _GetLRC:
2454  04c8 5206          	subw	sp,#6
2455       00000006      OFST:	set	6
2458                     ; 439 uint8_t a=1;   // 1, because the first char is ':'
2460  04ca a601          	ld	a,#1
2461  04cc 6b06          	ld	(OFST+0,sp),a
2462                     ; 440 uint8_t k=2;
2464  04ce 4c            	inc	a
2465  04cf 6b05          	ld	(OFST-1,sp),a
2466                     ; 442 uint8_t temp_sum=0;
2468  04d1 0f01          	clr	(OFST-5,sp)
2469                     ; 443 uint8_t sum = 0;
2471  04d3 0f02          	clr	(OFST-4,sp)
2473  04d5 2002          	jra	L5501
2474  04d7               L1501:
2475                     ; 448 a++;
2477  04d7 0c06          	inc	(OFST+0,sp)
2478  04d9               L5501:
2479                     ; 446 while((word[a] != '\r')&(word[a] != '*'))
2481  04d9 7b06          	ld	a,(OFST+0,sp)
2482  04db 5f            	clrw	x
2483  04dc 97            	ld	xl,a
2484  04dd e600          	ld	a,(_word,x)
2485  04df a10d          	cp	a,#13
2486  04e1 270a          	jreq	L1601
2488  04e3 7b06          	ld	a,(OFST+0,sp)
2489  04e5 5f            	clrw	x
2490  04e6 97            	ld	xl,a
2491  04e7 e600          	ld	a,(_word,x)
2492  04e9 a12a          	cp	a,#42
2493  04eb 26ea          	jrne	L1501
2494  04ed               L1601:
2495                     ; 450 a = a - 2; 
2497  04ed 0a06          	dec	(OFST+0,sp)
2498  04ef 0a06          	dec	(OFST+0,sp)
2499                     ; 452 for( k; k<a; k+=2)
2502  04f1 2023          	jra	L7601
2503  04f3               L3601:
2504                     ; 454 temp[0] = word[k-1];
2506  04f3 5f            	clrw	x
2507  04f4 97            	ld	xl,a
2508  04f5 5a            	decw	x
2509  04f6 e600          	ld	a,(_word,x)
2510  04f8 6b03          	ld	(OFST-3,sp),a
2511                     ; 455 temp[1] = word[k];
2513  04fa 5f            	clrw	x
2514  04fb 7b05          	ld	a,(OFST-1,sp)
2515  04fd 97            	ld	xl,a
2516  04fe e600          	ld	a,(_word,x)
2517  0500 6b04          	ld	(OFST-2,sp),a
2518                     ; 456 HexToByte(temp, &temp_sum);
2520  0502 96            	ldw	x,sp
2521  0503 5c            	incw	x
2522  0504 89            	pushw	x
2523  0505 1c0002        	addw	x,#2
2524  0508 cd00df        	call	_HexToByte
2526  050b 85            	popw	x
2527                     ; 457 sum += temp_sum;
2529  050c 7b02          	ld	a,(OFST-4,sp)
2530  050e 1b01          	add	a,(OFST-5,sp)
2531  0510 6b02          	ld	(OFST-4,sp),a
2532                     ; 452 for( k; k<a; k+=2)
2534  0512 0c05          	inc	(OFST-1,sp)
2535  0514 0c05          	inc	(OFST-1,sp)
2536  0516               L7601:
2539  0516 7b05          	ld	a,(OFST-1,sp)
2540  0518 1106          	cp	a,(OFST+0,sp)
2541  051a 25d7          	jrult	L3601
2542                     ; 460 sum = (~sum) + 1;
2544  051c 7b02          	ld	a,(OFST-4,sp)
2545  051e 43            	cpl	a
2546  051f 4c            	inc	a
2547                     ; 461 return sum;
2551  0520 5b06          	addw	sp,#6
2552  0522 81            	ret	
2644                     ; 465 void HexToByte_4(char *hexstring_4, uint16_t *byte)
2644                     ; 466 {
2645                     	switch	.text
2646  0523               _HexToByte_4:
2648  0523 89            	pushw	x
2649  0524 5208          	subw	sp,#8
2650       00000008      OFST:	set	8
2653                     ; 468 uint8_t right_dec = 0;
2655  0526 0f01          	clr	(OFST-7,sp)
2656                     ; 469 uint8_t left_dec = 0;
2658  0528 0f02          	clr	(OFST-6,sp)
2659                     ; 470 uint16_t right_dec16 = 0;
2661  052a 5f            	clrw	x
2662  052b 1f03          	ldw	(OFST-5,sp),x
2663                     ; 471 uint16_t left_dec16 = 0;
2665  052d 1f05          	ldw	(OFST-3,sp),x
2666                     ; 473 tempp[0] = hexstring_4[0];
2668  052f 1e09          	ldw	x,(OFST+1,sp)
2669  0531 f6            	ld	a,(x)
2670  0532 6b07          	ld	(OFST-1,sp),a
2671                     ; 474 tempp[1] = hexstring_4[1];
2673  0534 e601          	ld	a,(1,x)
2674  0536 6b08          	ld	(OFST+0,sp),a
2675                     ; 475 HexToByte(tempp,&left_dec);
2677  0538 96            	ldw	x,sp
2678  0539 1c0002        	addw	x,#OFST-6
2679  053c 89            	pushw	x
2680  053d 1c0005        	addw	x,#5
2681  0540 cd00df        	call	_HexToByte
2683  0543 85            	popw	x
2684                     ; 477 tempp[0] = hexstring_4[2];
2686  0544 1e09          	ldw	x,(OFST+1,sp)
2687  0546 e602          	ld	a,(2,x)
2688  0548 6b07          	ld	(OFST-1,sp),a
2689                     ; 478 tempp[1] = hexstring_4[3];
2691  054a e603          	ld	a,(3,x)
2692  054c 6b08          	ld	(OFST+0,sp),a
2693                     ; 479 HexToByte(tempp,&right_dec);
2695  054e 96            	ldw	x,sp
2696  054f 5c            	incw	x
2697  0550 89            	pushw	x
2698  0551 1c0006        	addw	x,#6
2699  0554 cd00df        	call	_HexToByte
2701  0557 85            	popw	x
2702                     ; 481 left_dec16 = left_dec16 | left_dec;
2704  0558 7b02          	ld	a,(OFST-6,sp)
2705  055a 5f            	clrw	x
2706  055b 97            	ld	xl,a
2707  055c 01            	rrwa	x,a
2708  055d 1a06          	or	a,(OFST-2,sp)
2709  055f 01            	rrwa	x,a
2710  0560 1a05          	or	a,(OFST-3,sp)
2711  0562 01            	rrwa	x,a
2712  0563 1f05          	ldw	(OFST-3,sp),x
2713                     ; 482 right_dec16 = right_dec16 | right_dec;
2715  0565 5f            	clrw	x
2716  0566 7b01          	ld	a,(OFST-7,sp)
2717  0568 97            	ld	xl,a
2718  0569 01            	rrwa	x,a
2719  056a 1a04          	or	a,(OFST-4,sp)
2720  056c 01            	rrwa	x,a
2721  056d 1a03          	or	a,(OFST-5,sp)
2722  056f 01            	rrwa	x,a
2723  0570 1f03          	ldw	(OFST-5,sp),x
2724                     ; 484 *byte = (left_dec16 << 8) | right_dec16;
2726  0572 7b04          	ld	a,(OFST-4,sp)
2727  0574 1e05          	ldw	x,(OFST-3,sp)
2728  0576 01            	rrwa	x,a
2729  0577 1a03          	or	a,(OFST-5,sp)
2730  0579 160d          	ldw	y,(OFST+5,sp)
2731  057b 01            	rrwa	x,a
2732  057c 90ff          	ldw	(y),x
2733                     ; 485 }
2736  057e 5b0a          	addw	sp,#10
2737  0580 81            	ret	
2847                     ; 489 void ByteToHex_4(char *hexstring, uint16_t byte)
2847                     ; 490 {
2848                     	switch	.text
2849  0581               _ByteToHex_4:
2851  0581 89            	pushw	x
2852  0582 520b          	subw	sp,#11
2853       0000000b      OFST:	set	11
2856                     ; 493 	uint16_t D1 = byte >> 8;
2858  0584 1e10          	ldw	x,(OFST+5,sp)
2859  0586 4f            	clr	a
2860  0587 01            	rrwa	x,a
2861  0588 1f02          	ldw	(OFST-9,sp),x
2862                     ; 494   uint16_t D2 = byte & 255;
2864  058a 5f            	clrw	x
2865  058b 7b11          	ld	a,(OFST+6,sp)
2866  058d 02            	rlwa	x,a
2867  058e 1f04          	ldw	(OFST-7,sp),x
2868                     ; 495 	uint8_t D1_8 = 0;
2870  0590 0f06          	clr	(OFST-5,sp)
2871                     ; 496 	uint8_t D2_8 = 0;
2873  0592 0f07          	clr	(OFST-4,sp)
2874                     ; 497 	uint8_t ct = 0;
2876  0594 0f01          	clr	(OFST-10,sp)
2877                     ; 499 	D1_8 |= D1;
2879  0596 7b06          	ld	a,(OFST-5,sp)
2880  0598 1a03          	or	a,(OFST-8,sp)
2881  059a 6b06          	ld	(OFST-5,sp),a
2882                     ; 500 	D2_8 |= D2;
2884  059c 7b07          	ld	a,(OFST-4,sp)
2885  059e 1a05          	or	a,(OFST-6,sp)
2886  05a0 6b07          	ld	(OFST-4,sp),a
2887                     ; 502 	ByteToHex(temp1, D1_8);
2889  05a2 7b06          	ld	a,(OFST-5,sp)
2890  05a4 88            	push	a
2891  05a5 96            	ldw	x,sp
2892  05a6 1c0009        	addw	x,#OFST-2
2893  05a9 cd00a7        	call	_ByteToHex
2895  05ac 84            	pop	a
2896                     ; 503 	ByteToHex(temp2, D2_8);
2898  05ad 7b07          	ld	a,(OFST-4,sp)
2899  05af 88            	push	a
2900  05b0 96            	ldw	x,sp
2901  05b1 1c000b        	addw	x,#OFST+0
2902  05b4 cd00a7        	call	_ByteToHex
2904  05b7 84            	pop	a
2905                     ; 505 	hexstring[0] = temp1[0];
2907  05b8 1e0c          	ldw	x,(OFST+1,sp)
2908  05ba 7b08          	ld	a,(OFST-3,sp)
2909  05bc f7            	ld	(x),a
2910                     ; 506 	hexstring[1] = temp1[1];
2912  05bd 7b09          	ld	a,(OFST-2,sp)
2913  05bf e701          	ld	(1,x),a
2914                     ; 507 	hexstring[2] = temp2[0];
2916  05c1 7b0a          	ld	a,(OFST-1,sp)
2917  05c3 e702          	ld	(2,x),a
2918                     ; 508 	hexstring[3] = temp2[1];
2920  05c5 7b0b          	ld	a,(OFST+0,sp)
2921  05c7 e703          	ld	(3,x),a
2922                     ; 510 }
2925  05c9 5b0d          	addw	sp,#13
2926  05cb 81            	ret	
2939                     	xref.b	_Output_Registers
2940                     	xref.b	_Input_Registers
2941                     	xref.b	_word
2942                     	xref.b	_Address
2943                     	xref.b	_TimmingDelay
2944                     	xdef	_StateOfCoil
2945                     	xdef	_RewritingChars
2946                     	xdef	_PresetSingleRegister
2947                     	xdef	_ForceSingleCoil
2948                     	xdef	_ReadInputRegisters
2949                     	xdef	_ReadHoldingRegisters
2950                     	xdef	_ReadInputStatus
2951                     	xdef	_ReadCoilStatus
2952                     	xdef	___checkFunc
2953                     	xdef	___checkAddr
2954                     	xdef	_ByteToHex_4
2955                     	xdef	_GetLRC
2956                     	xdef	_CheckLRC
2957                     	xdef	_SetDevAddr
2958                     	xdef	_HexToByte_4
2959                     	xdef	_HexToByte
2960                     	xdef	_ByteToHex
2961                     	xdef	_UART_SendStr
2962                     	xdef	_Modbus_Init
2963                     	xdef	_Delay
2964                     	xdef	_Delay_Init
2965                     	xref	_UART2_SendData8
2966                     	xref	_UART2_ITConfig
2967                     	xref	_UART2_Cmd
2968                     	xref	_UART2_Init
2969                     	xref	_UART2_DeInit
2970                     	xref	_TIM3_ITConfig
2971                     	xref	_TIM3_Cmd
2972                     	xref	_TIM3_TimeBaseInit
2973                     	xref	_TIM3_DeInit
2974                     	xref	_TIM2_ITConfig
2975                     	xref	_TIM2_Cmd
2976                     	xref	_TIM2_TimeBaseInit
2977                     	xref	_TIM2_DeInit
2978                     	xref	_GPIO_WriteLow
2979                     	xref	_GPIO_WriteHigh
2980                     	xref	_GPIO_Init
2981                     	xref	_GPIO_DeInit
2982                     	xref	_CLK_HSIPrescalerConfig
3001                     	xref	c_lzmp
3002                     	end
