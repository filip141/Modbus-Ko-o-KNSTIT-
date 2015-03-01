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
1250  01b5 1c0011        	addw	x,#OFST-27
1251  01b8 72fb2a        	addw	x,(OFST-2,sp)
1252  01bb 7f            	clr	(x)
1255  01bc 1e2a          	ldw	x,(OFST-2,sp)
1256  01be 5c            	incw	x
1257  01bf 1f2a          	ldw	(OFST-2,sp),x
1260  01c1 a30019        	cpw	x,#25
1261  01c4 25ee          	jrult	L535
1262                     ; 209 Input_Registers[0] = 0b0000000011111111;
1264  01c6 ae00ff        	ldw	x,#255
1265  01c9 bf00          	ldw	_Input_Registers,x
1266                     ; 214 RewritingChars(OutputFrame,0,4);
1268  01cb 4b04          	push	#4
1269  01cd 4b00          	push	#0
1270  01cf 96            	ldw	x,sp
1271  01d0 1c0013        	addw	x,#OFST-25
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
1297  01ee cd0551        	call	_HexToByte_4
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
1322  020a cd0551        	call	_HexToByte_4
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
1354  0227 1c0010        	addw	x,#OFST-28
1355  022a cd00a7        	call	_ByteToHex
1357  022d 84            	pop	a
1358                     ; 242 OutputFrame[5] = temp[0];
1360  022e 7b0f          	ld	a,(OFST-29,sp)
1361  0230 6b16          	ld	(OFST-22,sp),a
1362                     ; 243 OutputFrame[6] = temp[1];
1364  0232 7b10          	ld	a,(OFST-28,sp)
1365  0234 6b17          	ld	(OFST-21,sp),a
1366                     ; 246 counter = 7; 
1368  0236 a607          	ld	a,#7
1369  0238 6b2c          	ld	(OFST+0,sp),a
1370                     ; 247 Coil = FirstCoil;
1372  023a 1e03          	ldw	x,(OFST-41,sp)
1373  023c 1f0c          	ldw	(OFST-32,sp),x
1374                     ; 248 n = NumberOfCoils;
1376  023e 1e05          	ldw	x,(OFST-39,sp)
1377  0240 1f2a          	ldw	(OFST-2,sp),x
1379  0242 cc030c        	jra	L355
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
1438  0284 1c0010        	addw	x,#OFST-28
1439  0287 cd00a7        	call	_ByteToHex
1441  028a 84            	pop	a
1442                     ; 261 						TempSum = 0;
1444  028b 0f0e          	clr	(OFST-30,sp)
1445                     ; 262 						OutputFrame[counter] = temp[0];
1447  028d 96            	ldw	x,sp
1448  028e cd0373        	call	LC003
1449  0291 1b2c          	add	a,(OFST+0,sp)
1450  0293 2401          	jrnc	L231
1451  0295 5c            	incw	x
1452  0296               L231:
1453  0296 02            	rlwa	x,a
1454  0297 7b0f          	ld	a,(OFST-29,sp)
1455  0299 f7            	ld	(x),a
1456                     ; 263 						counter++;
1458                     ; 264 						OutputFrame[counter] = temp[1];
1460  029a 96            	ldw	x,sp
1461  029b 0c2c          	inc	(OFST+0,sp)
1462  029d cd0373        	call	LC003
1463  02a0 1b2c          	add	a,(OFST+0,sp)
1464  02a2 2462          	jrnc	L051
1465                     ; 265 						counter++;
1467  02a4 205f          	jp	LC002
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
1529  02e6 1c0010        	addw	x,#OFST-28
1530  02e9 cd00a7        	call	_ByteToHex
1532  02ec 84            	pop	a
1533                     ; 278 						TempSum = 0;
1535  02ed 0f0e          	clr	(OFST-30,sp)
1536                     ; 279 						OutputFrame[counter] = temp[0];
1538  02ef 96            	ldw	x,sp
1539  02f0 cd0373        	call	LC003
1540  02f3 1b2c          	add	a,(OFST+0,sp)
1541  02f5 2401          	jrnc	L641
1542  02f7 5c            	incw	x
1543  02f8               L641:
1544  02f8 02            	rlwa	x,a
1545  02f9 7b0f          	ld	a,(OFST-29,sp)
1546  02fb f7            	ld	(x),a
1547                     ; 280 						counter++;
1549                     ; 281 						OutputFrame[counter] = temp[1];
1551  02fc 96            	ldw	x,sp
1552  02fd 0c2c          	inc	(OFST+0,sp)
1553  02ff ad72          	call	LC003
1554  0301 1b2c          	add	a,(OFST+0,sp)
1555  0303 2401          	jrnc	L051
1556  0305               LC002:
1557  0305 5c            	incw	x
1558  0306               L051:
1559                     ; 282 						counter++;
1561  0306 02            	rlwa	x,a
1562  0307 7b10          	ld	a,(OFST-28,sp)
1563  0309 f7            	ld	(x),a
1565  030a 0c2c          	inc	(OFST+0,sp)
1566  030c               L355:
1567                     ; 249 while(n>0)
1569  030c 1e2a          	ldw	x,(OFST-2,sp)
1570  030e 2703cc0245    	jrne	L745
1571                     ; 295 ByteToHex(temp,GetLRC(OutputFrame));
1573  0313 96            	ldw	x,sp
1574  0314 1c0011        	addw	x,#OFST-27
1575  0317 cd0520        	call	_GetLRC
1577  031a 88            	push	a
1578  031b 96            	ldw	x,sp
1579  031c 1c0010        	addw	x,#OFST-28
1580  031f cd00a7        	call	_ByteToHex
1582  0322 84            	pop	a
1583                     ; 296 OutputFrame[counter] = temp[0];
1585  0323 96            	ldw	x,sp
1586  0324 ad4d          	call	LC003
1587  0326 1b2c          	add	a,(OFST+0,sp)
1588  0328 2401          	jrnc	L651
1589  032a 5c            	incw	x
1590  032b               L651:
1591  032b 02            	rlwa	x,a
1592  032c 7b0f          	ld	a,(OFST-29,sp)
1593  032e f7            	ld	(x),a
1594                     ; 297 counter++;
1596                     ; 298 OutputFrame[counter] = temp[1];
1598  032f 96            	ldw	x,sp
1599  0330 0c2c          	inc	(OFST+0,sp)
1600  0332 ad3f          	call	LC003
1601  0334 1b2c          	add	a,(OFST+0,sp)
1602  0336 2401          	jrnc	L061
1603  0338 5c            	incw	x
1604  0339               L061:
1605  0339 02            	rlwa	x,a
1606  033a 7b10          	ld	a,(OFST-28,sp)
1607  033c f7            	ld	(x),a
1608                     ; 299 counter++;
1610                     ; 300 OutputFrame[counter] = 0x0D;
1612  033d 96            	ldw	x,sp
1613  033e 0c2c          	inc	(OFST+0,sp)
1614  0340 ad31          	call	LC003
1615  0342 1b2c          	add	a,(OFST+0,sp)
1616  0344 2401          	jrnc	L261
1617  0346 5c            	incw	x
1618  0347               L261:
1619  0347 02            	rlwa	x,a
1620  0348 a60d          	ld	a,#13
1621  034a f7            	ld	(x),a
1622                     ; 301 counter++;
1624                     ; 302 OutputFrame[counter] = 0x0A;
1626  034b 96            	ldw	x,sp
1627  034c 0c2c          	inc	(OFST+0,sp)
1628  034e ad23          	call	LC003
1629  0350 1b2c          	add	a,(OFST+0,sp)
1630  0352 2401          	jrnc	L461
1631  0354 5c            	incw	x
1632  0355               L461:
1633  0355 02            	rlwa	x,a
1634  0356 a60a          	ld	a,#10
1635  0358 f7            	ld	(x),a
1636                     ; 303 counter++;
1638                     ; 304 OutputFrame[counter] = 0x0A;
1640  0359 96            	ldw	x,sp
1641  035a 0c2c          	inc	(OFST+0,sp)
1642  035c ad15          	call	LC003
1643  035e 1b2c          	add	a,(OFST+0,sp)
1644  0360 2401          	jrnc	L661
1645  0362 5c            	incw	x
1646  0363               L661:
1647  0363 02            	rlwa	x,a
1648  0364 a60a          	ld	a,#10
1649  0366 f7            	ld	(x),a
1650                     ; 305 counter++;
1652                     ; 308 	UART_SendStr(OutputFrame); 
1654  0367 96            	ldw	x,sp
1655  0368 0c2c          	inc	(OFST+0,sp)
1656  036a 1c0011        	addw	x,#OFST-27
1657  036d cd0000        	call	_UART_SendStr
1659                     ; 309 }
1662  0370 5b2c          	addw	sp,#44
1663  0372 81            	ret	
1664  0373               LC003:
1665  0373 1c0011        	addw	x,#OFST-27
1666  0376 9f            	ld	a,xl
1667  0377 5e            	swapw	x
1668  0378 81            	ret	
1691                     ; 313 void ReadInputStatus(void)
1691                     ; 314 {
1692                     	switch	.text
1693  0379               _ReadInputStatus:
1697                     ; 317 }
1700  0379 81            	ret	
1827                     ; 320 void ReadHoldingRegisters(void)
1827                     ; 321 {
1828                     	switch	.text
1829  037a               _ReadHoldingRegisters:
1831  037a 5228          	subw	sp,#40
1832       00000028      OFST:	set	40
1835                     ; 326 uint16_t FirstReg = 0;
1837  037c 5f            	clrw	x
1838  037d 1f01          	ldw	(OFST-39,sp),x
1839                     ; 327 uint16_t NumberOfRegs = 0;
1841  037f 1f05          	ldw	(OFST-35,sp),x
1842                     ; 328 uint8_t NumberOfBytes = 0 ;
1844                     ; 329 uint8_t ct = 0;
1846                     ; 330 uint8_t k = 0;
1848                     ; 331 uint8_t counter = 0;
1850                     ; 332 uint16_t Content_dec = 0;
1852                     ; 336 for(k = 0; k<25; k++){OutputFrame[k] = '\0';}
1854  0381 0f0a          	clr	(OFST-30,sp)
1855  0383               L376:
1858  0383 96            	ldw	x,sp
1859  0384 cd04ba        	call	LC004
1860  0387 1b0a          	add	a,(OFST-30,sp)
1861  0389 2401          	jrnc	L671
1862  038b 5c            	incw	x
1863  038c               L671:
1864  038c 02            	rlwa	x,a
1865  038d 7f            	clr	(x)
1868  038e 0c0a          	inc	(OFST-30,sp)
1871  0390 7b0a          	ld	a,(OFST-30,sp)
1872  0392 a119          	cp	a,#25
1873  0394 25ed          	jrult	L376
1874                     ; 339 RewritingChars(OutputFrame,0,4);
1876  0396 4b04          	push	#4
1877  0398 4b00          	push	#0
1878  039a 96            	ldw	x,sp
1879  039b 1c000d        	addw	x,#OFST-27
1880  039e cd0159        	call	_RewritingChars
1882  03a1 b605          	ld	a,_word+5
1883  03a3 85            	popw	x
1884                     ; 342 temp[0] = word[5];
1886  03a4 6b24          	ld	(OFST-4,sp),a
1887                     ; 343 temp[1] = word[6];
1889  03a6 b606          	ld	a,_word+6
1890  03a8 6b25          	ld	(OFST-3,sp),a
1891                     ; 344 temp[2] = word[7];
1893  03aa b607          	ld	a,_word+7
1894  03ac 6b26          	ld	(OFST-2,sp),a
1895                     ; 345 temp[3] = word[8];
1897  03ae b608          	ld	a,_word+8
1898  03b0 6b27          	ld	(OFST-1,sp),a
1899                     ; 346 HexToByte_4(temp, &FirstReg);
1901  03b2 96            	ldw	x,sp
1902  03b3 5c            	incw	x
1903  03b4 89            	pushw	x
1904  03b5 1c0023        	addw	x,#35
1905  03b8 cd0551        	call	_HexToByte_4
1907  03bb b609          	ld	a,_word+9
1908  03bd 85            	popw	x
1909                     ; 349 temp[0] = word[9];
1911  03be 6b24          	ld	(OFST-4,sp),a
1912                     ; 350 temp[1] = word[10];
1914  03c0 b60a          	ld	a,_word+10
1915  03c2 6b25          	ld	(OFST-3,sp),a
1916                     ; 351 temp[2] = word[11];
1918  03c4 b60b          	ld	a,_word+11
1919  03c6 6b26          	ld	(OFST-2,sp),a
1920                     ; 352 temp[3] = word[12];
1922  03c8 b60c          	ld	a,_word+12
1923  03ca 6b27          	ld	(OFST-1,sp),a
1924                     ; 353 HexToByte_4(temp, &NumberOfRegs);
1926  03cc 96            	ldw	x,sp
1927  03cd 1c0005        	addw	x,#OFST-35
1928  03d0 89            	pushw	x
1929  03d1 1c001f        	addw	x,#31
1930  03d4 cd0551        	call	_HexToByte_4
1932  03d7 85            	popw	x
1933                     ; 356 NumberOfBytes = NumberOfRegs*2;
1935  03d8 7b06          	ld	a,(OFST-34,sp)
1936  03da 48            	sll	a
1937  03db 6b09          	ld	(OFST-31,sp),a
1938                     ; 359 ByteToHex(temp,NumberOfBytes);
1940  03dd 88            	push	a
1941  03de 96            	ldw	x,sp
1942  03df 1c0025        	addw	x,#OFST-3
1943  03e2 cd00a7        	call	_ByteToHex
1945  03e5 84            	pop	a
1946                     ; 360 OutputFrame[5] = temp[0];
1948  03e6 7b24          	ld	a,(OFST-4,sp)
1949  03e8 6b10          	ld	(OFST-24,sp),a
1950                     ; 361 OutputFrame[6] = temp[1];
1952  03ea 7b25          	ld	a,(OFST-3,sp)
1953  03ec 6b11          	ld	(OFST-23,sp),a
1954                     ; 363 counter = 7;
1956  03ee a607          	ld	a,#7
1957  03f0 6b28          	ld	(OFST+0,sp),a
1958                     ; 364 k = FirstReg;
1960  03f2 7b02          	ld	a,(OFST-38,sp)
1961  03f4 6b0a          	ld	(OFST-30,sp),a
1962                     ; 366 Output_Registers[1] = 65535;
1964  03f6 aeffff        	ldw	x,#65535
1965  03f9 bf02          	ldw	_Output_Registers+2,x
1966                     ; 367 Output_Registers[2] = 65535;
1968  03fb bf04          	ldw	_Output_Registers+4,x
1969                     ; 369 for(ct=0;ct<NumberOfRegs;ct++)
1971  03fd 0f09          	clr	(OFST-31,sp)
1973  03ff 2051          	jra	L507
1974  0401               L107:
1975                     ; 371 		Content_dec = Output_Registers[k];
1977  0401 7b0a          	ld	a,(OFST-30,sp)
1978  0403 5f            	clrw	x
1979  0404 97            	ld	xl,a
1980  0405 58            	sllw	x
1981  0406 ee00          	ldw	x,(_Output_Registers,x)
1982  0408 1f07          	ldw	(OFST-33,sp),x
1983                     ; 372 		ByteToHex_4(temp,Content_dec);
1985  040a 89            	pushw	x
1986  040b 96            	ldw	x,sp
1987  040c 1c0026        	addw	x,#OFST-2
1988  040f cd05af        	call	_ByteToHex_4
1990  0412 85            	popw	x
1991                     ; 373 		OutputFrame[counter] = temp[0];
1993  0413 96            	ldw	x,sp
1994  0414 cd04ba        	call	LC004
1995  0417 1b28          	add	a,(OFST+0,sp)
1996  0419 2401          	jrnc	L212
1997  041b 5c            	incw	x
1998  041c               L212:
1999  041c 02            	rlwa	x,a
2000  041d 7b24          	ld	a,(OFST-4,sp)
2001  041f f7            	ld	(x),a
2002                     ; 374 		counter++;
2004                     ; 375 		OutputFrame[counter] = temp[1];
2006  0420 96            	ldw	x,sp
2007  0421 0c28          	inc	(OFST+0,sp)
2008  0423 cd04ba        	call	LC004
2009  0426 1b28          	add	a,(OFST+0,sp)
2010  0428 2401          	jrnc	L412
2011  042a 5c            	incw	x
2012  042b               L412:
2013  042b 02            	rlwa	x,a
2014  042c 7b25          	ld	a,(OFST-3,sp)
2015  042e f7            	ld	(x),a
2016                     ; 376 		counter++;
2018                     ; 377 		OutputFrame[counter] = temp[2];
2020  042f 96            	ldw	x,sp
2021  0430 0c28          	inc	(OFST+0,sp)
2022  0432 cd04ba        	call	LC004
2023  0435 1b28          	add	a,(OFST+0,sp)
2024  0437 2401          	jrnc	L612
2025  0439 5c            	incw	x
2026  043a               L612:
2027  043a 02            	rlwa	x,a
2028  043b 7b26          	ld	a,(OFST-2,sp)
2029  043d f7            	ld	(x),a
2030                     ; 378 		counter++;
2032                     ; 379 		OutputFrame[counter] = temp[3];
2034  043e 96            	ldw	x,sp
2035  043f 0c28          	inc	(OFST+0,sp)
2036  0441 ad77          	call	LC004
2037  0443 1b28          	add	a,(OFST+0,sp)
2038  0445 2401          	jrnc	L022
2039  0447 5c            	incw	x
2040  0448               L022:
2041  0448 02            	rlwa	x,a
2042  0449 7b27          	ld	a,(OFST-1,sp)
2043  044b f7            	ld	(x),a
2044                     ; 380 		counter++;
2046  044c 0c28          	inc	(OFST+0,sp)
2047                     ; 381 		k++;
2049  044e 0c0a          	inc	(OFST-30,sp)
2050                     ; 369 for(ct=0;ct<NumberOfRegs;ct++)
2052  0450 0c09          	inc	(OFST-31,sp)
2053  0452               L507:
2056  0452 7b09          	ld	a,(OFST-31,sp)
2057  0454 5f            	clrw	x
2058  0455 97            	ld	xl,a
2059  0456 1305          	cpw	x,(OFST-35,sp)
2060  0458 25a7          	jrult	L107
2061                     ; 386 ByteToHex(temp2,GetLRC(OutputFrame));
2063  045a 96            	ldw	x,sp
2064  045b 1c000b        	addw	x,#OFST-29
2065  045e cd0520        	call	_GetLRC
2067  0461 88            	push	a
2068  0462 96            	ldw	x,sp
2069  0463 1c0004        	addw	x,#OFST-36
2070  0466 cd00a7        	call	_ByteToHex
2072  0469 84            	pop	a
2073                     ; 387 OutputFrame[counter] = temp2[0];
2075  046a 96            	ldw	x,sp
2076  046b ad4d          	call	LC004
2077  046d 1b28          	add	a,(OFST+0,sp)
2078  046f 2401          	jrnc	L622
2079  0471 5c            	incw	x
2080  0472               L622:
2081  0472 02            	rlwa	x,a
2082  0473 7b03          	ld	a,(OFST-37,sp)
2083  0475 f7            	ld	(x),a
2084                     ; 388 counter++;
2086                     ; 389 OutputFrame[counter] = temp2[1];
2088  0476 96            	ldw	x,sp
2089  0477 0c28          	inc	(OFST+0,sp)
2090  0479 ad3f          	call	LC004
2091  047b 1b28          	add	a,(OFST+0,sp)
2092  047d 2401          	jrnc	L032
2093  047f 5c            	incw	x
2094  0480               L032:
2095  0480 02            	rlwa	x,a
2096  0481 7b04          	ld	a,(OFST-36,sp)
2097  0483 f7            	ld	(x),a
2098                     ; 390 counter++;
2100                     ; 391 OutputFrame[counter] = 0x0D;
2102  0484 96            	ldw	x,sp
2103  0485 0c28          	inc	(OFST+0,sp)
2104  0487 ad31          	call	LC004
2105  0489 1b28          	add	a,(OFST+0,sp)
2106  048b 2401          	jrnc	L232
2107  048d 5c            	incw	x
2108  048e               L232:
2109  048e 02            	rlwa	x,a
2110  048f a60d          	ld	a,#13
2111  0491 f7            	ld	(x),a
2112                     ; 392 counter++;
2114                     ; 393 OutputFrame[counter] = 0x0A;
2116  0492 96            	ldw	x,sp
2117  0493 0c28          	inc	(OFST+0,sp)
2118  0495 ad23          	call	LC004
2119  0497 1b28          	add	a,(OFST+0,sp)
2120  0499 2401          	jrnc	L432
2121  049b 5c            	incw	x
2122  049c               L432:
2123  049c 02            	rlwa	x,a
2124  049d a60a          	ld	a,#10
2125  049f f7            	ld	(x),a
2126                     ; 394 counter++;
2128                     ; 395 OutputFrame[counter] = 0x0A;
2130  04a0 96            	ldw	x,sp
2131  04a1 0c28          	inc	(OFST+0,sp)
2132  04a3 ad15          	call	LC004
2133  04a5 1b28          	add	a,(OFST+0,sp)
2134  04a7 2401          	jrnc	L632
2135  04a9 5c            	incw	x
2136  04aa               L632:
2137  04aa 02            	rlwa	x,a
2138  04ab a60a          	ld	a,#10
2139  04ad f7            	ld	(x),a
2140                     ; 396 counter++;
2142                     ; 400 UART_SendStr(OutputFrame); 
2144  04ae 96            	ldw	x,sp
2145  04af 0c28          	inc	(OFST+0,sp)
2146  04b1 1c000b        	addw	x,#OFST-29
2147  04b4 cd0000        	call	_UART_SendStr
2149                     ; 402 }
2152  04b7 5b28          	addw	sp,#40
2153  04b9 81            	ret	
2154  04ba               LC004:
2155  04ba 1c000b        	addw	x,#OFST-29
2156  04bd 9f            	ld	a,xl
2157  04be 5e            	swapw	x
2158  04bf 81            	ret	
2181                     ; 403 void ReadInputRegisters(void)
2181                     ; 404 {
2182                     	switch	.text
2183  04c0               _ReadInputRegisters:
2187                     ; 407 }
2190  04c0 81            	ret	
2213                     ; 408 void ForceSingleCoil(void)
2213                     ; 409 {}
2214                     	switch	.text
2215  04c1               _ForceSingleCoil:
2222  04c1 81            	ret	
2246                     ; 410 void PresetSingleRegister(void)
2246                     ; 411 {}
2247                     	switch	.text
2248  04c2               _PresetSingleRegister:
2255  04c2 81            	ret	
2340                     ; 414 bool CheckLRC(char *frame)
2340                     ; 415 {
2341                     	switch	.text
2342  04c3               _CheckLRC:
2344  04c3 89            	pushw	x
2345  04c4 5207          	subw	sp,#7
2346       00000007      OFST:	set	7
2349                     ; 416 	uint8_t a = 0;
2351  04c6 0f07          	clr	(OFST+0,sp)
2352                     ; 419 	uint8_t tempSum = 0;
2354  04c8 0f01          	clr	(OFST-6,sp)
2355                     ; 421 	uint8_t LRC_calculated = 0;
2357                     ; 423 	uint8_t LRC_dec_from_frame = 0;	
2359  04ca 0f02          	clr	(OFST-5,sp)
2361  04cc 2002          	jra	L7001
2362  04ce               L3001:
2363                     ; 428 				a++;
2365  04ce 0c07          	inc	(OFST+0,sp)
2366  04d0               L7001:
2367                     ; 426 	while(word[a] != '\r')
2369  04d0 7b07          	ld	a,(OFST+0,sp)
2370  04d2 5f            	clrw	x
2371  04d3 97            	ld	xl,a
2372  04d4 e600          	ld	a,(_word,x)
2373  04d6 a10d          	cp	a,#13
2374  04d8 26f4          	jrne	L3001
2375                     ; 431 temp[1] = frame[a-1];
2377  04da 7b07          	ld	a,(OFST+0,sp)
2378  04dc 5f            	clrw	x
2379  04dd 97            	ld	xl,a
2380  04de 5a            	decw	x
2381  04df 72fb08        	addw	x,(OFST+1,sp)
2382  04e2 f6            	ld	a,(x)
2383  04e3 6b04          	ld	(OFST-3,sp),a
2384                     ; 432 temp[0] = frame[a-2];
2386  04e5 5f            	clrw	x
2387  04e6 7b07          	ld	a,(OFST+0,sp)
2388  04e8 97            	ld	xl,a
2389  04e9 1d0002        	subw	x,#2
2390  04ec 72fb08        	addw	x,(OFST+1,sp)
2391  04ef f6            	ld	a,(x)
2392  04f0 6b03          	ld	(OFST-4,sp),a
2393                     ; 434 HexToByte(temp,&LRC_dec_from_frame);
2395  04f2 96            	ldw	x,sp
2396  04f3 1c0002        	addw	x,#OFST-5
2397  04f6 89            	pushw	x
2398  04f7 5c            	incw	x
2399  04f8 cd00df        	call	_HexToByte
2401  04fb 85            	popw	x
2402                     ; 436 frame[a-1] = '\0';
2404  04fc 7b07          	ld	a,(OFST+0,sp)
2405  04fe 5f            	clrw	x
2406  04ff 97            	ld	xl,a
2407  0500 5a            	decw	x
2408  0501 72fb08        	addw	x,(OFST+1,sp)
2409  0504 7f            	clr	(x)
2410                     ; 437 frame[a-2] = '\0';
2412  0505 5f            	clrw	x
2413  0506 97            	ld	xl,a
2414  0507 1d0002        	subw	x,#2
2415  050a 72fb08        	addw	x,(OFST+1,sp)
2416  050d 7f            	clr	(x)
2417                     ; 440 LRC_calculated = GetLRC(frame);
2419  050e 1e08          	ldw	x,(OFST+1,sp)
2420  0510 ad0e          	call	_GetLRC
2422  0512 6b07          	ld	(OFST+0,sp),a
2423                     ; 442 if (LRC_calculated == LRC_dec_from_frame)
2425  0514 1102          	cp	a,(OFST-5,sp)
2426  0516 2604          	jrne	L3101
2427                     ; 445 		return 1;
2429  0518 a601          	ld	a,#1
2431  051a 2001          	jra	L652
2432  051c               L3101:
2433                     ; 449 		return 0;
2435  051c 4f            	clr	a
2437  051d               L652:
2439  051d 5b09          	addw	sp,#9
2440  051f 81            	ret	
2504                     ; 453 uint8_t GetLRC(char *frame)
2504                     ; 454 {
2505                     	switch	.text
2506  0520               _GetLRC:
2508  0520 89            	pushw	x
2509  0521 5204          	subw	sp,#4
2510       00000004      OFST:	set	4
2513                     ; 455 uint8_t LRCsum = 0;
2515  0523 0f01          	clr	(OFST-3,sp)
2516                     ; 458 frame++;
2518  0525 1e05          	ldw	x,(OFST+1,sp)
2519  0527 5c            	incw	x
2520  0528 1f05          	ldw	(OFST+1,sp),x
2522  052a 201b          	jra	L3501
2523  052c               L1501:
2524                     ; 462 temp[0] = *frame++;
2526  052c 6b03          	ld	(OFST-1,sp),a
2527  052e 5c            	incw	x
2528                     ; 463 temp[1] = *frame++;
2530  052f f6            	ld	a,(x)
2531  0530 5c            	incw	x
2532  0531 1f05          	ldw	(OFST+1,sp),x
2533  0533 6b04          	ld	(OFST+0,sp),a
2534                     ; 464 HexToByte(temp, &TempSum);
2536  0535 96            	ldw	x,sp
2537  0536 1c0002        	addw	x,#OFST-2
2538  0539 89            	pushw	x
2539  053a 5c            	incw	x
2540  053b cd00df        	call	_HexToByte
2542  053e 85            	popw	x
2543                     ; 465 LRCsum += TempSum;
2545  053f 7b01          	ld	a,(OFST-3,sp)
2546  0541 1b02          	add	a,(OFST-2,sp)
2547  0543 6b01          	ld	(OFST-3,sp),a
2548  0545 1e05          	ldw	x,(OFST+1,sp)
2549  0547               L3501:
2550                     ; 460 while(*frame)
2552  0547 f6            	ld	a,(x)
2553  0548 26e2          	jrne	L1501
2554                     ; 467 LRCsum = (~(LRCsum)+1);
2556  054a 7b01          	ld	a,(OFST-3,sp)
2557  054c 43            	cpl	a
2558  054d 4c            	inc	a
2559                     ; 468 return LRCsum;
2563  054e 5b06          	addw	sp,#6
2564  0550 81            	ret	
2656                     ; 471 void HexToByte_4(char *hexstring_4, uint16_t *byte)
2656                     ; 472 {
2657                     	switch	.text
2658  0551               _HexToByte_4:
2660  0551 89            	pushw	x
2661  0552 5208          	subw	sp,#8
2662       00000008      OFST:	set	8
2665                     ; 474 uint8_t right_dec = 0;
2667  0554 0f01          	clr	(OFST-7,sp)
2668                     ; 475 uint8_t left_dec = 0;
2670  0556 0f02          	clr	(OFST-6,sp)
2671                     ; 476 uint16_t right_dec16 = 0;
2673  0558 5f            	clrw	x
2674  0559 1f03          	ldw	(OFST-5,sp),x
2675                     ; 477 uint16_t left_dec16 = 0;
2677  055b 1f05          	ldw	(OFST-3,sp),x
2678                     ; 479 tempp[0] = hexstring_4[0];
2680  055d 1e09          	ldw	x,(OFST+1,sp)
2681  055f f6            	ld	a,(x)
2682  0560 6b07          	ld	(OFST-1,sp),a
2683                     ; 480 tempp[1] = hexstring_4[1];
2685  0562 e601          	ld	a,(1,x)
2686  0564 6b08          	ld	(OFST+0,sp),a
2687                     ; 481 HexToByte(tempp,&left_dec);
2689  0566 96            	ldw	x,sp
2690  0567 1c0002        	addw	x,#OFST-6
2691  056a 89            	pushw	x
2692  056b 1c0005        	addw	x,#5
2693  056e cd00df        	call	_HexToByte
2695  0571 85            	popw	x
2696                     ; 483 tempp[0] = hexstring_4[2];
2698  0572 1e09          	ldw	x,(OFST+1,sp)
2699  0574 e602          	ld	a,(2,x)
2700  0576 6b07          	ld	(OFST-1,sp),a
2701                     ; 484 tempp[1] = hexstring_4[3];
2703  0578 e603          	ld	a,(3,x)
2704  057a 6b08          	ld	(OFST+0,sp),a
2705                     ; 485 HexToByte(tempp,&right_dec);
2707  057c 96            	ldw	x,sp
2708  057d 5c            	incw	x
2709  057e 89            	pushw	x
2710  057f 1c0006        	addw	x,#6
2711  0582 cd00df        	call	_HexToByte
2713  0585 85            	popw	x
2714                     ; 487 left_dec16 = left_dec16 | left_dec;
2716  0586 7b02          	ld	a,(OFST-6,sp)
2717  0588 5f            	clrw	x
2718  0589 97            	ld	xl,a
2719  058a 01            	rrwa	x,a
2720  058b 1a06          	or	a,(OFST-2,sp)
2721  058d 01            	rrwa	x,a
2722  058e 1a05          	or	a,(OFST-3,sp)
2723  0590 01            	rrwa	x,a
2724  0591 1f05          	ldw	(OFST-3,sp),x
2725                     ; 488 right_dec16 = right_dec16 | right_dec;
2727  0593 5f            	clrw	x
2728  0594 7b01          	ld	a,(OFST-7,sp)
2729  0596 97            	ld	xl,a
2730  0597 01            	rrwa	x,a
2731  0598 1a04          	or	a,(OFST-4,sp)
2732  059a 01            	rrwa	x,a
2733  059b 1a03          	or	a,(OFST-5,sp)
2734  059d 01            	rrwa	x,a
2735  059e 1f03          	ldw	(OFST-5,sp),x
2736                     ; 490 *byte = (left_dec16 << 8) | right_dec16;
2738  05a0 7b04          	ld	a,(OFST-4,sp)
2739  05a2 1e05          	ldw	x,(OFST-3,sp)
2740  05a4 01            	rrwa	x,a
2741  05a5 1a03          	or	a,(OFST-5,sp)
2742  05a7 160d          	ldw	y,(OFST+5,sp)
2743  05a9 01            	rrwa	x,a
2744  05aa 90ff          	ldw	(y),x
2745                     ; 491 }
2748  05ac 5b0a          	addw	sp,#10
2749  05ae 81            	ret	
2859                     ; 495 void ByteToHex_4(char *hexstring, uint16_t byte)
2859                     ; 496 {
2860                     	switch	.text
2861  05af               _ByteToHex_4:
2863  05af 89            	pushw	x
2864  05b0 520b          	subw	sp,#11
2865       0000000b      OFST:	set	11
2868                     ; 499 	uint16_t D1 = byte >> 8;
2870  05b2 1e10          	ldw	x,(OFST+5,sp)
2871  05b4 4f            	clr	a
2872  05b5 01            	rrwa	x,a
2873  05b6 1f02          	ldw	(OFST-9,sp),x
2874                     ; 500   uint16_t D2 = byte & 255;
2876  05b8 5f            	clrw	x
2877  05b9 7b11          	ld	a,(OFST+6,sp)
2878  05bb 02            	rlwa	x,a
2879  05bc 1f04          	ldw	(OFST-7,sp),x
2880                     ; 501 	uint8_t D1_8 = 0;
2882  05be 0f06          	clr	(OFST-5,sp)
2883                     ; 502 	uint8_t D2_8 = 0;
2885  05c0 0f07          	clr	(OFST-4,sp)
2886                     ; 503 	uint8_t ct = 0;
2888  05c2 0f01          	clr	(OFST-10,sp)
2889                     ; 505 	D1_8 |= D1;
2891  05c4 7b06          	ld	a,(OFST-5,sp)
2892  05c6 1a03          	or	a,(OFST-8,sp)
2893  05c8 6b06          	ld	(OFST-5,sp),a
2894                     ; 506 	D2_8 |= D2;
2896  05ca 7b07          	ld	a,(OFST-4,sp)
2897  05cc 1a05          	or	a,(OFST-6,sp)
2898  05ce 6b07          	ld	(OFST-4,sp),a
2899                     ; 508 	ByteToHex(temp1, D1_8);
2901  05d0 7b06          	ld	a,(OFST-5,sp)
2902  05d2 88            	push	a
2903  05d3 96            	ldw	x,sp
2904  05d4 1c0009        	addw	x,#OFST-2
2905  05d7 cd00a7        	call	_ByteToHex
2907  05da 84            	pop	a
2908                     ; 509 	ByteToHex(temp2, D2_8);
2910  05db 7b07          	ld	a,(OFST-4,sp)
2911  05dd 88            	push	a
2912  05de 96            	ldw	x,sp
2913  05df 1c000b        	addw	x,#OFST+0
2914  05e2 cd00a7        	call	_ByteToHex
2916  05e5 84            	pop	a
2917                     ; 511 	hexstring[0] = temp1[0];
2919  05e6 1e0c          	ldw	x,(OFST+1,sp)
2920  05e8 7b08          	ld	a,(OFST-3,sp)
2921  05ea f7            	ld	(x),a
2922                     ; 512 	hexstring[1] = temp1[1];
2924  05eb 7b09          	ld	a,(OFST-2,sp)
2925  05ed e701          	ld	(1,x),a
2926                     ; 513 	hexstring[2] = temp2[0];
2928  05ef 7b0a          	ld	a,(OFST-1,sp)
2929  05f1 e702          	ld	(2,x),a
2930                     ; 514 	hexstring[3] = temp2[1];
2932  05f3 7b0b          	ld	a,(OFST+0,sp)
2933  05f5 e703          	ld	(3,x),a
2934                     ; 516 }
2937  05f7 5b0d          	addw	sp,#13
2938  05f9 81            	ret	
2951                     	xref.b	_Output_Registers
2952                     	xref.b	_Input_Registers
2953                     	xref.b	_word
2954                     	xref.b	_Address
2955                     	xref.b	_TimmingDelay
2956                     	xdef	_StateOfCoil
2957                     	xdef	_RewritingChars
2958                     	xdef	_PresetSingleRegister
2959                     	xdef	_ForceSingleCoil
2960                     	xdef	_ReadInputRegisters
2961                     	xdef	_ReadHoldingRegisters
2962                     	xdef	_ReadInputStatus
2963                     	xdef	_ReadCoilStatus
2964                     	xdef	___checkFunc
2965                     	xdef	___checkAddr
2966                     	xdef	_ByteToHex_4
2967                     	xdef	_GetLRC
2968                     	xdef	_CheckLRC
2969                     	xdef	_SetDevAddr
2970                     	xdef	_HexToByte_4
2971                     	xdef	_HexToByte
2972                     	xdef	_ByteToHex
2973                     	xdef	_UART_SendStr
2974                     	xdef	_Modbus_Init
2975                     	xdef	_Delay
2976                     	xdef	_Delay_Init
2977                     	xref	_UART2_SendData8
2978                     	xref	_UART2_ITConfig
2979                     	xref	_UART2_Cmd
2980                     	xref	_UART2_Init
2981                     	xref	_UART2_DeInit
2982                     	xref	_TIM3_ITConfig
2983                     	xref	_TIM3_Cmd
2984                     	xref	_TIM3_TimeBaseInit
2985                     	xref	_TIM3_DeInit
2986                     	xref	_TIM2_ITConfig
2987                     	xref	_TIM2_Cmd
2988                     	xref	_TIM2_TimeBaseInit
2989                     	xref	_TIM2_DeInit
2990                     	xref	_GPIO_WriteLow
2991                     	xref	_GPIO_WriteHigh
2992                     	xref	_GPIO_Init
2993                     	xref	_GPIO_DeInit
2994                     	xref	_CLK_HSIPrescalerConfig
3013                     	xref	c_lzmp
3014                     	end
