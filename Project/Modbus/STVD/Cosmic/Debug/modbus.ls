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
 750                     ; 141 	if(Function_Number == 1 || Function_Number == 2 || Function_Number == 3 || Function_Number == 4 || Function_Number == 5 || Function_Number == 6 || Function_Number == 15 || Function_Number == 16)
 752  0130 a101          	cp	a,#1
 753  0132 271c          	jreq	L772
 755  0134 a102          	cp	a,#2
 756  0136 2718          	jreq	L772
 758  0138 a103          	cp	a,#3
 759  013a 2714          	jreq	L772
 761  013c a104          	cp	a,#4
 762  013e 2710          	jreq	L772
 764  0140 a105          	cp	a,#5
 765  0142 270c          	jreq	L772
 767  0144 a106          	cp	a,#6
 768  0146 2708          	jreq	L772
 770  0148 a10f          	cp	a,#15
 771  014a 2704          	jreq	L772
 773  014c a110          	cp	a,#16
 774  014e 2603          	jrne	L572
 775  0150               L772:
 776                     ; 143 		return 1;
 778  0150 a601          	ld	a,#1
 781  0152 81            	ret	
 782  0153               L572:
 783                     ; 147 		return 0;
 785  0153 4f            	clr	a
 788  0154 81            	ret	
 824                     ; 151 void SetDevAddr(uint8_t Addr)
 824                     ; 152 {
 825                     	switch	.text
 826  0155               _SetDevAddr:
 828  0155 88            	push	a
 829       00000000      OFST:	set	0
 832                     ; 153 	if(__checkAddr(Addr))
 834  0156 add5          	call	___checkAddr
 836  0158 4d            	tnz	a
 837  0159 2704          	jreq	L533
 838                     ; 155 	Address = Addr;
 840  015b 7b01          	ld	a,(OFST+1,sp)
 841  015d b700          	ld	_Address,a
 842  015f               L533:
 843                     ; 157 }
 846  015f 84            	pop	a
 847  0160 81            	ret	
 901                     ; 159 void RewritingChars(char *destination, uint8_t from, uint8_t to)
 901                     ; 160 {
 902                     	switch	.text
 903  0161               _RewritingChars:
 905  0161 89            	pushw	x
 906       00000000      OFST:	set	0
 909                     ; 161 for(from; from<=to; ++from)
 912  0162 2017          	jra	L173
 913  0164               L563:
 914                     ; 163 	destination[from] = word[from];	
 916  0164 7b01          	ld	a,(OFST+1,sp)
 917  0166 97            	ld	xl,a
 918  0167 7b02          	ld	a,(OFST+2,sp)
 919  0169 1b05          	add	a,(OFST+5,sp)
 920  016b 2401          	jrnc	L67
 921  016d 5c            	incw	x
 922  016e               L67:
 923  016e 02            	rlwa	x,a
 924  016f 7b05          	ld	a,(OFST+5,sp)
 925  0171 905f          	clrw	y
 926  0173 9097          	ld	yl,a
 927  0175 90e600        	ld	a,(_word,y)
 928  0178 f7            	ld	(x),a
 929                     ; 161 for(from; from<=to; ++from)
 931  0179 0c05          	inc	(OFST+5,sp)
 932  017b               L173:
 935  017b 7b05          	ld	a,(OFST+5,sp)
 936  017d 1106          	cp	a,(OFST+6,sp)
 937  017f 23e3          	jrule	L563
 938                     ; 166 }
 941  0181 85            	popw	x
 942  0182 81            	ret	
 997                     ; 170 void SetSingleCoil(uint16_t *Coil, uint16_t *StatusToWrite, uint16_t *registers)
 997                     ; 171 { 
 998                     	switch	.text
 999  0183               _SetSingleCoil:
1001  0183 89            	pushw	x
1002       00000000      OFST:	set	0
1005                     ; 174 if(*StatusToWrite == 0xFF00)
1007  0184 1605          	ldw	y,(OFST+5,sp)
1008  0186 90fe          	ldw	y,(y)
1009  0188 90a3ff00      	cpw	y,#65280
1010  018c 262a          	jrne	L324
1011                     ; 176 		registers[*Coil/16 ] |= (1<<(*Coil%16));		
1013  018e 1e01          	ldw	x,(OFST+1,sp)
1014  0190 fe            	ldw	x,(x)
1015  0191 54            	srlw	x
1016  0192 54            	srlw	x
1017  0193 54            	srlw	x
1018  0194 54            	srlw	x
1019  0195 58            	sllw	x
1020  0196 1601          	ldw	y,(OFST+1,sp)
1021  0198 72fb07        	addw	x,(OFST+7,sp)
1022  019b 90e601        	ld	a,(1,y)
1023  019e a40f          	and	a,#15
1024  01a0 90ae0001      	ldw	y,#1
1025  01a4 4d            	tnz	a
1026  01a5 2705          	jreq	L201
1027  01a7               L401:
1028  01a7 9058          	sllw	y
1029  01a9 4a            	dec	a
1030  01aa 26fb          	jrne	L401
1031  01ac               L201:
1032  01ac 9001          	rrwa	y,a
1033  01ae ea01          	or	a,(1,x)
1034  01b0 9001          	rrwa	y,a
1035  01b2 fa            	or	a,(x)
1036  01b3 9001          	rrwa	y,a
1037  01b5 ff            	ldw	(x),y
1039  01b6 2039          	jra	L524
1040  01b8               L324:
1041                     ; 180 else if(*StatusToWrite == 0x0000)
1043  01b8 1e05          	ldw	x,(OFST+5,sp)
1044  01ba e601          	ld	a,(1,x)
1045  01bc fa            	or	a,(x)
1046  01bd 2632          	jrne	L524
1047                     ; 182 		registers[*Coil/16 ] &= (!(1<<(*Coil%16)));
1049  01bf 1601          	ldw	y,(OFST+1,sp)
1050  01c1 ae0001        	ldw	x,#1
1051  01c4 90e601        	ld	a,(1,y)
1052  01c7 a40f          	and	a,#15
1053  01c9 2704          	jreq	L011
1054  01cb               L211:
1055  01cb 58            	sllw	x
1056  01cc 4a            	dec	a
1057  01cd 26fc          	jrne	L211
1058  01cf               L011:
1059  01cf a30000        	cpw	x,#0
1060  01d2 2603          	jrne	L601
1061  01d4 5c            	incw	x
1062  01d5 2001          	jra	L411
1063  01d7               L601:
1064  01d7 5f            	clrw	x
1065  01d8               L411:
1066  01d8 90fe          	ldw	y,(y)
1067  01da 9054          	srlw	y
1068  01dc 9054          	srlw	y
1069  01de 9054          	srlw	y
1070  01e0 9054          	srlw	y
1071  01e2 9058          	sllw	y
1072  01e4 72f907        	addw	y,(OFST+7,sp)
1073  01e7 01            	rrwa	x,a
1074  01e8 90e401        	and	a,(1,y)
1075  01eb 01            	rrwa	x,a
1076  01ec 90f4          	and	a,(y)
1077  01ee 01            	rrwa	x,a
1078  01ef 90ff          	ldw	(y),x
1080  01f1               L524:
1081                     ; 188 }
1084  01f1 85            	popw	x
1085  01f2 81            	ret	
1168                     ; 191 bool StateOfCoil(uint8_t NumberOfCoil, uint16_t registers[])
1168                     ; 192 {
1169                     	switch	.text
1170  01f3               _StateOfCoil:
1172  01f3 88            	push	a
1173  01f4 5204          	subw	sp,#4
1174       00000004      OFST:	set	4
1177                     ; 194 	uint16_t Value = registers[NumberOfCoil/16];   
1179  01f6 5f            	clrw	x
1180  01f7 97            	ld	xl,a
1181  01f8 57            	sraw	x
1182  01f9 57            	sraw	x
1183  01fa 57            	sraw	x
1184  01fb 57            	sraw	x
1185  01fc 58            	sllw	x
1186  01fd 72fb08        	addw	x,(OFST+4,sp)
1187  0200 fe            	ldw	x,(x)
1188  0201 1f01          	ldw	(OFST-3,sp),x
1189                     ; 197 	uint16_t Compare = 1<<(NumberOfCoil%16);			
1191  0203 ae0001        	ldw	x,#1
1192  0206 a40f          	and	a,#15
1193  0208 2704          	jreq	L021
1194  020a               L221:
1195  020a 58            	sllw	x
1196  020b 4a            	dec	a
1197  020c 26fc          	jrne	L221
1198  020e               L021:
1199  020e 1f03          	ldw	(OFST-1,sp),x
1200                     ; 199 	if ((Value & Compare) == Compare )
1202  0210 1e01          	ldw	x,(OFST-3,sp)
1203  0212 01            	rrwa	x,a
1204  0213 1404          	and	a,(OFST+0,sp)
1205  0215 01            	rrwa	x,a
1206  0216 1403          	and	a,(OFST-1,sp)
1207  0218 01            	rrwa	x,a
1208  0219 1303          	cpw	x,(OFST-1,sp)
1209  021b 2604          	jrne	L574
1210                     ; 201 				return 1;
1212  021d a601          	ld	a,#1
1214  021f 2001          	jra	L421
1215  0221               L574:
1216                     ; 206 				return 0;
1218  0221 4f            	clr	a
1220  0222               L421:
1222  0222 5b05          	addw	sp,#5
1223  0224 81            	ret	
1308                     ; 212 bool CheckLRC(char *frame)
1308                     ; 213 {
1309                     	switch	.text
1310  0225               _CheckLRC:
1312  0225 89            	pushw	x
1313  0226 5207          	subw	sp,#7
1314       00000007      OFST:	set	7
1317                     ; 214 	uint8_t a = 0;
1319  0228 0f07          	clr	(OFST+0,sp)
1320                     ; 217 	uint8_t tempSum = 0;
1322  022a 0f01          	clr	(OFST-6,sp)
1323                     ; 219 	uint8_t LRC_calculated = 0;
1325                     ; 221 	uint8_t LRC_dec_from_frame = 0;	
1327  022c 0f02          	clr	(OFST-5,sp)
1329  022e 2002          	jra	L745
1330  0230               L345:
1331                     ; 226 				a++;
1333  0230 0c07          	inc	(OFST+0,sp)
1334  0232               L745:
1335                     ; 224 	while(word[a] != '\r')
1337  0232 7b07          	ld	a,(OFST+0,sp)
1338  0234 5f            	clrw	x
1339  0235 97            	ld	xl,a
1340  0236 e600          	ld	a,(_word,x)
1341  0238 a10d          	cp	a,#13
1342  023a 26f4          	jrne	L345
1343                     ; 229 temp[1] = frame[a-1];
1345  023c 7b07          	ld	a,(OFST+0,sp)
1346  023e 5f            	clrw	x
1347  023f 97            	ld	xl,a
1348  0240 5a            	decw	x
1349  0241 72fb08        	addw	x,(OFST+1,sp)
1350  0244 f6            	ld	a,(x)
1351  0245 6b04          	ld	(OFST-3,sp),a
1352                     ; 230 temp[0] = frame[a-2];
1354  0247 5f            	clrw	x
1355  0248 7b07          	ld	a,(OFST+0,sp)
1356  024a 97            	ld	xl,a
1357  024b 1d0002        	subw	x,#2
1358  024e 72fb08        	addw	x,(OFST+1,sp)
1359  0251 f6            	ld	a,(x)
1360  0252 6b03          	ld	(OFST-4,sp),a
1361                     ; 232 HexToByte(temp,&LRC_dec_from_frame);
1363  0254 96            	ldw	x,sp
1364  0255 1c0002        	addw	x,#OFST-5
1365  0258 89            	pushw	x
1366  0259 5c            	incw	x
1367  025a cd00df        	call	_HexToByte
1369  025d 85            	popw	x
1370                     ; 234 frame[a-1] = '\0';
1372  025e 7b07          	ld	a,(OFST+0,sp)
1373  0260 5f            	clrw	x
1374  0261 97            	ld	xl,a
1375  0262 5a            	decw	x
1376  0263 72fb08        	addw	x,(OFST+1,sp)
1377  0266 7f            	clr	(x)
1378                     ; 235 frame[a-2] = '\0';
1380  0267 5f            	clrw	x
1381  0268 97            	ld	xl,a
1382  0269 1d0002        	subw	x,#2
1383  026c 72fb08        	addw	x,(OFST+1,sp)
1384  026f 7f            	clr	(x)
1385                     ; 238 LRC_calculated = GetLRC(frame);
1387  0270 1e08          	ldw	x,(OFST+1,sp)
1388  0272 ad0e          	call	_GetLRC
1390  0274 6b07          	ld	(OFST+0,sp),a
1391                     ; 240 if (LRC_calculated == LRC_dec_from_frame)
1393  0276 1102          	cp	a,(OFST-5,sp)
1394  0278 2604          	jrne	L355
1395                     ; 242 	return 1;
1397  027a a601          	ld	a,#1
1399  027c 2001          	jra	L431
1400  027e               L355:
1401                     ; 246 	return 0;
1403  027e 4f            	clr	a
1405  027f               L431:
1407  027f 5b09          	addw	sp,#9
1408  0281 81            	ret	
1472                     ; 250 uint8_t GetLRC(char *frame)
1472                     ; 251 {
1473                     	switch	.text
1474  0282               _GetLRC:
1476  0282 89            	pushw	x
1477  0283 5204          	subw	sp,#4
1478       00000004      OFST:	set	4
1481                     ; 252 uint8_t LRCsum = 0;
1483  0285 0f01          	clr	(OFST-3,sp)
1484                     ; 255 frame++;
1486  0287 1e05          	ldw	x,(OFST+1,sp)
1487  0289 5c            	incw	x
1488  028a 1f05          	ldw	(OFST+1,sp),x
1490  028c 201b          	jra	L316
1491  028e               L116:
1492                     ; 259 temp[0] = *frame++;
1494  028e 6b03          	ld	(OFST-1,sp),a
1495  0290 5c            	incw	x
1496                     ; 260 temp[1] = *frame++;
1498  0291 f6            	ld	a,(x)
1499  0292 5c            	incw	x
1500  0293 1f05          	ldw	(OFST+1,sp),x
1501  0295 6b04          	ld	(OFST+0,sp),a
1502                     ; 261 HexToByte(temp, &TempSum);
1504  0297 96            	ldw	x,sp
1505  0298 1c0002        	addw	x,#OFST-2
1506  029b 89            	pushw	x
1507  029c 5c            	incw	x
1508  029d cd00df        	call	_HexToByte
1510  02a0 85            	popw	x
1511                     ; 262 LRCsum += TempSum;
1513  02a1 7b01          	ld	a,(OFST-3,sp)
1514  02a3 1b02          	add	a,(OFST-2,sp)
1515  02a5 6b01          	ld	(OFST-3,sp),a
1516  02a7 1e05          	ldw	x,(OFST+1,sp)
1517  02a9               L316:
1518                     ; 257 while(*frame)
1520  02a9 f6            	ld	a,(x)
1521  02aa 26e2          	jrne	L116
1522                     ; 264 LRCsum = (~(LRCsum)+1);
1524  02ac 7b01          	ld	a,(OFST-3,sp)
1525  02ae 43            	cpl	a
1526  02af 4c            	inc	a
1527                     ; 265 return LRCsum;
1531  02b0 5b06          	addw	sp,#6
1532  02b2 81            	ret	
1624                     ; 269 void HexToByte_4(char *hexstring_4, uint16_t *byte)
1624                     ; 270 {
1625                     	switch	.text
1626  02b3               _HexToByte_4:
1628  02b3 89            	pushw	x
1629  02b4 5208          	subw	sp,#8
1630       00000008      OFST:	set	8
1633                     ; 272 uint8_t right_dec = 0;
1635  02b6 0f01          	clr	(OFST-7,sp)
1636                     ; 273 uint8_t left_dec = 0;
1638  02b8 0f02          	clr	(OFST-6,sp)
1639                     ; 274 uint16_t right_dec16 = 0;
1641  02ba 5f            	clrw	x
1642  02bb 1f03          	ldw	(OFST-5,sp),x
1643                     ; 275 uint16_t left_dec16 = 0;
1645  02bd 1f05          	ldw	(OFST-3,sp),x
1646                     ; 277 tempp[0] = hexstring_4[0];
1648  02bf 1e09          	ldw	x,(OFST+1,sp)
1649  02c1 f6            	ld	a,(x)
1650  02c2 6b07          	ld	(OFST-1,sp),a
1651                     ; 278 tempp[1] = hexstring_4[1];
1653  02c4 e601          	ld	a,(1,x)
1654  02c6 6b08          	ld	(OFST+0,sp),a
1655                     ; 279 HexToByte(tempp,&left_dec);
1657  02c8 96            	ldw	x,sp
1658  02c9 1c0002        	addw	x,#OFST-6
1659  02cc 89            	pushw	x
1660  02cd 1c0005        	addw	x,#5
1661  02d0 cd00df        	call	_HexToByte
1663  02d3 85            	popw	x
1664                     ; 281 tempp[0] = hexstring_4[2];
1666  02d4 1e09          	ldw	x,(OFST+1,sp)
1667  02d6 e602          	ld	a,(2,x)
1668  02d8 6b07          	ld	(OFST-1,sp),a
1669                     ; 282 tempp[1] = hexstring_4[3];
1671  02da e603          	ld	a,(3,x)
1672  02dc 6b08          	ld	(OFST+0,sp),a
1673                     ; 283 HexToByte(tempp,&right_dec);
1675  02de 96            	ldw	x,sp
1676  02df 5c            	incw	x
1677  02e0 89            	pushw	x
1678  02e1 1c0006        	addw	x,#6
1679  02e4 cd00df        	call	_HexToByte
1681  02e7 85            	popw	x
1682                     ; 285 left_dec16 = left_dec16 | left_dec;
1684  02e8 7b02          	ld	a,(OFST-6,sp)
1685  02ea 5f            	clrw	x
1686  02eb 97            	ld	xl,a
1687  02ec 01            	rrwa	x,a
1688  02ed 1a06          	or	a,(OFST-2,sp)
1689  02ef 01            	rrwa	x,a
1690  02f0 1a05          	or	a,(OFST-3,sp)
1691  02f2 01            	rrwa	x,a
1692  02f3 1f05          	ldw	(OFST-3,sp),x
1693                     ; 286 right_dec16 = right_dec16 | right_dec;
1695  02f5 5f            	clrw	x
1696  02f6 7b01          	ld	a,(OFST-7,sp)
1697  02f8 97            	ld	xl,a
1698  02f9 01            	rrwa	x,a
1699  02fa 1a04          	or	a,(OFST-4,sp)
1700  02fc 01            	rrwa	x,a
1701  02fd 1a03          	or	a,(OFST-5,sp)
1702  02ff 01            	rrwa	x,a
1703  0300 1f03          	ldw	(OFST-5,sp),x
1704                     ; 288 *byte = (left_dec16 << 8) | right_dec16;
1706  0302 7b04          	ld	a,(OFST-4,sp)
1707  0304 1e05          	ldw	x,(OFST-3,sp)
1708  0306 01            	rrwa	x,a
1709  0307 1a03          	or	a,(OFST-5,sp)
1710  0309 160d          	ldw	y,(OFST+5,sp)
1711  030b 01            	rrwa	x,a
1712  030c 90ff          	ldw	(y),x
1713                     ; 289 }
1716  030e 5b0a          	addw	sp,#10
1717  0310 81            	ret	
1827                     ; 293 void ByteToHex_4(char *hexstring, uint16_t byte)
1827                     ; 294 {
1828                     	switch	.text
1829  0311               _ByteToHex_4:
1831  0311 89            	pushw	x
1832  0312 520b          	subw	sp,#11
1833       0000000b      OFST:	set	11
1836                     ; 297 	uint16_t D1 = byte >> 8;
1838  0314 1e10          	ldw	x,(OFST+5,sp)
1839  0316 4f            	clr	a
1840  0317 01            	rrwa	x,a
1841  0318 1f02          	ldw	(OFST-9,sp),x
1842                     ; 298   uint16_t D2 = byte & 255;
1844  031a 5f            	clrw	x
1845  031b 7b11          	ld	a,(OFST+6,sp)
1846  031d 02            	rlwa	x,a
1847  031e 1f04          	ldw	(OFST-7,sp),x
1848                     ; 299 	uint8_t D1_8 = 0;
1850  0320 0f06          	clr	(OFST-5,sp)
1851                     ; 300 	uint8_t D2_8 = 0;
1853  0322 0f07          	clr	(OFST-4,sp)
1854                     ; 301 	uint8_t ct = 0;
1856  0324 0f01          	clr	(OFST-10,sp)
1857                     ; 303 	D1_8 |= D1;
1859  0326 7b06          	ld	a,(OFST-5,sp)
1860  0328 1a03          	or	a,(OFST-8,sp)
1861  032a 6b06          	ld	(OFST-5,sp),a
1862                     ; 304 	D2_8 |= D2;
1864  032c 7b07          	ld	a,(OFST-4,sp)
1865  032e 1a05          	or	a,(OFST-6,sp)
1866  0330 6b07          	ld	(OFST-4,sp),a
1867                     ; 306 	ByteToHex(temp1, D1_8);
1869  0332 7b06          	ld	a,(OFST-5,sp)
1870  0334 88            	push	a
1871  0335 96            	ldw	x,sp
1872  0336 1c0009        	addw	x,#OFST-2
1873  0339 cd00a7        	call	_ByteToHex
1875  033c 84            	pop	a
1876                     ; 307 	ByteToHex(temp2, D2_8);
1878  033d 7b07          	ld	a,(OFST-4,sp)
1879  033f 88            	push	a
1880  0340 96            	ldw	x,sp
1881  0341 1c000b        	addw	x,#OFST+0
1882  0344 cd00a7        	call	_ByteToHex
1884  0347 84            	pop	a
1885                     ; 309 	hexstring[0] = temp1[0];
1887  0348 1e0c          	ldw	x,(OFST+1,sp)
1888  034a 7b08          	ld	a,(OFST-3,sp)
1889  034c f7            	ld	(x),a
1890                     ; 310 	hexstring[1] = temp1[1];
1892  034d 7b09          	ld	a,(OFST-2,sp)
1893  034f e701          	ld	(1,x),a
1894                     ; 311 	hexstring[2] = temp2[0];
1896  0351 7b0a          	ld	a,(OFST-1,sp)
1897  0353 e702          	ld	(2,x),a
1898                     ; 312 	hexstring[3] = temp2[1];
1900  0355 7b0b          	ld	a,(OFST+0,sp)
1901  0357 e703          	ld	(3,x),a
1902                     ; 314 }
1905  0359 5b0d          	addw	sp,#13
1906  035b 81            	ret	
2068                     ; 324 void ReadCoilStatus(uint16_t *registers)
2068                     ; 325 {
2069                     	switch	.text
2070  035c               _ReadCoilStatus:
2072  035c 89            	pushw	x
2073  035d 522c          	subw	sp,#44
2074       0000002c      OFST:	set	44
2077                     ; 327 uint8_t counter = 0;
2079                     ; 328 uint8_t TempSum=0;
2081  035f 0f0e          	clr	(OFST-30,sp)
2082                     ; 335 uint16_t n = 0;
2084                     ; 338 for(n = 0; n<OFS; n++){OutputFrame[n] = '\0';}
2086  0361 5f            	clrw	x
2087  0362 1f2a          	ldw	(OFST-2,sp),x
2088  0364               L5401:
2091  0364 96            	ldw	x,sp
2092  0365 1c0011        	addw	x,#OFST-27
2093  0368 72fb2a        	addw	x,(OFST-2,sp)
2094  036b 7f            	clr	(x)
2097  036c 1e2a          	ldw	x,(OFST-2,sp)
2098  036e 5c            	incw	x
2099  036f 1f2a          	ldw	(OFST-2,sp),x
2102  0371 a30019        	cpw	x,#25
2103  0374 25ee          	jrult	L5401
2104                     ; 341 RewritingChars(OutputFrame,0,4);
2106  0376 4b04          	push	#4
2107  0378 4b00          	push	#0
2108  037a 96            	ldw	x,sp
2109  037b 1c0013        	addw	x,#OFST-25
2110  037e cd0161        	call	_RewritingChars
2112  0381 b605          	ld	a,_word+5
2113  0383 85            	popw	x
2114                     ; 344 temp4[0] = word[5];
2116  0384 6b08          	ld	(OFST-36,sp),a
2117                     ; 345 temp4[1] = word[6];
2119  0386 b606          	ld	a,_word+6
2120  0388 6b09          	ld	(OFST-35,sp),a
2121                     ; 346 temp4[2] = word[7];
2123  038a b607          	ld	a,_word+7
2124  038c 6b0a          	ld	(OFST-34,sp),a
2125                     ; 347 temp4[3] = word[8];
2127  038e b608          	ld	a,_word+8
2128  0390 6b0b          	ld	(OFST-33,sp),a
2129                     ; 348 HexToByte_4(temp4, &FirstCoil);
2131  0392 96            	ldw	x,sp
2132  0393 1c0003        	addw	x,#OFST-41
2133  0396 89            	pushw	x
2134  0397 1c0005        	addw	x,#5
2135  039a cd02b3        	call	_HexToByte_4
2137  039d b609          	ld	a,_word+9
2138  039f 85            	popw	x
2139                     ; 351 temp4[0] = word[9];
2141  03a0 6b08          	ld	(OFST-36,sp),a
2142                     ; 352 temp4[1] = word[10];
2144  03a2 b60a          	ld	a,_word+10
2145  03a4 6b09          	ld	(OFST-35,sp),a
2146                     ; 353 temp4[2] = word[11];
2148  03a6 b60b          	ld	a,_word+11
2149  03a8 6b0a          	ld	(OFST-34,sp),a
2150                     ; 354 temp4[3] = word[12];
2152  03aa b60c          	ld	a,_word+12
2153  03ac 6b0b          	ld	(OFST-33,sp),a
2154                     ; 355 HexToByte_4(temp4, &NumberOfCoils);
2156  03ae 96            	ldw	x,sp
2157  03af 1c0005        	addw	x,#OFST-39
2158  03b2 89            	pushw	x
2159  03b3 1c0003        	addw	x,#3
2160  03b6 cd02b3        	call	_HexToByte_4
2162  03b9 85            	popw	x
2163                     ; 358 if((NumberOfCoils%8)!=0)
2165  03ba 7b06          	ld	a,(OFST-38,sp)
2166  03bc a507          	bcp	a,#7
2167  03be 2709          	jreq	L3501
2168                     ; 360 	NumberOfDataBytes = ( NumberOfCoils/8)+1;
2170  03c0 1e05          	ldw	x,(OFST-39,sp)
2171  03c2 54            	srlw	x
2172  03c3 54            	srlw	x
2173  03c4 54            	srlw	x
2174  03c5 01            	rrwa	x,a
2175  03c6 4c            	inc	a
2177  03c7 2006          	jra	L5501
2178  03c9               L3501:
2179                     ; 364 	NumberOfDataBytes = NumberOfCoils/8;
2181  03c9 1e05          	ldw	x,(OFST-39,sp)
2182  03cb 54            	srlw	x
2183  03cc 54            	srlw	x
2184  03cd 54            	srlw	x
2185  03ce 01            	rrwa	x,a
2186  03cf               L5501:
2187  03cf 6b07          	ld	(OFST-37,sp),a
2188                     ; 368 ByteToHex(temp,NumberOfDataBytes);
2190  03d1 88            	push	a
2191  03d2 96            	ldw	x,sp
2192  03d3 1c0010        	addw	x,#OFST-28
2193  03d6 cd00a7        	call	_ByteToHex
2195  03d9 84            	pop	a
2196                     ; 369 OutputFrame[5] = temp[0];
2198  03da 7b0f          	ld	a,(OFST-29,sp)
2199  03dc 6b16          	ld	(OFST-22,sp),a
2200                     ; 370 OutputFrame[6] = temp[1];
2202  03de 7b10          	ld	a,(OFST-28,sp)
2203  03e0 6b17          	ld	(OFST-21,sp),a
2204                     ; 373 counter = 7; 
2206  03e2 a607          	ld	a,#7
2207  03e4 6b2c          	ld	(OFST+0,sp),a
2208                     ; 374 Coil = FirstCoil;
2210  03e6 1e03          	ldw	x,(OFST-41,sp)
2211  03e8 1f0c          	ldw	(OFST-32,sp),x
2212                     ; 375 n = NumberOfCoils;
2214  03ea 1e05          	ldw	x,(OFST-39,sp)
2215  03ec 1f2a          	ldw	(OFST-2,sp),x
2217  03ee cc04b6        	jra	L3601
2218  03f1               L7501:
2219                     ; 378 		if(n>=8)                   //    changing 8bits to hex
2221  03f1 a30008        	cpw	x,#8
2222  03f4 255b          	jrult	L7601
2223                     ; 380 						uint8_t pwr = 0;
2225                     ; 381 						for(pwr =0; pwr<8; pwr++,Coil++)
2227  03f6 0f02          	clr	(OFST-42,sp)
2228  03f8               L1701:
2229                     ; 383 								TempSum += (1<<pwr)*StateOfCoil(Coil, registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
2231  03f8 1e2d          	ldw	x,(OFST+1,sp)
2232  03fa 89            	pushw	x
2233  03fb 7b0f          	ld	a,(OFST-29,sp)
2234  03fd cd01f3        	call	_StateOfCoil
2236  0400 85            	popw	x
2237  0401 6b01          	ld	(OFST-43,sp),a
2238  0403 5f            	clrw	x
2239  0404 7b02          	ld	a,(OFST-42,sp)
2240  0406 97            	ld	xl,a
2241  0407 a601          	ld	a,#1
2242  0409 5d            	tnzw	x
2243  040a 2704          	jreq	L271
2244  040c               L471:
2245  040c 48            	sll	a
2246  040d 5a            	decw	x
2247  040e 26fc          	jrne	L471
2248  0410               L271:
2249  0410 97            	ld	xl,a
2250  0411 7b01          	ld	a,(OFST-43,sp)
2251  0413 42            	mul	x,a
2252  0414 9f            	ld	a,xl
2253  0415 1b0e          	add	a,(OFST-30,sp)
2254  0417 6b0e          	ld	(OFST-30,sp),a
2255                     ; 384 								n--;
2257  0419 1e2a          	ldw	x,(OFST-2,sp)
2258  041b 5a            	decw	x
2259  041c 1f2a          	ldw	(OFST-2,sp),x
2260                     ; 381 						for(pwr =0; pwr<8; pwr++,Coil++)
2262  041e 0c02          	inc	(OFST-42,sp)
2263  0420 1e0c          	ldw	x,(OFST-32,sp)
2264  0422 5c            	incw	x
2265  0423 1f0c          	ldw	(OFST-32,sp),x
2268  0425 7b02          	ld	a,(OFST-42,sp)
2269  0427 a108          	cp	a,#8
2270  0429 25cd          	jrult	L1701
2271                     ; 387 						ByteToHex(temp,TempSum);
2273  042b 7b0e          	ld	a,(OFST-30,sp)
2274  042d 88            	push	a
2275  042e 96            	ldw	x,sp
2276  042f 1c0010        	addw	x,#OFST-28
2277  0432 cd00a7        	call	_ByteToHex
2279  0435 84            	pop	a
2280                     ; 388 						TempSum = 0;
2282  0436 0f0e          	clr	(OFST-30,sp)
2283                     ; 389 						OutputFrame[counter] = temp[0];
2285  0438 96            	ldw	x,sp
2286  0439 cd051d        	call	LC003
2287  043c 1b2c          	add	a,(OFST+0,sp)
2288  043e 2401          	jrnc	L002
2289  0440 5c            	incw	x
2290  0441               L002:
2291  0441 02            	rlwa	x,a
2292  0442 7b0f          	ld	a,(OFST-29,sp)
2293  0444 f7            	ld	(x),a
2294                     ; 390 						counter++;
2296                     ; 391 						OutputFrame[counter] = temp[1];
2298  0445 96            	ldw	x,sp
2299  0446 0c2c          	inc	(OFST+0,sp)
2300  0448 cd051d        	call	LC003
2301  044b 1b2c          	add	a,(OFST+0,sp)
2302  044d 2461          	jrnc	L612
2303                     ; 392 						counter++;
2305  044f 205e          	jp	LC002
2306  0451               L7601:
2307                     ; 397 						uint8_t pwr = 0;
2309                     ; 398 						uint8_t zm = n;
2311  0451 7b2b          	ld	a,(OFST-1,sp)
2312  0453 6b07          	ld	(OFST-37,sp),a
2313                     ; 399 						for(pwr =0; pwr<zm; pwr++,Coil++)
2315  0455 0f02          	clr	(OFST-42,sp)
2317  0457 202d          	jra	L5011
2318  0459               L1011:
2319                     ; 401 								TempSum += (1<<pwr)*StateOfCoil(Coil, registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
2321  0459 1e2d          	ldw	x,(OFST+1,sp)
2322  045b 89            	pushw	x
2323  045c 7b0f          	ld	a,(OFST-29,sp)
2324  045e cd01f3        	call	_StateOfCoil
2326  0461 85            	popw	x
2327  0462 6b01          	ld	(OFST-43,sp),a
2328  0464 5f            	clrw	x
2329  0465 7b02          	ld	a,(OFST-42,sp)
2330  0467 97            	ld	xl,a
2331  0468 a601          	ld	a,#1
2332  046a 5d            	tnzw	x
2333  046b 2704          	jreq	L602
2334  046d               L012:
2335  046d 48            	sll	a
2336  046e 5a            	decw	x
2337  046f 26fc          	jrne	L012
2338  0471               L602:
2339  0471 97            	ld	xl,a
2340  0472 7b01          	ld	a,(OFST-43,sp)
2341  0474 42            	mul	x,a
2342  0475 9f            	ld	a,xl
2343  0476 1b0e          	add	a,(OFST-30,sp)
2344  0478 6b0e          	ld	(OFST-30,sp),a
2345                     ; 402 								n--;
2347  047a 1e2a          	ldw	x,(OFST-2,sp)
2348  047c 5a            	decw	x
2349  047d 1f2a          	ldw	(OFST-2,sp),x
2350                     ; 399 						for(pwr =0; pwr<zm; pwr++,Coil++)
2352  047f 0c02          	inc	(OFST-42,sp)
2353  0481 1e0c          	ldw	x,(OFST-32,sp)
2354  0483 5c            	incw	x
2355  0484 1f0c          	ldw	(OFST-32,sp),x
2356  0486               L5011:
2359  0486 7b02          	ld	a,(OFST-42,sp)
2360  0488 1107          	cp	a,(OFST-37,sp)
2361  048a 25cd          	jrult	L1011
2362                     ; 404 						ByteToHex(temp,TempSum);
2364  048c 7b0e          	ld	a,(OFST-30,sp)
2365  048e 88            	push	a
2366  048f 96            	ldw	x,sp
2367  0490 1c0010        	addw	x,#OFST-28
2368  0493 cd00a7        	call	_ByteToHex
2370  0496 84            	pop	a
2371                     ; 405 						TempSum = 0;
2373  0497 0f0e          	clr	(OFST-30,sp)
2374                     ; 406 						OutputFrame[counter] = temp[0];
2376  0499 96            	ldw	x,sp
2377  049a cd051d        	call	LC003
2378  049d 1b2c          	add	a,(OFST+0,sp)
2379  049f 2401          	jrnc	L412
2380  04a1 5c            	incw	x
2381  04a2               L412:
2382  04a2 02            	rlwa	x,a
2383  04a3 7b0f          	ld	a,(OFST-29,sp)
2384  04a5 f7            	ld	(x),a
2385                     ; 407 						counter++;
2387                     ; 408 						OutputFrame[counter] = temp[1];
2389  04a6 96            	ldw	x,sp
2390  04a7 0c2c          	inc	(OFST+0,sp)
2391  04a9 ad72          	call	LC003
2392  04ab 1b2c          	add	a,(OFST+0,sp)
2393  04ad 2401          	jrnc	L612
2394  04af               LC002:
2395  04af 5c            	incw	x
2396  04b0               L612:
2397                     ; 409 						counter++;
2399  04b0 02            	rlwa	x,a
2400  04b1 7b10          	ld	a,(OFST-28,sp)
2401  04b3 f7            	ld	(x),a
2403  04b4 0c2c          	inc	(OFST+0,sp)
2404  04b6               L3601:
2405                     ; 376 while(n>0)
2407  04b6 1e2a          	ldw	x,(OFST-2,sp)
2408  04b8 2703cc03f1    	jrne	L7501
2409                     ; 414 ByteToHex(temp,GetLRC(OutputFrame));
2411  04bd 96            	ldw	x,sp
2412  04be 1c0011        	addw	x,#OFST-27
2413  04c1 cd0282        	call	_GetLRC
2415  04c4 88            	push	a
2416  04c5 96            	ldw	x,sp
2417  04c6 1c0010        	addw	x,#OFST-28
2418  04c9 cd00a7        	call	_ByteToHex
2420  04cc 84            	pop	a
2421                     ; 415 OutputFrame[counter] = temp[0];
2423  04cd 96            	ldw	x,sp
2424  04ce ad4d          	call	LC003
2425  04d0 1b2c          	add	a,(OFST+0,sp)
2426  04d2 2401          	jrnc	L422
2427  04d4 5c            	incw	x
2428  04d5               L422:
2429  04d5 02            	rlwa	x,a
2430  04d6 7b0f          	ld	a,(OFST-29,sp)
2431  04d8 f7            	ld	(x),a
2432                     ; 416 counter++;
2434                     ; 417 OutputFrame[counter] = temp[1];
2436  04d9 96            	ldw	x,sp
2437  04da 0c2c          	inc	(OFST+0,sp)
2438  04dc ad3f          	call	LC003
2439  04de 1b2c          	add	a,(OFST+0,sp)
2440  04e0 2401          	jrnc	L622
2441  04e2 5c            	incw	x
2442  04e3               L622:
2443  04e3 02            	rlwa	x,a
2444  04e4 7b10          	ld	a,(OFST-28,sp)
2445  04e6 f7            	ld	(x),a
2446                     ; 418 counter++;
2448                     ; 419 OutputFrame[counter] = 0x0D;
2450  04e7 96            	ldw	x,sp
2451  04e8 0c2c          	inc	(OFST+0,sp)
2452  04ea ad31          	call	LC003
2453  04ec 1b2c          	add	a,(OFST+0,sp)
2454  04ee 2401          	jrnc	L032
2455  04f0 5c            	incw	x
2456  04f1               L032:
2457  04f1 02            	rlwa	x,a
2458  04f2 a60d          	ld	a,#13
2459  04f4 f7            	ld	(x),a
2460                     ; 420 counter++;
2462                     ; 421 OutputFrame[counter] = 0x0A;
2464  04f5 96            	ldw	x,sp
2465  04f6 0c2c          	inc	(OFST+0,sp)
2466  04f8 ad23          	call	LC003
2467  04fa 1b2c          	add	a,(OFST+0,sp)
2468  04fc 2401          	jrnc	L232
2469  04fe 5c            	incw	x
2470  04ff               L232:
2471  04ff 02            	rlwa	x,a
2472  0500 a60a          	ld	a,#10
2473  0502 f7            	ld	(x),a
2474                     ; 422 counter++;
2476                     ; 423 OutputFrame[counter] = 0x0A;
2478  0503 96            	ldw	x,sp
2479  0504 0c2c          	inc	(OFST+0,sp)
2480  0506 ad15          	call	LC003
2481  0508 1b2c          	add	a,(OFST+0,sp)
2482  050a 2401          	jrnc	L432
2483  050c 5c            	incw	x
2484  050d               L432:
2485  050d 02            	rlwa	x,a
2486  050e a60a          	ld	a,#10
2487  0510 f7            	ld	(x),a
2488                     ; 424 counter++;
2490                     ; 427 	UART_SendStr(OutputFrame); 
2492  0511 96            	ldw	x,sp
2493  0512 0c2c          	inc	(OFST+0,sp)
2494  0514 1c0011        	addw	x,#OFST-27
2495  0517 cd0000        	call	_UART_SendStr
2497                     ; 428 }
2500  051a 5b2e          	addw	sp,#46
2501  051c 81            	ret	
2502  051d               LC003:
2503  051d 1c0011        	addw	x,#OFST-27
2504  0520 9f            	ld	a,xl
2505  0521 5e            	swapw	x
2506  0522 81            	ret	
2531                     ; 432 void ReadInputStatus(void)
2531                     ; 433 {
2532                     	switch	.text
2533  0523               _ReadInputStatus:
2537                     ; 434 ReadCoilStatus(Input_Registers);
2539  0523 ae0000        	ldw	x,#_Input_Registers
2541                     ; 435 }
2544  0526 cc035c        	jp	_ReadCoilStatus
2681                     ; 439 void ReadHoldingRegisters(uint16_t *registers)
2681                     ; 440 {
2682                     	switch	.text
2683  0529               _ReadHoldingRegisters:
2685  0529 89            	pushw	x
2686  052a 5228          	subw	sp,#40
2687       00000028      OFST:	set	40
2690                     ; 445 uint16_t FirstReg = 0;
2692  052c 5f            	clrw	x
2693  052d 1f01          	ldw	(OFST-39,sp),x
2694                     ; 446 uint16_t NumberOfRegs = 0;
2696  052f 1f05          	ldw	(OFST-35,sp),x
2697                     ; 447 uint8_t NumberOfBytes = 0 ;
2699                     ; 448 uint8_t ct = 0;
2701                     ; 449 uint8_t k = 0;
2703                     ; 450 uint8_t counter = 0;
2705                     ; 451 uint16_t Content_dec = 0;
2707                     ; 455 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
2709  0531 0f0a          	clr	(OFST-30,sp)
2710  0533               L7021:
2713  0533 96            	ldw	x,sp
2714  0534 cd066c        	call	LC004
2715  0537 1b0a          	add	a,(OFST-30,sp)
2716  0539 2401          	jrnc	L642
2717  053b 5c            	incw	x
2718  053c               L642:
2719  053c 02            	rlwa	x,a
2720  053d 7f            	clr	(x)
2723  053e 0c0a          	inc	(OFST-30,sp)
2726  0540 7b0a          	ld	a,(OFST-30,sp)
2727  0542 a119          	cp	a,#25
2728  0544 25ed          	jrult	L7021
2729                     ; 458 RewritingChars(OutputFrame,0,4);
2731  0546 4b04          	push	#4
2732  0548 4b00          	push	#0
2733  054a 96            	ldw	x,sp
2734  054b 1c000d        	addw	x,#OFST-27
2735  054e cd0161        	call	_RewritingChars
2737  0551 b605          	ld	a,_word+5
2738  0553 85            	popw	x
2739                     ; 461 temp[0] = word[5];
2741  0554 6b24          	ld	(OFST-4,sp),a
2742                     ; 462 temp[1] = word[6];
2744  0556 b606          	ld	a,_word+6
2745  0558 6b25          	ld	(OFST-3,sp),a
2746                     ; 463 temp[2] = word[7];
2748  055a b607          	ld	a,_word+7
2749  055c 6b26          	ld	(OFST-2,sp),a
2750                     ; 464 temp[3] = word[8];
2752  055e b608          	ld	a,_word+8
2753  0560 6b27          	ld	(OFST-1,sp),a
2754                     ; 465 HexToByte_4(temp, &FirstReg);
2756  0562 96            	ldw	x,sp
2757  0563 5c            	incw	x
2758  0564 89            	pushw	x
2759  0565 1c0023        	addw	x,#35
2760  0568 cd02b3        	call	_HexToByte_4
2762  056b b609          	ld	a,_word+9
2763  056d 85            	popw	x
2764                     ; 468 temp[0] = word[9];
2766  056e 6b24          	ld	(OFST-4,sp),a
2767                     ; 469 temp[1] = word[10];
2769  0570 b60a          	ld	a,_word+10
2770  0572 6b25          	ld	(OFST-3,sp),a
2771                     ; 470 temp[2] = word[11];
2773  0574 b60b          	ld	a,_word+11
2774  0576 6b26          	ld	(OFST-2,sp),a
2775                     ; 471 temp[3] = word[12];
2777  0578 b60c          	ld	a,_word+12
2778  057a 6b27          	ld	(OFST-1,sp),a
2779                     ; 472 HexToByte_4(temp, &NumberOfRegs);
2781  057c 96            	ldw	x,sp
2782  057d 1c0005        	addw	x,#OFST-35
2783  0580 89            	pushw	x
2784  0581 1c001f        	addw	x,#31
2785  0584 cd02b3        	call	_HexToByte_4
2787  0587 85            	popw	x
2788                     ; 475 NumberOfBytes = NumberOfRegs*2;
2790  0588 7b06          	ld	a,(OFST-34,sp)
2791  058a 48            	sll	a
2792  058b 6b09          	ld	(OFST-31,sp),a
2793                     ; 478 ByteToHex(temp,NumberOfBytes);
2795  058d 88            	push	a
2796  058e 96            	ldw	x,sp
2797  058f 1c0025        	addw	x,#OFST-3
2798  0592 cd00a7        	call	_ByteToHex
2800  0595 84            	pop	a
2801                     ; 479 OutputFrame[5] = temp[0];
2803  0596 7b24          	ld	a,(OFST-4,sp)
2804  0598 6b10          	ld	(OFST-24,sp),a
2805                     ; 480 OutputFrame[6] = temp[1];
2807  059a 7b25          	ld	a,(OFST-3,sp)
2808  059c 6b11          	ld	(OFST-23,sp),a
2809                     ; 482 counter = 7;
2811  059e a607          	ld	a,#7
2812  05a0 6b28          	ld	(OFST+0,sp),a
2813                     ; 483 k = FirstReg;
2815  05a2 7b02          	ld	a,(OFST-38,sp)
2816  05a4 6b0a          	ld	(OFST-30,sp),a
2817                     ; 485 Output_Registers[1] = 65535;
2819  05a6 aeffff        	ldw	x,#65535
2820  05a9 bf02          	ldw	_Output_Registers+2,x
2821                     ; 486 Output_Registers[2] = 65535;
2823  05ab bf04          	ldw	_Output_Registers+4,x
2824                     ; 489 for(ct=0;ct<NumberOfRegs;ct++)
2826  05ad 0f09          	clr	(OFST-31,sp)
2828  05af 2053          	jra	L1221
2829  05b1               L5121:
2830                     ; 491 		Content_dec = registers[k];
2832  05b1 7b0a          	ld	a,(OFST-30,sp)
2833  05b3 5f            	clrw	x
2834  05b4 97            	ld	xl,a
2835  05b5 58            	sllw	x
2836  05b6 72fb29        	addw	x,(OFST+1,sp)
2837  05b9 fe            	ldw	x,(x)
2838  05ba 1f07          	ldw	(OFST-33,sp),x
2839                     ; 492 		ByteToHex_4(temp,Content_dec);
2841  05bc 89            	pushw	x
2842  05bd 96            	ldw	x,sp
2843  05be 1c0026        	addw	x,#OFST-2
2844  05c1 cd0311        	call	_ByteToHex_4
2846  05c4 85            	popw	x
2847                     ; 493 		OutputFrame[counter] = temp[0];
2849  05c5 96            	ldw	x,sp
2850  05c6 cd066c        	call	LC004
2851  05c9 1b28          	add	a,(OFST+0,sp)
2852  05cb 2401          	jrnc	L262
2853  05cd 5c            	incw	x
2854  05ce               L262:
2855  05ce 02            	rlwa	x,a
2856  05cf 7b24          	ld	a,(OFST-4,sp)
2857  05d1 f7            	ld	(x),a
2858                     ; 494 		counter++;
2860                     ; 495 		OutputFrame[counter] = temp[1];
2862  05d2 96            	ldw	x,sp
2863  05d3 0c28          	inc	(OFST+0,sp)
2864  05d5 cd066c        	call	LC004
2865  05d8 1b28          	add	a,(OFST+0,sp)
2866  05da 2401          	jrnc	L462
2867  05dc 5c            	incw	x
2868  05dd               L462:
2869  05dd 02            	rlwa	x,a
2870  05de 7b25          	ld	a,(OFST-3,sp)
2871  05e0 f7            	ld	(x),a
2872                     ; 496 		counter++;
2874                     ; 497 		OutputFrame[counter] = temp[2];
2876  05e1 96            	ldw	x,sp
2877  05e2 0c28          	inc	(OFST+0,sp)
2878  05e4 cd066c        	call	LC004
2879  05e7 1b28          	add	a,(OFST+0,sp)
2880  05e9 2401          	jrnc	L662
2881  05eb 5c            	incw	x
2882  05ec               L662:
2883  05ec 02            	rlwa	x,a
2884  05ed 7b26          	ld	a,(OFST-2,sp)
2885  05ef f7            	ld	(x),a
2886                     ; 498 		counter++;
2888                     ; 499 		OutputFrame[counter] = temp[3];
2890  05f0 96            	ldw	x,sp
2891  05f1 0c28          	inc	(OFST+0,sp)
2892  05f3 ad77          	call	LC004
2893  05f5 1b28          	add	a,(OFST+0,sp)
2894  05f7 2401          	jrnc	L072
2895  05f9 5c            	incw	x
2896  05fa               L072:
2897  05fa 02            	rlwa	x,a
2898  05fb 7b27          	ld	a,(OFST-1,sp)
2899  05fd f7            	ld	(x),a
2900                     ; 500 		counter++;
2902  05fe 0c28          	inc	(OFST+0,sp)
2903                     ; 501 		k++;
2905  0600 0c0a          	inc	(OFST-30,sp)
2906                     ; 489 for(ct=0;ct<NumberOfRegs;ct++)
2908  0602 0c09          	inc	(OFST-31,sp)
2909  0604               L1221:
2912  0604 7b09          	ld	a,(OFST-31,sp)
2913  0606 5f            	clrw	x
2914  0607 97            	ld	xl,a
2915  0608 1305          	cpw	x,(OFST-35,sp)
2916  060a 25a5          	jrult	L5121
2917                     ; 506 ByteToHex(temp2,GetLRC(OutputFrame));
2919  060c 96            	ldw	x,sp
2920  060d 1c000b        	addw	x,#OFST-29
2921  0610 cd0282        	call	_GetLRC
2923  0613 88            	push	a
2924  0614 96            	ldw	x,sp
2925  0615 1c0004        	addw	x,#OFST-36
2926  0618 cd00a7        	call	_ByteToHex
2928  061b 84            	pop	a
2929                     ; 507 OutputFrame[counter] = temp2[0];
2931  061c 96            	ldw	x,sp
2932  061d ad4d          	call	LC004
2933  061f 1b28          	add	a,(OFST+0,sp)
2934  0621 2401          	jrnc	L672
2935  0623 5c            	incw	x
2936  0624               L672:
2937  0624 02            	rlwa	x,a
2938  0625 7b03          	ld	a,(OFST-37,sp)
2939  0627 f7            	ld	(x),a
2940                     ; 508 counter++;
2942                     ; 509 OutputFrame[counter] = temp2[1];
2944  0628 96            	ldw	x,sp
2945  0629 0c28          	inc	(OFST+0,sp)
2946  062b ad3f          	call	LC004
2947  062d 1b28          	add	a,(OFST+0,sp)
2948  062f 2401          	jrnc	L003
2949  0631 5c            	incw	x
2950  0632               L003:
2951  0632 02            	rlwa	x,a
2952  0633 7b04          	ld	a,(OFST-36,sp)
2953  0635 f7            	ld	(x),a
2954                     ; 510 counter++;
2956                     ; 511 OutputFrame[counter] = 0x0D;
2958  0636 96            	ldw	x,sp
2959  0637 0c28          	inc	(OFST+0,sp)
2960  0639 ad31          	call	LC004
2961  063b 1b28          	add	a,(OFST+0,sp)
2962  063d 2401          	jrnc	L203
2963  063f 5c            	incw	x
2964  0640               L203:
2965  0640 02            	rlwa	x,a
2966  0641 a60d          	ld	a,#13
2967  0643 f7            	ld	(x),a
2968                     ; 512 counter++;
2970                     ; 513 OutputFrame[counter] = 0x0A;
2972  0644 96            	ldw	x,sp
2973  0645 0c28          	inc	(OFST+0,sp)
2974  0647 ad23          	call	LC004
2975  0649 1b28          	add	a,(OFST+0,sp)
2976  064b 2401          	jrnc	L403
2977  064d 5c            	incw	x
2978  064e               L403:
2979  064e 02            	rlwa	x,a
2980  064f a60a          	ld	a,#10
2981  0651 f7            	ld	(x),a
2982                     ; 514 counter++;
2984                     ; 515 OutputFrame[counter] = 0x0A;
2986  0652 96            	ldw	x,sp
2987  0653 0c28          	inc	(OFST+0,sp)
2988  0655 ad15          	call	LC004
2989  0657 1b28          	add	a,(OFST+0,sp)
2990  0659 2401          	jrnc	L603
2991  065b 5c            	incw	x
2992  065c               L603:
2993  065c 02            	rlwa	x,a
2994  065d a60a          	ld	a,#10
2995  065f f7            	ld	(x),a
2996                     ; 516 counter++;
2998                     ; 520 UART_SendStr(OutputFrame); 
3000  0660 96            	ldw	x,sp
3001  0661 0c28          	inc	(OFST+0,sp)
3002  0663 1c000b        	addw	x,#OFST-29
3003  0666 cd0000        	call	_UART_SendStr
3005                     ; 522 }
3008  0669 5b2a          	addw	sp,#42
3009  066b 81            	ret	
3010  066c               LC004:
3011  066c 1c000b        	addw	x,#OFST-29
3012  066f 9f            	ld	a,xl
3013  0670 5e            	swapw	x
3014  0671 81            	ret	
3039                     ; 525 void ReadInputRegisters(void)
3039                     ; 526 {
3040                     	switch	.text
3041  0672               _ReadInputRegisters:
3045                     ; 528 ReadHoldingRegisters(Input_Registers);
3047  0672 ae0000        	ldw	x,#_Input_Registers
3049                     ; 529 }
3052  0675 cc0529        	jp	_ReadHoldingRegisters
3142                     ; 533 void ForceSingleCoil(void)
3142                     ; 534 {
3143                     	switch	.text
3144  0678               _ForceSingleCoil:
3146  0678 5224          	subw	sp,#36
3147       00000024      OFST:	set	36
3150                     ; 539 uint16_t Coil = 0;
3152  067a 5f            	clrw	x
3153  067b 1f01          	ldw	(OFST-35,sp),x
3154                     ; 540 uint16_t StatusToWrite = 0;
3156  067d 1f03          	ldw	(OFST-33,sp),x
3157                     ; 541 uint8_t k = 0;
3159                     ; 544 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
3161  067f 0f24          	clr	(OFST+0,sp)
3162  0681               L7721:
3165  0681 96            	ldw	x,sp
3166  0682 cd074b        	call	LC005
3167  0685 1b24          	add	a,(OFST+0,sp)
3168  0687 2401          	jrnc	L023
3169  0689 5c            	incw	x
3170  068a               L023:
3171  068a 02            	rlwa	x,a
3172  068b 7f            	clr	(x)
3175  068c 0c24          	inc	(OFST+0,sp)
3178  068e 7b24          	ld	a,(OFST+0,sp)
3179  0690 a119          	cp	a,#25
3180  0692 25ed          	jrult	L7721
3181                     ; 547 RewritingChars(OutputFrame,0,12);
3183  0694 4b0c          	push	#12
3184  0696 4b00          	push	#0
3185  0698 96            	ldw	x,sp
3186  0699 1c000d        	addw	x,#OFST-23
3187  069c cd0161        	call	_RewritingChars
3189  069f b605          	ld	a,_word+5
3190  06a1 85            	popw	x
3191                     ; 551 temp4[0] = word[5];
3193  06a2 6b07          	ld	(OFST-29,sp),a
3194                     ; 552 temp4[1] = word[6];
3196  06a4 b606          	ld	a,_word+6
3197  06a6 6b08          	ld	(OFST-28,sp),a
3198                     ; 553 temp4[2] = word[7];
3200  06a8 b607          	ld	a,_word+7
3201  06aa 6b09          	ld	(OFST-27,sp),a
3202                     ; 554 temp4[3] = word[8];
3204  06ac b608          	ld	a,_word+8
3205  06ae 6b0a          	ld	(OFST-26,sp),a
3206                     ; 555 HexToByte_4(temp4, &Coil);
3208  06b0 96            	ldw	x,sp
3209  06b1 5c            	incw	x
3210  06b2 89            	pushw	x
3211  06b3 1c0006        	addw	x,#6
3212  06b6 cd02b3        	call	_HexToByte_4
3214  06b9 b609          	ld	a,_word+9
3215  06bb 85            	popw	x
3216                     ; 558 temp4[0] = word[9];
3218  06bc 6b07          	ld	(OFST-29,sp),a
3219                     ; 559 temp4[1] = word[10];
3221  06be b60a          	ld	a,_word+10
3222  06c0 6b08          	ld	(OFST-28,sp),a
3223                     ; 560 temp4[2] = word[11];
3225  06c2 b60b          	ld	a,_word+11
3226  06c4 6b09          	ld	(OFST-27,sp),a
3227                     ; 561 temp4[3] = word[12];
3229  06c6 b60c          	ld	a,_word+12
3230  06c8 6b0a          	ld	(OFST-26,sp),a
3231                     ; 562 HexToByte_4(temp4, &StatusToWrite);
3233  06ca 96            	ldw	x,sp
3234  06cb 1c0003        	addw	x,#OFST-33
3235  06ce 89            	pushw	x
3236  06cf 1c0004        	addw	x,#4
3237  06d2 cd02b3        	call	_HexToByte_4
3239  06d5 85            	popw	x
3240                     ; 565 SetSingleCoil( &Coil,  &StatusToWrite, Output_Registers);
3242  06d6 ae0000        	ldw	x,#_Output_Registers
3243  06d9 89            	pushw	x
3244  06da 96            	ldw	x,sp
3245  06db 1c0005        	addw	x,#OFST-31
3246  06de 89            	pushw	x
3247  06df 1d0002        	subw	x,#2
3248  06e2 cd0183        	call	_SetSingleCoil
3250  06e5 5b04          	addw	sp,#4
3251                     ; 568 k = 13;
3253  06e7 a60d          	ld	a,#13
3254  06e9 6b24          	ld	(OFST+0,sp),a
3255                     ; 569 ByteToHex(temp2,GetLRC(OutputFrame));
3257  06eb 96            	ldw	x,sp
3258  06ec 1c000b        	addw	x,#OFST-25
3259  06ef cd0282        	call	_GetLRC
3261  06f2 88            	push	a
3262  06f3 96            	ldw	x,sp
3263  06f4 1c0006        	addw	x,#OFST-30
3264  06f7 cd00a7        	call	_ByteToHex
3266  06fa 84            	pop	a
3267                     ; 570 OutputFrame[k] = temp2[0];
3269  06fb 96            	ldw	x,sp
3270  06fc ad4d          	call	LC005
3271  06fe 1b24          	add	a,(OFST+0,sp)
3272  0700 2401          	jrnc	L633
3273  0702 5c            	incw	x
3274  0703               L633:
3275  0703 02            	rlwa	x,a
3276  0704 7b05          	ld	a,(OFST-31,sp)
3277  0706 f7            	ld	(x),a
3278                     ; 571 k++;
3280                     ; 572 OutputFrame[k] = temp2[1];
3282  0707 96            	ldw	x,sp
3283  0708 0c24          	inc	(OFST+0,sp)
3284  070a ad3f          	call	LC005
3285  070c 1b24          	add	a,(OFST+0,sp)
3286  070e 2401          	jrnc	L043
3287  0710 5c            	incw	x
3288  0711               L043:
3289  0711 02            	rlwa	x,a
3290  0712 7b06          	ld	a,(OFST-30,sp)
3291  0714 f7            	ld	(x),a
3292                     ; 573 k++;
3294                     ; 574 OutputFrame[k] = 0x0D;
3296  0715 96            	ldw	x,sp
3297  0716 0c24          	inc	(OFST+0,sp)
3298  0718 ad31          	call	LC005
3299  071a 1b24          	add	a,(OFST+0,sp)
3300  071c 2401          	jrnc	L243
3301  071e 5c            	incw	x
3302  071f               L243:
3303  071f 02            	rlwa	x,a
3304  0720 a60d          	ld	a,#13
3305  0722 f7            	ld	(x),a
3306                     ; 575 k++;
3308                     ; 576 OutputFrame[k] = 0x0A;
3310  0723 96            	ldw	x,sp
3311  0724 0c24          	inc	(OFST+0,sp)
3312  0726 ad23          	call	LC005
3313  0728 1b24          	add	a,(OFST+0,sp)
3314  072a 2401          	jrnc	L443
3315  072c 5c            	incw	x
3316  072d               L443:
3317  072d 02            	rlwa	x,a
3318  072e a60a          	ld	a,#10
3319  0730 f7            	ld	(x),a
3320                     ; 577 k++;
3322                     ; 578 OutputFrame[k] = 0x0A;
3324  0731 96            	ldw	x,sp
3325  0732 0c24          	inc	(OFST+0,sp)
3326  0734 ad15          	call	LC005
3327  0736 1b24          	add	a,(OFST+0,sp)
3328  0738 2401          	jrnc	L643
3329  073a 5c            	incw	x
3330  073b               L643:
3331  073b 02            	rlwa	x,a
3332  073c a60a          	ld	a,#10
3333  073e f7            	ld	(x),a
3334                     ; 579 k++;
3336                     ; 582 UART_SendStr(OutputFrame); 
3338  073f 96            	ldw	x,sp
3339  0740 0c24          	inc	(OFST+0,sp)
3340  0742 1c000b        	addw	x,#OFST-25
3341  0745 cd0000        	call	_UART_SendStr
3343                     ; 583 }
3346  0748 5b24          	addw	sp,#36
3347  074a 81            	ret	
3348  074b               LC005:
3349  074b 1c000b        	addw	x,#OFST-25
3350  074e 9f            	ld	a,xl
3351  074f 5e            	swapw	x
3352  0750 81            	ret	
3442                     ; 589 void PresetSingleRegister(void)
3442                     ; 590 {
3443                     	switch	.text
3444  0751               _PresetSingleRegister:
3446  0751 5224          	subw	sp,#36
3447       00000024      OFST:	set	36
3450                     ; 595 uint16_t Register = 0;
3452  0753 5f            	clrw	x
3453  0754 1f01          	ldw	(OFST-35,sp),x
3454                     ; 596 uint16_t ValueToWrite = 0;
3456  0756 1f03          	ldw	(OFST-33,sp),x
3457                     ; 597 uint8_t k = 0;
3459                     ; 600 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
3461  0758 0f24          	clr	(OFST+0,sp)
3462  075a               L7431:
3465  075a 96            	ldw	x,sp
3466  075b cd081a        	call	LC006
3467  075e 1b24          	add	a,(OFST+0,sp)
3468  0760 2401          	jrnc	L453
3469  0762 5c            	incw	x
3470  0763               L453:
3471  0763 02            	rlwa	x,a
3472  0764 7f            	clr	(x)
3475  0765 0c24          	inc	(OFST+0,sp)
3478  0767 7b24          	ld	a,(OFST+0,sp)
3479  0769 a119          	cp	a,#25
3480  076b 25ed          	jrult	L7431
3481                     ; 603 RewritingChars(OutputFrame,0,12);
3483  076d 4b0c          	push	#12
3484  076f 4b00          	push	#0
3485  0771 96            	ldw	x,sp
3486  0772 1c000d        	addw	x,#OFST-23
3487  0775 cd0161        	call	_RewritingChars
3489  0778 b605          	ld	a,_word+5
3490  077a 85            	popw	x
3491                     ; 607 temp4[0] = word[5];
3493  077b 6b07          	ld	(OFST-29,sp),a
3494                     ; 608 temp4[1] = word[6];
3496  077d b606          	ld	a,_word+6
3497  077f 6b08          	ld	(OFST-28,sp),a
3498                     ; 609 temp4[2] = word[7];
3500  0781 b607          	ld	a,_word+7
3501  0783 6b09          	ld	(OFST-27,sp),a
3502                     ; 610 temp4[3] = word[8];
3504  0785 b608          	ld	a,_word+8
3505  0787 6b0a          	ld	(OFST-26,sp),a
3506                     ; 611 HexToByte_4(temp4, &Register);
3508  0789 96            	ldw	x,sp
3509  078a 5c            	incw	x
3510  078b 89            	pushw	x
3511  078c 1c0006        	addw	x,#6
3512  078f cd02b3        	call	_HexToByte_4
3514  0792 b609          	ld	a,_word+9
3515  0794 85            	popw	x
3516                     ; 614 temp4[0] = word[9];
3518  0795 6b07          	ld	(OFST-29,sp),a
3519                     ; 615 temp4[1] = word[10];
3521  0797 b60a          	ld	a,_word+10
3522  0799 6b08          	ld	(OFST-28,sp),a
3523                     ; 616 temp4[2] = word[11];
3525  079b b60b          	ld	a,_word+11
3526  079d 6b09          	ld	(OFST-27,sp),a
3527                     ; 617 temp4[3] = word[12];
3529  079f b60c          	ld	a,_word+12
3530  07a1 6b0a          	ld	(OFST-26,sp),a
3531                     ; 618 HexToByte_4(temp4, &ValueToWrite);
3533  07a3 96            	ldw	x,sp
3534  07a4 1c0003        	addw	x,#OFST-33
3535  07a7 89            	pushw	x
3536  07a8 1c0004        	addw	x,#4
3537  07ab cd02b3        	call	_HexToByte_4
3539  07ae 85            	popw	x
3540                     ; 621 Output_Registers[Register] = ValueToWrite;
3542  07af 1e01          	ldw	x,(OFST-35,sp)
3543  07b1 58            	sllw	x
3544  07b2 1603          	ldw	y,(OFST-33,sp)
3545  07b4 ef00          	ldw	(_Output_Registers,x),y
3546                     ; 624 k = 13;
3548  07b6 a60d          	ld	a,#13
3549  07b8 6b24          	ld	(OFST+0,sp),a
3550                     ; 625 ByteToHex(temp2,GetLRC(OutputFrame));
3552  07ba 96            	ldw	x,sp
3553  07bb 1c000b        	addw	x,#OFST-25
3554  07be cd0282        	call	_GetLRC
3556  07c1 88            	push	a
3557  07c2 96            	ldw	x,sp
3558  07c3 1c0006        	addw	x,#OFST-30
3559  07c6 cd00a7        	call	_ByteToHex
3561  07c9 84            	pop	a
3562                     ; 626 OutputFrame[k] = temp2[0];
3564  07ca 96            	ldw	x,sp
3565  07cb ad4d          	call	LC006
3566  07cd 1b24          	add	a,(OFST+0,sp)
3567  07cf 2401          	jrnc	L073
3568  07d1 5c            	incw	x
3569  07d2               L073:
3570  07d2 02            	rlwa	x,a
3571  07d3 7b05          	ld	a,(OFST-31,sp)
3572  07d5 f7            	ld	(x),a
3573                     ; 627 k++;
3575                     ; 628 OutputFrame[k] = temp2[1];
3577  07d6 96            	ldw	x,sp
3578  07d7 0c24          	inc	(OFST+0,sp)
3579  07d9 ad3f          	call	LC006
3580  07db 1b24          	add	a,(OFST+0,sp)
3581  07dd 2401          	jrnc	L273
3582  07df 5c            	incw	x
3583  07e0               L273:
3584  07e0 02            	rlwa	x,a
3585  07e1 7b06          	ld	a,(OFST-30,sp)
3586  07e3 f7            	ld	(x),a
3587                     ; 629 k++;
3589                     ; 630 OutputFrame[k] = 0x0D;
3591  07e4 96            	ldw	x,sp
3592  07e5 0c24          	inc	(OFST+0,sp)
3593  07e7 ad31          	call	LC006
3594  07e9 1b24          	add	a,(OFST+0,sp)
3595  07eb 2401          	jrnc	L473
3596  07ed 5c            	incw	x
3597  07ee               L473:
3598  07ee 02            	rlwa	x,a
3599  07ef a60d          	ld	a,#13
3600  07f1 f7            	ld	(x),a
3601                     ; 631 k++;
3603                     ; 632 OutputFrame[k] = 0x0A;
3605  07f2 96            	ldw	x,sp
3606  07f3 0c24          	inc	(OFST+0,sp)
3607  07f5 ad23          	call	LC006
3608  07f7 1b24          	add	a,(OFST+0,sp)
3609  07f9 2401          	jrnc	L673
3610  07fb 5c            	incw	x
3611  07fc               L673:
3612  07fc 02            	rlwa	x,a
3613  07fd a60a          	ld	a,#10
3614  07ff f7            	ld	(x),a
3615                     ; 633 k++;
3617                     ; 634 OutputFrame[k] = 0x0A;
3619  0800 96            	ldw	x,sp
3620  0801 0c24          	inc	(OFST+0,sp)
3621  0803 ad15          	call	LC006
3622  0805 1b24          	add	a,(OFST+0,sp)
3623  0807 2401          	jrnc	L004
3624  0809 5c            	incw	x
3625  080a               L004:
3626  080a 02            	rlwa	x,a
3627  080b a60a          	ld	a,#10
3628  080d f7            	ld	(x),a
3629                     ; 635 k++;
3631                     ; 638 UART_SendStr(OutputFrame); 
3633  080e 96            	ldw	x,sp
3634  080f 0c24          	inc	(OFST+0,sp)
3635  0811 1c000b        	addw	x,#OFST-25
3636  0814 cd0000        	call	_UART_SendStr
3638                     ; 639 }
3641  0817 5b24          	addw	sp,#36
3642  0819 81            	ret	
3643  081a               LC006:
3644  081a 1c000b        	addw	x,#OFST-25
3645  081d 9f            	ld	a,xl
3646  081e 5e            	swapw	x
3647  081f 81            	ret	
3801                     ; 643 void ForceMultipleCoils()
3801                     ; 644 {
3802                     	switch	.text
3803  0820               _ForceMultipleCoils:
3805  0820 522f          	subw	sp,#47
3806       0000002f      OFST:	set	47
3809                     ; 646 uint8_t counter = 0;
3811                     ; 647 uint8_t TempSum=0;
3813  0822 0f03          	clr	(OFST-44,sp)
3814                     ; 654 uint8_t n = 0;
3816                     ; 655 uint8_t k = 0;
3818                     ; 656 uint16_t j = 0;
3820  0824 5f            	clrw	x
3821  0825 1f2c          	ldw	(OFST-3,sp),x
3822                     ; 657 uint16_t status = 0;
3824  0827 1f2a          	ldw	(OFST-5,sp),x
3825                     ; 658 uint8_t Value = 0;
3827  0829 0f0a          	clr	(OFST-37,sp)
3828                     ; 661 for(n = 0; n<OFS; n++){OutputFrame[n] = '\0';}
3830  082b 0f2f          	clr	(OFST+0,sp)
3831  082d               L3541:
3834  082d 96            	ldw	x,sp
3835  082e cd0992        	call	LC007
3836  0831 1b2f          	add	a,(OFST+0,sp)
3837  0833 2401          	jrnc	L604
3838  0835 5c            	incw	x
3839  0836               L604:
3840  0836 02            	rlwa	x,a
3841  0837 7f            	clr	(x)
3844  0838 0c2f          	inc	(OFST+0,sp)
3847  083a 7b2f          	ld	a,(OFST+0,sp)
3848  083c a119          	cp	a,#25
3849  083e 25ed          	jrult	L3541
3850                     ; 664 RewritingChars(OutputFrame,0,12);
3852  0840 4b0c          	push	#12
3853  0842 4b00          	push	#0
3854  0844 96            	ldw	x,sp
3855  0845 1c0011        	addw	x,#OFST-30
3856  0848 cd0161        	call	_RewritingChars
3858  084b b605          	ld	a,_word+5
3859  084d 85            	popw	x
3860                     ; 667 temp4[0] = word[5];
3862  084e 6b0b          	ld	(OFST-36,sp),a
3863                     ; 668 temp4[1] = word[6];
3865  0850 b606          	ld	a,_word+6
3866  0852 6b0c          	ld	(OFST-35,sp),a
3867                     ; 669 temp4[2] = word[7];
3869  0854 b607          	ld	a,_word+7
3870  0856 6b0d          	ld	(OFST-34,sp),a
3871                     ; 670 temp4[3] = word[8];
3873  0858 b608          	ld	a,_word+8
3874  085a 6b0e          	ld	(OFST-33,sp),a
3875                     ; 671 HexToByte_4(temp4, &FirstCoil);
3877  085c 96            	ldw	x,sp
3878  085d 1c0007        	addw	x,#OFST-40
3879  0860 89            	pushw	x
3880  0861 1c0004        	addw	x,#4
3881  0864 cd02b3        	call	_HexToByte_4
3883  0867 b609          	ld	a,_word+9
3884  0869 85            	popw	x
3885                     ; 674 temp4[0] = word[9];
3887  086a 6b0b          	ld	(OFST-36,sp),a
3888                     ; 675 temp4[1] = word[10];
3890  086c b60a          	ld	a,_word+10
3891  086e 6b0c          	ld	(OFST-35,sp),a
3892                     ; 676 temp4[2] = word[11];
3894  0870 b60b          	ld	a,_word+11
3895  0872 6b0d          	ld	(OFST-34,sp),a
3896                     ; 677 temp4[3] = word[12];
3898  0874 b60c          	ld	a,_word+12
3899  0876 6b0e          	ld	(OFST-33,sp),a
3900                     ; 678 HexToByte_4(temp4, &NumberOfCoils);
3902  0878 96            	ldw	x,sp
3903  0879 1c0005        	addw	x,#OFST-42
3904  087c 89            	pushw	x
3905  087d 1c0006        	addw	x,#6
3906  0880 cd02b3        	call	_HexToByte_4
3908  0883 b60d          	ld	a,_word+13
3909  0885 85            	popw	x
3910                     ; 681 temp[0] = word[13];
3912  0886 6b28          	ld	(OFST-7,sp),a
3913                     ; 682 temp[1] = word[14];
3915  0888 b60e          	ld	a,_word+14
3916  088a 6b29          	ld	(OFST-6,sp),a
3917                     ; 683 HexToByte(temp, &NumberOfDataBytes);
3919  088c 96            	ldw	x,sp
3920  088d 1c0004        	addw	x,#OFST-43
3921  0890 89            	pushw	x
3922  0891 1c0024        	addw	x,#36
3923  0894 cd00df        	call	_HexToByte
3925  0897 a60f          	ld	a,#15
3926  0899 85            	popw	x
3927                     ; 685 counter=15;
3929  089a 6b2e          	ld	(OFST-1,sp),a
3930                     ; 686 j = FirstCoil;
3932  089c 1e07          	ldw	x,(OFST-40,sp)
3933  089e 1f2c          	ldw	(OFST-3,sp),x
3934                     ; 688 for(k=0;k<NumberOfDataBytes;k++)
3936  08a0 0f09          	clr	(OFST-38,sp)
3938  08a2 cc0925        	jra	L5641
3939  08a5               L1641:
3940                     ; 690 	temp[0] = word[counter];
3942  08a5 7b2e          	ld	a,(OFST-1,sp)
3943  08a7 5f            	clrw	x
3944  08a8 97            	ld	xl,a
3945  08a9 e600          	ld	a,(_word,x)
3946  08ab 6b28          	ld	(OFST-7,sp),a
3947                     ; 691 	counter++;
3949  08ad 0c2e          	inc	(OFST-1,sp)
3950                     ; 692 	temp[1] = word[counter];
3952  08af 5f            	clrw	x
3953  08b0 7b2e          	ld	a,(OFST-1,sp)
3954  08b2 97            	ld	xl,a
3955  08b3 e600          	ld	a,(_word,x)
3956  08b5 6b29          	ld	(OFST-6,sp),a
3957                     ; 693 	counter++;
3959                     ; 694 	HexToByte(temp, &Value);		
3961  08b7 96            	ldw	x,sp
3962  08b8 0c2e          	inc	(OFST-1,sp)
3963  08ba 1c000a        	addw	x,#OFST-37
3964  08bd 89            	pushw	x
3965  08be 1c001e        	addw	x,#30
3966  08c1 cd00df        	call	_HexToByte
3968  08c4 85            	popw	x
3969                     ; 696 		for(n=0; n<8,j<(FirstCoil+NumberOfCoils); n++)
3971  08c5 0f2f          	clr	(OFST+0,sp)
3973  08c7 2051          	jra	L5741
3974  08c9               L1741:
3975                     ; 699 						if ((1<<n) == (Value & (1<<n)))
3977  08c9 ae0001        	ldw	x,#1
3978  08cc 7b2f          	ld	a,(OFST+0,sp)
3979  08ce 2704          	jreq	L224
3980  08d0               L424:
3981  08d0 58            	sllw	x
3982  08d1 4a            	dec	a
3983  08d2 26fc          	jrne	L424
3984  08d4               L224:
3985  08d4 7b0a          	ld	a,(OFST-37,sp)
3986  08d6 905f          	clrw	y
3987  08d8 9097          	ld	yl,a
3988  08da 1701          	ldw	(OFST-46,sp),y
3989  08dc 90ae0001      	ldw	y,#1
3990  08e0 7b2f          	ld	a,(OFST+0,sp)
3991  08e2 2705          	jreq	L624
3992  08e4               L034:
3993  08e4 9058          	sllw	y
3994  08e6 4a            	dec	a
3995  08e7 26fb          	jrne	L034
3996  08e9               L624:
3997  08e9 9001          	rrwa	y,a
3998  08eb 1402          	and	a,(OFST-45,sp)
3999  08ed 9001          	rrwa	y,a
4000  08ef 1401          	and	a,(OFST-46,sp)
4001  08f1 9001          	rrwa	y,a
4002  08f3 90bf00        	ldw	c_y,y
4003  08f6 b300          	cpw	x,c_y
4004  08f8 2605          	jrne	L1051
4005                     ; 701 										status = 0xFF00;
4007  08fa aeff00        	ldw	x,#65280
4009  08fd 2001          	jra	L3051
4010  08ff               L1051:
4011                     ; 705 										status = 0x0000	;
4013  08ff 5f            	clrw	x
4014  0900               L3051:
4015  0900 1f2a          	ldw	(OFST-5,sp),x
4016                     ; 708 				SetSingleCoil(&j, &status, Output_Registers);
4018  0902 ae0000        	ldw	x,#_Output_Registers
4019  0905 89            	pushw	x
4020  0906 96            	ldw	x,sp
4021  0907 1c002c        	addw	x,#OFST-3
4022  090a 89            	pushw	x
4023  090b 1c0002        	addw	x,#2
4024  090e cd0183        	call	_SetSingleCoil
4026  0911 5b04          	addw	sp,#4
4027                     ; 709 				j++;	
4029  0913 1e2c          	ldw	x,(OFST-3,sp)
4030  0915 5c            	incw	x
4031  0916 1f2c          	ldw	(OFST-3,sp),x
4032                     ; 696 		for(n=0; n<8,j<(FirstCoil+NumberOfCoils); n++)
4034  0918 0c2f          	inc	(OFST+0,sp)
4035  091a               L5741:
4038  091a 1e07          	ldw	x,(OFST-40,sp)
4039  091c 72fb05        	addw	x,(OFST-42,sp)
4040  091f 132c          	cpw	x,(OFST-3,sp)
4041  0921 22a6          	jrugt	L1741
4042                     ; 688 for(k=0;k<NumberOfDataBytes;k++)
4044  0923 0c09          	inc	(OFST-38,sp)
4045  0925               L5641:
4048  0925 7b09          	ld	a,(OFST-38,sp)
4049  0927 1104          	cp	a,(OFST-43,sp)
4050  0929 2403cc08a5    	jrult	L1641
4051                     ; 714 counter = 13;
4053  092e a60d          	ld	a,#13
4054  0930 6b2e          	ld	(OFST-1,sp),a
4055                     ; 715 ByteToHex(temp,GetLRC(OutputFrame));
4057  0932 96            	ldw	x,sp
4058  0933 1c000f        	addw	x,#OFST-32
4059  0936 cd0282        	call	_GetLRC
4061  0939 88            	push	a
4062  093a 96            	ldw	x,sp
4063  093b 1c0029        	addw	x,#OFST-6
4064  093e cd00a7        	call	_ByteToHex
4066  0941 84            	pop	a
4067                     ; 716 OutputFrame[counter] = temp[0];
4069  0942 96            	ldw	x,sp
4070  0943 ad4d          	call	LC007
4071  0945 1b2e          	add	a,(OFST-1,sp)
4072  0947 2401          	jrnc	L044
4073  0949 5c            	incw	x
4074  094a               L044:
4075  094a 02            	rlwa	x,a
4076  094b 7b28          	ld	a,(OFST-7,sp)
4077  094d f7            	ld	(x),a
4078                     ; 717 counter++;
4080                     ; 718 OutputFrame[counter] = temp[1];
4082  094e 96            	ldw	x,sp
4083  094f 0c2e          	inc	(OFST-1,sp)
4084  0951 ad3f          	call	LC007
4085  0953 1b2e          	add	a,(OFST-1,sp)
4086  0955 2401          	jrnc	L244
4087  0957 5c            	incw	x
4088  0958               L244:
4089  0958 02            	rlwa	x,a
4090  0959 7b29          	ld	a,(OFST-6,sp)
4091  095b f7            	ld	(x),a
4092                     ; 719 counter++;
4094                     ; 720 OutputFrame[counter] = 0x0D;
4096  095c 96            	ldw	x,sp
4097  095d 0c2e          	inc	(OFST-1,sp)
4098  095f ad31          	call	LC007
4099  0961 1b2e          	add	a,(OFST-1,sp)
4100  0963 2401          	jrnc	L444
4101  0965 5c            	incw	x
4102  0966               L444:
4103  0966 02            	rlwa	x,a
4104  0967 a60d          	ld	a,#13
4105  0969 f7            	ld	(x),a
4106                     ; 721 counter++;
4108                     ; 722 OutputFrame[counter] = 0x0A;
4110  096a 96            	ldw	x,sp
4111  096b 0c2e          	inc	(OFST-1,sp)
4112  096d ad23          	call	LC007
4113  096f 1b2e          	add	a,(OFST-1,sp)
4114  0971 2401          	jrnc	L644
4115  0973 5c            	incw	x
4116  0974               L644:
4117  0974 02            	rlwa	x,a
4118  0975 a60a          	ld	a,#10
4119  0977 f7            	ld	(x),a
4120                     ; 723 counter++;
4122                     ; 724 OutputFrame[counter] = 0x0A;
4124  0978 96            	ldw	x,sp
4125  0979 0c2e          	inc	(OFST-1,sp)
4126  097b ad15          	call	LC007
4127  097d 1b2e          	add	a,(OFST-1,sp)
4128  097f 2401          	jrnc	L054
4129  0981 5c            	incw	x
4130  0982               L054:
4131  0982 02            	rlwa	x,a
4132  0983 a60a          	ld	a,#10
4133  0985 f7            	ld	(x),a
4134                     ; 725 counter++;
4136                     ; 728 UART_SendStr(OutputFrame); 
4138  0986 96            	ldw	x,sp
4139  0987 0c2e          	inc	(OFST-1,sp)
4140  0989 1c000f        	addw	x,#OFST-32
4141  098c cd0000        	call	_UART_SendStr
4143                     ; 730 }
4146  098f 5b2f          	addw	sp,#47
4147  0991 81            	ret	
4148  0992               LC007:
4149  0992 1c000f        	addw	x,#OFST-32
4150  0995 9f            	ld	a,xl
4151  0996 5e            	swapw	x
4152  0997 81            	ret	
4270                     ; 733 void ForceMultipleRegisters()
4270                     ; 734 {
4271                     	switch	.text
4272  0998               _ForceMultipleRegisters:
4274  0998 5229          	subw	sp,#41
4275       00000029      OFST:	set	41
4278                     ; 736 uint8_t counter = 0;
4280                     ; 737 uint16_t Value=0;
4282  099a 5f            	clrw	x
4283  099b 1f06          	ldw	(OFST-35,sp),x
4284                     ; 744 uint16_t n = 0;
4286                     ; 747 for(n = 0; n<OFS; n++){OutputFrame[n] = '\0';}
4288  099d 1f23          	ldw	(OFST-6,sp),x
4289  099f               L3651:
4292  099f 96            	ldw	x,sp
4293  09a0 1c000a        	addw	x,#OFST-31
4294  09a3 72fb23        	addw	x,(OFST-6,sp)
4295  09a6 7f            	clr	(x)
4298  09a7 1e23          	ldw	x,(OFST-6,sp)
4299  09a9 5c            	incw	x
4300  09aa 1f23          	ldw	(OFST-6,sp),x
4303  09ac a30019        	cpw	x,#25
4304  09af 25ee          	jrult	L3651
4305                     ; 750 RewritingChars(OutputFrame,0,12);
4307  09b1 4b0c          	push	#12
4308  09b3 4b00          	push	#0
4309  09b5 96            	ldw	x,sp
4310  09b6 1c000c        	addw	x,#OFST-29
4311  09b9 cd0161        	call	_RewritingChars
4313  09bc b605          	ld	a,_word+5
4314  09be 85            	popw	x
4315                     ; 753 temp4[0] = word[5];
4317  09bf 6b25          	ld	(OFST-4,sp),a
4318                     ; 754 temp4[1] = word[6];
4320  09c1 b606          	ld	a,_word+6
4321  09c3 6b26          	ld	(OFST-3,sp),a
4322                     ; 755 temp4[2] = word[7];
4324  09c5 b607          	ld	a,_word+7
4325  09c7 6b27          	ld	(OFST-2,sp),a
4326                     ; 756 temp4[3] = word[8];
4328  09c9 b608          	ld	a,_word+8
4329  09cb 6b28          	ld	(OFST-1,sp),a
4330                     ; 757 HexToByte_4(temp4, &FirstRegister);
4332  09cd 96            	ldw	x,sp
4333  09ce 1c0003        	addw	x,#OFST-38
4334  09d1 89            	pushw	x
4335  09d2 1c0022        	addw	x,#34
4336  09d5 cd02b3        	call	_HexToByte_4
4338  09d8 b609          	ld	a,_word+9
4339  09da 85            	popw	x
4340                     ; 760 temp4[0] = word[9];
4342  09db 6b25          	ld	(OFST-4,sp),a
4343                     ; 761 temp4[1] = word[10];
4345  09dd b60a          	ld	a,_word+10
4346  09df 6b26          	ld	(OFST-3,sp),a
4347                     ; 762 temp4[2] = word[11];
4349  09e1 b60b          	ld	a,_word+11
4350  09e3 6b27          	ld	(OFST-2,sp),a
4351                     ; 763 temp4[3] = word[12];
4353  09e5 b60c          	ld	a,_word+12
4354  09e7 6b28          	ld	(OFST-1,sp),a
4355                     ; 764 HexToByte_4(temp4, &NumberOfRegs);
4357  09e9 96            	ldw	x,sp
4358  09ea 5c            	incw	x
4359  09eb 89            	pushw	x
4360  09ec 1c0024        	addw	x,#36
4361  09ef cd02b3        	call	_HexToByte_4
4363  09f2 b60d          	ld	a,_word+13
4364  09f4 85            	popw	x
4365                     ; 767 temp[0] = word[13];
4367  09f5 6b08          	ld	(OFST-33,sp),a
4368                     ; 768 temp[1] = word[14];
4370  09f7 b60e          	ld	a,_word+14
4371  09f9 6b09          	ld	(OFST-32,sp),a
4372                     ; 769 HexToByte(temp, &NumberOfDataBytes);
4374  09fb 96            	ldw	x,sp
4375  09fc 1c0005        	addw	x,#OFST-36
4376  09ff 89            	pushw	x
4377  0a00 1c0003        	addw	x,#3
4378  0a03 cd00df        	call	_HexToByte
4380  0a06 a60f          	ld	a,#15
4381  0a08 85            	popw	x
4382                     ; 771 counter=15;
4384  0a09 6b29          	ld	(OFST+0,sp),a
4385                     ; 773 for(n=0; n<(NumberOfDataBytes/2); n++)
4387  0a0b 5f            	clrw	x
4389  0a0c 2041          	jra	L5751
4390  0a0e               L1751:
4391                     ; 775 		temp4[0] = word[counter];
4393  0a0e 7b29          	ld	a,(OFST+0,sp)
4394  0a10 5f            	clrw	x
4395  0a11 97            	ld	xl,a
4396  0a12 e600          	ld	a,(_word,x)
4397  0a14 6b25          	ld	(OFST-4,sp),a
4398                     ; 776 		counter++;
4400  0a16 0c29          	inc	(OFST+0,sp)
4401                     ; 777 		temp4[1] = word[counter];
4403  0a18 5f            	clrw	x
4404  0a19 7b29          	ld	a,(OFST+0,sp)
4405  0a1b 97            	ld	xl,a
4406  0a1c e600          	ld	a,(_word,x)
4407  0a1e 6b26          	ld	(OFST-3,sp),a
4408                     ; 778 		counter++;
4410  0a20 0c29          	inc	(OFST+0,sp)
4411                     ; 779 		temp4[2] = word[counter];
4413  0a22 5f            	clrw	x
4414  0a23 7b29          	ld	a,(OFST+0,sp)
4415  0a25 97            	ld	xl,a
4416  0a26 e600          	ld	a,(_word,x)
4417  0a28 6b27          	ld	(OFST-2,sp),a
4418                     ; 780 		counter++;
4420  0a2a 0c29          	inc	(OFST+0,sp)
4421                     ; 781 		temp4[3] = word[counter];		
4423  0a2c 5f            	clrw	x
4424  0a2d 7b29          	ld	a,(OFST+0,sp)
4425  0a2f 97            	ld	xl,a
4426  0a30 e600          	ld	a,(_word,x)
4427  0a32 6b28          	ld	(OFST-1,sp),a
4428                     ; 782 		counter++;
4430                     ; 784 		HexToByte_4(temp4, &Value);
4432  0a34 96            	ldw	x,sp
4433  0a35 0c29          	inc	(OFST+0,sp)
4434  0a37 1c0006        	addw	x,#OFST-35
4435  0a3a 89            	pushw	x
4436  0a3b 1c001f        	addw	x,#31
4437  0a3e cd02b3        	call	_HexToByte_4
4439  0a41 85            	popw	x
4440                     ; 785 		Output_Registers[FirstRegister+n] = Value;
4442  0a42 1e03          	ldw	x,(OFST-38,sp)
4443  0a44 72fb23        	addw	x,(OFST-6,sp)
4444  0a47 58            	sllw	x
4445  0a48 1606          	ldw	y,(OFST-35,sp)
4446  0a4a ef00          	ldw	(_Output_Registers,x),y
4447                     ; 773 for(n=0; n<(NumberOfDataBytes/2); n++)
4449  0a4c 1e23          	ldw	x,(OFST-6,sp)
4450  0a4e 5c            	incw	x
4451  0a4f               L5751:
4452  0a4f 1f23          	ldw	(OFST-6,sp),x
4455  0a51 5f            	clrw	x
4456  0a52 7b05          	ld	a,(OFST-36,sp)
4457  0a54 97            	ld	xl,a
4458  0a55 57            	sraw	x
4459  0a56 1323          	cpw	x,(OFST-6,sp)
4460  0a58 22b4          	jrugt	L1751
4461                     ; 789 counter = 13;
4463  0a5a a60d          	ld	a,#13
4464  0a5c 6b29          	ld	(OFST+0,sp),a
4465                     ; 790 ByteToHex(temp,GetLRC(OutputFrame));
4467  0a5e 96            	ldw	x,sp
4468  0a5f 1c000a        	addw	x,#OFST-31
4469  0a62 cd0282        	call	_GetLRC
4471  0a65 88            	push	a
4472  0a66 96            	ldw	x,sp
4473  0a67 1c0009        	addw	x,#OFST-32
4474  0a6a cd00a7        	call	_ByteToHex
4476  0a6d 84            	pop	a
4477                     ; 791 OutputFrame[counter] = temp[0];
4479  0a6e 96            	ldw	x,sp
4480  0a6f ad4d          	call	LC008
4481  0a71 1b29          	add	a,(OFST+0,sp)
4482  0a73 2401          	jrnc	L474
4483  0a75 5c            	incw	x
4484  0a76               L474:
4485  0a76 02            	rlwa	x,a
4486  0a77 7b08          	ld	a,(OFST-33,sp)
4487  0a79 f7            	ld	(x),a
4488                     ; 792 counter++;
4490                     ; 793 OutputFrame[counter] = temp[1];
4492  0a7a 96            	ldw	x,sp
4493  0a7b 0c29          	inc	(OFST+0,sp)
4494  0a7d ad3f          	call	LC008
4495  0a7f 1b29          	add	a,(OFST+0,sp)
4496  0a81 2401          	jrnc	L674
4497  0a83 5c            	incw	x
4498  0a84               L674:
4499  0a84 02            	rlwa	x,a
4500  0a85 7b09          	ld	a,(OFST-32,sp)
4501  0a87 f7            	ld	(x),a
4502                     ; 794 counter++;
4504                     ; 795 OutputFrame[counter] = 0x0D;
4506  0a88 96            	ldw	x,sp
4507  0a89 0c29          	inc	(OFST+0,sp)
4508  0a8b ad31          	call	LC008
4509  0a8d 1b29          	add	a,(OFST+0,sp)
4510  0a8f 2401          	jrnc	L005
4511  0a91 5c            	incw	x
4512  0a92               L005:
4513  0a92 02            	rlwa	x,a
4514  0a93 a60d          	ld	a,#13
4515  0a95 f7            	ld	(x),a
4516                     ; 796 counter++;
4518                     ; 797 OutputFrame[counter] = 0x0A;
4520  0a96 96            	ldw	x,sp
4521  0a97 0c29          	inc	(OFST+0,sp)
4522  0a99 ad23          	call	LC008
4523  0a9b 1b29          	add	a,(OFST+0,sp)
4524  0a9d 2401          	jrnc	L205
4525  0a9f 5c            	incw	x
4526  0aa0               L205:
4527  0aa0 02            	rlwa	x,a
4528  0aa1 a60a          	ld	a,#10
4529  0aa3 f7            	ld	(x),a
4530                     ; 798 counter++;
4532                     ; 799 OutputFrame[counter] = 0x0A;
4534  0aa4 96            	ldw	x,sp
4535  0aa5 0c29          	inc	(OFST+0,sp)
4536  0aa7 ad15          	call	LC008
4537  0aa9 1b29          	add	a,(OFST+0,sp)
4538  0aab 2401          	jrnc	L405
4539  0aad 5c            	incw	x
4540  0aae               L405:
4541  0aae 02            	rlwa	x,a
4542  0aaf a60a          	ld	a,#10
4543  0ab1 f7            	ld	(x),a
4544                     ; 800 counter++;
4546                     ; 803 UART_SendStr(OutputFrame); 
4548  0ab2 96            	ldw	x,sp
4549  0ab3 0c29          	inc	(OFST+0,sp)
4550  0ab5 1c000a        	addw	x,#OFST-31
4551  0ab8 cd0000        	call	_UART_SendStr
4553                     ; 805 }
4556  0abb 5b29          	addw	sp,#41
4557  0abd 81            	ret	
4558  0abe               LC008:
4559  0abe 1c000a        	addw	x,#OFST-31
4560  0ac1 9f            	ld	a,xl
4561  0ac2 5e            	swapw	x
4562  0ac3 81            	ret	
4575                     	xref.b	_Output_Registers
4576                     	xref.b	_Input_Registers
4577                     	xref.b	_word
4578                     	xref.b	_Address
4579                     	xref.b	_TimmingDelay
4580                     	xdef	_SetSingleCoil
4581                     	xdef	_StateOfCoil
4582                     	xdef	_RewritingChars
4583                     	xdef	_ForceMultipleRegisters
4584                     	xdef	_ForceMultipleCoils
4585                     	xdef	_PresetSingleRegister
4586                     	xdef	_ForceSingleCoil
4587                     	xdef	_ReadInputRegisters
4588                     	xdef	_ReadHoldingRegisters
4589                     	xdef	_ReadInputStatus
4590                     	xdef	_ReadCoilStatus
4591                     	xdef	___checkFunc
4592                     	xdef	___checkAddr
4593                     	xdef	_ByteToHex_4
4594                     	xdef	_GetLRC
4595                     	xdef	_CheckLRC
4596                     	xdef	_SetDevAddr
4597                     	xdef	_HexToByte_4
4598                     	xdef	_HexToByte
4599                     	xdef	_ByteToHex
4600                     	xdef	_UART_SendStr
4601                     	xdef	_Modbus_Init
4602                     	xdef	_Delay
4603                     	xdef	_Delay_Init
4604                     	xref	_UART2_SendData8
4605                     	xref	_UART2_ITConfig
4606                     	xref	_UART2_Cmd
4607                     	xref	_UART2_Init
4608                     	xref	_UART2_DeInit
4609                     	xref	_TIM3_ITConfig
4610                     	xref	_TIM3_Cmd
4611                     	xref	_TIM3_TimeBaseInit
4612                     	xref	_TIM3_DeInit
4613                     	xref	_TIM2_ITConfig
4614                     	xref	_TIM2_Cmd
4615                     	xref	_TIM2_TimeBaseInit
4616                     	xref	_TIM2_DeInit
4617                     	xref	_GPIO_WriteLow
4618                     	xref	_GPIO_WriteHigh
4619                     	xref	_GPIO_Init
4620                     	xref	_GPIO_DeInit
4621                     	xref	_CLK_HSIPrescalerConfig
4622                     	xref.b	c_y
4641                     	xref	c_lzmp
4642                     	end
