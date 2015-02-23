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
1099                     ; 169 void ReadCoilStatus(void)
1099                     ; 170 {
1100                     	switch	.text
1101  017b               _ReadCoilStatus:
1103  017b 524e          	subw	sp,#78
1104       0000004e      OFST:	set	78
1107                     ; 173 uint8_t counter = 0;
1109                     ; 174 uint8_t TempSum=0;
1111  017d 0f4b          	clr	(OFST-3,sp)
1112                     ; 180 uint8_t n = 0;
1114  017f 0f02          	clr	(OFST-76,sp)
1115                     ; 185 data[4] = 1;
1117                     ; 186 data[5] = 1;
1119  0181 a601          	ld	a,#1
1120  0183 6b13          	ld	(OFST-59,sp),a
1121                     ; 187 data[6] = 1;
1123  0185 6b14          	ld	(OFST-58,sp),a
1124                     ; 188 data[7] = 1;
1126  0187 6b15          	ld	(OFST-57,sp),a
1127                     ; 189 data[8] = 1;
1129  0189 6b16          	ld	(OFST-56,sp),a
1130                     ; 190 data[4] = 1;
1132  018b 6b12          	ld	(OFST-60,sp),a
1133                     ; 191 data[9] = 1;
1135  018d 6b17          	ld	(OFST-55,sp),a
1136                     ; 192 data[10] = 1;
1138  018f 6b18          	ld	(OFST-54,sp),a
1139                     ; 193 data[11] = 1;
1141  0191 6b19          	ld	(OFST-53,sp),a
1142                     ; 197 RewritingChars(OutputFrame,0,4);
1144  0193 4b04          	push	#4
1145  0195 4b00          	push	#0
1146  0197 96            	ldw	x,sp
1147  0198 1c0006        	addw	x,#OFST-72
1148  019b adbc          	call	_RewritingChars
1150  019d b607          	ld	a,_word+7
1151  019f 85            	popw	x
1152                     ; 200 temp[0] = word[7];
1154  01a0 6b4c          	ld	(OFST-2,sp),a
1155                     ; 201 temp[1] = word[8];
1157  01a2 b608          	ld	a,_word+8
1158  01a4 6b4d          	ld	(OFST-1,sp),a
1159                     ; 202 HexToByte(temp, &FirstCoil);
1161  01a6 96            	ldw	x,sp
1162  01a7 5c            	incw	x
1163  01a8 89            	pushw	x
1164  01a9 1c004b        	addw	x,#75
1165  01ac cd00df        	call	_HexToByte
1167  01af b60b          	ld	a,_word+11
1168  01b1 85            	popw	x
1169                     ; 205 temp[0] = word[11];
1171  01b2 6b4c          	ld	(OFST-2,sp),a
1172                     ; 206 temp[1] = word[12];
1174  01b4 b60c          	ld	a,_word+12
1175  01b6 6b4d          	ld	(OFST-1,sp),a
1176                     ; 207 HexToByte(temp, &NumberOfCoils);
1178  01b8 96            	ldw	x,sp
1179  01b9 1c0003        	addw	x,#OFST-75
1180  01bc 89            	pushw	x
1181  01bd 1c0049        	addw	x,#73
1182  01c0 cd00df        	call	_HexToByte
1184  01c3 85            	popw	x
1185                     ; 210 if((NumberOfCoils%8)!=0)
1187  01c4 7b03          	ld	a,(OFST-75,sp)
1188  01c6 a507          	bcp	a,#7
1189  01c8 2709          	jreq	L574
1190                     ; 212 	NumberOfDataBytes = ( NumberOfCoils/8)+1;
1192  01ca 5f            	clrw	x
1193  01cb 97            	ld	xl,a
1194  01cc 57            	sraw	x
1195  01cd 57            	sraw	x
1196  01ce 57            	sraw	x
1197  01cf 01            	rrwa	x,a
1198  01d0 4c            	inc	a
1200  01d1 2006          	jra	L774
1201  01d3               L574:
1202                     ; 216 	NumberOfDataBytes = NumberOfCoils/8;
1204  01d3 5f            	clrw	x
1205  01d4 97            	ld	xl,a
1206  01d5 57            	sraw	x
1207  01d6 57            	sraw	x
1208  01d7 57            	sraw	x
1209  01d8 01            	rrwa	x,a
1210  01d9               L774:
1211  01d9 6b4e          	ld	(OFST+0,sp),a
1212                     ; 220 ByteToHex(temp,NumberOfDataBytes);
1214  01db 88            	push	a
1215  01dc 96            	ldw	x,sp
1216  01dd 1c004d        	addw	x,#OFST-1
1217  01e0 cd00a7        	call	_ByteToHex
1219  01e3 84            	pop	a
1220                     ; 221 OutputFrame[5] = temp[0];
1222  01e4 7b4c          	ld	a,(OFST-2,sp)
1223  01e6 6b09          	ld	(OFST-69,sp),a
1224                     ; 222 OutputFrame[6] = temp[1];
1226  01e8 7b4d          	ld	a,(OFST-1,sp)
1227  01ea 6b0a          	ld	(OFST-68,sp),a
1228                     ; 225 counter = 7; 
1230  01ec a607          	ld	a,#7
1231  01ee 6b0d          	ld	(OFST-65,sp),a
1232                     ; 226 g = FirstCoil + 1;
1234  01f0 7b01          	ld	a,(OFST-77,sp)
1235  01f2 4c            	inc	a
1236  01f3 6b4a          	ld	(OFST-4,sp),a
1238  01f5 cc02bf        	jra	L505
1239  01f8               L105:
1240                     ; 230 		if(NumberOfCoils>=8)                   //    zamiana oktetu na HEX
1242  01f8 7b03          	ld	a,(OFST-75,sp)
1243  01fa a108          	cp	a,#8
1244  01fc 255d          	jrult	L115
1245                     ; 232 						uint8_t pwr = 0;
1247                     ; 233 						for(pwr =0; pwr<8; pwr++,g++)
1249  01fe 0f4e          	clr	(OFST+0,sp)
1250  0200               L315:
1251                     ; 235 								TempSum += (1<<pwr)*data[g];   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
1253  0200 96            	ldw	x,sp
1254  0201 1c000e        	addw	x,#OFST-64
1255  0204 9f            	ld	a,xl
1256  0205 5e            	swapw	x
1257  0206 1b4a          	add	a,(OFST-4,sp)
1258  0208 2401          	jrnc	L211
1259  020a 5c            	incw	x
1260  020b               L211:
1261  020b 02            	rlwa	x,a
1262  020c 7b4e          	ld	a,(OFST+0,sp)
1263  020e 905f          	clrw	y
1264  0210 9097          	ld	yl,a
1265  0212 a601          	ld	a,#1
1266  0214 905d          	tnzw	y
1267  0216 2705          	jreq	L411
1268  0218               L611:
1269  0218 48            	sll	a
1270  0219 905a          	decw	y
1271  021b 26fb          	jrne	L611
1272  021d               L411:
1273  021d 88            	push	a
1274  021e f6            	ld	a,(x)
1275  021f 97            	ld	xl,a
1276  0220 84            	pop	a
1277  0221 42            	mul	x,a
1278  0222 9f            	ld	a,xl
1279  0223 1b4b          	add	a,(OFST-3,sp)
1280  0225 6b4b          	ld	(OFST-3,sp),a
1281                     ; 236 								n++;
1283  0227 0c02          	inc	(OFST-76,sp)
1284                     ; 233 						for(pwr =0; pwr<8; pwr++,g++)
1286  0229 0c4e          	inc	(OFST+0,sp)
1287  022b 0c4a          	inc	(OFST-4,sp)
1290  022d 7b4e          	ld	a,(OFST+0,sp)
1291  022f a108          	cp	a,#8
1292  0231 25cd          	jrult	L315
1293                     ; 239 						ByteToHex(temp,TempSum);
1295  0233 7b4b          	ld	a,(OFST-3,sp)
1296  0235 88            	push	a
1297  0236 96            	ldw	x,sp
1298  0237 1c004d        	addw	x,#OFST-1
1299  023a cd00a7        	call	_ByteToHex
1301  023d 84            	pop	a
1302                     ; 240 						TempSum = 0;
1304  023e 0f4b          	clr	(OFST-3,sp)
1305                     ; 241 						OutputFrame[counter] = temp[0];
1307  0240 96            	ldw	x,sp
1308  0241 1c0004        	addw	x,#OFST-74
1309  0244 9f            	ld	a,xl
1310  0245 5e            	swapw	x
1311  0246 1b0d          	add	a,(OFST-65,sp)
1312  0248 2401          	jrnc	L221
1313  024a 5c            	incw	x
1314  024b               L221:
1315  024b 02            	rlwa	x,a
1316  024c 7b4c          	ld	a,(OFST-2,sp)
1317  024e f7            	ld	(x),a
1318                     ; 242 						OutputFrame[counter+1] = temp[1];
1320  024f 96            	ldw	x,sp
1321  0250 1c0005        	addw	x,#OFST-73
1322  0253 9f            	ld	a,xl
1323  0254 5e            	swapw	x
1324  0255 1b0d          	add	a,(OFST-65,sp)
1325  0257 2460          	jrnc	L041
1326                     ; 243 						counter++;
1328  0259 205d          	jp	LC002
1329  025b               L115:
1330                     ; 248 						uint8_t pwr = 0;
1332                     ; 249 						for(pwr =0; pwr<NumberOfCoils; pwr++,g++)
1334  025b 0f4e          	clr	(OFST+0,sp)
1336  025d 202d          	jra	L725
1337  025f               L325:
1338                     ; 251 								TempSum += (1<<pwr)*data[g];   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
1340  025f 96            	ldw	x,sp
1341  0260 1c000e        	addw	x,#OFST-64
1342  0263 9f            	ld	a,xl
1343  0264 5e            	swapw	x
1344  0265 1b4a          	add	a,(OFST-4,sp)
1345  0267 2401          	jrnc	L621
1346  0269 5c            	incw	x
1347  026a               L621:
1348  026a 02            	rlwa	x,a
1349  026b 7b4e          	ld	a,(OFST+0,sp)
1350  026d 905f          	clrw	y
1351  026f 9097          	ld	yl,a
1352  0271 a601          	ld	a,#1
1353  0273 905d          	tnzw	y
1354  0275 2705          	jreq	L031
1355  0277               L231:
1356  0277 48            	sll	a
1357  0278 905a          	decw	y
1358  027a 26fb          	jrne	L231
1359  027c               L031:
1360  027c 88            	push	a
1361  027d f6            	ld	a,(x)
1362  027e 97            	ld	xl,a
1363  027f 84            	pop	a
1364  0280 42            	mul	x,a
1365  0281 9f            	ld	a,xl
1366  0282 1b4b          	add	a,(OFST-3,sp)
1367  0284 6b4b          	ld	(OFST-3,sp),a
1368                     ; 252 								n++;
1370  0286 0c02          	inc	(OFST-76,sp)
1371                     ; 249 						for(pwr =0; pwr<NumberOfCoils; pwr++,g++)
1373  0288 0c4e          	inc	(OFST+0,sp)
1374  028a 0c4a          	inc	(OFST-4,sp)
1375  028c               L725:
1378  028c 7b4e          	ld	a,(OFST+0,sp)
1379  028e 1103          	cp	a,(OFST-75,sp)
1380  0290 25cd          	jrult	L325
1381                     ; 254 						ByteToHex(temp,TempSum);
1383  0292 7b4b          	ld	a,(OFST-3,sp)
1384  0294 88            	push	a
1385  0295 96            	ldw	x,sp
1386  0296 1c004d        	addw	x,#OFST-1
1387  0299 cd00a7        	call	_ByteToHex
1389  029c 84            	pop	a
1390                     ; 255 						TempSum = 0;
1392  029d 0f4b          	clr	(OFST-3,sp)
1393                     ; 256 						OutputFrame[counter] = temp[0];
1395  029f 96            	ldw	x,sp
1396  02a0 1c0004        	addw	x,#OFST-74
1397  02a3 9f            	ld	a,xl
1398  02a4 5e            	swapw	x
1399  02a5 1b0d          	add	a,(OFST-65,sp)
1400  02a7 2401          	jrnc	L631
1401  02a9 5c            	incw	x
1402  02aa               L631:
1403  02aa 02            	rlwa	x,a
1404  02ab 7b4c          	ld	a,(OFST-2,sp)
1405  02ad f7            	ld	(x),a
1406                     ; 257 						OutputFrame[counter+1] = temp[1];
1408  02ae 96            	ldw	x,sp
1409  02af 1c0005        	addw	x,#OFST-73
1410  02b2 9f            	ld	a,xl
1411  02b3 5e            	swapw	x
1412  02b4 1b0d          	add	a,(OFST-65,sp)
1413  02b6 2401          	jrnc	L041
1414  02b8               LC002:
1415  02b8 5c            	incw	x
1416  02b9               L041:
1417                     ; 258 						counter++;
1419  02b9 02            	rlwa	x,a
1420  02ba 7b4d          	ld	a,(OFST-1,sp)
1421  02bc f7            	ld	(x),a
1423  02bd 0c0d          	inc	(OFST-65,sp)
1424  02bf               L505:
1425                     ; 228 while(n <	NumberOfCoils)
1427  02bf 7b02          	ld	a,(OFST-76,sp)
1428  02c1 1103          	cp	a,(OFST-75,sp)
1429  02c3 2403cc01f8    	jrult	L105
1430                     ; 264 UART_SendStr(OutputFrame); 
1432  02c8 96            	ldw	x,sp
1433  02c9 1c0004        	addw	x,#OFST-74
1434  02cc cd0000        	call	_UART_SendStr
1436                     ; 266 }
1439  02cf 5b4e          	addw	sp,#78
1440  02d1 81            	ret	
1464                     ; 270 void ReadInputStatus(void)
1464                     ; 271 {
1465                     	switch	.text
1466  02d2               _ReadInputStatus:
1470                     ; 272 UART_SendStr("Function 2 Handled");
1472  02d2 ae0000        	ldw	x,#L345
1474                     ; 273 }
1477  02d5 cc0000        	jp	_UART_SendStr
1501                     ; 274 void ReadHoldingRegisters(void)
1501                     ; 275 {}
1502                     	switch	.text
1503  02d8               _ReadHoldingRegisters:
1510  02d8 81            	ret	
1533                     ; 276 void ReadInputRegisters(void)
1533                     ; 277 {}
1534                     	switch	.text
1535  02d9               _ReadInputRegisters:
1542  02d9 81            	ret	
1565                     ; 278 void ForceSingleCoil(void)
1565                     ; 279 {}
1566                     	switch	.text
1567  02da               _ForceSingleCoil:
1574  02da 81            	ret	
1598                     ; 280 void PresetSingleRegister(void)
1598                     ; 281 {}
1599                     	switch	.text
1600  02db               _PresetSingleRegister:
1607  02db 81            	ret	
1620                     	xref.b	_word
1621                     	xref.b	_Address
1622                     	xref.b	_TimmingDelay
1623                     	xdef	_RewritingChars
1624                     	xdef	_PresetSingleRegister
1625                     	xdef	_ForceSingleCoil
1626                     	xdef	_ReadInputRegisters
1627                     	xdef	_ReadHoldingRegisters
1628                     	xdef	_ReadInputStatus
1629                     	xdef	_ReadCoilStatus
1630                     	xdef	___checkFunc
1631                     	xdef	___checkAddr
1632                     	xdef	_SetDevAddr
1633                     	xdef	_HexToByte
1634                     	xdef	_ByteToHex
1635                     	xdef	_UART_SendStr
1636                     	xdef	_Modbus_Init
1637                     	xdef	_Delay
1638                     	xdef	_Delay_Init
1639                     	xref	_UART2_SendData8
1640                     	xref	_UART2_ITConfig
1641                     	xref	_UART2_Cmd
1642                     	xref	_UART2_Init
1643                     	xref	_UART2_DeInit
1644                     	xref	_TIM3_ITConfig
1645                     	xref	_TIM3_Cmd
1646                     	xref	_TIM3_TimeBaseInit
1647                     	xref	_TIM3_DeInit
1648                     	xref	_TIM2_ITConfig
1649                     	xref	_TIM2_Cmd
1650                     	xref	_TIM2_TimeBaseInit
1651                     	xref	_TIM2_DeInit
1652                     	xref	_GPIO_WriteLow
1653                     	xref	_GPIO_WriteHigh
1654                     	xref	_GPIO_Init
1655                     	xref	_GPIO_DeInit
1656                     	xref	_CLK_HSIPrescalerConfig
1657                     .const:	section	.text
1658  0000               L345:
1659  0000 46756e637469  	dc.b	"Function 2 Handled",0
1679                     	xref	c_lzmp
1680                     	end
