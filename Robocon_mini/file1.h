#ifndef __FILE1_H
#define __FILE1_H

#include <mega16.h>
#include <delay.h>

#define DIR1    PORTC.2
#define DIR2    PORTC.3

#define EN1     PORTD.7
#define EN2     PORTD.6


#define DATA_SENSOR     PINA

#define CENTER  0b11100111

#define LEFT1   0b11110111
#define LEFT2   0b11110011
#define LEFT3   0b11110001
#define LEFT4   0b11111001
#define LEFT5   0b11111000
#define LEFT6   0b11111100
#define LEFT7   0b11111110

#define RIGHT1  0b11101111
#define RIGHT2  0b11001111
#define RIGHT3  0b10001111
#define RIGHT4  0b10011111
#define RIGHT5  0b00011111
#define RIGHT6  0b00111111
#define RIGHT7  0b01111111

#define CENTER_1  0b01100110

#define LEFT1_1   0b01110110
#define LEFT2_1   0b01110010
#define LEFT3_1   0b01110000
#define LEFT4_1   0b01111000
#define LEFT5_1   0b01111000
#define LEFT6_1   0b01111100
#define LEFT7_1   0b01111110

#define RIGHT1_1  0b01101110
#define RIGHT2_1  0b01001110
#define RIGHT3_1  0b00001110
#define RIGHT4_1  0b00011110
#define RIGHT5_1  0b00011110
#define RIGHT6_1  0b00111110
#define RIGHT7_1  0b01111110


#define VT1     5300
#define VT2     4000  

#define VT11      7000
#define VT22      7000  


void Forward(unsigned int v_left, unsigned int v_right);
void Quay(unsigned int v_right, unsigned int v_left);
void Stop(void);
void FirstRoad2(void);
void FirstRoad3(void);
void Rol(void);



#endif /*__File1_H*/