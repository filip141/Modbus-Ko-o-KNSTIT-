#include "modbus.h"


//Method to send strings via UART
void UART_SendStr(const char *s)
{
	//Set Max485 in Transmitter mode
	GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
	while(*s)
	{
	UART2_SendData8((uint8_t)(*s));
	while ((UART2->SR & UART2_SR_TXE ) != UART2_SR_TXE );
	s++;
	}
	//Set Max485 in Receiver mode
	GPIO_WriteLow(GPIOA, GPIO_PIN_3);
}

//Modbus Initialization
void Modbus_Init(void)
{
//Clock divider equals 1.Clock 16MHz
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
//Clear bits 
	GPIO_DeInit(GPIOA);
	UART2_DeInit();
//Peripetial Initialization
	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	UART2_Init(BAUDRATE, UART2_WORDLENGTH_8D, UART2_STOPBITS_2,UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,UART2_MODE_TXRX_ENABLE );  
//Enable Periphs
	UART2_Cmd(ENABLE);
//Interrupt configuration
	UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);
#ifndef __DELAY_EN
	#define __MODBUS_EN
	enableInterrupts();
#endif
}

void Delay_Init(void)
{
//Clear bits 
	TIM3_DeInit();
//Peripetial Initialization
	TIM3_TimeBaseInit(TIM3_PRESCALER_16, 999);
//Enable Periphs
	TIM3_Cmd(ENABLE);
//Interrupt configuration
	TIM3_ITConfig(TIM3_IT_UPDATE, ENABLE);
#ifndef __MODBUS_EN
	#define __DELAY_EN
	enableInterrupts();
#endif
}

//Delay Function
void Delay(uint32_t time)
{
	TimmingDelay = time;
	while(TimmingDelay != 0 );
}

//Byte to HexString. ASCII coding
void ByteToHex(char *hexstring, uint8_t byte)
{
	char fhex;
	char lhex;
	uint8_t fchar = (byte & 0b11110000) >> 4 ;
	uint8_t lchar = (byte & 0b00001111) ; 
	
	if( fchar >= 0 && fchar <= 9 )
	{
		fhex = (char)(fchar+48);
	}
	else
	{
		fhex = (char)(fchar+55);
	}
		if( lchar >= 0 && lchar <= 9 )
	{
		lhex = (char)(lchar+48);
	}
		else
	{
		lhex = (char)(lchar+55);
	}
	hexstring[0] = fhex;
	hexstring[1] = lhex;
}
//HexString to Byte.ASCII decoding
void HexToByte(char *hexstring, uint8_t *byte)
{
	char fhex;
	char lhex;
	uint16_t tmpb;
	uint8_t fchar;
	uint8_t lchar;
	fhex	= hexstring[0];
	lhex = hexstring[1];
	if( ((int)fhex) >= 48 && ((int)fhex) <= 57 )
	{
		fchar = ((int)fhex) - 48; 
	}
	else
	{
		fchar = ((int)fhex) - 55;
	}
		if( ((int)lhex) >= 48 && ((int)lhex) <= 57 )
	{
		lchar = ((int)lhex) - 48; 
	}
	else
	{
		lchar = ((int)lhex) - 55;
	}
	tmpb = ((fchar<<4) | lchar);
	*byte =  (uint8_t)tmpb; 
	
}