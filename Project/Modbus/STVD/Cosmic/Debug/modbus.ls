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
1226                     ; 190 void ReadCoilStatus(void)
1226                     ; 191 {
1227                     	switch	.text
1228  01ad               _ReadCoilStatus:
1230  01ad 521b          	subw	sp,#27
1231       0000001b      OFST:	set	27
1234                     ; 194 uint8_t counter = 0;
1236                     ; 195 uint8_t counter2 = 0 ;
1238  01af 0f03          	clr	(OFST-24,sp)
1239                     ; 196 uint8_t TempSum=0;
1241  01b1 0f18          	clr	(OFST-3,sp)
1242                     ; 202 uint8_t n = 0;
1244                     ; 205 Input_Registers[0] = 0b111111000101;
1246  01b3 ae0fc5        	ldw	x,#4037
1247  01b6 bf00          	ldw	_Input_Registers,x
1248                     ; 210 RewritingChars(OutputFrame,0,4);
1250  01b8 4b04          	push	#4
1251  01ba 4b00          	push	#0
1252  01bc 96            	ldw	x,sp
1253  01bd 1c000a        	addw	x,#OFST-17
1254  01c0 ad97          	call	_RewritingChars
1256  01c2 b607          	ld	a,_word+7
1257  01c4 85            	popw	x
1258                     ; 213 temp[0] = word[7];
1260  01c5 6b19          	ld	(OFST-2,sp),a
1261                     ; 214 temp[1] = word[8];
1263  01c7 b608          	ld	a,_word+8
1264  01c9 6b1a          	ld	(OFST-1,sp),a
1265                     ; 215 HexToByte(temp, &FirstCoil);
1267  01cb 96            	ldw	x,sp
1268  01cc 1c0004        	addw	x,#OFST-23
1269  01cf 89            	pushw	x
1270  01d0 1c0015        	addw	x,#21
1271  01d3 cd00df        	call	_HexToByte
1273  01d6 b60b          	ld	a,_word+11
1274  01d8 85            	popw	x
1275                     ; 218 temp[0] = word[11];
1277  01d9 6b19          	ld	(OFST-2,sp),a
1278                     ; 219 temp[1] = word[12];
1280  01db b60c          	ld	a,_word+12
1281  01dd 6b1a          	ld	(OFST-1,sp),a
1282                     ; 220 HexToByte(temp, &NumberOfCoils);
1284  01df 96            	ldw	x,sp
1285  01e0 1c0005        	addw	x,#OFST-22
1286  01e3 89            	pushw	x
1287  01e4 1c0014        	addw	x,#20
1288  01e7 cd00df        	call	_HexToByte
1290  01ea 85            	popw	x
1291                     ; 223 if((NumberOfCoils%8)!=0)
1293  01eb 7b05          	ld	a,(OFST-22,sp)
1294  01ed a507          	bcp	a,#7
1295  01ef 2709          	jreq	L535
1296                     ; 225 	NumberOfDataBytes = ( NumberOfCoils/8)+1;
1298  01f1 5f            	clrw	x
1299  01f2 97            	ld	xl,a
1300  01f3 57            	sraw	x
1301  01f4 57            	sraw	x
1302  01f5 57            	sraw	x
1303  01f6 01            	rrwa	x,a
1304  01f7 4c            	inc	a
1306  01f8 2006          	jra	L735
1307  01fa               L535:
1308                     ; 229 	NumberOfDataBytes = NumberOfCoils/8;
1310  01fa 5f            	clrw	x
1311  01fb 97            	ld	xl,a
1312  01fc 57            	sraw	x
1313  01fd 57            	sraw	x
1314  01fe 57            	sraw	x
1315  01ff 01            	rrwa	x,a
1316  0200               L735:
1317  0200 6b06          	ld	(OFST-21,sp),a
1318                     ; 233 ByteToHex(temp,NumberOfDataBytes);
1320  0202 88            	push	a
1321  0203 96            	ldw	x,sp
1322  0204 1c001a        	addw	x,#OFST-1
1323  0207 cd00a7        	call	_ByteToHex
1325  020a 84            	pop	a
1326                     ; 234 OutputFrame[5] = temp[0];
1328  020b 7b19          	ld	a,(OFST-2,sp)
1329  020d 6b0d          	ld	(OFST-14,sp),a
1330                     ; 235 OutputFrame[6] = temp[1];
1332  020f 7b1a          	ld	a,(OFST-1,sp)
1333  0211 6b0e          	ld	(OFST-13,sp),a
1334                     ; 238 counter = 7; 
1336  0213 a607          	ld	a,#7
1337  0215 6b1b          	ld	(OFST+0,sp),a
1338                     ; 239 Coil = FirstCoil;
1340  0217 7b04          	ld	a,(OFST-23,sp)
1341  0219 6b17          	ld	(OFST-4,sp),a
1342                     ; 240 n = NumberOfCoils;
1344  021b 7b05          	ld	a,(OFST-22,sp)
1345  021d 6b07          	ld	(OFST-20,sp),a
1347  021f cc02d9        	jra	L545
1348  0222               L145:
1349                     ; 243 		if(n>=8)                   //    changing 8bits to hex
1351  0222 a108          	cp	a,#8
1352  0224 2556          	jrult	L155
1353                     ; 245 						uint8_t pwr = 0;
1355                     ; 246 						for(pwr =0; pwr<8; pwr++,Coil++)
1357  0226 0f02          	clr	(OFST-25,sp)
1358  0228               L355:
1359                     ; 248 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
1361  0228 ae0000        	ldw	x,#_Input_Registers
1362  022b 89            	pushw	x
1363  022c 7b19          	ld	a,(OFST-2,sp)
1364  022e cd017b        	call	_StateOfCoil
1366  0231 85            	popw	x
1367  0232 6b01          	ld	(OFST-26,sp),a
1368  0234 5f            	clrw	x
1369  0235 7b02          	ld	a,(OFST-25,sp)
1370  0237 97            	ld	xl,a
1371  0238 a601          	ld	a,#1
1372  023a 5d            	tnzw	x
1373  023b 2704          	jreq	L421
1374  023d               L621:
1375  023d 48            	sll	a
1376  023e 5a            	decw	x
1377  023f 26fc          	jrne	L621
1378  0241               L421:
1379  0241 97            	ld	xl,a
1380  0242 7b01          	ld	a,(OFST-26,sp)
1381  0244 42            	mul	x,a
1382  0245 9f            	ld	a,xl
1383  0246 1b18          	add	a,(OFST-3,sp)
1384  0248 6b18          	ld	(OFST-3,sp),a
1385                     ; 249 								n--;
1387  024a 0a07          	dec	(OFST-20,sp)
1388                     ; 246 						for(pwr =0; pwr<8; pwr++,Coil++)
1390  024c 0c02          	inc	(OFST-25,sp)
1391  024e 0c17          	inc	(OFST-4,sp)
1394  0250 7b02          	ld	a,(OFST-25,sp)
1395  0252 a108          	cp	a,#8
1396  0254 25d2          	jrult	L355
1397                     ; 252 						ByteToHex(temp,TempSum);
1399  0256 7b18          	ld	a,(OFST-3,sp)
1400  0258 88            	push	a
1401  0259 96            	ldw	x,sp
1402  025a 1c001a        	addw	x,#OFST-1
1403  025d cd00a7        	call	_ByteToHex
1405  0260 84            	pop	a
1406                     ; 253 						TempSum = 0;
1408  0261 0f18          	clr	(OFST-3,sp)
1409                     ; 254 						OutputFrame[counter] = temp[0];
1411  0263 96            	ldw	x,sp
1412  0264 cd0332        	call	LC003
1413  0267 1b1b          	add	a,(OFST+0,sp)
1414  0269 2401          	jrnc	L231
1415  026b 5c            	incw	x
1416  026c               L231:
1417  026c 02            	rlwa	x,a
1418  026d 7b19          	ld	a,(OFST-2,sp)
1419  026f f7            	ld	(x),a
1420                     ; 255 						counter++;
1422                     ; 256 						OutputFrame[counter] = temp[1];
1424  0270 96            	ldw	x,sp
1425  0271 0c1b          	inc	(OFST+0,sp)
1426  0273 cd0332        	call	LC003
1427  0276 1b1b          	add	a,(OFST+0,sp)
1428  0278 2459          	jrnc	L051
1429                     ; 257 						counter++;
1431  027a 2056          	jp	LC002
1432  027c               L155:
1433                     ; 262 						uint8_t pwr = 0;
1435                     ; 263 						uint8_t zm = n;
1437  027c 6b06          	ld	(OFST-21,sp),a
1438                     ; 264 						for(pwr =0; pwr<zm; pwr++,Coil++)
1440  027e 0f02          	clr	(OFST-25,sp)
1442  0280 2028          	jra	L765
1443  0282               L365:
1444                     ; 266 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
1446  0282 ae0000        	ldw	x,#_Input_Registers
1447  0285 89            	pushw	x
1448  0286 7b19          	ld	a,(OFST-2,sp)
1449  0288 cd017b        	call	_StateOfCoil
1451  028b 85            	popw	x
1452  028c 6b01          	ld	(OFST-26,sp),a
1453  028e 5f            	clrw	x
1454  028f 7b02          	ld	a,(OFST-25,sp)
1455  0291 97            	ld	xl,a
1456  0292 a601          	ld	a,#1
1457  0294 5d            	tnzw	x
1458  0295 2704          	jreq	L041
1459  0297               L241:
1460  0297 48            	sll	a
1461  0298 5a            	decw	x
1462  0299 26fc          	jrne	L241
1463  029b               L041:
1464  029b 97            	ld	xl,a
1465  029c 7b01          	ld	a,(OFST-26,sp)
1466  029e 42            	mul	x,a
1467  029f 9f            	ld	a,xl
1468  02a0 1b18          	add	a,(OFST-3,sp)
1469  02a2 6b18          	ld	(OFST-3,sp),a
1470                     ; 267 								n--;
1472  02a4 0a07          	dec	(OFST-20,sp)
1473                     ; 264 						for(pwr =0; pwr<zm; pwr++,Coil++)
1475  02a6 0c02          	inc	(OFST-25,sp)
1476  02a8 0c17          	inc	(OFST-4,sp)
1477  02aa               L765:
1480  02aa 7b02          	ld	a,(OFST-25,sp)
1481  02ac 1106          	cp	a,(OFST-21,sp)
1482  02ae 25d2          	jrult	L365
1483                     ; 269 						ByteToHex(temp,TempSum);
1485  02b0 7b18          	ld	a,(OFST-3,sp)
1486  02b2 88            	push	a
1487  02b3 96            	ldw	x,sp
1488  02b4 1c001a        	addw	x,#OFST-1
1489  02b7 cd00a7        	call	_ByteToHex
1491  02ba 84            	pop	a
1492                     ; 270 						TempSum = 0;
1494  02bb 0f18          	clr	(OFST-3,sp)
1495                     ; 271 						OutputFrame[counter] = temp[0];
1497  02bd 96            	ldw	x,sp
1498  02be ad72          	call	LC003
1499  02c0 1b1b          	add	a,(OFST+0,sp)
1500  02c2 2401          	jrnc	L641
1501  02c4 5c            	incw	x
1502  02c5               L641:
1503  02c5 02            	rlwa	x,a
1504  02c6 7b19          	ld	a,(OFST-2,sp)
1505  02c8 f7            	ld	(x),a
1506                     ; 272 						counter++;
1508                     ; 273 						OutputFrame[counter] = temp[1];
1510  02c9 96            	ldw	x,sp
1511  02ca 0c1b          	inc	(OFST+0,sp)
1512  02cc ad64          	call	LC003
1513  02ce 1b1b          	add	a,(OFST+0,sp)
1514  02d0 2401          	jrnc	L051
1515  02d2               LC002:
1516  02d2 5c            	incw	x
1517  02d3               L051:
1518                     ; 274 						counter++;
1520  02d3 02            	rlwa	x,a
1521  02d4 7b1a          	ld	a,(OFST-1,sp)
1522  02d6 f7            	ld	(x),a
1524  02d7 0c1b          	inc	(OFST+0,sp)
1525  02d9               L545:
1526                     ; 241 while(n>0)
1528  02d9 7b07          	ld	a,(OFST-20,sp)
1529  02db 2703cc0222    	jrne	L145
1530                     ; 287 ByteToHex(temp,GetLRC(OutputFrame));
1532  02e0 96            	ldw	x,sp
1533  02e1 1c0008        	addw	x,#OFST-19
1534  02e4 cd049c        	call	_GetLRC
1536  02e7 88            	push	a
1537  02e8 96            	ldw	x,sp
1538  02e9 1c001a        	addw	x,#OFST-1
1539  02ec cd00a7        	call	_ByteToHex
1541  02ef 84            	pop	a
1542                     ; 288 OutputFrame[counter] = temp[0];
1544  02f0 96            	ldw	x,sp
1545  02f1 ad3f          	call	LC003
1546  02f3 1b1b          	add	a,(OFST+0,sp)
1547  02f5 2401          	jrnc	L651
1548  02f7 5c            	incw	x
1549  02f8               L651:
1550  02f8 02            	rlwa	x,a
1551  02f9 7b19          	ld	a,(OFST-2,sp)
1552  02fb f7            	ld	(x),a
1553                     ; 289 counter++;
1555                     ; 290 OutputFrame[counter] = temp[1];
1557  02fc 96            	ldw	x,sp
1558  02fd 0c1b          	inc	(OFST+0,sp)
1559  02ff ad31          	call	LC003
1560  0301 1b1b          	add	a,(OFST+0,sp)
1561  0303 2401          	jrnc	L061
1562  0305 5c            	incw	x
1563  0306               L061:
1564  0306 02            	rlwa	x,a
1565  0307 7b1a          	ld	a,(OFST-1,sp)
1566  0309 f7            	ld	(x),a
1567                     ; 291 counter++;
1569                     ; 292 OutputFrame[counter] = 0x0D;
1571  030a 96            	ldw	x,sp
1572  030b 0c1b          	inc	(OFST+0,sp)
1573  030d ad23          	call	LC003
1574  030f 1b1b          	add	a,(OFST+0,sp)
1575  0311 2401          	jrnc	L261
1576  0313 5c            	incw	x
1577  0314               L261:
1578  0314 02            	rlwa	x,a
1579  0315 a60d          	ld	a,#13
1580  0317 f7            	ld	(x),a
1581                     ; 293 counter++;
1583                     ; 294 OutputFrame[counter] = 0x0A;
1585  0318 96            	ldw	x,sp
1586  0319 0c1b          	inc	(OFST+0,sp)
1587  031b ad15          	call	LC003
1588  031d 1b1b          	add	a,(OFST+0,sp)
1589  031f 2401          	jrnc	L461
1590  0321 5c            	incw	x
1591  0322               L461:
1592  0322 02            	rlwa	x,a
1593  0323 a60a          	ld	a,#10
1594  0325 f7            	ld	(x),a
1595                     ; 295 counter++;
1597                     ; 297 UART_SendStr(OutputFrame); 
1599  0326 96            	ldw	x,sp
1600  0327 0c1b          	inc	(OFST+0,sp)
1601  0329 1c0008        	addw	x,#OFST-19
1602  032c cd0000        	call	_UART_SendStr
1604                     ; 298 }
1607  032f 5b1b          	addw	sp,#27
1608  0331 81            	ret	
1609  0332               LC003:
1610  0332 1c0008        	addw	x,#OFST-19
1611  0335 9f            	ld	a,xl
1612  0336 5e            	swapw	x
1613  0337 81            	ret	
1636                     ; 302 void ReadInputStatus(void)
1636                     ; 303 {
1637                     	switch	.text
1638  0338               _ReadInputStatus:
1642                     ; 306 }
1645  0338 81            	ret	
1753                     ; 309 void ReadHoldingRegisters(void)
1753                     ; 310 {
1754                     	switch	.text
1755  0339               _ReadHoldingRegisters:
1757  0339 521b          	subw	sp,#27
1758       0000001b      OFST:	set	27
1761                     ; 314 uint16_t FirstReg = 0;
1763  033b 5f            	clrw	x
1764  033c 1f01          	ldw	(OFST-26,sp),x
1765                     ; 315 uint16_t NumberOfRegs = 0;
1767  033e 1f03          	ldw	(OFST-24,sp),x
1768                     ; 316 uint8_t NumberOfBytes = 0 ;
1770                     ; 317 uint8_t ct = 0;
1772                     ; 318 uint8_t counter = 0;
1774                     ; 319 uint16_t Content_dec = 0;
1776                     ; 322 RewritingChars(OutputFrame,0,4);
1778  0340 4b04          	push	#4
1779  0342 4b00          	push	#0
1780  0344 96            	ldw	x,sp
1781  0345 1c000a        	addw	x,#OFST-17
1782  0348 cd0159        	call	_RewritingChars
1784  034b b605          	ld	a,_word+5
1785  034d 85            	popw	x
1786                     ; 325 temp[0] = word[5];
1788  034e 6b17          	ld	(OFST-4,sp),a
1789                     ; 326 temp[1] = word[6];
1791  0350 b606          	ld	a,_word+6
1792  0352 6b18          	ld	(OFST-3,sp),a
1793                     ; 327 temp[2] = word[7];
1795  0354 b607          	ld	a,_word+7
1796  0356 6b19          	ld	(OFST-2,sp),a
1797                     ; 328 temp[3] = word[8];
1799  0358 b608          	ld	a,_word+8
1800  035a 6b1a          	ld	(OFST-1,sp),a
1801                     ; 329 HexToByte_4(temp, &FirstReg);
1803  035c 96            	ldw	x,sp
1804  035d 5c            	incw	x
1805  035e 89            	pushw	x
1806  035f 1c0016        	addw	x,#22
1807  0362 cd04f7        	call	_HexToByte_4
1809  0365 b605          	ld	a,_word+5
1810  0367 85            	popw	x
1811                     ; 332 temp[0] = word[5];
1813  0368 6b17          	ld	(OFST-4,sp),a
1814                     ; 333 temp[1] = word[6];
1816  036a b606          	ld	a,_word+6
1817  036c 6b18          	ld	(OFST-3,sp),a
1818                     ; 334 temp[2] = word[7];
1820  036e b607          	ld	a,_word+7
1821  0370 6b19          	ld	(OFST-2,sp),a
1822                     ; 335 temp[3] = word[8];
1824  0372 b608          	ld	a,_word+8
1825  0374 6b1a          	ld	(OFST-1,sp),a
1826                     ; 336 HexToByte_4(temp, &NumberOfRegs);
1828  0376 96            	ldw	x,sp
1829  0377 1c0003        	addw	x,#OFST-24
1830  037a 89            	pushw	x
1831  037b 1c0014        	addw	x,#20
1832  037e cd04f7        	call	_HexToByte_4
1834  0381 85            	popw	x
1835                     ; 339 NumberOfBytes = NumberOfRegs*2;
1837  0382 7b04          	ld	a,(OFST-23,sp)
1838  0384 48            	sll	a
1839  0385 6b07          	ld	(OFST-20,sp),a
1840                     ; 342 ByteToHex(temp,NumberOfBytes);
1842  0387 88            	push	a
1843  0388 96            	ldw	x,sp
1844  0389 1c0018        	addw	x,#OFST-3
1845  038c cd00a7        	call	_ByteToHex
1847  038f 84            	pop	a
1848                     ; 343 OutputFrame[5] = temp[0];
1850  0390 7b17          	ld	a,(OFST-4,sp)
1851  0392 6b0d          	ld	(OFST-14,sp),a
1852                     ; 344 OutputFrame[6] = temp[1];
1854  0394 7b18          	ld	a,(OFST-3,sp)
1855  0396 6b0e          	ld	(OFST-13,sp),a
1856                     ; 346 counter = 7;
1858  0398 a607          	ld	a,#7
1859  039a 6b1b          	ld	(OFST+0,sp),a
1860                     ; 349 for(ct=FirstReg;ct<NumberOfRegs;ct++)
1862  039c 7b02          	ld	a,(OFST-25,sp)
1863  039e 6b07          	ld	(OFST-20,sp),a
1865  03a0 204e          	jra	L166
1866  03a2               L556:
1867                     ; 351 		Content_dec = Output_Registers[ct];
1869  03a2 5f            	clrw	x
1870  03a3 97            	ld	xl,a
1871  03a4 58            	sllw	x
1872  03a5 ee00          	ldw	x,(_Output_Registers,x)
1873  03a7 1f05          	ldw	(OFST-22,sp),x
1874                     ; 352 		ByteToHex_4(temp,Content_dec);
1876  03a9 89            	pushw	x
1877  03aa 96            	ldw	x,sp
1878  03ab 1c0019        	addw	x,#OFST-2
1879  03ae cd0555        	call	_ByteToHex_4
1881  03b1 85            	popw	x
1882                     ; 353 		OutputFrame[counter] = temp[0];
1884  03b2 96            	ldw	x,sp
1885  03b3 cd0448        	call	LC004
1886  03b6 1b1b          	add	a,(OFST+0,sp)
1887  03b8 2401          	jrnc	L602
1888  03ba 5c            	incw	x
1889  03bb               L602:
1890  03bb 02            	rlwa	x,a
1891  03bc 7b17          	ld	a,(OFST-4,sp)
1892  03be f7            	ld	(x),a
1893                     ; 354 		counter ++;
1895                     ; 355 		OutputFrame[counter] = temp[1];
1897  03bf 96            	ldw	x,sp
1898  03c0 0c1b          	inc	(OFST+0,sp)
1899  03c2 cd0448        	call	LC004
1900  03c5 1b1b          	add	a,(OFST+0,sp)
1901  03c7 2401          	jrnc	L012
1902  03c9 5c            	incw	x
1903  03ca               L012:
1904  03ca 02            	rlwa	x,a
1905  03cb 7b18          	ld	a,(OFST-3,sp)
1906  03cd f7            	ld	(x),a
1907                     ; 356 		counter ++;
1909                     ; 357 		OutputFrame[counter] = temp[2];
1911  03ce 96            	ldw	x,sp
1912  03cf 0c1b          	inc	(OFST+0,sp)
1913  03d1 ad75          	call	LC004
1914  03d3 1b1b          	add	a,(OFST+0,sp)
1915  03d5 2401          	jrnc	L212
1916  03d7 5c            	incw	x
1917  03d8               L212:
1918  03d8 02            	rlwa	x,a
1919  03d9 7b19          	ld	a,(OFST-2,sp)
1920  03db f7            	ld	(x),a
1921                     ; 358 		counter ++;
1923                     ; 359 		OutputFrame[counter] = temp[3];
1925  03dc 96            	ldw	x,sp
1926  03dd 0c1b          	inc	(OFST+0,sp)
1927  03df ad67          	call	LC004
1928  03e1 1b1b          	add	a,(OFST+0,sp)
1929  03e3 2401          	jrnc	L412
1930  03e5 5c            	incw	x
1931  03e6               L412:
1932  03e6 02            	rlwa	x,a
1933  03e7 7b1a          	ld	a,(OFST-1,sp)
1934  03e9 f7            	ld	(x),a
1935                     ; 360 		counter ++;
1937  03ea 0c1b          	inc	(OFST+0,sp)
1938                     ; 349 for(ct=FirstReg;ct<NumberOfRegs;ct++)
1940  03ec 0c07          	inc	(OFST-20,sp)
1941  03ee 7b07          	ld	a,(OFST-20,sp)
1942  03f0               L166:
1945  03f0 5f            	clrw	x
1946  03f1 97            	ld	xl,a
1947  03f2 1303          	cpw	x,(OFST-24,sp)
1948  03f4 25ac          	jrult	L556
1949                     ; 365 ByteToHex(temp,GetLRC(OutputFrame));
1951  03f6 96            	ldw	x,sp
1952  03f7 1c0008        	addw	x,#OFST-19
1953  03fa cd049c        	call	_GetLRC
1955  03fd 88            	push	a
1956  03fe 96            	ldw	x,sp
1957  03ff 1c0018        	addw	x,#OFST-3
1958  0402 cd00a7        	call	_ByteToHex
1960  0405 84            	pop	a
1961                     ; 366 OutputFrame[counter] = temp[0];
1963  0406 96            	ldw	x,sp
1964  0407 ad3f          	call	LC004
1965  0409 1b1b          	add	a,(OFST+0,sp)
1966  040b 2401          	jrnc	L222
1967  040d 5c            	incw	x
1968  040e               L222:
1969  040e 02            	rlwa	x,a
1970  040f 7b17          	ld	a,(OFST-4,sp)
1971  0411 f7            	ld	(x),a
1972                     ; 367 counter++;
1974                     ; 368 OutputFrame[counter] = temp[1];
1976  0412 96            	ldw	x,sp
1977  0413 0c1b          	inc	(OFST+0,sp)
1978  0415 ad31          	call	LC004
1979  0417 1b1b          	add	a,(OFST+0,sp)
1980  0419 2401          	jrnc	L422
1981  041b 5c            	incw	x
1982  041c               L422:
1983  041c 02            	rlwa	x,a
1984  041d 7b18          	ld	a,(OFST-3,sp)
1985  041f f7            	ld	(x),a
1986                     ; 369 counter++;
1988                     ; 370 OutputFrame[counter] = 0x0D;
1990  0420 96            	ldw	x,sp
1991  0421 0c1b          	inc	(OFST+0,sp)
1992  0423 ad23          	call	LC004
1993  0425 1b1b          	add	a,(OFST+0,sp)
1994  0427 2401          	jrnc	L622
1995  0429 5c            	incw	x
1996  042a               L622:
1997  042a 02            	rlwa	x,a
1998  042b a60d          	ld	a,#13
1999  042d f7            	ld	(x),a
2000                     ; 371 counter++;
2002                     ; 372 OutputFrame[counter] = 0x0A;
2004  042e 96            	ldw	x,sp
2005  042f 0c1b          	inc	(OFST+0,sp)
2006  0431 ad15          	call	LC004
2007  0433 1b1b          	add	a,(OFST+0,sp)
2008  0435 2401          	jrnc	L032
2009  0437 5c            	incw	x
2010  0438               L032:
2011  0438 02            	rlwa	x,a
2012  0439 a60a          	ld	a,#10
2013  043b f7            	ld	(x),a
2014                     ; 373 counter++;
2016                     ; 375 UART_SendStr(OutputFrame); 
2018  043c 96            	ldw	x,sp
2019  043d 0c1b          	inc	(OFST+0,sp)
2020  043f 1c0008        	addw	x,#OFST-19
2021  0442 cd0000        	call	_UART_SendStr
2023                     ; 377 }
2026  0445 5b1b          	addw	sp,#27
2027  0447 81            	ret	
2028  0448               LC004:
2029  0448 1c0008        	addw	x,#OFST-19
2030  044b 9f            	ld	a,xl
2031  044c 5e            	swapw	x
2032  044d 81            	ret	
2055                     ; 378 void ReadInputRegisters(void)
2055                     ; 379 {
2056                     	switch	.text
2057  044e               _ReadInputRegisters:
2061                     ; 382 }
2064  044e 81            	ret	
2087                     ; 383 void ForceSingleCoil(void)
2087                     ; 384 {}
2088                     	switch	.text
2089  044f               _ForceSingleCoil:
2096  044f 81            	ret	
2120                     ; 385 void PresetSingleRegister(void)
2120                     ; 386 {}
2121                     	switch	.text
2122  0450               _PresetSingleRegister:
2129  0450 81            	ret	
2214                     ; 389 bool CheckLRC(char *frame)
2214                     ; 390 {
2215                     	switch	.text
2216  0451               _CheckLRC:
2218  0451 89            	pushw	x
2219  0452 5207          	subw	sp,#7
2220       00000007      OFST:	set	7
2223                     ; 391 	uint8_t a = 0;
2225  0454 0f07          	clr	(OFST+0,sp)
2226                     ; 394 	uint8_t tempSum = 0;
2228  0456 0f01          	clr	(OFST-6,sp)
2229                     ; 396 	uint8_t LRC_calculated = 0;
2231                     ; 398 	uint8_t LRC_dec_from_frame = 0;	
2233  0458 0f02          	clr	(OFST-5,sp)
2235  045a 2002          	jra	L367
2236  045c               L757:
2237                     ; 403 				a++;
2239  045c 0c07          	inc	(OFST+0,sp)
2240  045e               L367:
2241                     ; 401 	while(word[a] != '\r')
2243  045e 7b07          	ld	a,(OFST+0,sp)
2244  0460 5f            	clrw	x
2245  0461 97            	ld	xl,a
2246  0462 e600          	ld	a,(_word,x)
2247  0464 a10d          	cp	a,#13
2248  0466 26f4          	jrne	L757
2249                     ; 406 temp[1] = frame[a-1];
2251  0468 7b07          	ld	a,(OFST+0,sp)
2252  046a 5f            	clrw	x
2253  046b 97            	ld	xl,a
2254  046c 5a            	decw	x
2255  046d 72fb08        	addw	x,(OFST+1,sp)
2256  0470 f6            	ld	a,(x)
2257  0471 6b04          	ld	(OFST-3,sp),a
2258                     ; 407 temp[0] = frame[a-2];
2260  0473 5f            	clrw	x
2261  0474 7b07          	ld	a,(OFST+0,sp)
2262  0476 97            	ld	xl,a
2263  0477 1d0002        	subw	x,#2
2264  047a 72fb08        	addw	x,(OFST+1,sp)
2265  047d f6            	ld	a,(x)
2266  047e 6b03          	ld	(OFST-4,sp),a
2267                     ; 409 HexToByte(temp,&LRC_dec_from_frame);
2269  0480 96            	ldw	x,sp
2270  0481 1c0002        	addw	x,#OFST-5
2271  0484 89            	pushw	x
2272  0485 5c            	incw	x
2273  0486 cd00df        	call	_HexToByte
2275  0489 85            	popw	x
2276                     ; 413 LRC_calculated = GetLRC(frame);
2278  048a 1e08          	ldw	x,(OFST+1,sp)
2279  048c ad0e          	call	_GetLRC
2281  048e 6b07          	ld	(OFST+0,sp),a
2282                     ; 415 if (LRC_calculated == LRC_dec_from_frame)
2284  0490 1102          	cp	a,(OFST-5,sp)
2285  0492 2604          	jrne	L767
2286                     ; 418 		return 1;
2288  0494 a601          	ld	a,#1
2290  0496 2001          	jra	L052
2291  0498               L767:
2292                     ; 422 		return 0;
2294  0498 4f            	clr	a
2296  0499               L052:
2298  0499 5b09          	addw	sp,#9
2299  049b 81            	ret	
2382                     ; 426 uint8_t GetLRC(char *frame)
2382                     ; 427 {
2383                     	switch	.text
2384  049c               _GetLRC:
2386  049c 5206          	subw	sp,#6
2387       00000006      OFST:	set	6
2390                     ; 428 uint8_t a=1;   // 1, because the first char is ':'
2392  049e a601          	ld	a,#1
2393  04a0 6b06          	ld	(OFST+0,sp),a
2394                     ; 429 uint8_t k=2;
2396  04a2 4c            	inc	a
2397  04a3 6b05          	ld	(OFST-1,sp),a
2398                     ; 431 uint8_t temp_sum=0;
2400  04a5 0f01          	clr	(OFST-5,sp)
2401                     ; 432 uint8_t sum = 0;
2403  04a7 0f02          	clr	(OFST-4,sp)
2405  04a9 2002          	jra	L1401
2406  04ab               L5301:
2407                     ; 437 a++;
2409  04ab 0c06          	inc	(OFST+0,sp)
2410  04ad               L1401:
2411                     ; 435 while((word[a] != '\r')&(word[a] != '*'))
2413  04ad 7b06          	ld	a,(OFST+0,sp)
2414  04af 5f            	clrw	x
2415  04b0 97            	ld	xl,a
2416  04b1 e600          	ld	a,(_word,x)
2417  04b3 a10d          	cp	a,#13
2418  04b5 270a          	jreq	L5401
2420  04b7 7b06          	ld	a,(OFST+0,sp)
2421  04b9 5f            	clrw	x
2422  04ba 97            	ld	xl,a
2423  04bb e600          	ld	a,(_word,x)
2424  04bd a12a          	cp	a,#42
2425  04bf 26ea          	jrne	L5301
2426  04c1               L5401:
2427                     ; 439 a = a - 2; 
2429  04c1 0a06          	dec	(OFST+0,sp)
2430  04c3 0a06          	dec	(OFST+0,sp)
2431                     ; 441 for( k; k<a; k+=2)
2434  04c5 2023          	jra	L3501
2435  04c7               L7401:
2436                     ; 443 temp[0] = word[k-1];
2438  04c7 5f            	clrw	x
2439  04c8 97            	ld	xl,a
2440  04c9 5a            	decw	x
2441  04ca e600          	ld	a,(_word,x)
2442  04cc 6b03          	ld	(OFST-3,sp),a
2443                     ; 444 temp[1] = word[k];
2445  04ce 5f            	clrw	x
2446  04cf 7b05          	ld	a,(OFST-1,sp)
2447  04d1 97            	ld	xl,a
2448  04d2 e600          	ld	a,(_word,x)
2449  04d4 6b04          	ld	(OFST-2,sp),a
2450                     ; 445 HexToByte(temp, &temp_sum);
2452  04d6 96            	ldw	x,sp
2453  04d7 5c            	incw	x
2454  04d8 89            	pushw	x
2455  04d9 1c0002        	addw	x,#2
2456  04dc cd00df        	call	_HexToByte
2458  04df 85            	popw	x
2459                     ; 446 sum += temp_sum;
2461  04e0 7b02          	ld	a,(OFST-4,sp)
2462  04e2 1b01          	add	a,(OFST-5,sp)
2463  04e4 6b02          	ld	(OFST-4,sp),a
2464                     ; 441 for( k; k<a; k+=2)
2466  04e6 0c05          	inc	(OFST-1,sp)
2467  04e8 0c05          	inc	(OFST-1,sp)
2468  04ea               L3501:
2471  04ea 7b05          	ld	a,(OFST-1,sp)
2472  04ec 1106          	cp	a,(OFST+0,sp)
2473  04ee 25d7          	jrult	L7401
2474                     ; 449 sum = (~sum) + 1;
2476  04f0 7b02          	ld	a,(OFST-4,sp)
2477  04f2 43            	cpl	a
2478  04f3 4c            	inc	a
2479                     ; 450 return sum;
2483  04f4 5b06          	addw	sp,#6
2484  04f6 81            	ret	
2576                     ; 454 void HexToByte_4(char *hexstring_4, uint16_t *byte)
2576                     ; 455 {
2577                     	switch	.text
2578  04f7               _HexToByte_4:
2580  04f7 89            	pushw	x
2581  04f8 5208          	subw	sp,#8
2582       00000008      OFST:	set	8
2585                     ; 457 uint8_t right_dec = 0;
2587  04fa 0f01          	clr	(OFST-7,sp)
2588                     ; 458 uint8_t left_dec = 0;
2590  04fc 0f02          	clr	(OFST-6,sp)
2591                     ; 459 uint16_t right_dec16 = 0;
2593  04fe 5f            	clrw	x
2594  04ff 1f03          	ldw	(OFST-5,sp),x
2595                     ; 460 uint16_t left_dec16 = 0;
2597  0501 1f05          	ldw	(OFST-3,sp),x
2598                     ; 462 tempp[0] = hexstring_4[0];
2600  0503 1e09          	ldw	x,(OFST+1,sp)
2601  0505 f6            	ld	a,(x)
2602  0506 6b07          	ld	(OFST-1,sp),a
2603                     ; 463 tempp[1] = hexstring_4[1];
2605  0508 e601          	ld	a,(1,x)
2606  050a 6b08          	ld	(OFST+0,sp),a
2607                     ; 464 HexToByte(tempp,&left_dec);
2609  050c 96            	ldw	x,sp
2610  050d 1c0002        	addw	x,#OFST-6
2611  0510 89            	pushw	x
2612  0511 1c0005        	addw	x,#5
2613  0514 cd00df        	call	_HexToByte
2615  0517 85            	popw	x
2616                     ; 466 tempp[0] = hexstring_4[2];
2618  0518 1e09          	ldw	x,(OFST+1,sp)
2619  051a e602          	ld	a,(2,x)
2620  051c 6b07          	ld	(OFST-1,sp),a
2621                     ; 467 tempp[1] = hexstring_4[3];
2623  051e e603          	ld	a,(3,x)
2624  0520 6b08          	ld	(OFST+0,sp),a
2625                     ; 468 HexToByte(tempp,&right_dec);
2627  0522 96            	ldw	x,sp
2628  0523 5c            	incw	x
2629  0524 89            	pushw	x
2630  0525 1c0006        	addw	x,#6
2631  0528 cd00df        	call	_HexToByte
2633  052b 85            	popw	x
2634                     ; 470 left_dec16 = left_dec16 | left_dec;
2636  052c 7b02          	ld	a,(OFST-6,sp)
2637  052e 5f            	clrw	x
2638  052f 97            	ld	xl,a
2639  0530 01            	rrwa	x,a
2640  0531 1a06          	or	a,(OFST-2,sp)
2641  0533 01            	rrwa	x,a
2642  0534 1a05          	or	a,(OFST-3,sp)
2643  0536 01            	rrwa	x,a
2644  0537 1f05          	ldw	(OFST-3,sp),x
2645                     ; 471 right_dec16 = right_dec16 | right_dec;
2647  0539 5f            	clrw	x
2648  053a 7b01          	ld	a,(OFST-7,sp)
2649  053c 97            	ld	xl,a
2650  053d 01            	rrwa	x,a
2651  053e 1a04          	or	a,(OFST-4,sp)
2652  0540 01            	rrwa	x,a
2653  0541 1a03          	or	a,(OFST-5,sp)
2654  0543 01            	rrwa	x,a
2655  0544 1f03          	ldw	(OFST-5,sp),x
2656                     ; 473 *byte = (left_dec16 << 8) | right_dec16;
2658  0546 7b04          	ld	a,(OFST-4,sp)
2659  0548 1e05          	ldw	x,(OFST-3,sp)
2660  054a 01            	rrwa	x,a
2661  054b 1a03          	or	a,(OFST-5,sp)
2662  054d 160d          	ldw	y,(OFST+5,sp)
2663  054f 01            	rrwa	x,a
2664  0550 90ff          	ldw	(y),x
2665                     ; 474 }
2668  0552 5b0a          	addw	sp,#10
2669  0554 81            	ret	
2779                     ; 477 void ByteToHex_4(char *hexstring, uint16_t byte)
2779                     ; 478 {
2780                     	switch	.text
2781  0555               _ByteToHex_4:
2783  0555 89            	pushw	x
2784  0556 520b          	subw	sp,#11
2785       0000000b      OFST:	set	11
2788                     ; 481 	uint16_t D1 = byte >> 8;
2790  0558 1e10          	ldw	x,(OFST+5,sp)
2791  055a 4f            	clr	a
2792  055b 01            	rrwa	x,a
2793  055c 1f02          	ldw	(OFST-9,sp),x
2794                     ; 482   uint16_t D2 = byte & 255;
2796  055e 5f            	clrw	x
2797  055f 7b11          	ld	a,(OFST+6,sp)
2798  0561 02            	rlwa	x,a
2799  0562 1f04          	ldw	(OFST-7,sp),x
2800                     ; 483 	uint8_t D1_8 = 0;
2802  0564 0f06          	clr	(OFST-5,sp)
2803                     ; 484 	uint8_t D2_8 = 0;
2805  0566 0f07          	clr	(OFST-4,sp)
2806                     ; 485 	uint8_t ct = 0;
2808  0568 0f01          	clr	(OFST-10,sp)
2809                     ; 487 	D1_8 |= D1;
2811  056a 7b06          	ld	a,(OFST-5,sp)
2812  056c 1a03          	or	a,(OFST-8,sp)
2813  056e 6b06          	ld	(OFST-5,sp),a
2814                     ; 488 	D2_8 |= D2;
2816  0570 7b07          	ld	a,(OFST-4,sp)
2817  0572 1a05          	or	a,(OFST-6,sp)
2818  0574 6b07          	ld	(OFST-4,sp),a
2819                     ; 490 	ByteToHex(temp1, D1_8);
2821  0576 7b06          	ld	a,(OFST-5,sp)
2822  0578 88            	push	a
2823  0579 96            	ldw	x,sp
2824  057a 1c0009        	addw	x,#OFST-2
2825  057d cd00a7        	call	_ByteToHex
2827  0580 84            	pop	a
2828                     ; 491 	ByteToHex(temp2, D2_8);
2830  0581 7b07          	ld	a,(OFST-4,sp)
2831  0583 88            	push	a
2832  0584 96            	ldw	x,sp
2833  0585 1c000b        	addw	x,#OFST+0
2834  0588 cd00a7        	call	_ByteToHex
2836  058b 84            	pop	a
2837                     ; 493 	hexstring[0] = temp1[0];
2839  058c 1e0c          	ldw	x,(OFST+1,sp)
2840  058e 7b08          	ld	a,(OFST-3,sp)
2841  0590 f7            	ld	(x),a
2842                     ; 494 	hexstring[1] = temp1[1];
2844  0591 7b09          	ld	a,(OFST-2,sp)
2845  0593 e701          	ld	(1,x),a
2846                     ; 495 	hexstring[2] = temp2[0];
2848  0595 7b0a          	ld	a,(OFST-1,sp)
2849  0597 e702          	ld	(2,x),a
2850                     ; 496 	hexstring[3] = temp2[1];
2852  0599 7b0b          	ld	a,(OFST+0,sp)
2853  059b e703          	ld	(3,x),a
2854                     ; 498 }
2857  059d 5b0d          	addw	sp,#13
2858  059f 81            	ret	
2871                     	xref.b	_Output_Registers
2872                     	xref.b	_Input_Registers
2873                     	xref.b	_word
2874                     	xref.b	_Address
2875                     	xref.b	_TimmingDelay
2876                     	xdef	_StateOfCoil
2877                     	xdef	_RewritingChars
2878                     	xdef	_PresetSingleRegister
2879                     	xdef	_ForceSingleCoil
2880                     	xdef	_ReadInputRegisters
2881                     	xdef	_ReadHoldingRegisters
2882                     	xdef	_ReadInputStatus
2883                     	xdef	_ReadCoilStatus
2884                     	xdef	___checkFunc
2885                     	xdef	___checkAddr
2886                     	xdef	_ByteToHex_4
2887                     	xdef	_GetLRC
2888                     	xdef	_CheckLRC
2889                     	xdef	_SetDevAddr
2890                     	xdef	_HexToByte_4
2891                     	xdef	_HexToByte
2892                     	xdef	_ByteToHex
2893                     	xdef	_UART_SendStr
2894                     	xdef	_Modbus_Init
2895                     	xdef	_Delay
2896                     	xdef	_Delay_Init
2897                     	xref	_UART2_SendData8
2898                     	xref	_UART2_ITConfig
2899                     	xref	_UART2_Cmd
2900                     	xref	_UART2_Init
2901                     	xref	_UART2_DeInit
2902                     	xref	_TIM3_ITConfig
2903                     	xref	_TIM3_Cmd
2904                     	xref	_TIM3_TimeBaseInit
2905                     	xref	_TIM3_DeInit
2906                     	xref	_TIM2_ITConfig
2907                     	xref	_TIM2_Cmd
2908                     	xref	_TIM2_TimeBaseInit
2909                     	xref	_TIM2_DeInit
2910                     	xref	_GPIO_WriteLow
2911                     	xref	_GPIO_WriteHigh
2912                     	xref	_GPIO_Init
2913                     	xref	_GPIO_DeInit
2914                     	xref	_CLK_HSIPrescalerConfig
2933                     	xref	c_lzmp
2934                     	end
