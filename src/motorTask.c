// 2015 Adam Jesionowski

#include <xc.h>
#include <plib.h>
#include "motorTask.h"
#include "config.h"
#include "rtos.h"
#include "wiimoteTask.h"

/*
 * Servo datasheet:
 * http://www.parallax.com/sites/default/files/downloads/900-00008-Continuous-Rotation-Servo-Documentation-v2.2.pdf
 *
 * These servos work by sending a 1.3 to 1.7 millisecond pulse. 1.3 is full cw, 1.7 is ccw, 1.5 is stopped.
 * It also requires a 20 ms wait time between pulses, regardless of pulse size.
 */

static uintd_t motorTask_stack[DFLT_STACK_SIZE] = {0};
Task_t motorTask_task =
{
    PRIORITY_3,
    {NULL, NULL, &motorTask_task},
    0,
    motorTask_stack
};

// Speed is the max speed the servos can go, which is +/- 200 ms. Converted to timer counts:
// 200 ms = x/40 MHz/(8*2) (8 prescalar on pb clock, which is 40 MHz/2), means x = 500
#define SPEED 500

// TODO: We do want a queue size of 1, but we want the newest data to take effect rather than
// dropping off. Not an issue for the way our code is set up (the intervals are slow enough
// that we won't run into issues with overflow), but could be useful in the future.
#define QUEUE_SIZE 1
static JoystickInput_t motorInputQueueStorage[QUEUE_SIZE];
Queue_t motorInputQueue;

// Direction each motor is heading
static volatile int8_t leftDirection;
static volatile int8_t rightDirection;

static bool InRange(uint8_t xIn, uint8_t yIn, uint8_t x, uint8_t y);
static void SetLeftPWM(uint16_t speed);
static void SetRightPWM(uint16_t speed);

/*
 * This gives the encoders a way of knowing where the motors are going
 */
void __inline GetMotorDirection(int8_t* leftDir, int8_t* rightDir)
{
    *leftDir  = leftDirection;
    *rightDir = rightDirection;
}

void motorTask_init()
{
    motorTask_task.stackPtr = &motorTask_stack[DFLT_STACK_SIZE-1];
    motorTask_task.stackPtr = (uintd_t*)InitStack(motorTask_task.stackPtr, motorTask_main);

    InitQueue(&motorInputQueue, (uint8_t*)motorInputQueueStorage, sizeof(JoystickInput_t), QUEUE_SIZE);

    mPORTBSetPinsDigitalOut(BIT_5 | BIT_7);
    PPSOutput(1,RPB7,OC1); // Set RPB7 pin as output for output compare module -- Left
    PPSOutput(2,RPB5,OC2); // Set RPB5 pin as output for output compare module -- Right

    // Default periods is 53750, where 50,000 = 20 ms off time, 3750 = 1.5 ms pulse time
    OpenTimer2(T2_ON | T2_PS_1_8, 53750);
    OpenTimer3(T3_ON | T3_PS_1_8, 53750);

    OpenOC1( OC_ON  | OC_TIMER2_SRC | OC_PWM_FAULT_PIN_DISABLE | OC_LOW_HIGH , 0, 0 );
    OpenOC2( OC_ON  | OC_TIMER3_SRC | OC_PWM_FAULT_PIN_DISABLE | OC_LOW_HIGH , 0, 0 );

    SetDCOC1PWM(3750);
    SetDCOC2PWM(3750);

    leftDirection  = 1;
    rightDirection = 1;
}

// Defines the range of values for which the joystick can fall into
#define RANGE 15

/*
 * Returns true if xIn and yIn are in range of the x and y
 */
static bool InRange(uint8_t xIn, uint8_t yIn, uint8_t x, uint8_t y)
{
    bool result = false;

    if(xIn > (x - RANGE) && xIn < (x + RANGE))
    {
        if(yIn > (y - RANGE) && yIn < (y + RANGE))
        {
            result = true;
        }
    }

    return result;
}

/*
 * Set the PWM registers.
 * These functions take a speed value from -500 to 500, and set the period and PWM registers accordingly.
 * The period needs to be changed as the servos required 20 ms of time inbetween the pulse times.
 */
static void SetLeftPWM(uint16_t speed)
{
    uint16_t adjustedSpeed = speed + 3750;
    uint16_t timerValue = 50000 + adjustedSpeed;
    SetDCOC1PWM(adjustedSpeed);

    T2CON = T2_PS_1_8;
    if(TMR2 > timerValue)
    {
        TMR2 = 0;
    }

    PR2 = timerValue;
    T2CONSET = T2_PS_1_8 | T2_ON;
}

static void SetRightPWM(uint16_t speed)
{
    uint16_t adjustedSpeed = speed + 3750;
    uint16_t timerValue = 50000 + adjustedSpeed;
    SetDCOC2PWM(adjustedSpeed);

    T3CON = T3_PS_1_8;
    if(TMR3 > timerValue)
    {
        TMR3 = 0;
    }
    
    PR3 = timerValue;
    T3CONSET = T3_PS_1_8 | T3_ON;
}

void motorTask_main()
{
    JoystickInput_t input;
    int16_t oldR = 0;
    int16_t oldL = 0;

    while(1)
    {
        DequeueBlocking(&motorInputQueue, (uint8_t*)&input);

        int16_t l = 0;
        int16_t r = 0;

        // The x and y values were found by recording the values for pushing the joystick
        // all the way in that direction. If it fits into none, just keep the default 0/0 central value
        if(InRange(input.x, input.y, 113, 217))
        {
            // Forward
            l = SPEED;
            r = -SPEED;
        }
        else if(InRange(input.x, input.y, 128, 18))
        {
            // Backward
            l = -SPEED;
            r = SPEED;
        }
        else if(InRange(input.x, input.y, 222, 115))
        {
            // Right
            l = SPEED;
            r = SPEED;
        }
        else if(InRange(input.x, input.y, 19, 128))
        {
            // Left
            l = -SPEED;
            r = -SPEED;
        }
        else if(InRange(input.x, input.y, 54, 164) || InRange(input.x, input.y, 15, 164))
        {
            // Forward Left
            // This one is a little weird, as it's either 54/164 or 8/164
            l = SPEED/8;
            r = -SPEED;
        }
        else if(InRange(input.x, input.y, 176, 153))
        {
            // Forward Right
            l = SPEED;
            r = -SPEED/8;
        }
        else if(InRange(input.x, input.y, 54, 52))
        {
            // Backward Left
            l = -SPEED/8;
            r = SPEED;
        }
        else if(InRange(input.x, input.y, 176, 54))
        {
            // Backward Right
            l = -SPEED;
            r = SPEED/8;
        }

        // Account for the way left and right motors are flipped
        if(l >= 0)
        {
            leftDirection = 1;
        }
        else
        {
            leftDirection = -1;
        }

        if(r < 0)
        {
            rightDirection = 1;
        }
        else
        {
            rightDirection = -1;
        }

        // Set PWM if the speeds for each motor has changed
        if(oldL != l)
        {
            SetLeftPWM(l);
            oldL = l;
        }

        if(oldR != r)
        {
            SetRightPWM(r);
            oldR = r;
        }
    }
}
