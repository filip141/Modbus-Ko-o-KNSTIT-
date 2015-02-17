   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
   4                     ; Optimizer V4.3.6 - 29 Nov 2011
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
 143                     ; 20 void Modbus_Init(void)
 143                     ; 21 {
 144                     	switch	.text
 145  0029               _Modbus_Init:
 149                     ; 23 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 151  0029 4f            	clr	a
 152  002a cd0000        	call	_CLK_HSIPrescalerConfig
 154                     ; 25 	GPIO_DeInit(GPIOA);
 156  002d ae5000        	ldw	x,#20480
 157  0030 cd0000        	call	_GPIO_DeInit
 159                     ; 26 	UART2_DeInit();
 161  0033 cd0000        	call	_UART2_DeInit
 163                     ; 28 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 165  0036 4be0          	push	#224
 166  0038 4b08          	push	#8
 167  003a ae5000        	ldw	x,#20480
 168  003d cd0000        	call	_GPIO_Init
 170  0040 85            	popw	x
 171                     ; 29 	UART2_Init(BAUDRATE, UART2_WORDLENGTH_8D, UART2_STOPBITS_2,UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,UART2_MODE_TXRX_ENABLE );  
 173  0041 4b0c          	push	#12
 174  0043 4b80          	push	#128
 175  0045 4b00          	push	#0
 176  0047 4b20          	push	#32
 177  0049 4b00          	push	#0
 178  004b ae4b00        	ldw	x,#19200
 179  004e 89            	pushw	x
 180  004f 5f            	clrw	x
 181  0050 89            	pushw	x
 182  0051 cd0000        	call	_UART2_Init
 184  0054 5b09          	addw	sp,#9
 185                     ; 31 	UART2_Cmd(ENABLE);
 187  0056 a601          	ld	a,#1
 188  0058 cd0000        	call	_UART2_Cmd
 190                     ; 33 	UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);
 192  005b 4b01          	push	#1
 193  005d ae0205        	ldw	x,#517
 194  0060 cd0000        	call	_UART2_ITConfig
 196  0063 9a            	rim	
 197  0064 84            	pop	a
 198                     ; 36 	enableInterrupts();
 202                     ; 38 }
 206  0065 81            	ret	
 233                     ; 40 void Delay_Init(void)
 233                     ; 41 {
 234                     	switch	.text
 235  0066               _Delay_Init:
 239                     ; 43 	TIM3_DeInit();
 241  0066 cd0000        	call	_TIM3_DeInit
 243                     ; 45 	TIM3_TimeBaseInit(TIM3_PRESCALER_16, 999);
 245  0069 ae03e7        	ldw	x,#999
 246  006c 89            	pushw	x
 247  006d a604          	ld	a,#4
 248  006f cd0000        	call	_TIM3_TimeBaseInit
 250  0072 a601          	ld	a,#1
 251  0074 85            	popw	x
 252                     ; 47 	TIM3_Cmd(ENABLE);
 254  0075 cd0000        	call	_TIM3_Cmd
 256                     ; 49 	TIM3_ITConfig(TIM3_IT_UPDATE, ENABLE);
 258  0078 ae0101        	ldw	x,#257
 260                     ; 54 }
 263  007b cc0000        	jp	_TIM3_ITConfig
 298                     ; 57 void Delay(uint32_t time)
 298                     ; 58 {
 299                     	switch	.text
 300  007e               _Delay:
 302       00000000      OFST:	set	0
 305                     ; 59 	TimmingDelay = time;
 307  007e 1e05          	ldw	x,(OFST+5,sp)
 308  0080 bf02          	ldw	_TimmingDelay+2,x
 309  0082 1e03          	ldw	x,(OFST+3,sp)
 310  0084 bf00          	ldw	_TimmingDelay,x
 312  0086 ae0000        	ldw	x,#_TimmingDelay
 313  0089               L501:
 314                     ; 60 	while(TimmingDelay != 0 );
 316  0089 cd0000        	call	c_lzmp
 318  008c 26fb          	jrne	L501
 319                     ; 61 }
 322  008e 81            	ret	
 402                     ; 64 void ByteToHex(char *hexstring, uint8_t byte)
 402                     ; 65 {
 403                     	switch	.text
 404  008f               _ByteToHex:
 406  008f 89            	pushw	x
 407  0090 5203          	subw	sp,#3
 408       00000003      OFST:	set	3
 411                     ; 68 	uint8_t fchar = (byte & 0b11110000) >> 4 ;
 413  0092 7b08          	ld	a,(OFST+5,sp)
 414  0094 4e            	swap	a
 415  0095 a40f          	and	a,#15
 416  0097 6b03          	ld	(OFST+0,sp),a
 417                     ; 69 	uint8_t lchar = (byte & 0b00001111) ; 
 419  0099 7b08          	ld	a,(OFST+5,sp)
 420  009b a40f          	and	a,#15
 421  009d 6b02          	ld	(OFST-1,sp),a
 422                     ; 71 	if( fchar >= 0 && fchar <= 9 )
 424  009f 7b03          	ld	a,(OFST+0,sp)
 425  00a1 a10a          	cp	a,#10
 426  00a3 2404          	jruge	L351
 427                     ; 73 		fhex = (char)(fchar+48);
 429  00a5 ab30          	add	a,#48
 431  00a7 2002          	jra	L551
 432  00a9               L351:
 433                     ; 77 		fhex = (char)(fchar+55);
 435  00a9 ab37          	add	a,#55
 436  00ab               L551:
 437  00ab 6b01          	ld	(OFST-2,sp),a
 438                     ; 79 		if( lchar >= 0 && lchar <= 9 )
 440  00ad 7b02          	ld	a,(OFST-1,sp)
 441  00af a10a          	cp	a,#10
 442  00b1 2404          	jruge	L751
 443                     ; 81 		lhex = (char)(lchar+48);
 445  00b3 ab30          	add	a,#48
 447  00b5 2002          	jra	L161
 448  00b7               L751:
 449                     ; 85 		lhex = (char)(lchar+55);
 451  00b7 ab37          	add	a,#55
 452  00b9               L161:
 453  00b9 6b03          	ld	(OFST+0,sp),a
 454                     ; 87 	hexstring[0] = fhex;
 456  00bb 1e04          	ldw	x,(OFST+1,sp)
 457  00bd 7b01          	ld	a,(OFST-2,sp)
 458  00bf f7            	ld	(x),a
 459                     ; 88 	hexstring[1] = lhex;
 461  00c0 7b03          	ld	a,(OFST+0,sp)
 462  00c2 e701          	ld	(1,x),a
 463                     ; 89 }
 466  00c4 5b05          	addw	sp,#5
 467  00c6 81            	ret	
 557                     ; 91 void HexToByte(char *hexstring, uint8_t *byte)
 557                     ; 92 {
 558                     	switch	.text
 559  00c7               _HexToByte:
 561  00c7 89            	pushw	x
 562  00c8 5205          	subw	sp,#5
 563       00000005      OFST:	set	5
 566                     ; 98 	fhex	= hexstring[0];
 568  00ca f6            	ld	a,(x)
 569  00cb 6b05          	ld	(OFST+0,sp),a
 570                     ; 99 	lhex = hexstring[1];
 572  00cd e601          	ld	a,(1,x)
 573  00cf 6b04          	ld	(OFST-1,sp),a
 574                     ; 100 	if( ((int)fhex) >= 48 && ((int)fhex) <= 57 )
 576  00d1 5f            	clrw	x
 577  00d2 7b05          	ld	a,(OFST+0,sp)
 578  00d4 97            	ld	xl,a
 579  00d5 a30030        	cpw	x,#48
 580  00d8 2f0b          	jrslt	L132
 582  00da 5f            	clrw	x
 583  00db 97            	ld	xl,a
 584  00dc a3003a        	cpw	x,#58
 585  00df 2e04          	jrsge	L132
 586                     ; 102 		fchar = ((int)fhex) - 48; 
 588  00e1 a030          	sub	a,#48
 590  00e3 2002          	jra	L332
 591  00e5               L132:
 592                     ; 106 		fchar = ((int)fhex) - 55;
 594  00e5 a037          	sub	a,#55
 595  00e7               L332:
 596  00e7 6b03          	ld	(OFST-2,sp),a
 597                     ; 108 		if( ((int)lhex) >= 48 && ((int)lhex) <= 57 )
 599  00e9 5f            	clrw	x
 600  00ea 7b04          	ld	a,(OFST-1,sp)
 601  00ec 97            	ld	xl,a
 602  00ed a30030        	cpw	x,#48
 603  00f0 2f0b          	jrslt	L532
 605  00f2 5f            	clrw	x
 606  00f3 97            	ld	xl,a
 607  00f4 a3003a        	cpw	x,#58
 608  00f7 2e04          	jrsge	L532
 609                     ; 110 		lchar = ((int)lhex) - 48; 
 611  00f9 a030          	sub	a,#48
 613  00fb 2002          	jra	L732
 614  00fd               L532:
 615                     ; 114 		lchar = ((int)lhex) - 55;
 617  00fd a037          	sub	a,#55
 618  00ff               L732:
 619  00ff 6b05          	ld	(OFST+0,sp),a
 620                     ; 116 	tmpb = ((fchar<<4) | lchar);
 622  0101 7b03          	ld	a,(OFST-2,sp)
 623  0103 97            	ld	xl,a
 624  0104 a610          	ld	a,#16
 625  0106 42            	mul	x,a
 626  0107 01            	rrwa	x,a
 627  0108 1a05          	or	a,(OFST+0,sp)
 628  010a 02            	rlwa	x,a
 629  010b 1f01          	ldw	(OFST-4,sp),x
 630                     ; 117 	*byte =  (uint8_t)tmpb; 
 632  010d 1e0a          	ldw	x,(OFST+5,sp)
 633  010f 7b02          	ld	a,(OFST-3,sp)
 634  0111 f7            	ld	(x),a
 635                     ; 119 }
 638  0112 5b07          	addw	sp,#7
 639  0114 81            	ret	
 652                     	xref.b	_TimmingDelay
 653                     	xdef	_HexToByte
 654                     	xdef	_ByteToHex
 655                     	xdef	_UART_SendStr
 656                     	xdef	_Modbus_Init
 657                     	xdef	_Delay
 658                     	xdef	_Delay_Init
 659                     	xref	_UART2_SendData8
 660                     	xref	_UART2_ITConfig
 661                     	xref	_UART2_Cmd
 662                     	xref	_UART2_Init
 663                     	xref	_UART2_DeInit
 664                     	xref	_TIM3_ITConfig
 665                     	xref	_TIM3_Cmd
 666                     	xref	_TIM3_TimeBaseInit
 667                     	xref	_TIM3_DeInit
 668                     	xref	_GPIO_WriteLow
 669                     	xref	_GPIO_WriteHigh
 670                     	xref	_GPIO_Init
 671                     	xref	_GPIO_DeInit
 672                     	xref	_CLK_HSIPrescalerConfig
 691                     	xref	c_lzmp
 692                     	end
