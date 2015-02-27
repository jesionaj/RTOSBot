// 2015 Adam Jesionowski

#ifndef BLINKLED_H
#define	BLINKLED_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "task.h"

extern Task_t blinkLED_task;

void blinkLED_init();
void blinkLED_main();

#ifdef	__cplusplus
}
#endif

#endif	/* BLINKLED_H */

