   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  19                     	bsct
  20  0000               _STATUS_BIT:
  21  0000 00            	dc.b	0
  51                     ; 70 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  51                     ; 71 {
  52                     	switch	.text
  53  0000               f_NonHandledInterrupt:
  57                     ; 75 }
  60  0000 80            	iret	
  82                     ; 83 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  82                     ; 84 {
  83                     	switch	.text
  84  0001               f_TRAP_IRQHandler:
  88                     ; 88 }
  91  0001 80            	iret	
 113                     ; 94 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 113                     ; 95 {
 114                     	switch	.text
 115  0002               f_TLI_IRQHandler:
 119                     ; 99 }
 122  0002 80            	iret	
 144                     ; 106 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 144                     ; 107 {
 145                     	switch	.text
 146  0003               f_AWU_IRQHandler:
 150                     ; 111 }
 153  0003 80            	iret	
 175                     ; 118 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 175                     ; 119 {
 176                     	switch	.text
 177  0004               f_CLK_IRQHandler:
 181                     ; 123 }
 184  0004 80            	iret	
 207                     ; 130 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 131 {
 208                     	switch	.text
 209  0005               f_EXTI_PORTA_IRQHandler:
 213                     ; 135 }
 216  0005 80            	iret	
 239                     ; 142 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 239                     ; 143 {
 240                     	switch	.text
 241  0006               f_EXTI_PORTB_IRQHandler:
 245                     ; 147 }
 248  0006 80            	iret	
 271                     ; 154 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 271                     ; 155 {
 272                     	switch	.text
 273  0007               f_EXTI_PORTC_IRQHandler:
 277                     ; 159 }
 280  0007 80            	iret	
 303                     ; 166 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 303                     ; 167 {
 304                     	switch	.text
 305  0008               f_EXTI_PORTD_IRQHandler:
 309                     ; 171 }
 312  0008 80            	iret	
 335                     ; 178 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 335                     ; 179 {
 336                     	switch	.text
 337  0009               f_EXTI_PORTE_IRQHandler:
 341                     ; 183 }
 344  0009 80            	iret	
 366                     ; 229 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 366                     ; 230 {
 367                     	switch	.text
 368  000a               f_SPI_IRQHandler:
 372                     ; 234 }
 375  000a 80            	iret	
 398                     ; 241 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 398                     ; 242 {
 399                     	switch	.text
 400  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 404                     ; 246 }
 407  000b 80            	iret	
 430                     ; 253 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 430                     ; 254 {
 431                     	switch	.text
 432  000c               f_TIM1_CAP_COM_IRQHandler:
 436                     ; 258 }
 439  000c 80            	iret	
 506                     ; 292  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 506                     ; 293 {
 507                     	switch	.text
 508  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 510  000d 8a            	push	cc
 511  000e 84            	pop	a
 512  000f a4bf          	and	a,#191
 513  0011 88            	push	a
 514  0012 86            	pop	cc
 515       00000004      OFST:	set	4
 516  0013 3b0002        	push	c_x+2
 517  0016 be00          	ldw	x,c_x
 518  0018 89            	pushw	x
 519  0019 3b0002        	push	c_y+2
 520  001c be00          	ldw	x,c_y
 521  001e 89            	pushw	x
 522  001f 5204          	subw	sp,#4
 525                     ; 298 	if(word[0] != '\0')
 527  0021 b62e          	ld	a,_word
 528  0023 2604aca600a6  	jreq	L132
 529                     ; 300 		if (CheckLRC(word))
 531  0029 ae002e        	ldw	x,#_word
 532  002c cd0000        	call	_CheckLRC
 534  002f 4d            	tnz	a
 535  0030 2765          	jreq	L332
 536                     ; 303 		tmp[0] = word[3];
 538  0032 b631          	ld	a,_word+3
 539  0034 6b01          	ld	(OFST-3,sp),a
 540                     ; 304 		tmp[1] = word[4];
 542  0036 b632          	ld	a,_word+4
 543  0038 6b02          	ld	(OFST-2,sp),a
 544                     ; 305 		HexToByte(tmp, &FunC);
 546  003a 96            	ldw	x,sp
 547  003b 1c0003        	addw	x,#OFST-1
 548  003e 89            	pushw	x
 549  003f 1d0002        	subw	x,#2
 550  0042 cd0000        	call	_HexToByte
 552  0045 85            	popw	x
 553                     ; 307 		if(__checkFunc(FunC))
 555  0046 7b03          	ld	a,(OFST-1,sp)
 556  0048 cd0000        	call	___checkFunc
 558  004b 4d            	tnz	a
 559  004c 2749          	jreq	L332
 560                     ; 310 			switch (FunC) 
 562  004e 7b03          	ld	a,(OFST-1,sp)
 564                     ; 353 			default: 
 564                     ; 354 				break;
 565  0050 4a            	dec	a
 566  0051 2718          	jreq	L161
 567  0053 4a            	dec	a
 568  0054 271d          	jreq	L361
 569  0056 4a            	dec	a
 570  0057 271f          	jreq	L561
 571  0059 4a            	dec	a
 572  005a 2724          	jreq	L761
 573  005c 4a            	dec	a
 574  005d 2726          	jreq	L171
 575  005f 4a            	dec	a
 576  0060 2728          	jreq	L371
 577  0062 a009          	sub	a,#9
 578  0064 2729          	jreq	L571
 579  0066 4a            	dec	a
 580  0067 272b          	jreq	L771
 581  0069 202c          	jra	L332
 582  006b               L161:
 583                     ; 312 			case 1:
 583                     ; 313 				//Function 1
 583                     ; 314 				ReadCoilStatus(Output_Registers);
 585  006b ae0004        	ldw	x,#_Output_Registers
 586  006e cd0000        	call	_ReadCoilStatus
 588                     ; 315 				break;
 590  0071 2024          	jra	L332
 591  0073               L361:
 592                     ; 317 			case 2:
 592                     ; 318 				//Function 2
 592                     ; 319 				ReadInputStatus();
 594  0073 cd0000        	call	_ReadInputStatus
 596                     ; 320 				break;
 598  0076 201f          	jra	L332
 599  0078               L561:
 600                     ; 322 			case 3: 
 600                     ; 323 				//Function 3
 600                     ; 324 				ReadHoldingRegisters(Output_Registers);
 602  0078 ae0004        	ldw	x,#_Output_Registers
 603  007b cd0000        	call	_ReadHoldingRegisters
 605                     ; 325 				break;
 607  007e 2017          	jra	L332
 608  0080               L761:
 609                     ; 327 			case 4: 
 609                     ; 328 				//Function 4
 609                     ; 329 				ReadInputRegisters();				
 611  0080 cd0000        	call	_ReadInputRegisters
 613                     ; 330 				break;
 615  0083 2012          	jra	L332
 616  0085               L171:
 617                     ; 332 			case 5: 
 617                     ; 333 				//Function 5
 617                     ; 334 				ForceSingleCoil();
 619  0085 cd0000        	call	_ForceSingleCoil
 621                     ; 335 				break;
 623  0088 200d          	jra	L332
 624  008a               L371:
 625                     ; 337 			case 6:
 625                     ; 338 				//Function 6
 625                     ; 339 				PresetSingleRegister();
 627  008a cd0000        	call	_PresetSingleRegister
 629                     ; 340 				break;
 631  008d 2008          	jra	L332
 632  008f               L571:
 633                     ; 342 				case 15:
 633                     ; 343 				//Function 15
 633                     ; 344 				ForceMultipleCoils();
 635  008f cd0000        	call	_ForceMultipleCoils
 637                     ; 345 				break;	
 639  0092 2003          	jra	L332
 640  0094               L771:
 641                     ; 347 			case 16:
 641                     ; 348 				//Function 16
 641                     ; 349 				ForceMultipleRegisters();
 643  0094 cd0000        	call	_ForceMultipleRegisters
 645                     ; 350 				break;
 647                     ; 353 			default: 
 647                     ; 354 				break;
 649  0097               L332:
 650                     ; 358 		for(i = 0; i<20; i++){word[i] = '\0';}
 652  0097 4f            	clr	a
 653  0098 6b04          	ld	(OFST+0,sp),a
 654  009a               L342:
 657  009a 5f            	clrw	x
 658  009b 97            	ld	xl,a
 659  009c 6f2e          	clr	(_word,x)
 662  009e 0c04          	inc	(OFST+0,sp)
 665  00a0 7b04          	ld	a,(OFST+0,sp)
 666  00a2 a114          	cp	a,#20
 667  00a4 25f4          	jrult	L342
 668  00a6               L132:
 669                     ; 360   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 671  00a6 a601          	ld	a,#1
 672  00a8 cd0000        	call	_TIM2_ClearITPendingBit
 674                     ; 361 }
 677  00ab 5b04          	addw	sp,#4
 678  00ad 85            	popw	x
 679  00ae bf00          	ldw	c_y,x
 680  00b0 320002        	pop	c_y+2
 681  00b3 85            	popw	x
 682  00b4 bf00          	ldw	c_x,x
 683  00b6 320002        	pop	c_x+2
 684  00b9 80            	iret	
 707                     ; 368  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 707                     ; 369 {
 708                     	switch	.text
 709  00ba               f_TIM2_CAP_COM_IRQHandler:
 713                     ; 373 }
 716  00ba 80            	iret	
 741                     ; 383  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 741                     ; 384 {
 742                     	switch	.text
 743  00bb               f_TIM3_UPD_OVF_BRK_IRQHandler:
 745  00bb 8a            	push	cc
 746  00bc 84            	pop	a
 747  00bd a4bf          	and	a,#191
 748  00bf 88            	push	a
 749  00c0 86            	pop	cc
 750  00c1 3b0002        	push	c_x+2
 751  00c4 be00          	ldw	x,c_x
 752  00c6 89            	pushw	x
 753  00c7 3b0002        	push	c_y+2
 754  00ca be00          	ldw	x,c_y
 755  00cc 89            	pushw	x
 758                     ; 386 	if(TimmingDelay !=0)
 760  00cd ae0000        	ldw	x,#_TimmingDelay
 761  00d0 cd0000        	call	c_lzmp
 763  00d3 2705          	jreq	L172
 764                     ; 388 		TimmingDelay--;
 766  00d5 a601          	ld	a,#1
 767  00d7 cd0000        	call	c_lgsbc
 769  00da               L172:
 770                     ; 390 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 772  00da a601          	ld	a,#1
 773  00dc cd0000        	call	_TIM3_ClearITPendingBit
 775                     ; 391 }
 778  00df 85            	popw	x
 779  00e0 bf00          	ldw	c_y,x
 780  00e2 320002        	pop	c_y+2
 781  00e5 85            	popw	x
 782  00e6 bf00          	ldw	c_x,x
 783  00e8 320002        	pop	c_x+2
 784  00eb 80            	iret	
 807                     ; 398  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 807                     ; 399 {
 808                     	switch	.text
 809  00ec               f_TIM3_CAP_COM_IRQHandler:
 813                     ; 403 }
 816  00ec 80            	iret	
 838                     ; 438 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 838                     ; 439 {
 839                     	switch	.text
 840  00ed               f_I2C_IRQHandler:
 844                     ; 443 }
 847  00ed 80            	iret	
 870                     ; 451  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 870                     ; 452 {
 871                     	switch	.text
 872  00ee               f_UART2_TX_IRQHandler:
 876                     ; 456   }
 879  00ee 80            	iret	
 940                     ; 464  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 940                     ; 465 {
 941                     	switch	.text
 942  00ef               f_UART2_RX_IRQHandler:
 944  00ef 8a            	push	cc
 945  00f0 84            	pop	a
 946  00f1 a4bf          	and	a,#191
 947  00f3 88            	push	a
 948  00f4 86            	pop	cc
 949       00000004      OFST:	set	4
 950  00f5 3b0002        	push	c_x+2
 951  00f8 be00          	ldw	x,c_x
 952  00fa 89            	pushw	x
 953  00fb 3b0002        	push	c_y+2
 954  00fe be00          	ldw	x,c_y
 955  0100 89            	pushw	x
 956  0101 5204          	subw	sp,#4
 959                     ; 467 	buffer[counter] = UART2_ReceiveData8();
 961  0103 b62d          	ld	a,_counter
 962  0105 5f            	clrw	x
 963  0106 97            	ld	xl,a
 964  0107 89            	pushw	x
 965  0108 cd0000        	call	_UART2_ReceiveData8
 967  010b 85            	popw	x
 968  010c e742          	ld	(_buffer,x),a
 969                     ; 469 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 971  010e 5f            	clrw	x
 972  010f b62d          	ld	a,_counter
 973  0111 97            	ld	xl,a
 974  0112 e642          	ld	a,(_buffer,x)
 975  0114 a10d          	cp	a,#13
 976  0116 2604          	jrne	L153
 979  0118 35010000      	mov	_STATUS_BIT,#1
 980  011c               L153:
 981                     ; 470 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 983  011c b62d          	ld	a,_counter
 984  011e 5f            	clrw	x
 985  011f 97            	ld	xl,a
 986  0120 e642          	ld	a,(_buffer,x)
 987  0122 a10a          	cp	a,#10
 988  0124 264b          	jrne	L353
 990  0126 b600          	ld	a,_STATUS_BIT
 991  0128 4a            	dec	a
 992  0129 2646          	jrne	L353
 993                     ; 476 	temp[0] = buffer[1];
 995  012b b643          	ld	a,_buffer+1
 996  012d 6b02          	ld	(OFST-2,sp),a
 997                     ; 477 	temp[1] = buffer[2];
 999  012f b644          	ld	a,_buffer+2
1000  0131 6b03          	ld	(OFST-1,sp),a
1001                     ; 478 	HexToByte(temp, &Addr);
1003  0133 96            	ldw	x,sp
1004  0134 5c            	incw	x
1005  0135 89            	pushw	x
1006  0136 5c            	incw	x
1007  0137 cd0000        	call	_HexToByte
1009  013a 85            	popw	x
1010                     ; 480 		if(Addr == Address || Addr == 0)
1012  013b 7b01          	ld	a,(OFST-3,sp)
1013  013d b12c          	cp	a,_Address
1014  013f 2704          	jreq	L753
1016  0141 7b01          	ld	a,(OFST-3,sp)
1017  0143 2619          	jrne	L553
1018  0145               L753:
1019                     ; 483 			for(i = 0; i<20; i++)
1021  0145 4f            	clr	a
1022  0146 6b04          	ld	(OFST+0,sp),a
1023  0148               L163:
1024                     ; 485 			word[i] = buffer[i];
1026  0148 5f            	clrw	x
1027  0149 97            	ld	xl,a
1028  014a e642          	ld	a,(_buffer,x)
1029  014c e72e          	ld	(_word,x),a
1030                     ; 486 			buffer[i] = '\0';	
1032  014e 5f            	clrw	x
1033  014f 7b04          	ld	a,(OFST+0,sp)
1034  0151 97            	ld	xl,a
1035  0152 6f42          	clr	(_buffer,x)
1036                     ; 483 			for(i = 0; i<20; i++)
1038  0154 0c04          	inc	(OFST+0,sp)
1041  0156 7b04          	ld	a,(OFST+0,sp)
1042  0158 a114          	cp	a,#20
1043  015a 25ec          	jrult	L163
1044                     ; 488 			counter = 0;
1046  015c 200f          	jpf	LC001
1047  015e               L553:
1048                     ; 493 			for(i = 0; i<20; i++)
1050  015e 4f            	clr	a
1051  015f 6b04          	ld	(OFST+0,sp),a
1052  0161               L173:
1053                     ; 495 			buffer[i] = '\0';	
1055  0161 5f            	clrw	x
1056  0162 97            	ld	xl,a
1057  0163 6f42          	clr	(_buffer,x)
1058                     ; 493 			for(i = 0; i<20; i++)
1060  0165 0c04          	inc	(OFST+0,sp)
1063  0167 7b04          	ld	a,(OFST+0,sp)
1064  0169 a114          	cp	a,#20
1065  016b 25f4          	jrult	L173
1066                     ; 497 			counter = 0;
1068  016d               LC001:
1070  016d 3f2d          	clr	_counter
1071  016f 2002          	jra	L773
1072  0171               L353:
1073                     ; 503 	counter++;
1075  0171 3c2d          	inc	_counter
1076  0173               L773:
1077                     ; 506 	UART2_ClearITPendingBit(UART2_IT_RXNE);
1079  0173 ae0255        	ldw	x,#597
1080  0176 cd0000        	call	_UART2_ClearITPendingBit
1082                     ; 507 }
1085  0179 5b04          	addw	sp,#4
1086  017b 85            	popw	x
1087  017c bf00          	ldw	c_y,x
1088  017e 320002        	pop	c_y+2
1089  0181 85            	popw	x
1090  0182 bf00          	ldw	c_x,x
1091  0184 320002        	pop	c_x+2
1092  0187 80            	iret	
1114                     ; 555  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
1114                     ; 556 {
1115                     	switch	.text
1116  0188               f_ADC1_IRQHandler:
1120                     ; 561 }
1123  0188 80            	iret	
1146                     ; 582  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1146                     ; 583 {
1147                     	switch	.text
1148  0189               f_TIM4_UPD_OVF_IRQHandler:
1152                     ; 587 }
1155  0189 80            	iret	
1178                     ; 595 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1178                     ; 596 {
1179                     	switch	.text
1180  018a               f_EEPROM_EEC_IRQHandler:
1184                     ; 600 }
1187  018a 80            	iret	
1277                     	switch	.ubsct
1278  0000               _TimmingDelay:
1279  0000 00000000      	ds.b	4
1280                     	xdef	_TimmingDelay
1281  0004               _Output_Registers:
1282  0004 000000000000  	ds.b	20
1283                     	xdef	_Output_Registers
1284  0018               _Input_Registers:
1285  0018 000000000000  	ds.b	20
1286                     	xdef	_Input_Registers
1287  002c               _Address:
1288  002c 00            	ds.b	1
1289                     	xdef	_Address
1290                     	xdef	_STATUS_BIT
1291  002d               _counter:
1292  002d 00            	ds.b	1
1293                     	xdef	_counter
1294  002e               _word:
1295  002e 000000000000  	ds.b	20
1296                     	xdef	_word
1297  0042               _buffer:
1298  0042 000000000000  	ds.b	20
1299                     	xdef	_buffer
1300                     	xref	_ForceMultipleRegisters
1301                     	xref	_ForceMultipleCoils
1302                     	xref	_PresetSingleRegister
1303                     	xref	_ForceSingleCoil
1304                     	xref	_ReadInputRegisters
1305                     	xref	_ReadHoldingRegisters
1306                     	xref	_ReadInputStatus
1307                     	xref	_ReadCoilStatus
1308                     	xref	___checkFunc
1309                     	xref	_CheckLRC
1310                     	xref	_HexToByte
1311                     	xdef	f_EEPROM_EEC_IRQHandler
1312                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1313                     	xdef	f_ADC1_IRQHandler
1314                     	xdef	f_UART2_TX_IRQHandler
1315                     	xdef	f_UART2_RX_IRQHandler
1316                     	xdef	f_I2C_IRQHandler
1317                     	xdef	f_TIM3_CAP_COM_IRQHandler
1318                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1319                     	xdef	f_TIM2_CAP_COM_IRQHandler
1320                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1321                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1322                     	xdef	f_TIM1_CAP_COM_IRQHandler
1323                     	xdef	f_SPI_IRQHandler
1324                     	xdef	f_EXTI_PORTE_IRQHandler
1325                     	xdef	f_EXTI_PORTD_IRQHandler
1326                     	xdef	f_EXTI_PORTC_IRQHandler
1327                     	xdef	f_EXTI_PORTB_IRQHandler
1328                     	xdef	f_EXTI_PORTA_IRQHandler
1329                     	xdef	f_CLK_IRQHandler
1330                     	xdef	f_AWU_IRQHandler
1331                     	xdef	f_TLI_IRQHandler
1332                     	xdef	f_TRAP_IRQHandler
1333                     	xdef	f_NonHandledInterrupt
1334                     	xref	_UART2_ClearITPendingBit
1335                     	xref	_UART2_ReceiveData8
1336                     	xref	_TIM3_ClearITPendingBit
1337                     	xref	_TIM2_ClearITPendingBit
1338                     	xref.b	c_x
1339                     	xref.b	c_y
1359                     	xref	c_lgsbc
1360                     	xref	c_lzmp
1361                     	end
