   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  19                     	bsct
  20  0000               _STATUS_BIT:
  21  0000 00            	dc.b	0
  51                     ; 68 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  51                     ; 69 {
  52                     	switch	.text
  53  0000               f_NonHandledInterrupt:
  57                     ; 73 }
  60  0000 80            	iret	
  82                     ; 81 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  82                     ; 82 {
  83                     	switch	.text
  84  0001               f_TRAP_IRQHandler:
  88                     ; 86 }
  91  0001 80            	iret	
 113                     ; 92 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 113                     ; 93 {
 114                     	switch	.text
 115  0002               f_TLI_IRQHandler:
 119                     ; 97 }
 122  0002 80            	iret	
 144                     ; 104 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 144                     ; 105 {
 145                     	switch	.text
 146  0003               f_AWU_IRQHandler:
 150                     ; 109 }
 153  0003 80            	iret	
 175                     ; 116 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 175                     ; 117 {
 176                     	switch	.text
 177  0004               f_CLK_IRQHandler:
 181                     ; 121 }
 184  0004 80            	iret	
 207                     ; 128 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 129 {
 208                     	switch	.text
 209  0005               f_EXTI_PORTA_IRQHandler:
 213                     ; 133 }
 216  0005 80            	iret	
 239                     ; 140 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 239                     ; 141 {
 240                     	switch	.text
 241  0006               f_EXTI_PORTB_IRQHandler:
 245                     ; 145 }
 248  0006 80            	iret	
 271                     ; 152 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 271                     ; 153 {
 272                     	switch	.text
 273  0007               f_EXTI_PORTC_IRQHandler:
 277                     ; 157 }
 280  0007 80            	iret	
 303                     ; 164 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 303                     ; 165 {
 304                     	switch	.text
 305  0008               f_EXTI_PORTD_IRQHandler:
 309                     ; 169 }
 312  0008 80            	iret	
 335                     ; 176 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 335                     ; 177 {
 336                     	switch	.text
 337  0009               f_EXTI_PORTE_IRQHandler:
 341                     ; 181 }
 344  0009 80            	iret	
 366                     ; 227 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 366                     ; 228 {
 367                     	switch	.text
 368  000a               f_SPI_IRQHandler:
 372                     ; 232 }
 375  000a 80            	iret	
 398                     ; 239 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 398                     ; 240 {
 399                     	switch	.text
 400  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 404                     ; 244 }
 407  000b 80            	iret	
 430                     ; 251 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 430                     ; 252 {
 431                     	switch	.text
 432  000c               f_TIM1_CAP_COM_IRQHandler:
 436                     ; 256 }
 439  000c 80            	iret	
 504                     ; 290  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 504                     ; 291 {
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
 523                     ; 296 	if(word[0] != '\0')
 525  0021 b62e          	ld	a,_word
 526  0023 2604acb000b0  	jreq	L722
 527                     ; 298 		CheckCRC(word);
 529  0029 ae002e        	ldw	x,#_word
 530  002c cd0000        	call	_CheckCRC
 532                     ; 302 		tmp[0] = word[3];
 534  002f b631          	ld	a,_word+3
 535  0031 6b01          	ld	(OFST-3,sp),a
 536                     ; 303 		tmp[1] = word[4];
 538  0033 b632          	ld	a,_word+4
 539  0035 6b02          	ld	(OFST-2,sp),a
 540                     ; 304 		HexToByte(tmp, &FunC);
 542  0037 96            	ldw	x,sp
 543  0038 1c0003        	addw	x,#OFST-1
 544  003b 89            	pushw	x
 545  003c 1d0002        	subw	x,#2
 546  003f cd0000        	call	_HexToByte
 548  0042 85            	popw	x
 549                     ; 306 		if(__checkFunc(FunC))
 551  0043 7b03          	ld	a,(OFST-1,sp)
 552  0045 cd0000        	call	___checkFunc
 554  0048 4d            	tnz	a
 555  0049 2756          	jreq	L132
 556                     ; 309 			switch (FunC) 
 558  004b 7b03          	ld	a,(OFST-1,sp)
 560                     ; 347 			default: 
 560                     ; 348 				break;
 561  004d 4a            	dec	a
 562  004e 2715          	jreq	L161
 563  0050 4a            	dec	a
 564  0051 2717          	jreq	L361
 565  0053 4a            	dec	a
 566  0054 2719          	jreq	L561
 567  0056 4a            	dec	a
 568  0057 2721          	jreq	L761
 569  0059 4a            	dec	a
 570  005a 2729          	jreq	L171
 571  005c 4a            	dec	a
 572  005d 2731          	jreq	L371
 573  005f a00a          	sub	a,#10
 574  0061 2738          	jreq	L571
 575  0063 203c          	jra	L132
 576  0065               L161:
 577                     ; 311 			case 1:
 577                     ; 312 				//Function 1
 577                     ; 313 				ReadCoilStatus();
 579  0065 cd0000        	call	_ReadCoilStatus
 581                     ; 314 				break;
 583  0068 2037          	jra	L132
 584  006a               L361:
 585                     ; 315 			case 2:
 585                     ; 316 				//Function 2
 585                     ; 317 				ReadInputStatus();
 587  006a cd0000        	call	_ReadInputStatus
 589                     ; 318 				break;
 591  006d 2032          	jra	L132
 592  006f               L561:
 593                     ; 319 			case 3: 
 593                     ; 320 				//Function 3
 593                     ; 321 				UART_SendStr("Function 3 Handled");
 595  006f ae004d        	ldw	x,#L732
 596  0072 cd0000        	call	_UART_SendStr
 598                     ; 322 				ReadHoldingRegisters();
 600  0075 cd0000        	call	_ReadHoldingRegisters
 602                     ; 323 				break;
 604  0078 2027          	jra	L132
 605  007a               L761:
 606                     ; 325 			case 4: 
 606                     ; 326 				//Function 4
 606                     ; 327 				UART_SendStr("Function 4 Handled");
 608  007a ae003a        	ldw	x,#L142
 609  007d cd0000        	call	_UART_SendStr
 611                     ; 328 				ReadInputRegisters();
 613  0080 cd0000        	call	_ReadInputRegisters
 615                     ; 330 				break;
 617  0083 201c          	jra	L132
 618  0085               L171:
 619                     ; 331 			case 5: 
 619                     ; 332 				//Function 5
 619                     ; 333 				UART_SendStr("Function 5 Handled");
 621  0085 ae0027        	ldw	x,#L342
 622  0088 cd0000        	call	_UART_SendStr
 624                     ; 334 				ForceSingleCoil();
 626  008b cd0000        	call	_ForceSingleCoil
 628                     ; 335 				break;
 630  008e 2011          	jra	L132
 631  0090               L371:
 632                     ; 337 			case 6:
 632                     ; 338 				//Function 6
 632                     ; 339 				UART_SendStr("Function 6 Handled");
 634  0090 ae0014        	ldw	x,#L542
 635  0093 cd0000        	call	_UART_SendStr
 637                     ; 340 				PresetSingleRegister();
 639  0096 cd0000        	call	_PresetSingleRegister
 641                     ; 341 				break;
 643  0099 2006          	jra	L132
 644  009b               L571:
 645                     ; 343 			case 16:
 645                     ; 344 				//Function 16
 645                     ; 345 				UART_SendStr("Function 16 Handled");
 647  009b ae0000        	ldw	x,#L742
 648  009e cd0000        	call	_UART_SendStr
 650                     ; 346 				break;
 652                     ; 347 			default: 
 652                     ; 348 				break;
 654  00a1               L132:
 655                     ; 351 		for(i = 0; i<20; i++){word[i] = '\0';}
 657  00a1 4f            	clr	a
 658  00a2 6b04          	ld	(OFST+0,sp),a
 659  00a4               L152:
 662  00a4 5f            	clrw	x
 663  00a5 97            	ld	xl,a
 664  00a6 6f2e          	clr	(_word,x)
 667  00a8 0c04          	inc	(OFST+0,sp)
 670  00aa 7b04          	ld	a,(OFST+0,sp)
 671  00ac a114          	cp	a,#20
 672  00ae 25f4          	jrult	L152
 673  00b0               L722:
 674                     ; 353   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 676  00b0 a601          	ld	a,#1
 677  00b2 cd0000        	call	_TIM2_ClearITPendingBit
 679                     ; 354 }
 682  00b5 5b04          	addw	sp,#4
 683  00b7 85            	popw	x
 684  00b8 bf00          	ldw	c_y,x
 685  00ba 320002        	pop	c_y+2
 686  00bd 85            	popw	x
 687  00be bf00          	ldw	c_x,x
 688  00c0 320002        	pop	c_x+2
 689  00c3 80            	iret	
 712                     ; 361  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 712                     ; 362 {
 713                     	switch	.text
 714  00c4               f_TIM2_CAP_COM_IRQHandler:
 718                     ; 366 }
 721  00c4 80            	iret	
 746                     ; 376  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 746                     ; 377 {
 747                     	switch	.text
 748  00c5               f_TIM3_UPD_OVF_BRK_IRQHandler:
 750  00c5 8a            	push	cc
 751  00c6 84            	pop	a
 752  00c7 a4bf          	and	a,#191
 753  00c9 88            	push	a
 754  00ca 86            	pop	cc
 755  00cb 3b0002        	push	c_x+2
 756  00ce be00          	ldw	x,c_x
 757  00d0 89            	pushw	x
 758  00d1 3b0002        	push	c_y+2
 759  00d4 be00          	ldw	x,c_y
 760  00d6 89            	pushw	x
 763                     ; 379 	if(TimmingDelay !=0)
 765  00d7 ae0000        	ldw	x,#_TimmingDelay
 766  00da cd0000        	call	c_lzmp
 768  00dd 2705          	jreq	L772
 769                     ; 381 		TimmingDelay--;
 771  00df a601          	ld	a,#1
 772  00e1 cd0000        	call	c_lgsbc
 774  00e4               L772:
 775                     ; 383 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 777  00e4 a601          	ld	a,#1
 778  00e6 cd0000        	call	_TIM3_ClearITPendingBit
 780                     ; 384 }
 783  00e9 85            	popw	x
 784  00ea bf00          	ldw	c_y,x
 785  00ec 320002        	pop	c_y+2
 786  00ef 85            	popw	x
 787  00f0 bf00          	ldw	c_x,x
 788  00f2 320002        	pop	c_x+2
 789  00f5 80            	iret	
 812                     ; 391  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 812                     ; 392 {
 813                     	switch	.text
 814  00f6               f_TIM3_CAP_COM_IRQHandler:
 818                     ; 396 }
 821  00f6 80            	iret	
 843                     ; 431 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 843                     ; 432 {
 844                     	switch	.text
 845  00f7               f_I2C_IRQHandler:
 849                     ; 436 }
 852  00f7 80            	iret	
 875                     ; 444  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 875                     ; 445 {
 876                     	switch	.text
 877  00f8               f_UART2_TX_IRQHandler:
 881                     ; 449   }
 884  00f8 80            	iret	
 945                     ; 457  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 945                     ; 458 {
 946                     	switch	.text
 947  00f9               f_UART2_RX_IRQHandler:
 949  00f9 8a            	push	cc
 950  00fa 84            	pop	a
 951  00fb a4bf          	and	a,#191
 952  00fd 88            	push	a
 953  00fe 86            	pop	cc
 954       00000004      OFST:	set	4
 955  00ff 3b0002        	push	c_x+2
 956  0102 be00          	ldw	x,c_x
 957  0104 89            	pushw	x
 958  0105 3b0002        	push	c_y+2
 959  0108 be00          	ldw	x,c_y
 960  010a 89            	pushw	x
 961  010b 5204          	subw	sp,#4
 964                     ; 460 	buffer[counter] = UART2_ReceiveData8();
 966  010d b62d          	ld	a,_counter
 967  010f 5f            	clrw	x
 968  0110 97            	ld	xl,a
 969  0111 89            	pushw	x
 970  0112 cd0000        	call	_UART2_ReceiveData8
 972  0115 85            	popw	x
 973  0116 e742          	ld	(_buffer,x),a
 974                     ; 462 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 976  0118 5f            	clrw	x
 977  0119 b62d          	ld	a,_counter
 978  011b 97            	ld	xl,a
 979  011c e642          	ld	a,(_buffer,x)
 980  011e a10d          	cp	a,#13
 981  0120 2604          	jrne	L753
 984  0122 35010000      	mov	_STATUS_BIT,#1
 985  0126               L753:
 986                     ; 463 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 988  0126 b62d          	ld	a,_counter
 989  0128 5f            	clrw	x
 990  0129 97            	ld	xl,a
 991  012a e642          	ld	a,(_buffer,x)
 992  012c a10a          	cp	a,#10
 993  012e 264b          	jrne	L163
 995  0130 b600          	ld	a,_STATUS_BIT
 996  0132 4a            	dec	a
 997  0133 2646          	jrne	L163
 998                     ; 469 	temp[0] = buffer[1];
1000  0135 b643          	ld	a,_buffer+1
1001  0137 6b02          	ld	(OFST-2,sp),a
1002                     ; 470 	temp[1] = buffer[2];
1004  0139 b644          	ld	a,_buffer+2
1005  013b 6b03          	ld	(OFST-1,sp),a
1006                     ; 471 	HexToByte(temp, &Addr);
1008  013d 96            	ldw	x,sp
1009  013e 5c            	incw	x
1010  013f 89            	pushw	x
1011  0140 5c            	incw	x
1012  0141 cd0000        	call	_HexToByte
1014  0144 85            	popw	x
1015                     ; 473 		if(Addr == Address || Addr == 0)
1017  0145 7b01          	ld	a,(OFST-3,sp)
1018  0147 b12c          	cp	a,_Address
1019  0149 2704          	jreq	L563
1021  014b 7b01          	ld	a,(OFST-3,sp)
1022  014d 2619          	jrne	L363
1023  014f               L563:
1024                     ; 476 			for(i = 0; i<20; i++)
1026  014f 4f            	clr	a
1027  0150 6b04          	ld	(OFST+0,sp),a
1028  0152               L763:
1029                     ; 478 			word[i] = buffer[i];
1031  0152 5f            	clrw	x
1032  0153 97            	ld	xl,a
1033  0154 e642          	ld	a,(_buffer,x)
1034  0156 e72e          	ld	(_word,x),a
1035                     ; 479 			buffer[i] = '\0';	
1037  0158 5f            	clrw	x
1038  0159 7b04          	ld	a,(OFST+0,sp)
1039  015b 97            	ld	xl,a
1040  015c 6f42          	clr	(_buffer,x)
1041                     ; 476 			for(i = 0; i<20; i++)
1043  015e 0c04          	inc	(OFST+0,sp)
1046  0160 7b04          	ld	a,(OFST+0,sp)
1047  0162 a114          	cp	a,#20
1048  0164 25ec          	jrult	L763
1049                     ; 481 			counter = 0;
1051  0166 200f          	jpf	LC001
1052  0168               L363:
1053                     ; 486 			for(i = 0; i<20; i++)
1055  0168 4f            	clr	a
1056  0169 6b04          	ld	(OFST+0,sp),a
1057  016b               L773:
1058                     ; 488 			buffer[i] = '\0';	
1060  016b 5f            	clrw	x
1061  016c 97            	ld	xl,a
1062  016d 6f42          	clr	(_buffer,x)
1063                     ; 486 			for(i = 0; i<20; i++)
1065  016f 0c04          	inc	(OFST+0,sp)
1068  0171 7b04          	ld	a,(OFST+0,sp)
1069  0173 a114          	cp	a,#20
1070  0175 25f4          	jrult	L773
1071                     ; 490 			counter = 0;
1073  0177               LC001:
1075  0177 3f2d          	clr	_counter
1076  0179 2002          	jra	L504
1077  017b               L163:
1078                     ; 496 	counter++;
1080  017b 3c2d          	inc	_counter
1081  017d               L504:
1082                     ; 499 	UART2_ClearITPendingBit(UART2_IT_RXNE);
1084  017d ae0255        	ldw	x,#597
1085  0180 cd0000        	call	_UART2_ClearITPendingBit
1087                     ; 500 }
1090  0183 5b04          	addw	sp,#4
1091  0185 85            	popw	x
1092  0186 bf00          	ldw	c_y,x
1093  0188 320002        	pop	c_y+2
1094  018b 85            	popw	x
1095  018c bf00          	ldw	c_x,x
1096  018e 320002        	pop	c_x+2
1097  0191 80            	iret	
1119                     ; 548  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
1119                     ; 549 {
1120                     	switch	.text
1121  0192               f_ADC1_IRQHandler:
1125                     ; 554 }
1128  0192 80            	iret	
1151                     ; 575  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1151                     ; 576 {
1152                     	switch	.text
1153  0193               f_TIM4_UPD_OVF_IRQHandler:
1157                     ; 580 }
1160  0193 80            	iret	
1183                     ; 588 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1183                     ; 589 {
1184                     	switch	.text
1185  0194               f_EEPROM_EEC_IRQHandler:
1189                     ; 593 }
1192  0194 80            	iret	
1282                     	switch	.ubsct
1283  0000               _TimmingDelay:
1284  0000 00000000      	ds.b	4
1285                     	xdef	_TimmingDelay
1286  0004               _Output_Registers:
1287  0004 000000000000  	ds.b	20
1288                     	xdef	_Output_Registers
1289  0018               _Input_Registers:
1290  0018 000000000000  	ds.b	20
1291                     	xdef	_Input_Registers
1292  002c               _Address:
1293  002c 00            	ds.b	1
1294                     	xdef	_Address
1295                     	xdef	_STATUS_BIT
1296  002d               _counter:
1297  002d 00            	ds.b	1
1298                     	xdef	_counter
1299  002e               _word:
1300  002e 000000000000  	ds.b	20
1301                     	xdef	_word
1302  0042               _buffer:
1303  0042 000000000000  	ds.b	20
1304                     	xdef	_buffer
1305                     	xref	_PresetSingleRegister
1306                     	xref	_ForceSingleCoil
1307                     	xref	_ReadInputRegisters
1308                     	xref	_ReadHoldingRegisters
1309                     	xref	_ReadInputStatus
1310                     	xref	_ReadCoilStatus
1311                     	xref	___checkFunc
1312                     	xref	_CheckCRC
1313                     	xref	_UART_SendStr
1314                     	xref	_HexToByte
1315                     	xdef	f_EEPROM_EEC_IRQHandler
1316                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1317                     	xdef	f_ADC1_IRQHandler
1318                     	xdef	f_UART2_TX_IRQHandler
1319                     	xdef	f_UART2_RX_IRQHandler
1320                     	xdef	f_I2C_IRQHandler
1321                     	xdef	f_TIM3_CAP_COM_IRQHandler
1322                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1323                     	xdef	f_TIM2_CAP_COM_IRQHandler
1324                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1325                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1326                     	xdef	f_TIM1_CAP_COM_IRQHandler
1327                     	xdef	f_SPI_IRQHandler
1328                     	xdef	f_EXTI_PORTE_IRQHandler
1329                     	xdef	f_EXTI_PORTD_IRQHandler
1330                     	xdef	f_EXTI_PORTC_IRQHandler
1331                     	xdef	f_EXTI_PORTB_IRQHandler
1332                     	xdef	f_EXTI_PORTA_IRQHandler
1333                     	xdef	f_CLK_IRQHandler
1334                     	xdef	f_AWU_IRQHandler
1335                     	xdef	f_TLI_IRQHandler
1336                     	xdef	f_TRAP_IRQHandler
1337                     	xdef	f_NonHandledInterrupt
1338                     	xref	_UART2_ClearITPendingBit
1339                     	xref	_UART2_ReceiveData8
1340                     	xref	_TIM3_ClearITPendingBit
1341                     	xref	_TIM2_ClearITPendingBit
1342                     .const:	section	.text
1343  0000               L742:
1344  0000 46756e637469  	dc.b	"Function 16 Handle"
1345  0012 6400          	dc.b	"d",0
1346  0014               L542:
1347  0014 46756e637469  	dc.b	"Function 6 Handled",0
1348  0027               L342:
1349  0027 46756e637469  	dc.b	"Function 5 Handled",0
1350  003a               L142:
1351  003a 46756e637469  	dc.b	"Function 4 Handled",0
1352  004d               L732:
1353  004d 46756e637469  	dc.b	"Function 3 Handled",0
1354                     	xref.b	c_x
1355                     	xref.b	c_y
1375                     	xref	c_lgsbc
1376                     	xref	c_lzmp
1377                     	end
