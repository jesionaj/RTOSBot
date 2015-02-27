// 2015 Adam Jesionowski

#include <xc.h>
#include <plib.h>
#include "serialLCD.h"
#include "config.h"
#include "motorTask.h"
#include "rtos.h"
#include "wiimoteTask.h"
#include "port.h"

static uintd_t serialLCD_stack[DFLT_STACK_SIZE] = {0};
Task_t serialLCD_task =
{
    PRIORITY_2,
    {NULL, NULL, &serialLCD_task},
    0,
    serialLCD_stack
};

#define QUEUE_SIZE 6
static RobotState_t lcdStorage[QUEUE_SIZE];
Queue_t lcdQueue;

// Convert unsigned int to a string
static char* dec(uint8_t x, char *s);

void serialLCD_init()
{
    serialLCD_task.stackPtr = &serialLCD_stack[DFLT_STACK_SIZE-1];
    serialLCD_task.stackPtr = (uintd_t*)InitStack(serialLCD_task.stackPtr, serialLCD_main);

    InitQueue(&lcdQueue, (uint8_t*)lcdStorage, sizeof(RobotState_t), QUEUE_SIZE);

    PPSOutput(1,RPB15,U1TX); // Set RPF5 pin as output for U1TX

    UARTConfigure(UART1, UART_ENABLE_PINS_TX_RX_ONLY);
    UARTSetFifoMode(UART1, UART_INTERRUPT_ON_TX_NOT_FULL | UART_INTERRUPT_ON_RX_NOT_EMPTY);
    UARTSetLineControl(UART1, UART_DATA_SIZE_8_BITS | UART_PARITY_NONE | UART_STOP_BITS_1);
    UARTSetDataRate(UART1, PB_CLOCK, 9600);
    UARTEnable(UART1, UART_ENABLE_FLAGS(UART_PERIPHERAL | UART_TX));
}

void serialLCD_main()
{
    uint32_t i;
    char buffer[32];
    RobotState_t state;
    RobotState_t lastState = {0};

    // Since we can't display int16s, just show int8s
    int8_t totalLeftEncoderCount = 0;
    int8_t totalRightEncoderCount = 0;

    DelayCurrentTask(100);

    while(1)
    {
        DequeueBlocking(&lcdQueue, (uint8_t*)&state);
        
        // Only send the data if its changed
        if(lastState.joystick.x == state.joystick.x && lastState.joystick.y == state.joystick.y
                && state.leftEncoderCount == 0 && state.rightEncoderCount == 0)
            continue;

        // Zero out the LCD buffer
        for(i = 0; i < 32; i++){
    		buffer[i] = ' ';
    	}

        lastState = state;

        totalLeftEncoderCount  += state.leftEncoderCount;
        totalRightEncoderCount += state.rightEncoderCount;

        // Populate the buffer
        // First line
        buffer[0] = 0xFE;
        buffer[1] = 128;
        buffer[2] = 'X';
        buffer[3] = ':';
        dec(state.joystick.x, &buffer[8]);
        buffer[9] = 'Y';
        buffer[10] = ':';
        dec(state.joystick.y, &buffer[15]);

        // Second line
        buffer[16] = 0xFE;
        buffer[17] = 192;
        buffer[18] = 'L';
        buffer[19] = ':';
        dec((uint8_t)totalLeftEncoderCount, &buffer[24]);
        buffer[25] = 'R';
        buffer[26] = ':';
        dec((uint8_t)totalRightEncoderCount, &buffer[31]);

        for(i = 0; i < 32; i++){
            while(!UARTTransmitterIsReady(UART1));
            UARTSendDataByte(UART1, buffer[i]);
        }
    }
}

/*
 * Convert an unsigned 8-bit integer to a string. Taken from:
 * http://stackoverflow.com/questions/6920554/source-code-in-embedded-c-for-unsigned-integer-to-string
 */
static char* dec(uint8_t x, char *s)
{
    if(!x)
    {
        *--s = '0';
    }
    for (; x; x /= 10)
    {
        *--s = '0' + (x % 10);
    }
    return s;
}
