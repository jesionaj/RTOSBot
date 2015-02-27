// 2015 Adam Jesionowski

#include <xc.h>
#include <plib.h>
#include "blinkLED.h"
#include "config.h"

static uintd_t blinkLED_stack[DFLT_STACK_SIZE] = {0};
Task_t blinkLED_task =
{
    PRIORITY_1,
    {NULL, NULL, &blinkLED_task},
    0,
    blinkLED_stack
};

void blinkLED_init()
{
    mPORTAClearBits(BIT_0);
    mPORTASetPinsDigitalOut(BIT_0);

    blinkLED_task.stackPtr = &blinkLED_stack[DFLT_STACK_SIZE-1];
    blinkLED_task.stackPtr = (uintd_t*)InitStack(blinkLED_task.stackPtr, blinkLED_main);
}

void blinkLED_main()
{
    while(1)
    {
        mPORTASetBits(BIT_0);
        DelayCurrentTask(5);
        mPORTAClearBits(BIT_0);
        DelayCurrentTask(25);
    }
}
