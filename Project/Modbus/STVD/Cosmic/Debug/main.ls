   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
   4                     ; Optimizer V4.3.6 - 29 Nov 2011
  87                     ; 31 void main(void)
  87                     ; 32 {
  89                     	switch	.text
  90  0000               _main:
  92  0000 5204          	subw	sp,#4
  93       00000004      OFST:	set	4
  96                     ; 36 	GPIO_DeInit(GPIOD);
  98  0002 ae500f        	ldw	x,#20495
  99  0005 cd0000        	call	_GPIO_DeInit
 101                     ; 37 	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
 103  0008 4be0          	push	#224
 104  000a 4b01          	push	#1
 105  000c ae500f        	ldw	x,#20495
 106  000f cd0000        	call	_GPIO_Init
 108  0012 85            	popw	x
 109                     ; 38 	Delay_Init();
 111  0013 cd0000        	call	_Delay_Init
 113                     ; 39 	Modbus_Init();
 115  0016 cd0000        	call	_Modbus_Init
 117                     ; 40 	ByteToHex(tmp,0b10110111);
 119  0019 4bb7          	push	#183
 120  001b 96            	ldw	x,sp
 121  001c 1c0003        	addw	x,#OFST-1
 122  001f cd0000        	call	_ByteToHex
 124  0022 84            	pop	a
 125                     ; 41 	HexToByte(tmp, &byte);
 127  0023 96            	ldw	x,sp
 128  0024 5c            	incw	x
 129  0025 89            	pushw	x
 130  0026 5c            	incw	x
 131  0027 cd0000        	call	_HexToByte
 133  002a 85            	popw	x
 134  002b               L73:
 135                     ; 45 		Delay(1000);
 137  002b ae03e8        	ldw	x,#1000
 138  002e 89            	pushw	x
 139  002f 5f            	clrw	x
 140  0030 89            	pushw	x
 141  0031 cd0000        	call	_Delay
 143  0034 5b04          	addw	sp,#4
 144                     ; 46 		if(word[0] != '\0')
 146  0036 b600          	ld	a,_word
 147  0038 2715          	jreq	L34
 148                     ; 48 			UART_SendStr(word);
 150  003a ae0000        	ldw	x,#_word
 151  003d cd0000        	call	_UART_SendStr
 153                     ; 49 			for(i = 0; i<20; i++){word[i] = '\0';}
 155  0040 4f            	clr	a
 156  0041 6b04          	ld	(OFST+0,sp),a
 157  0043               L54:
 160  0043 5f            	clrw	x
 161  0044 97            	ld	xl,a
 162  0045 6f00          	clr	(_word,x)
 165  0047 0c04          	inc	(OFST+0,sp)
 168  0049 7b04          	ld	a,(OFST+0,sp)
 169  004b a114          	cp	a,#20
 170  004d 25f4          	jrult	L54
 171  004f               L34:
 172                     ; 51 		GPIO_WriteReverse(GPIOD, GPIO_PIN_0);
 174  004f 4b01          	push	#1
 175  0051 ae500f        	ldw	x,#20495
 176  0054 cd0000        	call	_GPIO_WriteReverse
 178  0057 84            	pop	a
 180  0058 20d1          	jra	L73
 215                     ; 65 void assert_failed(u8* file, u32 line)
 215                     ; 66 { 
 216                     	switch	.text
 217  005a               _assert_failed:
 221  005a               L17:
 222  005a 20fe          	jra	L17
 235                     	xdef	_main
 236                     	xref.b	_word
 237                     	xref	_HexToByte
 238                     	xref	_ByteToHex
 239                     	xref	_UART_SendStr
 240                     	xref	_Modbus_Init
 241                     	xref	_Delay
 242                     	xref	_Delay_Init
 243                     	xdef	_assert_failed
 244                     	xref	_GPIO_WriteReverse
 245                     	xref	_GPIO_Init
 246                     	xref	_GPIO_DeInit
 265                     	end
