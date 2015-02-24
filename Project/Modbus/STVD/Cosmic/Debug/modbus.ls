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
1108                     ; 169 void ReadCoilStatus(void)
1108                     ; 170 {
1109                     	switch	.text
1110  017b               _ReadCoilStatus:
1112  017b 5255          	subw	sp,#85
1113       00000055      OFST:	set	85
1116                     ; 173 uint8_t counter = 0;
1118                     ; 174 uint8_t TempSum=0;
1120  017d 0f16          	clr	(OFST-63,sp)
1121                     ; 180 uint8_t n = 0;
1123                     ; 185 data[4] = 1;
1125                     ; 186 data[5] = 1;
1127  017f a601          	ld	a,#1
1128  0181 6b1f          	ld	(OFST-54,sp),a
1129                     ; 187 data[6] = 1;
1131  0183 6b20          	ld	(OFST-53,sp),a
1132                     ; 188 data[7] = 1;
1134  0185 6b21          	ld	(OFST-52,sp),a
1135                     ; 189 data[8] = 1;
1137  0187 6b22          	ld	(OFST-51,sp),a
1138                     ; 190 data[4] = 1;
1140  0189 6b1e          	ld	(OFST-55,sp),a
1141                     ; 191 data[9] = 1;
1143  018b 6b23          	ld	(OFST-50,sp),a
1144                     ; 192 data[10] = 1;
1146  018d 6b24          	ld	(OFST-49,sp),a
1147                     ; 193 data[11] = 1;
1149  018f 6b25          	ld	(OFST-48,sp),a
1150                     ; 194 data[12] = 1;
1152  0191 6b26          	ld	(OFST-47,sp),a
1153                     ; 195 data[13] = 1;
1155  0193 6b27          	ld	(OFST-46,sp),a
1156                     ; 196 data[14] = 1;
1158  0195 6b28          	ld	(OFST-45,sp),a
1159                     ; 197 data[15] = 1;
1161  0197 6b29          	ld	(OFST-44,sp),a
1162                     ; 198 data[16] = 1;
1164  0199 6b2a          	ld	(OFST-43,sp),a
1165                     ; 199 data[17] = 1;
1167  019b 6b2b          	ld	(OFST-42,sp),a
1168                     ; 200 data[18] = 1;
1170  019d 6b2c          	ld	(OFST-41,sp),a
1171                     ; 201 data[19] = 1;
1173  019f 6b2d          	ld	(OFST-40,sp),a
1174                     ; 202 data[20] = 1;
1176  01a1 6b2e          	ld	(OFST-39,sp),a
1177                     ; 203 data[21] = 0;
1179  01a3 0f2f          	clr	(OFST-38,sp)
1180                     ; 204 data[22] = 0;
1182  01a5 0f30          	clr	(OFST-37,sp)
1183                     ; 205 data[23] = 0;
1185  01a7 0f31          	clr	(OFST-36,sp)
1186                     ; 206 data[24] = 0;
1188  01a9 0f32          	clr	(OFST-35,sp)
1189                     ; 207 data[25] = 0;
1191  01ab 0f33          	clr	(OFST-34,sp)
1192                     ; 208 data[26] = 0;
1194  01ad 0f34          	clr	(OFST-33,sp)
1195                     ; 209 data[27] = 0;
1197  01af 0f35          	clr	(OFST-32,sp)
1198                     ; 210 data[28] = 0;
1200  01b1 0f36          	clr	(OFST-31,sp)
1201                     ; 214 RewritingChars(OutputFrame,0,4);
1203  01b3 4b04          	push	#4
1204  01b5 4b00          	push	#0
1205  01b7 96            	ldw	x,sp
1206  01b8 1c0007        	addw	x,#OFST-78
1207  01bb ad9c          	call	_RewritingChars
1209  01bd b607          	ld	a,_word+7
1210  01bf 85            	popw	x
1211                     ; 217 temp[0] = word[7];
1213  01c0 6b17          	ld	(OFST-62,sp),a
1214                     ; 218 temp[1] = word[8];
1216  01c2 b608          	ld	a,_word+8
1217  01c4 6b18          	ld	(OFST-61,sp),a
1218                     ; 219 HexToByte(temp, &FirstCoil);
1220  01c6 96            	ldw	x,sp
1221  01c7 1c0002        	addw	x,#OFST-83
1222  01ca 89            	pushw	x
1223  01cb 1c0015        	addw	x,#21
1224  01ce cd00df        	call	_HexToByte
1226  01d1 b60b          	ld	a,_word+11
1227  01d3 85            	popw	x
1228                     ; 222 temp[0] = word[11];
1230  01d4 6b17          	ld	(OFST-62,sp),a
1231                     ; 223 temp[1] = word[12];
1233  01d6 b60c          	ld	a,_word+12
1234  01d8 6b18          	ld	(OFST-61,sp),a
1235                     ; 224 HexToByte(temp, &NumberOfCoils);
1237  01da 96            	ldw	x,sp
1238  01db 1c0003        	addw	x,#OFST-82
1239  01de 89            	pushw	x
1240  01df 1c0014        	addw	x,#20
1241  01e2 cd00df        	call	_HexToByte
1243  01e5 85            	popw	x
1244                     ; 227 if((NumberOfCoils%8)!=0)
1246  01e6 7b03          	ld	a,(OFST-82,sp)
1247  01e8 a507          	bcp	a,#7
1248  01ea 2709          	jreq	L105
1249                     ; 229 	NumberOfDataBytes = ( NumberOfCoils/8)+1;
1251  01ec 5f            	clrw	x
1252  01ed 97            	ld	xl,a
1253  01ee 57            	sraw	x
1254  01ef 57            	sraw	x
1255  01f0 57            	sraw	x
1256  01f1 01            	rrwa	x,a
1257  01f2 4c            	inc	a
1259  01f3 2006          	jra	L305
1260  01f5               L105:
1261                     ; 233 	NumberOfDataBytes = NumberOfCoils/8;
1263  01f5 5f            	clrw	x
1264  01f6 97            	ld	xl,a
1265  01f7 57            	sraw	x
1266  01f8 57            	sraw	x
1267  01f9 57            	sraw	x
1268  01fa 01            	rrwa	x,a
1269  01fb               L305:
1270  01fb 6b04          	ld	(OFST-81,sp),a
1271                     ; 237 ByteToHex(temp,NumberOfDataBytes);
1273  01fd 88            	push	a
1274  01fe 96            	ldw	x,sp
1275  01ff 1c0018        	addw	x,#OFST-61
1276  0202 cd00a7        	call	_ByteToHex
1278  0205 84            	pop	a
1279                     ; 238 OutputFrame[5] = temp[0];
1281  0206 7b17          	ld	a,(OFST-62,sp)
1282  0208 6b0a          	ld	(OFST-75,sp),a
1283                     ; 239 OutputFrame[6] = temp[1];
1285  020a 7b18          	ld	a,(OFST-61,sp)
1286  020c 6b0b          	ld	(OFST-74,sp),a
1287                     ; 242 counter = 7; 
1289  020e a607          	ld	a,#7
1290  0210 6b19          	ld	(OFST-60,sp),a
1291                     ; 243 g = FirstCoil + 1;
1293  0212 7b02          	ld	a,(OFST-83,sp)
1294  0214 4c            	inc	a
1295  0215 6b15          	ld	(OFST-64,sp),a
1296                     ; 244 n = NumberOfCoils;
1298  0217 7b03          	ld	a,(OFST-82,sp)
1299  0219 6b14          	ld	(OFST-65,sp),a
1301  021b cc02df        	jra	L115
1302  021e               L505:
1303                     ; 247 		if(n>=8)                   //    zamiana oktetu na HEX
1305  021e a108          	cp	a,#8
1306  0220 255b          	jrult	L515
1307                     ; 249 						uint8_t pwr = 0;
1309                     ; 250 						for(pwr =0; pwr<8; pwr++,g++)
1311  0222 0f01          	clr	(OFST-84,sp)
1312  0224               L715:
1313                     ; 252 								TempSum += (1<<pwr)*data[g];   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
1315  0224 96            	ldw	x,sp
1316  0225 1c001a        	addw	x,#OFST-59
1317  0228 9f            	ld	a,xl
1318  0229 5e            	swapw	x
1319  022a 1b15          	add	a,(OFST-64,sp)
1320  022c 2401          	jrnc	L211
1321  022e 5c            	incw	x
1322  022f               L211:
1323  022f 02            	rlwa	x,a
1324  0230 7b01          	ld	a,(OFST-84,sp)
1325  0232 905f          	clrw	y
1326  0234 9097          	ld	yl,a
1327  0236 a601          	ld	a,#1
1328  0238 905d          	tnzw	y
1329  023a 2705          	jreq	L411
1330  023c               L611:
1331  023c 48            	sll	a
1332  023d 905a          	decw	y
1333  023f 26fb          	jrne	L611
1334  0241               L411:
1335  0241 88            	push	a
1336  0242 f6            	ld	a,(x)
1337  0243 97            	ld	xl,a
1338  0244 84            	pop	a
1339  0245 42            	mul	x,a
1340  0246 9f            	ld	a,xl
1341  0247 1b16          	add	a,(OFST-63,sp)
1342  0249 6b16          	ld	(OFST-63,sp),a
1343                     ; 253 								n--;
1345  024b 0a14          	dec	(OFST-65,sp)
1346                     ; 250 						for(pwr =0; pwr<8; pwr++,g++)
1348  024d 0c01          	inc	(OFST-84,sp)
1349  024f 0c15          	inc	(OFST-64,sp)
1352  0251 7b01          	ld	a,(OFST-84,sp)
1353  0253 a108          	cp	a,#8
1354  0255 25cd          	jrult	L715
1355                     ; 256 						ByteToHex(temp,TempSum);
1357  0257 7b16          	ld	a,(OFST-63,sp)
1358  0259 88            	push	a
1359  025a 96            	ldw	x,sp
1360  025b 1c0018        	addw	x,#OFST-61
1361  025e cd00a7        	call	_ByteToHex
1363  0261 84            	pop	a
1364                     ; 257 						TempSum = 0;
1366  0262 0f16          	clr	(OFST-63,sp)
1367                     ; 258 						OutputFrame[counter] = temp[0];
1369  0264 96            	ldw	x,sp
1370  0265 cd0305        	call	LC003
1371  0268 1b19          	add	a,(OFST-60,sp)
1372  026a 2401          	jrnc	L221
1373  026c 5c            	incw	x
1374  026d               L221:
1375  026d 02            	rlwa	x,a
1376  026e 7b17          	ld	a,(OFST-62,sp)
1377  0270 f7            	ld	(x),a
1378                     ; 259 						counter++;
1380                     ; 260 						OutputFrame[counter] = temp[1];
1382  0271 96            	ldw	x,sp
1383  0272 0c19          	inc	(OFST-60,sp)
1384  0274 cd0305        	call	LC003
1385  0277 1b19          	add	a,(OFST-60,sp)
1386  0279 245e          	jrnc	L041
1387                     ; 261 						counter++;
1389  027b 205b          	jp	LC002
1390  027d               L515:
1391                     ; 266 						uint8_t pwr = 0;
1393                     ; 267 						uint8_t zm = n;
1395  027d 6b04          	ld	(OFST-81,sp),a
1396                     ; 268 						for(pwr =0; pwr<zm; pwr++,g++)
1398  027f 0f01          	clr	(OFST-84,sp)
1400  0281 202d          	jra	L335
1401  0283               L725:
1402                     ; 270 								TempSum += (1<<pwr)*data[g];   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
1404  0283 96            	ldw	x,sp
1405  0284 1c001a        	addw	x,#OFST-59
1406  0287 9f            	ld	a,xl
1407  0288 5e            	swapw	x
1408  0289 1b15          	add	a,(OFST-64,sp)
1409  028b 2401          	jrnc	L621
1410  028d 5c            	incw	x
1411  028e               L621:
1412  028e 02            	rlwa	x,a
1413  028f 7b01          	ld	a,(OFST-84,sp)
1414  0291 905f          	clrw	y
1415  0293 9097          	ld	yl,a
1416  0295 a601          	ld	a,#1
1417  0297 905d          	tnzw	y
1418  0299 2705          	jreq	L031
1419  029b               L231:
1420  029b 48            	sll	a
1421  029c 905a          	decw	y
1422  029e 26fb          	jrne	L231
1423  02a0               L031:
1424  02a0 88            	push	a
1425  02a1 f6            	ld	a,(x)
1426  02a2 97            	ld	xl,a
1427  02a3 84            	pop	a
1428  02a4 42            	mul	x,a
1429  02a5 9f            	ld	a,xl
1430  02a6 1b16          	add	a,(OFST-63,sp)
1431  02a8 6b16          	ld	(OFST-63,sp),a
1432                     ; 271 								n--;
1434  02aa 0a14          	dec	(OFST-65,sp)
1435                     ; 268 						for(pwr =0; pwr<zm; pwr++,g++)
1437  02ac 0c01          	inc	(OFST-84,sp)
1438  02ae 0c15          	inc	(OFST-64,sp)
1439  02b0               L335:
1442  02b0 7b01          	ld	a,(OFST-84,sp)
1443  02b2 1104          	cp	a,(OFST-81,sp)
1444  02b4 25cd          	jrult	L725
1445                     ; 273 						ByteToHex(temp,TempSum);
1447  02b6 7b16          	ld	a,(OFST-63,sp)
1448  02b8 88            	push	a
1449  02b9 96            	ldw	x,sp
1450  02ba 1c0018        	addw	x,#OFST-61
1451  02bd cd00a7        	call	_ByteToHex
1453  02c0 84            	pop	a
1454                     ; 274 						TempSum = 0;
1456  02c1 0f16          	clr	(OFST-63,sp)
1457                     ; 275 						OutputFrame[counter] = temp[0];
1459  02c3 96            	ldw	x,sp
1460  02c4 ad3f          	call	LC003
1461  02c6 1b19          	add	a,(OFST-60,sp)
1462  02c8 2401          	jrnc	L631
1463  02ca 5c            	incw	x
1464  02cb               L631:
1465  02cb 02            	rlwa	x,a
1466  02cc 7b17          	ld	a,(OFST-62,sp)
1467  02ce f7            	ld	(x),a
1468                     ; 276 						counter++;
1470                     ; 277 						OutputFrame[counter] = temp[1];
1472  02cf 96            	ldw	x,sp
1473  02d0 0c19          	inc	(OFST-60,sp)
1474  02d2 ad31          	call	LC003
1475  02d4 1b19          	add	a,(OFST-60,sp)
1476  02d6 2401          	jrnc	L041
1477  02d8               LC002:
1478  02d8 5c            	incw	x
1479  02d9               L041:
1480                     ; 278 						counter++;
1482  02d9 02            	rlwa	x,a
1483  02da 7b18          	ld	a,(OFST-61,sp)
1484  02dc f7            	ld	(x),a
1486  02dd 0c19          	inc	(OFST-60,sp)
1487  02df               L115:
1488                     ; 245 while(n>0)
1490  02df 7b14          	ld	a,(OFST-65,sp)
1491  02e1 2703cc021e    	jrne	L505
1492                     ; 283 for(counter; counter<=15; counter++)
1495  02e6 200d          	jra	L345
1496  02e8               L735:
1497                     ; 285 			OutputFrame[counter] = '*';
1499  02e8 ad1b          	call	LC003
1500  02ea 1b19          	add	a,(OFST-60,sp)
1501  02ec 2401          	jrnc	L241
1502  02ee 5c            	incw	x
1503  02ef               L241:
1504  02ef 02            	rlwa	x,a
1505  02f0 a62a          	ld	a,#42
1506  02f2 f7            	ld	(x),a
1507                     ; 283 for(counter; counter<=15; counter++)
1509  02f3 0c19          	inc	(OFST-60,sp)
1510  02f5               L345:
1513  02f5 7b19          	ld	a,(OFST-60,sp)
1514  02f7 a110          	cp	a,#16
1515  02f9 96            	ldw	x,sp
1516  02fa 25ec          	jrult	L735
1517                     ; 287 UART_SendStr(OutputFrame); 
1519  02fc 1c0005        	addw	x,#OFST-80
1520  02ff cd0000        	call	_UART_SendStr
1522                     ; 289 }
1525  0302 5b55          	addw	sp,#85
1526  0304 81            	ret	
1527  0305               LC003:
1528  0305 1c0005        	addw	x,#OFST-80
1529  0308 9f            	ld	a,xl
1530  0309 5e            	swapw	x
1531  030a 81            	ret	
1555                     ; 293 void ReadInputStatus(void)
1555                     ; 294 {
1556                     	switch	.text
1557  030b               _ReadInputStatus:
1561                     ; 295 UART_SendStr("Function 2 Handled");
1563  030b ae0000        	ldw	x,#L755
1565                     ; 296 }
1568  030e cc0000        	jp	_UART_SendStr
1592                     ; 297 void ReadHoldingRegisters(void)
1592                     ; 298 {}
1593                     	switch	.text
1594  0311               _ReadHoldingRegisters:
1601  0311 81            	ret	
1624                     ; 299 void ReadInputRegisters(void)
1624                     ; 300 {}
1625                     	switch	.text
1626  0312               _ReadInputRegisters:
1633  0312 81            	ret	
1656                     ; 301 void ForceSingleCoil(void)
1656                     ; 302 {}
1657                     	switch	.text
1658  0313               _ForceSingleCoil:
1665  0313 81            	ret	
1689                     ; 303 void PresetSingleRegister(void)
1689                     ; 304 {}
1690                     	switch	.text
1691  0314               _PresetSingleRegister:
1698  0314 81            	ret	
1711                     	xref.b	_word
1712                     	xref.b	_Address
1713                     	xref.b	_TimmingDelay
1714                     	xdef	_RewritingChars
1715                     	xdef	_PresetSingleRegister
1716                     	xdef	_ForceSingleCoil
1717                     	xdef	_ReadInputRegisters
1718                     	xdef	_ReadHoldingRegisters
1719                     	xdef	_ReadInputStatus
1720                     	xdef	_ReadCoilStatus
1721                     	xdef	___checkFunc
1722                     	xdef	___checkAddr
1723                     	xdef	_SetDevAddr
1724                     	xdef	_HexToByte
1725                     	xdef	_ByteToHex
1726                     	xdef	_UART_SendStr
1727                     	xdef	_Modbus_Init
1728                     	xdef	_Delay
1729                     	xdef	_Delay_Init
1730                     	xref	_UART2_SendData8
1731                     	xref	_UART2_ITConfig
1732                     	xref	_UART2_Cmd
1733                     	xref	_UART2_Init
1734                     	xref	_UART2_DeInit
1735                     	xref	_TIM3_ITConfig
1736                     	xref	_TIM3_Cmd
1737                     	xref	_TIM3_TimeBaseInit
1738                     	xref	_TIM3_DeInit
1739                     	xref	_TIM2_ITConfig
1740                     	xref	_TIM2_Cmd
1741                     	xref	_TIM2_TimeBaseInit
1742                     	xref	_TIM2_DeInit
1743                     	xref	_GPIO_WriteLow
1744                     	xref	_GPIO_WriteHigh
1745                     	xref	_GPIO_Init
1746                     	xref	_GPIO_DeInit
1747                     	xref	_CLK_HSIPrescalerConfig
1748                     .const:	section	.text
1749  0000               L755:
1750  0000 46756e637469  	dc.b	"Function 2 Handled",0
1770                     	xref	c_lzmp
1771                     	end
