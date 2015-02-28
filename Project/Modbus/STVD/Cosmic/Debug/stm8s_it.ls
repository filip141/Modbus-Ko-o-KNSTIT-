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
 526  0023 2604acb900b9  	jreq	L722
 527                     ; 299 				if (!CheckLRC(word))
 529  0029 ae002e        	ldw	x,#_word
 530  002c cd0000        	call	_CheckLRC
 532  002f 4d            	tnz	a
 533  0030 2606          	jrne	L132
 534                     ; 301 						UART_SendStr("Error, LRC is not right.");
 536  0032 ae0060        	ldw	x,#L332
 537  0035 cd0000        	call	_UART_SendStr
 539  0038               L132:
 540                     ; 306 		tmp[0] = word[3];
 542  0038 b631          	ld	a,_word+3
 543  003a 6b01          	ld	(OFST-3,sp),a
 544                     ; 307 		tmp[1] = word[4];
 546  003c b632          	ld	a,_word+4
 547  003e 6b02          	ld	(OFST-2,sp),a
 548                     ; 308 		HexToByte(tmp, &FunC);
 550  0040 96            	ldw	x,sp
 551  0041 1c0003        	addw	x,#OFST-1
 552  0044 89            	pushw	x
 553  0045 1d0002        	subw	x,#2
 554  0048 cd0000        	call	_HexToByte
 556  004b 85            	popw	x
 557                     ; 310 		if(__checkFunc(FunC))
 559  004c 7b03          	ld	a,(OFST-1,sp)
 560  004e cd0000        	call	___checkFunc
 562  0051 4d            	tnz	a
 563  0052 2756          	jreq	L532
 564                     ; 313 			switch (FunC) 
 566  0054 7b03          	ld	a,(OFST-1,sp)
 568                     ; 351 			default: 
 568                     ; 352 				break;
 569  0056 4a            	dec	a
 570  0057 2715          	jreq	L161
 571  0059 4a            	dec	a
 572  005a 2717          	jreq	L361
 573  005c 4a            	dec	a
 574  005d 2719          	jreq	L561
 575  005f 4a            	dec	a
 576  0060 2721          	jreq	L761
 577  0062 4a            	dec	a
 578  0063 2729          	jreq	L171
 579  0065 4a            	dec	a
 580  0066 2731          	jreq	L371
 581  0068 a00a          	sub	a,#10
 582  006a 2738          	jreq	L571
 583  006c 203c          	jra	L532
 584  006e               L161:
 585                     ; 315 			case 1:
 585                     ; 316 				//Function 1
 585                     ; 317 				ReadCoilStatus();
 587  006e cd0000        	call	_ReadCoilStatus
 589                     ; 318 				break;
 591  0071 2037          	jra	L532
 592  0073               L361:
 593                     ; 319 			case 2:
 593                     ; 320 				//Function 2
 593                     ; 321 				ReadInputStatus();
 595  0073 cd0000        	call	_ReadInputStatus
 597                     ; 322 				break;
 599  0076 2032          	jra	L532
 600  0078               L561:
 601                     ; 323 			case 3: 
 601                     ; 324 				//Function 3
 601                     ; 325 				UART_SendStr("Function 3 Handled");
 603  0078 ae004d        	ldw	x,#L342
 604  007b cd0000        	call	_UART_SendStr
 606                     ; 326 				ReadHoldingRegisters();
 608  007e cd0000        	call	_ReadHoldingRegisters
 610                     ; 327 				break;
 612  0081 2027          	jra	L532
 613  0083               L761:
 614                     ; 329 			case 4: 
 614                     ; 330 				//Function 4
 614                     ; 331 				UART_SendStr("Function 4 Handled");
 616  0083 ae003a        	ldw	x,#L542
 617  0086 cd0000        	call	_UART_SendStr
 619                     ; 332 				ReadInputRegisters();
 621  0089 cd0000        	call	_ReadInputRegisters
 623                     ; 334 				break;
 625  008c 201c          	jra	L532
 626  008e               L171:
 627                     ; 335 			case 5: 
 627                     ; 336 				//Function 5
 627                     ; 337 				UART_SendStr("Function 5 Handled");
 629  008e ae0027        	ldw	x,#L742
 630  0091 cd0000        	call	_UART_SendStr
 632                     ; 338 				ForceSingleCoil();
 634  0094 cd0000        	call	_ForceSingleCoil
 636                     ; 339 				break;
 638  0097 2011          	jra	L532
 639  0099               L371:
 640                     ; 341 			case 6:
 640                     ; 342 				//Function 6
 640                     ; 343 				UART_SendStr("Function 6 Handled");
 642  0099 ae0014        	ldw	x,#L152
 643  009c cd0000        	call	_UART_SendStr
 645                     ; 344 				PresetSingleRegister();
 647  009f cd0000        	call	_PresetSingleRegister
 649                     ; 345 				break;
 651  00a2 2006          	jra	L532
 652  00a4               L571:
 653                     ; 347 			case 16:
 653                     ; 348 				//Function 16
 653                     ; 349 				UART_SendStr("Function 16 Handled");
 655  00a4 ae0000        	ldw	x,#L352
 656  00a7 cd0000        	call	_UART_SendStr
 658                     ; 350 				break;
 660                     ; 351 			default: 
 660                     ; 352 				break;
 662  00aa               L532:
 663                     ; 355 		for(i = 0; i<20; i++){word[i] = '\0';}
 665  00aa 4f            	clr	a
 666  00ab 6b04          	ld	(OFST+0,sp),a
 667  00ad               L552:
 670  00ad 5f            	clrw	x
 671  00ae 97            	ld	xl,a
 672  00af 6f2e          	clr	(_word,x)
 675  00b1 0c04          	inc	(OFST+0,sp)
 678  00b3 7b04          	ld	a,(OFST+0,sp)
 679  00b5 a114          	cp	a,#20
 680  00b7 25f4          	jrult	L552
 681  00b9               L722:
 682                     ; 357   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 684  00b9 a601          	ld	a,#1
 685  00bb cd0000        	call	_TIM2_ClearITPendingBit
 687                     ; 358 }
 690  00be 5b04          	addw	sp,#4
 691  00c0 85            	popw	x
 692  00c1 bf00          	ldw	c_y,x
 693  00c3 320002        	pop	c_y+2
 694  00c6 85            	popw	x
 695  00c7 bf00          	ldw	c_x,x
 696  00c9 320002        	pop	c_x+2
 697  00cc 80            	iret	
 720                     ; 365  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 720                     ; 366 {
 721                     	switch	.text
 722  00cd               f_TIM2_CAP_COM_IRQHandler:
 726                     ; 370 }
 729  00cd 80            	iret	
 754                     ; 380  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 754                     ; 381 {
 755                     	switch	.text
 756  00ce               f_TIM3_UPD_OVF_BRK_IRQHandler:
 758  00ce 8a            	push	cc
 759  00cf 84            	pop	a
 760  00d0 a4bf          	and	a,#191
 761  00d2 88            	push	a
 762  00d3 86            	pop	cc
 763  00d4 3b0002        	push	c_x+2
 764  00d7 be00          	ldw	x,c_x
 765  00d9 89            	pushw	x
 766  00da 3b0002        	push	c_y+2
 767  00dd be00          	ldw	x,c_y
 768  00df 89            	pushw	x
 771                     ; 383 	if(TimmingDelay !=0)
 773  00e0 ae0000        	ldw	x,#_TimmingDelay
 774  00e3 cd0000        	call	c_lzmp
 776  00e6 2705          	jreq	L303
 777                     ; 385 		TimmingDelay--;
 779  00e8 a601          	ld	a,#1
 780  00ea cd0000        	call	c_lgsbc
 782  00ed               L303:
 783                     ; 387 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 785  00ed a601          	ld	a,#1
 786  00ef cd0000        	call	_TIM3_ClearITPendingBit
 788                     ; 388 }
 791  00f2 85            	popw	x
 792  00f3 bf00          	ldw	c_y,x
 793  00f5 320002        	pop	c_y+2
 794  00f8 85            	popw	x
 795  00f9 bf00          	ldw	c_x,x
 796  00fb 320002        	pop	c_x+2
 797  00fe 80            	iret	
 820                     ; 395  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 820                     ; 396 {
 821                     	switch	.text
 822  00ff               f_TIM3_CAP_COM_IRQHandler:
 826                     ; 400 }
 829  00ff 80            	iret	
 851                     ; 435 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 851                     ; 436 {
 852                     	switch	.text
 853  0100               f_I2C_IRQHandler:
 857                     ; 440 }
 860  0100 80            	iret	
 883                     ; 448  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 883                     ; 449 {
 884                     	switch	.text
 885  0101               f_UART2_TX_IRQHandler:
 889                     ; 453   }
 892  0101 80            	iret	
 953                     ; 461  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 953                     ; 462 {
 954                     	switch	.text
 955  0102               f_UART2_RX_IRQHandler:
 957  0102 8a            	push	cc
 958  0103 84            	pop	a
 959  0104 a4bf          	and	a,#191
 960  0106 88            	push	a
 961  0107 86            	pop	cc
 962       00000004      OFST:	set	4
 963  0108 3b0002        	push	c_x+2
 964  010b be00          	ldw	x,c_x
 965  010d 89            	pushw	x
 966  010e 3b0002        	push	c_y+2
 967  0111 be00          	ldw	x,c_y
 968  0113 89            	pushw	x
 969  0114 5204          	subw	sp,#4
 972                     ; 464 	buffer[counter] = UART2_ReceiveData8();
 974  0116 b62d          	ld	a,_counter
 975  0118 5f            	clrw	x
 976  0119 97            	ld	xl,a
 977  011a 89            	pushw	x
 978  011b cd0000        	call	_UART2_ReceiveData8
 980  011e 85            	popw	x
 981  011f e742          	ld	(_buffer,x),a
 982                     ; 466 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 984  0121 5f            	clrw	x
 985  0122 b62d          	ld	a,_counter
 986  0124 97            	ld	xl,a
 987  0125 e642          	ld	a,(_buffer,x)
 988  0127 a10d          	cp	a,#13
 989  0129 2604          	jrne	L363
 992  012b 35010000      	mov	_STATUS_BIT,#1
 993  012f               L363:
 994                     ; 467 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 996  012f b62d          	ld	a,_counter
 997  0131 5f            	clrw	x
 998  0132 97            	ld	xl,a
 999  0133 e642          	ld	a,(_buffer,x)
1000  0135 a10a          	cp	a,#10
1001  0137 264b          	jrne	L563
1003  0139 b600          	ld	a,_STATUS_BIT
1004  013b 4a            	dec	a
1005  013c 2646          	jrne	L563
1006                     ; 473 	temp[0] = buffer[1];
1008  013e b643          	ld	a,_buffer+1
1009  0140 6b02          	ld	(OFST-2,sp),a
1010                     ; 474 	temp[1] = buffer[2];
1012  0142 b644          	ld	a,_buffer+2
1013  0144 6b03          	ld	(OFST-1,sp),a
1014                     ; 475 	HexToByte(temp, &Addr);
1016  0146 96            	ldw	x,sp
1017  0147 5c            	incw	x
1018  0148 89            	pushw	x
1019  0149 5c            	incw	x
1020  014a cd0000        	call	_HexToByte
1022  014d 85            	popw	x
1023                     ; 477 		if(Addr == Address || Addr == 0)
1025  014e 7b01          	ld	a,(OFST-3,sp)
1026  0150 b12c          	cp	a,_Address
1027  0152 2704          	jreq	L173
1029  0154 7b01          	ld	a,(OFST-3,sp)
1030  0156 2619          	jrne	L763
1031  0158               L173:
1032                     ; 480 			for(i = 0; i<20; i++)
1034  0158 4f            	clr	a
1035  0159 6b04          	ld	(OFST+0,sp),a
1036  015b               L373:
1037                     ; 482 			word[i] = buffer[i];
1039  015b 5f            	clrw	x
1040  015c 97            	ld	xl,a
1041  015d e642          	ld	a,(_buffer,x)
1042  015f e72e          	ld	(_word,x),a
1043                     ; 483 			buffer[i] = '\0';	
1045  0161 5f            	clrw	x
1046  0162 7b04          	ld	a,(OFST+0,sp)
1047  0164 97            	ld	xl,a
1048  0165 6f42          	clr	(_buffer,x)
1049                     ; 480 			for(i = 0; i<20; i++)
1051  0167 0c04          	inc	(OFST+0,sp)
1054  0169 7b04          	ld	a,(OFST+0,sp)
1055  016b a114          	cp	a,#20
1056  016d 25ec          	jrult	L373
1057                     ; 485 			counter = 0;
1059  016f 200f          	jpf	LC001
1060  0171               L763:
1061                     ; 490 			for(i = 0; i<20; i++)
1063  0171 4f            	clr	a
1064  0172 6b04          	ld	(OFST+0,sp),a
1065  0174               L304:
1066                     ; 492 			buffer[i] = '\0';	
1068  0174 5f            	clrw	x
1069  0175 97            	ld	xl,a
1070  0176 6f42          	clr	(_buffer,x)
1071                     ; 490 			for(i = 0; i<20; i++)
1073  0178 0c04          	inc	(OFST+0,sp)
1076  017a 7b04          	ld	a,(OFST+0,sp)
1077  017c a114          	cp	a,#20
1078  017e 25f4          	jrult	L304
1079                     ; 494 			counter = 0;
1081  0180               LC001:
1083  0180 3f2d          	clr	_counter
1084  0182 2002          	jra	L114
1085  0184               L563:
1086                     ; 500 	counter++;
1088  0184 3c2d          	inc	_counter
1089  0186               L114:
1090                     ; 503 	UART2_ClearITPendingBit(UART2_IT_RXNE);
1092  0186 ae0255        	ldw	x,#597
1093  0189 cd0000        	call	_UART2_ClearITPendingBit
1095                     ; 504 }
1098  018c 5b04          	addw	sp,#4
1099  018e 85            	popw	x
1100  018f bf00          	ldw	c_y,x
1101  0191 320002        	pop	c_y+2
1102  0194 85            	popw	x
1103  0195 bf00          	ldw	c_x,x
1104  0197 320002        	pop	c_x+2
1105  019a 80            	iret	
1127                     ; 552  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
1127                     ; 553 {
1128                     	switch	.text
1129  019b               f_ADC1_IRQHandler:
1133                     ; 558 }
1136  019b 80            	iret	
1159                     ; 579  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1159                     ; 580 {
1160                     	switch	.text
1161  019c               f_TIM4_UPD_OVF_IRQHandler:
1165                     ; 584 }
1168  019c 80            	iret	
1191                     ; 592 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1191                     ; 593 {
1192                     	switch	.text
1193  019d               f_EEPROM_EEC_IRQHandler:
1197                     ; 597 }
1200  019d 80            	iret	
1290                     	switch	.ubsct
1291  0000               _TimmingDelay:
1292  0000 00000000      	ds.b	4
1293                     	xdef	_TimmingDelay
1294  0004               _Output_Registers:
1295  0004 000000000000  	ds.b	20
1296                     	xdef	_Output_Registers
1297  0018               _Input_Registers:
1298  0018 000000000000  	ds.b	20
1299                     	xdef	_Input_Registers
1300  002c               _Address:
1301  002c 00            	ds.b	1
1302                     	xdef	_Address
1303                     	xdef	_STATUS_BIT
1304  002d               _counter:
1305  002d 00            	ds.b	1
1306                     	xdef	_counter
1307  002e               _word:
1308  002e 000000000000  	ds.b	20
1309                     	xdef	_word
1310  0042               _buffer:
1311  0042 000000000000  	ds.b	20
1312                     	xdef	_buffer
1313                     	xref	_PresetSingleRegister
1314                     	xref	_ForceSingleCoil
1315                     	xref	_ReadInputRegisters
1316                     	xref	_ReadHoldingRegisters
1317                     	xref	_ReadInputStatus
1318                     	xref	_ReadCoilStatus
1319                     	xref	___checkFunc
1320                     	xref	_CheckLRC
1321                     	xref	_UART_SendStr
1322                     	xref	_HexToByte
1323                     	xdef	f_EEPROM_EEC_IRQHandler
1324                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1325                     	xdef	f_ADC1_IRQHandler
1326                     	xdef	f_UART2_TX_IRQHandler
1327                     	xdef	f_UART2_RX_IRQHandler
1328                     	xdef	f_I2C_IRQHandler
1329                     	xdef	f_TIM3_CAP_COM_IRQHandler
1330                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1331                     	xdef	f_TIM2_CAP_COM_IRQHandler
1332                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1333                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1334                     	xdef	f_TIM1_CAP_COM_IRQHandler
1335                     	xdef	f_SPI_IRQHandler
1336                     	xdef	f_EXTI_PORTE_IRQHandler
1337                     	xdef	f_EXTI_PORTD_IRQHandler
1338                     	xdef	f_EXTI_PORTC_IRQHandler
1339                     	xdef	f_EXTI_PORTB_IRQHandler
1340                     	xdef	f_EXTI_PORTA_IRQHandler
1341                     	xdef	f_CLK_IRQHandler
1342                     	xdef	f_AWU_IRQHandler
1343                     	xdef	f_TLI_IRQHandler
1344                     	xdef	f_TRAP_IRQHandler
1345                     	xdef	f_NonHandledInterrupt
1346                     	xref	_UART2_ClearITPendingBit
1347                     	xref	_UART2_ReceiveData8
1348                     	xref	_TIM3_ClearITPendingBit
1349                     	xref	_TIM2_ClearITPendingBit
1350                     .const:	section	.text
1351  0000               L352:
1352  0000 46756e637469  	dc.b	"Function 16 Handle"
1353  0012 6400          	dc.b	"d",0
1354  0014               L152:
1355  0014 46756e637469  	dc.b	"Function 6 Handled",0
1356  0027               L742:
1357  0027 46756e637469  	dc.b	"Function 5 Handled",0
1358  003a               L542:
1359  003a 46756e637469  	dc.b	"Function 4 Handled",0
1360  004d               L342:
1361  004d 46756e637469  	dc.b	"Function 3 Handled",0
1362  0060               L332:
1363  0060 4572726f722c  	dc.b	"Error, LRC is not "
1364  0072 72696768742e  	dc.b	"right.",0
1365                     	xref.b	c_x
1366                     	xref.b	c_y
1386                     	xref	c_lgsbc
1387                     	xref	c_lzmp
1388                     	end
