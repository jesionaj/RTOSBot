// 2015 Adam Jesionowski

#ifndef WIIMOTEI2C_H
#define	WIIMOTEI2C_H

#ifdef	__cplusplus
extern "C" {
#endif

void InitI2C();
void StartWiimote();
void WiimoteGetData(uint8_t* buffer);

#ifdef	__cplusplus
}
#endif

#endif	/* WIIMOTEI2C_H */
