   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
   4                     ; Optimizer V4.3.6 - 29 Nov 2011
  67                     ; 31 void main(void)
  67                     ; 32 {
  69                     	switch	.text
  70  0000               _main:
  72  0000 88            	push	a
  73       00000001      OFST:	set	1
  76                     ; 36 	GPIO_DeInit(GPIOD);
  78  0001 ae500f        	ldw	x,#20495
  79  0004 cd0000        	call	_GPIO_DeInit
  81                     ; 37 	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
  83  0007 4be0          	push	#224
  84  0009 4b01          	push	#1
  85  000b ae500f        	ldw	x,#20495
  86  000e cd0000        	call	_GPIO_Init
  88  0011 85            	popw	x
  89                     ; 38 	Delay_Init();
  91  0012 cd0000        	call	_Delay_Init
  93                     ; 39 	Modbus_Init();
  95  0015 cd0000        	call	_Modbus_Init
  97                     ; 40 	SetDevAddr(13);
  99  0018 a60d          	ld	a,#13
 100  001a cd0000        	call	_SetDevAddr
 102  001d               L72:
 103                     ; 44 		Delay(1000);
 105  001d ae03e8        	ldw	x,#1000
 106  0020 89            	pushw	x
 107  0021 5f            	clrw	x
 108  0022 89            	pushw	x
 109  0023 cd0000        	call	_Delay
 111  0026 5b04          	addw	sp,#4
 112                     ; 45 		if(word[0] != '\0')
 114  0028 b600          	ld	a,_word
 115  002a 2715          	jreq	L33
 116                     ; 47 			UART_SendStr(word);
 118  002c ae0000        	ldw	x,#_word
 119  002f cd0000        	call	_UART_SendStr
 121                     ; 48 			for(i = 0; i<20; i++){word[i] = '\0';}
 123  0032 4f            	clr	a
 124  0033 6b01          	ld	(OFST+0,sp),a
 125  0035               L53:
 128  0035 5f            	clrw	x
 129  0036 97            	ld	xl,a
 130  0037 6f00          	clr	(_word,x)
 133  0039 0c01          	inc	(OFST+0,sp)
 136  003b 7b01          	ld	a,(OFST+0,sp)
 137  003d a114          	cp	a,#20
 138  003f 25f4          	jrult	L53
 139  0041               L33:
 140                     ; 50 		GPIO_WriteReverse(GPIOD, GPIO_PIN_0);
 142  0041 4b01          	push	#1
 143  0043 ae500f        	ldw	x,#20495
 144  0046 cd0000        	call	_GPIO_WriteReverse
 146  0049 84            	pop	a
 148  004a 20d1          	jra	L72
 183                     ; 64 void assert_failed(u8* file, u32 line)
 183                     ; 65 { 
 184                     	switch	.text
 185  004c               _assert_failed:
 189  004c               L16:
 190  004c 20fe          	jra	L16
 203                     	xdef	_main
 204                     	xref.b	_word
 205                     	xref	_SetDevAddr
 206                     	xref	_UART_SendStr
 207                     	xref	_Modbus_Init
 208                     	xref	_Delay
 209                     	xref	_Delay_Init
 210                     	xdef	_assert_failed
 211                     	xref	_GPIO_WriteReverse
 212                     	xref	_GPIO_Init
 213                     	xref	_GPIO_DeInit
 232                     	end
