// 2015 Adam Jesionowski

#ifndef CONFIG_H
#define	CONFIG_H

#include <stdbool.h>
#include <stdint.h>

#ifdef	__cplusplus
extern "C" {
#endif

#define SYS_FREQ (40000000L)
#define	PB_CLOCK (SYS_FREQ/(1 << OSCCONbits.PBDIV))

#define SWITCH_TO_NEXT_INT      CoreSetSoftwareInterrupt0()

#define ENTER_CRITICAL_SECTION  uint32_t intStatus = INTDisableInterrupts()
#define EXIT_CRITICAL_SECTION   INTRestoreInterrupts(intStatus)

#define READ_TIMER_REGISTER()   ReadCoreTimer()

/*
 * Datatype related
 */
#ifndef	NULL
    #define NULL (0)
#endif	/* NULL */

// Default size type (should be equal to width of processor)
typedef uint32_t uintd_t;

/*
 * Priority related
 */
#define NUM_PRIORITY_LEVELS 7
#define PRIORITY_0 0
#define PRIORITY_1 1
#define PRIORITY_2 2
#define PRIORITY_3 3
#define PRIORITY_4 4
#define PRIORITY_5 5
#define PRIORITY_6 6

#define PRIORITY_IDLE PRIORITY_0

/*
 * Stack related
 */
#define DFLT_STACK_SIZE	300
#define OS_STACK_SIZE   1000

// Define this if the stack grows upwards
#define STACK_GROWS_TOWARD_ZERO 1


/*
 * Timer related
 */
typedef enum {
    WIIMOTE_TIMER,
    NUM_TIMERS
} SW_TIMER;

typedef uintd_t TIME;
#define TIMER_MAX  0xFFFFFFFFUL // 32-bit uint max

/*
 * Test related
 */

// Define this if you're going to run unit tests.
//#define RUNTESTS

#ifdef RUNTESTS
    #define LOOP(b)
#else
    #define LOOP(b) while(b)
#endif



#ifdef	__cplusplus
}
#endif

#endif	/* PORT_TYPES_H */

