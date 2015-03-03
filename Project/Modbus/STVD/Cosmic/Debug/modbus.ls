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
1383                     ; 212 void ReadCoilStatus(uint16_t *registers)
1383                     ; 213 {
1384                     	switch	.text
1385  0221               _ReadCoilStatus:
1387  0221 89            	pushw	x
1388  0222 522c          	subw	sp,#44
1389       0000002c      OFST:	set	44
1392                     ; 216 uint8_t counter = 0;
1394                     ; 218 uint8_t TempSum=0;
1396  0224 0f0e          	clr	(OFST-30,sp)
1397                     ; 225 uint16_t n = 0;
1399                     ; 229 for(n = 0; n<OFS; n++){OutputFrame[n] = '\0';}
1401  0226 5f            	clrw	x
1402  0227 1f2a          	ldw	(OFST-2,sp),x
1403  0229               L106:
1406  0229 96            	ldw	x,sp
1407  022a 1c0011        	addw	x,#OFST-27
1408  022d 72fb2a        	addw	x,(OFST-2,sp)
1409  0230 7f            	clr	(x)
1412  0231 1e2a          	ldw	x,(OFST-2,sp)
1413  0233 5c            	incw	x
1414  0234 1f2a          	ldw	(OFST-2,sp),x
1417  0236 a30019        	cpw	x,#25
1418  0239 25ee          	jrult	L106
1419                     ; 231 Input_Registers[0] = 0b0000000011111111;
1421  023b ae00ff        	ldw	x,#255
1422  023e bf00          	ldw	_Input_Registers,x
1423                     ; 236 RewritingChars(OutputFrame,0,4);
1425  0240 4b04          	push	#4
1426  0242 4b00          	push	#0
1427  0244 96            	ldw	x,sp
1428  0245 1c0013        	addw	x,#OFST-25
1429  0248 cd015d        	call	_RewritingChars
1431  024b b605          	ld	a,_word+5
1432  024d 85            	popw	x
1433                     ; 239 temp4[0] = word[5];
1435  024e 6b08          	ld	(OFST-36,sp),a
1436                     ; 240 temp4[1] = word[6];
1438  0250 b606          	ld	a,_word+6
1439  0252 6b09          	ld	(OFST-35,sp),a
1440                     ; 241 temp4[2] = word[7];
1442  0254 b607          	ld	a,_word+7
1443  0256 6b0a          	ld	(OFST-34,sp),a
1444                     ; 242 temp4[3] = word[8];
1446  0258 b608          	ld	a,_word+8
1447  025a 6b0b          	ld	(OFST-33,sp),a
1448                     ; 243 HexToByte_4(temp4, &FirstCoil);
1450  025c 96            	ldw	x,sp
1451  025d 1c0003        	addw	x,#OFST-41
1452  0260 89            	pushw	x
1453  0261 1c0005        	addw	x,#5
1454  0264 cd0762        	call	_HexToByte_4
1456  0267 b609          	ld	a,_word+9
1457  0269 85            	popw	x
1458                     ; 246 temp4[0] = word[9];
1460  026a 6b08          	ld	(OFST-36,sp),a
1461                     ; 247 temp4[1] = word[10];
1463  026c b60a          	ld	a,_word+10
1464  026e 6b09          	ld	(OFST-35,sp),a
1465                     ; 248 temp4[2] = word[11];
1467  0270 b60b          	ld	a,_word+11
1468  0272 6b0a          	ld	(OFST-34,sp),a
1469                     ; 249 temp4[3] = word[12];
1471  0274 b60c          	ld	a,_word+12
1472  0276 6b0b          	ld	(OFST-33,sp),a
1473                     ; 250 HexToByte_4(temp4, &NumberOfCoils);
1475  0278 96            	ldw	x,sp
1476  0279 1c0005        	addw	x,#OFST-39
1477  027c 89            	pushw	x
1478  027d 1c0003        	addw	x,#3
1479  0280 cd0762        	call	_HexToByte_4
1481  0283 85            	popw	x
1482                     ; 253 if((NumberOfCoils%8)!=0)
1484  0284 7b06          	ld	a,(OFST-38,sp)
1485  0286 a507          	bcp	a,#7
1486  0288 2709          	jreq	L706
1487                     ; 255 	NumberOfDataBytes = ( NumberOfCoils/8)+1;
1489  028a 1e05          	ldw	x,(OFST-39,sp)
1490  028c 54            	srlw	x
1491  028d 54            	srlw	x
1492  028e 54            	srlw	x
1493  028f 01            	rrwa	x,a
1494  0290 4c            	inc	a
1496  0291 2006          	jra	L116
1497  0293               L706:
1498                     ; 259 	NumberOfDataBytes = NumberOfCoils/8;
1500  0293 1e05          	ldw	x,(OFST-39,sp)
1501  0295 54            	srlw	x
1502  0296 54            	srlw	x
1503  0297 54            	srlw	x
1504  0298 01            	rrwa	x,a
1505  0299               L116:
1506  0299 6b07          	ld	(OFST-37,sp),a
1507                     ; 263 ByteToHex(temp,NumberOfDataBytes);
1509  029b 88            	push	a
1510  029c 96            	ldw	x,sp
1511  029d 1c0010        	addw	x,#OFST-28
1512  02a0 cd00a7        	call	_ByteToHex
1514  02a3 84            	pop	a
1515                     ; 264 OutputFrame[5] = temp[0];
1517  02a4 7b0f          	ld	a,(OFST-29,sp)
1518  02a6 6b16          	ld	(OFST-22,sp),a
1519                     ; 265 OutputFrame[6] = temp[1];
1521  02a8 7b10          	ld	a,(OFST-28,sp)
1522  02aa 6b17          	ld	(OFST-21,sp),a
1523                     ; 268 counter = 7; 
1525  02ac a607          	ld	a,#7
1526  02ae 6b2c          	ld	(OFST+0,sp),a
1527                     ; 269 Coil = FirstCoil;
1529  02b0 1e03          	ldw	x,(OFST-41,sp)
1530  02b2 1f0c          	ldw	(OFST-32,sp),x
1531                     ; 270 n = NumberOfCoils;
1533  02b4 1e05          	ldw	x,(OFST-39,sp)
1534  02b6 1f2a          	ldw	(OFST-2,sp),x
1536  02b8 cc0380        	jra	L716
1537  02bb               L316:
1538                     ; 273 		if(n>=8)                   //    changing 8bits to hex
1540  02bb a30008        	cpw	x,#8
1541  02be 255b          	jrult	L326
1542                     ; 275 						uint8_t pwr = 0;
1544                     ; 276 						for(pwr =0; pwr<8; pwr++,Coil++)
1546  02c0 0f02          	clr	(OFST-42,sp)
1547  02c2               L526:
1548                     ; 278 								TempSum += (1<<pwr)*StateOfCoil(Coil, registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
1550  02c2 1e2d          	ldw	x,(OFST+1,sp)
1551  02c4 89            	pushw	x
1552  02c5 7b0f          	ld	a,(OFST-29,sp)
1553  02c7 cd01ef        	call	_StateOfCoil
1555  02ca 85            	popw	x
1556  02cb 6b01          	ld	(OFST-43,sp),a
1557  02cd 5f            	clrw	x
1558  02ce 7b02          	ld	a,(OFST-42,sp)
1559  02d0 97            	ld	xl,a
1560  02d1 a601          	ld	a,#1
1561  02d3 5d            	tnzw	x
1562  02d4 2704          	jreq	L241
1563  02d6               L441:
1564  02d6 48            	sll	a
1565  02d7 5a            	decw	x
1566  02d8 26fc          	jrne	L441
1567  02da               L241:
1568  02da 97            	ld	xl,a
1569  02db 7b01          	ld	a,(OFST-43,sp)
1570  02dd 42            	mul	x,a
1571  02de 9f            	ld	a,xl
1572  02df 1b0e          	add	a,(OFST-30,sp)
1573  02e1 6b0e          	ld	(OFST-30,sp),a
1574                     ; 279 								n--;
1576  02e3 1e2a          	ldw	x,(OFST-2,sp)
1577  02e5 5a            	decw	x
1578  02e6 1f2a          	ldw	(OFST-2,sp),x
1579                     ; 276 						for(pwr =0; pwr<8; pwr++,Coil++)
1581  02e8 0c02          	inc	(OFST-42,sp)
1582  02ea 1e0c          	ldw	x,(OFST-32,sp)
1583  02ec 5c            	incw	x
1584  02ed 1f0c          	ldw	(OFST-32,sp),x
1587  02ef 7b02          	ld	a,(OFST-42,sp)
1588  02f1 a108          	cp	a,#8
1589  02f3 25cd          	jrult	L526
1590                     ; 282 						ByteToHex(temp,TempSum);
1592  02f5 7b0e          	ld	a,(OFST-30,sp)
1593  02f7 88            	push	a
1594  02f8 96            	ldw	x,sp
1595  02f9 1c0010        	addw	x,#OFST-28
1596  02fc cd00a7        	call	_ByteToHex
1598  02ff 84            	pop	a
1599                     ; 283 						TempSum = 0;
1601  0300 0f0e          	clr	(OFST-30,sp)
1602                     ; 284 						OutputFrame[counter] = temp[0];
1604  0302 96            	ldw	x,sp
1605  0303 cd03e7        	call	LC003
1606  0306 1b2c          	add	a,(OFST+0,sp)
1607  0308 2401          	jrnc	L051
1608  030a 5c            	incw	x
1609  030b               L051:
1610  030b 02            	rlwa	x,a
1611  030c 7b0f          	ld	a,(OFST-29,sp)
1612  030e f7            	ld	(x),a
1613                     ; 285 						counter++;
1615                     ; 286 						OutputFrame[counter] = temp[1];
1617  030f 96            	ldw	x,sp
1618  0310 0c2c          	inc	(OFST+0,sp)
1619  0312 cd03e7        	call	LC003
1620  0315 1b2c          	add	a,(OFST+0,sp)
1621  0317 2461          	jrnc	L661
1622                     ; 287 						counter++;
1624  0319 205e          	jp	LC002
1625  031b               L326:
1626                     ; 292 						uint8_t pwr = 0;
1628                     ; 293 						uint8_t zm = n;
1630  031b 7b2b          	ld	a,(OFST-1,sp)
1631  031d 6b07          	ld	(OFST-37,sp),a
1632                     ; 294 						for(pwr =0; pwr<zm; pwr++,Coil++)
1634  031f 0f02          	clr	(OFST-42,sp)
1636  0321 202d          	jra	L146
1637  0323               L536:
1638                     ; 296 								TempSum += (1<<pwr)*StateOfCoil(Coil, registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
1640  0323 1e2d          	ldw	x,(OFST+1,sp)
1641  0325 89            	pushw	x
1642  0326 7b0f          	ld	a,(OFST-29,sp)
1643  0328 cd01ef        	call	_StateOfCoil
1645  032b 85            	popw	x
1646  032c 6b01          	ld	(OFST-43,sp),a
1647  032e 5f            	clrw	x
1648  032f 7b02          	ld	a,(OFST-42,sp)
1649  0331 97            	ld	xl,a
1650  0332 a601          	ld	a,#1
1651  0334 5d            	tnzw	x
1652  0335 2704          	jreq	L651
1653  0337               L061:
1654  0337 48            	sll	a
1655  0338 5a            	decw	x
1656  0339 26fc          	jrne	L061
1657  033b               L651:
1658  033b 97            	ld	xl,a
1659  033c 7b01          	ld	a,(OFST-43,sp)
1660  033e 42            	mul	x,a
1661  033f 9f            	ld	a,xl
1662  0340 1b0e          	add	a,(OFST-30,sp)
1663  0342 6b0e          	ld	(OFST-30,sp),a
1664                     ; 297 								n--;
1666  0344 1e2a          	ldw	x,(OFST-2,sp)
1667  0346 5a            	decw	x
1668  0347 1f2a          	ldw	(OFST-2,sp),x
1669                     ; 294 						for(pwr =0; pwr<zm; pwr++,Coil++)
1671  0349 0c02          	inc	(OFST-42,sp)
1672  034b 1e0c          	ldw	x,(OFST-32,sp)
1673  034d 5c            	incw	x
1674  034e 1f0c          	ldw	(OFST-32,sp),x
1675  0350               L146:
1678  0350 7b02          	ld	a,(OFST-42,sp)
1679  0352 1107          	cp	a,(OFST-37,sp)
1680  0354 25cd          	jrult	L536
1681                     ; 299 						ByteToHex(temp,TempSum);
1683  0356 7b0e          	ld	a,(OFST-30,sp)
1684  0358 88            	push	a
1685  0359 96            	ldw	x,sp
1686  035a 1c0010        	addw	x,#OFST-28
1687  035d cd00a7        	call	_ByteToHex
1689  0360 84            	pop	a
1690                     ; 300 						TempSum = 0;
1692  0361 0f0e          	clr	(OFST-30,sp)
1693                     ; 301 						OutputFrame[counter] = temp[0];
1695  0363 96            	ldw	x,sp
1696  0364 cd03e7        	call	LC003
1697  0367 1b2c          	add	a,(OFST+0,sp)
1698  0369 2401          	jrnc	L461
1699  036b 5c            	incw	x
1700  036c               L461:
1701  036c 02            	rlwa	x,a
1702  036d 7b0f          	ld	a,(OFST-29,sp)
1703  036f f7            	ld	(x),a
1704                     ; 302 						counter++;
1706                     ; 303 						OutputFrame[counter] = temp[1];
1708  0370 96            	ldw	x,sp
1709  0371 0c2c          	inc	(OFST+0,sp)
1710  0373 ad72          	call	LC003
1711  0375 1b2c          	add	a,(OFST+0,sp)
1712  0377 2401          	jrnc	L661
1713  0379               LC002:
1714  0379 5c            	incw	x
1715  037a               L661:
1716                     ; 304 						counter++;
1718  037a 02            	rlwa	x,a
1719  037b 7b10          	ld	a,(OFST-28,sp)
1720  037d f7            	ld	(x),a
1722  037e 0c2c          	inc	(OFST+0,sp)
1723  0380               L716:
1724                     ; 271 while(n>0)
1726  0380 1e2a          	ldw	x,(OFST-2,sp)
1727  0382 2703cc02bb    	jrne	L316
1728                     ; 309 ByteToHex(temp,GetLRC(OutputFrame));
1730  0387 96            	ldw	x,sp
1731  0388 1c0011        	addw	x,#OFST-27
1732  038b cd0731        	call	_GetLRC
1734  038e 88            	push	a
1735  038f 96            	ldw	x,sp
1736  0390 1c0010        	addw	x,#OFST-28
1737  0393 cd00a7        	call	_ByteToHex
1739  0396 84            	pop	a
1740                     ; 310 OutputFrame[counter] = temp[0];
1742  0397 96            	ldw	x,sp
1743  0398 ad4d          	call	LC003
1744  039a 1b2c          	add	a,(OFST+0,sp)
1745  039c 2401          	jrnc	L471
1746  039e 5c            	incw	x
1747  039f               L471:
1748  039f 02            	rlwa	x,a
1749  03a0 7b0f          	ld	a,(OFST-29,sp)
1750  03a2 f7            	ld	(x),a
1751                     ; 311 counter++;
1753                     ; 312 OutputFrame[counter] = temp[1];
1755  03a3 96            	ldw	x,sp
1756  03a4 0c2c          	inc	(OFST+0,sp)
1757  03a6 ad3f          	call	LC003
1758  03a8 1b2c          	add	a,(OFST+0,sp)
1759  03aa 2401          	jrnc	L671
1760  03ac 5c            	incw	x
1761  03ad               L671:
1762  03ad 02            	rlwa	x,a
1763  03ae 7b10          	ld	a,(OFST-28,sp)
1764  03b0 f7            	ld	(x),a
1765                     ; 313 counter++;
1767                     ; 314 OutputFrame[counter] = 0x0D;
1769  03b1 96            	ldw	x,sp
1770  03b2 0c2c          	inc	(OFST+0,sp)
1771  03b4 ad31          	call	LC003
1772  03b6 1b2c          	add	a,(OFST+0,sp)
1773  03b8 2401          	jrnc	L002
1774  03ba 5c            	incw	x
1775  03bb               L002:
1776  03bb 02            	rlwa	x,a
1777  03bc a60d          	ld	a,#13
1778  03be f7            	ld	(x),a
1779                     ; 315 counter++;
1781                     ; 316 OutputFrame[counter] = 0x0A;
1783  03bf 96            	ldw	x,sp
1784  03c0 0c2c          	inc	(OFST+0,sp)
1785  03c2 ad23          	call	LC003
1786  03c4 1b2c          	add	a,(OFST+0,sp)
1787  03c6 2401          	jrnc	L202
1788  03c8 5c            	incw	x
1789  03c9               L202:
1790  03c9 02            	rlwa	x,a
1791  03ca a60a          	ld	a,#10
1792  03cc f7            	ld	(x),a
1793                     ; 317 counter++;
1795                     ; 318 OutputFrame[counter] = 0x0A;
1797  03cd 96            	ldw	x,sp
1798  03ce 0c2c          	inc	(OFST+0,sp)
1799  03d0 ad15          	call	LC003
1800  03d2 1b2c          	add	a,(OFST+0,sp)
1801  03d4 2401          	jrnc	L402
1802  03d6 5c            	incw	x
1803  03d7               L402:
1804  03d7 02            	rlwa	x,a
1805  03d8 a60a          	ld	a,#10
1806  03da f7            	ld	(x),a
1807                     ; 319 counter++;
1809                     ; 322 	UART_SendStr(OutputFrame); 
1811  03db 96            	ldw	x,sp
1812  03dc 0c2c          	inc	(OFST+0,sp)
1813  03de 1c0011        	addw	x,#OFST-27
1814  03e1 cd0000        	call	_UART_SendStr
1816                     ; 323 }
1819  03e4 5b2e          	addw	sp,#46
1820  03e6 81            	ret	
1821  03e7               LC003:
1822  03e7 1c0011        	addw	x,#OFST-27
1823  03ea 9f            	ld	a,xl
1824  03eb 5e            	swapw	x
1825  03ec 81            	ret	
1850                     ; 327 void ReadInputStatus(void)
1850                     ; 328 {
1851                     	switch	.text
1852  03ed               _ReadInputStatus:
1856                     ; 329 ReadCoilStatus(Input_Registers);
1858  03ed ae0000        	ldw	x,#_Input_Registers
1860                     ; 330 }
1863  03f0 cc0221        	jp	_ReadCoilStatus
2000                     ; 334 void ReadHoldingRegisters(uint16_t *registers)
2000                     ; 335 {
2001                     	switch	.text
2002  03f3               _ReadHoldingRegisters:
2004  03f3 89            	pushw	x
2005  03f4 5228          	subw	sp,#40
2006       00000028      OFST:	set	40
2009                     ; 340 uint16_t FirstReg = 0;
2011  03f6 5f            	clrw	x
2012  03f7 1f01          	ldw	(OFST-39,sp),x
2013                     ; 341 uint16_t NumberOfRegs = 0;
2015  03f9 1f05          	ldw	(OFST-35,sp),x
2016                     ; 342 uint8_t NumberOfBytes = 0 ;
2018                     ; 343 uint8_t ct = 0;
2020                     ; 344 uint8_t k = 0;
2022                     ; 345 uint8_t counter = 0;
2024                     ; 346 uint16_t Content_dec = 0;
2026                     ; 350 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
2028  03fb 0f0a          	clr	(OFST-30,sp)
2029  03fd               L347:
2032  03fd 96            	ldw	x,sp
2033  03fe cd0536        	call	LC004
2034  0401 1b0a          	add	a,(OFST-30,sp)
2035  0403 2401          	jrnc	L612
2036  0405 5c            	incw	x
2037  0406               L612:
2038  0406 02            	rlwa	x,a
2039  0407 7f            	clr	(x)
2042  0408 0c0a          	inc	(OFST-30,sp)
2045  040a 7b0a          	ld	a,(OFST-30,sp)
2046  040c a119          	cp	a,#25
2047  040e 25ed          	jrult	L347
2048                     ; 353 RewritingChars(OutputFrame,0,4);
2050  0410 4b04          	push	#4
2051  0412 4b00          	push	#0
2052  0414 96            	ldw	x,sp
2053  0415 1c000d        	addw	x,#OFST-27
2054  0418 cd015d        	call	_RewritingChars
2056  041b b605          	ld	a,_word+5
2057  041d 85            	popw	x
2058                     ; 356 temp[0] = word[5];
2060  041e 6b24          	ld	(OFST-4,sp),a
2061                     ; 357 temp[1] = word[6];
2063  0420 b606          	ld	a,_word+6
2064  0422 6b25          	ld	(OFST-3,sp),a
2065                     ; 358 temp[2] = word[7];
2067  0424 b607          	ld	a,_word+7
2068  0426 6b26          	ld	(OFST-2,sp),a
2069                     ; 359 temp[3] = word[8];
2071  0428 b608          	ld	a,_word+8
2072  042a 6b27          	ld	(OFST-1,sp),a
2073                     ; 360 HexToByte_4(temp, &FirstReg);
2075  042c 96            	ldw	x,sp
2076  042d 5c            	incw	x
2077  042e 89            	pushw	x
2078  042f 1c0023        	addw	x,#35
2079  0432 cd0762        	call	_HexToByte_4
2081  0435 b609          	ld	a,_word+9
2082  0437 85            	popw	x
2083                     ; 363 temp[0] = word[9];
2085  0438 6b24          	ld	(OFST-4,sp),a
2086                     ; 364 temp[1] = word[10];
2088  043a b60a          	ld	a,_word+10
2089  043c 6b25          	ld	(OFST-3,sp),a
2090                     ; 365 temp[2] = word[11];
2092  043e b60b          	ld	a,_word+11
2093  0440 6b26          	ld	(OFST-2,sp),a
2094                     ; 366 temp[3] = word[12];
2096  0442 b60c          	ld	a,_word+12
2097  0444 6b27          	ld	(OFST-1,sp),a
2098                     ; 367 HexToByte_4(temp, &NumberOfRegs);
2100  0446 96            	ldw	x,sp
2101  0447 1c0005        	addw	x,#OFST-35
2102  044a 89            	pushw	x
2103  044b 1c001f        	addw	x,#31
2104  044e cd0762        	call	_HexToByte_4
2106  0451 85            	popw	x
2107                     ; 370 NumberOfBytes = NumberOfRegs*2;
2109  0452 7b06          	ld	a,(OFST-34,sp)
2110  0454 48            	sll	a
2111  0455 6b09          	ld	(OFST-31,sp),a
2112                     ; 373 ByteToHex(temp,NumberOfBytes);
2114  0457 88            	push	a
2115  0458 96            	ldw	x,sp
2116  0459 1c0025        	addw	x,#OFST-3
2117  045c cd00a7        	call	_ByteToHex
2119  045f 84            	pop	a
2120                     ; 374 OutputFrame[5] = temp[0];
2122  0460 7b24          	ld	a,(OFST-4,sp)
2123  0462 6b10          	ld	(OFST-24,sp),a
2124                     ; 375 OutputFrame[6] = temp[1];
2126  0464 7b25          	ld	a,(OFST-3,sp)
2127  0466 6b11          	ld	(OFST-23,sp),a
2128                     ; 377 counter = 7;
2130  0468 a607          	ld	a,#7
2131  046a 6b28          	ld	(OFST+0,sp),a
2132                     ; 378 k = FirstReg;
2134  046c 7b02          	ld	a,(OFST-38,sp)
2135  046e 6b0a          	ld	(OFST-30,sp),a
2136                     ; 380 Output_Registers[1] = 65535;
2138  0470 aeffff        	ldw	x,#65535
2139  0473 bf02          	ldw	_Output_Registers+2,x
2140                     ; 381 Output_Registers[2] = 65535;
2142  0475 bf04          	ldw	_Output_Registers+4,x
2143                     ; 384 for(ct=0;ct<NumberOfRegs;ct++)
2145  0477 0f09          	clr	(OFST-31,sp)
2147  0479 2053          	jra	L557
2148  047b               L157:
2149                     ; 386 		Content_dec = registers[k];
2151  047b 7b0a          	ld	a,(OFST-30,sp)
2152  047d 5f            	clrw	x
2153  047e 97            	ld	xl,a
2154  047f 58            	sllw	x
2155  0480 72fb29        	addw	x,(OFST+1,sp)
2156  0483 fe            	ldw	x,(x)
2157  0484 1f07          	ldw	(OFST-33,sp),x
2158                     ; 387 		ByteToHex_4(temp,Content_dec);
2160  0486 89            	pushw	x
2161  0487 96            	ldw	x,sp
2162  0488 1c0026        	addw	x,#OFST-2
2163  048b cd07c0        	call	_ByteToHex_4
2165  048e 85            	popw	x
2166                     ; 388 		OutputFrame[counter] = temp[0];
2168  048f 96            	ldw	x,sp
2169  0490 cd0536        	call	LC004
2170  0493 1b28          	add	a,(OFST+0,sp)
2171  0495 2401          	jrnc	L232
2172  0497 5c            	incw	x
2173  0498               L232:
2174  0498 02            	rlwa	x,a
2175  0499 7b24          	ld	a,(OFST-4,sp)
2176  049b f7            	ld	(x),a
2177                     ; 389 		counter++;
2179                     ; 390 		OutputFrame[counter] = temp[1];
2181  049c 96            	ldw	x,sp
2182  049d 0c28          	inc	(OFST+0,sp)
2183  049f cd0536        	call	LC004
2184  04a2 1b28          	add	a,(OFST+0,sp)
2185  04a4 2401          	jrnc	L432
2186  04a6 5c            	incw	x
2187  04a7               L432:
2188  04a7 02            	rlwa	x,a
2189  04a8 7b25          	ld	a,(OFST-3,sp)
2190  04aa f7            	ld	(x),a
2191                     ; 391 		counter++;
2193                     ; 392 		OutputFrame[counter] = temp[2];
2195  04ab 96            	ldw	x,sp
2196  04ac 0c28          	inc	(OFST+0,sp)
2197  04ae cd0536        	call	LC004
2198  04b1 1b28          	add	a,(OFST+0,sp)
2199  04b3 2401          	jrnc	L632
2200  04b5 5c            	incw	x
2201  04b6               L632:
2202  04b6 02            	rlwa	x,a
2203  04b7 7b26          	ld	a,(OFST-2,sp)
2204  04b9 f7            	ld	(x),a
2205                     ; 393 		counter++;
2207                     ; 394 		OutputFrame[counter] = temp[3];
2209  04ba 96            	ldw	x,sp
2210  04bb 0c28          	inc	(OFST+0,sp)
2211  04bd ad77          	call	LC004
2212  04bf 1b28          	add	a,(OFST+0,sp)
2213  04c1 2401          	jrnc	L042
2214  04c3 5c            	incw	x
2215  04c4               L042:
2216  04c4 02            	rlwa	x,a
2217  04c5 7b27          	ld	a,(OFST-1,sp)
2218  04c7 f7            	ld	(x),a
2219                     ; 395 		counter++;
2221  04c8 0c28          	inc	(OFST+0,sp)
2222                     ; 396 		k++;
2224  04ca 0c0a          	inc	(OFST-30,sp)
2225                     ; 384 for(ct=0;ct<NumberOfRegs;ct++)
2227  04cc 0c09          	inc	(OFST-31,sp)
2228  04ce               L557:
2231  04ce 7b09          	ld	a,(OFST-31,sp)
2232  04d0 5f            	clrw	x
2233  04d1 97            	ld	xl,a
2234  04d2 1305          	cpw	x,(OFST-35,sp)
2235  04d4 25a5          	jrult	L157
2236                     ; 401 ByteToHex(temp2,GetLRC(OutputFrame));
2238  04d6 96            	ldw	x,sp
2239  04d7 1c000b        	addw	x,#OFST-29
2240  04da cd0731        	call	_GetLRC
2242  04dd 88            	push	a
2243  04de 96            	ldw	x,sp
2244  04df 1c0004        	addw	x,#OFST-36
2245  04e2 cd00a7        	call	_ByteToHex
2247  04e5 84            	pop	a
2248                     ; 402 OutputFrame[counter] = temp2[0];
2250  04e6 96            	ldw	x,sp
2251  04e7 ad4d          	call	LC004
2252  04e9 1b28          	add	a,(OFST+0,sp)
2253  04eb 2401          	jrnc	L642
2254  04ed 5c            	incw	x
2255  04ee               L642:
2256  04ee 02            	rlwa	x,a
2257  04ef 7b03          	ld	a,(OFST-37,sp)
2258  04f1 f7            	ld	(x),a
2259                     ; 403 counter++;
2261                     ; 404 OutputFrame[counter] = temp2[1];
2263  04f2 96            	ldw	x,sp
2264  04f3 0c28          	inc	(OFST+0,sp)
2265  04f5 ad3f          	call	LC004
2266  04f7 1b28          	add	a,(OFST+0,sp)
2267  04f9 2401          	jrnc	L052
2268  04fb 5c            	incw	x
2269  04fc               L052:
2270  04fc 02            	rlwa	x,a
2271  04fd 7b04          	ld	a,(OFST-36,sp)
2272  04ff f7            	ld	(x),a
2273                     ; 405 counter++;
2275                     ; 406 OutputFrame[counter] = 0x0D;
2277  0500 96            	ldw	x,sp
2278  0501 0c28          	inc	(OFST+0,sp)
2279  0503 ad31          	call	LC004
2280  0505 1b28          	add	a,(OFST+0,sp)
2281  0507 2401          	jrnc	L252
2282  0509 5c            	incw	x
2283  050a               L252:
2284  050a 02            	rlwa	x,a
2285  050b a60d          	ld	a,#13
2286  050d f7            	ld	(x),a
2287                     ; 407 counter++;
2289                     ; 408 OutputFrame[counter] = 0x0A;
2291  050e 96            	ldw	x,sp
2292  050f 0c28          	inc	(OFST+0,sp)
2293  0511 ad23          	call	LC004
2294  0513 1b28          	add	a,(OFST+0,sp)
2295  0515 2401          	jrnc	L452
2296  0517 5c            	incw	x
2297  0518               L452:
2298  0518 02            	rlwa	x,a
2299  0519 a60a          	ld	a,#10
2300  051b f7            	ld	(x),a
2301                     ; 409 counter++;
2303                     ; 410 OutputFrame[counter] = 0x0A;
2305  051c 96            	ldw	x,sp
2306  051d 0c28          	inc	(OFST+0,sp)
2307  051f ad15          	call	LC004
2308  0521 1b28          	add	a,(OFST+0,sp)
2309  0523 2401          	jrnc	L652
2310  0525 5c            	incw	x
2311  0526               L652:
2312  0526 02            	rlwa	x,a
2313  0527 a60a          	ld	a,#10
2314  0529 f7            	ld	(x),a
2315                     ; 411 counter++;
2317                     ; 415 UART_SendStr(OutputFrame); 
2319  052a 96            	ldw	x,sp
2320  052b 0c28          	inc	(OFST+0,sp)
2321  052d 1c000b        	addw	x,#OFST-29
2322  0530 cd0000        	call	_UART_SendStr
2324                     ; 417 }
2327  0533 5b2a          	addw	sp,#42
2328  0535 81            	ret	
2329  0536               LC004:
2330  0536 1c000b        	addw	x,#OFST-29
2331  0539 9f            	ld	a,xl
2332  053a 5e            	swapw	x
2333  053b 81            	ret	
2358                     ; 420 void ReadInputRegisters(void)
2358                     ; 421 {
2359                     	switch	.text
2360  053c               _ReadInputRegisters:
2364                     ; 423 ReadHoldingRegisters(Input_Registers);
2366  053c ae0000        	ldw	x,#_Input_Registers
2368                     ; 424 }
2371  053f cc03f3        	jp	_ReadHoldingRegisters
2460                     ; 428 void ForceSingleCoil(void)
2460                     ; 429 {
2461                     	switch	.text
2462  0542               _ForceSingleCoil:
2464  0542 5224          	subw	sp,#36
2465       00000024      OFST:	set	36
2468                     ; 434 uint16_t Coil = 0;
2470  0544 5f            	clrw	x
2471  0545 1f01          	ldw	(OFST-35,sp),x
2472                     ; 435 uint16_t StatusToWrite = 0;
2474  0547 1f03          	ldw	(OFST-33,sp),x
2475                     ; 436 uint8_t k = 0;
2477                     ; 439 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
2479  0549 0f24          	clr	(OFST+0,sp)
2480  054b               L3301:
2483  054b 96            	ldw	x,sp
2484  054c cd060a        	call	LC005
2485  054f 1b24          	add	a,(OFST+0,sp)
2486  0551 2401          	jrnc	L072
2487  0553 5c            	incw	x
2488  0554               L072:
2489  0554 02            	rlwa	x,a
2490  0555 7f            	clr	(x)
2493  0556 0c24          	inc	(OFST+0,sp)
2496  0558 7b24          	ld	a,(OFST+0,sp)
2497  055a a119          	cp	a,#25
2498  055c 25ed          	jrult	L3301
2499                     ; 442 RewritingChars(OutputFrame,0,12);
2501  055e 4b0c          	push	#12
2502  0560 4b00          	push	#0
2503  0562 96            	ldw	x,sp
2504  0563 1c0009        	addw	x,#OFST-27
2505  0566 cd015d        	call	_RewritingChars
2507  0569 b605          	ld	a,_word+5
2508  056b 85            	popw	x
2509                     ; 446 temp4[0] = word[5];
2511  056c 6b20          	ld	(OFST-4,sp),a
2512                     ; 447 temp4[1] = word[6];
2514  056e b606          	ld	a,_word+6
2515  0570 6b21          	ld	(OFST-3,sp),a
2516                     ; 448 temp4[2] = word[7];
2518  0572 b607          	ld	a,_word+7
2519  0574 6b22          	ld	(OFST-2,sp),a
2520                     ; 449 temp4[3] = word[8];
2522  0576 b608          	ld	a,_word+8
2523  0578 6b23          	ld	(OFST-1,sp),a
2524                     ; 450 HexToByte_4(temp4, &Coil);
2526  057a 96            	ldw	x,sp
2527  057b 5c            	incw	x
2528  057c 89            	pushw	x
2529  057d 1c001f        	addw	x,#31
2530  0580 cd0762        	call	_HexToByte_4
2532  0583 b609          	ld	a,_word+9
2533  0585 85            	popw	x
2534                     ; 453 temp4[0] = word[9];
2536  0586 6b20          	ld	(OFST-4,sp),a
2537                     ; 454 temp4[1] = word[10];
2539  0588 b60a          	ld	a,_word+10
2540  058a 6b21          	ld	(OFST-3,sp),a
2541                     ; 455 temp4[2] = word[11];
2543  058c b60b          	ld	a,_word+11
2544  058e 6b22          	ld	(OFST-2,sp),a
2545                     ; 456 temp4[3] = word[12];
2547  0590 b60c          	ld	a,_word+12
2548  0592 6b23          	ld	(OFST-1,sp),a
2549                     ; 457 HexToByte_4(temp4, &StatusToWrite);
2551  0594 96            	ldw	x,sp
2552  0595 1c0003        	addw	x,#OFST-33
2553  0598 89            	pushw	x
2554  0599 1c001d        	addw	x,#29
2555  059c cd0762        	call	_HexToByte_4
2557  059f 85            	popw	x
2558                     ; 460 SetSingleCoil( &Coil,  &StatusToWrite, Output_Registers);
2560  05a0 ae0000        	ldw	x,#_Output_Registers
2561  05a3 89            	pushw	x
2562  05a4 96            	ldw	x,sp
2563  05a5 1c0005        	addw	x,#OFST-31
2564  05a8 89            	pushw	x
2565  05a9 1d0002        	subw	x,#2
2566  05ac cd017f        	call	_SetSingleCoil
2568  05af 5b04          	addw	sp,#4
2569                     ; 463 ByteToHex(temp2,GetLRC(OutputFrame));
2571  05b1 96            	ldw	x,sp
2572  05b2 1c0007        	addw	x,#OFST-29
2573  05b5 cd0731        	call	_GetLRC
2575  05b8 88            	push	a
2576  05b9 96            	ldw	x,sp
2577  05ba 1c0006        	addw	x,#OFST-30
2578  05bd cd00a7        	call	_ByteToHex
2580  05c0 84            	pop	a
2581                     ; 464 OutputFrame[k] = temp2[0];
2583  05c1 96            	ldw	x,sp
2584  05c2 ad46          	call	LC005
2585  05c4 1b24          	add	a,(OFST+0,sp)
2586  05c6 2401          	jrnc	L603
2587  05c8 5c            	incw	x
2588  05c9               L603:
2589  05c9 02            	rlwa	x,a
2590  05ca 7b05          	ld	a,(OFST-31,sp)
2591  05cc f7            	ld	(x),a
2592                     ; 465 k++;
2594                     ; 466 OutputFrame[k] = temp2[1];
2596  05cd 96            	ldw	x,sp
2597  05ce 0c24          	inc	(OFST+0,sp)
2598  05d0 ad38          	call	LC005
2599  05d2 1b24          	add	a,(OFST+0,sp)
2600  05d4 2401          	jrnc	L013
2601  05d6 5c            	incw	x
2602  05d7               L013:
2603  05d7 02            	rlwa	x,a
2604  05d8 7b06          	ld	a,(OFST-30,sp)
2605  05da f7            	ld	(x),a
2606                     ; 467 k++;
2608                     ; 468 OutputFrame[k] = 0x0D;
2610  05db 96            	ldw	x,sp
2611  05dc 0c24          	inc	(OFST+0,sp)
2612  05de ad2a          	call	LC005
2613  05e0 1b24          	add	a,(OFST+0,sp)
2614  05e2 2401          	jrnc	L213
2615  05e4 5c            	incw	x
2616  05e5               L213:
2617  05e5 02            	rlwa	x,a
2618  05e6 a60d          	ld	a,#13
2619  05e8 f7            	ld	(x),a
2620                     ; 469 k++;
2622                     ; 470 OutputFrame[k] = 0x0A;
2624  05e9 96            	ldw	x,sp
2625  05ea 0c24          	inc	(OFST+0,sp)
2626  05ec ad1c          	call	LC005
2627  05ee 1b24          	add	a,(OFST+0,sp)
2628  05f0 2401          	jrnc	L413
2629  05f2 5c            	incw	x
2630  05f3               L413:
2631  05f3 02            	rlwa	x,a
2632  05f4 a60a          	ld	a,#10
2633  05f6 f7            	ld	(x),a
2634                     ; 471 k++;
2636                     ; 472 OutputFrame[k] = 0x0A;
2638  05f7 96            	ldw	x,sp
2639  05f8 0c24          	inc	(OFST+0,sp)
2640  05fa ad0e          	call	LC005
2641  05fc 1b24          	add	a,(OFST+0,sp)
2642  05fe 2401          	jrnc	L613
2643  0600 5c            	incw	x
2644  0601               L613:
2645  0601 02            	rlwa	x,a
2646  0602 a60a          	ld	a,#10
2647  0604 f7            	ld	(x),a
2648                     ; 473 k++;
2650  0605 0c24          	inc	(OFST+0,sp)
2651                     ; 474 }
2654  0607 5b24          	addw	sp,#36
2655  0609 81            	ret	
2656  060a               LC005:
2657  060a 1c0007        	addw	x,#OFST-29
2658  060d 9f            	ld	a,xl
2659  060e 5e            	swapw	x
2660  060f 81            	ret	
2749                     ; 480 void PresetSingleRegister(void)
2749                     ; 481 {
2750                     	switch	.text
2751  0610               _PresetSingleRegister:
2753  0610 5224          	subw	sp,#36
2754       00000024      OFST:	set	36
2757                     ; 486 uint16_t Register = 0;
2759  0612 5f            	clrw	x
2760  0613 1f01          	ldw	(OFST-35,sp),x
2761                     ; 487 uint16_t ValueToWrite = 0;
2763  0615 1f03          	ldw	(OFST-33,sp),x
2764                     ; 488 uint8_t k = 0;
2766                     ; 491 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
2768  0617 0f24          	clr	(OFST+0,sp)
2769  0619               L3011:
2772  0619 96            	ldw	x,sp
2773  061a cd06ce        	call	LC006
2774  061d 1b24          	add	a,(OFST+0,sp)
2775  061f 2401          	jrnc	L223
2776  0621 5c            	incw	x
2777  0622               L223:
2778  0622 02            	rlwa	x,a
2779  0623 7f            	clr	(x)
2782  0624 0c24          	inc	(OFST+0,sp)
2785  0626 7b24          	ld	a,(OFST+0,sp)
2786  0628 a119          	cp	a,#25
2787  062a 25ed          	jrult	L3011
2788                     ; 494 RewritingChars(OutputFrame,0,12);
2790  062c 4b0c          	push	#12
2791  062e 4b00          	push	#0
2792  0630 96            	ldw	x,sp
2793  0631 1c0009        	addw	x,#OFST-27
2794  0634 cd015d        	call	_RewritingChars
2796  0637 b605          	ld	a,_word+5
2797  0639 85            	popw	x
2798                     ; 498 temp4[0] = word[5];
2800  063a 6b20          	ld	(OFST-4,sp),a
2801                     ; 499 temp4[1] = word[6];
2803  063c b606          	ld	a,_word+6
2804  063e 6b21          	ld	(OFST-3,sp),a
2805                     ; 500 temp4[2] = word[7];
2807  0640 b607          	ld	a,_word+7
2808  0642 6b22          	ld	(OFST-2,sp),a
2809                     ; 501 temp4[3] = word[8];
2811  0644 b608          	ld	a,_word+8
2812  0646 6b23          	ld	(OFST-1,sp),a
2813                     ; 502 HexToByte_4(temp4, &Register);
2815  0648 96            	ldw	x,sp
2816  0649 5c            	incw	x
2817  064a 89            	pushw	x
2818  064b 1c001f        	addw	x,#31
2819  064e cd0762        	call	_HexToByte_4
2821  0651 b609          	ld	a,_word+9
2822  0653 85            	popw	x
2823                     ; 505 temp4[0] = word[9];
2825  0654 6b20          	ld	(OFST-4,sp),a
2826                     ; 506 temp4[1] = word[10];
2828  0656 b60a          	ld	a,_word+10
2829  0658 6b21          	ld	(OFST-3,sp),a
2830                     ; 507 temp4[2] = word[11];
2832  065a b60b          	ld	a,_word+11
2833  065c 6b22          	ld	(OFST-2,sp),a
2834                     ; 508 temp4[3] = word[12];
2836  065e b60c          	ld	a,_word+12
2837  0660 6b23          	ld	(OFST-1,sp),a
2838                     ; 509 HexToByte_4(temp4, &ValueToWrite);
2840  0662 96            	ldw	x,sp
2841  0663 1c0003        	addw	x,#OFST-33
2842  0666 89            	pushw	x
2843  0667 1c001d        	addw	x,#29
2844  066a cd0762        	call	_HexToByte_4
2846  066d 85            	popw	x
2847                     ; 512 Output_Registers[Register] = ValueToWrite;
2849  066e 1e01          	ldw	x,(OFST-35,sp)
2850  0670 58            	sllw	x
2851  0671 1603          	ldw	y,(OFST-33,sp)
2852  0673 ef00          	ldw	(_Output_Registers,x),y
2853                     ; 517 ByteToHex(temp2,GetLRC(OutputFrame));
2855  0675 96            	ldw	x,sp
2856  0676 1c0007        	addw	x,#OFST-29
2857  0679 cd0731        	call	_GetLRC
2859  067c 88            	push	a
2860  067d 96            	ldw	x,sp
2861  067e 1c0006        	addw	x,#OFST-30
2862  0681 cd00a7        	call	_ByteToHex
2864  0684 84            	pop	a
2865                     ; 518 OutputFrame[k] = temp2[0];
2867  0685 96            	ldw	x,sp
2868  0686 ad46          	call	LC006
2869  0688 1b24          	add	a,(OFST+0,sp)
2870  068a 2401          	jrnc	L633
2871  068c 5c            	incw	x
2872  068d               L633:
2873  068d 02            	rlwa	x,a
2874  068e 7b05          	ld	a,(OFST-31,sp)
2875  0690 f7            	ld	(x),a
2876                     ; 519 k++;
2878                     ; 520 OutputFrame[k] = temp2[1];
2880  0691 96            	ldw	x,sp
2881  0692 0c24          	inc	(OFST+0,sp)
2882  0694 ad38          	call	LC006
2883  0696 1b24          	add	a,(OFST+0,sp)
2884  0698 2401          	jrnc	L043
2885  069a 5c            	incw	x
2886  069b               L043:
2887  069b 02            	rlwa	x,a
2888  069c 7b06          	ld	a,(OFST-30,sp)
2889  069e f7            	ld	(x),a
2890                     ; 521 k++;
2892                     ; 522 OutputFrame[k] = 0x0D;
2894  069f 96            	ldw	x,sp
2895  06a0 0c24          	inc	(OFST+0,sp)
2896  06a2 ad2a          	call	LC006
2897  06a4 1b24          	add	a,(OFST+0,sp)
2898  06a6 2401          	jrnc	L243
2899  06a8 5c            	incw	x
2900  06a9               L243:
2901  06a9 02            	rlwa	x,a
2902  06aa a60d          	ld	a,#13
2903  06ac f7            	ld	(x),a
2904                     ; 523 k++;
2906                     ; 524 OutputFrame[k] = 0x0A;
2908  06ad 96            	ldw	x,sp
2909  06ae 0c24          	inc	(OFST+0,sp)
2910  06b0 ad1c          	call	LC006
2911  06b2 1b24          	add	a,(OFST+0,sp)
2912  06b4 2401          	jrnc	L443
2913  06b6 5c            	incw	x
2914  06b7               L443:
2915  06b7 02            	rlwa	x,a
2916  06b8 a60a          	ld	a,#10
2917  06ba f7            	ld	(x),a
2918                     ; 525 k++;
2920                     ; 526 OutputFrame[k] = 0x0A;
2922  06bb 96            	ldw	x,sp
2923  06bc 0c24          	inc	(OFST+0,sp)
2924  06be ad0e          	call	LC006
2925  06c0 1b24          	add	a,(OFST+0,sp)
2926  06c2 2401          	jrnc	L643
2927  06c4 5c            	incw	x
2928  06c5               L643:
2929  06c5 02            	rlwa	x,a
2930  06c6 a60a          	ld	a,#10
2931  06c8 f7            	ld	(x),a
2932                     ; 527 k++;
2934  06c9 0c24          	inc	(OFST+0,sp)
2935                     ; 528 }
2938  06cb 5b24          	addw	sp,#36
2939  06cd 81            	ret	
2940  06ce               LC006:
2941  06ce 1c0007        	addw	x,#OFST-29
2942  06d1 9f            	ld	a,xl
2943  06d2 5e            	swapw	x
2944  06d3 81            	ret	
3029                     ; 531 bool CheckLRC(char *frame)
3029                     ; 532 {
3030                     	switch	.text
3031  06d4               _CheckLRC:
3033  06d4 89            	pushw	x
3034  06d5 5207          	subw	sp,#7
3035       00000007      OFST:	set	7
3038                     ; 533 	uint8_t a = 0;
3040  06d7 0f07          	clr	(OFST+0,sp)
3041                     ; 536 	uint8_t tempSum = 0;
3043  06d9 0f01          	clr	(OFST-6,sp)
3044                     ; 538 	uint8_t LRC_calculated = 0;
3046                     ; 540 	uint8_t LRC_dec_from_frame = 0;	
3048  06db 0f02          	clr	(OFST-5,sp)
3050  06dd 2002          	jra	L7511
3051  06df               L3511:
3052                     ; 545 				a++;
3054  06df 0c07          	inc	(OFST+0,sp)
3055  06e1               L7511:
3056                     ; 543 	while(word[a] != '\r')
3058  06e1 7b07          	ld	a,(OFST+0,sp)
3059  06e3 5f            	clrw	x
3060  06e4 97            	ld	xl,a
3061  06e5 e600          	ld	a,(_word,x)
3062  06e7 a10d          	cp	a,#13
3063  06e9 26f4          	jrne	L3511
3064                     ; 548 temp[1] = frame[a-1];
3066  06eb 7b07          	ld	a,(OFST+0,sp)
3067  06ed 5f            	clrw	x
3068  06ee 97            	ld	xl,a
3069  06ef 5a            	decw	x
3070  06f0 72fb08        	addw	x,(OFST+1,sp)
3071  06f3 f6            	ld	a,(x)
3072  06f4 6b04          	ld	(OFST-3,sp),a
3073                     ; 549 temp[0] = frame[a-2];
3075  06f6 5f            	clrw	x
3076  06f7 7b07          	ld	a,(OFST+0,sp)
3077  06f9 97            	ld	xl,a
3078  06fa 1d0002        	subw	x,#2
3079  06fd 72fb08        	addw	x,(OFST+1,sp)
3080  0700 f6            	ld	a,(x)
3081  0701 6b03          	ld	(OFST-4,sp),a
3082                     ; 551 HexToByte(temp,&LRC_dec_from_frame);
3084  0703 96            	ldw	x,sp
3085  0704 1c0002        	addw	x,#OFST-5
3086  0707 89            	pushw	x
3087  0708 5c            	incw	x
3088  0709 cd00df        	call	_HexToByte
3090  070c 85            	popw	x
3091                     ; 553 frame[a-1] = '\0';
3093  070d 7b07          	ld	a,(OFST+0,sp)
3094  070f 5f            	clrw	x
3095  0710 97            	ld	xl,a
3096  0711 5a            	decw	x
3097  0712 72fb08        	addw	x,(OFST+1,sp)
3098  0715 7f            	clr	(x)
3099                     ; 554 frame[a-2] = '\0';
3101  0716 5f            	clrw	x
3102  0717 97            	ld	xl,a
3103  0718 1d0002        	subw	x,#2
3104  071b 72fb08        	addw	x,(OFST+1,sp)
3105  071e 7f            	clr	(x)
3106                     ; 557 LRC_calculated = GetLRC(frame);
3108  071f 1e08          	ldw	x,(OFST+1,sp)
3109  0721 ad0e          	call	_GetLRC
3111  0723 6b07          	ld	(OFST+0,sp),a
3112                     ; 559 if (LRC_calculated == LRC_dec_from_frame)
3114  0725 1102          	cp	a,(OFST-5,sp)
3115  0727 2604          	jrne	L3611
3116                     ; 562 		return 1;
3118  0729 a601          	ld	a,#1
3120  072b 2001          	jra	L653
3121  072d               L3611:
3122                     ; 566 		return 0;
3124  072d 4f            	clr	a
3126  072e               L653:
3128  072e 5b09          	addw	sp,#9
3129  0730 81            	ret	
3193                     ; 570 uint8_t GetLRC(char *frame)
3193                     ; 571 {
3194                     	switch	.text
3195  0731               _GetLRC:
3197  0731 89            	pushw	x
3198  0732 5204          	subw	sp,#4
3199       00000004      OFST:	set	4
3202                     ; 572 uint8_t LRCsum = 0;
3204  0734 0f01          	clr	(OFST-3,sp)
3205                     ; 575 frame++;
3207  0736 1e05          	ldw	x,(OFST+1,sp)
3208  0738 5c            	incw	x
3209  0739 1f05          	ldw	(OFST+1,sp),x
3211  073b 201b          	jra	L3221
3212  073d               L1221:
3213                     ; 579 temp[0] = *frame++;
3215  073d 6b03          	ld	(OFST-1,sp),a
3216  073f 5c            	incw	x
3217                     ; 580 temp[1] = *frame++;
3219  0740 f6            	ld	a,(x)
3220  0741 5c            	incw	x
3221  0742 1f05          	ldw	(OFST+1,sp),x
3222  0744 6b04          	ld	(OFST+0,sp),a
3223                     ; 581 HexToByte(temp, &TempSum);
3225  0746 96            	ldw	x,sp
3226  0747 1c0002        	addw	x,#OFST-2
3227  074a 89            	pushw	x
3228  074b 5c            	incw	x
3229  074c cd00df        	call	_HexToByte
3231  074f 85            	popw	x
3232                     ; 582 LRCsum += TempSum;
3234  0750 7b01          	ld	a,(OFST-3,sp)
3235  0752 1b02          	add	a,(OFST-2,sp)
3236  0754 6b01          	ld	(OFST-3,sp),a
3237  0756 1e05          	ldw	x,(OFST+1,sp)
3238  0758               L3221:
3239                     ; 577 while(*frame)
3241  0758 f6            	ld	a,(x)
3242  0759 26e2          	jrne	L1221
3243                     ; 584 LRCsum = (~(LRCsum)+1);
3245  075b 7b01          	ld	a,(OFST-3,sp)
3246  075d 43            	cpl	a
3247  075e 4c            	inc	a
3248                     ; 585 return LRCsum;
3252  075f 5b06          	addw	sp,#6
3253  0761 81            	ret	
3345                     ; 589 void HexToByte_4(char *hexstring_4, uint16_t *byte)
3345                     ; 590 {
3346                     	switch	.text
3347  0762               _HexToByte_4:
3349  0762 89            	pushw	x
3350  0763 5208          	subw	sp,#8
3351       00000008      OFST:	set	8
3354                     ; 592 uint8_t right_dec = 0;
3356  0765 0f01          	clr	(OFST-7,sp)
3357                     ; 593 uint8_t left_dec = 0;
3359  0767 0f02          	clr	(OFST-6,sp)
3360                     ; 594 uint16_t right_dec16 = 0;
3362  0769 5f            	clrw	x
3363  076a 1f03          	ldw	(OFST-5,sp),x
3364                     ; 595 uint16_t left_dec16 = 0;
3366  076c 1f05          	ldw	(OFST-3,sp),x
3367                     ; 597 tempp[0] = hexstring_4[0];
3369  076e 1e09          	ldw	x,(OFST+1,sp)
3370  0770 f6            	ld	a,(x)
3371  0771 6b07          	ld	(OFST-1,sp),a
3372                     ; 598 tempp[1] = hexstring_4[1];
3374  0773 e601          	ld	a,(1,x)
3375  0775 6b08          	ld	(OFST+0,sp),a
3376                     ; 599 HexToByte(tempp,&left_dec);
3378  0777 96            	ldw	x,sp
3379  0778 1c0002        	addw	x,#OFST-6
3380  077b 89            	pushw	x
3381  077c 1c0005        	addw	x,#5
3382  077f cd00df        	call	_HexToByte
3384  0782 85            	popw	x
3385                     ; 601 tempp[0] = hexstring_4[2];
3387  0783 1e09          	ldw	x,(OFST+1,sp)
3388  0785 e602          	ld	a,(2,x)
3389  0787 6b07          	ld	(OFST-1,sp),a
3390                     ; 602 tempp[1] = hexstring_4[3];
3392  0789 e603          	ld	a,(3,x)
3393  078b 6b08          	ld	(OFST+0,sp),a
3394                     ; 603 HexToByte(tempp,&right_dec);
3396  078d 96            	ldw	x,sp
3397  078e 5c            	incw	x
3398  078f 89            	pushw	x
3399  0790 1c0006        	addw	x,#6
3400  0793 cd00df        	call	_HexToByte
3402  0796 85            	popw	x
3403                     ; 605 left_dec16 = left_dec16 | left_dec;
3405  0797 7b02          	ld	a,(OFST-6,sp)
3406  0799 5f            	clrw	x
3407  079a 97            	ld	xl,a
3408  079b 01            	rrwa	x,a
3409  079c 1a06          	or	a,(OFST-2,sp)
3410  079e 01            	rrwa	x,a
3411  079f 1a05          	or	a,(OFST-3,sp)
3412  07a1 01            	rrwa	x,a
3413  07a2 1f05          	ldw	(OFST-3,sp),x
3414                     ; 606 right_dec16 = right_dec16 | right_dec;
3416  07a4 5f            	clrw	x
3417  07a5 7b01          	ld	a,(OFST-7,sp)
3418  07a7 97            	ld	xl,a
3419  07a8 01            	rrwa	x,a
3420  07a9 1a04          	or	a,(OFST-4,sp)
3421  07ab 01            	rrwa	x,a
3422  07ac 1a03          	or	a,(OFST-5,sp)
3423  07ae 01            	rrwa	x,a
3424  07af 1f03          	ldw	(OFST-5,sp),x
3425                     ; 608 *byte = (left_dec16 << 8) | right_dec16;
3427  07b1 7b04          	ld	a,(OFST-4,sp)
3428  07b3 1e05          	ldw	x,(OFST-3,sp)
3429  07b5 01            	rrwa	x,a
3430  07b6 1a03          	or	a,(OFST-5,sp)
3431  07b8 160d          	ldw	y,(OFST+5,sp)
3432  07ba 01            	rrwa	x,a
3433  07bb 90ff          	ldw	(y),x
3434                     ; 609 }
3437  07bd 5b0a          	addw	sp,#10
3438  07bf 81            	ret	
3548                     ; 613 void ByteToHex_4(char *hexstring, uint16_t byte)
3548                     ; 614 {
3549                     	switch	.text
3550  07c0               _ByteToHex_4:
3552  07c0 89            	pushw	x
3553  07c1 520b          	subw	sp,#11
3554       0000000b      OFST:	set	11
3557                     ; 617 	uint16_t D1 = byte >> 8;
3559  07c3 1e10          	ldw	x,(OFST+5,sp)
3560  07c5 4f            	clr	a
3561  07c6 01            	rrwa	x,a
3562  07c7 1f02          	ldw	(OFST-9,sp),x
3563                     ; 618   uint16_t D2 = byte & 255;
3565  07c9 5f            	clrw	x
3566  07ca 7b11          	ld	a,(OFST+6,sp)
3567  07cc 02            	rlwa	x,a
3568  07cd 1f04          	ldw	(OFST-7,sp),x
3569                     ; 619 	uint8_t D1_8 = 0;
3571  07cf 0f06          	clr	(OFST-5,sp)
3572                     ; 620 	uint8_t D2_8 = 0;
3574  07d1 0f07          	clr	(OFST-4,sp)
3575                     ; 621 	uint8_t ct = 0;
3577  07d3 0f01          	clr	(OFST-10,sp)
3578                     ; 623 	D1_8 |= D1;
3580  07d5 7b06          	ld	a,(OFST-5,sp)
3581  07d7 1a03          	or	a,(OFST-8,sp)
3582  07d9 6b06          	ld	(OFST-5,sp),a
3583                     ; 624 	D2_8 |= D2;
3585  07db 7b07          	ld	a,(OFST-4,sp)
3586  07dd 1a05          	or	a,(OFST-6,sp)
3587  07df 6b07          	ld	(OFST-4,sp),a
3588                     ; 626 	ByteToHex(temp1, D1_8);
3590  07e1 7b06          	ld	a,(OFST-5,sp)
3591  07e3 88            	push	a
3592  07e4 96            	ldw	x,sp
3593  07e5 1c0009        	addw	x,#OFST-2
3594  07e8 cd00a7        	call	_ByteToHex
3596  07eb 84            	pop	a
3597                     ; 627 	ByteToHex(temp2, D2_8);
3599  07ec 7b07          	ld	a,(OFST-4,sp)
3600  07ee 88            	push	a
3601  07ef 96            	ldw	x,sp
3602  07f0 1c000b        	addw	x,#OFST+0
3603  07f3 cd00a7        	call	_ByteToHex
3605  07f6 84            	pop	a
3606                     ; 629 	hexstring[0] = temp1[0];
3608  07f7 1e0c          	ldw	x,(OFST+1,sp)
3609  07f9 7b08          	ld	a,(OFST-3,sp)
3610  07fb f7            	ld	(x),a
3611                     ; 630 	hexstring[1] = temp1[1];
3613  07fc 7b09          	ld	a,(OFST-2,sp)
3614  07fe e701          	ld	(1,x),a
3615                     ; 631 	hexstring[2] = temp2[0];
3617  0800 7b0a          	ld	a,(OFST-1,sp)
3618  0802 e702          	ld	(2,x),a
3619                     ; 632 	hexstring[3] = temp2[1];
3621  0804 7b0b          	ld	a,(OFST+0,sp)
3622  0806 e703          	ld	(3,x),a
3623                     ; 634 }
3626  0808 5b0d          	addw	sp,#13
3627  080a 81            	ret	
3640                     	xref.b	_Output_Registers
3641                     	xref.b	_Input_Registers
3642                     	xref.b	_word
3643                     	xref.b	_Address
3644                     	xref.b	_TimmingDelay
3645                     	xdef	_SetSingleCoil
3646                     	xdef	_StateOfCoil
3647                     	xdef	_RewritingChars
3648                     	xdef	_PresetSingleRegister
3649                     	xdef	_ForceSingleCoil
3650                     	xdef	_ReadInputRegisters
3651                     	xdef	_ReadHoldingRegisters
3652                     	xdef	_ReadInputStatus
3653                     	xdef	_ReadCoilStatus
3654                     	xdef	___checkFunc
3655                     	xdef	___checkAddr
3656                     	xdef	_ByteToHex_4
3657                     	xdef	_GetLRC
3658                     	xdef	_CheckLRC
3659                     	xdef	_SetDevAddr
3660                     	xdef	_HexToByte_4
3661                     	xdef	_HexToByte
3662                     	xdef	_ByteToHex
3663                     	xdef	_UART_SendStr
3664                     	xdef	_Modbus_Init
3665                     	xdef	_Delay
3666                     	xdef	_Delay_Init
3667                     	xref	_UART2_SendData8
3668                     	xref	_UART2_ITConfig
3669                     	xref	_UART2_Cmd
3670                     	xref	_UART2_Init
3671                     	xref	_UART2_DeInit
3672                     	xref	_TIM3_ITConfig
3673                     	xref	_TIM3_Cmd
3674                     	xref	_TIM3_TimeBaseInit
3675                     	xref	_TIM3_DeInit
3676                     	xref	_TIM2_ITConfig
3677                     	xref	_TIM2_Cmd
3678                     	xref	_TIM2_TimeBaseInit
3679                     	xref	_TIM2_DeInit
3680                     	xref	_GPIO_WriteLow
3681                     	xref	_GPIO_WriteHigh
3682                     	xref	_GPIO_Init
3683                     	xref	_GPIO_DeInit
3684                     	xref	_CLK_HSIPrescalerConfig
3703                     	xref	c_lzmp
3704                     	end
