// 2015 Adam Jesionowski

#include <xc.h>
#include <plib.h>
#include "sdCard.h"

// TODO: There are no timeouts in these whiles, so the SD card could get stuck.

/*
 * Send a byte and return the response
 */
static uint8_t SendData(uint8_t data)
{
    SpiChnPutC(SPI_CHANNEL1, data);
    return SpiChnGetC(SPI_CHANNEL1);
}

/*
 * 0xFF means the slave did not return any information. Keep sending dummy values
 * until we get a response.
 */
static uint8_t GetResponse()
{
    uint8_t rcv = 0xFF;

    while(rcv == 0xFF)
    {
        rcv = SendData(0xFF);
    }

    return rcv;
}

/*
 * Send a SD card command
 */
static void SendCommand(uint8_t cmd, uint8_t param1, uint8_t param2, uint8_t param3, uint8_t param4)
{
    uint8_t crc;

    // A little bit of a hack here, CMD0 is the only command we'll be sending with a CRC,
    // which has a known value of 0x95.
    if(cmd == 0)
    {
        crc = 0x95;
    }
    else
    {
        crc = 0xFF;
    }

    SendData(0x40 | cmd);
    SendData(param1);
    SendData(param2);
    SendData(param3);
    SendData(param4);
    SendData(crc);
}

/*
 * Send a command and wait for a response
 */
static uint8_t CommandAndResponse(uint8_t cmd, uint8_t param1, uint8_t param2, uint8_t param3, uint8_t param4)
{
    uint8_t rcv = 0xFF;

    SendCommand(cmd, param1, param2, param3, param4);

    // Wait until the SD card has responded
    while(rcv == 0xFF)
    {
        rcv = SendData(0xFF);
    }

    // Send a final dummy byte
    SendData(0xFF);

    return rcv;
}

/*
 * Set the block length we'll be working with
 */
static bool SetBlockLength(uint32_t blockLen)
{
    bool    result = true;
    uint8_t response;

    response = CommandAndResponse(0x10,
        (uint8_t)((blockLen >> 24) & 0xFF),
        (uint8_t)((blockLen >> 16) & 0xFF),
        (uint8_t)((blockLen >> 8) & 0xFF),
        (uint8_t)(blockLen & 0xFF));

    if(response != 0x00)
    {
        result = false;
    }

    return result;
}

/*
 * Start the SD card up
 */
bool StartSDCard()
{
    bool init = false;
    uint8_t response;
    uintd_t i;

    // Wait 100 milliseconds so we can make sure the SD card is ready
    DelayCurrentTask(100);

    // Send a bunch of clock signals
    for(i = 0; i < 10; i++)
    {
        SendData(0xFF);
    }

    // Set CS low
    mPORTBClearBits(SD_CS);

    // Let the SD card know we want to talk to it
    SendData(0xFF);

    // Send CMD0, reseting the card
    response = CommandAndResponse(0x00, 0x00, 0x00, 0x00, 0x00);

    if(response == 0x01)
    {
        // Send CMD1, initializing the card
        response = CommandAndResponse(0x01, 0x00, 0x00, 0x00, 0x00);
        if(response == 0x01)
        {
            while(!init)
            {
                // Send CMD1 to confirm initialization
                DelayCurrentTask(1);
                response = CommandAndResponse(0x01, 0x00, 0x00, 0x00, 0x00);
                if(response == 0)
                {
                    SetBlockLength(512);
                    init = true;
                }
            }
        }
    }

    mPORTBSetBits(SD_CS);

    return init;
}

/*
 * Write a block of 512 bytes to the card
 */
void WriteDataToSD(uint8_t* data, uint32_t address)
{
    uintd_t i;
    uint8_t response;

    mPORTBClearBits(SD_CS);
    SendData(0xFF);

    // Send CMD24
    response = CommandAndResponse(0x18, 
            (uint8_t)((address >> 24) & 0xFF),
            (uint8_t)((address >> 16) & 0xFF),
            (uint8_t)((address >> 8) & 0xFF),
            (uint8_t)(address & 0xFF));

    if(response == 0x00)
    {
        // Wait at least one byte time
        SendData(0xFF);

        // Now we send the data packet
        // Send data token, 0xFE for CMD24
        SendData(0xFE);

        for(i = 0; i < 512; i++)
        {
            SendData(data[i]);
        }

        // Send two byte CRC. CRC isn't enabled, so just send 0xFF FF
        SendData(0xFF);
        SendData(0xFF);
    }

    SendData(0xFF);

    mPORTBSetBits(SD_CS);
}

/*
 * Read a block of 512 bytes from the SD card
 */
void ReadDataFromSD(uint8_t* data, uint32_t address)
{
    uintd_t i;
    uint8_t response;

    mPORTBClearBits(SD_CS);
    SendData(0xFF);

    // Send CMD17
    response = CommandAndResponse(0x11,
            (uint8_t)((address >> 24) & 0xFF),
            (uint8_t)((address >> 16) & 0xFF),
            (uint8_t)((address >> 8) & 0xFF),
            (uint8_t)(address & 0xFF));

    if(response == 0x00)
    {
        // Wait for 0xFE, which indicates we're starting the read
        if(GetResponse() == 0xFE)
        {
            for(i = 0; i < 512; i++)
            {
                data[i] = SendData(0xFF);
            }

            // Read two byte CRC, which we don't care about
            SendData(0xFF);
            SendData(0xFF);
        }
    }

    SendData(0xFF);

    mPORTBSetBits(SD_CS);
}
