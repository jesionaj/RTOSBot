// 2015 Adam Jesionowski

#ifndef SDCARD_H
#define	SDCARD_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "task.h"
#include "queue.h"

// RB13 is CS
#define SD_CS BIT_13

extern Task_t  sdCard_task;
extern Queue_t sdCardQueue;

void sdCard_init();
void sdCard_main();

#ifdef	__cplusplus
}
#endif

#endif	/* SDCARD_H */

