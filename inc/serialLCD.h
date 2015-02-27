// 2015 Adam Jesionowski

#ifndef SERIALLCD_H
#define	SERIALLCD_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "task.h"
#include "queue.h"

extern Task_t serialLCD_task;
extern Queue_t lcdQueue;

void serialLCD_init();
void serialLCD_main();

#ifdef	__cplusplus
}
#endif

#endif	/* SERIALLCD_H */

