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
1230  01ad 521a          	subw	sp,#26
1231       0000001a      OFST:	set	26
1234                     ; 194 uint8_t counter = 0;
1236                     ; 195 uint8_t counter2 = 0 ;
1238                     ; 196 uint8_t TempSum=0;
1240  01af 0f16          	clr	(OFST-4,sp)
1241                     ; 202 uint8_t n = 0;
1243                     ; 205 Input_Registers[0] = 255;
1245  01b1 ae00ff        	ldw	x,#255
1246  01b4 bf00          	ldw	_Input_Registers,x
1247                     ; 209 RewritingChars(OutputFrame,0,4);
1249  01b6 4b04          	push	#4
1250  01b8 4b00          	push	#0
1251  01ba 96            	ldw	x,sp
1252  01bb 1c0009        	addw	x,#OFST-17
1253  01be ad99          	call	_RewritingChars
1255  01c0 b607          	ld	a,_word+7
1256  01c2 85            	popw	x
1257                     ; 212 temp[0] = word[7];
1259  01c3 6b18          	ld	(OFST-2,sp),a
1260                     ; 213 temp[1] = word[8];
1262  01c5 b608          	ld	a,_word+8
1263  01c7 6b19          	ld	(OFST-1,sp),a
1264                     ; 214 HexToByte(temp, &FirstCoil);
1266  01c9 96            	ldw	x,sp
1267  01ca 1c0002        	addw	x,#OFST-24
1268  01cd 89            	pushw	x
1269  01ce 1c0016        	addw	x,#22
1270  01d1 cd00df        	call	_HexToByte
1272  01d4 b60b          	ld	a,_word+11
1273  01d6 85            	popw	x
1274                     ; 217 temp[0] = word[11];
1276  01d7 6b18          	ld	(OFST-2,sp),a
1277                     ; 218 temp[1] = word[12];
1279  01d9 b60c          	ld	a,_word+12
1280  01db 6b19          	ld	(OFST-1,sp),a
1281                     ; 219 HexToByte(temp, &NumberOfCoils);
1283  01dd 96            	ldw	x,sp
1284  01de 1c0003        	addw	x,#OFST-23
1285  01e1 89            	pushw	x
1286  01e2 1c0015        	addw	x,#21
1287  01e5 cd00df        	call	_HexToByte
1289  01e8 85            	popw	x
1290                     ; 222 if((NumberOfCoils%8)!=0)
1292  01e9 7b03          	ld	a,(OFST-23,sp)
1293  01eb a507          	bcp	a,#7
1294  01ed 2709          	jreq	L535
1295                     ; 224 	NumberOfDataBytes = ( NumberOfCoils/8)+1;
1297  01ef 5f            	clrw	x
1298  01f0 97            	ld	xl,a
1299  01f1 57            	sraw	x
1300  01f2 57            	sraw	x
1301  01f3 57            	sraw	x
1302  01f4 01            	rrwa	x,a
1303  01f5 4c            	inc	a
1305  01f6 2006          	jra	L735
1306  01f8               L535:
1307                     ; 228 	NumberOfDataBytes = NumberOfCoils/8;
1309  01f8 5f            	clrw	x
1310  01f9 97            	ld	xl,a
1311  01fa 57            	sraw	x
1312  01fb 57            	sraw	x
1313  01fc 57            	sraw	x
1314  01fd 01            	rrwa	x,a
1315  01fe               L735:
1316  01fe 6b04          	ld	(OFST-22,sp),a
1317                     ; 232 ByteToHex(temp,NumberOfDataBytes);
1319  0200 88            	push	a
1320  0201 96            	ldw	x,sp
1321  0202 1c0019        	addw	x,#OFST-1
1322  0205 cd00a7        	call	_ByteToHex
1324  0208 84            	pop	a
1325                     ; 233 OutputFrame[5] = temp[0];
1327  0209 7b18          	ld	a,(OFST-2,sp)
1328  020b 6b0c          	ld	(OFST-14,sp),a
1329                     ; 234 OutputFrame[6] = temp[1];
1331  020d 7b19          	ld	a,(OFST-1,sp)
1332  020f 6b0d          	ld	(OFST-13,sp),a
1333                     ; 237 counter = 7; 
1335  0211 a607          	ld	a,#7
1336  0213 6b17          	ld	(OFST-3,sp),a
1337                     ; 238 Coil = FirstCoil + 1;
1339  0215 7b02          	ld	a,(OFST-24,sp)
1340  0217 4c            	inc	a
1341  0218 6b06          	ld	(OFST-20,sp),a
1342                     ; 239 n = NumberOfCoils;
1344  021a 7b03          	ld	a,(OFST-23,sp)
1345  021c 6b05          	ld	(OFST-21,sp),a
1347  021e cc02d8        	jra	L545
1348  0221               L145:
1349                     ; 242 		if(n>=8)                   //    changing 8bits to hex
1351  0221 a108          	cp	a,#8
1352  0223 2556          	jrult	L155
1353                     ; 244 						uint8_t pwr = 0;
1355                     ; 245 						for(pwr =0; pwr<8; pwr++,Coil++)
1357  0225 0f1a          	clr	(OFST+0,sp)
1358  0227               L355:
1359                     ; 247 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
1361  0227 ae0000        	ldw	x,#_Input_Registers
1362  022a 89            	pushw	x
1363  022b 7b08          	ld	a,(OFST-18,sp)
1364  022d cd017b        	call	_StateOfCoil
1366  0230 85            	popw	x
1367  0231 6b01          	ld	(OFST-25,sp),a
1368  0233 5f            	clrw	x
1369  0234 7b1a          	ld	a,(OFST+0,sp)
1370  0236 97            	ld	xl,a
1371  0237 a601          	ld	a,#1
1372  0239 5d            	tnzw	x
1373  023a 2704          	jreq	L421
1374  023c               L621:
1375  023c 48            	sll	a
1376  023d 5a            	decw	x
1377  023e 26fc          	jrne	L621
1378  0240               L421:
1379  0240 97            	ld	xl,a
1380  0241 7b01          	ld	a,(OFST-25,sp)
1381  0243 42            	mul	x,a
1382  0244 9f            	ld	a,xl
1383  0245 1b16          	add	a,(OFST-4,sp)
1384  0247 6b16          	ld	(OFST-4,sp),a
1385                     ; 248 								n--;
1387  0249 0a05          	dec	(OFST-21,sp)
1388                     ; 245 						for(pwr =0; pwr<8; pwr++,Coil++)
1390  024b 0c1a          	inc	(OFST+0,sp)
1391  024d 0c06          	inc	(OFST-20,sp)
1394  024f 7b1a          	ld	a,(OFST+0,sp)
1395  0251 a108          	cp	a,#8
1396  0253 25d2          	jrult	L355
1397                     ; 251 						ByteToHex(temp,TempSum);
1399  0255 7b16          	ld	a,(OFST-4,sp)
1400  0257 88            	push	a
1401  0258 96            	ldw	x,sp
1402  0259 1c0019        	addw	x,#OFST-1
1403  025c cd00a7        	call	_ByteToHex
1405  025f 84            	pop	a
1406                     ; 252 						TempSum = 0;
1408  0260 0f16          	clr	(OFST-4,sp)
1409                     ; 253 						OutputFrame[counter] = temp[0];
1411  0262 96            	ldw	x,sp
1412  0263 cd032e        	call	LC003
1413  0266 1b17          	add	a,(OFST-3,sp)
1414  0268 2401          	jrnc	L231
1415  026a 5c            	incw	x
1416  026b               L231:
1417  026b 02            	rlwa	x,a
1418  026c 7b18          	ld	a,(OFST-2,sp)
1419  026e f7            	ld	(x),a
1420                     ; 254 						counter++;
1422                     ; 255 						OutputFrame[counter] = temp[1];
1424  026f 96            	ldw	x,sp
1425  0270 0c17          	inc	(OFST-3,sp)
1426  0272 cd032e        	call	LC003
1427  0275 1b17          	add	a,(OFST-3,sp)
1428  0277 2459          	jrnc	L051
1429                     ; 256 						counter++;
1431  0279 2056          	jp	LC002
1432  027b               L155:
1433                     ; 261 						uint8_t pwr = 0;
1435                     ; 262 						uint8_t zm = n;
1437  027b 6b04          	ld	(OFST-22,sp),a
1438                     ; 263 						for(pwr =0; pwr<zm; pwr++,Coil++)
1440  027d 0f1a          	clr	(OFST+0,sp)
1442  027f 2028          	jra	L765
1443  0281               L365:
1444                     ; 265 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
1446  0281 ae0000        	ldw	x,#_Input_Registers
1447  0284 89            	pushw	x
1448  0285 7b08          	ld	a,(OFST-18,sp)
1449  0287 cd017b        	call	_StateOfCoil
1451  028a 85            	popw	x
1452  028b 6b01          	ld	(OFST-25,sp),a
1453  028d 5f            	clrw	x
1454  028e 7b1a          	ld	a,(OFST+0,sp)
1455  0290 97            	ld	xl,a
1456  0291 a601          	ld	a,#1
1457  0293 5d            	tnzw	x
1458  0294 2704          	jreq	L041
1459  0296               L241:
1460  0296 48            	sll	a
1461  0297 5a            	decw	x
1462  0298 26fc          	jrne	L241
1463  029a               L041:
1464  029a 97            	ld	xl,a
1465  029b 7b01          	ld	a,(OFST-25,sp)
1466  029d 42            	mul	x,a
1467  029e 9f            	ld	a,xl
1468  029f 1b16          	add	a,(OFST-4,sp)
1469  02a1 6b16          	ld	(OFST-4,sp),a
1470                     ; 266 								n--;
1472  02a3 0a05          	dec	(OFST-21,sp)
1473                     ; 263 						for(pwr =0; pwr<zm; pwr++,Coil++)
1475  02a5 0c1a          	inc	(OFST+0,sp)
1476  02a7 0c06          	inc	(OFST-20,sp)
1477  02a9               L765:
1480  02a9 7b1a          	ld	a,(OFST+0,sp)
1481  02ab 1104          	cp	a,(OFST-22,sp)
1482  02ad 25d2          	jrult	L365
1483                     ; 268 						ByteToHex(temp,TempSum);
1485  02af 7b16          	ld	a,(OFST-4,sp)
1486  02b1 88            	push	a
1487  02b2 96            	ldw	x,sp
1488  02b3 1c0019        	addw	x,#OFST-1
1489  02b6 cd00a7        	call	_ByteToHex
1491  02b9 84            	pop	a
1492                     ; 269 						TempSum = 0;
1494  02ba 0f16          	clr	(OFST-4,sp)
1495                     ; 270 						OutputFrame[counter] = temp[0];
1497  02bc 96            	ldw	x,sp
1498  02bd ad6f          	call	LC003
1499  02bf 1b17          	add	a,(OFST-3,sp)
1500  02c1 2401          	jrnc	L641
1501  02c3 5c            	incw	x
1502  02c4               L641:
1503  02c4 02            	rlwa	x,a
1504  02c5 7b18          	ld	a,(OFST-2,sp)
1505  02c7 f7            	ld	(x),a
1506                     ; 271 						counter++;
1508                     ; 272 						OutputFrame[counter] = temp[1];
1510  02c8 96            	ldw	x,sp
1511  02c9 0c17          	inc	(OFST-3,sp)
1512  02cb ad61          	call	LC003
1513  02cd 1b17          	add	a,(OFST-3,sp)
1514  02cf 2401          	jrnc	L051
1515  02d1               LC002:
1516  02d1 5c            	incw	x
1517  02d2               L051:
1518                     ; 273 						counter++;
1520  02d2 02            	rlwa	x,a
1521  02d3 7b19          	ld	a,(OFST-1,sp)
1522  02d5 f7            	ld	(x),a
1524  02d6 0c17          	inc	(OFST-3,sp)
1525  02d8               L545:
1526                     ; 240 while(n>0)
1528  02d8 7b05          	ld	a,(OFST-21,sp)
1529  02da 2703cc0221    	jrne	L145
1530                     ; 278 counter2 = counter;
1532  02df 7b17          	ld	a,(OFST-3,sp)
1533  02e1 6b1a          	ld	(OFST+0,sp),a
1534                     ; 279 for(counter2; counter2<=15; counter2++)
1537  02e3 200f          	jra	L775
1538  02e5               L375:
1539                     ; 281 			OutputFrame[counter2] = '*';
1541  02e5 ad47          	call	LC003
1542  02e7 1b1a          	add	a,(OFST+0,sp)
1543  02e9 2401          	jrnc	L251
1544  02eb 5c            	incw	x
1545  02ec               L251:
1546  02ec 02            	rlwa	x,a
1547  02ed a62a          	ld	a,#42
1548  02ef f7            	ld	(x),a
1549                     ; 279 for(counter2; counter2<=15; counter2++)
1551  02f0 0c1a          	inc	(OFST+0,sp)
1552  02f2 7b1a          	ld	a,(OFST+0,sp)
1553  02f4               L775:
1556  02f4 a110          	cp	a,#16
1557  02f6 96            	ldw	x,sp
1558  02f7 25ec          	jrult	L375
1559                     ; 285 ByteToHex(temp,GetLRC(OutputFrame));
1561  02f9 1c0007        	addw	x,#OFST-19
1562  02fc cd0395        	call	_GetLRC
1564  02ff 88            	push	a
1565  0300 96            	ldw	x,sp
1566  0301 1c0019        	addw	x,#OFST-1
1567  0304 cd00a7        	call	_ByteToHex
1569  0307 84            	pop	a
1570                     ; 286 OutputFrame[counter] = temp[0];
1572  0308 96            	ldw	x,sp
1573  0309 ad23          	call	LC003
1574  030b 1b17          	add	a,(OFST-3,sp)
1575  030d 2401          	jrnc	L061
1576  030f 5c            	incw	x
1577  0310               L061:
1578  0310 02            	rlwa	x,a
1579  0311 7b18          	ld	a,(OFST-2,sp)
1580  0313 f7            	ld	(x),a
1581                     ; 287 counter++;
1583                     ; 288 OutputFrame[counter] = temp[1];
1585  0314 96            	ldw	x,sp
1586  0315 0c17          	inc	(OFST-3,sp)
1587  0317 ad15          	call	LC003
1588  0319 1b17          	add	a,(OFST-3,sp)
1589  031b 2401          	jrnc	L261
1590  031d 5c            	incw	x
1591  031e               L261:
1592  031e 02            	rlwa	x,a
1593  031f 7b19          	ld	a,(OFST-1,sp)
1594  0321 f7            	ld	(x),a
1595                     ; 289 counter++;
1597                     ; 292 UART_SendStr(OutputFrame); 
1599  0322 96            	ldw	x,sp
1600  0323 0c17          	inc	(OFST-3,sp)
1601  0325 1c0007        	addw	x,#OFST-19
1602  0328 cd0000        	call	_UART_SendStr
1604                     ; 293 }
1607  032b 5b1a          	addw	sp,#26
1608  032d 81            	ret	
1609  032e               LC003:
1610  032e 1c0007        	addw	x,#OFST-19
1611  0331 9f            	ld	a,xl
1612  0332 5e            	swapw	x
1613  0333 81            	ret	
1637                     ; 297 void ReadInputStatus(void)
1637                     ; 298 {
1638                     	switch	.text
1639  0334               _ReadInputStatus:
1643                     ; 299 UART_SendStr("Function 2 Handled");
1645  0334 ae0015        	ldw	x,#L316
1647                     ; 300 }
1650  0337 cc0000        	jp	_UART_SendStr
1674                     ; 301 void ReadHoldingRegisters(void)
1674                     ; 302 {}
1675                     	switch	.text
1676  033a               _ReadHoldingRegisters:
1683  033a 81            	ret	
1706                     ; 303 void ReadInputRegisters(void)
1706                     ; 304 {}
1707                     	switch	.text
1708  033b               _ReadInputRegisters:
1715  033b 81            	ret	
1738                     ; 305 void ForceSingleCoil(void)
1738                     ; 306 {}
1739                     	switch	.text
1740  033c               _ForceSingleCoil:
1747  033c 81            	ret	
1771                     ; 307 void PresetSingleRegister(void)
1771                     ; 308 {}
1772                     	switch	.text
1773  033d               _PresetSingleRegister:
1780  033d 81            	ret	
1866                     ; 311 bool CheckLRC(char *frame)
1866                     ; 312 {
1867                     	switch	.text
1868  033e               _CheckLRC:
1870  033e 89            	pushw	x
1871  033f 5207          	subw	sp,#7
1872       00000007      OFST:	set	7
1875                     ; 313 	uint8_t a = 0;
1877  0341 0f07          	clr	(OFST+0,sp)
1878                     ; 316 	uint8_t tempSum = 0;
1880  0343 0f01          	clr	(OFST-6,sp)
1881                     ; 318 	uint8_t LRC_calculated = 0;
1883                     ; 320 	uint8_t LRC_dec_from_frame = 0;	
1885  0345 0f02          	clr	(OFST-5,sp)
1887  0347 2002          	jra	L327
1888  0349               L717:
1889                     ; 325 				a++;
1891  0349 0c07          	inc	(OFST+0,sp)
1892  034b               L327:
1893                     ; 323 	while(word[a] != '\r')
1895  034b 7b07          	ld	a,(OFST+0,sp)
1896  034d 5f            	clrw	x
1897  034e 97            	ld	xl,a
1898  034f e600          	ld	a,(_word,x)
1899  0351 a10d          	cp	a,#13
1900  0353 26f4          	jrne	L717
1901                     ; 328 temp[1] = frame[a-1];
1903  0355 7b07          	ld	a,(OFST+0,sp)
1904  0357 5f            	clrw	x
1905  0358 97            	ld	xl,a
1906  0359 5a            	decw	x
1907  035a 72fb08        	addw	x,(OFST+1,sp)
1908  035d f6            	ld	a,(x)
1909  035e 6b04          	ld	(OFST-3,sp),a
1910                     ; 329 temp[0] = frame[a-2];
1912  0360 5f            	clrw	x
1913  0361 7b07          	ld	a,(OFST+0,sp)
1914  0363 97            	ld	xl,a
1915  0364 1d0002        	subw	x,#2
1916  0367 72fb08        	addw	x,(OFST+1,sp)
1917  036a f6            	ld	a,(x)
1918  036b 6b03          	ld	(OFST-4,sp),a
1919                     ; 331 HexToByte(temp,&LRC_dec_from_frame);
1921  036d 96            	ldw	x,sp
1922  036e 1c0002        	addw	x,#OFST-5
1923  0371 89            	pushw	x
1924  0372 5c            	incw	x
1925  0373 cd00df        	call	_HexToByte
1927  0376 85            	popw	x
1928                     ; 335 LRC_calculated = GetLRC(frame);
1930  0377 1e08          	ldw	x,(OFST+1,sp)
1931  0379 ad1a          	call	_GetLRC
1933  037b 6b07          	ld	(OFST+0,sp),a
1934                     ; 337 if (LRC_calculated == LRC_dec_from_frame)
1936  037d 1102          	cp	a,(OFST-5,sp)
1937  037f 260a          	jrne	L727
1938                     ; 339 		UART_SendStr("LRC IS OK"); 
1940  0381 ae000b        	ldw	x,#L137
1941  0384 cd0000        	call	_UART_SendStr
1943                     ; 340 		return 1;
1945  0387 a601          	ld	a,#1
1947  0389 2007          	jra	L412
1948  038b               L727:
1949                     ; 344 		UART_SendStr("LRC IS BAD");
1951  038b ae0000        	ldw	x,#L537
1952  038e cd0000        	call	_UART_SendStr
1954                     ; 345 		return 0;
1956  0391 4f            	clr	a
1958  0392               L412:
1960  0392 5b09          	addw	sp,#9
1961  0394 81            	ret	
2044                     ; 349 uint8_t GetLRC(char *frame)
2044                     ; 350 {
2045                     	switch	.text
2046  0395               _GetLRC:
2048  0395 5206          	subw	sp,#6
2049       00000006      OFST:	set	6
2052                     ; 351 uint8_t a=1;   // 1, because the first char is ':'
2054  0397 a601          	ld	a,#1
2055  0399 6b06          	ld	(OFST+0,sp),a
2056                     ; 352 uint8_t k=2;
2058  039b 4c            	inc	a
2059  039c 6b05          	ld	(OFST-1,sp),a
2060                     ; 354 uint8_t temp_sum=0;
2062  039e 0f01          	clr	(OFST-5,sp)
2063                     ; 355 uint8_t sum = 0;
2065  03a0 0f02          	clr	(OFST-4,sp)
2067  03a2 2002          	jra	L5001
2068  03a4               L1001:
2069                     ; 360 a++;
2071  03a4 0c06          	inc	(OFST+0,sp)
2072  03a6               L5001:
2073                     ; 358 while((word[a] != '\r')&(word[a] != '*'))
2075  03a6 7b06          	ld	a,(OFST+0,sp)
2076  03a8 5f            	clrw	x
2077  03a9 97            	ld	xl,a
2078  03aa e600          	ld	a,(_word,x)
2079  03ac a10d          	cp	a,#13
2080  03ae 270a          	jreq	L1101
2082  03b0 7b06          	ld	a,(OFST+0,sp)
2083  03b2 5f            	clrw	x
2084  03b3 97            	ld	xl,a
2085  03b4 e600          	ld	a,(_word,x)
2086  03b6 a12a          	cp	a,#42
2087  03b8 26ea          	jrne	L1001
2088  03ba               L1101:
2089                     ; 362 a = a - 2; 
2091  03ba 0a06          	dec	(OFST+0,sp)
2092  03bc 0a06          	dec	(OFST+0,sp)
2093                     ; 364 for( k; k<a; k+=2)
2096  03be 2023          	jra	L7101
2097  03c0               L3101:
2098                     ; 366 temp[0] = word[k-1];
2100  03c0 5f            	clrw	x
2101  03c1 97            	ld	xl,a
2102  03c2 5a            	decw	x
2103  03c3 e600          	ld	a,(_word,x)
2104  03c5 6b03          	ld	(OFST-3,sp),a
2105                     ; 367 temp[1] = word[k];
2107  03c7 5f            	clrw	x
2108  03c8 7b05          	ld	a,(OFST-1,sp)
2109  03ca 97            	ld	xl,a
2110  03cb e600          	ld	a,(_word,x)
2111  03cd 6b04          	ld	(OFST-2,sp),a
2112                     ; 368 HexToByte(temp, &temp_sum);
2114  03cf 96            	ldw	x,sp
2115  03d0 5c            	incw	x
2116  03d1 89            	pushw	x
2117  03d2 1c0002        	addw	x,#2
2118  03d5 cd00df        	call	_HexToByte
2120  03d8 85            	popw	x
2121                     ; 369 sum += temp_sum;
2123  03d9 7b02          	ld	a,(OFST-4,sp)
2124  03db 1b01          	add	a,(OFST-5,sp)
2125  03dd 6b02          	ld	(OFST-4,sp),a
2126                     ; 364 for( k; k<a; k+=2)
2128  03df 0c05          	inc	(OFST-1,sp)
2129  03e1 0c05          	inc	(OFST-1,sp)
2130  03e3               L7101:
2133  03e3 7b05          	ld	a,(OFST-1,sp)
2134  03e5 1106          	cp	a,(OFST+0,sp)
2135  03e7 25d7          	jrult	L3101
2136                     ; 372 sum = (~sum) + 1;
2138  03e9 7b02          	ld	a,(OFST-4,sp)
2139  03eb 43            	cpl	a
2140  03ec 4c            	inc	a
2141                     ; 373 return sum;
2145  03ed 5b06          	addw	sp,#6
2146  03ef 81            	ret	
2238                     ; 377 void HextoByte_4(char *hexstring_4, uint16_t *byte)
2238                     ; 378 {
2239                     	switch	.text
2240  03f0               _HextoByte_4:
2242  03f0 89            	pushw	x
2243  03f1 5208          	subw	sp,#8
2244       00000008      OFST:	set	8
2247                     ; 380 uint8_t right_dec = 0;
2249  03f3 0f01          	clr	(OFST-7,sp)
2250                     ; 381 uint8_t left_dec = 0;
2252  03f5 0f02          	clr	(OFST-6,sp)
2253                     ; 382 uint16_t right_dec16 = 0;
2255  03f7 5f            	clrw	x
2256  03f8 1f03          	ldw	(OFST-5,sp),x
2257                     ; 383 uint16_t left_dec16 = 0;
2259  03fa 1f05          	ldw	(OFST-3,sp),x
2260                     ; 385 tempp[0] = hexstring_4[0];
2262  03fc 1e09          	ldw	x,(OFST+1,sp)
2263  03fe f6            	ld	a,(x)
2264  03ff 6b07          	ld	(OFST-1,sp),a
2265                     ; 386 tempp[1] = hexstring_4[1];
2267  0401 e601          	ld	a,(1,x)
2268  0403 6b08          	ld	(OFST+0,sp),a
2269                     ; 387 HexToByte(tempp,&left_dec);
2271  0405 96            	ldw	x,sp
2272  0406 1c0002        	addw	x,#OFST-6
2273  0409 89            	pushw	x
2274  040a 1c0005        	addw	x,#5
2275  040d cd00df        	call	_HexToByte
2277  0410 85            	popw	x
2278                     ; 389 tempp[0] = hexstring_4[2];
2280  0411 1e09          	ldw	x,(OFST+1,sp)
2281  0413 e602          	ld	a,(2,x)
2282  0415 6b07          	ld	(OFST-1,sp),a
2283                     ; 390 tempp[1] = hexstring_4[3];
2285  0417 e603          	ld	a,(3,x)
2286  0419 6b08          	ld	(OFST+0,sp),a
2287                     ; 391 HexToByte(tempp,&right_dec);
2289  041b 96            	ldw	x,sp
2290  041c 5c            	incw	x
2291  041d 89            	pushw	x
2292  041e 1c0006        	addw	x,#6
2293  0421 cd00df        	call	_HexToByte
2295  0424 85            	popw	x
2296                     ; 393 left_dec16 = left_dec16 | left_dec;
2298  0425 7b02          	ld	a,(OFST-6,sp)
2299  0427 5f            	clrw	x
2300  0428 97            	ld	xl,a
2301  0429 01            	rrwa	x,a
2302  042a 1a06          	or	a,(OFST-2,sp)
2303  042c 01            	rrwa	x,a
2304  042d 1a05          	or	a,(OFST-3,sp)
2305  042f 01            	rrwa	x,a
2306  0430 1f05          	ldw	(OFST-3,sp),x
2307                     ; 394 right_dec16 = right_dec16 | right_dec;
2309  0432 5f            	clrw	x
2310  0433 7b01          	ld	a,(OFST-7,sp)
2311  0435 97            	ld	xl,a
2312  0436 01            	rrwa	x,a
2313  0437 1a04          	or	a,(OFST-4,sp)
2314  0439 01            	rrwa	x,a
2315  043a 1a03          	or	a,(OFST-5,sp)
2316  043c 01            	rrwa	x,a
2317  043d 1f03          	ldw	(OFST-5,sp),x
2318                     ; 396 *byte = (left_dec16 << 8) | right_dec16;
2320  043f 7b04          	ld	a,(OFST-4,sp)
2321  0441 1e05          	ldw	x,(OFST-3,sp)
2322  0443 01            	rrwa	x,a
2323  0444 1a03          	or	a,(OFST-5,sp)
2324  0446 160d          	ldw	y,(OFST+5,sp)
2325  0448 01            	rrwa	x,a
2326  0449 90ff          	ldw	(y),x
2327                     ; 397 }
2330  044b 5b0a          	addw	sp,#10
2331  044d 81            	ret	
2344                     	xref.b	_Input_Registers
2345                     	xref.b	_word
2346                     	xref.b	_Address
2347                     	xref.b	_TimmingDelay
2348                     	xdef	_StateOfCoil
2349                     	xdef	_RewritingChars
2350                     	xdef	_PresetSingleRegister
2351                     	xdef	_ForceSingleCoil
2352                     	xdef	_ReadInputRegisters
2353                     	xdef	_ReadHoldingRegisters
2354                     	xdef	_ReadInputStatus
2355                     	xdef	_ReadCoilStatus
2356                     	xdef	___checkFunc
2357                     	xdef	___checkAddr
2358                     	xdef	_GetLRC
2359                     	xdef	_CheckLRC
2360                     	xdef	_SetDevAddr
2361                     	xdef	_HextoByte_4
2362                     	xdef	_HexToByte
2363                     	xdef	_ByteToHex
2364                     	xdef	_UART_SendStr
2365                     	xdef	_Modbus_Init
2366                     	xdef	_Delay
2367                     	xdef	_Delay_Init
2368                     	xref	_UART2_SendData8
2369                     	xref	_UART2_ITConfig
2370                     	xref	_UART2_Cmd
2371                     	xref	_UART2_Init
2372                     	xref	_UART2_DeInit
2373                     	xref	_TIM3_ITConfig
2374                     	xref	_TIM3_Cmd
2375                     	xref	_TIM3_TimeBaseInit
2376                     	xref	_TIM3_DeInit
2377                     	xref	_TIM2_ITConfig
2378                     	xref	_TIM2_Cmd
2379                     	xref	_TIM2_TimeBaseInit
2380                     	xref	_TIM2_DeInit
2381                     	xref	_GPIO_WriteLow
2382                     	xref	_GPIO_WriteHigh
2383                     	xref	_GPIO_Init
2384                     	xref	_GPIO_DeInit
2385                     	xref	_CLK_HSIPrescalerConfig
2386                     .const:	section	.text
2387  0000               L537:
2388  0000 4c5243204953  	dc.b	"LRC IS BAD",0
2389  000b               L137:
2390  000b 4c5243204953  	dc.b	"LRC IS OK",0
2391  0015               L316:
2392  0015 46756e637469  	dc.b	"Function 2 Handled",0
2412                     	xref	c_lzmp
2413                     	end
