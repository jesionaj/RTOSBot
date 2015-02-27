// 2015 Adam Jesionowski

#include <xc.h>
#include <plib.h>
#include "config.h"
#include "motorTask.h"
#include "port.h"

static volatile bool lastRight;
static volatile bool lastLeft;

static volatile int8_t lCount;
static volatile int8_t rCount;

/*
 * Initialize change notification interrupt
 */
void InitEncoder()
{
    mPORTASetPinsDigitalIn(BIT_4);
    mPORTBSetPinsDigitalIn(BIT_10);

    lastRight = mPORTAReadBits(BIT_4);
    lastLeft  = mPORTBReadBits(BIT_10);

    mCNAOpen(CNA_ON, CNA4_ENABLE,  CNA_PULLUP_DISABLE_ALL);
    mCNBOpen(CNB_ON, CNB10_ENABLE, CNB_PULLUP_DISABLE_ALL);

    // Read corresponding registers to clear mismatch condition on CN input pins
    mPORTARead();
    mPORTBRead();

    // Set up the interrupt
    ConfigIntCNA(CHANGE_INT_ON | CHANGE_INT_PRI_2);
    ConfigIntCNB(CHANGE_INT_ON | CHANGE_INT_PRI_2);

    INTSetVectorPriority(INT_CHANGE_NOTICE_VECTOR, INT_PRIORITY_LEVEL_2);
    INTSetVectorSubPriority(INT_CHANGE_NOTICE_VECTOR, INT_SUB_PRIORITY_LEVEL_0);

    // Clear CN interrupt flag
    INTClearFlag(INT_CNA);
    INTClearFlag(INT_CNB);
}

/*
 * ISR for Change Notification
 */
void __ISR(_CHANGE_NOTICE_VECTOR, ipl2) EncoderIntWrapper(void);
void EncoderInt(void)
{
    // Read corresponding registers to clear mismatch condition on CN input pins
    uint16_t portA = mPORTARead();
    uint16_t portB = mPORTBRead();

    // Clear the interrupt flags
    // If one of these interrupts kicked things off but the other became true in the intervening period,
    // it's still okay to clear it here, as the change will be processed below
    INTClearFlag(INT_CNA);
    INTClearFlag(INT_CNB);

    // If right is different than from the last interrupt:
    if(lastRight != (bool)(portA & BIT_4))
    {
        lastRight = (bool)(portA & BIT_4);
        rCount++;
    }

    // If left is differrent than from the last interrupt:
    if(lastLeft != (bool)(portB & BIT_10))
    {
        lastLeft = (bool)(portB & BIT_10);
        lCount++;
    }
}

/*
 * Return and reset current encoder counts
 */
void __inline GetAndResetCounts(int8_t* left, int8_t* right)
{
    ENTER_CRITICAL_SECTION;
    *left  = lCount;
    *right = rCount;
    lCount = 0;
    rCount = 0;
    EXIT_CRITICAL_SECTION;
}
