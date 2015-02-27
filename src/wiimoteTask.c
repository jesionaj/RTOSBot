// 2015 Adam Jesionowski

#include <xc.h>
#include <plib.h>
#include "wiimoteTask.h"
#include "motorTask.h"
#include "sdCard.h"
#include "serialLCD.h"
#include "config.h"
#include "rtos.h"

// Timer runs at 20 MHz, so we want 2,000,000 for 100 ms
#define TIMER_LENGTH (2000000UL)

static uintd_t wiimoteTask_stack[DFLT_STACK_SIZE] = {0};
Task_t wiimoteTask_task =
{
    PRIORITY_4,
    {NULL, NULL, &wiimoteTask_task},
    0,
    wiimoteTask_stack
};
static Event_t wiimoteSampleEvent;

/*
 * This is the callback that will occur when 100 ms have passed. This is on the OS stack,
 * and we want to kick off the wiimote task
 */
static void TriggerWiimoteSample()
{
    // This will ready the wiimote task and immediately switch to it
    TriggerEvent(&wiimoteSampleEvent);
    SwitchToHighestPriorityTaskFromISR();
}

void wiimoteTask_init()
{
    wiimoteTask_task.stackPtr = &wiimoteTask_stack[DFLT_STACK_SIZE-1];
    wiimoteTask_task.stackPtr = (uintd_t*)InitStack(wiimoteTask_task.stackPtr, wiimoteTask_main);

    wiimoteSampleEvent.blockedTasks = NULL;
}

void wiimoteTask_main()
{
    uint8_t buffer[6];  // Data from wiimote is 6 bytes long
    RobotState_t state = {0};
    int8_t leftDir;
    int8_t rightDir;

    // Wait for Wiimote to start up
    DelayCurrentTask(100);

    // Handshake with Wiimote
    StartWiimote();

    // Kick off the event timer. This auto-reloads and triggers the event every 100 ms
    // This is necessary for accurate timing so that our replay works properly
    TimerEnable(WIIMOTE_TIMER, TIMER_LENGTH, TriggerWiimoteSample, true);
    while(1)
    {
        GetAndResetCounts(&state.leftEncoderCount, &state.rightEncoderCount);

        // Figure out which direction the motors are moving in (sets as 1 or -1),
        // Then multiply accordingly. Wiimote Task is a higher task than Motor Task,
        // so it won't be able to prempt this.
        // TODO: This is a bad way of passing data between tasks, but a queue is too heavy
        // duty. Figure out a better method.
        GetMotorDirection(&leftDir, &rightDir);
        state.leftEncoderCount  *= leftDir;
        state.rightEncoderCount *= rightDir;
        
        // Get the joystick data
        WiimoteGetData(buffer);
        state.joystick.x = buffer[0];
        state.joystick.y = buffer[1];

        // Send the data off
        Enqueue(&motorInputQueue, (uint8_t*)&state.joystick);
        Enqueue(&lcdQueue, (uint8_t*)&state);
        Enqueue(&sdCardQueue, (uint8_t*)&state);

        // We'll complete the code above way before the event re-triggers
        // We do it this way because getting data from I2C takes a long time (~4 ms).
        WaitForEvent(&wiimoteSampleEvent);
    }
}
