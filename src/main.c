// 2015 Adam Jesionowski

// Micro pinout:
// MCLR  1 --|         |-- 28 AVdd
// RA0   2 --|         |-- 27 GND
// RA1   3 --|         |-- 26 RB15
// Prgm  4 --|         |-- 25 RB14
// Prgm  5 --|         |-- 24 RB13
// RB2   6 --|         |-- 23 Vusb
// RB3   7 --|         |-- 22 RB11
// GND   8 --|         |-- 21 RB10
// RA2   9 --|         |-- 20 Vcap
// RA3  10 --|         |-- 19 GND
// RB4  11 --|         |-- 18 RB9
// RA4  12 --|         |-- 17 RB8
// Vdd  13 --|         |-- 16 RB7
// RB5  14 --|         |-- 15 VBus

// Connections:
// MCLR  1 --|         |-- 28 AVdd
// LED   2 --|         |-- 27 GND
// SDO   3 --|         |-- 26 U1TX
// Prgm  4 --|         |-- 25 SCLK
// Prgm  5 --|         |-- 24 CS
// Pin0  6 --|         |-- 23 Vusb
// Pin1  7 --|         |-- 22 SDI
// GND   8 --|         |-- 21 EncL
// Pin2  9 --|         |-- 20 Vcap
// Pin3 10 --|         |-- 19 GND
// Pin4 11 --|         |-- 18 SCA
// EncR 12 --|         |-- 17 SCL
// Vdd  13 --|         |-- 16 MtrL
// MtrR 14 --|         |-- 15 VBus

#include <xc.h>
#include <plib.h>

#include "rtos.h"
#include "port.h"
#include "blinkLED.h"
#include "serialLCD.h"
#include "motorTask.h"
#include "sdcard.h"
#include "wiimoteTask.h"
#include "encoder.h"

// Configuration Bits
#pragma config FNOSC = FRCPLL       // Internal Fast RC oscillator (8 MHz) w/ PLL
#pragma config FPLLIDIV = DIV_2     // Divide FRC before PLL (now 4 MHz)
#pragma config FPLLMUL = MUL_20     // PLL Multiply (now 80 MHz)
#pragma config FPLLODIV = DIV_2     // Divide After PLL (now 40 MHz)
                                    // see figure 8.1 in datasheet for more info
#pragma config FWDTEN = OFF         // Watchdog Timer Disabled
#pragma config ICESEL = ICS_PGx1    // ICE/ICD Comm Channel Select
#pragma config JTAGEN = OFF         // Disable JTAG
#pragma config FSOSCEN = OFF        // Disable Secondary Oscillator
#pragma config FPBDIV = DIV_2

void main(void)
{
    // Turn off JTAG
    DDPCONbits.JTAGEN = 0;

    SYSTEMConfig(SYS_FREQ, SYS_CFG_WAIT_STATES);

    // Initalize hardware and interrupts
    InitTickTimer();
    InitSoftwareInterrupt();
    InitHardwareTimer();
    InitI2C();
    InitEncoder();

    RTOS_Initialize();

    // Initialize tasks
    blinkLED_init();
    wiimoteTask_init();
    serialLCD_init();
    motorTask_init();
    sdCard_init();

    // Start tasks
    StartTask(&blinkLED_task);
    StartTask(&wiimoteTask_task);
    StartTask(&serialLCD_task);
    StartTask(&motorTask_task);
    StartTask(&sdCard_task);

    // Enable interrupts
    INTEnableSystemMultiVectoredInt();

    // Kick RTOS off
    StartFirstTask();

    // We should never get here.
    while(1);
}
