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
 750                     ; 141 	if(Function_Number == 1 || Function_Number == 2 || Function_Number == 3 || Function_Number == 4 || Function_Number == 5 || Function_Number == 6 || Function_Number == 16)
 752  0130 a101          	cp	a,#1
 753  0132 2718          	jreq	L772
 755  0134 a102          	cp	a,#2
 756  0136 2714          	jreq	L772
 758  0138 a103          	cp	a,#3
 759  013a 2710          	jreq	L772
 761  013c a104          	cp	a,#4
 762  013e 270c          	jreq	L772
 764  0140 a105          	cp	a,#5
 765  0142 2708          	jreq	L772
 767  0144 a106          	cp	a,#6
 768  0146 2704          	jreq	L772
 770  0148 a110          	cp	a,#16
 771  014a 2603          	jrne	L572
 772  014c               L772:
 773                     ; 143 		return 1;
 775  014c a601          	ld	a,#1
 778  014e 81            	ret	
 779  014f               L572:
 780                     ; 147 		return 0;
 782  014f 4f            	clr	a
 785  0150 81            	ret	
 821                     ; 151 void SetDevAddr(uint8_t Addr)
 821                     ; 152 {
 822                     	switch	.text
 823  0151               _SetDevAddr:
 825  0151 88            	push	a
 826       00000000      OFST:	set	0
 829                     ; 153 	if(__checkAddr(Addr))
 831  0152 add9          	call	___checkAddr
 833  0154 4d            	tnz	a
 834  0155 2704          	jreq	L333
 835                     ; 155 	Address = Addr;
 837  0157 7b01          	ld	a,(OFST+1,sp)
 838  0159 b700          	ld	_Address,a
 839  015b               L333:
 840                     ; 157 }
 843  015b 84            	pop	a
 844  015c 81            	ret	
 898                     ; 159 void RewritingChars(char *destination, uint8_t from, uint8_t to)
 898                     ; 160 {
 899                     	switch	.text
 900  015d               _RewritingChars:
 902  015d 89            	pushw	x
 903       00000000      OFST:	set	0
 906                     ; 161 for(from; from<=to; ++from)
 909  015e 2017          	jra	L763
 910  0160               L363:
 911                     ; 163 	destination[from] = word[from];	
 913  0160 7b01          	ld	a,(OFST+1,sp)
 914  0162 97            	ld	xl,a
 915  0163 7b02          	ld	a,(OFST+2,sp)
 916  0165 1b05          	add	a,(OFST+5,sp)
 917  0167 2401          	jrnc	L67
 918  0169 5c            	incw	x
 919  016a               L67:
 920  016a 02            	rlwa	x,a
 921  016b 7b05          	ld	a,(OFST+5,sp)
 922  016d 905f          	clrw	y
 923  016f 9097          	ld	yl,a
 924  0171 90e600        	ld	a,(_word,y)
 925  0174 f7            	ld	(x),a
 926                     ; 161 for(from; from<=to; ++from)
 928  0175 0c05          	inc	(OFST+5,sp)
 929  0177               L763:
 932  0177 7b05          	ld	a,(OFST+5,sp)
 933  0179 1106          	cp	a,(OFST+6,sp)
 934  017b 23e3          	jrule	L363
 935                     ; 166 }
 938  017d 85            	popw	x
 939  017e 81            	ret	
1022                     ; 171 bool StateOfCoil(uint8_t NumberOfCoil, uint16_t registers[])
1022                     ; 172 {
1023                     	switch	.text
1024  017f               _StateOfCoil:
1026  017f 88            	push	a
1027  0180 5204          	subw	sp,#4
1028       00000004      OFST:	set	4
1031                     ; 174 	uint16_t Value = registers[NumberOfCoil/16];   
1033  0182 5f            	clrw	x
1034  0183 97            	ld	xl,a
1035  0184 57            	sraw	x
1036  0185 57            	sraw	x
1037  0186 57            	sraw	x
1038  0187 57            	sraw	x
1039  0188 58            	sllw	x
1040  0189 72fb08        	addw	x,(OFST+4,sp)
1041  018c fe            	ldw	x,(x)
1042  018d 1f01          	ldw	(OFST-3,sp),x
1043                     ; 177 	uint16_t Compare = 1<<(NumberOfCoil%16);			
1045  018f ae0001        	ldw	x,#1
1046  0192 a40f          	and	a,#15
1047  0194 2704          	jreq	L201
1048  0196               L401:
1049  0196 58            	sllw	x
1050  0197 4a            	dec	a
1051  0198 26fc          	jrne	L401
1052  019a               L201:
1053  019a 1f03          	ldw	(OFST-1,sp),x
1054                     ; 179 	if ((Value & Compare) == Compare  )
1056  019c 1e01          	ldw	x,(OFST-3,sp)
1057  019e 01            	rrwa	x,a
1058  019f 1404          	and	a,(OFST+0,sp)
1059  01a1 01            	rrwa	x,a
1060  01a2 1403          	and	a,(OFST-1,sp)
1061  01a4 01            	rrwa	x,a
1062  01a5 1303          	cpw	x,(OFST-1,sp)
1063  01a7 2604          	jrne	L534
1064                     ; 181 				return 1;
1066  01a9 a601          	ld	a,#1
1068  01ab 2001          	jra	L601
1069  01ad               L534:
1070                     ; 186 				return 0;
1072  01ad 4f            	clr	a
1074  01ae               L601:
1076  01ae 5b05          	addw	sp,#5
1077  01b0 81            	ret	
1240                     ; 192 void ReadCoilStatus(uint16_t *registers)
1240                     ; 193 {
1241                     	switch	.text
1242  01b1               _ReadCoilStatus:
1244  01b1 89            	pushw	x
1245  01b2 522c          	subw	sp,#44
1246       0000002c      OFST:	set	44
1249                     ; 196 uint8_t counter = 0;
1251                     ; 198 uint8_t TempSum=0;
1253  01b4 0f0e          	clr	(OFST-30,sp)
1254                     ; 205 uint16_t n = 0;
1256                     ; 209 for(n = 0; n<25; n++){OutputFrame[n] = '\0';}
1258  01b6 5f            	clrw	x
1259  01b7 1f2a          	ldw	(OFST-2,sp),x
1260  01b9               L345:
1263  01b9 96            	ldw	x,sp
1264  01ba 1c0011        	addw	x,#OFST-27
1265  01bd 72fb2a        	addw	x,(OFST-2,sp)
1266  01c0 7f            	clr	(x)
1269  01c1 1e2a          	ldw	x,(OFST-2,sp)
1270  01c3 5c            	incw	x
1271  01c4 1f2a          	ldw	(OFST-2,sp),x
1274  01c6 a30019        	cpw	x,#25
1275  01c9 25ee          	jrult	L345
1276                     ; 211 Input_Registers[0] = 0b0000000011111111;
1278  01cb ae00ff        	ldw	x,#255
1279  01ce bf00          	ldw	_Input_Registers,x
1280                     ; 216 RewritingChars(OutputFrame,0,4);
1282  01d0 4b04          	push	#4
1283  01d2 4b00          	push	#0
1284  01d4 96            	ldw	x,sp
1285  01d5 1c0013        	addw	x,#OFST-25
1286  01d8 ad83          	call	_RewritingChars
1288  01da b605          	ld	a,_word+5
1289  01dc 85            	popw	x
1290                     ; 219 temp4[0] = word[5];
1292  01dd 6b08          	ld	(OFST-36,sp),a
1293                     ; 220 temp4[1] = word[6];
1295  01df b606          	ld	a,_word+6
1296  01e1 6b09          	ld	(OFST-35,sp),a
1297                     ; 221 temp4[2] = word[7];
1299  01e3 b607          	ld	a,_word+7
1300  01e5 6b0a          	ld	(OFST-34,sp),a
1301                     ; 222 temp4[3] = word[8];
1303  01e7 b608          	ld	a,_word+8
1304  01e9 6b0b          	ld	(OFST-33,sp),a
1305                     ; 223 HexToByte_4(temp4, &FirstCoil);
1307  01eb 96            	ldw	x,sp
1308  01ec 1c0003        	addw	x,#OFST-41
1309  01ef 89            	pushw	x
1310  01f0 1c0005        	addw	x,#5
1311  01f3 cd0562        	call	_HexToByte_4
1313  01f6 b609          	ld	a,_word+9
1314  01f8 85            	popw	x
1315                     ; 226 temp4[0] = word[9];
1317  01f9 6b08          	ld	(OFST-36,sp),a
1318                     ; 227 temp4[1] = word[10];
1320  01fb b60a          	ld	a,_word+10
1321  01fd 6b09          	ld	(OFST-35,sp),a
1322                     ; 228 temp4[2] = word[11];
1324  01ff b60b          	ld	a,_word+11
1325  0201 6b0a          	ld	(OFST-34,sp),a
1326                     ; 229 temp4[3] = word[12];
1328  0203 b60c          	ld	a,_word+12
1329  0205 6b0b          	ld	(OFST-33,sp),a
1330                     ; 230 HexToByte_4(temp4, &NumberOfCoils);
1332  0207 96            	ldw	x,sp
1333  0208 1c0005        	addw	x,#OFST-39
1334  020b 89            	pushw	x
1335  020c 1c0003        	addw	x,#3
1336  020f cd0562        	call	_HexToByte_4
1338  0212 85            	popw	x
1339                     ; 233 if((NumberOfCoils%8)!=0)
1341  0213 7b06          	ld	a,(OFST-38,sp)
1342  0215 a507          	bcp	a,#7
1343  0217 2709          	jreq	L155
1344                     ; 235 	NumberOfDataBytes = ( NumberOfCoils/8)+1;
1346  0219 1e05          	ldw	x,(OFST-39,sp)
1347  021b 54            	srlw	x
1348  021c 54            	srlw	x
1349  021d 54            	srlw	x
1350  021e 01            	rrwa	x,a
1351  021f 4c            	inc	a
1353  0220 2006          	jra	L355
1354  0222               L155:
1355                     ; 239 	NumberOfDataBytes = NumberOfCoils/8;
1357  0222 1e05          	ldw	x,(OFST-39,sp)
1358  0224 54            	srlw	x
1359  0225 54            	srlw	x
1360  0226 54            	srlw	x
1361  0227 01            	rrwa	x,a
1362  0228               L355:
1363  0228 6b07          	ld	(OFST-37,sp),a
1364                     ; 243 ByteToHex(temp,NumberOfDataBytes);
1366  022a 88            	push	a
1367  022b 96            	ldw	x,sp
1368  022c 1c0010        	addw	x,#OFST-28
1369  022f cd00a7        	call	_ByteToHex
1371  0232 84            	pop	a
1372                     ; 244 OutputFrame[5] = temp[0];
1374  0233 7b0f          	ld	a,(OFST-29,sp)
1375  0235 6b16          	ld	(OFST-22,sp),a
1376                     ; 245 OutputFrame[6] = temp[1];
1378  0237 7b10          	ld	a,(OFST-28,sp)
1379  0239 6b17          	ld	(OFST-21,sp),a
1380                     ; 248 counter = 7; 
1382  023b a607          	ld	a,#7
1383  023d 6b2c          	ld	(OFST+0,sp),a
1384                     ; 249 Coil = FirstCoil;
1386  023f 1e03          	ldw	x,(OFST-41,sp)
1387  0241 1f0c          	ldw	(OFST-32,sp),x
1388                     ; 250 n = NumberOfCoils;
1390  0243 1e05          	ldw	x,(OFST-39,sp)
1391  0245 1f2a          	ldw	(OFST-2,sp),x
1393  0247 cc0310        	jra	L165
1394  024a               L555:
1395                     ; 253 		if(n>=8)                   //    changing 8bits to hex
1397  024a a30008        	cpw	x,#8
1398  024d 255b          	jrult	L565
1399                     ; 255 						uint8_t pwr = 0;
1401                     ; 256 						for(pwr =0; pwr<8; pwr++,Coil++)
1403  024f 0f02          	clr	(OFST-42,sp)
1404  0251               L765:
1405                     ; 258 								TempSum += (1<<pwr)*StateOfCoil(Coil, registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
1407  0251 1e2d          	ldw	x,(OFST+1,sp)
1408  0253 89            	pushw	x
1409  0254 7b0f          	ld	a,(OFST-29,sp)
1410  0256 cd017f        	call	_StateOfCoil
1412  0259 85            	popw	x
1413  025a 6b01          	ld	(OFST-43,sp),a
1414  025c 5f            	clrw	x
1415  025d 7b02          	ld	a,(OFST-42,sp)
1416  025f 97            	ld	xl,a
1417  0260 a601          	ld	a,#1
1418  0262 5d            	tnzw	x
1419  0263 2704          	jreq	L421
1420  0265               L621:
1421  0265 48            	sll	a
1422  0266 5a            	decw	x
1423  0267 26fc          	jrne	L621
1424  0269               L421:
1425  0269 97            	ld	xl,a
1426  026a 7b01          	ld	a,(OFST-43,sp)
1427  026c 42            	mul	x,a
1428  026d 9f            	ld	a,xl
1429  026e 1b0e          	add	a,(OFST-30,sp)
1430  0270 6b0e          	ld	(OFST-30,sp),a
1431                     ; 259 								n--;
1433  0272 1e2a          	ldw	x,(OFST-2,sp)
1434  0274 5a            	decw	x
1435  0275 1f2a          	ldw	(OFST-2,sp),x
1436                     ; 256 						for(pwr =0; pwr<8; pwr++,Coil++)
1438  0277 0c02          	inc	(OFST-42,sp)
1439  0279 1e0c          	ldw	x,(OFST-32,sp)
1440  027b 5c            	incw	x
1441  027c 1f0c          	ldw	(OFST-32,sp),x
1444  027e 7b02          	ld	a,(OFST-42,sp)
1445  0280 a108          	cp	a,#8
1446  0282 25cd          	jrult	L765
1447                     ; 262 						ByteToHex(temp,TempSum);
1449  0284 7b0e          	ld	a,(OFST-30,sp)
1450  0286 88            	push	a
1451  0287 96            	ldw	x,sp
1452  0288 1c0010        	addw	x,#OFST-28
1453  028b cd00a7        	call	_ByteToHex
1455  028e 84            	pop	a
1456                     ; 263 						TempSum = 0;
1458  028f 0f0e          	clr	(OFST-30,sp)
1459                     ; 264 						OutputFrame[counter] = temp[0];
1461  0291 96            	ldw	x,sp
1462  0292 cd0377        	call	LC003
1463  0295 1b2c          	add	a,(OFST+0,sp)
1464  0297 2401          	jrnc	L231
1465  0299 5c            	incw	x
1466  029a               L231:
1467  029a 02            	rlwa	x,a
1468  029b 7b0f          	ld	a,(OFST-29,sp)
1469  029d f7            	ld	(x),a
1470                     ; 265 						counter++;
1472                     ; 266 						OutputFrame[counter] = temp[1];
1474  029e 96            	ldw	x,sp
1475  029f 0c2c          	inc	(OFST+0,sp)
1476  02a1 cd0377        	call	LC003
1477  02a4 1b2c          	add	a,(OFST+0,sp)
1478  02a6 2462          	jrnc	L051
1479                     ; 267 						counter++;
1481  02a8 205f          	jp	LC002
1482  02aa               L565:
1483                     ; 272 						uint8_t pwr = 0;
1485                     ; 273 						uint8_t zm = n;
1487  02aa 7b2b          	ld	a,(OFST-1,sp)
1488  02ac 6b07          	ld	(OFST-37,sp),a
1489                     ; 274 						for(pwr =0; pwr<zm; pwr++,Coil++)
1491  02ae 0f02          	clr	(OFST-42,sp)
1493  02b0 202e          	jra	L306
1494  02b2               L775:
1495                     ; 276 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
1497  02b2 ae0000        	ldw	x,#_Input_Registers
1498  02b5 89            	pushw	x
1499  02b6 7b0f          	ld	a,(OFST-29,sp)
1500  02b8 cd017f        	call	_StateOfCoil
1502  02bb 85            	popw	x
1503  02bc 6b01          	ld	(OFST-43,sp),a
1504  02be 5f            	clrw	x
1505  02bf 7b02          	ld	a,(OFST-42,sp)
1506  02c1 97            	ld	xl,a
1507  02c2 a601          	ld	a,#1
1508  02c4 5d            	tnzw	x
1509  02c5 2704          	jreq	L041
1510  02c7               L241:
1511  02c7 48            	sll	a
1512  02c8 5a            	decw	x
1513  02c9 26fc          	jrne	L241
1514  02cb               L041:
1515  02cb 97            	ld	xl,a
1516  02cc 7b01          	ld	a,(OFST-43,sp)
1517  02ce 42            	mul	x,a
1518  02cf 9f            	ld	a,xl
1519  02d0 1b0e          	add	a,(OFST-30,sp)
1520  02d2 6b0e          	ld	(OFST-30,sp),a
1521                     ; 277 								n--;
1523  02d4 1e2a          	ldw	x,(OFST-2,sp)
1524  02d6 5a            	decw	x
1525  02d7 1f2a          	ldw	(OFST-2,sp),x
1526                     ; 274 						for(pwr =0; pwr<zm; pwr++,Coil++)
1528  02d9 0c02          	inc	(OFST-42,sp)
1529  02db 1e0c          	ldw	x,(OFST-32,sp)
1530  02dd 5c            	incw	x
1531  02de 1f0c          	ldw	(OFST-32,sp),x
1532  02e0               L306:
1535  02e0 7b02          	ld	a,(OFST-42,sp)
1536  02e2 1107          	cp	a,(OFST-37,sp)
1537  02e4 25cc          	jrult	L775
1538                     ; 279 						ByteToHex(temp,TempSum);
1540  02e6 7b0e          	ld	a,(OFST-30,sp)
1541  02e8 88            	push	a
1542  02e9 96            	ldw	x,sp
1543  02ea 1c0010        	addw	x,#OFST-28
1544  02ed cd00a7        	call	_ByteToHex
1546  02f0 84            	pop	a
1547                     ; 280 						TempSum = 0;
1549  02f1 0f0e          	clr	(OFST-30,sp)
1550                     ; 281 						OutputFrame[counter] = temp[0];
1552  02f3 96            	ldw	x,sp
1553  02f4 cd0377        	call	LC003
1554  02f7 1b2c          	add	a,(OFST+0,sp)
1555  02f9 2401          	jrnc	L641
1556  02fb 5c            	incw	x
1557  02fc               L641:
1558  02fc 02            	rlwa	x,a
1559  02fd 7b0f          	ld	a,(OFST-29,sp)
1560  02ff f7            	ld	(x),a
1561                     ; 282 						counter++;
1563                     ; 283 						OutputFrame[counter] = temp[1];
1565  0300 96            	ldw	x,sp
1566  0301 0c2c          	inc	(OFST+0,sp)
1567  0303 ad72          	call	LC003
1568  0305 1b2c          	add	a,(OFST+0,sp)
1569  0307 2401          	jrnc	L051
1570  0309               LC002:
1571  0309 5c            	incw	x
1572  030a               L051:
1573                     ; 284 						counter++;
1575  030a 02            	rlwa	x,a
1576  030b 7b10          	ld	a,(OFST-28,sp)
1577  030d f7            	ld	(x),a
1579  030e 0c2c          	inc	(OFST+0,sp)
1580  0310               L165:
1581                     ; 251 while(n>0)
1583  0310 1e2a          	ldw	x,(OFST-2,sp)
1584  0312 2703cc024a    	jrne	L555
1585                     ; 297 ByteToHex(temp,GetLRC(OutputFrame));
1587  0317 96            	ldw	x,sp
1588  0318 1c0011        	addw	x,#OFST-27
1589  031b cd0531        	call	_GetLRC
1591  031e 88            	push	a
1592  031f 96            	ldw	x,sp
1593  0320 1c0010        	addw	x,#OFST-28
1594  0323 cd00a7        	call	_ByteToHex
1596  0326 84            	pop	a
1597                     ; 298 OutputFrame[counter] = temp[0];
1599  0327 96            	ldw	x,sp
1600  0328 ad4d          	call	LC003
1601  032a 1b2c          	add	a,(OFST+0,sp)
1602  032c 2401          	jrnc	L651
1603  032e 5c            	incw	x
1604  032f               L651:
1605  032f 02            	rlwa	x,a
1606  0330 7b0f          	ld	a,(OFST-29,sp)
1607  0332 f7            	ld	(x),a
1608                     ; 299 counter++;
1610                     ; 300 OutputFrame[counter] = temp[1];
1612  0333 96            	ldw	x,sp
1613  0334 0c2c          	inc	(OFST+0,sp)
1614  0336 ad3f          	call	LC003
1615  0338 1b2c          	add	a,(OFST+0,sp)
1616  033a 2401          	jrnc	L061
1617  033c 5c            	incw	x
1618  033d               L061:
1619  033d 02            	rlwa	x,a
1620  033e 7b10          	ld	a,(OFST-28,sp)
1621  0340 f7            	ld	(x),a
1622                     ; 301 counter++;
1624                     ; 302 OutputFrame[counter] = 0x0D;
1626  0341 96            	ldw	x,sp
1627  0342 0c2c          	inc	(OFST+0,sp)
1628  0344 ad31          	call	LC003
1629  0346 1b2c          	add	a,(OFST+0,sp)
1630  0348 2401          	jrnc	L261
1631  034a 5c            	incw	x
1632  034b               L261:
1633  034b 02            	rlwa	x,a
1634  034c a60d          	ld	a,#13
1635  034e f7            	ld	(x),a
1636                     ; 303 counter++;
1638                     ; 304 OutputFrame[counter] = 0x0A;
1640  034f 96            	ldw	x,sp
1641  0350 0c2c          	inc	(OFST+0,sp)
1642  0352 ad23          	call	LC003
1643  0354 1b2c          	add	a,(OFST+0,sp)
1644  0356 2401          	jrnc	L461
1645  0358 5c            	incw	x
1646  0359               L461:
1647  0359 02            	rlwa	x,a
1648  035a a60a          	ld	a,#10
1649  035c f7            	ld	(x),a
1650                     ; 305 counter++;
1652                     ; 306 OutputFrame[counter] = 0x0A;
1654  035d 96            	ldw	x,sp
1655  035e 0c2c          	inc	(OFST+0,sp)
1656  0360 ad15          	call	LC003
1657  0362 1b2c          	add	a,(OFST+0,sp)
1658  0364 2401          	jrnc	L661
1659  0366 5c            	incw	x
1660  0367               L661:
1661  0367 02            	rlwa	x,a
1662  0368 a60a          	ld	a,#10
1663  036a f7            	ld	(x),a
1664                     ; 307 counter++;
1666                     ; 310 	UART_SendStr(OutputFrame); 
1668  036b 96            	ldw	x,sp
1669  036c 0c2c          	inc	(OFST+0,sp)
1670  036e 1c0011        	addw	x,#OFST-27
1671  0371 cd0000        	call	_UART_SendStr
1673                     ; 311 }
1676  0374 5b2e          	addw	sp,#46
1677  0376 81            	ret	
1678  0377               LC003:
1679  0377 1c0011        	addw	x,#OFST-27
1680  037a 9f            	ld	a,xl
1681  037b 5e            	swapw	x
1682  037c 81            	ret	
1707                     ; 315 void ReadInputStatus(void)
1707                     ; 316 {
1708                     	switch	.text
1709  037d               _ReadInputStatus:
1713                     ; 317 ReadCoilStatus(Input_Registers);
1715  037d ae0000        	ldw	x,#_Input_Registers
1717                     ; 318 }
1720  0380 cc01b1        	jp	_ReadCoilStatus
1857                     ; 322 void ReadHoldingRegisters(uint16_t *registers)
1857                     ; 323 {
1858                     	switch	.text
1859  0383               _ReadHoldingRegisters:
1861  0383 89            	pushw	x
1862  0384 5228          	subw	sp,#40
1863       00000028      OFST:	set	40
1866                     ; 328 uint16_t FirstReg = 0;
1868  0386 5f            	clrw	x
1869  0387 1f01          	ldw	(OFST-39,sp),x
1870                     ; 329 uint16_t NumberOfRegs = 0;
1872  0389 1f05          	ldw	(OFST-35,sp),x
1873                     ; 330 uint8_t NumberOfBytes = 0 ;
1875                     ; 331 uint8_t ct = 0;
1877                     ; 332 uint8_t k = 0;
1879                     ; 333 uint8_t counter = 0;
1881                     ; 334 uint16_t Content_dec = 0;
1883                     ; 338 for(k = 0; k<25; k++){OutputFrame[k] = '\0';}
1885  038b 0f0a          	clr	(OFST-30,sp)
1886  038d               L507:
1889  038d 96            	ldw	x,sp
1890  038e cd04c6        	call	LC004
1891  0391 1b0a          	add	a,(OFST-30,sp)
1892  0393 2401          	jrnc	L002
1893  0395 5c            	incw	x
1894  0396               L002:
1895  0396 02            	rlwa	x,a
1896  0397 7f            	clr	(x)
1899  0398 0c0a          	inc	(OFST-30,sp)
1902  039a 7b0a          	ld	a,(OFST-30,sp)
1903  039c a119          	cp	a,#25
1904  039e 25ed          	jrult	L507
1905                     ; 341 RewritingChars(OutputFrame,0,4);
1907  03a0 4b04          	push	#4
1908  03a2 4b00          	push	#0
1909  03a4 96            	ldw	x,sp
1910  03a5 1c000d        	addw	x,#OFST-27
1911  03a8 cd015d        	call	_RewritingChars
1913  03ab b605          	ld	a,_word+5
1914  03ad 85            	popw	x
1915                     ; 344 temp[0] = word[5];
1917  03ae 6b24          	ld	(OFST-4,sp),a
1918                     ; 345 temp[1] = word[6];
1920  03b0 b606          	ld	a,_word+6
1921  03b2 6b25          	ld	(OFST-3,sp),a
1922                     ; 346 temp[2] = word[7];
1924  03b4 b607          	ld	a,_word+7
1925  03b6 6b26          	ld	(OFST-2,sp),a
1926                     ; 347 temp[3] = word[8];
1928  03b8 b608          	ld	a,_word+8
1929  03ba 6b27          	ld	(OFST-1,sp),a
1930                     ; 348 HexToByte_4(temp, &FirstReg);
1932  03bc 96            	ldw	x,sp
1933  03bd 5c            	incw	x
1934  03be 89            	pushw	x
1935  03bf 1c0023        	addw	x,#35
1936  03c2 cd0562        	call	_HexToByte_4
1938  03c5 b609          	ld	a,_word+9
1939  03c7 85            	popw	x
1940                     ; 351 temp[0] = word[9];
1942  03c8 6b24          	ld	(OFST-4,sp),a
1943                     ; 352 temp[1] = word[10];
1945  03ca b60a          	ld	a,_word+10
1946  03cc 6b25          	ld	(OFST-3,sp),a
1947                     ; 353 temp[2] = word[11];
1949  03ce b60b          	ld	a,_word+11
1950  03d0 6b26          	ld	(OFST-2,sp),a
1951                     ; 354 temp[3] = word[12];
1953  03d2 b60c          	ld	a,_word+12
1954  03d4 6b27          	ld	(OFST-1,sp),a
1955                     ; 355 HexToByte_4(temp, &NumberOfRegs);
1957  03d6 96            	ldw	x,sp
1958  03d7 1c0005        	addw	x,#OFST-35
1959  03da 89            	pushw	x
1960  03db 1c001f        	addw	x,#31
1961  03de cd0562        	call	_HexToByte_4
1963  03e1 85            	popw	x
1964                     ; 358 NumberOfBytes = NumberOfRegs*2;
1966  03e2 7b06          	ld	a,(OFST-34,sp)
1967  03e4 48            	sll	a
1968  03e5 6b09          	ld	(OFST-31,sp),a
1969                     ; 361 ByteToHex(temp,NumberOfBytes);
1971  03e7 88            	push	a
1972  03e8 96            	ldw	x,sp
1973  03e9 1c0025        	addw	x,#OFST-3
1974  03ec cd00a7        	call	_ByteToHex
1976  03ef 84            	pop	a
1977                     ; 362 OutputFrame[5] = temp[0];
1979  03f0 7b24          	ld	a,(OFST-4,sp)
1980  03f2 6b10          	ld	(OFST-24,sp),a
1981                     ; 363 OutputFrame[6] = temp[1];
1983  03f4 7b25          	ld	a,(OFST-3,sp)
1984  03f6 6b11          	ld	(OFST-23,sp),a
1985                     ; 365 counter = 7;
1987  03f8 a607          	ld	a,#7
1988  03fa 6b28          	ld	(OFST+0,sp),a
1989                     ; 366 k = FirstReg;
1991  03fc 7b02          	ld	a,(OFST-38,sp)
1992  03fe 6b0a          	ld	(OFST-30,sp),a
1993                     ; 368 Output_Registers[1] = 65535;
1995  0400 aeffff        	ldw	x,#65535
1996  0403 bf02          	ldw	_Output_Registers+2,x
1997                     ; 369 Output_Registers[2] = 65535;
1999  0405 bf04          	ldw	_Output_Registers+4,x
2000                     ; 371 for(ct=0;ct<NumberOfRegs;ct++)
2002  0407 0f09          	clr	(OFST-31,sp)
2004  0409 2053          	jra	L717
2005  040b               L317:
2006                     ; 373 		Content_dec = registers[k];
2008  040b 7b0a          	ld	a,(OFST-30,sp)
2009  040d 5f            	clrw	x
2010  040e 97            	ld	xl,a
2011  040f 58            	sllw	x
2012  0410 72fb29        	addw	x,(OFST+1,sp)
2013  0413 fe            	ldw	x,(x)
2014  0414 1f07          	ldw	(OFST-33,sp),x
2015                     ; 374 		ByteToHex_4(temp,Content_dec);
2017  0416 89            	pushw	x
2018  0417 96            	ldw	x,sp
2019  0418 1c0026        	addw	x,#OFST-2
2020  041b cd05c0        	call	_ByteToHex_4
2022  041e 85            	popw	x
2023                     ; 375 		OutputFrame[counter] = temp[0];
2025  041f 96            	ldw	x,sp
2026  0420 cd04c6        	call	LC004
2027  0423 1b28          	add	a,(OFST+0,sp)
2028  0425 2401          	jrnc	L412
2029  0427 5c            	incw	x
2030  0428               L412:
2031  0428 02            	rlwa	x,a
2032  0429 7b24          	ld	a,(OFST-4,sp)
2033  042b f7            	ld	(x),a
2034                     ; 376 		counter++;
2036                     ; 377 		OutputFrame[counter] = temp[1];
2038  042c 96            	ldw	x,sp
2039  042d 0c28          	inc	(OFST+0,sp)
2040  042f cd04c6        	call	LC004
2041  0432 1b28          	add	a,(OFST+0,sp)
2042  0434 2401          	jrnc	L612
2043  0436 5c            	incw	x
2044  0437               L612:
2045  0437 02            	rlwa	x,a
2046  0438 7b25          	ld	a,(OFST-3,sp)
2047  043a f7            	ld	(x),a
2048                     ; 378 		counter++;
2050                     ; 379 		OutputFrame[counter] = temp[2];
2052  043b 96            	ldw	x,sp
2053  043c 0c28          	inc	(OFST+0,sp)
2054  043e cd04c6        	call	LC004
2055  0441 1b28          	add	a,(OFST+0,sp)
2056  0443 2401          	jrnc	L022
2057  0445 5c            	incw	x
2058  0446               L022:
2059  0446 02            	rlwa	x,a
2060  0447 7b26          	ld	a,(OFST-2,sp)
2061  0449 f7            	ld	(x),a
2062                     ; 380 		counter++;
2064                     ; 381 		OutputFrame[counter] = temp[3];
2066  044a 96            	ldw	x,sp
2067  044b 0c28          	inc	(OFST+0,sp)
2068  044d ad77          	call	LC004
2069  044f 1b28          	add	a,(OFST+0,sp)
2070  0451 2401          	jrnc	L222
2071  0453 5c            	incw	x
2072  0454               L222:
2073  0454 02            	rlwa	x,a
2074  0455 7b27          	ld	a,(OFST-1,sp)
2075  0457 f7            	ld	(x),a
2076                     ; 382 		counter++;
2078  0458 0c28          	inc	(OFST+0,sp)
2079                     ; 383 		k++;
2081  045a 0c0a          	inc	(OFST-30,sp)
2082                     ; 371 for(ct=0;ct<NumberOfRegs;ct++)
2084  045c 0c09          	inc	(OFST-31,sp)
2085  045e               L717:
2088  045e 7b09          	ld	a,(OFST-31,sp)
2089  0460 5f            	clrw	x
2090  0461 97            	ld	xl,a
2091  0462 1305          	cpw	x,(OFST-35,sp)
2092  0464 25a5          	jrult	L317
2093                     ; 388 ByteToHex(temp2,GetLRC(OutputFrame));
2095  0466 96            	ldw	x,sp
2096  0467 1c000b        	addw	x,#OFST-29
2097  046a cd0531        	call	_GetLRC
2099  046d 88            	push	a
2100  046e 96            	ldw	x,sp
2101  046f 1c0004        	addw	x,#OFST-36
2102  0472 cd00a7        	call	_ByteToHex
2104  0475 84            	pop	a
2105                     ; 389 OutputFrame[counter] = temp2[0];
2107  0476 96            	ldw	x,sp
2108  0477 ad4d          	call	LC004
2109  0479 1b28          	add	a,(OFST+0,sp)
2110  047b 2401          	jrnc	L032
2111  047d 5c            	incw	x
2112  047e               L032:
2113  047e 02            	rlwa	x,a
2114  047f 7b03          	ld	a,(OFST-37,sp)
2115  0481 f7            	ld	(x),a
2116                     ; 390 counter++;
2118                     ; 391 OutputFrame[counter] = temp2[1];
2120  0482 96            	ldw	x,sp
2121  0483 0c28          	inc	(OFST+0,sp)
2122  0485 ad3f          	call	LC004
2123  0487 1b28          	add	a,(OFST+0,sp)
2124  0489 2401          	jrnc	L232
2125  048b 5c            	incw	x
2126  048c               L232:
2127  048c 02            	rlwa	x,a
2128  048d 7b04          	ld	a,(OFST-36,sp)
2129  048f f7            	ld	(x),a
2130                     ; 392 counter++;
2132                     ; 393 OutputFrame[counter] = 0x0D;
2134  0490 96            	ldw	x,sp
2135  0491 0c28          	inc	(OFST+0,sp)
2136  0493 ad31          	call	LC004
2137  0495 1b28          	add	a,(OFST+0,sp)
2138  0497 2401          	jrnc	L432
2139  0499 5c            	incw	x
2140  049a               L432:
2141  049a 02            	rlwa	x,a
2142  049b a60d          	ld	a,#13
2143  049d f7            	ld	(x),a
2144                     ; 394 counter++;
2146                     ; 395 OutputFrame[counter] = 0x0A;
2148  049e 96            	ldw	x,sp
2149  049f 0c28          	inc	(OFST+0,sp)
2150  04a1 ad23          	call	LC004
2151  04a3 1b28          	add	a,(OFST+0,sp)
2152  04a5 2401          	jrnc	L632
2153  04a7 5c            	incw	x
2154  04a8               L632:
2155  04a8 02            	rlwa	x,a
2156  04a9 a60a          	ld	a,#10
2157  04ab f7            	ld	(x),a
2158                     ; 396 counter++;
2160                     ; 397 OutputFrame[counter] = 0x0A;
2162  04ac 96            	ldw	x,sp
2163  04ad 0c28          	inc	(OFST+0,sp)
2164  04af ad15          	call	LC004
2165  04b1 1b28          	add	a,(OFST+0,sp)
2166  04b3 2401          	jrnc	L042
2167  04b5 5c            	incw	x
2168  04b6               L042:
2169  04b6 02            	rlwa	x,a
2170  04b7 a60a          	ld	a,#10
2171  04b9 f7            	ld	(x),a
2172                     ; 398 counter++;
2174                     ; 402 UART_SendStr(OutputFrame); 
2176  04ba 96            	ldw	x,sp
2177  04bb 0c28          	inc	(OFST+0,sp)
2178  04bd 1c000b        	addw	x,#OFST-29
2179  04c0 cd0000        	call	_UART_SendStr
2181                     ; 404 }
2184  04c3 5b2a          	addw	sp,#42
2185  04c5 81            	ret	
2186  04c6               LC004:
2187  04c6 1c000b        	addw	x,#OFST-29
2188  04c9 9f            	ld	a,xl
2189  04ca 5e            	swapw	x
2190  04cb 81            	ret	
2215                     ; 407 void ReadInputRegisters(void)
2215                     ; 408 {
2216                     	switch	.text
2217  04cc               _ReadInputRegisters:
2221                     ; 410 ReadHoldingRegisters(Input_Registers);
2223  04cc ae0000        	ldw	x,#_Input_Registers
2225                     ; 411 }
2228  04cf cc0383        	jp	_ReadHoldingRegisters
2251                     ; 415 void ForceSingleCoil(void)
2251                     ; 416 {}
2252                     	switch	.text
2253  04d2               _ForceSingleCoil:
2260  04d2 81            	ret	
2284                     ; 419 void PresetSingleRegister(void)
2284                     ; 420 {}
2285                     	switch	.text
2286  04d3               _PresetSingleRegister:
2293  04d3 81            	ret	
2378                     ; 423 bool CheckLRC(char *frame)
2378                     ; 424 {
2379                     	switch	.text
2380  04d4               _CheckLRC:
2382  04d4 89            	pushw	x
2383  04d5 5207          	subw	sp,#7
2384       00000007      OFST:	set	7
2387                     ; 425 	uint8_t a = 0;
2389  04d7 0f07          	clr	(OFST+0,sp)
2390                     ; 428 	uint8_t tempSum = 0;
2392  04d9 0f01          	clr	(OFST-6,sp)
2393                     ; 430 	uint8_t LRC_calculated = 0;
2395                     ; 432 	uint8_t LRC_dec_from_frame = 0;	
2397  04db 0f02          	clr	(OFST-5,sp)
2399  04dd 2002          	jra	L1201
2400  04df               L5101:
2401                     ; 437 				a++;
2403  04df 0c07          	inc	(OFST+0,sp)
2404  04e1               L1201:
2405                     ; 435 	while(word[a] != '\r')
2407  04e1 7b07          	ld	a,(OFST+0,sp)
2408  04e3 5f            	clrw	x
2409  04e4 97            	ld	xl,a
2410  04e5 e600          	ld	a,(_word,x)
2411  04e7 a10d          	cp	a,#13
2412  04e9 26f4          	jrne	L5101
2413                     ; 440 temp[1] = frame[a-1];
2415  04eb 7b07          	ld	a,(OFST+0,sp)
2416  04ed 5f            	clrw	x
2417  04ee 97            	ld	xl,a
2418  04ef 5a            	decw	x
2419  04f0 72fb08        	addw	x,(OFST+1,sp)
2420  04f3 f6            	ld	a,(x)
2421  04f4 6b04          	ld	(OFST-3,sp),a
2422                     ; 441 temp[0] = frame[a-2];
2424  04f6 5f            	clrw	x
2425  04f7 7b07          	ld	a,(OFST+0,sp)
2426  04f9 97            	ld	xl,a
2427  04fa 1d0002        	subw	x,#2
2428  04fd 72fb08        	addw	x,(OFST+1,sp)
2429  0500 f6            	ld	a,(x)
2430  0501 6b03          	ld	(OFST-4,sp),a
2431                     ; 443 HexToByte(temp,&LRC_dec_from_frame);
2433  0503 96            	ldw	x,sp
2434  0504 1c0002        	addw	x,#OFST-5
2435  0507 89            	pushw	x
2436  0508 5c            	incw	x
2437  0509 cd00df        	call	_HexToByte
2439  050c 85            	popw	x
2440                     ; 445 frame[a-1] = '\0';
2442  050d 7b07          	ld	a,(OFST+0,sp)
2443  050f 5f            	clrw	x
2444  0510 97            	ld	xl,a
2445  0511 5a            	decw	x
2446  0512 72fb08        	addw	x,(OFST+1,sp)
2447  0515 7f            	clr	(x)
2448                     ; 446 frame[a-2] = '\0';
2450  0516 5f            	clrw	x
2451  0517 97            	ld	xl,a
2452  0518 1d0002        	subw	x,#2
2453  051b 72fb08        	addw	x,(OFST+1,sp)
2454  051e 7f            	clr	(x)
2455                     ; 449 LRC_calculated = GetLRC(frame);
2457  051f 1e08          	ldw	x,(OFST+1,sp)
2458  0521 ad0e          	call	_GetLRC
2460  0523 6b07          	ld	(OFST+0,sp),a
2461                     ; 451 if (LRC_calculated == LRC_dec_from_frame)
2463  0525 1102          	cp	a,(OFST-5,sp)
2464  0527 2604          	jrne	L5201
2465                     ; 454 		return 1;
2467  0529 a601          	ld	a,#1
2469  052b 2001          	jra	L262
2470  052d               L5201:
2471                     ; 458 		return 0;
2473  052d 4f            	clr	a
2475  052e               L262:
2477  052e 5b09          	addw	sp,#9
2478  0530 81            	ret	
2542                     ; 462 uint8_t GetLRC(char *frame)
2542                     ; 463 {
2543                     	switch	.text
2544  0531               _GetLRC:
2546  0531 89            	pushw	x
2547  0532 5204          	subw	sp,#4
2548       00000004      OFST:	set	4
2551                     ; 464 uint8_t LRCsum = 0;
2553  0534 0f01          	clr	(OFST-3,sp)
2554                     ; 467 frame++;
2556  0536 1e05          	ldw	x,(OFST+1,sp)
2557  0538 5c            	incw	x
2558  0539 1f05          	ldw	(OFST+1,sp),x
2560  053b 201b          	jra	L5601
2561  053d               L3601:
2562                     ; 471 temp[0] = *frame++;
2564  053d 6b03          	ld	(OFST-1,sp),a
2565  053f 5c            	incw	x
2566                     ; 472 temp[1] = *frame++;
2568  0540 f6            	ld	a,(x)
2569  0541 5c            	incw	x
2570  0542 1f05          	ldw	(OFST+1,sp),x
2571  0544 6b04          	ld	(OFST+0,sp),a
2572                     ; 473 HexToByte(temp, &TempSum);
2574  0546 96            	ldw	x,sp
2575  0547 1c0002        	addw	x,#OFST-2
2576  054a 89            	pushw	x
2577  054b 5c            	incw	x
2578  054c cd00df        	call	_HexToByte
2580  054f 85            	popw	x
2581                     ; 474 LRCsum += TempSum;
2583  0550 7b01          	ld	a,(OFST-3,sp)
2584  0552 1b02          	add	a,(OFST-2,sp)
2585  0554 6b01          	ld	(OFST-3,sp),a
2586  0556 1e05          	ldw	x,(OFST+1,sp)
2587  0558               L5601:
2588                     ; 469 while(*frame)
2590  0558 f6            	ld	a,(x)
2591  0559 26e2          	jrne	L3601
2592                     ; 476 LRCsum = (~(LRCsum)+1);
2594  055b 7b01          	ld	a,(OFST-3,sp)
2595  055d 43            	cpl	a
2596  055e 4c            	inc	a
2597                     ; 477 return LRCsum;
2601  055f 5b06          	addw	sp,#6
2602  0561 81            	ret	
2694                     ; 481 void HexToByte_4(char *hexstring_4, uint16_t *byte)
2694                     ; 482 {
2695                     	switch	.text
2696  0562               _HexToByte_4:
2698  0562 89            	pushw	x
2699  0563 5208          	subw	sp,#8
2700       00000008      OFST:	set	8
2703                     ; 484 uint8_t right_dec = 0;
2705  0565 0f01          	clr	(OFST-7,sp)
2706                     ; 485 uint8_t left_dec = 0;
2708  0567 0f02          	clr	(OFST-6,sp)
2709                     ; 486 uint16_t right_dec16 = 0;
2711  0569 5f            	clrw	x
2712  056a 1f03          	ldw	(OFST-5,sp),x
2713                     ; 487 uint16_t left_dec16 = 0;
2715  056c 1f05          	ldw	(OFST-3,sp),x
2716                     ; 489 tempp[0] = hexstring_4[0];
2718  056e 1e09          	ldw	x,(OFST+1,sp)
2719  0570 f6            	ld	a,(x)
2720  0571 6b07          	ld	(OFST-1,sp),a
2721                     ; 490 tempp[1] = hexstring_4[1];
2723  0573 e601          	ld	a,(1,x)
2724  0575 6b08          	ld	(OFST+0,sp),a
2725                     ; 491 HexToByte(tempp,&left_dec);
2727  0577 96            	ldw	x,sp
2728  0578 1c0002        	addw	x,#OFST-6
2729  057b 89            	pushw	x
2730  057c 1c0005        	addw	x,#5
2731  057f cd00df        	call	_HexToByte
2733  0582 85            	popw	x
2734                     ; 493 tempp[0] = hexstring_4[2];
2736  0583 1e09          	ldw	x,(OFST+1,sp)
2737  0585 e602          	ld	a,(2,x)
2738  0587 6b07          	ld	(OFST-1,sp),a
2739                     ; 494 tempp[1] = hexstring_4[3];
2741  0589 e603          	ld	a,(3,x)
2742  058b 6b08          	ld	(OFST+0,sp),a
2743                     ; 495 HexToByte(tempp,&right_dec);
2745  058d 96            	ldw	x,sp
2746  058e 5c            	incw	x
2747  058f 89            	pushw	x
2748  0590 1c0006        	addw	x,#6
2749  0593 cd00df        	call	_HexToByte
2751  0596 85            	popw	x
2752                     ; 497 left_dec16 = left_dec16 | left_dec;
2754  0597 7b02          	ld	a,(OFST-6,sp)
2755  0599 5f            	clrw	x
2756  059a 97            	ld	xl,a
2757  059b 01            	rrwa	x,a
2758  059c 1a06          	or	a,(OFST-2,sp)
2759  059e 01            	rrwa	x,a
2760  059f 1a05          	or	a,(OFST-3,sp)
2761  05a1 01            	rrwa	x,a
2762  05a2 1f05          	ldw	(OFST-3,sp),x
2763                     ; 498 right_dec16 = right_dec16 | right_dec;
2765  05a4 5f            	clrw	x
2766  05a5 7b01          	ld	a,(OFST-7,sp)
2767  05a7 97            	ld	xl,a
2768  05a8 01            	rrwa	x,a
2769  05a9 1a04          	or	a,(OFST-4,sp)
2770  05ab 01            	rrwa	x,a
2771  05ac 1a03          	or	a,(OFST-5,sp)
2772  05ae 01            	rrwa	x,a
2773  05af 1f03          	ldw	(OFST-5,sp),x
2774                     ; 500 *byte = (left_dec16 << 8) | right_dec16;
2776  05b1 7b04          	ld	a,(OFST-4,sp)
2777  05b3 1e05          	ldw	x,(OFST-3,sp)
2778  05b5 01            	rrwa	x,a
2779  05b6 1a03          	or	a,(OFST-5,sp)
2780  05b8 160d          	ldw	y,(OFST+5,sp)
2781  05ba 01            	rrwa	x,a
2782  05bb 90ff          	ldw	(y),x
2783                     ; 501 }
2786  05bd 5b0a          	addw	sp,#10
2787  05bf 81            	ret	
2897                     ; 505 void ByteToHex_4(char *hexstring, uint16_t byte)
2897                     ; 506 {
2898                     	switch	.text
2899  05c0               _ByteToHex_4:
2901  05c0 89            	pushw	x
2902  05c1 520b          	subw	sp,#11
2903       0000000b      OFST:	set	11
2906                     ; 509 	uint16_t D1 = byte >> 8;
2908  05c3 1e10          	ldw	x,(OFST+5,sp)
2909  05c5 4f            	clr	a
2910  05c6 01            	rrwa	x,a
2911  05c7 1f02          	ldw	(OFST-9,sp),x
2912                     ; 510   uint16_t D2 = byte & 255;
2914  05c9 5f            	clrw	x
2915  05ca 7b11          	ld	a,(OFST+6,sp)
2916  05cc 02            	rlwa	x,a
2917  05cd 1f04          	ldw	(OFST-7,sp),x
2918                     ; 511 	uint8_t D1_8 = 0;
2920  05cf 0f06          	clr	(OFST-5,sp)
2921                     ; 512 	uint8_t D2_8 = 0;
2923  05d1 0f07          	clr	(OFST-4,sp)
2924                     ; 513 	uint8_t ct = 0;
2926  05d3 0f01          	clr	(OFST-10,sp)
2927                     ; 515 	D1_8 |= D1;
2929  05d5 7b06          	ld	a,(OFST-5,sp)
2930  05d7 1a03          	or	a,(OFST-8,sp)
2931  05d9 6b06          	ld	(OFST-5,sp),a
2932                     ; 516 	D2_8 |= D2;
2934  05db 7b07          	ld	a,(OFST-4,sp)
2935  05dd 1a05          	or	a,(OFST-6,sp)
2936  05df 6b07          	ld	(OFST-4,sp),a
2937                     ; 518 	ByteToHex(temp1, D1_8);
2939  05e1 7b06          	ld	a,(OFST-5,sp)
2940  05e3 88            	push	a
2941  05e4 96            	ldw	x,sp
2942  05e5 1c0009        	addw	x,#OFST-2
2943  05e8 cd00a7        	call	_ByteToHex
2945  05eb 84            	pop	a
2946                     ; 519 	ByteToHex(temp2, D2_8);
2948  05ec 7b07          	ld	a,(OFST-4,sp)
2949  05ee 88            	push	a
2950  05ef 96            	ldw	x,sp
2951  05f0 1c000b        	addw	x,#OFST+0
2952  05f3 cd00a7        	call	_ByteToHex
2954  05f6 84            	pop	a
2955                     ; 521 	hexstring[0] = temp1[0];
2957  05f7 1e0c          	ldw	x,(OFST+1,sp)
2958  05f9 7b08          	ld	a,(OFST-3,sp)
2959  05fb f7            	ld	(x),a
2960                     ; 522 	hexstring[1] = temp1[1];
2962  05fc 7b09          	ld	a,(OFST-2,sp)
2963  05fe e701          	ld	(1,x),a
2964                     ; 523 	hexstring[2] = temp2[0];
2966  0600 7b0a          	ld	a,(OFST-1,sp)
2967  0602 e702          	ld	(2,x),a
2968                     ; 524 	hexstring[3] = temp2[1];
2970  0604 7b0b          	ld	a,(OFST+0,sp)
2971  0606 e703          	ld	(3,x),a
2972                     ; 526 }
2975  0608 5b0d          	addw	sp,#13
2976  060a 81            	ret	
2989                     	xref.b	_Output_Registers
2990                     	xref.b	_Input_Registers
2991                     	xref.b	_word
2992                     	xref.b	_Address
2993                     	xref.b	_TimmingDelay
2994                     	xdef	_StateOfCoil
2995                     	xdef	_RewritingChars
2996                     	xdef	_PresetSingleRegister
2997                     	xdef	_ForceSingleCoil
2998                     	xdef	_ReadInputRegisters
2999                     	xdef	_ReadHoldingRegisters
3000                     	xdef	_ReadInputStatus
3001                     	xdef	_ReadCoilStatus
3002                     	xdef	___checkFunc
3003                     	xdef	___checkAddr
3004                     	xdef	_ByteToHex_4
3005                     	xdef	_GetLRC
3006                     	xdef	_CheckLRC
3007                     	xdef	_SetDevAddr
3008                     	xdef	_HexToByte_4
3009                     	xdef	_HexToByte
3010                     	xdef	_ByteToHex
3011                     	xdef	_UART_SendStr
3012                     	xdef	_Modbus_Init
3013                     	xdef	_Delay
3014                     	xdef	_Delay_Init
3015                     	xref	_UART2_SendData8
3016                     	xref	_UART2_ITConfig
3017                     	xref	_UART2_Cmd
3018                     	xref	_UART2_Init
3019                     	xref	_UART2_DeInit
3020                     	xref	_TIM3_ITConfig
3021                     	xref	_TIM3_Cmd
3022                     	xref	_TIM3_TimeBaseInit
3023                     	xref	_TIM3_DeInit
3024                     	xref	_TIM2_ITConfig
3025                     	xref	_TIM2_Cmd
3026                     	xref	_TIM2_TimeBaseInit
3027                     	xref	_TIM2_DeInit
3028                     	xref	_GPIO_WriteLow
3029                     	xref	_GPIO_WriteHigh
3030                     	xref	_GPIO_Init
3031                     	xref	_GPIO_DeInit
3032                     	xref	_CLK_HSIPrescalerConfig
3051                     	xref	c_lzmp
3052                     	end
