   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
   4                     ; Optimizer V4.3.6 - 29 Nov 2011
  66                     ; 31 void main(void)
  66                     ; 32 {
  68                     	switch	.text
  69  0000               _main:
  71  0000 88            	push	a
  72       00000001      OFST:	set	1
  75                     ; 34 	GPIO_DeInit(GPIOD);
  77  0001 ae500f        	ldw	x,#20495
  78  0004 cd0000        	call	_GPIO_DeInit
  80                     ; 35 	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
  82  0007 4be0          	push	#224
  83  0009 4b01          	push	#1
  84  000b ae500f        	ldw	x,#20495
  85  000e cd0000        	call	_GPIO_Init
  87  0011 85            	popw	x
  88                     ; 36 	Delay_Init();
  90  0012 cd0000        	call	_Delay_Init
  92                     ; 37 	Modbus_Init();
  94  0015 cd0000        	call	_Modbus_Init
  96  0018               L72:
  97                     ; 41 		Delay(1000);
  99  0018 ae03e8        	ldw	x,#1000
 100  001b 89            	pushw	x
 101  001c 5f            	clrw	x
 102  001d 89            	pushw	x
 103  001e cd0000        	call	_Delay
 105  0021 5b04          	addw	sp,#4
 106                     ; 42 		if(word[0] != '\0')
 108  0023 b600          	ld	a,_word
 109  0025 2715          	jreq	L33
 110                     ; 44 			UART_SendStr(word);
 112  0027 ae0000        	ldw	x,#_word
 113  002a cd0000        	call	_UART_SendStr
 115                     ; 45 			for(i = 0; i<20; i++){word[i] = '\0';}
 117  002d 4f            	clr	a
 118  002e 6b01          	ld	(OFST+0,sp),a
 119  0030               L53:
 122  0030 5f            	clrw	x
 123  0031 97            	ld	xl,a
 124  0032 6f00          	clr	(_word,x)
 127  0034 0c01          	inc	(OFST+0,sp)
 130  0036 7b01          	ld	a,(OFST+0,sp)
 131  0038 a114          	cp	a,#20
 132  003a 25f4          	jrult	L53
 133  003c               L33:
 134                     ; 47 		GPIO_WriteReverse(GPIOD, GPIO_PIN_0);
 136  003c 4b01          	push	#1
 137  003e ae500f        	ldw	x,#20495
 138  0041 cd0000        	call	_GPIO_WriteReverse
 140  0044 84            	pop	a
 142  0045 20d1          	jra	L72
 155                     	xdef	_main
 156                     	xref.b	_word
 157                     	xref	_UART_SendStr
 158                     	xref	_Modbus_Init
 159                     	xref	_Delay
 160                     	xref	_Delay_Init
 161                     	xref	_GPIO_WriteReverse
 162                     	xref	_GPIO_Init
 163                     	xref	_GPIO_DeInit
 182                     	end
