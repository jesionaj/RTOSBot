// 2015 Adam Jesionowski

#include <xc.h>
#include <plib.h>
#include "sdCard.h"
#include "config.h"
#include "rtos.h"
#include "port.h"
#include "queue.h"
#include "wiimoteTask.h"

#define STARTING_ADDRESS 1024 // Where we start putting the data on the SD card

static uintd_t sdCard_stack[DFLT_STACK_SIZE] = {0};
Task_t sdCard_task =
{
    PRIORITY_1,
    {NULL, NULL, &sdCard_task},
    0,
    sdCard_stack
};

// We send in blocks of 512 bytes, and RobotState is 4 bytes. Queue should be large enough that we have a buffer
#define QUEUE_SIZE 200
static RobotState_t sdCardQueueStorage[QUEUE_SIZE];
Queue_t sdCardQueue;

void sdCard_init()
{
    sdCard_task.stackPtr = &sdCard_stack[DFLT_STACK_SIZE-1];
    sdCard_task.stackPtr = (uintd_t*)InitStack(sdCard_task.stackPtr, sdCard_main);

    InitQueue(&sdCardQueue, (uint8_t*)sdCardQueueStorage, sizeof(RobotState_t), QUEUE_SIZE);

    mPORTBSetPinsDigitalOut(SD_CS);
    mPORTBSetBits(SD_CS);

    mPORTBSetPinsDigitalOut(BIT_4);
    mPORTBSetBits(BIT_4);

    PPSInput(2, SDI1, RPB11);
    PPSOutput(2, RPA1, SDO1);

    SpiChnOpen(SPI_CHANNEL1, SPI_MODE8_ON | SPI_SMP_ON | SPI_CKE_ON | MASTER_ENABLE_ON, 2);
}

void sdCard_main()
{
    RobotState_t tempState;
    uint32_t address = 1024;
    uintd_t i;
    uint8_t data[512];
    bool init = StartSDCard();

    uintd_t size;

    while(!init)
    {
        init = StartSDCard();
    }

    // Only do this if the card is initialized
    while(init)
    {
        // Alright, so instead of DequeueBlocking with a queue size of 128, we'd rather not drop data
        // As such, we'll just poll on the size, waiting for it to be greater than 128
        DelayCurrentTask(100);

        size = QueueSize(&sdCardQueue);
        if(size >= 128)
        {
            // When queue size is greater than 128, dequeue that data into our local array
            for(i = 0; i < 128; i++)
            {
                Dequeue(&sdCardQueue, (uint8_t*)&tempState);
                data[4*i]   = tempState.joystick.x;
                data[4*i+1] = tempState.joystick.y;
                data[4*i+2] = (uint8_t)tempState.leftEncoderCount;
                data[4*i+3] = (uint8_t)tempState.rightEncoderCount;
            }
            
            // Write the data to the SD card and increment the address
            WriteDataToSD(data, address);
            address += 512;

            mPORTBToggleBits(BIT_4);
        }
    }
}
