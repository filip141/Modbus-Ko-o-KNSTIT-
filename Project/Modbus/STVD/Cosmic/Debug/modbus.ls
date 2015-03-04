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
 994                     ; 170 void SetSingleCoil(uint16_t *Coil, uint16_t *StatusToWrite, uint16_t *registers)
 994                     ; 171 { 
 995                     	switch	.text
 996  017f               _SetSingleCoil:
 998  017f 89            	pushw	x
 999       00000000      OFST:	set	0
1002                     ; 174 if(*StatusToWrite == 0xFF00)
1004  0180 1605          	ldw	y,(OFST+5,sp)
1005  0182 90fe          	ldw	y,(y)
1006  0184 90a3ff00      	cpw	y,#65280
1007  0188 262a          	jrne	L124
1008                     ; 176 		registers[*Coil/16 ] |= (1<<(*Coil%16));		
1010  018a 1e01          	ldw	x,(OFST+1,sp)
1011  018c fe            	ldw	x,(x)
1012  018d 54            	srlw	x
1013  018e 54            	srlw	x
1014  018f 54            	srlw	x
1015  0190 54            	srlw	x
1016  0191 58            	sllw	x
1017  0192 1601          	ldw	y,(OFST+1,sp)
1018  0194 72fb07        	addw	x,(OFST+7,sp)
1019  0197 90e601        	ld	a,(1,y)
1020  019a a40f          	and	a,#15
1021  019c 90ae0001      	ldw	y,#1
1022  01a0 4d            	tnz	a
1023  01a1 2705          	jreq	L201
1024  01a3               L401:
1025  01a3 9058          	sllw	y
1026  01a5 4a            	dec	a
1027  01a6 26fb          	jrne	L401
1028  01a8               L201:
1029  01a8 9001          	rrwa	y,a
1030  01aa ea01          	or	a,(1,x)
1031  01ac 9001          	rrwa	y,a
1032  01ae fa            	or	a,(x)
1033  01af 9001          	rrwa	y,a
1034  01b1 ff            	ldw	(x),y
1036  01b2 2039          	jra	L324
1037  01b4               L124:
1038                     ; 180 else if(*StatusToWrite == 0x0000)
1040  01b4 1e05          	ldw	x,(OFST+5,sp)
1041  01b6 e601          	ld	a,(1,x)
1042  01b8 fa            	or	a,(x)
1043  01b9 2632          	jrne	L324
1044                     ; 182 		registers[*Coil/16 ] &= (!(1<<(*Coil%16)));
1046  01bb 1601          	ldw	y,(OFST+1,sp)
1047  01bd ae0001        	ldw	x,#1
1048  01c0 90e601        	ld	a,(1,y)
1049  01c3 a40f          	and	a,#15
1050  01c5 2704          	jreq	L011
1051  01c7               L211:
1052  01c7 58            	sllw	x
1053  01c8 4a            	dec	a
1054  01c9 26fc          	jrne	L211
1055  01cb               L011:
1056  01cb a30000        	cpw	x,#0
1057  01ce 2603          	jrne	L601
1058  01d0 5c            	incw	x
1059  01d1 2001          	jra	L411
1060  01d3               L601:
1061  01d3 5f            	clrw	x
1062  01d4               L411:
1063  01d4 90fe          	ldw	y,(y)
1064  01d6 9054          	srlw	y
1065  01d8 9054          	srlw	y
1066  01da 9054          	srlw	y
1067  01dc 9054          	srlw	y
1068  01de 9058          	sllw	y
1069  01e0 72f907        	addw	y,(OFST+7,sp)
1070  01e3 01            	rrwa	x,a
1071  01e4 90e401        	and	a,(1,y)
1072  01e7 01            	rrwa	x,a
1073  01e8 90f4          	and	a,(y)
1074  01ea 01            	rrwa	x,a
1075  01eb 90ff          	ldw	(y),x
1077  01ed               L324:
1078                     ; 188 }
1081  01ed 85            	popw	x
1082  01ee 81            	ret	
1165                     ; 191 bool StateOfCoil(uint8_t NumberOfCoil, uint16_t registers[])
1165                     ; 192 {
1166                     	switch	.text
1167  01ef               _StateOfCoil:
1169  01ef 88            	push	a
1170  01f0 5204          	subw	sp,#4
1171       00000004      OFST:	set	4
1174                     ; 194 	uint16_t Value = registers[NumberOfCoil/16];   
1176  01f2 5f            	clrw	x
1177  01f3 97            	ld	xl,a
1178  01f4 57            	sraw	x
1179  01f5 57            	sraw	x
1180  01f6 57            	sraw	x
1181  01f7 57            	sraw	x
1182  01f8 58            	sllw	x
1183  01f9 72fb08        	addw	x,(OFST+4,sp)
1184  01fc fe            	ldw	x,(x)
1185  01fd 1f01          	ldw	(OFST-3,sp),x
1186                     ; 197 	uint16_t Compare = 1<<(NumberOfCoil%16);			
1188  01ff ae0001        	ldw	x,#1
1189  0202 a40f          	and	a,#15
1190  0204 2704          	jreq	L021
1191  0206               L221:
1192  0206 58            	sllw	x
1193  0207 4a            	dec	a
1194  0208 26fc          	jrne	L221
1195  020a               L021:
1196  020a 1f03          	ldw	(OFST-1,sp),x
1197                     ; 199 	if ((Value & Compare) == Compare )
1199  020c 1e01          	ldw	x,(OFST-3,sp)
1200  020e 01            	rrwa	x,a
1201  020f 1404          	and	a,(OFST+0,sp)
1202  0211 01            	rrwa	x,a
1203  0212 1403          	and	a,(OFST-1,sp)
1204  0214 01            	rrwa	x,a
1205  0215 1303          	cpw	x,(OFST-1,sp)
1206  0217 2604          	jrne	L374
1207                     ; 201 				return 1;
1209  0219 a601          	ld	a,#1
1211  021b 2001          	jra	L421
1212  021d               L374:
1213                     ; 206 				return 0;
1215  021d 4f            	clr	a
1217  021e               L421:
1219  021e 5b05          	addw	sp,#5
1220  0220 81            	ret	
1305                     ; 212 bool CheckLRC(char *frame)
1305                     ; 213 {
1306                     	switch	.text
1307  0221               _CheckLRC:
1309  0221 89            	pushw	x
1310  0222 5207          	subw	sp,#7
1311       00000007      OFST:	set	7
1314                     ; 214 	uint8_t a = 0;
1316  0224 0f07          	clr	(OFST+0,sp)
1317                     ; 217 	uint8_t tempSum = 0;
1319  0226 0f01          	clr	(OFST-6,sp)
1320                     ; 219 	uint8_t LRC_calculated = 0;
1322                     ; 221 	uint8_t LRC_dec_from_frame = 0;	
1324  0228 0f02          	clr	(OFST-5,sp)
1326  022a 2002          	jra	L545
1327  022c               L145:
1328                     ; 226 				a++;
1330  022c 0c07          	inc	(OFST+0,sp)
1331  022e               L545:
1332                     ; 224 	while(word[a] != '\r')
1334  022e 7b07          	ld	a,(OFST+0,sp)
1335  0230 5f            	clrw	x
1336  0231 97            	ld	xl,a
1337  0232 e600          	ld	a,(_word,x)
1338  0234 a10d          	cp	a,#13
1339  0236 26f4          	jrne	L145
1340                     ; 229 temp[1] = frame[a-1];
1342  0238 7b07          	ld	a,(OFST+0,sp)
1343  023a 5f            	clrw	x
1344  023b 97            	ld	xl,a
1345  023c 5a            	decw	x
1346  023d 72fb08        	addw	x,(OFST+1,sp)
1347  0240 f6            	ld	a,(x)
1348  0241 6b04          	ld	(OFST-3,sp),a
1349                     ; 230 temp[0] = frame[a-2];
1351  0243 5f            	clrw	x
1352  0244 7b07          	ld	a,(OFST+0,sp)
1353  0246 97            	ld	xl,a
1354  0247 1d0002        	subw	x,#2
1355  024a 72fb08        	addw	x,(OFST+1,sp)
1356  024d f6            	ld	a,(x)
1357  024e 6b03          	ld	(OFST-4,sp),a
1358                     ; 232 HexToByte(temp,&LRC_dec_from_frame);
1360  0250 96            	ldw	x,sp
1361  0251 1c0002        	addw	x,#OFST-5
1362  0254 89            	pushw	x
1363  0255 5c            	incw	x
1364  0256 cd00df        	call	_HexToByte
1366  0259 85            	popw	x
1367                     ; 234 frame[a-1] = '\0';
1369  025a 7b07          	ld	a,(OFST+0,sp)
1370  025c 5f            	clrw	x
1371  025d 97            	ld	xl,a
1372  025e 5a            	decw	x
1373  025f 72fb08        	addw	x,(OFST+1,sp)
1374  0262 7f            	clr	(x)
1375                     ; 235 frame[a-2] = '\0';
1377  0263 5f            	clrw	x
1378  0264 97            	ld	xl,a
1379  0265 1d0002        	subw	x,#2
1380  0268 72fb08        	addw	x,(OFST+1,sp)
1381  026b 7f            	clr	(x)
1382                     ; 238 LRC_calculated = GetLRC(frame);
1384  026c 1e08          	ldw	x,(OFST+1,sp)
1385  026e ad0e          	call	_GetLRC
1387  0270 6b07          	ld	(OFST+0,sp),a
1388                     ; 240 if (LRC_calculated == LRC_dec_from_frame)
1390  0272 1102          	cp	a,(OFST-5,sp)
1391  0274 2604          	jrne	L155
1392                     ; 242 	return 1;
1394  0276 a601          	ld	a,#1
1396  0278 2001          	jra	L431
1397  027a               L155:
1398                     ; 246 	return 0;
1400  027a 4f            	clr	a
1402  027b               L431:
1404  027b 5b09          	addw	sp,#9
1405  027d 81            	ret	
1469                     ; 250 uint8_t GetLRC(char *frame)
1469                     ; 251 {
1470                     	switch	.text
1471  027e               _GetLRC:
1473  027e 89            	pushw	x
1474  027f 5204          	subw	sp,#4
1475       00000004      OFST:	set	4
1478                     ; 252 uint8_t LRCsum = 0;
1480  0281 0f01          	clr	(OFST-3,sp)
1481                     ; 255 frame++;
1483  0283 1e05          	ldw	x,(OFST+1,sp)
1484  0285 5c            	incw	x
1485  0286 1f05          	ldw	(OFST+1,sp),x
1487  0288 201b          	jra	L116
1488  028a               L706:
1489                     ; 259 temp[0] = *frame++;
1491  028a 6b03          	ld	(OFST-1,sp),a
1492  028c 5c            	incw	x
1493                     ; 260 temp[1] = *frame++;
1495  028d f6            	ld	a,(x)
1496  028e 5c            	incw	x
1497  028f 1f05          	ldw	(OFST+1,sp),x
1498  0291 6b04          	ld	(OFST+0,sp),a
1499                     ; 261 HexToByte(temp, &TempSum);
1501  0293 96            	ldw	x,sp
1502  0294 1c0002        	addw	x,#OFST-2
1503  0297 89            	pushw	x
1504  0298 5c            	incw	x
1505  0299 cd00df        	call	_HexToByte
1507  029c 85            	popw	x
1508                     ; 262 LRCsum += TempSum;
1510  029d 7b01          	ld	a,(OFST-3,sp)
1511  029f 1b02          	add	a,(OFST-2,sp)
1512  02a1 6b01          	ld	(OFST-3,sp),a
1513  02a3 1e05          	ldw	x,(OFST+1,sp)
1514  02a5               L116:
1515                     ; 257 while(*frame)
1517  02a5 f6            	ld	a,(x)
1518  02a6 26e2          	jrne	L706
1519                     ; 264 LRCsum = (~(LRCsum)+1);
1521  02a8 7b01          	ld	a,(OFST-3,sp)
1522  02aa 43            	cpl	a
1523  02ab 4c            	inc	a
1524                     ; 265 return LRCsum;
1528  02ac 5b06          	addw	sp,#6
1529  02ae 81            	ret	
1621                     ; 269 void HexToByte_4(char *hexstring_4, uint16_t *byte)
1621                     ; 270 {
1622                     	switch	.text
1623  02af               _HexToByte_4:
1625  02af 89            	pushw	x
1626  02b0 5208          	subw	sp,#8
1627       00000008      OFST:	set	8
1630                     ; 272 uint8_t right_dec = 0;
1632  02b2 0f01          	clr	(OFST-7,sp)
1633                     ; 273 uint8_t left_dec = 0;
1635  02b4 0f02          	clr	(OFST-6,sp)
1636                     ; 274 uint16_t right_dec16 = 0;
1638  02b6 5f            	clrw	x
1639  02b7 1f03          	ldw	(OFST-5,sp),x
1640                     ; 275 uint16_t left_dec16 = 0;
1642  02b9 1f05          	ldw	(OFST-3,sp),x
1643                     ; 277 tempp[0] = hexstring_4[0];
1645  02bb 1e09          	ldw	x,(OFST+1,sp)
1646  02bd f6            	ld	a,(x)
1647  02be 6b07          	ld	(OFST-1,sp),a
1648                     ; 278 tempp[1] = hexstring_4[1];
1650  02c0 e601          	ld	a,(1,x)
1651  02c2 6b08          	ld	(OFST+0,sp),a
1652                     ; 279 HexToByte(tempp,&left_dec);
1654  02c4 96            	ldw	x,sp
1655  02c5 1c0002        	addw	x,#OFST-6
1656  02c8 89            	pushw	x
1657  02c9 1c0005        	addw	x,#5
1658  02cc cd00df        	call	_HexToByte
1660  02cf 85            	popw	x
1661                     ; 281 tempp[0] = hexstring_4[2];
1663  02d0 1e09          	ldw	x,(OFST+1,sp)
1664  02d2 e602          	ld	a,(2,x)
1665  02d4 6b07          	ld	(OFST-1,sp),a
1666                     ; 282 tempp[1] = hexstring_4[3];
1668  02d6 e603          	ld	a,(3,x)
1669  02d8 6b08          	ld	(OFST+0,sp),a
1670                     ; 283 HexToByte(tempp,&right_dec);
1672  02da 96            	ldw	x,sp
1673  02db 5c            	incw	x
1674  02dc 89            	pushw	x
1675  02dd 1c0006        	addw	x,#6
1676  02e0 cd00df        	call	_HexToByte
1678  02e3 85            	popw	x
1679                     ; 285 left_dec16 = left_dec16 | left_dec;
1681  02e4 7b02          	ld	a,(OFST-6,sp)
1682  02e6 5f            	clrw	x
1683  02e7 97            	ld	xl,a
1684  02e8 01            	rrwa	x,a
1685  02e9 1a06          	or	a,(OFST-2,sp)
1686  02eb 01            	rrwa	x,a
1687  02ec 1a05          	or	a,(OFST-3,sp)
1688  02ee 01            	rrwa	x,a
1689  02ef 1f05          	ldw	(OFST-3,sp),x
1690                     ; 286 right_dec16 = right_dec16 | right_dec;
1692  02f1 5f            	clrw	x
1693  02f2 7b01          	ld	a,(OFST-7,sp)
1694  02f4 97            	ld	xl,a
1695  02f5 01            	rrwa	x,a
1696  02f6 1a04          	or	a,(OFST-4,sp)
1697  02f8 01            	rrwa	x,a
1698  02f9 1a03          	or	a,(OFST-5,sp)
1699  02fb 01            	rrwa	x,a
1700  02fc 1f03          	ldw	(OFST-5,sp),x
1701                     ; 288 *byte = (left_dec16 << 8) | right_dec16;
1703  02fe 7b04          	ld	a,(OFST-4,sp)
1704  0300 1e05          	ldw	x,(OFST-3,sp)
1705  0302 01            	rrwa	x,a
1706  0303 1a03          	or	a,(OFST-5,sp)
1707  0305 160d          	ldw	y,(OFST+5,sp)
1708  0307 01            	rrwa	x,a
1709  0308 90ff          	ldw	(y),x
1710                     ; 289 }
1713  030a 5b0a          	addw	sp,#10
1714  030c 81            	ret	
1824                     ; 293 void ByteToHex_4(char *hexstring, uint16_t byte)
1824                     ; 294 {
1825                     	switch	.text
1826  030d               _ByteToHex_4:
1828  030d 89            	pushw	x
1829  030e 520b          	subw	sp,#11
1830       0000000b      OFST:	set	11
1833                     ; 297 	uint16_t D1 = byte >> 8;
1835  0310 1e10          	ldw	x,(OFST+5,sp)
1836  0312 4f            	clr	a
1837  0313 01            	rrwa	x,a
1838  0314 1f02          	ldw	(OFST-9,sp),x
1839                     ; 298   uint16_t D2 = byte & 255;
1841  0316 5f            	clrw	x
1842  0317 7b11          	ld	a,(OFST+6,sp)
1843  0319 02            	rlwa	x,a
1844  031a 1f04          	ldw	(OFST-7,sp),x
1845                     ; 299 	uint8_t D1_8 = 0;
1847  031c 0f06          	clr	(OFST-5,sp)
1848                     ; 300 	uint8_t D2_8 = 0;
1850  031e 0f07          	clr	(OFST-4,sp)
1851                     ; 301 	uint8_t ct = 0;
1853  0320 0f01          	clr	(OFST-10,sp)
1854                     ; 303 	D1_8 |= D1;
1856  0322 7b06          	ld	a,(OFST-5,sp)
1857  0324 1a03          	or	a,(OFST-8,sp)
1858  0326 6b06          	ld	(OFST-5,sp),a
1859                     ; 304 	D2_8 |= D2;
1861  0328 7b07          	ld	a,(OFST-4,sp)
1862  032a 1a05          	or	a,(OFST-6,sp)
1863  032c 6b07          	ld	(OFST-4,sp),a
1864                     ; 306 	ByteToHex(temp1, D1_8);
1866  032e 7b06          	ld	a,(OFST-5,sp)
1867  0330 88            	push	a
1868  0331 96            	ldw	x,sp
1869  0332 1c0009        	addw	x,#OFST-2
1870  0335 cd00a7        	call	_ByteToHex
1872  0338 84            	pop	a
1873                     ; 307 	ByteToHex(temp2, D2_8);
1875  0339 7b07          	ld	a,(OFST-4,sp)
1876  033b 88            	push	a
1877  033c 96            	ldw	x,sp
1878  033d 1c000b        	addw	x,#OFST+0
1879  0340 cd00a7        	call	_ByteToHex
1881  0343 84            	pop	a
1882                     ; 309 	hexstring[0] = temp1[0];
1884  0344 1e0c          	ldw	x,(OFST+1,sp)
1885  0346 7b08          	ld	a,(OFST-3,sp)
1886  0348 f7            	ld	(x),a
1887                     ; 310 	hexstring[1] = temp1[1];
1889  0349 7b09          	ld	a,(OFST-2,sp)
1890  034b e701          	ld	(1,x),a
1891                     ; 311 	hexstring[2] = temp2[0];
1893  034d 7b0a          	ld	a,(OFST-1,sp)
1894  034f e702          	ld	(2,x),a
1895                     ; 312 	hexstring[3] = temp2[1];
1897  0351 7b0b          	ld	a,(OFST+0,sp)
1898  0353 e703          	ld	(3,x),a
1899                     ; 314 }
1902  0355 5b0d          	addw	sp,#13
1903  0357 81            	ret	
2065                     ; 324 void ReadCoilStatus(uint16_t *registers)
2065                     ; 325 {
2066                     	switch	.text
2067  0358               _ReadCoilStatus:
2069  0358 89            	pushw	x
2070  0359 522c          	subw	sp,#44
2071       0000002c      OFST:	set	44
2074                     ; 327 uint8_t counter = 0;
2076                     ; 328 uint8_t TempSum=0;
2078  035b 0f0e          	clr	(OFST-30,sp)
2079                     ; 335 uint16_t n = 0;
2081                     ; 338 for(n = 0; n<OFS; n++){OutputFrame[n] = '\0';}
2083  035d 5f            	clrw	x
2084  035e 1f2a          	ldw	(OFST-2,sp),x
2085  0360               L3401:
2088  0360 96            	ldw	x,sp
2089  0361 1c0011        	addw	x,#OFST-27
2090  0364 72fb2a        	addw	x,(OFST-2,sp)
2091  0367 7f            	clr	(x)
2094  0368 1e2a          	ldw	x,(OFST-2,sp)
2095  036a 5c            	incw	x
2096  036b 1f2a          	ldw	(OFST-2,sp),x
2099  036d a30019        	cpw	x,#25
2100  0370 25ee          	jrult	L3401
2101                     ; 341 RewritingChars(OutputFrame,0,4);
2103  0372 4b04          	push	#4
2104  0374 4b00          	push	#0
2105  0376 96            	ldw	x,sp
2106  0377 1c0013        	addw	x,#OFST-25
2107  037a cd015d        	call	_RewritingChars
2109  037d b605          	ld	a,_word+5
2110  037f 85            	popw	x
2111                     ; 344 temp4[0] = word[5];
2113  0380 6b08          	ld	(OFST-36,sp),a
2114                     ; 345 temp4[1] = word[6];
2116  0382 b606          	ld	a,_word+6
2117  0384 6b09          	ld	(OFST-35,sp),a
2118                     ; 346 temp4[2] = word[7];
2120  0386 b607          	ld	a,_word+7
2121  0388 6b0a          	ld	(OFST-34,sp),a
2122                     ; 347 temp4[3] = word[8];
2124  038a b608          	ld	a,_word+8
2125  038c 6b0b          	ld	(OFST-33,sp),a
2126                     ; 348 HexToByte_4(temp4, &FirstCoil);
2128  038e 96            	ldw	x,sp
2129  038f 1c0003        	addw	x,#OFST-41
2130  0392 89            	pushw	x
2131  0393 1c0005        	addw	x,#5
2132  0396 cd02af        	call	_HexToByte_4
2134  0399 b609          	ld	a,_word+9
2135  039b 85            	popw	x
2136                     ; 351 temp4[0] = word[9];
2138  039c 6b08          	ld	(OFST-36,sp),a
2139                     ; 352 temp4[1] = word[10];
2141  039e b60a          	ld	a,_word+10
2142  03a0 6b09          	ld	(OFST-35,sp),a
2143                     ; 353 temp4[2] = word[11];
2145  03a2 b60b          	ld	a,_word+11
2146  03a4 6b0a          	ld	(OFST-34,sp),a
2147                     ; 354 temp4[3] = word[12];
2149  03a6 b60c          	ld	a,_word+12
2150  03a8 6b0b          	ld	(OFST-33,sp),a
2151                     ; 355 HexToByte_4(temp4, &NumberOfCoils);
2153  03aa 96            	ldw	x,sp
2154  03ab 1c0005        	addw	x,#OFST-39
2155  03ae 89            	pushw	x
2156  03af 1c0003        	addw	x,#3
2157  03b2 cd02af        	call	_HexToByte_4
2159  03b5 85            	popw	x
2160                     ; 358 if((NumberOfCoils%8)!=0)
2162  03b6 7b06          	ld	a,(OFST-38,sp)
2163  03b8 a507          	bcp	a,#7
2164  03ba 2709          	jreq	L1501
2165                     ; 360 	NumberOfDataBytes = ( NumberOfCoils/8)+1;
2167  03bc 1e05          	ldw	x,(OFST-39,sp)
2168  03be 54            	srlw	x
2169  03bf 54            	srlw	x
2170  03c0 54            	srlw	x
2171  03c1 01            	rrwa	x,a
2172  03c2 4c            	inc	a
2174  03c3 2006          	jra	L3501
2175  03c5               L1501:
2176                     ; 364 	NumberOfDataBytes = NumberOfCoils/8;
2178  03c5 1e05          	ldw	x,(OFST-39,sp)
2179  03c7 54            	srlw	x
2180  03c8 54            	srlw	x
2181  03c9 54            	srlw	x
2182  03ca 01            	rrwa	x,a
2183  03cb               L3501:
2184  03cb 6b07          	ld	(OFST-37,sp),a
2185                     ; 368 ByteToHex(temp,NumberOfDataBytes);
2187  03cd 88            	push	a
2188  03ce 96            	ldw	x,sp
2189  03cf 1c0010        	addw	x,#OFST-28
2190  03d2 cd00a7        	call	_ByteToHex
2192  03d5 84            	pop	a
2193                     ; 369 OutputFrame[5] = temp[0];
2195  03d6 7b0f          	ld	a,(OFST-29,sp)
2196  03d8 6b16          	ld	(OFST-22,sp),a
2197                     ; 370 OutputFrame[6] = temp[1];
2199  03da 7b10          	ld	a,(OFST-28,sp)
2200  03dc 6b17          	ld	(OFST-21,sp),a
2201                     ; 373 counter = 7; 
2203  03de a607          	ld	a,#7
2204  03e0 6b2c          	ld	(OFST+0,sp),a
2205                     ; 374 Coil = FirstCoil;
2207  03e2 1e03          	ldw	x,(OFST-41,sp)
2208  03e4 1f0c          	ldw	(OFST-32,sp),x
2209                     ; 375 n = NumberOfCoils;
2211  03e6 1e05          	ldw	x,(OFST-39,sp)
2212  03e8 1f2a          	ldw	(OFST-2,sp),x
2214  03ea cc04b2        	jra	L1601
2215  03ed               L5501:
2216                     ; 378 		if(n>=8)                   //    changes 8bits to hex
2218  03ed a30008        	cpw	x,#8
2219  03f0 255b          	jrult	L5601
2220                     ; 380 						uint8_t pwr = 0;
2222                     ; 381 						for(pwr =0; pwr<8; pwr++,Coil++)
2224  03f2 0f02          	clr	(OFST-42,sp)
2225  03f4               L7601:
2226                     ; 383 								TempSum += (1<<pwr)*StateOfCoil(Coil, registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
2228  03f4 1e2d          	ldw	x,(OFST+1,sp)
2229  03f6 89            	pushw	x
2230  03f7 7b0f          	ld	a,(OFST-29,sp)
2231  03f9 cd01ef        	call	_StateOfCoil
2233  03fc 85            	popw	x
2234  03fd 6b01          	ld	(OFST-43,sp),a
2235  03ff 5f            	clrw	x
2236  0400 7b02          	ld	a,(OFST-42,sp)
2237  0402 97            	ld	xl,a
2238  0403 a601          	ld	a,#1
2239  0405 5d            	tnzw	x
2240  0406 2704          	jreq	L271
2241  0408               L471:
2242  0408 48            	sll	a
2243  0409 5a            	decw	x
2244  040a 26fc          	jrne	L471
2245  040c               L271:
2246  040c 97            	ld	xl,a
2247  040d 7b01          	ld	a,(OFST-43,sp)
2248  040f 42            	mul	x,a
2249  0410 9f            	ld	a,xl
2250  0411 1b0e          	add	a,(OFST-30,sp)
2251  0413 6b0e          	ld	(OFST-30,sp),a
2252                     ; 384 								n--;
2254  0415 1e2a          	ldw	x,(OFST-2,sp)
2255  0417 5a            	decw	x
2256  0418 1f2a          	ldw	(OFST-2,sp),x
2257                     ; 381 						for(pwr =0; pwr<8; pwr++,Coil++)
2259  041a 0c02          	inc	(OFST-42,sp)
2260  041c 1e0c          	ldw	x,(OFST-32,sp)
2261  041e 5c            	incw	x
2262  041f 1f0c          	ldw	(OFST-32,sp),x
2265  0421 7b02          	ld	a,(OFST-42,sp)
2266  0423 a108          	cp	a,#8
2267  0425 25cd          	jrult	L7601
2268                     ; 387 						ByteToHex(temp,TempSum);
2270  0427 7b0e          	ld	a,(OFST-30,sp)
2271  0429 88            	push	a
2272  042a 96            	ldw	x,sp
2273  042b 1c0010        	addw	x,#OFST-28
2274  042e cd00a7        	call	_ByteToHex
2276  0431 84            	pop	a
2277                     ; 388 						TempSum = 0;
2279  0432 0f0e          	clr	(OFST-30,sp)
2280                     ; 389 						OutputFrame[counter] = temp[0];
2282  0434 96            	ldw	x,sp
2283  0435 cd0519        	call	LC003
2284  0438 1b2c          	add	a,(OFST+0,sp)
2285  043a 2401          	jrnc	L002
2286  043c 5c            	incw	x
2287  043d               L002:
2288  043d 02            	rlwa	x,a
2289  043e 7b0f          	ld	a,(OFST-29,sp)
2290  0440 f7            	ld	(x),a
2291                     ; 390 						counter++;
2293                     ; 391 						OutputFrame[counter] = temp[1];
2295  0441 96            	ldw	x,sp
2296  0442 0c2c          	inc	(OFST+0,sp)
2297  0444 cd0519        	call	LC003
2298  0447 1b2c          	add	a,(OFST+0,sp)
2299  0449 2461          	jrnc	L612
2300                     ; 392 						counter++;
2302  044b 205e          	jp	LC002
2303  044d               L5601:
2304                     ; 397 						uint8_t pwr = 0;
2306                     ; 398 						uint8_t zm = n;
2308  044d 7b2b          	ld	a,(OFST-1,sp)
2309  044f 6b07          	ld	(OFST-37,sp),a
2310                     ; 399 						for(pwr =0; pwr<zm; pwr++,Coil++)
2312  0451 0f02          	clr	(OFST-42,sp)
2314  0453 202d          	jra	L3011
2315  0455               L7701:
2316                     ; 401 								TempSum += (1<<pwr)*StateOfCoil(Coil, registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
2318  0455 1e2d          	ldw	x,(OFST+1,sp)
2319  0457 89            	pushw	x
2320  0458 7b0f          	ld	a,(OFST-29,sp)
2321  045a cd01ef        	call	_StateOfCoil
2323  045d 85            	popw	x
2324  045e 6b01          	ld	(OFST-43,sp),a
2325  0460 5f            	clrw	x
2326  0461 7b02          	ld	a,(OFST-42,sp)
2327  0463 97            	ld	xl,a
2328  0464 a601          	ld	a,#1
2329  0466 5d            	tnzw	x
2330  0467 2704          	jreq	L602
2331  0469               L012:
2332  0469 48            	sll	a
2333  046a 5a            	decw	x
2334  046b 26fc          	jrne	L012
2335  046d               L602:
2336  046d 97            	ld	xl,a
2337  046e 7b01          	ld	a,(OFST-43,sp)
2338  0470 42            	mul	x,a
2339  0471 9f            	ld	a,xl
2340  0472 1b0e          	add	a,(OFST-30,sp)
2341  0474 6b0e          	ld	(OFST-30,sp),a
2342                     ; 402 								n--;
2344  0476 1e2a          	ldw	x,(OFST-2,sp)
2345  0478 5a            	decw	x
2346  0479 1f2a          	ldw	(OFST-2,sp),x
2347                     ; 399 						for(pwr =0; pwr<zm; pwr++,Coil++)
2349  047b 0c02          	inc	(OFST-42,sp)
2350  047d 1e0c          	ldw	x,(OFST-32,sp)
2351  047f 5c            	incw	x
2352  0480 1f0c          	ldw	(OFST-32,sp),x
2353  0482               L3011:
2356  0482 7b02          	ld	a,(OFST-42,sp)
2357  0484 1107          	cp	a,(OFST-37,sp)
2358  0486 25cd          	jrult	L7701
2359                     ; 404 						ByteToHex(temp,TempSum);
2361  0488 7b0e          	ld	a,(OFST-30,sp)
2362  048a 88            	push	a
2363  048b 96            	ldw	x,sp
2364  048c 1c0010        	addw	x,#OFST-28
2365  048f cd00a7        	call	_ByteToHex
2367  0492 84            	pop	a
2368                     ; 405 						TempSum = 0;
2370  0493 0f0e          	clr	(OFST-30,sp)
2371                     ; 406 						OutputFrame[counter] = temp[0];
2373  0495 96            	ldw	x,sp
2374  0496 cd0519        	call	LC003
2375  0499 1b2c          	add	a,(OFST+0,sp)
2376  049b 2401          	jrnc	L412
2377  049d 5c            	incw	x
2378  049e               L412:
2379  049e 02            	rlwa	x,a
2380  049f 7b0f          	ld	a,(OFST-29,sp)
2381  04a1 f7            	ld	(x),a
2382                     ; 407 						counter++;
2384                     ; 408 						OutputFrame[counter] = temp[1];
2386  04a2 96            	ldw	x,sp
2387  04a3 0c2c          	inc	(OFST+0,sp)
2388  04a5 ad72          	call	LC003
2389  04a7 1b2c          	add	a,(OFST+0,sp)
2390  04a9 2401          	jrnc	L612
2391  04ab               LC002:
2392  04ab 5c            	incw	x
2393  04ac               L612:
2394                     ; 409 						counter++;
2396  04ac 02            	rlwa	x,a
2397  04ad 7b10          	ld	a,(OFST-28,sp)
2398  04af f7            	ld	(x),a
2400  04b0 0c2c          	inc	(OFST+0,sp)
2401  04b2               L1601:
2402                     ; 376 while(n>0)
2404  04b2 1e2a          	ldw	x,(OFST-2,sp)
2405  04b4 2703cc03ed    	jrne	L5501
2406                     ; 414 ByteToHex(temp,GetLRC(OutputFrame));
2408  04b9 96            	ldw	x,sp
2409  04ba 1c0011        	addw	x,#OFST-27
2410  04bd cd027e        	call	_GetLRC
2412  04c0 88            	push	a
2413  04c1 96            	ldw	x,sp
2414  04c2 1c0010        	addw	x,#OFST-28
2415  04c5 cd00a7        	call	_ByteToHex
2417  04c8 84            	pop	a
2418                     ; 415 OutputFrame[counter] = temp[0];
2420  04c9 96            	ldw	x,sp
2421  04ca ad4d          	call	LC003
2422  04cc 1b2c          	add	a,(OFST+0,sp)
2423  04ce 2401          	jrnc	L422
2424  04d0 5c            	incw	x
2425  04d1               L422:
2426  04d1 02            	rlwa	x,a
2427  04d2 7b0f          	ld	a,(OFST-29,sp)
2428  04d4 f7            	ld	(x),a
2429                     ; 416 counter++;
2431                     ; 417 OutputFrame[counter] = temp[1];
2433  04d5 96            	ldw	x,sp
2434  04d6 0c2c          	inc	(OFST+0,sp)
2435  04d8 ad3f          	call	LC003
2436  04da 1b2c          	add	a,(OFST+0,sp)
2437  04dc 2401          	jrnc	L622
2438  04de 5c            	incw	x
2439  04df               L622:
2440  04df 02            	rlwa	x,a
2441  04e0 7b10          	ld	a,(OFST-28,sp)
2442  04e2 f7            	ld	(x),a
2443                     ; 418 counter++;
2445                     ; 419 OutputFrame[counter] = 0x0D;
2447  04e3 96            	ldw	x,sp
2448  04e4 0c2c          	inc	(OFST+0,sp)
2449  04e6 ad31          	call	LC003
2450  04e8 1b2c          	add	a,(OFST+0,sp)
2451  04ea 2401          	jrnc	L032
2452  04ec 5c            	incw	x
2453  04ed               L032:
2454  04ed 02            	rlwa	x,a
2455  04ee a60d          	ld	a,#13
2456  04f0 f7            	ld	(x),a
2457                     ; 420 counter++;
2459                     ; 421 OutputFrame[counter] = 0x0A;
2461  04f1 96            	ldw	x,sp
2462  04f2 0c2c          	inc	(OFST+0,sp)
2463  04f4 ad23          	call	LC003
2464  04f6 1b2c          	add	a,(OFST+0,sp)
2465  04f8 2401          	jrnc	L232
2466  04fa 5c            	incw	x
2467  04fb               L232:
2468  04fb 02            	rlwa	x,a
2469  04fc a60a          	ld	a,#10
2470  04fe f7            	ld	(x),a
2471                     ; 422 counter++;
2473                     ; 423 OutputFrame[counter] = 0x0A;
2475  04ff 96            	ldw	x,sp
2476  0500 0c2c          	inc	(OFST+0,sp)
2477  0502 ad15          	call	LC003
2478  0504 1b2c          	add	a,(OFST+0,sp)
2479  0506 2401          	jrnc	L432
2480  0508 5c            	incw	x
2481  0509               L432:
2482  0509 02            	rlwa	x,a
2483  050a a60a          	ld	a,#10
2484  050c f7            	ld	(x),a
2485                     ; 424 counter++;
2487                     ; 427 	UART_SendStr(OutputFrame); 
2489  050d 96            	ldw	x,sp
2490  050e 0c2c          	inc	(OFST+0,sp)
2491  0510 1c0011        	addw	x,#OFST-27
2492  0513 cd0000        	call	_UART_SendStr
2494                     ; 428 }
2497  0516 5b2e          	addw	sp,#46
2498  0518 81            	ret	
2499  0519               LC003:
2500  0519 1c0011        	addw	x,#OFST-27
2501  051c 9f            	ld	a,xl
2502  051d 5e            	swapw	x
2503  051e 81            	ret	
2528                     ; 432 void ReadInputStatus(void)
2528                     ; 433 {
2529                     	switch	.text
2530  051f               _ReadInputStatus:
2534                     ; 434 ReadCoilStatus(Input_Registers);
2536  051f ae0000        	ldw	x,#_Input_Registers
2538                     ; 435 }
2541  0522 cc0358        	jp	_ReadCoilStatus
2678                     ; 439 void ReadHoldingRegisters(uint16_t *registers)
2678                     ; 440 {
2679                     	switch	.text
2680  0525               _ReadHoldingRegisters:
2682  0525 89            	pushw	x
2683  0526 5228          	subw	sp,#40
2684       00000028      OFST:	set	40
2687                     ; 445 uint16_t FirstReg = 0;
2689  0528 5f            	clrw	x
2690  0529 1f01          	ldw	(OFST-39,sp),x
2691                     ; 446 uint16_t NumberOfRegs = 0;
2693  052b 1f05          	ldw	(OFST-35,sp),x
2694                     ; 447 uint8_t NumberOfBytes = 0 ;
2696                     ; 448 uint8_t ct = 0;
2698                     ; 449 uint8_t k = 0;
2700                     ; 450 uint8_t counter = 0;
2702                     ; 451 uint16_t Content_dec = 0;
2704                     ; 455 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
2706  052d 0f0a          	clr	(OFST-30,sp)
2707  052f               L5021:
2710  052f 96            	ldw	x,sp
2711  0530 cd0668        	call	LC004
2712  0533 1b0a          	add	a,(OFST-30,sp)
2713  0535 2401          	jrnc	L642
2714  0537 5c            	incw	x
2715  0538               L642:
2716  0538 02            	rlwa	x,a
2717  0539 7f            	clr	(x)
2720  053a 0c0a          	inc	(OFST-30,sp)
2723  053c 7b0a          	ld	a,(OFST-30,sp)
2724  053e a119          	cp	a,#25
2725  0540 25ed          	jrult	L5021
2726                     ; 458 RewritingChars(OutputFrame,0,4);
2728  0542 4b04          	push	#4
2729  0544 4b00          	push	#0
2730  0546 96            	ldw	x,sp
2731  0547 1c000d        	addw	x,#OFST-27
2732  054a cd015d        	call	_RewritingChars
2734  054d b605          	ld	a,_word+5
2735  054f 85            	popw	x
2736                     ; 461 temp[0] = word[5];
2738  0550 6b24          	ld	(OFST-4,sp),a
2739                     ; 462 temp[1] = word[6];
2741  0552 b606          	ld	a,_word+6
2742  0554 6b25          	ld	(OFST-3,sp),a
2743                     ; 463 temp[2] = word[7];
2745  0556 b607          	ld	a,_word+7
2746  0558 6b26          	ld	(OFST-2,sp),a
2747                     ; 464 temp[3] = word[8];
2749  055a b608          	ld	a,_word+8
2750  055c 6b27          	ld	(OFST-1,sp),a
2751                     ; 465 HexToByte_4(temp, &FirstReg);
2753  055e 96            	ldw	x,sp
2754  055f 5c            	incw	x
2755  0560 89            	pushw	x
2756  0561 1c0023        	addw	x,#35
2757  0564 cd02af        	call	_HexToByte_4
2759  0567 b609          	ld	a,_word+9
2760  0569 85            	popw	x
2761                     ; 468 temp[0] = word[9];
2763  056a 6b24          	ld	(OFST-4,sp),a
2764                     ; 469 temp[1] = word[10];
2766  056c b60a          	ld	a,_word+10
2767  056e 6b25          	ld	(OFST-3,sp),a
2768                     ; 470 temp[2] = word[11];
2770  0570 b60b          	ld	a,_word+11
2771  0572 6b26          	ld	(OFST-2,sp),a
2772                     ; 471 temp[3] = word[12];
2774  0574 b60c          	ld	a,_word+12
2775  0576 6b27          	ld	(OFST-1,sp),a
2776                     ; 472 HexToByte_4(temp, &NumberOfRegs);
2778  0578 96            	ldw	x,sp
2779  0579 1c0005        	addw	x,#OFST-35
2780  057c 89            	pushw	x
2781  057d 1c001f        	addw	x,#31
2782  0580 cd02af        	call	_HexToByte_4
2784  0583 85            	popw	x
2785                     ; 475 NumberOfBytes = NumberOfRegs*2;
2787  0584 7b06          	ld	a,(OFST-34,sp)
2788  0586 48            	sll	a
2789  0587 6b09          	ld	(OFST-31,sp),a
2790                     ; 478 ByteToHex(temp,NumberOfBytes);
2792  0589 88            	push	a
2793  058a 96            	ldw	x,sp
2794  058b 1c0025        	addw	x,#OFST-3
2795  058e cd00a7        	call	_ByteToHex
2797  0591 84            	pop	a
2798                     ; 479 OutputFrame[5] = temp[0];
2800  0592 7b24          	ld	a,(OFST-4,sp)
2801  0594 6b10          	ld	(OFST-24,sp),a
2802                     ; 480 OutputFrame[6] = temp[1];
2804  0596 7b25          	ld	a,(OFST-3,sp)
2805  0598 6b11          	ld	(OFST-23,sp),a
2806                     ; 482 counter = 7;
2808  059a a607          	ld	a,#7
2809  059c 6b28          	ld	(OFST+0,sp),a
2810                     ; 483 k = FirstReg;
2812  059e 7b02          	ld	a,(OFST-38,sp)
2813  05a0 6b0a          	ld	(OFST-30,sp),a
2814                     ; 485 Output_Registers[1] = 65535;
2816  05a2 aeffff        	ldw	x,#65535
2817  05a5 bf02          	ldw	_Output_Registers+2,x
2818                     ; 486 Output_Registers[2] = 65535;
2820  05a7 bf04          	ldw	_Output_Registers+4,x
2821                     ; 489 for(ct=0;ct<NumberOfRegs;ct++)
2823  05a9 0f09          	clr	(OFST-31,sp)
2825  05ab 2053          	jra	L7121
2826  05ad               L3121:
2827                     ; 491 		Content_dec = registers[k];
2829  05ad 7b0a          	ld	a,(OFST-30,sp)
2830  05af 5f            	clrw	x
2831  05b0 97            	ld	xl,a
2832  05b1 58            	sllw	x
2833  05b2 72fb29        	addw	x,(OFST+1,sp)
2834  05b5 fe            	ldw	x,(x)
2835  05b6 1f07          	ldw	(OFST-33,sp),x
2836                     ; 492 		ByteToHex_4(temp,Content_dec);
2838  05b8 89            	pushw	x
2839  05b9 96            	ldw	x,sp
2840  05ba 1c0026        	addw	x,#OFST-2
2841  05bd cd030d        	call	_ByteToHex_4
2843  05c0 85            	popw	x
2844                     ; 493 		OutputFrame[counter] = temp[0];
2846  05c1 96            	ldw	x,sp
2847  05c2 cd0668        	call	LC004
2848  05c5 1b28          	add	a,(OFST+0,sp)
2849  05c7 2401          	jrnc	L262
2850  05c9 5c            	incw	x
2851  05ca               L262:
2852  05ca 02            	rlwa	x,a
2853  05cb 7b24          	ld	a,(OFST-4,sp)
2854  05cd f7            	ld	(x),a
2855                     ; 494 		counter++;
2857                     ; 495 		OutputFrame[counter] = temp[1];
2859  05ce 96            	ldw	x,sp
2860  05cf 0c28          	inc	(OFST+0,sp)
2861  05d1 cd0668        	call	LC004
2862  05d4 1b28          	add	a,(OFST+0,sp)
2863  05d6 2401          	jrnc	L462
2864  05d8 5c            	incw	x
2865  05d9               L462:
2866  05d9 02            	rlwa	x,a
2867  05da 7b25          	ld	a,(OFST-3,sp)
2868  05dc f7            	ld	(x),a
2869                     ; 496 		counter++;
2871                     ; 497 		OutputFrame[counter] = temp[2];
2873  05dd 96            	ldw	x,sp
2874  05de 0c28          	inc	(OFST+0,sp)
2875  05e0 cd0668        	call	LC004
2876  05e3 1b28          	add	a,(OFST+0,sp)
2877  05e5 2401          	jrnc	L662
2878  05e7 5c            	incw	x
2879  05e8               L662:
2880  05e8 02            	rlwa	x,a
2881  05e9 7b26          	ld	a,(OFST-2,sp)
2882  05eb f7            	ld	(x),a
2883                     ; 498 		counter++;
2885                     ; 499 		OutputFrame[counter] = temp[3];
2887  05ec 96            	ldw	x,sp
2888  05ed 0c28          	inc	(OFST+0,sp)
2889  05ef ad77          	call	LC004
2890  05f1 1b28          	add	a,(OFST+0,sp)
2891  05f3 2401          	jrnc	L072
2892  05f5 5c            	incw	x
2893  05f6               L072:
2894  05f6 02            	rlwa	x,a
2895  05f7 7b27          	ld	a,(OFST-1,sp)
2896  05f9 f7            	ld	(x),a
2897                     ; 500 		counter++;
2899  05fa 0c28          	inc	(OFST+0,sp)
2900                     ; 501 		k++;
2902  05fc 0c0a          	inc	(OFST-30,sp)
2903                     ; 489 for(ct=0;ct<NumberOfRegs;ct++)
2905  05fe 0c09          	inc	(OFST-31,sp)
2906  0600               L7121:
2909  0600 7b09          	ld	a,(OFST-31,sp)
2910  0602 5f            	clrw	x
2911  0603 97            	ld	xl,a
2912  0604 1305          	cpw	x,(OFST-35,sp)
2913  0606 25a5          	jrult	L3121
2914                     ; 506 ByteToHex(temp2,GetLRC(OutputFrame));
2916  0608 96            	ldw	x,sp
2917  0609 1c000b        	addw	x,#OFST-29
2918  060c cd027e        	call	_GetLRC
2920  060f 88            	push	a
2921  0610 96            	ldw	x,sp
2922  0611 1c0004        	addw	x,#OFST-36
2923  0614 cd00a7        	call	_ByteToHex
2925  0617 84            	pop	a
2926                     ; 507 OutputFrame[counter] = temp2[0];
2928  0618 96            	ldw	x,sp
2929  0619 ad4d          	call	LC004
2930  061b 1b28          	add	a,(OFST+0,sp)
2931  061d 2401          	jrnc	L672
2932  061f 5c            	incw	x
2933  0620               L672:
2934  0620 02            	rlwa	x,a
2935  0621 7b03          	ld	a,(OFST-37,sp)
2936  0623 f7            	ld	(x),a
2937                     ; 508 counter++;
2939                     ; 509 OutputFrame[counter] = temp2[1];
2941  0624 96            	ldw	x,sp
2942  0625 0c28          	inc	(OFST+0,sp)
2943  0627 ad3f          	call	LC004
2944  0629 1b28          	add	a,(OFST+0,sp)
2945  062b 2401          	jrnc	L003
2946  062d 5c            	incw	x
2947  062e               L003:
2948  062e 02            	rlwa	x,a
2949  062f 7b04          	ld	a,(OFST-36,sp)
2950  0631 f7            	ld	(x),a
2951                     ; 510 counter++;
2953                     ; 511 OutputFrame[counter] = 0x0D;
2955  0632 96            	ldw	x,sp
2956  0633 0c28          	inc	(OFST+0,sp)
2957  0635 ad31          	call	LC004
2958  0637 1b28          	add	a,(OFST+0,sp)
2959  0639 2401          	jrnc	L203
2960  063b 5c            	incw	x
2961  063c               L203:
2962  063c 02            	rlwa	x,a
2963  063d a60d          	ld	a,#13
2964  063f f7            	ld	(x),a
2965                     ; 512 counter++;
2967                     ; 513 OutputFrame[counter] = 0x0A;
2969  0640 96            	ldw	x,sp
2970  0641 0c28          	inc	(OFST+0,sp)
2971  0643 ad23          	call	LC004
2972  0645 1b28          	add	a,(OFST+0,sp)
2973  0647 2401          	jrnc	L403
2974  0649 5c            	incw	x
2975  064a               L403:
2976  064a 02            	rlwa	x,a
2977  064b a60a          	ld	a,#10
2978  064d f7            	ld	(x),a
2979                     ; 514 counter++;
2981                     ; 515 OutputFrame[counter] = 0x0A;
2983  064e 96            	ldw	x,sp
2984  064f 0c28          	inc	(OFST+0,sp)
2985  0651 ad15          	call	LC004
2986  0653 1b28          	add	a,(OFST+0,sp)
2987  0655 2401          	jrnc	L603
2988  0657 5c            	incw	x
2989  0658               L603:
2990  0658 02            	rlwa	x,a
2991  0659 a60a          	ld	a,#10
2992  065b f7            	ld	(x),a
2993                     ; 516 counter++;
2995                     ; 520 UART_SendStr(OutputFrame); 
2997  065c 96            	ldw	x,sp
2998  065d 0c28          	inc	(OFST+0,sp)
2999  065f 1c000b        	addw	x,#OFST-29
3000  0662 cd0000        	call	_UART_SendStr
3002                     ; 522 }
3005  0665 5b2a          	addw	sp,#42
3006  0667 81            	ret	
3007  0668               LC004:
3008  0668 1c000b        	addw	x,#OFST-29
3009  066b 9f            	ld	a,xl
3010  066c 5e            	swapw	x
3011  066d 81            	ret	
3036                     ; 525 void ReadInputRegisters(void)
3036                     ; 526 {
3037                     	switch	.text
3038  066e               _ReadInputRegisters:
3042                     ; 528 ReadHoldingRegisters(Input_Registers);
3044  066e ae0000        	ldw	x,#_Input_Registers
3046                     ; 529 }
3049  0671 cc0525        	jp	_ReadHoldingRegisters
3139                     ; 533 void ForceSingleCoil(void)
3139                     ; 534 {
3140                     	switch	.text
3141  0674               _ForceSingleCoil:
3143  0674 5224          	subw	sp,#36
3144       00000024      OFST:	set	36
3147                     ; 539 uint16_t Coil = 0;
3149  0676 5f            	clrw	x
3150  0677 1f01          	ldw	(OFST-35,sp),x
3151                     ; 540 uint16_t StatusToWrite = 0;
3153  0679 1f03          	ldw	(OFST-33,sp),x
3154                     ; 541 uint8_t k = 0;
3156                     ; 544 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
3158  067b 0f24          	clr	(OFST+0,sp)
3159  067d               L5721:
3162  067d 96            	ldw	x,sp
3163  067e cd0747        	call	LC005
3164  0681 1b24          	add	a,(OFST+0,sp)
3165  0683 2401          	jrnc	L023
3166  0685 5c            	incw	x
3167  0686               L023:
3168  0686 02            	rlwa	x,a
3169  0687 7f            	clr	(x)
3172  0688 0c24          	inc	(OFST+0,sp)
3175  068a 7b24          	ld	a,(OFST+0,sp)
3176  068c a119          	cp	a,#25
3177  068e 25ed          	jrult	L5721
3178                     ; 547 RewritingChars(OutputFrame,0,12);
3180  0690 4b0c          	push	#12
3181  0692 4b00          	push	#0
3182  0694 96            	ldw	x,sp
3183  0695 1c000d        	addw	x,#OFST-23
3184  0698 cd015d        	call	_RewritingChars
3186  069b b605          	ld	a,_word+5
3187  069d 85            	popw	x
3188                     ; 551 temp4[0] = word[5];
3190  069e 6b07          	ld	(OFST-29,sp),a
3191                     ; 552 temp4[1] = word[6];
3193  06a0 b606          	ld	a,_word+6
3194  06a2 6b08          	ld	(OFST-28,sp),a
3195                     ; 553 temp4[2] = word[7];
3197  06a4 b607          	ld	a,_word+7
3198  06a6 6b09          	ld	(OFST-27,sp),a
3199                     ; 554 temp4[3] = word[8];
3201  06a8 b608          	ld	a,_word+8
3202  06aa 6b0a          	ld	(OFST-26,sp),a
3203                     ; 555 HexToByte_4(temp4, &Coil);
3205  06ac 96            	ldw	x,sp
3206  06ad 5c            	incw	x
3207  06ae 89            	pushw	x
3208  06af 1c0006        	addw	x,#6
3209  06b2 cd02af        	call	_HexToByte_4
3211  06b5 b609          	ld	a,_word+9
3212  06b7 85            	popw	x
3213                     ; 558 temp4[0] = word[9];
3215  06b8 6b07          	ld	(OFST-29,sp),a
3216                     ; 559 temp4[1] = word[10];
3218  06ba b60a          	ld	a,_word+10
3219  06bc 6b08          	ld	(OFST-28,sp),a
3220                     ; 560 temp4[2] = word[11];
3222  06be b60b          	ld	a,_word+11
3223  06c0 6b09          	ld	(OFST-27,sp),a
3224                     ; 561 temp4[3] = word[12];
3226  06c2 b60c          	ld	a,_word+12
3227  06c4 6b0a          	ld	(OFST-26,sp),a
3228                     ; 562 HexToByte_4(temp4, &StatusToWrite);
3230  06c6 96            	ldw	x,sp
3231  06c7 1c0003        	addw	x,#OFST-33
3232  06ca 89            	pushw	x
3233  06cb 1c0004        	addw	x,#4
3234  06ce cd02af        	call	_HexToByte_4
3236  06d1 85            	popw	x
3237                     ; 565 SetSingleCoil( &Coil,  &StatusToWrite, Output_Registers);
3239  06d2 ae0000        	ldw	x,#_Output_Registers
3240  06d5 89            	pushw	x
3241  06d6 96            	ldw	x,sp
3242  06d7 1c0005        	addw	x,#OFST-31
3243  06da 89            	pushw	x
3244  06db 1d0002        	subw	x,#2
3245  06de cd017f        	call	_SetSingleCoil
3247  06e1 5b04          	addw	sp,#4
3248                     ; 568 k = 13;
3250  06e3 a60d          	ld	a,#13
3251  06e5 6b24          	ld	(OFST+0,sp),a
3252                     ; 569 ByteToHex(temp2,GetLRC(OutputFrame));
3254  06e7 96            	ldw	x,sp
3255  06e8 1c000b        	addw	x,#OFST-25
3256  06eb cd027e        	call	_GetLRC
3258  06ee 88            	push	a
3259  06ef 96            	ldw	x,sp
3260  06f0 1c0006        	addw	x,#OFST-30
3261  06f3 cd00a7        	call	_ByteToHex
3263  06f6 84            	pop	a
3264                     ; 570 OutputFrame[k] = temp2[0];
3266  06f7 96            	ldw	x,sp
3267  06f8 ad4d          	call	LC005
3268  06fa 1b24          	add	a,(OFST+0,sp)
3269  06fc 2401          	jrnc	L633
3270  06fe 5c            	incw	x
3271  06ff               L633:
3272  06ff 02            	rlwa	x,a
3273  0700 7b05          	ld	a,(OFST-31,sp)
3274  0702 f7            	ld	(x),a
3275                     ; 571 k++;
3277                     ; 572 OutputFrame[k] = temp2[1];
3279  0703 96            	ldw	x,sp
3280  0704 0c24          	inc	(OFST+0,sp)
3281  0706 ad3f          	call	LC005
3282  0708 1b24          	add	a,(OFST+0,sp)
3283  070a 2401          	jrnc	L043
3284  070c 5c            	incw	x
3285  070d               L043:
3286  070d 02            	rlwa	x,a
3287  070e 7b06          	ld	a,(OFST-30,sp)
3288  0710 f7            	ld	(x),a
3289                     ; 573 k++;
3291                     ; 574 OutputFrame[k] = 0x0D;
3293  0711 96            	ldw	x,sp
3294  0712 0c24          	inc	(OFST+0,sp)
3295  0714 ad31          	call	LC005
3296  0716 1b24          	add	a,(OFST+0,sp)
3297  0718 2401          	jrnc	L243
3298  071a 5c            	incw	x
3299  071b               L243:
3300  071b 02            	rlwa	x,a
3301  071c a60d          	ld	a,#13
3302  071e f7            	ld	(x),a
3303                     ; 575 k++;
3305                     ; 576 OutputFrame[k] = 0x0A;
3307  071f 96            	ldw	x,sp
3308  0720 0c24          	inc	(OFST+0,sp)
3309  0722 ad23          	call	LC005
3310  0724 1b24          	add	a,(OFST+0,sp)
3311  0726 2401          	jrnc	L443
3312  0728 5c            	incw	x
3313  0729               L443:
3314  0729 02            	rlwa	x,a
3315  072a a60a          	ld	a,#10
3316  072c f7            	ld	(x),a
3317                     ; 577 k++;
3319                     ; 578 OutputFrame[k] = 0x0A;
3321  072d 96            	ldw	x,sp
3322  072e 0c24          	inc	(OFST+0,sp)
3323  0730 ad15          	call	LC005
3324  0732 1b24          	add	a,(OFST+0,sp)
3325  0734 2401          	jrnc	L643
3326  0736 5c            	incw	x
3327  0737               L643:
3328  0737 02            	rlwa	x,a
3329  0738 a60a          	ld	a,#10
3330  073a f7            	ld	(x),a
3331                     ; 579 k++;
3333                     ; 582 UART_SendStr(OutputFrame); 
3335  073b 96            	ldw	x,sp
3336  073c 0c24          	inc	(OFST+0,sp)
3337  073e 1c000b        	addw	x,#OFST-25
3338  0741 cd0000        	call	_UART_SendStr
3340                     ; 583 }
3343  0744 5b24          	addw	sp,#36
3344  0746 81            	ret	
3345  0747               LC005:
3346  0747 1c000b        	addw	x,#OFST-25
3347  074a 9f            	ld	a,xl
3348  074b 5e            	swapw	x
3349  074c 81            	ret	
3439                     ; 589 void PresetSingleRegister(void)
3439                     ; 590 {
3440                     	switch	.text
3441  074d               _PresetSingleRegister:
3443  074d 5224          	subw	sp,#36
3444       00000024      OFST:	set	36
3447                     ; 595 uint16_t Register = 0;
3449  074f 5f            	clrw	x
3450  0750 1f01          	ldw	(OFST-35,sp),x
3451                     ; 596 uint16_t ValueToWrite = 0;
3453  0752 1f03          	ldw	(OFST-33,sp),x
3454                     ; 597 uint8_t k = 0;
3456                     ; 600 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
3458  0754 0f24          	clr	(OFST+0,sp)
3459  0756               L5431:
3462  0756 96            	ldw	x,sp
3463  0757 cd0816        	call	LC006
3464  075a 1b24          	add	a,(OFST+0,sp)
3465  075c 2401          	jrnc	L453
3466  075e 5c            	incw	x
3467  075f               L453:
3468  075f 02            	rlwa	x,a
3469  0760 7f            	clr	(x)
3472  0761 0c24          	inc	(OFST+0,sp)
3475  0763 7b24          	ld	a,(OFST+0,sp)
3476  0765 a119          	cp	a,#25
3477  0767 25ed          	jrult	L5431
3478                     ; 603 RewritingChars(OutputFrame,0,12);
3480  0769 4b0c          	push	#12
3481  076b 4b00          	push	#0
3482  076d 96            	ldw	x,sp
3483  076e 1c000d        	addw	x,#OFST-23
3484  0771 cd015d        	call	_RewritingChars
3486  0774 b605          	ld	a,_word+5
3487  0776 85            	popw	x
3488                     ; 607 temp4[0] = word[5];
3490  0777 6b07          	ld	(OFST-29,sp),a
3491                     ; 608 temp4[1] = word[6];
3493  0779 b606          	ld	a,_word+6
3494  077b 6b08          	ld	(OFST-28,sp),a
3495                     ; 609 temp4[2] = word[7];
3497  077d b607          	ld	a,_word+7
3498  077f 6b09          	ld	(OFST-27,sp),a
3499                     ; 610 temp4[3] = word[8];
3501  0781 b608          	ld	a,_word+8
3502  0783 6b0a          	ld	(OFST-26,sp),a
3503                     ; 611 HexToByte_4(temp4, &Register);
3505  0785 96            	ldw	x,sp
3506  0786 5c            	incw	x
3507  0787 89            	pushw	x
3508  0788 1c0006        	addw	x,#6
3509  078b cd02af        	call	_HexToByte_4
3511  078e b609          	ld	a,_word+9
3512  0790 85            	popw	x
3513                     ; 614 temp4[0] = word[9];
3515  0791 6b07          	ld	(OFST-29,sp),a
3516                     ; 615 temp4[1] = word[10];
3518  0793 b60a          	ld	a,_word+10
3519  0795 6b08          	ld	(OFST-28,sp),a
3520                     ; 616 temp4[2] = word[11];
3522  0797 b60b          	ld	a,_word+11
3523  0799 6b09          	ld	(OFST-27,sp),a
3524                     ; 617 temp4[3] = word[12];
3526  079b b60c          	ld	a,_word+12
3527  079d 6b0a          	ld	(OFST-26,sp),a
3528                     ; 618 HexToByte_4(temp4, &ValueToWrite);
3530  079f 96            	ldw	x,sp
3531  07a0 1c0003        	addw	x,#OFST-33
3532  07a3 89            	pushw	x
3533  07a4 1c0004        	addw	x,#4
3534  07a7 cd02af        	call	_HexToByte_4
3536  07aa 85            	popw	x
3537                     ; 621 Output_Registers[Register] = ValueToWrite;
3539  07ab 1e01          	ldw	x,(OFST-35,sp)
3540  07ad 58            	sllw	x
3541  07ae 1603          	ldw	y,(OFST-33,sp)
3542  07b0 ef00          	ldw	(_Output_Registers,x),y
3543                     ; 624 k = 13;
3545  07b2 a60d          	ld	a,#13
3546  07b4 6b24          	ld	(OFST+0,sp),a
3547                     ; 625 ByteToHex(temp2,GetLRC(OutputFrame));
3549  07b6 96            	ldw	x,sp
3550  07b7 1c000b        	addw	x,#OFST-25
3551  07ba cd027e        	call	_GetLRC
3553  07bd 88            	push	a
3554  07be 96            	ldw	x,sp
3555  07bf 1c0006        	addw	x,#OFST-30
3556  07c2 cd00a7        	call	_ByteToHex
3558  07c5 84            	pop	a
3559                     ; 626 OutputFrame[k] = temp2[0];
3561  07c6 96            	ldw	x,sp
3562  07c7 ad4d          	call	LC006
3563  07c9 1b24          	add	a,(OFST+0,sp)
3564  07cb 2401          	jrnc	L073
3565  07cd 5c            	incw	x
3566  07ce               L073:
3567  07ce 02            	rlwa	x,a
3568  07cf 7b05          	ld	a,(OFST-31,sp)
3569  07d1 f7            	ld	(x),a
3570                     ; 627 k++;
3572                     ; 628 OutputFrame[k] = temp2[1];
3574  07d2 96            	ldw	x,sp
3575  07d3 0c24          	inc	(OFST+0,sp)
3576  07d5 ad3f          	call	LC006
3577  07d7 1b24          	add	a,(OFST+0,sp)
3578  07d9 2401          	jrnc	L273
3579  07db 5c            	incw	x
3580  07dc               L273:
3581  07dc 02            	rlwa	x,a
3582  07dd 7b06          	ld	a,(OFST-30,sp)
3583  07df f7            	ld	(x),a
3584                     ; 629 k++;
3586                     ; 630 OutputFrame[k] = 0x0D;
3588  07e0 96            	ldw	x,sp
3589  07e1 0c24          	inc	(OFST+0,sp)
3590  07e3 ad31          	call	LC006
3591  07e5 1b24          	add	a,(OFST+0,sp)
3592  07e7 2401          	jrnc	L473
3593  07e9 5c            	incw	x
3594  07ea               L473:
3595  07ea 02            	rlwa	x,a
3596  07eb a60d          	ld	a,#13
3597  07ed f7            	ld	(x),a
3598                     ; 631 k++;
3600                     ; 632 OutputFrame[k] = 0x0A;
3602  07ee 96            	ldw	x,sp
3603  07ef 0c24          	inc	(OFST+0,sp)
3604  07f1 ad23          	call	LC006
3605  07f3 1b24          	add	a,(OFST+0,sp)
3606  07f5 2401          	jrnc	L673
3607  07f7 5c            	incw	x
3608  07f8               L673:
3609  07f8 02            	rlwa	x,a
3610  07f9 a60a          	ld	a,#10
3611  07fb f7            	ld	(x),a
3612                     ; 633 k++;
3614                     ; 634 OutputFrame[k] = 0x0A;
3616  07fc 96            	ldw	x,sp
3617  07fd 0c24          	inc	(OFST+0,sp)
3618  07ff ad15          	call	LC006
3619  0801 1b24          	add	a,(OFST+0,sp)
3620  0803 2401          	jrnc	L004
3621  0805 5c            	incw	x
3622  0806               L004:
3623  0806 02            	rlwa	x,a
3624  0807 a60a          	ld	a,#10
3625  0809 f7            	ld	(x),a
3626                     ; 635 k++;
3628                     ; 638 UART_SendStr(OutputFrame); 
3630  080a 96            	ldw	x,sp
3631  080b 0c24          	inc	(OFST+0,sp)
3632  080d 1c000b        	addw	x,#OFST-25
3633  0810 cd0000        	call	_UART_SendStr
3635                     ; 639 }
3638  0813 5b24          	addw	sp,#36
3639  0815 81            	ret	
3640  0816               LC006:
3641  0816 1c000b        	addw	x,#OFST-25
3642  0819 9f            	ld	a,xl
3643  081a 5e            	swapw	x
3644  081b 81            	ret	
3762                     ; 643 void ForceMultipleRegisters()
3762                     ; 644 {
3763                     	switch	.text
3764  081c               _ForceMultipleRegisters:
3766  081c 5229          	subw	sp,#41
3767       00000029      OFST:	set	41
3770                     ; 646 uint8_t counter = 0;
3772                     ; 647 uint16_t Value=0;
3774  081e 5f            	clrw	x
3775  081f 1f06          	ldw	(OFST-35,sp),x
3776                     ; 654 uint16_t n = 0;
3778                     ; 657 for(n = 0; n<OFS; n++){OutputFrame[n] = '\0';}
3780  0821 1f23          	ldw	(OFST-6,sp),x
3781  0823               L1341:
3784  0823 96            	ldw	x,sp
3785  0824 1c000a        	addw	x,#OFST-31
3786  0827 72fb23        	addw	x,(OFST-6,sp)
3787  082a 7f            	clr	(x)
3790  082b 1e23          	ldw	x,(OFST-6,sp)
3791  082d 5c            	incw	x
3792  082e 1f23          	ldw	(OFST-6,sp),x
3795  0830 a30019        	cpw	x,#25
3796  0833 25ee          	jrult	L1341
3797                     ; 660 RewritingChars(OutputFrame,0,12);
3799  0835 4b0c          	push	#12
3800  0837 4b00          	push	#0
3801  0839 96            	ldw	x,sp
3802  083a 1c000c        	addw	x,#OFST-29
3803  083d cd015d        	call	_RewritingChars
3805  0840 b605          	ld	a,_word+5
3806  0842 85            	popw	x
3807                     ; 663 temp4[0] = word[5];
3809  0843 6b25          	ld	(OFST-4,sp),a
3810                     ; 664 temp4[1] = word[6];
3812  0845 b606          	ld	a,_word+6
3813  0847 6b26          	ld	(OFST-3,sp),a
3814                     ; 665 temp4[2] = word[7];
3816  0849 b607          	ld	a,_word+7
3817  084b 6b27          	ld	(OFST-2,sp),a
3818                     ; 666 temp4[3] = word[8];
3820  084d b608          	ld	a,_word+8
3821  084f 6b28          	ld	(OFST-1,sp),a
3822                     ; 667 HexToByte_4(temp4, &FirstRegister);
3824  0851 96            	ldw	x,sp
3825  0852 1c0003        	addw	x,#OFST-38
3826  0855 89            	pushw	x
3827  0856 1c0022        	addw	x,#34
3828  0859 cd02af        	call	_HexToByte_4
3830  085c b609          	ld	a,_word+9
3831  085e 85            	popw	x
3832                     ; 670 temp4[0] = word[9];
3834  085f 6b25          	ld	(OFST-4,sp),a
3835                     ; 671 temp4[1] = word[10];
3837  0861 b60a          	ld	a,_word+10
3838  0863 6b26          	ld	(OFST-3,sp),a
3839                     ; 672 temp4[2] = word[11];
3841  0865 b60b          	ld	a,_word+11
3842  0867 6b27          	ld	(OFST-2,sp),a
3843                     ; 673 temp4[3] = word[12];
3845  0869 b60c          	ld	a,_word+12
3846  086b 6b28          	ld	(OFST-1,sp),a
3847                     ; 674 HexToByte_4(temp4, &NumberOfRegs);
3849  086d 96            	ldw	x,sp
3850  086e 5c            	incw	x
3851  086f 89            	pushw	x
3852  0870 1c0024        	addw	x,#36
3853  0873 cd02af        	call	_HexToByte_4
3855  0876 b60d          	ld	a,_word+13
3856  0878 85            	popw	x
3857                     ; 677 temp[0] = word[13];
3859  0879 6b08          	ld	(OFST-33,sp),a
3860                     ; 678 temp[1] = word[14];
3862  087b b60e          	ld	a,_word+14
3863  087d 6b09          	ld	(OFST-32,sp),a
3864                     ; 679 HexToByte(temp, &NumberOfDataBytes);
3866  087f 96            	ldw	x,sp
3867  0880 1c0005        	addw	x,#OFST-36
3868  0883 89            	pushw	x
3869  0884 1c0003        	addw	x,#3
3870  0887 cd00df        	call	_HexToByte
3872  088a a60f          	ld	a,#15
3873  088c 85            	popw	x
3874                     ; 681 counter=15;
3876  088d 6b29          	ld	(OFST+0,sp),a
3877                     ; 683 for(n=0; n<(NumberOfDataBytes/2); n++)
3879  088f 5f            	clrw	x
3881  0890 2041          	jra	L3441
3882  0892               L7341:
3883                     ; 685 		temp4[0] = word[counter];
3885  0892 7b29          	ld	a,(OFST+0,sp)
3886  0894 5f            	clrw	x
3887  0895 97            	ld	xl,a
3888  0896 e600          	ld	a,(_word,x)
3889  0898 6b25          	ld	(OFST-4,sp),a
3890                     ; 686 		counter++;
3892  089a 0c29          	inc	(OFST+0,sp)
3893                     ; 687 		temp4[1] = word[counter];
3895  089c 5f            	clrw	x
3896  089d 7b29          	ld	a,(OFST+0,sp)
3897  089f 97            	ld	xl,a
3898  08a0 e600          	ld	a,(_word,x)
3899  08a2 6b26          	ld	(OFST-3,sp),a
3900                     ; 688 		counter++;
3902  08a4 0c29          	inc	(OFST+0,sp)
3903                     ; 689 		temp4[2] = word[counter];
3905  08a6 5f            	clrw	x
3906  08a7 7b29          	ld	a,(OFST+0,sp)
3907  08a9 97            	ld	xl,a
3908  08aa e600          	ld	a,(_word,x)
3909  08ac 6b27          	ld	(OFST-2,sp),a
3910                     ; 690 		counter++;
3912  08ae 0c29          	inc	(OFST+0,sp)
3913                     ; 691 		temp4[3] = word[counter];		
3915  08b0 5f            	clrw	x
3916  08b1 7b29          	ld	a,(OFST+0,sp)
3917  08b3 97            	ld	xl,a
3918  08b4 e600          	ld	a,(_word,x)
3919  08b6 6b28          	ld	(OFST-1,sp),a
3920                     ; 692 		counter++;
3922                     ; 694 		HexToByte_4(temp4, &Value);
3924  08b8 96            	ldw	x,sp
3925  08b9 0c29          	inc	(OFST+0,sp)
3926  08bb 1c0006        	addw	x,#OFST-35
3927  08be 89            	pushw	x
3928  08bf 1c001f        	addw	x,#31
3929  08c2 cd02af        	call	_HexToByte_4
3931  08c5 85            	popw	x
3932                     ; 695 		Output_Registers[FirstRegister+n] = Value;
3934  08c6 1e03          	ldw	x,(OFST-38,sp)
3935  08c8 72fb23        	addw	x,(OFST-6,sp)
3936  08cb 58            	sllw	x
3937  08cc 1606          	ldw	y,(OFST-35,sp)
3938  08ce ef00          	ldw	(_Output_Registers,x),y
3939                     ; 683 for(n=0; n<(NumberOfDataBytes/2); n++)
3941  08d0 1e23          	ldw	x,(OFST-6,sp)
3942  08d2 5c            	incw	x
3943  08d3               L3441:
3944  08d3 1f23          	ldw	(OFST-6,sp),x
3947  08d5 5f            	clrw	x
3948  08d6 7b05          	ld	a,(OFST-36,sp)
3949  08d8 97            	ld	xl,a
3950  08d9 57            	sraw	x
3951  08da 1323          	cpw	x,(OFST-6,sp)
3952  08dc 22b4          	jrugt	L7341
3953                     ; 699 counter = 13;
3955  08de a60d          	ld	a,#13
3956  08e0 6b29          	ld	(OFST+0,sp),a
3957                     ; 700 ByteToHex(temp,GetLRC(OutputFrame));
3959  08e2 96            	ldw	x,sp
3960  08e3 1c000a        	addw	x,#OFST-31
3961  08e6 cd027e        	call	_GetLRC
3963  08e9 88            	push	a
3964  08ea 96            	ldw	x,sp
3965  08eb 1c0009        	addw	x,#OFST-32
3966  08ee cd00a7        	call	_ByteToHex
3968  08f1 84            	pop	a
3969                     ; 701 OutputFrame[counter] = temp[0];
3971  08f2 96            	ldw	x,sp
3972  08f3 ad4d          	call	LC007
3973  08f5 1b29          	add	a,(OFST+0,sp)
3974  08f7 2401          	jrnc	L424
3975  08f9 5c            	incw	x
3976  08fa               L424:
3977  08fa 02            	rlwa	x,a
3978  08fb 7b08          	ld	a,(OFST-33,sp)
3979  08fd f7            	ld	(x),a
3980                     ; 702 counter++;
3982                     ; 703 OutputFrame[counter] = temp[1];
3984  08fe 96            	ldw	x,sp
3985  08ff 0c29          	inc	(OFST+0,sp)
3986  0901 ad3f          	call	LC007
3987  0903 1b29          	add	a,(OFST+0,sp)
3988  0905 2401          	jrnc	L624
3989  0907 5c            	incw	x
3990  0908               L624:
3991  0908 02            	rlwa	x,a
3992  0909 7b09          	ld	a,(OFST-32,sp)
3993  090b f7            	ld	(x),a
3994                     ; 704 counter++;
3996                     ; 705 OutputFrame[counter] = 0x0D;
3998  090c 96            	ldw	x,sp
3999  090d 0c29          	inc	(OFST+0,sp)
4000  090f ad31          	call	LC007
4001  0911 1b29          	add	a,(OFST+0,sp)
4002  0913 2401          	jrnc	L034
4003  0915 5c            	incw	x
4004  0916               L034:
4005  0916 02            	rlwa	x,a
4006  0917 a60d          	ld	a,#13
4007  0919 f7            	ld	(x),a
4008                     ; 706 counter++;
4010                     ; 707 OutputFrame[counter] = 0x0A;
4012  091a 96            	ldw	x,sp
4013  091b 0c29          	inc	(OFST+0,sp)
4014  091d ad23          	call	LC007
4015  091f 1b29          	add	a,(OFST+0,sp)
4016  0921 2401          	jrnc	L234
4017  0923 5c            	incw	x
4018  0924               L234:
4019  0924 02            	rlwa	x,a
4020  0925 a60a          	ld	a,#10
4021  0927 f7            	ld	(x),a
4022                     ; 708 counter++;
4024                     ; 709 OutputFrame[counter] = 0x0A;
4026  0928 96            	ldw	x,sp
4027  0929 0c29          	inc	(OFST+0,sp)
4028  092b ad15          	call	LC007
4029  092d 1b29          	add	a,(OFST+0,sp)
4030  092f 2401          	jrnc	L434
4031  0931 5c            	incw	x
4032  0932               L434:
4033  0932 02            	rlwa	x,a
4034  0933 a60a          	ld	a,#10
4035  0935 f7            	ld	(x),a
4036                     ; 710 counter++;
4038                     ; 713 UART_SendStr(OutputFrame); 
4040  0936 96            	ldw	x,sp
4041  0937 0c29          	inc	(OFST+0,sp)
4042  0939 1c000a        	addw	x,#OFST-31
4043  093c cd0000        	call	_UART_SendStr
4045                     ; 715 }
4048  093f 5b29          	addw	sp,#41
4049  0941 81            	ret	
4050  0942               LC007:
4051  0942 1c000a        	addw	x,#OFST-31
4052  0945 9f            	ld	a,xl
4053  0946 5e            	swapw	x
4054  0947 81            	ret	
4067                     	xref.b	_Output_Registers
4068                     	xref.b	_Input_Registers
4069                     	xref.b	_word
4070                     	xref.b	_Address
4071                     	xref.b	_TimmingDelay
4072                     	xdef	_SetSingleCoil
4073                     	xdef	_StateOfCoil
4074                     	xdef	_RewritingChars
4075                     	xdef	_ForceMultipleRegisters
4076                     	xdef	_PresetSingleRegister
4077                     	xdef	_ForceSingleCoil
4078                     	xdef	_ReadInputRegisters
4079                     	xdef	_ReadHoldingRegisters
4080                     	xdef	_ReadInputStatus
4081                     	xdef	_ReadCoilStatus
4082                     	xdef	___checkFunc
4083                     	xdef	___checkAddr
4084                     	xdef	_ByteToHex_4
4085                     	xdef	_GetLRC
4086                     	xdef	_CheckLRC
4087                     	xdef	_SetDevAddr
4088                     	xdef	_HexToByte_4
4089                     	xdef	_HexToByte
4090                     	xdef	_ByteToHex
4091                     	xdef	_UART_SendStr
4092                     	xdef	_Modbus_Init
4093                     	xdef	_Delay
4094                     	xdef	_Delay_Init
4095                     	xref	_UART2_SendData8
4096                     	xref	_UART2_ITConfig
4097                     	xref	_UART2_Cmd
4098                     	xref	_UART2_Init
4099                     	xref	_UART2_DeInit
4100                     	xref	_TIM3_ITConfig
4101                     	xref	_TIM3_Cmd
4102                     	xref	_TIM3_TimeBaseInit
4103                     	xref	_TIM3_DeInit
4104                     	xref	_TIM2_ITConfig
4105                     	xref	_TIM2_Cmd
4106                     	xref	_TIM2_TimeBaseInit
4107                     	xref	_TIM2_DeInit
4108                     	xref	_GPIO_WriteLow
4109                     	xref	_GPIO_WriteHigh
4110                     	xref	_GPIO_Init
4111                     	xref	_GPIO_DeInit
4112                     	xref	_CLK_HSIPrescalerConfig
4131                     	xref	c_lzmp
4132                     	end
