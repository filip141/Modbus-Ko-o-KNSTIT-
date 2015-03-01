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
1227                     ; 190 void ReadCoilStatus(void)
1227                     ; 191 {
1228                     	switch	.text
1229  01ad               _ReadCoilStatus:
1231  01ad 522c          	subw	sp,#44
1232       0000002c      OFST:	set	44
1235                     ; 194 uint8_t counter = 0;
1237                     ; 196 uint8_t TempSum=0;
1239  01af 0f0e          	clr	(OFST-30,sp)
1240                     ; 203 uint16_t n = 0;
1242                     ; 207 for(n = 0; n<25; n++){OutputFrame[n] = '\0';}
1244  01b1 5f            	clrw	x
1245  01b2 1f2a          	ldw	(OFST-2,sp),x
1246  01b4               L535:
1249  01b4 96            	ldw	x,sp
1250  01b5 1c000f        	addw	x,#OFST-29
1251  01b8 72fb2a        	addw	x,(OFST-2,sp)
1252  01bb 7f            	clr	(x)
1255  01bc 1e2a          	ldw	x,(OFST-2,sp)
1256  01be 5c            	incw	x
1257  01bf 1f2a          	ldw	(OFST-2,sp),x
1260  01c1 a30019        	cpw	x,#25
1261  01c4 25ee          	jrult	L535
1262                     ; 209 Input_Registers[0] = 0b111111000101;
1264  01c6 ae0fc5        	ldw	x,#4037
1265  01c9 bf00          	ldw	_Input_Registers,x
1266                     ; 214 RewritingChars(OutputFrame,0,4);
1268  01cb 4b04          	push	#4
1269  01cd 4b00          	push	#0
1270  01cf 96            	ldw	x,sp
1271  01d0 1c0011        	addw	x,#OFST-27
1272  01d3 ad84          	call	_RewritingChars
1274  01d5 b605          	ld	a,_word+5
1275  01d7 85            	popw	x
1276                     ; 217 temp4[0] = word[5];
1278  01d8 6b08          	ld	(OFST-36,sp),a
1279                     ; 218 temp4[1] = word[6];
1281  01da b606          	ld	a,_word+6
1282  01dc 6b09          	ld	(OFST-35,sp),a
1283                     ; 219 temp4[2] = word[7];
1285  01de b607          	ld	a,_word+7
1286  01e0 6b0a          	ld	(OFST-34,sp),a
1287                     ; 220 temp4[3] = word[8];
1289  01e2 b608          	ld	a,_word+8
1290  01e4 6b0b          	ld	(OFST-33,sp),a
1291                     ; 221 HexToByte_4(temp4, &FirstCoil);
1293  01e6 96            	ldw	x,sp
1294  01e7 1c0003        	addw	x,#OFST-41
1295  01ea 89            	pushw	x
1296  01eb 1c0005        	addw	x,#5
1297  01ee cd051e        	call	_HexToByte_4
1299  01f1 b609          	ld	a,_word+9
1300  01f3 85            	popw	x
1301                     ; 224 temp4[0] = word[9];
1303  01f4 6b08          	ld	(OFST-36,sp),a
1304                     ; 225 temp4[1] = word[10];
1306  01f6 b60a          	ld	a,_word+10
1307  01f8 6b09          	ld	(OFST-35,sp),a
1308                     ; 226 temp4[2] = word[11];
1310  01fa b60b          	ld	a,_word+11
1311  01fc 6b0a          	ld	(OFST-34,sp),a
1312                     ; 227 temp4[3] = word[12];
1314  01fe b60c          	ld	a,_word+12
1315  0200 6b0b          	ld	(OFST-33,sp),a
1316                     ; 228 HexToByte_4(temp4, &NumberOfCoils);
1318  0202 96            	ldw	x,sp
1319  0203 1c0005        	addw	x,#OFST-39
1320  0206 89            	pushw	x
1321  0207 1c0003        	addw	x,#3
1322  020a cd051e        	call	_HexToByte_4
1324  020d 85            	popw	x
1325                     ; 231 if((NumberOfCoils%8)!=0)
1327  020e 7b06          	ld	a,(OFST-38,sp)
1328  0210 a507          	bcp	a,#7
1329  0212 2709          	jreq	L345
1330                     ; 233 	NumberOfDataBytes = ( NumberOfCoils/8)+1;
1332  0214 1e05          	ldw	x,(OFST-39,sp)
1333  0216 54            	srlw	x
1334  0217 54            	srlw	x
1335  0218 54            	srlw	x
1336  0219 01            	rrwa	x,a
1337  021a 4c            	inc	a
1339  021b 2006          	jra	L545
1340  021d               L345:
1341                     ; 237 	NumberOfDataBytes = NumberOfCoils/8;
1343  021d 1e05          	ldw	x,(OFST-39,sp)
1344  021f 54            	srlw	x
1345  0220 54            	srlw	x
1346  0221 54            	srlw	x
1347  0222 01            	rrwa	x,a
1348  0223               L545:
1349  0223 6b07          	ld	(OFST-37,sp),a
1350                     ; 241 ByteToHex(temp,NumberOfDataBytes);
1352  0225 88            	push	a
1353  0226 96            	ldw	x,sp
1354  0227 1c0029        	addw	x,#OFST-3
1355  022a cd00a7        	call	_ByteToHex
1357  022d 84            	pop	a
1358                     ; 242 OutputFrame[5] = temp[0];
1360  022e 7b28          	ld	a,(OFST-4,sp)
1361  0230 6b14          	ld	(OFST-24,sp),a
1362                     ; 243 OutputFrame[6] = temp[1];
1364  0232 7b29          	ld	a,(OFST-3,sp)
1365  0234 6b15          	ld	(OFST-23,sp),a
1366                     ; 246 counter = 7; 
1368  0236 a607          	ld	a,#7
1369  0238 6b2c          	ld	(OFST+0,sp),a
1370                     ; 247 Coil = FirstCoil;
1372  023a 1e03          	ldw	x,(OFST-41,sp)
1373  023c 1f0c          	ldw	(OFST-32,sp),x
1374                     ; 248 n = NumberOfCoils;
1376  023e 1e05          	ldw	x,(OFST-39,sp)
1377  0240 1f2a          	ldw	(OFST-2,sp),x
1379  0242 cc030b        	jra	L355
1380  0245               L745:
1381                     ; 251 		if(n>=8)                   //    changing 8bits to hex
1383  0245 a30008        	cpw	x,#8
1384  0248 255c          	jrult	L755
1385                     ; 253 						uint8_t pwr = 0;
1387                     ; 254 						for(pwr =0; pwr<8; pwr++,Coil++)
1389  024a 0f02          	clr	(OFST-42,sp)
1390  024c               L165:
1391                     ; 256 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
1393  024c ae0000        	ldw	x,#_Input_Registers
1394  024f 89            	pushw	x
1395  0250 7b0f          	ld	a,(OFST-29,sp)
1396  0252 cd017b        	call	_StateOfCoil
1398  0255 85            	popw	x
1399  0256 6b01          	ld	(OFST-43,sp),a
1400  0258 5f            	clrw	x
1401  0259 7b02          	ld	a,(OFST-42,sp)
1402  025b 97            	ld	xl,a
1403  025c a601          	ld	a,#1
1404  025e 5d            	tnzw	x
1405  025f 2704          	jreq	L421
1406  0261               L621:
1407  0261 48            	sll	a
1408  0262 5a            	decw	x
1409  0263 26fc          	jrne	L621
1410  0265               L421:
1411  0265 97            	ld	xl,a
1412  0266 7b01          	ld	a,(OFST-43,sp)
1413  0268 42            	mul	x,a
1414  0269 9f            	ld	a,xl
1415  026a 1b0e          	add	a,(OFST-30,sp)
1416  026c 6b0e          	ld	(OFST-30,sp),a
1417                     ; 257 								n--;
1419  026e 1e2a          	ldw	x,(OFST-2,sp)
1420  0270 5a            	decw	x
1421  0271 1f2a          	ldw	(OFST-2,sp),x
1422                     ; 254 						for(pwr =0; pwr<8; pwr++,Coil++)
1424  0273 0c02          	inc	(OFST-42,sp)
1425  0275 1e0c          	ldw	x,(OFST-32,sp)
1426  0277 5c            	incw	x
1427  0278 1f0c          	ldw	(OFST-32,sp),x
1430  027a 7b02          	ld	a,(OFST-42,sp)
1431  027c a108          	cp	a,#8
1432  027e 25cc          	jrult	L165
1433                     ; 260 						ByteToHex(temp,TempSum);
1435  0280 7b0e          	ld	a,(OFST-30,sp)
1436  0282 88            	push	a
1437  0283 96            	ldw	x,sp
1438  0284 1c0029        	addw	x,#OFST-3
1439  0287 cd00a7        	call	_ByteToHex
1441  028a 84            	pop	a
1442                     ; 261 						TempSum = 0;
1444  028b 0f0e          	clr	(OFST-30,sp)
1445                     ; 262 						OutputFrame[counter] = temp[0];
1447  028d 96            	ldw	x,sp
1448  028e cd0364        	call	LC003
1449  0291 1b2c          	add	a,(OFST+0,sp)
1450  0293 2401          	jrnc	L231
1451  0295 5c            	incw	x
1452  0296               L231:
1453  0296 02            	rlwa	x,a
1454  0297 7b28          	ld	a,(OFST-4,sp)
1455  0299 f7            	ld	(x),a
1456                     ; 263 						counter++;
1458                     ; 264 						OutputFrame[counter] = temp[1];
1460  029a 96            	ldw	x,sp
1461  029b 0c2c          	inc	(OFST+0,sp)
1462  029d cd0364        	call	LC003
1463  02a0 1b2c          	add	a,(OFST+0,sp)
1464  02a2 2461          	jrnc	L051
1465                     ; 265 						counter++;
1467  02a4 205e          	jp	LC002
1468  02a6               L755:
1469                     ; 270 						uint8_t pwr = 0;
1471                     ; 271 						uint8_t zm = n;
1473  02a6 7b2b          	ld	a,(OFST-1,sp)
1474  02a8 6b07          	ld	(OFST-37,sp),a
1475                     ; 272 						for(pwr =0; pwr<zm; pwr++,Coil++)
1477  02aa 0f02          	clr	(OFST-42,sp)
1479  02ac 202e          	jra	L575
1480  02ae               L175:
1481                     ; 274 								TempSum += (1<<pwr)*StateOfCoil(Coil, Input_Registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
1483  02ae ae0000        	ldw	x,#_Input_Registers
1484  02b1 89            	pushw	x
1485  02b2 7b0f          	ld	a,(OFST-29,sp)
1486  02b4 cd017b        	call	_StateOfCoil
1488  02b7 85            	popw	x
1489  02b8 6b01          	ld	(OFST-43,sp),a
1490  02ba 5f            	clrw	x
1491  02bb 7b02          	ld	a,(OFST-42,sp)
1492  02bd 97            	ld	xl,a
1493  02be a601          	ld	a,#1
1494  02c0 5d            	tnzw	x
1495  02c1 2704          	jreq	L041
1496  02c3               L241:
1497  02c3 48            	sll	a
1498  02c4 5a            	decw	x
1499  02c5 26fc          	jrne	L241
1500  02c7               L041:
1501  02c7 97            	ld	xl,a
1502  02c8 7b01          	ld	a,(OFST-43,sp)
1503  02ca 42            	mul	x,a
1504  02cb 9f            	ld	a,xl
1505  02cc 1b0e          	add	a,(OFST-30,sp)
1506  02ce 6b0e          	ld	(OFST-30,sp),a
1507                     ; 275 								n--;
1509  02d0 1e2a          	ldw	x,(OFST-2,sp)
1510  02d2 5a            	decw	x
1511  02d3 1f2a          	ldw	(OFST-2,sp),x
1512                     ; 272 						for(pwr =0; pwr<zm; pwr++,Coil++)
1514  02d5 0c02          	inc	(OFST-42,sp)
1515  02d7 1e0c          	ldw	x,(OFST-32,sp)
1516  02d9 5c            	incw	x
1517  02da 1f0c          	ldw	(OFST-32,sp),x
1518  02dc               L575:
1521  02dc 7b02          	ld	a,(OFST-42,sp)
1522  02de 1107          	cp	a,(OFST-37,sp)
1523  02e0 25cc          	jrult	L175
1524                     ; 277 						ByteToHex(temp,TempSum);
1526  02e2 7b0e          	ld	a,(OFST-30,sp)
1527  02e4 88            	push	a
1528  02e5 96            	ldw	x,sp
1529  02e6 1c0029        	addw	x,#OFST-3
1530  02e9 cd00a7        	call	_ByteToHex
1532  02ec 84            	pop	a
1533                     ; 278 						TempSum = 0;
1535  02ed 0f0e          	clr	(OFST-30,sp)
1536                     ; 279 						OutputFrame[counter] = temp[0];
1538  02ef 96            	ldw	x,sp
1539  02f0 ad72          	call	LC003
1540  02f2 1b2c          	add	a,(OFST+0,sp)
1541  02f4 2401          	jrnc	L641
1542  02f6 5c            	incw	x
1543  02f7               L641:
1544  02f7 02            	rlwa	x,a
1545  02f8 7b28          	ld	a,(OFST-4,sp)
1546  02fa f7            	ld	(x),a
1547                     ; 280 						counter++;
1549                     ; 281 						OutputFrame[counter] = temp[1];
1551  02fb 96            	ldw	x,sp
1552  02fc 0c2c          	inc	(OFST+0,sp)
1553  02fe ad64          	call	LC003
1554  0300 1b2c          	add	a,(OFST+0,sp)
1555  0302 2401          	jrnc	L051
1556  0304               LC002:
1557  0304 5c            	incw	x
1558  0305               L051:
1559                     ; 282 						counter++;
1561  0305 02            	rlwa	x,a
1562  0306 7b29          	ld	a,(OFST-3,sp)
1563  0308 f7            	ld	(x),a
1565  0309 0c2c          	inc	(OFST+0,sp)
1566  030b               L355:
1567                     ; 249 while(n>0)
1569  030b 1e2a          	ldw	x,(OFST-2,sp)
1570  030d 2703cc0245    	jrne	L745
1571                     ; 295 ByteToHex(temp,GetLRC(OutputFrame));
1573  0312 96            	ldw	x,sp
1574  0313 1c000f        	addw	x,#OFST-29
1575  0316 cd04ed        	call	_GetLRC
1577  0319 88            	push	a
1578  031a 96            	ldw	x,sp
1579  031b 1c0029        	addw	x,#OFST-3
1580  031e cd00a7        	call	_ByteToHex
1582  0321 84            	pop	a
1583                     ; 296 OutputFrame[counter] = temp[0];
1585  0322 96            	ldw	x,sp
1586  0323 ad3f          	call	LC003
1587  0325 1b2c          	add	a,(OFST+0,sp)
1588  0327 2401          	jrnc	L651
1589  0329 5c            	incw	x
1590  032a               L651:
1591  032a 02            	rlwa	x,a
1592  032b 7b28          	ld	a,(OFST-4,sp)
1593  032d f7            	ld	(x),a
1594                     ; 297 counter++;
1596                     ; 298 OutputFrame[counter] = temp[1];
1598  032e 96            	ldw	x,sp
1599  032f 0c2c          	inc	(OFST+0,sp)
1600  0331 ad31          	call	LC003
1601  0333 1b2c          	add	a,(OFST+0,sp)
1602  0335 2401          	jrnc	L061
1603  0337 5c            	incw	x
1604  0338               L061:
1605  0338 02            	rlwa	x,a
1606  0339 7b29          	ld	a,(OFST-3,sp)
1607  033b f7            	ld	(x),a
1608                     ; 299 counter++;
1610                     ; 300 OutputFrame[counter] = 0x0D;
1612  033c 96            	ldw	x,sp
1613  033d 0c2c          	inc	(OFST+0,sp)
1614  033f ad23          	call	LC003
1615  0341 1b2c          	add	a,(OFST+0,sp)
1616  0343 2401          	jrnc	L261
1617  0345 5c            	incw	x
1618  0346               L261:
1619  0346 02            	rlwa	x,a
1620  0347 a60d          	ld	a,#13
1621  0349 f7            	ld	(x),a
1622                     ; 301 counter++;
1624                     ; 302 OutputFrame[counter] = 0x0A;
1626  034a 96            	ldw	x,sp
1627  034b 0c2c          	inc	(OFST+0,sp)
1628  034d ad15          	call	LC003
1629  034f 1b2c          	add	a,(OFST+0,sp)
1630  0351 2401          	jrnc	L461
1631  0353 5c            	incw	x
1632  0354               L461:
1633  0354 02            	rlwa	x,a
1634  0355 a60a          	ld	a,#10
1635  0357 f7            	ld	(x),a
1636                     ; 303 counter++;
1638                     ; 305 UART_SendStr(OutputFrame); 
1640  0358 96            	ldw	x,sp
1641  0359 0c2c          	inc	(OFST+0,sp)
1642  035b 1c000f        	addw	x,#OFST-29
1643  035e cd0000        	call	_UART_SendStr
1645                     ; 306 }
1648  0361 5b2c          	addw	sp,#44
1649  0363 81            	ret	
1650  0364               LC003:
1651  0364 1c000f        	addw	x,#OFST-29
1652  0367 9f            	ld	a,xl
1653  0368 5e            	swapw	x
1654  0369 81            	ret	
1677                     ; 310 void ReadInputStatus(void)
1677                     ; 311 {
1678                     	switch	.text
1679  036a               _ReadInputStatus:
1683                     ; 314 }
1686  036a 81            	ret	
1813                     ; 317 void ReadHoldingRegisters(void)
1813                     ; 318 {
1814                     	switch	.text
1815  036b               _ReadHoldingRegisters:
1817  036b 5228          	subw	sp,#40
1818       00000028      OFST:	set	40
1821                     ; 323 uint16_t FirstReg = 0;
1823  036d 5f            	clrw	x
1824  036e 1f01          	ldw	(OFST-39,sp),x
1825                     ; 324 uint16_t NumberOfRegs = 0;
1827  0370 1f05          	ldw	(OFST-35,sp),x
1828                     ; 325 uint8_t NumberOfBytes = 0 ;
1830                     ; 326 uint8_t ct = 0;
1832                     ; 327 uint8_t k = 0;
1834                     ; 328 uint8_t counter = 0;
1836                     ; 329 uint16_t Content_dec = 0;
1838                     ; 332 RewritingChars(OutputFrame,0,4);
1840  0372 4b04          	push	#4
1841  0374 4b00          	push	#0
1842  0376 96            	ldw	x,sp
1843  0377 1c000d        	addw	x,#OFST-27
1844  037a cd0159        	call	_RewritingChars
1846  037d b605          	ld	a,_word+5
1847  037f 85            	popw	x
1848                     ; 335 temp[0] = word[5];
1850  0380 6b24          	ld	(OFST-4,sp),a
1851                     ; 336 temp[1] = word[6];
1853  0382 b606          	ld	a,_word+6
1854  0384 6b25          	ld	(OFST-3,sp),a
1855                     ; 337 temp[2] = word[7];
1857  0386 b607          	ld	a,_word+7
1858  0388 6b26          	ld	(OFST-2,sp),a
1859                     ; 338 temp[3] = word[8];
1861  038a b608          	ld	a,_word+8
1862  038c 6b27          	ld	(OFST-1,sp),a
1863                     ; 339 HexToByte_4(temp, &FirstReg);
1865  038e 96            	ldw	x,sp
1866  038f 5c            	incw	x
1867  0390 89            	pushw	x
1868  0391 1c0023        	addw	x,#35
1869  0394 cd051e        	call	_HexToByte_4
1871  0397 b609          	ld	a,_word+9
1872  0399 85            	popw	x
1873                     ; 342 temp[0] = word[9];
1875  039a 6b24          	ld	(OFST-4,sp),a
1876                     ; 343 temp[1] = word[10];
1878  039c b60a          	ld	a,_word+10
1879  039e 6b25          	ld	(OFST-3,sp),a
1880                     ; 344 temp[2] = word[11];
1882  03a0 b60b          	ld	a,_word+11
1883  03a2 6b26          	ld	(OFST-2,sp),a
1884                     ; 345 temp[3] = word[12];
1886  03a4 b60c          	ld	a,_word+12
1887  03a6 6b27          	ld	(OFST-1,sp),a
1888                     ; 346 HexToByte_4(temp, &NumberOfRegs);
1890  03a8 96            	ldw	x,sp
1891  03a9 1c0005        	addw	x,#OFST-35
1892  03ac 89            	pushw	x
1893  03ad 1c001f        	addw	x,#31
1894  03b0 cd051e        	call	_HexToByte_4
1896  03b3 85            	popw	x
1897                     ; 349 NumberOfBytes = NumberOfRegs*2;
1899  03b4 7b06          	ld	a,(OFST-34,sp)
1900  03b6 48            	sll	a
1901  03b7 6b0a          	ld	(OFST-30,sp),a
1902                     ; 352 ByteToHex(temp,NumberOfBytes);
1904  03b9 88            	push	a
1905  03ba 96            	ldw	x,sp
1906  03bb 1c0025        	addw	x,#OFST-3
1907  03be cd00a7        	call	_ByteToHex
1909  03c1 84            	pop	a
1910                     ; 353 OutputFrame[5] = temp[0];
1912  03c2 7b24          	ld	a,(OFST-4,sp)
1913  03c4 6b10          	ld	(OFST-24,sp),a
1914                     ; 354 OutputFrame[6] = temp[1];
1916  03c6 7b25          	ld	a,(OFST-3,sp)
1917  03c8 6b11          	ld	(OFST-23,sp),a
1918                     ; 356 counter = 7;
1920  03ca a607          	ld	a,#7
1921  03cc 6b28          	ld	(OFST+0,sp),a
1922                     ; 357 k = FirstReg;
1924  03ce 7b02          	ld	a,(OFST-38,sp)
1925  03d0 6b09          	ld	(OFST-31,sp),a
1926                     ; 359 Output_Registers[1] = 65535;
1928  03d2 aeffff        	ldw	x,#65535
1929  03d5 bf02          	ldw	_Output_Registers+2,x
1930                     ; 360 Output_Registers[2] = 65535;
1932  03d7 bf04          	ldw	_Output_Registers+4,x
1933                     ; 362 for(ct=0;ct<NumberOfRegs;ct++)
1935  03d9 0f0a          	clr	(OFST-30,sp)
1937  03db 2050          	jra	L776
1938  03dd               L376:
1939                     ; 364 		Content_dec = Output_Registers[k];
1941  03dd 7b09          	ld	a,(OFST-31,sp)
1942  03df 5f            	clrw	x
1943  03e0 97            	ld	xl,a
1944  03e1 58            	sllw	x
1945  03e2 ee00          	ldw	x,(_Output_Registers,x)
1946  03e4 1f07          	ldw	(OFST-33,sp),x
1947                     ; 365 		ByteToHex_4(temp,Content_dec);
1949  03e6 89            	pushw	x
1950  03e7 96            	ldw	x,sp
1951  03e8 1c0026        	addw	x,#OFST-2
1952  03eb cd057c        	call	_ByteToHex_4
1954  03ee 85            	popw	x
1955                     ; 366 		OutputFrame[counter] = temp[0];
1957  03ef 96            	ldw	x,sp
1958  03f0 cd0487        	call	LC004
1959  03f3 1b28          	add	a,(OFST+0,sp)
1960  03f5 2401          	jrnc	L602
1961  03f7 5c            	incw	x
1962  03f8               L602:
1963  03f8 02            	rlwa	x,a
1964  03f9 7b24          	ld	a,(OFST-4,sp)
1965  03fb f7            	ld	(x),a
1966                     ; 367 		counter++;
1968                     ; 368 		OutputFrame[counter] = temp[1];
1970  03fc 96            	ldw	x,sp
1971  03fd 0c28          	inc	(OFST+0,sp)
1972  03ff cd0487        	call	LC004
1973  0402 1b28          	add	a,(OFST+0,sp)
1974  0404 2401          	jrnc	L012
1975  0406 5c            	incw	x
1976  0407               L012:
1977  0407 02            	rlwa	x,a
1978  0408 7b25          	ld	a,(OFST-3,sp)
1979  040a f7            	ld	(x),a
1980                     ; 369 		counter++;
1982                     ; 370 		OutputFrame[counter] = temp[2];
1984  040b 96            	ldw	x,sp
1985  040c 0c28          	inc	(OFST+0,sp)
1986  040e ad77          	call	LC004
1987  0410 1b28          	add	a,(OFST+0,sp)
1988  0412 2401          	jrnc	L212
1989  0414 5c            	incw	x
1990  0415               L212:
1991  0415 02            	rlwa	x,a
1992  0416 7b26          	ld	a,(OFST-2,sp)
1993  0418 f7            	ld	(x),a
1994                     ; 371 		counter++;
1996                     ; 372 		OutputFrame[counter] = temp[3];
1998  0419 96            	ldw	x,sp
1999  041a 0c28          	inc	(OFST+0,sp)
2000  041c ad69          	call	LC004
2001  041e 1b28          	add	a,(OFST+0,sp)
2002  0420 2401          	jrnc	L412
2003  0422 5c            	incw	x
2004  0423               L412:
2005  0423 02            	rlwa	x,a
2006  0424 7b27          	ld	a,(OFST-1,sp)
2007  0426 f7            	ld	(x),a
2008                     ; 373 		counter++;
2010  0427 0c28          	inc	(OFST+0,sp)
2011                     ; 374 		k++;
2013  0429 0c09          	inc	(OFST-31,sp)
2014                     ; 362 for(ct=0;ct<NumberOfRegs;ct++)
2016  042b 0c0a          	inc	(OFST-30,sp)
2017  042d               L776:
2020  042d 7b0a          	ld	a,(OFST-30,sp)
2021  042f 5f            	clrw	x
2022  0430 97            	ld	xl,a
2023  0431 1305          	cpw	x,(OFST-35,sp)
2024  0433 25a8          	jrult	L376
2025                     ; 379 ByteToHex(temp2,GetLRC(OutputFrame));
2027  0435 96            	ldw	x,sp
2028  0436 1c000b        	addw	x,#OFST-29
2029  0439 cd04ed        	call	_GetLRC
2031  043c 88            	push	a
2032  043d 96            	ldw	x,sp
2033  043e 1c0004        	addw	x,#OFST-36
2034  0441 cd00a7        	call	_ByteToHex
2036  0444 84            	pop	a
2037                     ; 380 OutputFrame[counter] = temp2[0];
2039  0445 96            	ldw	x,sp
2040  0446 ad3f          	call	LC004
2041  0448 1b28          	add	a,(OFST+0,sp)
2042  044a 2401          	jrnc	L222
2043  044c 5c            	incw	x
2044  044d               L222:
2045  044d 02            	rlwa	x,a
2046  044e 7b03          	ld	a,(OFST-37,sp)
2047  0450 f7            	ld	(x),a
2048                     ; 381 counter++;
2050                     ; 382 OutputFrame[counter] = temp2[1];
2052  0451 96            	ldw	x,sp
2053  0452 0c28          	inc	(OFST+0,sp)
2054  0454 ad31          	call	LC004
2055  0456 1b28          	add	a,(OFST+0,sp)
2056  0458 2401          	jrnc	L422
2057  045a 5c            	incw	x
2058  045b               L422:
2059  045b 02            	rlwa	x,a
2060  045c 7b04          	ld	a,(OFST-36,sp)
2061  045e f7            	ld	(x),a
2062                     ; 383 counter++;
2064                     ; 384 OutputFrame[counter] = 0x0D;
2066  045f 96            	ldw	x,sp
2067  0460 0c28          	inc	(OFST+0,sp)
2068  0462 ad23          	call	LC004
2069  0464 1b28          	add	a,(OFST+0,sp)
2070  0466 2401          	jrnc	L622
2071  0468 5c            	incw	x
2072  0469               L622:
2073  0469 02            	rlwa	x,a
2074  046a a60d          	ld	a,#13
2075  046c f7            	ld	(x),a
2076                     ; 385 counter++;
2078                     ; 386 OutputFrame[counter] = 0x0A;
2080  046d 96            	ldw	x,sp
2081  046e 0c28          	inc	(OFST+0,sp)
2082  0470 ad15          	call	LC004
2083  0472 1b28          	add	a,(OFST+0,sp)
2084  0474 2401          	jrnc	L032
2085  0476 5c            	incw	x
2086  0477               L032:
2087  0477 02            	rlwa	x,a
2088  0478 a60a          	ld	a,#10
2089  047a f7            	ld	(x),a
2090                     ; 387 counter++;
2092                     ; 389 UART_SendStr(OutputFrame); 
2094  047b 96            	ldw	x,sp
2095  047c 0c28          	inc	(OFST+0,sp)
2096  047e 1c000b        	addw	x,#OFST-29
2097  0481 cd0000        	call	_UART_SendStr
2099                     ; 391 }
2102  0484 5b28          	addw	sp,#40
2103  0486 81            	ret	
2104  0487               LC004:
2105  0487 1c000b        	addw	x,#OFST-29
2106  048a 9f            	ld	a,xl
2107  048b 5e            	swapw	x
2108  048c 81            	ret	
2131                     ; 392 void ReadInputRegisters(void)
2131                     ; 393 {
2132                     	switch	.text
2133  048d               _ReadInputRegisters:
2137                     ; 396 }
2140  048d 81            	ret	
2163                     ; 397 void ForceSingleCoil(void)
2163                     ; 398 {}
2164                     	switch	.text
2165  048e               _ForceSingleCoil:
2172  048e 81            	ret	
2196                     ; 399 void PresetSingleRegister(void)
2196                     ; 400 {}
2197                     	switch	.text
2198  048f               _PresetSingleRegister:
2205  048f 81            	ret	
2290                     ; 403 bool CheckLRC(char *frame)
2290                     ; 404 {
2291                     	switch	.text
2292  0490               _CheckLRC:
2294  0490 89            	pushw	x
2295  0491 5207          	subw	sp,#7
2296       00000007      OFST:	set	7
2299                     ; 405 	uint8_t a = 0;
2301  0493 0f07          	clr	(OFST+0,sp)
2302                     ; 408 	uint8_t tempSum = 0;
2304  0495 0f01          	clr	(OFST-6,sp)
2305                     ; 410 	uint8_t LRC_calculated = 0;
2307                     ; 412 	uint8_t LRC_dec_from_frame = 0;	
2309  0497 0f02          	clr	(OFST-5,sp)
2311  0499 2002          	jra	L1001
2312  049b               L577:
2313                     ; 417 				a++;
2315  049b 0c07          	inc	(OFST+0,sp)
2316  049d               L1001:
2317                     ; 415 	while(word[a] != '\r')
2319  049d 7b07          	ld	a,(OFST+0,sp)
2320  049f 5f            	clrw	x
2321  04a0 97            	ld	xl,a
2322  04a1 e600          	ld	a,(_word,x)
2323  04a3 a10d          	cp	a,#13
2324  04a5 26f4          	jrne	L577
2325                     ; 420 temp[1] = frame[a-1];
2327  04a7 7b07          	ld	a,(OFST+0,sp)
2328  04a9 5f            	clrw	x
2329  04aa 97            	ld	xl,a
2330  04ab 5a            	decw	x
2331  04ac 72fb08        	addw	x,(OFST+1,sp)
2332  04af f6            	ld	a,(x)
2333  04b0 6b04          	ld	(OFST-3,sp),a
2334                     ; 421 temp[0] = frame[a-2];
2336  04b2 5f            	clrw	x
2337  04b3 7b07          	ld	a,(OFST+0,sp)
2338  04b5 97            	ld	xl,a
2339  04b6 1d0002        	subw	x,#2
2340  04b9 72fb08        	addw	x,(OFST+1,sp)
2341  04bc f6            	ld	a,(x)
2342  04bd 6b03          	ld	(OFST-4,sp),a
2343                     ; 423 HexToByte(temp,&LRC_dec_from_frame);
2345  04bf 96            	ldw	x,sp
2346  04c0 1c0002        	addw	x,#OFST-5
2347  04c3 89            	pushw	x
2348  04c4 5c            	incw	x
2349  04c5 cd00df        	call	_HexToByte
2351  04c8 85            	popw	x
2352                     ; 425 frame[a-1] = '\0';
2354  04c9 7b07          	ld	a,(OFST+0,sp)
2355  04cb 5f            	clrw	x
2356  04cc 97            	ld	xl,a
2357  04cd 5a            	decw	x
2358  04ce 72fb08        	addw	x,(OFST+1,sp)
2359  04d1 7f            	clr	(x)
2360                     ; 426 frame[a-2] = '\0';
2362  04d2 5f            	clrw	x
2363  04d3 97            	ld	xl,a
2364  04d4 1d0002        	subw	x,#2
2365  04d7 72fb08        	addw	x,(OFST+1,sp)
2366  04da 7f            	clr	(x)
2367                     ; 429 LRC_calculated = GetLRC(frame);
2369  04db 1e08          	ldw	x,(OFST+1,sp)
2370  04dd ad0e          	call	_GetLRC
2372  04df 6b07          	ld	(OFST+0,sp),a
2373                     ; 431 if (LRC_calculated == LRC_dec_from_frame)
2375  04e1 1102          	cp	a,(OFST-5,sp)
2376  04e3 2604          	jrne	L5001
2377                     ; 434 		return 1;
2379  04e5 a601          	ld	a,#1
2381  04e7 2001          	jra	L052
2382  04e9               L5001:
2383                     ; 438 		return 0;
2385  04e9 4f            	clr	a
2387  04ea               L052:
2389  04ea 5b09          	addw	sp,#9
2390  04ec 81            	ret	
2454                     ; 442 uint8_t GetLRC(char *frame)
2454                     ; 443 {
2455                     	switch	.text
2456  04ed               _GetLRC:
2458  04ed 89            	pushw	x
2459  04ee 5204          	subw	sp,#4
2460       00000004      OFST:	set	4
2463                     ; 444 uint8_t LRCsum = 0;
2465  04f0 0f01          	clr	(OFST-3,sp)
2466                     ; 447 frame++;
2468  04f2 1e05          	ldw	x,(OFST+1,sp)
2469  04f4 5c            	incw	x
2470  04f5 1f05          	ldw	(OFST+1,sp),x
2472  04f7 201b          	jra	L5401
2473  04f9               L3401:
2474                     ; 451 temp[0] = *frame++;
2476  04f9 6b03          	ld	(OFST-1,sp),a
2477  04fb 5c            	incw	x
2478                     ; 452 temp[1] = *frame++;
2480  04fc f6            	ld	a,(x)
2481  04fd 5c            	incw	x
2482  04fe 1f05          	ldw	(OFST+1,sp),x
2483  0500 6b04          	ld	(OFST+0,sp),a
2484                     ; 453 HexToByte(temp, &TempSum);
2486  0502 96            	ldw	x,sp
2487  0503 1c0002        	addw	x,#OFST-2
2488  0506 89            	pushw	x
2489  0507 5c            	incw	x
2490  0508 cd00df        	call	_HexToByte
2492  050b 85            	popw	x
2493                     ; 454 LRCsum += TempSum;
2495  050c 7b01          	ld	a,(OFST-3,sp)
2496  050e 1b02          	add	a,(OFST-2,sp)
2497  0510 6b01          	ld	(OFST-3,sp),a
2498  0512 1e05          	ldw	x,(OFST+1,sp)
2499  0514               L5401:
2500                     ; 449 while(*frame)
2502  0514 f6            	ld	a,(x)
2503  0515 26e2          	jrne	L3401
2504                     ; 456 LRCsum = (~(LRCsum)+1);
2506  0517 7b01          	ld	a,(OFST-3,sp)
2507  0519 43            	cpl	a
2508  051a 4c            	inc	a
2509                     ; 457 return LRCsum;
2513  051b 5b06          	addw	sp,#6
2514  051d 81            	ret	
2606                     ; 460 void HexToByte_4(char *hexstring_4, uint16_t *byte)
2606                     ; 461 {
2607                     	switch	.text
2608  051e               _HexToByte_4:
2610  051e 89            	pushw	x
2611  051f 5208          	subw	sp,#8
2612       00000008      OFST:	set	8
2615                     ; 463 uint8_t right_dec = 0;
2617  0521 0f01          	clr	(OFST-7,sp)
2618                     ; 464 uint8_t left_dec = 0;
2620  0523 0f02          	clr	(OFST-6,sp)
2621                     ; 465 uint16_t right_dec16 = 0;
2623  0525 5f            	clrw	x
2624  0526 1f03          	ldw	(OFST-5,sp),x
2625                     ; 466 uint16_t left_dec16 = 0;
2627  0528 1f05          	ldw	(OFST-3,sp),x
2628                     ; 468 tempp[0] = hexstring_4[0];
2630  052a 1e09          	ldw	x,(OFST+1,sp)
2631  052c f6            	ld	a,(x)
2632  052d 6b07          	ld	(OFST-1,sp),a
2633                     ; 469 tempp[1] = hexstring_4[1];
2635  052f e601          	ld	a,(1,x)
2636  0531 6b08          	ld	(OFST+0,sp),a
2637                     ; 470 HexToByte(tempp,&left_dec);
2639  0533 96            	ldw	x,sp
2640  0534 1c0002        	addw	x,#OFST-6
2641  0537 89            	pushw	x
2642  0538 1c0005        	addw	x,#5
2643  053b cd00df        	call	_HexToByte
2645  053e 85            	popw	x
2646                     ; 472 tempp[0] = hexstring_4[2];
2648  053f 1e09          	ldw	x,(OFST+1,sp)
2649  0541 e602          	ld	a,(2,x)
2650  0543 6b07          	ld	(OFST-1,sp),a
2651                     ; 473 tempp[1] = hexstring_4[3];
2653  0545 e603          	ld	a,(3,x)
2654  0547 6b08          	ld	(OFST+0,sp),a
2655                     ; 474 HexToByte(tempp,&right_dec);
2657  0549 96            	ldw	x,sp
2658  054a 5c            	incw	x
2659  054b 89            	pushw	x
2660  054c 1c0006        	addw	x,#6
2661  054f cd00df        	call	_HexToByte
2663  0552 85            	popw	x
2664                     ; 476 left_dec16 = left_dec16 | left_dec;
2666  0553 7b02          	ld	a,(OFST-6,sp)
2667  0555 5f            	clrw	x
2668  0556 97            	ld	xl,a
2669  0557 01            	rrwa	x,a
2670  0558 1a06          	or	a,(OFST-2,sp)
2671  055a 01            	rrwa	x,a
2672  055b 1a05          	or	a,(OFST-3,sp)
2673  055d 01            	rrwa	x,a
2674  055e 1f05          	ldw	(OFST-3,sp),x
2675                     ; 477 right_dec16 = right_dec16 | right_dec;
2677  0560 5f            	clrw	x
2678  0561 7b01          	ld	a,(OFST-7,sp)
2679  0563 97            	ld	xl,a
2680  0564 01            	rrwa	x,a
2681  0565 1a04          	or	a,(OFST-4,sp)
2682  0567 01            	rrwa	x,a
2683  0568 1a03          	or	a,(OFST-5,sp)
2684  056a 01            	rrwa	x,a
2685  056b 1f03          	ldw	(OFST-5,sp),x
2686                     ; 479 *byte = (left_dec16 << 8) | right_dec16;
2688  056d 7b04          	ld	a,(OFST-4,sp)
2689  056f 1e05          	ldw	x,(OFST-3,sp)
2690  0571 01            	rrwa	x,a
2691  0572 1a03          	or	a,(OFST-5,sp)
2692  0574 160d          	ldw	y,(OFST+5,sp)
2693  0576 01            	rrwa	x,a
2694  0577 90ff          	ldw	(y),x
2695                     ; 480 }
2698  0579 5b0a          	addw	sp,#10
2699  057b 81            	ret	
2809                     ; 484 void ByteToHex_4(char *hexstring, uint16_t byte)
2809                     ; 485 {
2810                     	switch	.text
2811  057c               _ByteToHex_4:
2813  057c 89            	pushw	x
2814  057d 520b          	subw	sp,#11
2815       0000000b      OFST:	set	11
2818                     ; 488 	uint16_t D1 = byte >> 8;
2820  057f 1e10          	ldw	x,(OFST+5,sp)
2821  0581 4f            	clr	a
2822  0582 01            	rrwa	x,a
2823  0583 1f02          	ldw	(OFST-9,sp),x
2824                     ; 489   uint16_t D2 = byte & 255;
2826  0585 5f            	clrw	x
2827  0586 7b11          	ld	a,(OFST+6,sp)
2828  0588 02            	rlwa	x,a
2829  0589 1f04          	ldw	(OFST-7,sp),x
2830                     ; 490 	uint8_t D1_8 = 0;
2832  058b 0f06          	clr	(OFST-5,sp)
2833                     ; 491 	uint8_t D2_8 = 0;
2835  058d 0f07          	clr	(OFST-4,sp)
2836                     ; 492 	uint8_t ct = 0;
2838  058f 0f01          	clr	(OFST-10,sp)
2839                     ; 494 	D1_8 |= D1;
2841  0591 7b06          	ld	a,(OFST-5,sp)
2842  0593 1a03          	or	a,(OFST-8,sp)
2843  0595 6b06          	ld	(OFST-5,sp),a
2844                     ; 495 	D2_8 |= D2;
2846  0597 7b07          	ld	a,(OFST-4,sp)
2847  0599 1a05          	or	a,(OFST-6,sp)
2848  059b 6b07          	ld	(OFST-4,sp),a
2849                     ; 497 	ByteToHex(temp1, D1_8);
2851  059d 7b06          	ld	a,(OFST-5,sp)
2852  059f 88            	push	a
2853  05a0 96            	ldw	x,sp
2854  05a1 1c0009        	addw	x,#OFST-2
2855  05a4 cd00a7        	call	_ByteToHex
2857  05a7 84            	pop	a
2858                     ; 498 	ByteToHex(temp2, D2_8);
2860  05a8 7b07          	ld	a,(OFST-4,sp)
2861  05aa 88            	push	a
2862  05ab 96            	ldw	x,sp
2863  05ac 1c000b        	addw	x,#OFST+0
2864  05af cd00a7        	call	_ByteToHex
2866  05b2 84            	pop	a
2867                     ; 500 	hexstring[0] = temp1[0];
2869  05b3 1e0c          	ldw	x,(OFST+1,sp)
2870  05b5 7b08          	ld	a,(OFST-3,sp)
2871  05b7 f7            	ld	(x),a
2872                     ; 501 	hexstring[1] = temp1[1];
2874  05b8 7b09          	ld	a,(OFST-2,sp)
2875  05ba e701          	ld	(1,x),a
2876                     ; 502 	hexstring[2] = temp2[0];
2878  05bc 7b0a          	ld	a,(OFST-1,sp)
2879  05be e702          	ld	(2,x),a
2880                     ; 503 	hexstring[3] = temp2[1];
2882  05c0 7b0b          	ld	a,(OFST+0,sp)
2883  05c2 e703          	ld	(3,x),a
2884                     ; 505 }
2887  05c4 5b0d          	addw	sp,#13
2888  05c6 81            	ret	
2901                     	xref.b	_Output_Registers
2902                     	xref.b	_Input_Registers
2903                     	xref.b	_word
2904                     	xref.b	_Address
2905                     	xref.b	_TimmingDelay
2906                     	xdef	_StateOfCoil
2907                     	xdef	_RewritingChars
2908                     	xdef	_PresetSingleRegister
2909                     	xdef	_ForceSingleCoil
2910                     	xdef	_ReadInputRegisters
2911                     	xdef	_ReadHoldingRegisters
2912                     	xdef	_ReadInputStatus
2913                     	xdef	_ReadCoilStatus
2914                     	xdef	___checkFunc
2915                     	xdef	___checkAddr
2916                     	xdef	_ByteToHex_4
2917                     	xdef	_GetLRC
2918                     	xdef	_CheckLRC
2919                     	xdef	_SetDevAddr
2920                     	xdef	_HexToByte_4
2921                     	xdef	_HexToByte
2922                     	xdef	_ByteToHex
2923                     	xdef	_UART_SendStr
2924                     	xdef	_Modbus_Init
2925                     	xdef	_Delay
2926                     	xdef	_Delay_Init
2927                     	xref	_UART2_SendData8
2928                     	xref	_UART2_ITConfig
2929                     	xref	_UART2_Cmd
2930                     	xref	_UART2_Init
2931                     	xref	_UART2_DeInit
2932                     	xref	_TIM3_ITConfig
2933                     	xref	_TIM3_Cmd
2934                     	xref	_TIM3_TimeBaseInit
2935                     	xref	_TIM3_DeInit
2936                     	xref	_TIM2_ITConfig
2937                     	xref	_TIM2_Cmd
2938                     	xref	_TIM2_TimeBaseInit
2939                     	xref	_TIM2_DeInit
2940                     	xref	_GPIO_WriteLow
2941                     	xref	_GPIO_WriteHigh
2942                     	xref	_GPIO_Init
2943                     	xref	_GPIO_DeInit
2944                     	xref	_CLK_HSIPrescalerConfig
2963                     	xref	c_lzmp
2964                     	end
