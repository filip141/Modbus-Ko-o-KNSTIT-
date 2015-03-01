   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  19                     	bsct
  20  0000               _STATUS_BIT:
  21  0000 00            	dc.b	0
  51                     ; 69 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  51                     ; 70 {
  52                     	switch	.text
  53  0000               f_NonHandledInterrupt:
  57                     ; 74 }
  60  0000 80            	iret	
  82                     ; 82 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  82                     ; 83 {
  83                     	switch	.text
  84  0001               f_TRAP_IRQHandler:
  88                     ; 87 }
  91  0001 80            	iret	
 113                     ; 93 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 113                     ; 94 {
 114                     	switch	.text
 115  0002               f_TLI_IRQHandler:
 119                     ; 98 }
 122  0002 80            	iret	
 144                     ; 105 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 144                     ; 106 {
 145                     	switch	.text
 146  0003               f_AWU_IRQHandler:
 150                     ; 110 }
 153  0003 80            	iret	
 175                     ; 117 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 175                     ; 118 {
 176                     	switch	.text
 177  0004               f_CLK_IRQHandler:
 181                     ; 122 }
 184  0004 80            	iret	
 207                     ; 129 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 130 {
 208                     	switch	.text
 209  0005               f_EXTI_PORTA_IRQHandler:
 213                     ; 134 }
 216  0005 80            	iret	
 239                     ; 141 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 239                     ; 142 {
 240                     	switch	.text
 241  0006               f_EXTI_PORTB_IRQHandler:
 245                     ; 146 }
 248  0006 80            	iret	
 271                     ; 153 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 271                     ; 154 {
 272                     	switch	.text
 273  0007               f_EXTI_PORTC_IRQHandler:
 277                     ; 158 }
 280  0007 80            	iret	
 303                     ; 165 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 303                     ; 166 {
 304                     	switch	.text
 305  0008               f_EXTI_PORTD_IRQHandler:
 309                     ; 170 }
 312  0008 80            	iret	
 335                     ; 177 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 335                     ; 178 {
 336                     	switch	.text
 337  0009               f_EXTI_PORTE_IRQHandler:
 341                     ; 182 }
 344  0009 80            	iret	
 366                     ; 228 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 366                     ; 229 {
 367                     	switch	.text
 368  000a               f_SPI_IRQHandler:
 372                     ; 233 }
 375  000a 80            	iret	
 398                     ; 240 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 398                     ; 241 {
 399                     	switch	.text
 400  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 404                     ; 245 }
 407  000b 80            	iret	
 430                     ; 252 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 430                     ; 253 {
 431                     	switch	.text
 432  000c               f_TIM1_CAP_COM_IRQHandler:
 436                     ; 257 }
 439  000c 80            	iret	
 504                     ; 291  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 504                     ; 292 {
 505                     	switch	.text
 506  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 508  000d 8a            	push	cc
 509  000e 84            	pop	a
 510  000f a4bf          	and	a,#191
 511  0011 88            	push	a
 512  0012 86            	pop	cc
 513       00000004      OFST:	set	4
 514  0013 3b0002        	push	c_x+2
 515  0016 be00          	ldw	x,c_x
 516  0018 89            	pushw	x
 517  0019 3b0002        	push	c_y+2
 518  001c be00          	ldw	x,c_y
 519  001e 89            	pushw	x
 520  001f 5204          	subw	sp,#4
 523                     ; 297 	if(word[0] != '\0')
 525  0021 b62e          	ld	a,_word
 526  0023 2604acad00ad  	jreq	L722
 527                     ; 299 		if (CheckLRC(word))
 529  0029 ae002e        	ldw	x,#_word
 530  002c cd0000        	call	_CheckLRC
 532  002f 4d            	tnz	a
 533  0030 276c          	jreq	L132
 534                     ; 302 		tmp[0] = word[3];
 536  0032 b631          	ld	a,_word+3
 537  0034 6b01          	ld	(OFST-3,sp),a
 538                     ; 303 		tmp[1] = word[4];
 540  0036 b632          	ld	a,_word+4
 541  0038 6b02          	ld	(OFST-2,sp),a
 542                     ; 304 		HexToByte(tmp, &FunC);
 544  003a 96            	ldw	x,sp
 545  003b 1c0003        	addw	x,#OFST-1
 546  003e 89            	pushw	x
 547  003f 1d0002        	subw	x,#2
 548  0042 cd0000        	call	_HexToByte
 550  0045 85            	popw	x
 551                     ; 306 		if(__checkFunc(FunC))
 553  0046 7b03          	ld	a,(OFST-1,sp)
 554  0048 cd0000        	call	___checkFunc
 556  004b 4d            	tnz	a
 557  004c 2750          	jreq	L132
 558                     ; 309 			switch (FunC) 
 560  004e 7b03          	ld	a,(OFST-1,sp)
 562                     ; 346 			default: 
 562                     ; 347 				break;
 563  0050 4a            	dec	a
 564  0051 2715          	jreq	L161
 565  0053 4a            	dec	a
 566  0054 2717          	jreq	L361
 567  0056 4a            	dec	a
 568  0057 2719          	jreq	L561
 569  0059 4a            	dec	a
 570  005a 271b          	jreq	L761
 571  005c 4a            	dec	a
 572  005d 2723          	jreq	L171
 573  005f 4a            	dec	a
 574  0060 272b          	jreq	L371
 575  0062 a00a          	sub	a,#10
 576  0064 2732          	jreq	L571
 577  0066 2036          	jra	L132
 578  0068               L161:
 579                     ; 311 			case 1:
 579                     ; 312 				//Function 1
 579                     ; 313 				ReadCoilStatus();
 581  0068 cd0000        	call	_ReadCoilStatus
 583                     ; 314 				break;
 585  006b 2031          	jra	L132
 586  006d               L361:
 587                     ; 315 			case 2:
 587                     ; 316 				//Function 2
 587                     ; 317 				ReadInputStatus();
 589  006d cd0000        	call	_ReadInputStatus
 591                     ; 318 				break;
 593  0070 202c          	jra	L132
 594  0072               L561:
 595                     ; 319 			case 3: 
 595                     ; 320 				//Function 3
 595                     ; 321 				ReadHoldingRegisters();
 597  0072 cd0000        	call	_ReadHoldingRegisters
 599                     ; 322 				break;
 601  0075 2027          	jra	L132
 602  0077               L761:
 603                     ; 324 			case 4: 
 603                     ; 325 				//Function 4
 603                     ; 326 				UART_SendStr("Function 4 Handled");
 605  0077 ae003a        	ldw	x,#L142
 606  007a cd0000        	call	_UART_SendStr
 608                     ; 327 				ReadInputRegisters();
 610  007d cd0000        	call	_ReadInputRegisters
 612                     ; 329 				break;
 614  0080 201c          	jra	L132
 615  0082               L171:
 616                     ; 330 			case 5: 
 616                     ; 331 				//Function 5
 616                     ; 332 				UART_SendStr("Function 5 Handled");
 618  0082 ae0027        	ldw	x,#L342
 619  0085 cd0000        	call	_UART_SendStr
 621                     ; 333 				ForceSingleCoil();
 623  0088 cd0000        	call	_ForceSingleCoil
 625                     ; 334 				break;
 627  008b 2011          	jra	L132
 628  008d               L371:
 629                     ; 336 			case 6:
 629                     ; 337 				//Function 6
 629                     ; 338 				UART_SendStr("Function 6 Handled");
 631  008d ae0014        	ldw	x,#L542
 632  0090 cd0000        	call	_UART_SendStr
 634                     ; 339 				PresetSingleRegister();
 636  0093 cd0000        	call	_PresetSingleRegister
 638                     ; 340 				break;
 640  0096 2006          	jra	L132
 641  0098               L571:
 642                     ; 342 			case 16:
 642                     ; 343 				//Function 16
 642                     ; 344 				UART_SendStr("Function 16 Handled");
 644  0098 ae0000        	ldw	x,#L742
 645  009b cd0000        	call	_UART_SendStr
 647                     ; 345 				break;
 649                     ; 346 			default: 
 649                     ; 347 				break;
 651  009e               L132:
 652                     ; 351 		for(i = 0; i<20; i++){word[i] = '\0';}
 654  009e 4f            	clr	a
 655  009f 6b04          	ld	(OFST+0,sp),a
 656  00a1               L152:
 659  00a1 5f            	clrw	x
 660  00a2 97            	ld	xl,a
 661  00a3 6f2e          	clr	(_word,x)
 664  00a5 0c04          	inc	(OFST+0,sp)
 667  00a7 7b04          	ld	a,(OFST+0,sp)
 668  00a9 a114          	cp	a,#20
 669  00ab 25f4          	jrult	L152
 670  00ad               L722:
 671                     ; 353   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 673  00ad a601          	ld	a,#1
 674  00af cd0000        	call	_TIM2_ClearITPendingBit
 676                     ; 354 }
 679  00b2 5b04          	addw	sp,#4
 680  00b4 85            	popw	x
 681  00b5 bf00          	ldw	c_y,x
 682  00b7 320002        	pop	c_y+2
 683  00ba 85            	popw	x
 684  00bb bf00          	ldw	c_x,x
 685  00bd 320002        	pop	c_x+2
 686  00c0 80            	iret	
 709                     ; 361  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 709                     ; 362 {
 710                     	switch	.text
 711  00c1               f_TIM2_CAP_COM_IRQHandler:
 715                     ; 366 }
 718  00c1 80            	iret	
 743                     ; 376  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 743                     ; 377 {
 744                     	switch	.text
 745  00c2               f_TIM3_UPD_OVF_BRK_IRQHandler:
 747  00c2 8a            	push	cc
 748  00c3 84            	pop	a
 749  00c4 a4bf          	and	a,#191
 750  00c6 88            	push	a
 751  00c7 86            	pop	cc
 752  00c8 3b0002        	push	c_x+2
 753  00cb be00          	ldw	x,c_x
 754  00cd 89            	pushw	x
 755  00ce 3b0002        	push	c_y+2
 756  00d1 be00          	ldw	x,c_y
 757  00d3 89            	pushw	x
 760                     ; 379 	if(TimmingDelay !=0)
 762  00d4 ae0000        	ldw	x,#_TimmingDelay
 763  00d7 cd0000        	call	c_lzmp
 765  00da 2705          	jreq	L772
 766                     ; 381 		TimmingDelay--;
 768  00dc a601          	ld	a,#1
 769  00de cd0000        	call	c_lgsbc
 771  00e1               L772:
 772                     ; 383 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 774  00e1 a601          	ld	a,#1
 775  00e3 cd0000        	call	_TIM3_ClearITPendingBit
 777                     ; 384 }
 780  00e6 85            	popw	x
 781  00e7 bf00          	ldw	c_y,x
 782  00e9 320002        	pop	c_y+2
 783  00ec 85            	popw	x
 784  00ed bf00          	ldw	c_x,x
 785  00ef 320002        	pop	c_x+2
 786  00f2 80            	iret	
 809                     ; 391  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 809                     ; 392 {
 810                     	switch	.text
 811  00f3               f_TIM3_CAP_COM_IRQHandler:
 815                     ; 396 }
 818  00f3 80            	iret	
 840                     ; 431 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 840                     ; 432 {
 841                     	switch	.text
 842  00f4               f_I2C_IRQHandler:
 846                     ; 436 }
 849  00f4 80            	iret	
 872                     ; 444  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 872                     ; 445 {
 873                     	switch	.text
 874  00f5               f_UART2_TX_IRQHandler:
 878                     ; 449   }
 881  00f5 80            	iret	
 942                     ; 457  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 942                     ; 458 {
 943                     	switch	.text
 944  00f6               f_UART2_RX_IRQHandler:
 946  00f6 8a            	push	cc
 947  00f7 84            	pop	a
 948  00f8 a4bf          	and	a,#191
 949  00fa 88            	push	a
 950  00fb 86            	pop	cc
 951       00000004      OFST:	set	4
 952  00fc 3b0002        	push	c_x+2
 953  00ff be00          	ldw	x,c_x
 954  0101 89            	pushw	x
 955  0102 3b0002        	push	c_y+2
 956  0105 be00          	ldw	x,c_y
 957  0107 89            	pushw	x
 958  0108 5204          	subw	sp,#4
 961                     ; 460 	buffer[counter] = UART2_ReceiveData8();
 963  010a b62d          	ld	a,_counter
 964  010c 5f            	clrw	x
 965  010d 97            	ld	xl,a
 966  010e 89            	pushw	x
 967  010f cd0000        	call	_UART2_ReceiveData8
 969  0112 85            	popw	x
 970  0113 e742          	ld	(_buffer,x),a
 971                     ; 462 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 973  0115 5f            	clrw	x
 974  0116 b62d          	ld	a,_counter
 975  0118 97            	ld	xl,a
 976  0119 e642          	ld	a,(_buffer,x)
 977  011b a10d          	cp	a,#13
 978  011d 2604          	jrne	L753
 981  011f 35010000      	mov	_STATUS_BIT,#1
 982  0123               L753:
 983                     ; 463 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 985  0123 b62d          	ld	a,_counter
 986  0125 5f            	clrw	x
 987  0126 97            	ld	xl,a
 988  0127 e642          	ld	a,(_buffer,x)
 989  0129 a10a          	cp	a,#10
 990  012b 264b          	jrne	L163
 992  012d b600          	ld	a,_STATUS_BIT
 993  012f 4a            	dec	a
 994  0130 2646          	jrne	L163
 995                     ; 469 	temp[0] = buffer[1];
 997  0132 b643          	ld	a,_buffer+1
 998  0134 6b02          	ld	(OFST-2,sp),a
 999                     ; 470 	temp[1] = buffer[2];
1001  0136 b644          	ld	a,_buffer+2
1002  0138 6b03          	ld	(OFST-1,sp),a
1003                     ; 471 	HexToByte(temp, &Addr);
1005  013a 96            	ldw	x,sp
1006  013b 5c            	incw	x
1007  013c 89            	pushw	x
1008  013d 5c            	incw	x
1009  013e cd0000        	call	_HexToByte
1011  0141 85            	popw	x
1012                     ; 473 		if(Addr == Address || Addr == 0)
1014  0142 7b01          	ld	a,(OFST-3,sp)
1015  0144 b12c          	cp	a,_Address
1016  0146 2704          	jreq	L563
1018  0148 7b01          	ld	a,(OFST-3,sp)
1019  014a 2619          	jrne	L363
1020  014c               L563:
1021                     ; 476 			for(i = 0; i<20; i++)
1023  014c 4f            	clr	a
1024  014d 6b04          	ld	(OFST+0,sp),a
1025  014f               L763:
1026                     ; 478 			word[i] = buffer[i];
1028  014f 5f            	clrw	x
1029  0150 97            	ld	xl,a
1030  0151 e642          	ld	a,(_buffer,x)
1031  0153 e72e          	ld	(_word,x),a
1032                     ; 479 			buffer[i] = '\0';	
1034  0155 5f            	clrw	x
1035  0156 7b04          	ld	a,(OFST+0,sp)
1036  0158 97            	ld	xl,a
1037  0159 6f42          	clr	(_buffer,x)
1038                     ; 476 			for(i = 0; i<20; i++)
1040  015b 0c04          	inc	(OFST+0,sp)
1043  015d 7b04          	ld	a,(OFST+0,sp)
1044  015f a114          	cp	a,#20
1045  0161 25ec          	jrult	L763
1046                     ; 481 			counter = 0;
1048  0163 200f          	jpf	LC001
1049  0165               L363:
1050                     ; 486 			for(i = 0; i<20; i++)
1052  0165 4f            	clr	a
1053  0166 6b04          	ld	(OFST+0,sp),a
1054  0168               L773:
1055                     ; 488 			buffer[i] = '\0';	
1057  0168 5f            	clrw	x
1058  0169 97            	ld	xl,a
1059  016a 6f42          	clr	(_buffer,x)
1060                     ; 486 			for(i = 0; i<20; i++)
1062  016c 0c04          	inc	(OFST+0,sp)
1065  016e 7b04          	ld	a,(OFST+0,sp)
1066  0170 a114          	cp	a,#20
1067  0172 25f4          	jrult	L773
1068                     ; 490 			counter = 0;
1070  0174               LC001:
1072  0174 3f2d          	clr	_counter
1073  0176 2002          	jra	L504
1074  0178               L163:
1075                     ; 496 	counter++;
1077  0178 3c2d          	inc	_counter
1078  017a               L504:
1079                     ; 499 	UART2_ClearITPendingBit(UART2_IT_RXNE);
1081  017a ae0255        	ldw	x,#597
1082  017d cd0000        	call	_UART2_ClearITPendingBit
1084                     ; 500 }
1087  0180 5b04          	addw	sp,#4
1088  0182 85            	popw	x
1089  0183 bf00          	ldw	c_y,x
1090  0185 320002        	pop	c_y+2
1091  0188 85            	popw	x
1092  0189 bf00          	ldw	c_x,x
1093  018b 320002        	pop	c_x+2
1094  018e 80            	iret	
1116                     ; 548  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
1116                     ; 549 {
1117                     	switch	.text
1118  018f               f_ADC1_IRQHandler:
1122                     ; 554 }
1125  018f 80            	iret	
1148                     ; 575  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1148                     ; 576 {
1149                     	switch	.text
1150  0190               f_TIM4_UPD_OVF_IRQHandler:
1154                     ; 580 }
1157  0190 80            	iret	
1180                     ; 588 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1180                     ; 589 {
1181                     	switch	.text
1182  0191               f_EEPROM_EEC_IRQHandler:
1186                     ; 593 }
1189  0191 80            	iret	
1279                     	switch	.ubsct
1280  0000               _TimmingDelay:
1281  0000 00000000      	ds.b	4
1282                     	xdef	_TimmingDelay
1283  0004               _Output_Registers:
1284  0004 000000000000  	ds.b	20
1285                     	xdef	_Output_Registers
1286  0018               _Input_Registers:
1287  0018 000000000000  	ds.b	20
1288                     	xdef	_Input_Registers
1289  002c               _Address:
1290  002c 00            	ds.b	1
1291                     	xdef	_Address
1292                     	xdef	_STATUS_BIT
1293  002d               _counter:
1294  002d 00            	ds.b	1
1295                     	xdef	_counter
1296  002e               _word:
1297  002e 000000000000  	ds.b	20
1298                     	xdef	_word
1299  0042               _buffer:
1300  0042 000000000000  	ds.b	20
1301                     	xdef	_buffer
1302                     	xref	_PresetSingleRegister
1303                     	xref	_ForceSingleCoil
1304                     	xref	_ReadInputRegisters
1305                     	xref	_ReadHoldingRegisters
1306                     	xref	_ReadInputStatus
1307                     	xref	_ReadCoilStatus
1308                     	xref	___checkFunc
1309                     	xref	_CheckLRC
1310                     	xref	_UART_SendStr
1311                     	xref	_HexToByte
1312                     	xdef	f_EEPROM_EEC_IRQHandler
1313                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1314                     	xdef	f_ADC1_IRQHandler
1315                     	xdef	f_UART2_TX_IRQHandler
1316                     	xdef	f_UART2_RX_IRQHandler
1317                     	xdef	f_I2C_IRQHandler
1318                     	xdef	f_TIM3_CAP_COM_IRQHandler
1319                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1320                     	xdef	f_TIM2_CAP_COM_IRQHandler
1321                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1322                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1323                     	xdef	f_TIM1_CAP_COM_IRQHandler
1324                     	xdef	f_SPI_IRQHandler
1325                     	xdef	f_EXTI_PORTE_IRQHandler
1326                     	xdef	f_EXTI_PORTD_IRQHandler
1327                     	xdef	f_EXTI_PORTC_IRQHandler
1328                     	xdef	f_EXTI_PORTB_IRQHandler
1329                     	xdef	f_EXTI_PORTA_IRQHandler
1330                     	xdef	f_CLK_IRQHandler
1331                     	xdef	f_AWU_IRQHandler
1332                     	xdef	f_TLI_IRQHandler
1333                     	xdef	f_TRAP_IRQHandler
1334                     	xdef	f_NonHandledInterrupt
1335                     	xref	_UART2_ClearITPendingBit
1336                     	xref	_UART2_ReceiveData8
1337                     	xref	_TIM3_ClearITPendingBit
1338                     	xref	_TIM2_ClearITPendingBit
1339                     .const:	section	.text
1340  0000               L742:
1341  0000 46756e637469  	dc.b	"Function 16 Handle"
1342  0012 6400          	dc.b	"d",0
1343  0014               L542:
1344  0014 46756e637469  	dc.b	"Function 6 Handled",0
1345  0027               L342:
1346  0027 46756e637469  	dc.b	"Function 5 Handled",0
1347  003a               L142:
1348  003a 46756e637469  	dc.b	"Function 4 Handled",0
1349                     	xref.b	c_x
1350                     	xref.b	c_y
1370                     	xref	c_lgsbc
1371                     	xref	c_lzmp
1372                     	end
