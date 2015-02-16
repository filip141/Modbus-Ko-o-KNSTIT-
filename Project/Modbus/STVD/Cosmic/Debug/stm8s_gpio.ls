   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
   4                     ; Optimizer V4.3.6 - 29 Nov 2011
 113                     ; 47 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 113                     ; 48 {
 115                     	switch	.text
 116  0000               _GPIO_DeInit:
 120                     ; 49     GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 122  0000 7f            	clr	(x)
 123                     ; 50     GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 125  0001 6f02          	clr	(2,x)
 126                     ; 51     GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 128  0003 6f03          	clr	(3,x)
 129                     ; 52     GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 131  0005 6f04          	clr	(4,x)
 132                     ; 53 }
 135  0007 81            	ret	
 375                     ; 65 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 375                     ; 66 {
 376                     	switch	.text
 377  0008               _GPIO_Init:
 379  0008 89            	pushw	x
 380       00000000      OFST:	set	0
 383                     ; 71     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 385                     ; 72     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 387                     ; 75   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 389  0009 7b05          	ld	a,(OFST+5,sp)
 390  000b 43            	cpl	a
 391  000c e404          	and	a,(4,x)
 392  000e e704          	ld	(4,x),a
 393                     ; 81     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 395  0010 7b06          	ld	a,(OFST+6,sp)
 396  0012 2a18          	jrpl	L771
 397                     ; 83         if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 399  0014 a510          	bcp	a,#16
 400  0016 2705          	jreq	L102
 401                     ; 85             GPIOx->ODR |= (uint8_t)GPIO_Pin;
 403  0018 f6            	ld	a,(x)
 404  0019 1a05          	or	a,(OFST+5,sp)
 406  001b 2006          	jra	L302
 407  001d               L102:
 408                     ; 89             GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 410  001d 1e01          	ldw	x,(OFST+1,sp)
 411  001f 7b05          	ld	a,(OFST+5,sp)
 412  0021 43            	cpl	a
 413  0022 f4            	and	a,(x)
 414  0023               L302:
 415  0023 f7            	ld	(x),a
 416                     ; 92         GPIOx->DDR |= (uint8_t)GPIO_Pin;
 418  0024 1e01          	ldw	x,(OFST+1,sp)
 419  0026 e602          	ld	a,(2,x)
 420  0028 1a05          	or	a,(OFST+5,sp)
 422  002a 2007          	jra	L502
 423  002c               L771:
 424                     ; 97         GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 426  002c 1e01          	ldw	x,(OFST+1,sp)
 427  002e 7b05          	ld	a,(OFST+5,sp)
 428  0030 43            	cpl	a
 429  0031 e402          	and	a,(2,x)
 430  0033               L502:
 431  0033 e702          	ld	(2,x),a
 432                     ; 104     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 434  0035 7b06          	ld	a,(OFST+6,sp)
 435  0037 a540          	bcp	a,#64
 436  0039 2706          	jreq	L702
 437                     ; 106         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 439  003b e603          	ld	a,(3,x)
 440  003d 1a05          	or	a,(OFST+5,sp)
 442  003f 2005          	jra	L112
 443  0041               L702:
 444                     ; 110         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 446  0041 7b05          	ld	a,(OFST+5,sp)
 447  0043 43            	cpl	a
 448  0044 e403          	and	a,(3,x)
 449  0046               L112:
 450  0046 e703          	ld	(3,x),a
 451                     ; 117     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 453  0048 7b06          	ld	a,(OFST+6,sp)
 454  004a a520          	bcp	a,#32
 455  004c 2706          	jreq	L312
 456                     ; 119         GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 458  004e e604          	ld	a,(4,x)
 459  0050 1a05          	or	a,(OFST+5,sp)
 461  0052 2005          	jra	L512
 462  0054               L312:
 463                     ; 123         GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 465  0054 7b05          	ld	a,(OFST+5,sp)
 466  0056 43            	cpl	a
 467  0057 e404          	and	a,(4,x)
 468  0059               L512:
 469  0059 e704          	ld	(4,x),a
 470                     ; 125 }
 473  005b 85            	popw	x
 474  005c 81            	ret	
 520                     ; 135 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 520                     ; 136 {
 521                     	switch	.text
 522  005d               _GPIO_Write:
 524  005d 89            	pushw	x
 525       00000000      OFST:	set	0
 528                     ; 137     GPIOx->ODR = PortVal;
 530  005e 1e01          	ldw	x,(OFST+1,sp)
 531  0060 7b05          	ld	a,(OFST+5,sp)
 532  0062 f7            	ld	(x),a
 533                     ; 138 }
 536  0063 85            	popw	x
 537  0064 81            	ret	
 584                     ; 148 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 584                     ; 149 {
 585                     	switch	.text
 586  0065               _GPIO_WriteHigh:
 588  0065 89            	pushw	x
 589       00000000      OFST:	set	0
 592                     ; 150     GPIOx->ODR |= (uint8_t)PortPins;
 594  0066 f6            	ld	a,(x)
 595  0067 1a05          	or	a,(OFST+5,sp)
 596  0069 f7            	ld	(x),a
 597                     ; 151 }
 600  006a 85            	popw	x
 601  006b 81            	ret	
 648                     ; 161 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 648                     ; 162 {
 649                     	switch	.text
 650  006c               _GPIO_WriteLow:
 652  006c 89            	pushw	x
 653       00000000      OFST:	set	0
 656                     ; 163     GPIOx->ODR &= (uint8_t)(~PortPins);
 658  006d 7b05          	ld	a,(OFST+5,sp)
 659  006f 43            	cpl	a
 660  0070 f4            	and	a,(x)
 661  0071 f7            	ld	(x),a
 662                     ; 164 }
 665  0072 85            	popw	x
 666  0073 81            	ret	
 713                     ; 174 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 713                     ; 175 {
 714                     	switch	.text
 715  0074               _GPIO_WriteReverse:
 717  0074 89            	pushw	x
 718       00000000      OFST:	set	0
 721                     ; 176     GPIOx->ODR ^= (uint8_t)PortPins;
 723  0075 f6            	ld	a,(x)
 724  0076 1805          	xor	a,(OFST+5,sp)
 725  0078 f7            	ld	(x),a
 726                     ; 177 }
 729  0079 85            	popw	x
 730  007a 81            	ret	
 768                     ; 185 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 768                     ; 186 {
 769                     	switch	.text
 770  007b               _GPIO_ReadOutputData:
 774                     ; 187     return ((uint8_t)GPIOx->ODR);
 776  007b f6            	ld	a,(x)
 779  007c 81            	ret	
 816                     ; 196 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 816                     ; 197 {
 817                     	switch	.text
 818  007d               _GPIO_ReadInputData:
 822                     ; 198     return ((uint8_t)GPIOx->IDR);
 824  007d e601          	ld	a,(1,x)
 827  007f 81            	ret	
 895                     ; 207 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 895                     ; 208 {
 896                     	switch	.text
 897  0080               _GPIO_ReadInputPin:
 899  0080 89            	pushw	x
 900       00000000      OFST:	set	0
 903                     ; 209     return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 905  0081 e601          	ld	a,(1,x)
 906  0083 1405          	and	a,(OFST+5,sp)
 909  0085 85            	popw	x
 910  0086 81            	ret	
 988                     ; 219 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 988                     ; 220 {
 989                     	switch	.text
 990  0087               _GPIO_ExternalPullUpConfig:
 992  0087 89            	pushw	x
 993       00000000      OFST:	set	0
 996                     ; 222     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 998                     ; 223     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1000                     ; 225     if (NewState != DISABLE) /* External Pull-Up Set*/
1002  0088 7b06          	ld	a,(OFST+6,sp)
1003  008a 2706          	jreq	L374
1004                     ; 227         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1006  008c e603          	ld	a,(3,x)
1007  008e 1a05          	or	a,(OFST+5,sp)
1009  0090 2007          	jra	L574
1010  0092               L374:
1011                     ; 230         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
1013  0092 1e01          	ldw	x,(OFST+1,sp)
1014  0094 7b05          	ld	a,(OFST+5,sp)
1015  0096 43            	cpl	a
1016  0097 e403          	and	a,(3,x)
1017  0099               L574:
1018  0099 e703          	ld	(3,x),a
1019                     ; 232 }
1022  009b 85            	popw	x
1023  009c 81            	ret	
1036                     	xdef	_GPIO_ExternalPullUpConfig
1037                     	xdef	_GPIO_ReadInputPin
1038                     	xdef	_GPIO_ReadOutputData
1039                     	xdef	_GPIO_ReadInputData
1040                     	xdef	_GPIO_WriteReverse
1041                     	xdef	_GPIO_WriteLow
1042                     	xdef	_GPIO_WriteHigh
1043                     	xdef	_GPIO_Write
1044                     	xdef	_GPIO_Init
1045                     	xdef	_GPIO_DeInit
1064                     	end
