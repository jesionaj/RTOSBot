// 2015 Adam Jesionowski

#include <xc.h>
#include <plib.h>
#include "config.h"
#include "port.h"

// TODO: There are no timeouts, so the wiimote could get stuck.

#define WII_I2C_BUS     I2C1
#define WII_ADDRESS     0x52
#define I2C_CLOCK_FREQ  100000

/*
 * Send the I2C start
 */
static bool StartTransfer(bool restart)
{
    I2C_STATUS status;

    // Send the Start (or Restart) signal
    if(restart)
    {
        I2CRepeatStart(WII_I2C_BUS);
    }
    else
    {
        // Wait for the bus to be idle, then start the transfer
        while(!I2CBusIsIdle(WII_I2C_BUS));

        if(I2CStart(WII_I2C_BUS) != I2C_SUCCESS)
        {
            return false;
        }
    }

    // Wait for the signal to complete
    do
    {
        status = I2CGetStatus(WII_I2C_BUS);
    } while(!(status & I2C_START));

    return true;
}

/*
 * Send a single byte
 */
static bool TransmitOneByte(uint8_t data)
{
    // Wait for the transmitter to be ready
    while(!I2CTransmitterIsReady(WII_I2C_BUS));

    // Transmit the byte
    if(I2CSendByte(WII_I2C_BUS, data) == I2C_MASTER_BUS_COLLISION)
    {
        return false;
    }

    // Wait for the transmission to finish
    while(!I2CTransmissionHasCompleted(WII_I2C_BUS));

    return true;
}

/*
 * Send the I2C stop
 */
static void StopTransfer()
{
    I2C_STATUS status;

    // Send the Stop signal
    I2CStop(WII_I2C_BUS);

    // Wait for the signal to complete
    do
    {
        status = I2CGetStatus(WII_I2C_BUS);
    } while (!(status & I2C_STOP));
}

/*
 * Initialize the I2C hardware
 */
void InitI2C()
{
    I2CConfigure(WII_I2C_BUS, I2C_ENABLE_SLAVE_CLOCK_STRETCHING);
    I2CSetFrequency(WII_I2C_BUS, SYS_FREQ/2, I2C_CLOCK_FREQ);

    // This needs to be set or it disables RA0
    I2C1CONbits.DISSLW = 1;

    I2CEnable(WII_I2C_BUS, true);
}

/*
 * Let the Wiimote know it should start
 */
void StartWiimote()
{
    I2C_7_BIT_ADDRESS   SlaveAddress;

    I2C_FORMAT_7_BIT_ADDRESS(SlaveAddress, WII_ADDRESS, I2C_WRITE);

    // 0x40 tells the Wiimote to start
    StartTransfer(false);
    TransmitOneByte(SlaveAddress.byte);
    TransmitOneByte(0x40);
    TransmitOneByte(0x00);
    StopTransfer();
}

/*
 * Get data from the wiimote.
 */
void WiimoteGetData(uint8_t* buffer)
{
    uintd_t       i;
    I2C_7_BIT_ADDRESS   SlaveAddress;

    // Send a write and 0x00, which requests data
    I2C_FORMAT_7_BIT_ADDRESS(SlaveAddress, WII_ADDRESS, I2C_WRITE);
    StartTransfer(true);
    TransmitOneByte(SlaveAddress.byte);
    TransmitOneByte(0x00);
    StopTransfer();

    // Wait for Wiimote to sample (not sure if this value is too high)
    DelayCurrentTask(3);

    // Now want to read
    StartTransfer(true);
    I2C_FORMAT_7_BIT_ADDRESS(SlaveAddress, WII_ADDRESS, I2C_READ);
    TransmitOneByte(SlaveAddress.byte);

    // There are six bytes in total, recieve and ACK the first 5
    for(i = 0; i < 5; i++)
    {
        I2CReceiverEnable(WII_I2C_BUS, true);
        while(!I2CReceivedDataIsAvailable(WII_I2C_BUS));
        I2CAcknowledgeByte(WII_I2C_BUS, true);
        while(!I2CAcknowledgeHasCompleted(WII_I2C_BUS));

        buffer[i] = I2CGetByte(WII_I2C_BUS);
    }

    // NACK the last byte
    I2CReceiverEnable(WII_I2C_BUS, true);
    while(!I2CReceivedDataIsAvailable(WII_I2C_BUS));
    I2CAcknowledgeByte(WII_I2C_BUS, false);
    while(!I2CAcknowledgeHasCompleted(WII_I2C_BUS));

    buffer[5] = I2CGetByte(WII_I2C_BUS);

    StopTransfer();
}
