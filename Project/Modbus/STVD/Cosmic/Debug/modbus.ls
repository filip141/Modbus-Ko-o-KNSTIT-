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
1534  02e4 cd038d        	call	_GetLRC
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
1637                     ; 302 void ReadInputStatus(void)
1637                     ; 303 {
1638                     	switch	.text
1639  0338               _ReadInputStatus:
1643                     ; 304 UART_SendStr("Function 2 Handled");
1645  0338 ae0000        	ldw	x,#L306
1647                     ; 305 }
1650  033b cc0000        	jp	_UART_SendStr
1674                     ; 306 void ReadHoldingRegisters(void)
1674                     ; 307 {}
1675                     	switch	.text
1676  033e               _ReadHoldingRegisters:
1683  033e 81            	ret	
1706                     ; 308 void ReadInputRegisters(void)
1706                     ; 309 {}
1707                     	switch	.text
1708  033f               _ReadInputRegisters:
1715  033f 81            	ret	
1738                     ; 310 void ForceSingleCoil(void)
1738                     ; 311 {}
1739                     	switch	.text
1740  0340               _ForceSingleCoil:
1747  0340 81            	ret	
1771                     ; 312 void PresetSingleRegister(void)
1771                     ; 313 {}
1772                     	switch	.text
1773  0341               _PresetSingleRegister:
1780  0341 81            	ret	
1865                     ; 316 bool CheckLRC(char *frame)
1865                     ; 317 {
1866                     	switch	.text
1867  0342               _CheckLRC:
1869  0342 89            	pushw	x
1870  0343 5207          	subw	sp,#7
1871       00000007      OFST:	set	7
1874                     ; 318 	uint8_t a = 0;
1876  0345 0f07          	clr	(OFST+0,sp)
1877                     ; 321 	uint8_t tempSum = 0;
1879  0347 0f01          	clr	(OFST-6,sp)
1880                     ; 323 	uint8_t LRC_calculated = 0;
1882                     ; 325 	uint8_t LRC_dec_from_frame = 0;	
1884  0349 0f02          	clr	(OFST-5,sp)
1886  034b 2002          	jra	L317
1887  034d               L707:
1888                     ; 330 				a++;
1890  034d 0c07          	inc	(OFST+0,sp)
1891  034f               L317:
1892                     ; 328 	while(word[a] != '\r')
1894  034f 7b07          	ld	a,(OFST+0,sp)
1895  0351 5f            	clrw	x
1896  0352 97            	ld	xl,a
1897  0353 e600          	ld	a,(_word,x)
1898  0355 a10d          	cp	a,#13
1899  0357 26f4          	jrne	L707
1900                     ; 333 temp[1] = frame[a-1];
1902  0359 7b07          	ld	a,(OFST+0,sp)
1903  035b 5f            	clrw	x
1904  035c 97            	ld	xl,a
1905  035d 5a            	decw	x
1906  035e 72fb08        	addw	x,(OFST+1,sp)
1907  0361 f6            	ld	a,(x)
1908  0362 6b04          	ld	(OFST-3,sp),a
1909                     ; 334 temp[0] = frame[a-2];
1911  0364 5f            	clrw	x
1912  0365 7b07          	ld	a,(OFST+0,sp)
1913  0367 97            	ld	xl,a
1914  0368 1d0002        	subw	x,#2
1915  036b 72fb08        	addw	x,(OFST+1,sp)
1916  036e f6            	ld	a,(x)
1917  036f 6b03          	ld	(OFST-4,sp),a
1918                     ; 336 HexToByte(temp,&LRC_dec_from_frame);
1920  0371 96            	ldw	x,sp
1921  0372 1c0002        	addw	x,#OFST-5
1922  0375 89            	pushw	x
1923  0376 5c            	incw	x
1924  0377 cd00df        	call	_HexToByte
1926  037a 85            	popw	x
1927                     ; 340 LRC_calculated = GetLRC(frame);
1929  037b 1e08          	ldw	x,(OFST+1,sp)
1930  037d ad0e          	call	_GetLRC
1932  037f 6b07          	ld	(OFST+0,sp),a
1933                     ; 342 if (LRC_calculated == LRC_dec_from_frame)
1935  0381 1102          	cp	a,(OFST-5,sp)
1936  0383 2604          	jrne	L717
1937                     ; 345 		return 1;
1939  0385 a601          	ld	a,#1
1941  0387 2001          	jra	L212
1942  0389               L717:
1943                     ; 349 		return 0;
1945  0389 4f            	clr	a
1947  038a               L212:
1949  038a 5b09          	addw	sp,#9
1950  038c 81            	ret	
2033                     ; 353 uint8_t GetLRC(char *frame)
2033                     ; 354 {
2034                     	switch	.text
2035  038d               _GetLRC:
2037  038d 5206          	subw	sp,#6
2038       00000006      OFST:	set	6
2041                     ; 355 uint8_t a=1;   // 1, because the first char is ':'
2043  038f a601          	ld	a,#1
2044  0391 6b06          	ld	(OFST+0,sp),a
2045                     ; 356 uint8_t k=2;
2047  0393 4c            	inc	a
2048  0394 6b05          	ld	(OFST-1,sp),a
2049                     ; 358 uint8_t temp_sum=0;
2051  0396 0f01          	clr	(OFST-5,sp)
2052                     ; 359 uint8_t sum = 0;
2054  0398 0f02          	clr	(OFST-4,sp)
2056  039a 2002          	jra	L177
2057  039c               L567:
2058                     ; 364 a++;
2060  039c 0c06          	inc	(OFST+0,sp)
2061  039e               L177:
2062                     ; 362 while((word[a] != '\r')&(word[a] != '*'))
2064  039e 7b06          	ld	a,(OFST+0,sp)
2065  03a0 5f            	clrw	x
2066  03a1 97            	ld	xl,a
2067  03a2 e600          	ld	a,(_word,x)
2068  03a4 a10d          	cp	a,#13
2069  03a6 270a          	jreq	L577
2071  03a8 7b06          	ld	a,(OFST+0,sp)
2072  03aa 5f            	clrw	x
2073  03ab 97            	ld	xl,a
2074  03ac e600          	ld	a,(_word,x)
2075  03ae a12a          	cp	a,#42
2076  03b0 26ea          	jrne	L567
2077  03b2               L577:
2078                     ; 366 a = a - 2; 
2080  03b2 0a06          	dec	(OFST+0,sp)
2081  03b4 0a06          	dec	(OFST+0,sp)
2082                     ; 368 for( k; k<a; k+=2)
2085  03b6 2023          	jra	L3001
2086  03b8               L777:
2087                     ; 370 temp[0] = word[k-1];
2089  03b8 5f            	clrw	x
2090  03b9 97            	ld	xl,a
2091  03ba 5a            	decw	x
2092  03bb e600          	ld	a,(_word,x)
2093  03bd 6b03          	ld	(OFST-3,sp),a
2094                     ; 371 temp[1] = word[k];
2096  03bf 5f            	clrw	x
2097  03c0 7b05          	ld	a,(OFST-1,sp)
2098  03c2 97            	ld	xl,a
2099  03c3 e600          	ld	a,(_word,x)
2100  03c5 6b04          	ld	(OFST-2,sp),a
2101                     ; 372 HexToByte(temp, &temp_sum);
2103  03c7 96            	ldw	x,sp
2104  03c8 5c            	incw	x
2105  03c9 89            	pushw	x
2106  03ca 1c0002        	addw	x,#2
2107  03cd cd00df        	call	_HexToByte
2109  03d0 85            	popw	x
2110                     ; 373 sum += temp_sum;
2112  03d1 7b02          	ld	a,(OFST-4,sp)
2113  03d3 1b01          	add	a,(OFST-5,sp)
2114  03d5 6b02          	ld	(OFST-4,sp),a
2115                     ; 368 for( k; k<a; k+=2)
2117  03d7 0c05          	inc	(OFST-1,sp)
2118  03d9 0c05          	inc	(OFST-1,sp)
2119  03db               L3001:
2122  03db 7b05          	ld	a,(OFST-1,sp)
2123  03dd 1106          	cp	a,(OFST+0,sp)
2124  03df 25d7          	jrult	L777
2125                     ; 376 sum = (~sum) + 1;
2127  03e1 7b02          	ld	a,(OFST-4,sp)
2128  03e3 43            	cpl	a
2129  03e4 4c            	inc	a
2130                     ; 377 return sum;
2134  03e5 5b06          	addw	sp,#6
2135  03e7 81            	ret	
2227                     ; 381 void HextoByte_4(char *hexstring_4, uint16_t *byte)
2227                     ; 382 {
2228                     	switch	.text
2229  03e8               _HextoByte_4:
2231  03e8 89            	pushw	x
2232  03e9 5208          	subw	sp,#8
2233       00000008      OFST:	set	8
2236                     ; 384 uint8_t right_dec = 0;
2238  03eb 0f01          	clr	(OFST-7,sp)
2239                     ; 385 uint8_t left_dec = 0;
2241  03ed 0f02          	clr	(OFST-6,sp)
2242                     ; 386 uint16_t right_dec16 = 0;
2244  03ef 5f            	clrw	x
2245  03f0 1f03          	ldw	(OFST-5,sp),x
2246                     ; 387 uint16_t left_dec16 = 0;
2248  03f2 1f05          	ldw	(OFST-3,sp),x
2249                     ; 389 tempp[0] = hexstring_4[0];
2251  03f4 1e09          	ldw	x,(OFST+1,sp)
2252  03f6 f6            	ld	a,(x)
2253  03f7 6b07          	ld	(OFST-1,sp),a
2254                     ; 390 tempp[1] = hexstring_4[1];
2256  03f9 e601          	ld	a,(1,x)
2257  03fb 6b08          	ld	(OFST+0,sp),a
2258                     ; 391 HexToByte(tempp,&left_dec);
2260  03fd 96            	ldw	x,sp
2261  03fe 1c0002        	addw	x,#OFST-6
2262  0401 89            	pushw	x
2263  0402 1c0005        	addw	x,#5
2264  0405 cd00df        	call	_HexToByte
2266  0408 85            	popw	x
2267                     ; 393 tempp[0] = hexstring_4[2];
2269  0409 1e09          	ldw	x,(OFST+1,sp)
2270  040b e602          	ld	a,(2,x)
2271  040d 6b07          	ld	(OFST-1,sp),a
2272                     ; 394 tempp[1] = hexstring_4[3];
2274  040f e603          	ld	a,(3,x)
2275  0411 6b08          	ld	(OFST+0,sp),a
2276                     ; 395 HexToByte(tempp,&right_dec);
2278  0413 96            	ldw	x,sp
2279  0414 5c            	incw	x
2280  0415 89            	pushw	x
2281  0416 1c0006        	addw	x,#6
2282  0419 cd00df        	call	_HexToByte
2284  041c 85            	popw	x
2285                     ; 397 left_dec16 = left_dec16 | left_dec;
2287  041d 7b02          	ld	a,(OFST-6,sp)
2288  041f 5f            	clrw	x
2289  0420 97            	ld	xl,a
2290  0421 01            	rrwa	x,a
2291  0422 1a06          	or	a,(OFST-2,sp)
2292  0424 01            	rrwa	x,a
2293  0425 1a05          	or	a,(OFST-3,sp)
2294  0427 01            	rrwa	x,a
2295  0428 1f05          	ldw	(OFST-3,sp),x
2296                     ; 398 right_dec16 = right_dec16 | right_dec;
2298  042a 5f            	clrw	x
2299  042b 7b01          	ld	a,(OFST-7,sp)
2300  042d 97            	ld	xl,a
2301  042e 01            	rrwa	x,a
2302  042f 1a04          	or	a,(OFST-4,sp)
2303  0431 01            	rrwa	x,a
2304  0432 1a03          	or	a,(OFST-5,sp)
2305  0434 01            	rrwa	x,a
2306  0435 1f03          	ldw	(OFST-5,sp),x
2307                     ; 400 *byte = (left_dec16 << 8) | right_dec16;
2309  0437 7b04          	ld	a,(OFST-4,sp)
2310  0439 1e05          	ldw	x,(OFST-3,sp)
2311  043b 01            	rrwa	x,a
2312  043c 1a03          	or	a,(OFST-5,sp)
2313  043e 160d          	ldw	y,(OFST+5,sp)
2314  0440 01            	rrwa	x,a
2315  0441 90ff          	ldw	(y),x
2316                     ; 401 }
2319  0443 5b0a          	addw	sp,#10
2320  0445 81            	ret	
2333                     	xref.b	_Input_Registers
2334                     	xref.b	_word
2335                     	xref.b	_Address
2336                     	xref.b	_TimmingDelay
2337                     	xdef	_StateOfCoil
2338                     	xdef	_RewritingChars
2339                     	xdef	_PresetSingleRegister
2340                     	xdef	_ForceSingleCoil
2341                     	xdef	_ReadInputRegisters
2342                     	xdef	_ReadHoldingRegisters
2343                     	xdef	_ReadInputStatus
2344                     	xdef	_ReadCoilStatus
2345                     	xdef	___checkFunc
2346                     	xdef	___checkAddr
2347                     	xdef	_GetLRC
2348                     	xdef	_CheckLRC
2349                     	xdef	_SetDevAddr
2350                     	xdef	_HextoByte_4
2351                     	xdef	_HexToByte
2352                     	xdef	_ByteToHex
2353                     	xdef	_UART_SendStr
2354                     	xdef	_Modbus_Init
2355                     	xdef	_Delay
2356                     	xdef	_Delay_Init
2357                     	xref	_UART2_SendData8
2358                     	xref	_UART2_ITConfig
2359                     	xref	_UART2_Cmd
2360                     	xref	_UART2_Init
2361                     	xref	_UART2_DeInit
2362                     	xref	_TIM3_ITConfig
2363                     	xref	_TIM3_Cmd
2364                     	xref	_TIM3_TimeBaseInit
2365                     	xref	_TIM3_DeInit
2366                     	xref	_TIM2_ITConfig
2367                     	xref	_TIM2_Cmd
2368                     	xref	_TIM2_TimeBaseInit
2369                     	xref	_TIM2_DeInit
2370                     	xref	_GPIO_WriteLow
2371                     	xref	_GPIO_WriteHigh
2372                     	xref	_GPIO_Init
2373                     	xref	_GPIO_DeInit
2374                     	xref	_CLK_HSIPrescalerConfig
2375                     .const:	section	.text
2376  0000               L306:
2377  0000 46756e637469  	dc.b	"Function 2 Handled",0
2397                     	xref	c_lzmp
2398                     	end
