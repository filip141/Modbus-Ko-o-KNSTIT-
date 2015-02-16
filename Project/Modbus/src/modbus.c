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

void Modbus_Init(void)
{
//Clock divider equals 1.Clock 16MHz
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
//Clear bits 
	GPIO_DeInit(GPIOA);
	UART2_DeInit();
	TIM3_DeInit();
//Peripetial Initialization
	TIM3_TimeBaseInit(TIM3_PRESCALER_16, 999);
	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	UART2_Init(19200, UART2_WORDLENGTH_8D, UART2_STOPBITS_2,UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,UART2_MODE_TXRX_ENABLE );  
//Enable Periphs
	UART2_Cmd(ENABLE);
	TIM3_Cmd(ENABLE);
//Interrupt configuration
	UART2_ITConfig(UART2_IT_RXNE, ENABLE);
	TIM3_ITConfig(TIM3_IT_UPDATE, ENABLE);
#define MODBUS_EN
#ifndef DELAY_EN
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
#define DELAY_EN
#ifndef MODBUS_EN
	enableInterrupts();
#endif
}

//Delay Function
void Delay(uint32_t time)
{
	TimmingDelay = time;
	while(TimmingDelay != 0 );
}