// 2015 Adam Jesionowski

#ifndef MOTORTASK_H
#define	MOTORTASK_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "queue.h"
#include "task.h"
#include "event.h"

extern Task_t  motorTask_task;
extern Queue_t motorInputQueue;

void motorTask_init();
void motorTask_main();

void __inline GetMotorDirection(int8_t* leftDir, int8_t* rightDir);

#ifdef	__cplusplus
}
#endif

#endif	/* MOTORTASK_H */

