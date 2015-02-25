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
1216                     ; 190 void ReadCoilStatus(void)
1216                     ; 191 {
1217                     	switch	.text
1218  01ad               _ReadCoilStatus:
1220  01ad 521a          	subw	sp,#26
1221       0000001a      OFST:	set	26
1224                     ; 194 uint8_t counter = 0;
1226                     ; 195 uint8_t TempSum=0;
1228  01af 0f17          	clr	(OFST-3,sp)
1229                     ; 201 uint8_t n = 0;
1231                     ; 204 Input_Registers[0] = 255;
1233  01b1 ae00ff        	ldw	x,#255
1234  01b4 bf00          	ldw	_Input_Registers,x
1235                     ; 208 RewritingChars(OutputFrame,0,4);
1237  01b6 4b04          	push	#4
1238  01b8 4b00          	push	#0
1239  01ba 96            	ldw	x,sp
1240  01bb 1c0008        	addw	x,#OFST-18
1241  01be ad99          	call	_RewritingChars
1243  01c0 b607          	ld	a,_word+7
1244  01c2 85            	popw	x
1245                     ; 211 temp[0] = word[7];
1247  01c3 6b18          	ld	(OFST-2,sp),a
1248                     ; 212 temp[1] = word[8];
1250  01c5 b608          	ld	a,_word+8
1251  01c7 6b19          	ld	(OFST-1,sp),a
1252                     ; 213 HexToByte(temp, &FirstCoil);
1254  01c9 96            	ldw	x,sp
1255  01ca 1c0003        	addw	x,#OFST-23
1256  01cd 89            	pushw	x
1257  01ce 1c0015        	addw	x,#21
1258  01d1 cd00df        	call	_HexToByte
1260  01d4 b60b          	ld	a,_word+11
1261  01d6 85            	popw	x
1262                     ; 216 temp[0] = word[11];
1264  01d7 6b18          	ld	(OFST-2,sp),a
1265                     ; 217 temp[1] = word[12];
1267  01d9 b60c          	ld	a,_word+12
1268  01db 6b19          	ld	(OFST-1,sp),a
1269                     ; 218 HexToByte(temp, &NumberOfCoils);
1271  01dd 96            	ldw	x,sp
1272  01de 1c0004        	addw	x,#OFST-22
1273  01e1 89            	pushw	x
1274  01e2 1c0014        	addw	x,#20
1275  01e5 cd00df        	call	_HexToByte
1277  01e8 85            	popw	x
1278                     ; 221 if((NumberOfCoils%8)!=0)
1280  01e9 7b04          	ld	a,(OFST-22,sp)
1281  01eb a507          	bcp	a,#7
1282  01ed 2709          	jreq	L135
1283                     ; 223 	NumberOfDataBytes = ( NumberOfCoils/8)+1;
1285  01ef 5f            	clrw	x
1286  01f0 97            	ld	xl,a
1287  01f1 57            	sraw	x
1288  01f2 57            	sraw	x
1289  01f3 57            	sraw	x
1290  01f4 01            	rrwa	x,a
1291  01f5 4c            	inc	a
1293  01f6 2006          	jra	L335
1294  01f8               L135:
1295                     ; 227 	NumberOfDataBytes = NumberOfCoils/8;
1297  01f8 5f            	clrw	x
1298  01f9 97            	ld	xl,a
1299  01fa 57            	sraw	x
1300  01fb 57            	sraw	x
1301  01fc 57            	sraw	x
1302  01fd 01            	rrwa	x,a
1303  01fe               L335:
1304  01fe 6b05          	ld	(OFST-21,sp),a
1305                     ; 231 ByteToHex(temp,NumberOfDataBytes);
1307  0200 88            	push	a
1308  0201 96            	ldw	x,sp
1309  0202 1c0019        	addw	x,#OFST-1
1310  0205 cd00a7        	call	_ByteToHex
1312  0208 84            	pop	a
1313                     ; 232 OutputFrame[5] = temp[0];
1315  0209 7b18          	ld	a,(OFST-2,sp)
1316  020b 6b0b          	ld	(OFST-15,sp),a
1317                     ; 233 OutputFrame[6] = temp[1];
1319  020d 7b19          	ld	a,(OFST-1,sp)
1320  020f 6b0c          	ld	(OFST-14,sp),a
1321                     ; 236 counter = 7; 
1323  0211 a607          	ld	a,#7
1324  0213 6b1a          	ld	(OFST+0,sp),a
1325                     ; 237 Coil = FirstCoil + 1;
1327  0215 7b03          	ld	a,(OFST-23,sp)
1328  0217 4c            	inc	a
1329  0218 6b16          	ld	(OFST-4,sp),a
1330                     ; 238 n = NumberOfCoils;
1332  021a 7b04          	ld	a,(OFST-22,sp)
1333  021c 6b15          	ld	(OFST-5,sp),a
1335  021e cc02d8        	jra	L145
1336  0221               L535:
1337                     ; 241 		if(n>=8)                   //    zamiana oktetu na HEX
1339  0221 a108          	cp	a,#8
1340  0223 2556          	jrult	L545
1341                     ; 243 						uint8_t pwr = 0;
1343                     ; 244 						for(pwr =0; pwr<8; pwr++,Coil++)
1345  0225 0f02          	clr	(OFST-24,sp)
1346  0227               L745:
1347                     ; 246 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
1349  0227 ae0000        	ldw	x,#_Input_Registers
1350  022a 89            	pushw	x
1351  022b 7b18          	ld	a,(OFST-2,sp)
1352  022d cd017b        	call	_StateOfCoil
1354  0230 85            	popw	x
1355  0231 6b01          	ld	(OFST-25,sp),a
1356  0233 5f            	clrw	x
1357  0234 7b02          	ld	a,(OFST-24,sp)
1358  0236 97            	ld	xl,a
1359  0237 a601          	ld	a,#1
1360  0239 5d            	tnzw	x
1361  023a 2704          	jreq	L421
1362  023c               L621:
1363  023c 48            	sll	a
1364  023d 5a            	decw	x
1365  023e 26fc          	jrne	L621
1366  0240               L421:
1367  0240 97            	ld	xl,a
1368  0241 7b01          	ld	a,(OFST-25,sp)
1369  0243 42            	mul	x,a
1370  0244 9f            	ld	a,xl
1371  0245 1b17          	add	a,(OFST-3,sp)
1372  0247 6b17          	ld	(OFST-3,sp),a
1373                     ; 247 								n--;
1375  0249 0a15          	dec	(OFST-5,sp)
1376                     ; 244 						for(pwr =0; pwr<8; pwr++,Coil++)
1378  024b 0c02          	inc	(OFST-24,sp)
1379  024d 0c16          	inc	(OFST-4,sp)
1382  024f 7b02          	ld	a,(OFST-24,sp)
1383  0251 a108          	cp	a,#8
1384  0253 25d2          	jrult	L745
1385                     ; 250 						ByteToHex(temp,TempSum);
1387  0255 7b17          	ld	a,(OFST-3,sp)
1388  0257 88            	push	a
1389  0258 96            	ldw	x,sp
1390  0259 1c0019        	addw	x,#OFST-1
1391  025c cd00a7        	call	_ByteToHex
1393  025f 84            	pop	a
1394                     ; 251 						TempSum = 0;
1396  0260 0f17          	clr	(OFST-3,sp)
1397                     ; 252 						OutputFrame[counter] = temp[0];
1399  0262 96            	ldw	x,sp
1400  0263 cd02fe        	call	LC003
1401  0266 1b1a          	add	a,(OFST+0,sp)
1402  0268 2401          	jrnc	L231
1403  026a 5c            	incw	x
1404  026b               L231:
1405  026b 02            	rlwa	x,a
1406  026c 7b18          	ld	a,(OFST-2,sp)
1407  026e f7            	ld	(x),a
1408                     ; 253 						counter++;
1410                     ; 254 						OutputFrame[counter] = temp[1];
1412  026f 96            	ldw	x,sp
1413  0270 0c1a          	inc	(OFST+0,sp)
1414  0272 cd02fe        	call	LC003
1415  0275 1b1a          	add	a,(OFST+0,sp)
1416  0277 2459          	jrnc	L051
1417                     ; 255 						counter++;
1419  0279 2056          	jp	LC002
1420  027b               L545:
1421                     ; 260 						uint8_t pwr = 0;
1423                     ; 261 						uint8_t zm = n;
1425  027b 6b05          	ld	(OFST-21,sp),a
1426                     ; 262 						for(pwr =0; pwr<zm; pwr++,Coil++)
1428  027d 0f02          	clr	(OFST-24,sp)
1430  027f 2028          	jra	L365
1431  0281               L755:
1432                     ; 264 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
1434  0281 ae0000        	ldw	x,#_Input_Registers
1435  0284 89            	pushw	x
1436  0285 7b18          	ld	a,(OFST-2,sp)
1437  0287 cd017b        	call	_StateOfCoil
1439  028a 85            	popw	x
1440  028b 6b01          	ld	(OFST-25,sp),a
1441  028d 5f            	clrw	x
1442  028e 7b02          	ld	a,(OFST-24,sp)
1443  0290 97            	ld	xl,a
1444  0291 a601          	ld	a,#1
1445  0293 5d            	tnzw	x
1446  0294 2704          	jreq	L041
1447  0296               L241:
1448  0296 48            	sll	a
1449  0297 5a            	decw	x
1450  0298 26fc          	jrne	L241
1451  029a               L041:
1452  029a 97            	ld	xl,a
1453  029b 7b01          	ld	a,(OFST-25,sp)
1454  029d 42            	mul	x,a
1455  029e 9f            	ld	a,xl
1456  029f 1b17          	add	a,(OFST-3,sp)
1457  02a1 6b17          	ld	(OFST-3,sp),a
1458                     ; 265 								n--;
1460  02a3 0a15          	dec	(OFST-5,sp)
1461                     ; 262 						for(pwr =0; pwr<zm; pwr++,Coil++)
1463  02a5 0c02          	inc	(OFST-24,sp)
1464  02a7 0c16          	inc	(OFST-4,sp)
1465  02a9               L365:
1468  02a9 7b02          	ld	a,(OFST-24,sp)
1469  02ab 1105          	cp	a,(OFST-21,sp)
1470  02ad 25d2          	jrult	L755
1471                     ; 267 						ByteToHex(temp,TempSum);
1473  02af 7b17          	ld	a,(OFST-3,sp)
1474  02b1 88            	push	a
1475  02b2 96            	ldw	x,sp
1476  02b3 1c0019        	addw	x,#OFST-1
1477  02b6 cd00a7        	call	_ByteToHex
1479  02b9 84            	pop	a
1480                     ; 268 						TempSum = 0;
1482  02ba 0f17          	clr	(OFST-3,sp)
1483                     ; 269 						OutputFrame[counter] = temp[0];
1485  02bc 96            	ldw	x,sp
1486  02bd ad3f          	call	LC003
1487  02bf 1b1a          	add	a,(OFST+0,sp)
1488  02c1 2401          	jrnc	L641
1489  02c3 5c            	incw	x
1490  02c4               L641:
1491  02c4 02            	rlwa	x,a
1492  02c5 7b18          	ld	a,(OFST-2,sp)
1493  02c7 f7            	ld	(x),a
1494                     ; 270 						counter++;
1496                     ; 271 						OutputFrame[counter] = temp[1];
1498  02c8 96            	ldw	x,sp
1499  02c9 0c1a          	inc	(OFST+0,sp)
1500  02cb ad31          	call	LC003
1501  02cd 1b1a          	add	a,(OFST+0,sp)
1502  02cf 2401          	jrnc	L051
1503  02d1               LC002:
1504  02d1 5c            	incw	x
1505  02d2               L051:
1506                     ; 272 						counter++;
1508  02d2 02            	rlwa	x,a
1509  02d3 7b19          	ld	a,(OFST-1,sp)
1510  02d5 f7            	ld	(x),a
1512  02d6 0c1a          	inc	(OFST+0,sp)
1513  02d8               L145:
1514                     ; 239 while(n>0)
1516  02d8 7b15          	ld	a,(OFST-5,sp)
1517  02da 2703cc0221    	jrne	L535
1518                     ; 277 for(counter; counter<=15; counter++)
1521  02df 200d          	jra	L375
1522  02e1               L765:
1523                     ; 279 			OutputFrame[counter] = '*';
1525  02e1 ad1b          	call	LC003
1526  02e3 1b1a          	add	a,(OFST+0,sp)
1527  02e5 2401          	jrnc	L251
1528  02e7 5c            	incw	x
1529  02e8               L251:
1530  02e8 02            	rlwa	x,a
1531  02e9 a62a          	ld	a,#42
1532  02eb f7            	ld	(x),a
1533                     ; 277 for(counter; counter<=15; counter++)
1535  02ec 0c1a          	inc	(OFST+0,sp)
1536  02ee               L375:
1539  02ee 7b1a          	ld	a,(OFST+0,sp)
1540  02f0 a110          	cp	a,#16
1541  02f2 96            	ldw	x,sp
1542  02f3 25ec          	jrult	L765
1543                     ; 281 UART_SendStr(OutputFrame); 
1545  02f5 1c0006        	addw	x,#OFST-20
1546  02f8 cd0000        	call	_UART_SendStr
1548                     ; 283 }
1551  02fb 5b1a          	addw	sp,#26
1552  02fd 81            	ret	
1553  02fe               LC003:
1554  02fe 1c0006        	addw	x,#OFST-20
1555  0301 9f            	ld	a,xl
1556  0302 5e            	swapw	x
1557  0303 81            	ret	
1581                     ; 287 void ReadInputStatus(void)
1581                     ; 288 {
1582                     	switch	.text
1583  0304               _ReadInputStatus:
1587                     ; 289 UART_SendStr("Function 2 Handled");
1589  0304 ae0000        	ldw	x,#L706
1591                     ; 290 }
1594  0307 cc0000        	jp	_UART_SendStr
1618                     ; 291 void ReadHoldingRegisters(void)
1618                     ; 292 {}
1619                     	switch	.text
1620  030a               _ReadHoldingRegisters:
1627  030a 81            	ret	
1650                     ; 293 void ReadInputRegisters(void)
1650                     ; 294 {}
1651                     	switch	.text
1652  030b               _ReadInputRegisters:
1659  030b 81            	ret	
1682                     ; 295 void ForceSingleCoil(void)
1682                     ; 296 {}
1683                     	switch	.text
1684  030c               _ForceSingleCoil:
1691  030c 81            	ret	
1715                     ; 297 void PresetSingleRegister(void)
1715                     ; 298 {}
1716                     	switch	.text
1717  030d               _PresetSingleRegister:
1724  030d 81            	ret	
1737                     	xref.b	_Input_Registers
1738                     	xref.b	_word
1739                     	xref.b	_Address
1740                     	xref.b	_TimmingDelay
1741                     	xdef	_StateOfCoil
1742                     	xdef	_RewritingChars
1743                     	xdef	_PresetSingleRegister
1744                     	xdef	_ForceSingleCoil
1745                     	xdef	_ReadInputRegisters
1746                     	xdef	_ReadHoldingRegisters
1747                     	xdef	_ReadInputStatus
1748                     	xdef	_ReadCoilStatus
1749                     	xdef	___checkFunc
1750                     	xdef	___checkAddr
1751                     	xdef	_SetDevAddr
1752                     	xdef	_HexToByte
1753                     	xdef	_ByteToHex
1754                     	xdef	_UART_SendStr
1755                     	xdef	_Modbus_Init
1756                     	xdef	_Delay
1757                     	xdef	_Delay_Init
1758                     	xref	_UART2_SendData8
1759                     	xref	_UART2_ITConfig
1760                     	xref	_UART2_Cmd
1761                     	xref	_UART2_Init
1762                     	xref	_UART2_DeInit
1763                     	xref	_TIM3_ITConfig
1764                     	xref	_TIM3_Cmd
1765                     	xref	_TIM3_TimeBaseInit
1766                     	xref	_TIM3_DeInit
1767                     	xref	_TIM2_ITConfig
1768                     	xref	_TIM2_Cmd
1769                     	xref	_TIM2_TimeBaseInit
1770                     	xref	_TIM2_DeInit
1771                     	xref	_GPIO_WriteLow
1772                     	xref	_GPIO_WriteHigh
1773                     	xref	_GPIO_Init
1774                     	xref	_GPIO_DeInit
1775                     	xref	_CLK_HSIPrescalerConfig
1776                     .const:	section	.text
1777  0000               L706:
1778  0000 46756e637469  	dc.b	"Function 2 Handled",0
1798                     	xref	c_lzmp
1799                     	end
