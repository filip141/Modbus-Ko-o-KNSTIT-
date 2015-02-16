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
 147                     ; 19 void Modbus_Init(void)
 147                     ; 20 {
 148                     	switch	.text
 149  0029               _Modbus_Init:
 153                     ; 22 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 155  0029 4f            	clr	a
 156  002a cd0000        	call	_CLK_HSIPrescalerConfig
 158                     ; 24 	GPIO_DeInit(GPIOA);
 160  002d ae5000        	ldw	x,#20480
 161  0030 cd0000        	call	_GPIO_DeInit
 163                     ; 25 	UART2_DeInit();
 165  0033 cd0000        	call	_UART2_DeInit
 167                     ; 26 	TIM3_DeInit();
 169  0036 cd0000        	call	_TIM3_DeInit
 171                     ; 28 	TIM3_TimeBaseInit(TIM3_PRESCALER_16, 999);
 173  0039 ae03e7        	ldw	x,#999
 174  003c 89            	pushw	x
 175  003d a604          	ld	a,#4
 176  003f cd0000        	call	_TIM3_TimeBaseInit
 178  0042 85            	popw	x
 179                     ; 29 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 181  0043 4be0          	push	#224
 182  0045 4b08          	push	#8
 183  0047 ae5000        	ldw	x,#20480
 184  004a cd0000        	call	_GPIO_Init
 186  004d 85            	popw	x
 187                     ; 30 	UART2_Init(19200, UART2_WORDLENGTH_8D, UART2_STOPBITS_2,UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,UART2_MODE_TXRX_ENABLE );  
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
 201                     ; 32 	UART2_Cmd(ENABLE);
 203  0063 a601          	ld	a,#1
 204  0065 cd0000        	call	_UART2_Cmd
 206                     ; 33 	TIM3_Cmd(ENABLE);
 208  0068 a601          	ld	a,#1
 209  006a cd0000        	call	_TIM3_Cmd
 211                     ; 35 	UART2_ITConfig(UART2_IT_RXNE, ENABLE);
 213  006d 4b01          	push	#1
 214  006f ae0255        	ldw	x,#597
 215  0072 cd0000        	call	_UART2_ITConfig
 217  0075 ae0101        	ldw	x,#257
 218  0078 84            	pop	a
 219                     ; 36 	TIM3_ITConfig(TIM3_IT_UPDATE, ENABLE);
 221  0079 cd0000        	call	_TIM3_ITConfig
 223                     ; 39 	enableInterrupts();
 226  007c 9a            	rim	
 228                     ; 41 }
 232  007d 81            	ret	
 259                     ; 42 void Delay_Init(void)
 259                     ; 43 {
 260                     	switch	.text
 261  007e               _Delay_Init:
 265                     ; 45 	TIM3_DeInit();
 267  007e cd0000        	call	_TIM3_DeInit
 269                     ; 47 	TIM3_TimeBaseInit(TIM3_PRESCALER_16, 999);
 271  0081 ae03e7        	ldw	x,#999
 272  0084 89            	pushw	x
 273  0085 a604          	ld	a,#4
 274  0087 cd0000        	call	_TIM3_TimeBaseInit
 276  008a a601          	ld	a,#1
 277  008c 85            	popw	x
 278                     ; 49 	TIM3_Cmd(ENABLE);
 280  008d cd0000        	call	_TIM3_Cmd
 282                     ; 51 	TIM3_ITConfig(TIM3_IT_UPDATE, ENABLE);
 284  0090 ae0101        	ldw	x,#257
 286                     ; 56 }
 289  0093 cc0000        	jp	_TIM3_ITConfig
 324                     ; 59 void Delay(uint32_t time)
 324                     ; 60 {
 325                     	switch	.text
 326  0096               _Delay:
 328       00000000      OFST:	set	0
 331                     ; 61 	TimmingDelay = time;
 333  0096 1e05          	ldw	x,(OFST+5,sp)
 334  0098 bf02          	ldw	_TimmingDelay+2,x
 335  009a 1e03          	ldw	x,(OFST+3,sp)
 336  009c bf00          	ldw	_TimmingDelay,x
 338  009e ae0000        	ldw	x,#_TimmingDelay
 339  00a1               L501:
 340                     ; 62 	while(TimmingDelay != 0 );
 342  00a1 cd0000        	call	c_lzmp
 344  00a4 26fb          	jrne	L501
 345                     ; 63 }
 348  00a6 81            	ret	
 361                     	xref.b	_TimmingDelay
 362                     	xdef	_UART_SendStr
 363                     	xdef	_Modbus_Init
 364                     	xdef	_Delay
 365                     	xdef	_Delay_Init
 366                     	xref	_UART2_SendData8
 367                     	xref	_UART2_ITConfig
 368                     	xref	_UART2_Cmd
 369                     	xref	_UART2_Init
 370                     	xref	_UART2_DeInit
 371                     	xref	_TIM3_ITConfig
 372                     	xref	_TIM3_Cmd
 373                     	xref	_TIM3_TimeBaseInit
 374                     	xref	_TIM3_DeInit
 375                     	xref	_GPIO_WriteLow
 376                     	xref	_GPIO_WriteHigh
 377                     	xref	_GPIO_Init
 378                     	xref	_GPIO_DeInit
 379                     	xref	_CLK_HSIPrescalerConfig
 398                     	xref	c_lzmp
 399                     	end
