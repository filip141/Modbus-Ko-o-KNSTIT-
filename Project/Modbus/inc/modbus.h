#ifndef __MODBUS_HEADER_H
#define __MODBUS_HEADER_H

/* Includes -----------------------------------------------*/
#include "stm8s.h"

/* Private defines -----------------------------------------------------------*/
#define BAUDRATE 19200
/* Private function prototypes -----------------------------------------------*/
void Delay_Init(void);
void Delay(uint32_t time);
void Modbus_Init(void);
void UART_SendStr(const char *s);
void ByteToHex(char *hexstring, uint8_t byte);
void HexToByte(char *hexstring, uint8_t *byte);
/* Private variables -----------------------------------------------------------*/
extern uint32_t TimmingDelay;
extern uint8_t buffer[20];
extern uint8_t word[20];


#endif