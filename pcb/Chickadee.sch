EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:ESP8266
LIBS:pololu
LIBS:rx5808
LIBS:dc-dc
LIBS:ac-dc
LIBS:actel
LIBS:Altera
LIBS:analog_devices
LIBS:brooktre
LIBS:cmos_ieee
LIBS:diode
LIBS:elec-unifil
LIBS:ESD_Protection
LIBS:ftdi
LIBS:gennum
LIBS:graphic
LIBS:hc11
LIBS:ir
LIBS:Lattice
LIBS:logo
LIBS:maxim
LIBS:microchip_dspic33dsc
LIBS:microchip_pic10mcu
LIBS:microchip_pic12mcu
LIBS:microchip_pic16mcu
LIBS:microchip_pic18mcu
LIBS:microchip_pic32mcu
LIBS:motor_drivers
LIBS:msp430
LIBS:nordicsemi
LIBS:nxp_armmcu
LIBS:onsemi
LIBS:Oscillators
LIBS:Power_Management
LIBS:powerint
LIBS:pspice
LIBS:references
LIBS:relays
LIBS:rfcom
LIBS:sensors
LIBS:silabs
LIBS:stm8
LIBS:stm32
LIBS:supertex
LIBS:switches
LIBS:transf
LIBS:ttl_ieee
LIBS:video
LIBS:Xicor
LIBS:Zilog
LIBS:sma
LIBS:ap7333
LIBS:cmt-1603-smt-tr
LIBS:74lvc1g3157
LIBS:bd93291efj
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ESP-12E U1
U 1 1 56144F8D
P 5600 2900
F 0 "U1" H 5600 2800 50  0000 C CNN
F 1 "ESP-12E" H 5600 3000 50  0000 C CNN
F 2 "ESP8266:ESP-12E" H 5600 2900 50  0001 C CNN
F 3 "" H 5600 2900 50  0001 C CNN
	1    5600 2900
	1    0    0    -1  
$EndComp
$Comp
L RX5808 RF1
U 1 1 561470C4
P 8250 2050
F 0 "RF1" H 8250 2150 60  0000 C CNN
F 1 "RX5808" H 8250 1950 60  0000 C CNN
F 2 "rx5808:rx5808" H 8000 2400 60  0001 C CNN
F 3 "" H 8000 2400 60  0000 C CNN
	1    8250 2050
	1    0    0    -1  
$EndComp
NoConn ~ 9000 1750
NoConn ~ 9000 1850
Text Label 9150 1950 0    60   ~ 0
RSSI
Text Label 4550 2700 2    60   ~ 0
SHARED_ADC
$Sheet
S 3000 1000 1550 950 
U 56158CC6
F0 "5V/3V3 Regulator" 60
F1 "Regulator.sch" 60
$EndSheet
$Comp
L +3.3V #PWR01
U 1 1 5615AE4C
P 4700 3300
F 0 "#PWR01" H 4700 3150 50  0001 C CNN
F 1 "+3.3V" V 4700 3550 50  0000 C CNN
F 2 "" H 4700 3300 60  0000 C CNN
F 3 "" H 4700 3300 60  0000 C CNN
	1    4700 3300
	0    -1   -1   0   
$EndComp
$Comp
L GNDPWR #PWR02
U 1 1 5615AEA2
P 6500 3300
F 0 "#PWR02" H 6500 3100 50  0001 C CNN
F 1 "GNDPWR" H 6500 3170 50  0000 C CNN
F 2 "" H 6500 3250 60  0000 C CNN
F 3 "" H 6500 3250 60  0000 C CNN
	1    6500 3300
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR03
U 1 1 5615AF25
P 9000 2150
F 0 "#PWR03" H 9000 1950 50  0001 C CNN
F 1 "GNDPWR" V 9000 1900 50  0000 C CNN
F 2 "" H 9000 2100 60  0000 C CNN
F 3 "" H 9000 2100 60  0000 C CNN
	1    9000 2150
	0    -1   -1   0   
$EndComp
$Comp
L +5V #PWR04
U 1 1 5615AF42
P 9000 2050
F 0 "#PWR04" H 9000 1900 50  0001 C CNN
F 1 "+5V" V 9000 2250 50  0000 C CNN
F 2 "" H 9000 2050 60  0000 C CNN
F 3 "" H 9000 2050 60  0000 C CNN
	1    9000 2050
	0    1    1    0   
$EndComp
$Comp
L GNDPWR #PWR05
U 1 1 5615AFA1
P 9000 1650
F 0 "#PWR05" H 9000 1450 50  0001 C CNN
F 1 "GNDPWR" V 9000 1400 50  0000 C CNN
F 2 "" H 9000 1600 60  0000 C CNN
F 3 "" H 9000 1600 60  0000 C CNN
	1    9000 1650
	0    -1   -1   0   
$EndComp
$Sheet
S 3550 4150 800  400 
U 5615B5ED
F0 "ESP-Reset" 60
F1 "ESP-Reset.sch" 60
F2 "RESET" I R 4350 4250 60 
F3 "GPIO0" I R 4350 4450 60 
$EndSheet
$Comp
L CMT-1603 LS1
U 1 1 56161010
P 3700 3100
F 0 "LS1" H 3700 3100 60  0000 C CNN
F 1 "CMT-1603" H 3700 3250 60  0000 C CNN
F 2 "cmt-1603-smt:CMT-1603-SMT" H 3700 3100 60  0001 C CNN
F 3 "" H 3700 3100 60  0000 C CNN
	1    3700 3100
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR06
U 1 1 56161036
P 3250 3000
F 0 "#PWR06" H 3250 2800 50  0001 C CNN
F 1 "GNDPWR" H 3250 2870 50  0000 C CNN
F 2 "" H 3250 2950 60  0000 C CNN
F 3 "" H 3250 2950 60  0000 C CNN
	1    3250 3000
	0    1    1    0   
$EndComp
Text Label 6700 3000 0    60   ~ 0
GPIO0
Text Label 4550 4450 0    60   ~ 0
GPIO0
Text Label 4550 4250 0    60   ~ 0
RESET
Text Label 4550 2600 2    60   ~ 0
RESET
$Comp
L CONN_01X06 P1
U 1 1 5616A176
P 5800 4700
F 0 "P1" H 5800 5050 50  0000 C CNN
F 1 "FTDI" V 5900 4700 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x06" H 5800 4700 60  0001 C CNN
F 3 "" H 5800 4700 60  0000 C CNN
	1    5800 4700
	0    1    1    0   
$EndComp
Text Label 6050 4300 3    60   ~ 0
GND
Text Label 5950 4300 3    60   ~ 0
CTS
Text Label 5850 4300 3    60   ~ 0
V+
Text Label 5750 4300 3    60   ~ 0
TXO
Text Label 5650 4300 3    60   ~ 0
RXI
Text Label 5550 4300 3    60   ~ 0
DTR
NoConn ~ 5850 4300
NoConn ~ 5550 4300
$Comp
L GNDPWR #PWR07
U 1 1 5616A720
P 6050 4300
F 0 "#PWR07" H 6050 4100 50  0001 C CNN
F 1 "GNDPWR" H 6050 4170 50  0000 C CNN
F 2 "" H 6050 4250 60  0000 C CNN
F 3 "" H 6050 4250 60  0000 C CNN
	1    6050 4300
	0    -1   -1   0   
$EndComp
Text Label 6700 2700 0    60   ~ 0
TXO
Text Label 6700 2600 0    60   ~ 0
RXI
$Comp
L 74LVC1G3157 U2
U 1 1 5616BFA9
P 8650 4100
F 0 "U2" H 8650 3550 60  0000 C CNN
F 1 "74LVC1G3157" H 8650 3950 60  0000 C CNN
F 2 "Housings_SOT-23_SOT-143_TSOT-6:SOT-23-6" H 8650 4100 60  0001 C CNN
F 3 "" H 8650 4100 60  0000 C CNN
	1    8650 4100
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR08
U 1 1 5616C00E
P 9150 4100
F 0 "#PWR08" H 9150 3950 50  0001 C CNN
F 1 "+3.3V" H 9150 4240 50  0000 C CNN
F 2 "" H 9150 4100 60  0000 C CNN
F 3 "" H 9150 4100 60  0000 C CNN
	1    9150 4100
	0    1    1    0   
$EndComp
Text Label 9300 4400 0    60   ~ 0
SHARED_ADC
Text Label 8000 3100 2    60   ~ 0
RSSI
$Comp
L GNDPWR #PWR09
U 1 1 5616C3A8
P 8150 4100
F 0 "#PWR09" H 8150 3900 50  0001 C CNN
F 1 "GNDPWR" H 8150 3970 50  0000 C CNN
F 2 "" H 8150 4050 60  0000 C CNN
F 3 "" H 8150 4050 60  0000 C CNN
	1    8150 4100
	0    1    1    0   
$EndComp
$Comp
L R R7
U 1 1 5616C40F
P 7650 4250
F 0 "R7" V 7730 4250 50  0000 C CNN
F 1 "470K" V 7650 4250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 7580 4250 30  0001 C CNN
F 3 "" H 7650 4250 30  0000 C CNN
	1    7650 4250
	1    0    0    -1  
$EndComp
$Comp
L R R8
U 1 1 5616C462
P 7650 4550
F 0 "R8" V 7730 4550 50  0000 C CNN
F 1 "10k" V 7650 4550 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 7580 4550 30  0001 C CNN
F 3 "" H 7650 4550 30  0000 C CNN
	1    7650 4550
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR010
U 1 1 5616C4B2
P 7650 5150
F 0 "#PWR010" H 7650 4950 50  0001 C CNN
F 1 "GNDPWR" H 7650 5000 50  0000 C CNN
F 2 "" H 7650 5100 60  0000 C CNN
F 3 "" H 7650 5100 60  0000 C CNN
	1    7650 5150
	1    0    0    -1  
$EndComp
$Comp
L +BATT #PWR011
U 1 1 5616C5A6
P 7650 4100
F 0 "#PWR011" H 7650 3950 50  0001 C CNN
F 1 "+BATT" H 7650 4240 50  0000 C CNN
F 2 "" H 7650 4100 60  0000 C CNN
F 3 "" H 7650 4100 60  0000 C CNN
	1    7650 4100
	1    0    0    -1  
$EndComp
Text Label 6700 2800 0    60   ~ 0
CLK
Text Label 6700 2900 0    60   ~ 0
LE
Text Label 4500 3200 2    60   ~ 0
DATA
$Comp
L R R6
U 1 1 5616C961
P 6650 3200
F 0 "R6" V 6730 3200 50  0000 C CNN
F 1 "10k" V 6650 3200 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 6580 3200 30  0001 C CNN
F 3 "" H 6650 3200 30  0000 C CNN
	1    6650 3200
	0    1    1    0   
$EndComp
$Comp
L GNDPWR #PWR012
U 1 1 5616C9B4
P 6800 3200
F 0 "#PWR012" H 6800 3000 50  0001 C CNN
F 1 "GNDPWR" H 6800 3070 50  0000 C CNN
F 2 "" H 6800 3150 60  0000 C CNN
F 3 "" H 6800 3150 60  0000 C CNN
	1    6800 3200
	0    -1   -1   0   
$EndComp
$Comp
L R R3
U 1 1 5616CA28
P 4550 2800
F 0 "R3" V 4630 2800 50  0000 C CNN
F 1 "47k" V 4550 2800 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 4480 2800 30  0001 C CNN
F 3 "" H 4550 2800 30  0000 C CNN
	1    4550 2800
	0    1    1    0   
$EndComp
$Comp
L R R5
U 1 1 5616CBEE
P 6650 3100
F 0 "R5" V 6730 3100 50  0000 C CNN
F 1 "47k" V 6650 3100 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 6580 3100 30  0001 C CNN
F 3 "" H 6650 3100 30  0000 C CNN
	1    6650 3100
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR013
U 1 1 5616CC89
P 6800 3100
F 0 "#PWR013" H 6800 2950 50  0001 C CNN
F 1 "+3.3V" H 6800 3240 50  0000 C CNN
F 2 "" H 6800 3100 60  0000 C CNN
F 3 "" H 6800 3100 60  0000 C CNN
	1    6800 3100
	0    1    1    0   
$EndComp
$Comp
L LED D2
U 1 1 5616CE7A
P 5200 1200
F 0 "D2" H 5200 1300 50  0000 C CNN
F 1 "LED" H 5200 1100 50  0000 C CNN
F 2 "LEDs:LED-0603" H 5200 1200 60  0001 C CNN
F 3 "" H 5200 1200 60  0000 C CNN
	1    5200 1200
	0    -1   -1   0   
$EndComp
$Comp
L +3.3V #PWR014
U 1 1 5616CEEB
P 5200 1000
F 0 "#PWR014" H 5200 850 50  0001 C CNN
F 1 "+3.3V" H 5200 1140 50  0000 C CNN
F 2 "" H 5200 1000 60  0000 C CNN
F 3 "" H 5200 1000 60  0000 C CNN
	1    5200 1000
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 5616CF35
P 5200 1550
F 0 "R4" V 5280 1550 50  0000 C CNN
F 1 "1K" V 5200 1550 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 5130 1550 30  0001 C CNN
F 3 "" H 5200 1550 30  0000 C CNN
	1    5200 1550
	1    0    0    -1  
$EndComp
Text Label 5200 2000 1    60   ~ 0
GPIO0
$Comp
L SMA J1
U 1 1 56176123
P 6750 4200
F 0 "J1" H 6875 4515 60  0000 C CNN
F 1 "SMA" H 6940 4440 60  0000 C CNN
F 2 "sma-jack:SMA-Jack-Straight" H 6925 4370 50  0000 C CNN
F 3 "" H 6750 4200 60  0000 C CNN
	1    6750 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 1950 9000 1950
Wire Wire Line
	4550 2700 4700 2700
Wire Wire Line
	4700 3000 4150 3000
Wire Wire Line
	6500 3000 6700 3000
Wire Wire Line
	4350 4450 4550 4450
Wire Wire Line
	4350 4250 4550 4250
Wire Wire Line
	4700 2600 4550 2600
Wire Wire Line
	6050 4500 6050 4300
Wire Wire Line
	5950 4500 5950 4300
Wire Wire Line
	5850 4500 5850 4300
Wire Wire Line
	5750 4500 5750 4300
Wire Wire Line
	5650 4500 5650 4300
Wire Wire Line
	5550 4500 5550 4300
Wire Wire Line
	6500 2600 6700 2600
Wire Wire Line
	6500 2700 6700 2700
Wire Wire Line
	9150 4400 9300 4400
Wire Wire Line
	8000 3800 8150 3800
Wire Wire Line
	8150 4400 7650 4400
Wire Wire Line
	6700 2800 6500 2800
Wire Wire Line
	6500 2900 6700 2900
Wire Wire Line
	4700 3200 4500 3200
Wire Wire Line
	5200 1700 5200 2000
Wire Wire Line
	6650 4100 6800 4100
Connection ~ 6700 4100
Connection ~ 6750 4100
Wire Wire Line
	6800 4100 6800 4400
$Comp
L GNDPWR #PWR015
U 1 1 5617627C
P 6800 4400
F 0 "#PWR015" H 6800 4200 50  0001 C CNN
F 1 "GNDPWR" H 6800 4270 50  0000 C CNN
F 2 "" H 6800 4350 60  0000 C CNN
F 3 "" H 6800 4350 60  0000 C CNN
	1    6800 4400
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR016
U 1 1 561762C4
P 7500 2400
F 0 "#PWR016" H 7500 2200 50  0001 C CNN
F 1 "GNDPWR" H 7500 2270 50  0000 C CNN
F 2 "" H 7500 2350 60  0000 C CNN
F 3 "" H 7500 2350 60  0000 C CNN
	1    7500 2400
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR017
U 1 1 56176313
P 7500 2200
F 0 "#PWR017" H 7500 2000 50  0001 C CNN
F 1 "GNDPWR" H 7500 2070 50  0000 C CNN
F 2 "" H 7500 2150 60  0000 C CNN
F 3 "" H 7500 2150 60  0000 C CNN
	1    7500 2200
	-1   0    0    1   
$EndComp
Wire Wire Line
	7500 2300 7300 2300
Wire Wire Line
	6600 3900 6600 3700
Text Label 7300 2300 2    60   ~ 0
RFIN
Text Label 6600 3700 0    60   ~ 0
RFIN
Wire Wire Line
	9000 2250 9500 2250
Wire Wire Line
	9000 2350 9400 2350
Wire Wire Line
	9400 2350 9400 2450
Wire Wire Line
	9400 2450 9500 2450
Wire Wire Line
	9000 2450 9250 2450
Wire Wire Line
	9250 2450 9250 2650
Wire Wire Line
	9250 2650 9500 2650
Text Label 9500 2650 0    60   ~ 0
DATA
Text Label 9500 2450 0    60   ~ 0
LE
Text Label 9500 2250 0    60   ~ 0
CLK
Text Label 9150 3800 0    60   ~ 0
ADC_SELECT
Text Label 4700 3100 2    60   ~ 0
ADC_SELECT
NoConn ~ 4700 2900
NoConn ~ 5350 3800
NoConn ~ 5450 3800
NoConn ~ 5550 3800
NoConn ~ 5650 3800
NoConn ~ 5750 3800
NoConn ~ 5850 3800
$Comp
L R R9
U 1 1 56177CF4
P 7650 5000
F 0 "R9" V 7730 5000 50  0000 C CNN
F 1 "10k" V 7650 5000 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 7580 5000 30  0001 C CNN
F 3 "" H 7650 5000 30  0000 C CNN
	1    7650 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	7650 4700 7650 4850
$Comp
L PWR_FLAG #FLG018
U 1 1 561836FA
P 5750 1000
F 0 "#FLG018" H 5750 1095 50  0001 C CNN
F 1 "PWR_FLAG" H 5750 1180 50  0000 C CNN
F 2 "" H 5750 1000 60  0000 C CNN
F 3 "" H 5750 1000 60  0000 C CNN
	1    5750 1000
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG019
U 1 1 561837B6
P 6100 1000
F 0 "#FLG019" H 6100 1095 50  0001 C CNN
F 1 "PWR_FLAG" H 6100 1180 50  0000 C CNN
F 2 "" H 6100 1000 60  0000 C CNN
F 3 "" H 6100 1000 60  0000 C CNN
	1    6100 1000
	1    0    0    -1  
$EndComp
$Comp
L +BATT #PWR020
U 1 1 56183809
P 5750 1000
F 0 "#PWR020" H 5750 850 50  0001 C CNN
F 1 "+BATT" H 5750 1140 50  0000 C CNN
F 2 "" H 5750 1000 60  0000 C CNN
F 3 "" H 5750 1000 60  0000 C CNN
	1    5750 1000
	-1   0    0    1   
$EndComp
$Comp
L GNDPWR #PWR021
U 1 1 5618385C
P 6100 1000
F 0 "#PWR021" H 6100 800 50  0001 C CNN
F 1 "GNDPWR" H 6100 870 50  0000 C CNN
F 2 "" H 6100 950 60  0000 C CNN
F 3 "" H 6100 950 60  0000 C CNN
	1    6100 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 4300 6050 4300
$Comp
L +3.3V #PWR022
U 1 1 563AE49A
P 4400 2800
F 0 "#PWR022" H 4400 2650 50  0001 C CNN
F 1 "+3.3V" H 4400 2940 50  0000 C CNN
F 2 "" H 4400 2800 60  0000 C CNN
F 3 "" H 4400 2800 60  0000 C CNN
	1    4400 2800
	0    -1   -1   0   
$EndComp
$Comp
L R oR1
U 1 1 563AE663
P 4650 2350
F 0 "oR1" V 4730 2350 50  0000 C CNN
F 1 "10k" V 4650 2350 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 4580 2350 30  0001 C CNN
F 3 "" H 4650 2350 30  0000 C CNN
	1    4650 2350
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR023
U 1 1 563AE73E
P 4650 2200
F 0 "#PWR023" H 4650 2050 50  0001 C CNN
F 1 "+3.3V" H 4650 2340 50  0000 C CNN
F 2 "" H 4650 2200 60  0000 C CNN
F 3 "" H 4650 2200 60  0000 C CNN
	1    4650 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 2500 4650 2600
Connection ~ 4650 2600
$Comp
L GNDPWR #PWR024
U 1 1 563AEEA1
P 7300 1300
F 0 "#PWR024" H 7300 1100 50  0001 C CNN
F 1 "GNDPWR" H 7300 1170 50  0000 C CNN
F 2 "" H 7300 1250 60  0000 C CNN
F 3 "" H 7300 1250 60  0000 C CNN
	1    7300 1300
	1    0    0    -1  
$EndComp
$Comp
L +BATT #PWR026
U 1 1 563AEFF1
P 7300 950
F 0 "#PWR026" H 7300 800 50  0001 C CNN
F 1 "+BATT" H 7300 1090 50  0000 C CNN
F 2 "" H 7300 950 60  0000 C CNN
F 3 "" H 7300 950 60  0000 C CNN
	1    7300 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	7300 950  7300 1200
$Comp
L PWR_FLAG #FLG027
U 1 1 563AF4CA
P 6450 3800
F 0 "#FLG027" H 6450 3895 50  0001 C CNN
F 1 "PWR_FLAG" H 6450 3980 50  0000 C CNN
F 2 "" H 6450 3800 60  0000 C CNN
F 3 "" H 6450 3800 60  0000 C CNN
	1    6450 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 3800 6600 3800
Connection ~ 6600 3800
$Comp
L CONN_01X02 P2
U 1 1 563AF67E
P 7100 1250
F 0 "P2" H 7100 1400 50  0000 C CNN
F 1 "CONN_01X02" V 7200 1250 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02" H 7100 1250 60  0001 C CNN
F 3 "" H 7100 1250 60  0000 C CNN
	1    7100 1250
	-1   0    0    1   
$EndComp
$Comp
L R_Small R10
U 1 1 564BBC33
P 8000 3300
F 0 "R10" H 8030 3320 50  0000 L CNN
F 1 "1k" H 8030 3260 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 8000 3300 60  0001 C CNN
F 3 "" H 8000 3300 60  0000 C CNN
	1    8000 3300
	1    0    0    -1  
$EndComp
$Comp
L R_Small R11
U 1 1 564BBC90
P 7700 3600
F 0 "R11" H 7730 3620 50  0000 L CNN
F 1 "10k" H 7730 3560 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 7700 3600 60  0001 C CNN
F 3 "" H 7700 3600 60  0000 C CNN
	1    7700 3600
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR028
U 1 1 564BBCF6
P 7700 3750
F 0 "#PWR028" H 7700 3550 50  0001 C CNN
F 1 "GNDPWR" H 7700 3620 50  0000 C CNN
F 2 "" H 7700 3700 60  0000 C CNN
F 3 "" H 7700 3700 60  0000 C CNN
	1    7700 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 3100 8000 3200
Wire Wire Line
	8000 3400 8000 3800
Wire Wire Line
	8000 3500 7700 3500
Wire Wire Line
	7700 3700 7700 3750
Connection ~ 8000 3500
Text Notes 8050 7100 0    60   ~ 0
Creative Commons Attribution-ShareAlike 4.0 International License
Text Notes 9950 6950 0    60   ~ 0
(c) 2015 Scott Shawcroft
Text Notes 9700 6800 0    118  ~ 0
Laptimer 5.8 v4
Text Notes 8250 7350 0    118  ~ 0
https://chickadee.tech/lt58/v4
$EndSCHEMATC
