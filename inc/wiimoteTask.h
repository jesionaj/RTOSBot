// 2015 Adam Jesionowski

#ifndef WIIMOTETASK_H
#define	WIIMOTETASK_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "task.h"

typedef struct _joystickinput_t
{
    uint8_t x;
    uint8_t y;
} JoystickInput_t;

typedef struct _robotstate_t
{
    JoystickInput_t joystick;
    int8_t leftEncoderCount;
    int8_t rightEncoderCount;
} RobotState_t;

extern Task_t  wiimoteTask_task;

void wiimoteTask_init();
void wiimoteTask_main();

#ifdef	__cplusplus
}
#endif

#endif	/* WIIMOTETASK_H */

