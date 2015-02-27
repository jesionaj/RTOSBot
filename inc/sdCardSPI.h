// 2015 Adam Jesionowski

#ifndef SDCARDSPI_H
#define	SDCARDSPI_H

#ifdef	__cplusplus
extern "C" {
#endif

bool StartSDCard();
void WriteDataToSD(uint8_t* data, uint32_t address);
void ReadDataFromSD(uint8_t* data, uint32_t address);

#ifdef	__cplusplus
}
#endif

#endif	/* SDCARDSPI_H */

