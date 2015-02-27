// 2015 Adam Jesionowski

#ifndef ENCODER_H
#define	ENCODER_H

#ifdef	__cplusplus
extern "C" {
#endif

void InitEncoder();
void __inline GetAndResetCounts(int8_t* left, int8_t* right);

#ifdef	__cplusplus
}
#endif

#endif	/* ENCODER_H */

