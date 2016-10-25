#include "file1.h"

unsigned char data_sensor;
extern unsigned char x;
void Forward(unsigned int v_left, unsigned int v_right)
{
    OCR1A = v_left;    
    OCR1B = v_right;
    DIR1 = 1;
    DIR2 = 1;
    EN1 = 1;
    EN2 = 1;     
}

void Quay(unsigned int v_right, unsigned int v_left)
{
    OCR1A = v_left;
    OCR1B = v_right;
    DIR1 = 0;
    DIR2 = 1;
    EN1 = 1;
    EN2 = 1;     
}


void Stop(void)
{
    Forward(0,0);
    EN1 = 0;
    EN2 = 0;     
}



void FirstRoad2(void)
{
    data_sensor = DATA_SENSOR;  
    data_sensor &=0b01111110;
    
    if(data_sensor==CENTER_1)
    {
        Forward(VT11,VT22);
    }
    
    if(data_sensor==RIGHT1_1)
    {
        Forward(6000,3500);
    }
    if(data_sensor==RIGHT2_1)
    {
        Forward(5500,3500);
    } 
    if(data_sensor==RIGHT3_1)
    {
        Forward(5000,3500);
    }
    if(data_sensor==RIGHT4_1)
    {
        Forward(4500,2500);
    }
    if(data_sensor==RIGHT5_1)
    {
        Forward(4500,2500);
    }
    if(data_sensor==RIGHT6_1)
    {
        Forward(4000,2500);
    }
    if(data_sensor==RIGHT7_1)
    {
        Forward(3000,2500);
    }       
    
    if(data_sensor==LEFT1_1)
    {
        Forward(3500,6000);
    }
    if(data_sensor==LEFT2_1)
    {
        Forward(3500,5500);
    } 
    if(data_sensor==LEFT3_1)
    {
        Forward(3500,5000);
    }
    if(data_sensor==LEFT4_1)
    {
        Forward(2500,4500);
    }
    if(data_sensor==LEFT5_1)
    {
        Forward(2500,4000);
    }
    if(data_sensor==LEFT6_1)
    {
        Forward(2500,3500); 
    }
    if(data_sensor==LEFT7_1)
    {
        Forward(2500,3000);
    } 
    
    if((data_sensor==0x00))
    {
        Stop();
        x=1;
    } 
}


void FirstRoad3(void)
{
    data_sensor = DATA_SENSOR;  
    data_sensor &=0b01111110;
    
    if(data_sensor==CENTER_1)
    {
        Forward(VT11,VT22);
    }
    
    if(data_sensor==RIGHT1_1)
    {
        Forward(6000,3500);
    }
    if(data_sensor==RIGHT2_1)
    {
        Forward(5500,3500);
    } 
    if(data_sensor==RIGHT3_1)
    {
        Forward(5000,3500);
    }
    if(data_sensor==RIGHT4_1)
    {
        Forward(4500,2500);
    }
    if(data_sensor==RIGHT5_1)
    {
        Forward(4500,2500);
    }
    if(data_sensor==RIGHT6_1)
    {
        Forward(4000,2500);
    }
    if(data_sensor==RIGHT7_1)
    {
        Forward(3000,2500);
    }       
    
    if(data_sensor==LEFT1_1)
    {
        Forward(3500,6000);
    }
    if(data_sensor==LEFT2_1)
    {
        Forward(3500,5500);
    } 
    if(data_sensor==LEFT3_1)
    {
        Forward(3500,5000);
    }
    if(data_sensor==LEFT4_1)
    {
        Forward(2500,4500);
    }
    if(data_sensor==LEFT5_1)
    {
        Forward(2500,4000);
    }
    if(data_sensor==LEFT6_1)
    {
        Forward(2500,3500); 
    }
    if(data_sensor==LEFT7_1)
    {
        Forward(2500,3000);
    } 
    
    if((data_sensor==0x00))
    {
        Stop();
        x=3;
    } 
}



void Rol(void)
{
    data_sensor = DATA_SENSOR; 
    while(data_sensor!=CENTER)  
    {                           
        data_sensor = DATA_SENSOR;  
        Quay(1900,1900);    
    }
    Forward(0,0);
    delay_ms(500);
    x=2;
}