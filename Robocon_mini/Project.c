/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.0 Professional
Automatic Program Generator
© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 20/10/2016
Author  : NeVaDa
Company : 
Comments: 


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 16.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/

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


#define VT1     4000
#define VT2     4500    


// Declare your global variables here


void Forward(unsigned int v_left, unsigned int v_right)
{
    OCR1A = v_right;   
    OCR1B = v_left;
    DIR1 = 1;
    DIR2 = 1;
    EN1 = 1;
    EN2 = 1;     
}

void Back(unsigned int v_left, unsigned int v_right)
{
    OCR1A = v_right;
    OCR1B = v_left;
    DIR1 = 0;
    DIR2 = 0;
    EN1 = 1;
    EN2 = 1;     
}


void Stop(void)
{
    EN1 = 0;
    EN2 = 0;     
}

void FirstRoad(void)
{
    if(DATA_SENSOR==CENTER)
    {
        Forward(VT1,VT2);
    }
    
    if(DATA_SENSOR==LEFT1)
    {
        Forward(VT1,2500);
    }
    if(DATA_SENSOR==LEFT2)
    {
        Forward(VT1,2000);
    } 
    if(DATA_SENSOR==LEFT3)
    {
        Forward(VT1,1800);
    }
    if(DATA_SENSOR==LEFT4)
    {
        Forward(VT1,1600);
    }
    if(DATA_SENSOR==LEFT5)
    {
        Forward(VT1,1400);
    }
    if(DATA_SENSOR==LEFT6)
    {
        Forward(VT1,1200);
    }
    if(DATA_SENSOR==LEFT7)
    {
        Forward(VT1,500);
    }       
    
    if(DATA_SENSOR==RIGHT1)
    {
        Forward(2500,VT2);
    }
    if(DATA_SENSOR==RIGHT2)
    {
        Forward(2000,VT2);
    } 
    if(DATA_SENSOR==RIGHT3)
    {
        Forward(1800,VT2);
    }
    if(DATA_SENSOR==RIGHT4)
    {
        Forward(1600,VT2);
    }
    if(DATA_SENSOR==RIGHT5)
    {
        Forward(1400,VT2);
    }
    if(DATA_SENSOR==RIGHT6)
    {
        Forward(1200,VT2);
    }
    if(DATA_SENSOR==RIGHT7)
    {
        Forward(500,VT2);
    } 
    
    if(DATA_SENSOR==0x00)
    {
        //Stop();
    }       
}

void main(void)
{
// Declare your local variables here

// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=P State6=P State5=P State4=P State3=P State2=P State1=P State0=P 
PORTA=0xFF;
DDRA=0x00;

// Port B initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTB=0x00;
DDRB=0xFF;

// Port C initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTC=0x00;
DDRC=0xFF;

// Port D initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTD=0x00;
DDRD=0xFF;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=0xFF
// OC0 output: Disconnected
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 16000.000 kHz
// Mode: Fast PWM top=ICR1
// OC1A output: Non-Inv.
// OC1B output: Non-Inv.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0xA2;
TCCR1B=0x19;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x1F;
ICR1L=0x40;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2 output: Disconnected
ASSR=0x00;
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;

// USART initialization
// USART disabled
UCSRB=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// ADC initialization
// ADC disabled
ADCSRA=0x00;

// SPI initialization
// SPI disabled
SPCR=0x00;

// TWI initialization
// TWI disabled
TWCR=0x00;
ICR1=8000;

while (1)
      {
      // Place your code here 
      FirstRoad(); 
      //Forward(6800,7000);
      }
}
