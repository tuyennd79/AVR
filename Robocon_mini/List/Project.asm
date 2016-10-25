
;CodeVisionAVR C Compiler V2.05.0 Professional
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega32A
;Program type             : Application
;Clock frequency          : 16.000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 512 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;global 'const' stored in FLASH: No
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega32A
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2143
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _x=R5
	.DEF _data_sensor=R4

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_0xA:
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x05
	.DW  _0xA*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.0 Professional
;Automatic Program Generator
;© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 20/10/2016
;Author  : NeVaDa
;Company :
;Comments:
;
;
;Chip type               : ATmega16
;Program type            : Application
;AVR Core Clock frequency: 16.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*****************************************************/
;
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include "file1.h"
;
;
;
;
;// Declare your global variables here
;
;unsigned char x=0;
;
;
;
;
;void main(void)
; 0000 0027 {

	.CSEG
_main:
; 0000 0028 // Declare your local variables here
; 0000 0029 
; 0000 002A // Input/Output Ports initialization
; 0000 002B // Port A initialization
; 0000 002C // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 002D // State7=P State6=P State5=P State4=P State3=P State2=P State1=P State0=P
; 0000 002E PORTA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1B,R30
; 0000 002F DDRA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 0030 
; 0000 0031 // Port B initialization
; 0000 0032 // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 0033 // State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 0034 PORTB=0x00;
	OUT  0x18,R30
; 0000 0035 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
; 0000 0036 
; 0000 0037 // Port C initialization
; 0000 0038 // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 0039 // State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 003A PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 003B DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 003C 
; 0000 003D // Port D initialization
; 0000 003E // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 003F // State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 0040 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0041 DDRD=0xFF;
	LDI  R30,LOW(255)
	OUT  0x11,R30
; 0000 0042 
; 0000 0043 // Timer/Counter 0 initialization
; 0000 0044 // Clock source: System Clock
; 0000 0045 // Clock value: Timer 0 Stopped
; 0000 0046 // Mode: Normal top=0xFF
; 0000 0047 // OC0 output: Disconnected
; 0000 0048 TCCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0000 0049 TCNT0=0x00;
	OUT  0x32,R30
; 0000 004A OCR0=0x00;
	OUT  0x3C,R30
; 0000 004B 
; 0000 004C // Timer/Counter 1 initialization
; 0000 004D // Clock source: System Clock
; 0000 004E // Clock value: 16000.000 kHz
; 0000 004F // Mode: Fast PWM top=ICR1
; 0000 0050 // OC1A output: Non-Inv.
; 0000 0051 // OC1B output: Non-Inv.
; 0000 0052 // Noise Canceler: Off
; 0000 0053 // Input Capture on Falling Edge
; 0000 0054 // Timer1 Overflow Interrupt: Off
; 0000 0055 // Input Capture Interrupt: Off
; 0000 0056 // Compare A Match Interrupt: Off
; 0000 0057 // Compare B Match Interrupt: Off
; 0000 0058 TCCR1A=0xA2;
	LDI  R30,LOW(162)
	OUT  0x2F,R30
; 0000 0059 TCCR1B=0x19;
	LDI  R30,LOW(25)
	OUT  0x2E,R30
; 0000 005A TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 005B TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 005C ICR1H=0x1F;
	LDI  R30,LOW(31)
	OUT  0x27,R30
; 0000 005D ICR1L=0x40;
	LDI  R30,LOW(64)
	OUT  0x26,R30
; 0000 005E OCR1AH=0x00;
	LDI  R30,LOW(0)
	OUT  0x2B,R30
; 0000 005F OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0060 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0061 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0062 
; 0000 0063 // Timer/Counter 2 initialization
; 0000 0064 // Clock source: System Clock
; 0000 0065 // Clock value: Timer2 Stopped
; 0000 0066 // Mode: Normal top=0xFF
; 0000 0067 // OC2 output: Disconnected
; 0000 0068 ASSR=0x00;
	OUT  0x22,R30
; 0000 0069 TCCR2=0x00;
	OUT  0x25,R30
; 0000 006A TCNT2=0x00;
	OUT  0x24,R30
; 0000 006B OCR2=0x00;
	OUT  0x23,R30
; 0000 006C 
; 0000 006D // External Interrupt(s) initialization
; 0000 006E // INT0: Off
; 0000 006F // INT1: Off
; 0000 0070 // INT2: Off
; 0000 0071 MCUCR=0x00;
	OUT  0x35,R30
; 0000 0072 MCUCSR=0x00;
	OUT  0x34,R30
; 0000 0073 
; 0000 0074 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 0075 TIMSK=0x00;
	OUT  0x39,R30
; 0000 0076 
; 0000 0077 // USART initialization
; 0000 0078 // USART disabled
; 0000 0079 UCSRB=0x00;
	OUT  0xA,R30
; 0000 007A 
; 0000 007B // Analog Comparator initialization
; 0000 007C // Analog Comparator: Off
; 0000 007D // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 007E ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 007F SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 0080 
; 0000 0081 // ADC initialization
; 0000 0082 // ADC disabled
; 0000 0083 ADCSRA=0x00;
	OUT  0x6,R30
; 0000 0084 
; 0000 0085 // SPI initialization
; 0000 0086 // SPI disabled
; 0000 0087 SPCR=0x00;
	OUT  0xD,R30
; 0000 0088 
; 0000 0089 // TWI initialization
; 0000 008A // TWI disabled
; 0000 008B TWCR=0x00;
	OUT  0x36,R30
; 0000 008C ICR1=8000;
	LDI  R30,LOW(8000)
	LDI  R31,HIGH(8000)
	OUT  0x26+1,R31
	OUT  0x26,R30
; 0000 008D Forward(2000,2000);
	LDI  R30,LOW(2000)
	LDI  R31,HIGH(2000)
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x0
; 0000 008E delay_ms(400);
	LDI  R30,LOW(400)
	LDI  R31,HIGH(400)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0000 008F Stop();
	RCALL _Stop
; 0000 0090 x=0;
	CLR  R5
; 0000 0091 while (1)
_0x3:
; 0000 0092       {
; 0000 0093       // Place your code here
; 0000 0094       //FirstRoad();
; 0000 0095       //Forward(VT11,VT22);
; 0000 0096       //FirstRoad2();
; 0000 0097       if(x==0)
	TST  R5
	BRNE _0x6
; 0000 0098        FirstRoad2();
	RCALL _FirstRoad2
; 0000 0099       if(x==1)
_0x6:
	LDI  R30,LOW(1)
	CP   R30,R5
	BRNE _0x7
; 0000 009A        Rol();
	RCALL _Rol
; 0000 009B       if(x==2)
_0x7:
	LDI  R30,LOW(2)
	CP   R30,R5
	BRNE _0x8
; 0000 009C        FirstRoad3();
	RCALL _FirstRoad3
; 0000 009D       }
_0x8:
	RJMP _0x3
; 0000 009E }
_0x9:
	RJMP _0x9
;#include "file1.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;unsigned char data_sensor;
;extern unsigned char x;
;void Forward(unsigned int v_left, unsigned int v_right)
; 0001 0006 {

	.CSEG
_Forward:
; 0001 0007     OCR1A = v_left;
;	v_left -> Y+2
;	v_right -> Y+0
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	OUT  0x2A+1,R31
	OUT  0x2A,R30
; 0001 0008     OCR1B = v_right;
	LD   R30,Y
	LDD  R31,Y+1
	OUT  0x28+1,R31
	OUT  0x28,R30
; 0001 0009     DIR1 = 1;
	SBI  0x15,2
; 0001 000A     DIR2 = 1;
	RJMP _0x2000001
; 0001 000B     EN1 = 1;
; 0001 000C     EN2 = 1;
; 0001 000D }
;
;void Quay(unsigned int v_right, unsigned int v_left)
; 0001 0010 {
_Quay:
; 0001 0011     OCR1A = v_left;
;	v_right -> Y+2
;	v_left -> Y+0
	LD   R30,Y
	LDD  R31,Y+1
	OUT  0x2A+1,R31
	OUT  0x2A,R30
; 0001 0012     OCR1B = v_right;
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	OUT  0x28+1,R31
	OUT  0x28,R30
; 0001 0013     DIR1 = 0;
	CBI  0x15,2
; 0001 0014     DIR2 = 1;
_0x2000001:
	SBI  0x15,3
; 0001 0015     EN1 = 1;
	SBI  0x12,7
; 0001 0016     EN2 = 1;
	SBI  0x12,6
; 0001 0017 }
	ADIW R28,4
	RET
;
;
;void Stop(void)
; 0001 001B {
_Stop:
; 0001 001C     Forward(0,0);
	RCALL SUBOPT_0x1
; 0001 001D     EN1 = 0;
	CBI  0x12,7
; 0001 001E     EN2 = 0;
	CBI  0x12,6
; 0001 001F }
	RET
;
;
;
;void FirstRoad2(void)
; 0001 0024 {
_FirstRoad2:
; 0001 0025     data_sensor = DATA_SENSOR;
	IN   R4,25
; 0001 0026     data_sensor &=0b01111110;
	LDI  R30,LOW(126)
	AND  R4,R30
; 0001 0027 
; 0001 0028     if(data_sensor==CENTER_1)
	LDI  R30,LOW(102)
	CP   R30,R4
	BRNE _0x20017
; 0001 0029     {
; 0001 002A         Forward(VT11,VT22);
	RCALL SUBOPT_0x2
; 0001 002B     }
; 0001 002C 
; 0001 002D     if(data_sensor==RIGHT1_1)
_0x20017:
	LDI  R30,LOW(110)
	CP   R30,R4
	BRNE _0x20018
; 0001 002E     {
; 0001 002F         Forward(6000,3500);
	RCALL SUBOPT_0x3
; 0001 0030     }
; 0001 0031     if(data_sensor==RIGHT2_1)
_0x20018:
	LDI  R30,LOW(78)
	CP   R30,R4
	BRNE _0x20019
; 0001 0032     {
; 0001 0033         Forward(5500,3500);
	RCALL SUBOPT_0x4
; 0001 0034     }
; 0001 0035     if(data_sensor==RIGHT3_1)
_0x20019:
	LDI  R30,LOW(14)
	CP   R30,R4
	BRNE _0x2001A
; 0001 0036     {
; 0001 0037         Forward(5000,3500);
	RCALL SUBOPT_0x5
; 0001 0038     }
; 0001 0039     if(data_sensor==RIGHT4_1)
_0x2001A:
	LDI  R30,LOW(30)
	CP   R30,R4
	BRNE _0x2001B
; 0001 003A     {
; 0001 003B         Forward(4500,2500);
	RCALL SUBOPT_0x6
; 0001 003C     }
; 0001 003D     if(data_sensor==RIGHT5_1)
_0x2001B:
	LDI  R30,LOW(30)
	CP   R30,R4
	BRNE _0x2001C
; 0001 003E     {
; 0001 003F         Forward(4500,2500);
	RCALL SUBOPT_0x6
; 0001 0040     }
; 0001 0041     if(data_sensor==RIGHT6_1)
_0x2001C:
	LDI  R30,LOW(62)
	CP   R30,R4
	BRNE _0x2001D
; 0001 0042     {
; 0001 0043         Forward(4000,2500);
	RCALL SUBOPT_0x7
; 0001 0044     }
; 0001 0045     if(data_sensor==RIGHT7_1)
_0x2001D:
	LDI  R30,LOW(126)
	CP   R30,R4
	BRNE _0x2001E
; 0001 0046     {
; 0001 0047         Forward(3000,2500);
	RCALL SUBOPT_0x8
; 0001 0048     }
; 0001 0049 
; 0001 004A     if(data_sensor==LEFT1_1)
_0x2001E:
	LDI  R30,LOW(118)
	CP   R30,R4
	BRNE _0x2001F
; 0001 004B     {
; 0001 004C         Forward(3500,6000);
	RCALL SUBOPT_0x9
	LDI  R30,LOW(6000)
	LDI  R31,HIGH(6000)
	RCALL SUBOPT_0x0
; 0001 004D     }
; 0001 004E     if(data_sensor==LEFT2_1)
_0x2001F:
	LDI  R30,LOW(114)
	CP   R30,R4
	BRNE _0x20020
; 0001 004F     {
; 0001 0050         Forward(3500,5500);
	RCALL SUBOPT_0x9
	LDI  R30,LOW(5500)
	LDI  R31,HIGH(5500)
	RCALL SUBOPT_0x0
; 0001 0051     }
; 0001 0052     if(data_sensor==LEFT3_1)
_0x20020:
	LDI  R30,LOW(112)
	CP   R30,R4
	BRNE _0x20021
; 0001 0053     {
; 0001 0054         Forward(3500,5000);
	RCALL SUBOPT_0x9
	LDI  R30,LOW(5000)
	LDI  R31,HIGH(5000)
	RCALL SUBOPT_0x0
; 0001 0055     }
; 0001 0056     if(data_sensor==LEFT4_1)
_0x20021:
	LDI  R30,LOW(120)
	CP   R30,R4
	BRNE _0x20022
; 0001 0057     {
; 0001 0058         Forward(2500,4500);
	RCALL SUBOPT_0xA
	LDI  R30,LOW(4500)
	LDI  R31,HIGH(4500)
	RCALL SUBOPT_0x0
; 0001 0059     }
; 0001 005A     if(data_sensor==LEFT5_1)
_0x20022:
	LDI  R30,LOW(120)
	CP   R30,R4
	BRNE _0x20023
; 0001 005B     {
; 0001 005C         Forward(2500,4000);
	RCALL SUBOPT_0xA
	LDI  R30,LOW(4000)
	LDI  R31,HIGH(4000)
	RCALL SUBOPT_0x0
; 0001 005D     }
; 0001 005E     if(data_sensor==LEFT6_1)
_0x20023:
	LDI  R30,LOW(124)
	CP   R30,R4
	BRNE _0x20024
; 0001 005F     {
; 0001 0060         Forward(2500,3500);
	RCALL SUBOPT_0xA
	LDI  R30,LOW(3500)
	LDI  R31,HIGH(3500)
	RCALL SUBOPT_0x0
; 0001 0061     }
; 0001 0062     if(data_sensor==LEFT7_1)
_0x20024:
	LDI  R30,LOW(126)
	CP   R30,R4
	BRNE _0x20025
; 0001 0063     {
; 0001 0064         Forward(2500,3000);
	RCALL SUBOPT_0xA
	LDI  R30,LOW(3000)
	LDI  R31,HIGH(3000)
	RCALL SUBOPT_0x0
; 0001 0065     }
; 0001 0066 
; 0001 0067     if((data_sensor==0x00))
_0x20025:
	TST  R4
	BRNE _0x20026
; 0001 0068     {
; 0001 0069         Stop();
	RCALL _Stop
; 0001 006A         x=1;
	LDI  R30,LOW(1)
	MOV  R5,R30
; 0001 006B     }
; 0001 006C }
_0x20026:
	RET
;
;
;void FirstRoad3(void)
; 0001 0070 {
_FirstRoad3:
; 0001 0071     data_sensor = DATA_SENSOR;
	IN   R4,25
; 0001 0072     data_sensor &=0b01111110;
	LDI  R30,LOW(126)
	AND  R4,R30
; 0001 0073 
; 0001 0074     if(data_sensor==CENTER_1)
	LDI  R30,LOW(102)
	CP   R30,R4
	BRNE _0x20027
; 0001 0075     {
; 0001 0076         Forward(VT11,VT22);
	RCALL SUBOPT_0x2
; 0001 0077     }
; 0001 0078 
; 0001 0079     if(data_sensor==RIGHT1_1)
_0x20027:
	LDI  R30,LOW(110)
	CP   R30,R4
	BRNE _0x20028
; 0001 007A     {
; 0001 007B         Forward(6000,3500);
	RCALL SUBOPT_0x3
; 0001 007C     }
; 0001 007D     if(data_sensor==RIGHT2_1)
_0x20028:
	LDI  R30,LOW(78)
	CP   R30,R4
	BRNE _0x20029
; 0001 007E     {
; 0001 007F         Forward(5500,3500);
	RCALL SUBOPT_0x4
; 0001 0080     }
; 0001 0081     if(data_sensor==RIGHT3_1)
_0x20029:
	LDI  R30,LOW(14)
	CP   R30,R4
	BRNE _0x2002A
; 0001 0082     {
; 0001 0083         Forward(5000,3500);
	RCALL SUBOPT_0x5
; 0001 0084     }
; 0001 0085     if(data_sensor==RIGHT4_1)
_0x2002A:
	LDI  R30,LOW(30)
	CP   R30,R4
	BRNE _0x2002B
; 0001 0086     {
; 0001 0087         Forward(4500,2500);
	RCALL SUBOPT_0x6
; 0001 0088     }
; 0001 0089     if(data_sensor==RIGHT5_1)
_0x2002B:
	LDI  R30,LOW(30)
	CP   R30,R4
	BRNE _0x2002C
; 0001 008A     {
; 0001 008B         Forward(4500,2500);
	RCALL SUBOPT_0x6
; 0001 008C     }
; 0001 008D     if(data_sensor==RIGHT6_1)
_0x2002C:
	LDI  R30,LOW(62)
	CP   R30,R4
	BRNE _0x2002D
; 0001 008E     {
; 0001 008F         Forward(4000,2500);
	RCALL SUBOPT_0x7
; 0001 0090     }
; 0001 0091     if(data_sensor==RIGHT7_1)
_0x2002D:
	LDI  R30,LOW(126)
	CP   R30,R4
	BRNE _0x2002E
; 0001 0092     {
; 0001 0093         Forward(3000,2500);
	RCALL SUBOPT_0x8
; 0001 0094     }
; 0001 0095 
; 0001 0096     if(data_sensor==LEFT1_1)
_0x2002E:
	LDI  R30,LOW(118)
	CP   R30,R4
	BRNE _0x2002F
; 0001 0097     {
; 0001 0098         Forward(3500,6000);
	RCALL SUBOPT_0x9
	LDI  R30,LOW(6000)
	LDI  R31,HIGH(6000)
	RCALL SUBOPT_0x0
; 0001 0099     }
; 0001 009A     if(data_sensor==LEFT2_1)
_0x2002F:
	LDI  R30,LOW(114)
	CP   R30,R4
	BRNE _0x20030
; 0001 009B     {
; 0001 009C         Forward(3500,5500);
	RCALL SUBOPT_0x9
	LDI  R30,LOW(5500)
	LDI  R31,HIGH(5500)
	RCALL SUBOPT_0x0
; 0001 009D     }
; 0001 009E     if(data_sensor==LEFT3_1)
_0x20030:
	LDI  R30,LOW(112)
	CP   R30,R4
	BRNE _0x20031
; 0001 009F     {
; 0001 00A0         Forward(3500,5000);
	RCALL SUBOPT_0x9
	LDI  R30,LOW(5000)
	LDI  R31,HIGH(5000)
	RCALL SUBOPT_0x0
; 0001 00A1     }
; 0001 00A2     if(data_sensor==LEFT4_1)
_0x20031:
	LDI  R30,LOW(120)
	CP   R30,R4
	BRNE _0x20032
; 0001 00A3     {
; 0001 00A4         Forward(2500,4500);
	RCALL SUBOPT_0xA
	LDI  R30,LOW(4500)
	LDI  R31,HIGH(4500)
	RCALL SUBOPT_0x0
; 0001 00A5     }
; 0001 00A6     if(data_sensor==LEFT5_1)
_0x20032:
	LDI  R30,LOW(120)
	CP   R30,R4
	BRNE _0x20033
; 0001 00A7     {
; 0001 00A8         Forward(2500,4000);
	RCALL SUBOPT_0xA
	LDI  R30,LOW(4000)
	LDI  R31,HIGH(4000)
	RCALL SUBOPT_0x0
; 0001 00A9     }
; 0001 00AA     if(data_sensor==LEFT6_1)
_0x20033:
	LDI  R30,LOW(124)
	CP   R30,R4
	BRNE _0x20034
; 0001 00AB     {
; 0001 00AC         Forward(2500,3500);
	RCALL SUBOPT_0xA
	LDI  R30,LOW(3500)
	LDI  R31,HIGH(3500)
	RCALL SUBOPT_0x0
; 0001 00AD     }
; 0001 00AE     if(data_sensor==LEFT7_1)
_0x20034:
	LDI  R30,LOW(126)
	CP   R30,R4
	BRNE _0x20035
; 0001 00AF     {
; 0001 00B0         Forward(2500,3000);
	RCALL SUBOPT_0xA
	LDI  R30,LOW(3000)
	LDI  R31,HIGH(3000)
	RCALL SUBOPT_0x0
; 0001 00B1     }
; 0001 00B2 
; 0001 00B3     if((data_sensor==0x00))
_0x20035:
	TST  R4
	BRNE _0x20036
; 0001 00B4     {
; 0001 00B5         Stop();
	RCALL _Stop
; 0001 00B6         x=3;
	LDI  R30,LOW(3)
	MOV  R5,R30
; 0001 00B7     }
; 0001 00B8 }
_0x20036:
	RET
;
;
;
;void Rol(void)
; 0001 00BD {
_Rol:
; 0001 00BE     data_sensor = DATA_SENSOR;
	IN   R4,25
; 0001 00BF     while(data_sensor!=CENTER)
_0x20037:
	LDI  R30,LOW(231)
	CP   R30,R4
	BREQ _0x20039
; 0001 00C0     {
; 0001 00C1         data_sensor = DATA_SENSOR;
	IN   R4,25
; 0001 00C2         Quay(1900,1900);
	LDI  R30,LOW(1900)
	LDI  R31,HIGH(1900)
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R31
	ST   -Y,R30
	RCALL _Quay
; 0001 00C3     }
	RJMP _0x20037
_0x20039:
; 0001 00C4     Forward(0,0);
	RCALL SUBOPT_0x1
; 0001 00C5     delay_ms(500);
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0001 00C6     x=2;
	LDI  R30,LOW(2)
	MOV  R5,R30
; 0001 00C7 }
	RET

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 33 TIMES, CODE SIZE REDUCTION:61 WORDS
SUBOPT_0x0:
	ST   -Y,R31
	ST   -Y,R30
	RJMP _Forward

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(7000)
	LDI  R31,HIGH(7000)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	LDI  R30,LOW(6000)
	LDI  R31,HIGH(6000)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3500)
	LDI  R31,HIGH(3500)
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(5500)
	LDI  R31,HIGH(5500)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3500)
	LDI  R31,HIGH(3500)
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(5000)
	LDI  R31,HIGH(5000)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3500)
	LDI  R31,HIGH(3500)
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(4500)
	LDI  R31,HIGH(4500)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2500)
	LDI  R31,HIGH(2500)
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(4000)
	LDI  R31,HIGH(4000)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2500)
	LDI  R31,HIGH(2500)
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(3000)
	LDI  R31,HIGH(3000)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2500)
	LDI  R31,HIGH(2500)
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x9:
	LDI  R30,LOW(3500)
	LDI  R31,HIGH(3500)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xA:
	LDI  R30,LOW(2500)
	LDI  R31,HIGH(2500)
	ST   -Y,R31
	ST   -Y,R30
	RET


	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
