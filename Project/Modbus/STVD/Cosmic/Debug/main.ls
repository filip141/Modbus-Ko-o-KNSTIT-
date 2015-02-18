   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  54                     ; 31 void main(void)
  54                     ; 32 {
  56                     	switch	.text
  57  0000               _main:
  61                     ; 33 	GPIO_DeInit(GPIOD);
  63  0000 ae500f        	ldw	x,#20495
  64  0003 cd0000        	call	_GPIO_DeInit
  66                     ; 34 	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
  68  0006 4be0          	push	#224
  69  0008 4b01          	push	#1
  70  000a ae500f        	ldw	x,#20495
  71  000d cd0000        	call	_GPIO_Init
  73  0010 85            	popw	x
  74                     ; 35 	Delay_Init();
  76  0011 cd0000        	call	_Delay_Init
  78                     ; 36 	Modbus_Init();
  80  0014 cd0000        	call	_Modbus_Init
  82                     ; 37 	SetDevAddr(13);
  84  0017 a60d          	ld	a,#13
  85  0019 cd0000        	call	_SetDevAddr
  87  001c               L12:
  88                     ; 41 		Delay(1000);
  90  001c ae03e8        	ldw	x,#1000
  91  001f 89            	pushw	x
  92  0020 5f            	clrw	x
  93  0021 89            	pushw	x
  94  0022 cd0000        	call	_Delay
  96  0025 5b04          	addw	sp,#4
  97                     ; 42 		GPIO_WriteReverse(GPIOD, GPIO_PIN_0);
  99  0027 4b01          	push	#1
 100  0029 ae500f        	ldw	x,#20495
 101  002c cd0000        	call	_GPIO_WriteReverse
 103  002f 84            	pop	a
 105  0030 20ea          	jra	L12
 140                     ; 56 void assert_failed(u8* file, u32 line)
 140                     ; 57 { 
 141                     	switch	.text
 142  0032               _assert_failed:
 146  0032               L34:
 147  0032 20fe          	jra	L34
 160                     	xdef	_main
 161                     	xref	_SetDevAddr
 162                     	xref	_Modbus_Init
 163                     	xref	_Delay
 164                     	xref	_Delay_Init
 165                     	xdef	_assert_failed
 166                     	xref	_GPIO_WriteReverse
 167                     	xref	_GPIO_Init
 168                     	xref	_GPIO_DeInit
 187                     	end
