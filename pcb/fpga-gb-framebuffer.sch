EESchema Schematic File Version 4
LIBS:fpga-gb-framebuffer-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
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
L Connector_Generic:Conn_02x09_Odd_Even GB_LCD1
U 1 1 5C3B8763
P 1300 1200
F 0 "GB_LCD1" H 1350 1817 50  0000 C CNN
F 1 "Conn_02x09_Counter_Clockwise" H 1350 1726 50  0000 C CNN
F 2 "library:PinHeader_2x09_P2.54mm_Vertical" H 1300 1200 50  0001 C CNN
F 3 "~" H 1300 1200 50  0001 C CNN
	1    1300 1200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5C3B8886
P 1350 2200
F 0 "R1" H 1420 2246 50  0000 L CNN
F 1 "510" H 1420 2155 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1280 2200 50  0001 C CNN
F 3 "~" H 1350 2200 50  0001 C CNN
F 4 "R" H 1350 2200 50  0001 C CNN "Spice_Primitive"
F 5 "510" H 1350 2200 50  0001 C CNN "Spice_Model"
F 6 "Y" H 1350 2200 50  0001 C CNN "Spice_Netlist_Enabled"
	1    1350 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5C3B8B39
P 1350 2500
F 0 "R2" H 1420 2546 50  0000 L CNN
F 1 "1k" H 1420 2455 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1280 2500 50  0001 C CNN
F 3 "~" H 1350 2500 50  0001 C CNN
F 4 "R" H 1350 2500 50  0001 C CNN "Spice_Primitive"
F 5 "1k" H 1350 2500 50  0001 C CNN "Spice_Model"
F 6 "Y" H 1350 2500 50  0001 C CNN "Spice_Netlist_Enabled"
	1    1350 2500
	1    0    0    -1  
$EndComp
Text GLabel 1100 800  0    50   Input ~ 0
GB_GND
Text GLabel 1600 900  2    50   Input ~ 0
GB_HSYNC
Text GLabel 1100 1000 0    50   Input ~ 0
GB_DATA_0
Text GLabel 1600 1000 2    50   Input ~ 0
GB_DATA_1
Text GLabel 1100 1100 0    50   Input ~ 0
GB_PIXEL_CLK
Text GLabel 1100 1400 0    50   Input ~ 0
GB_VSYNC
Text GLabel 1600 1400 2    50   Input ~ 0
GB_VCC
Wire Wire Line
	1350 2350 1600 2350
Connection ~ 1350 2350
$Comp
L Power:GND #PWR0101
U 1 1 5C3B9391
P 1350 2650
F 0 "#PWR0101" H 1350 2400 50  0001 C CNN
F 1 "GND" H 1355 2477 50  0000 C CNN
F 2 "" H 1350 2650 50  0001 C CNN
F 3 "" H 1350 2650 50  0001 C CNN
	1    1350 2650
	1    0    0    -1  
$EndComp
$Comp
L Power:GND #PWR0102
U 1 1 5C3B93BC
P 2450 1050
F 0 "#PWR0102" H 2450 800 50  0001 C CNN
F 1 "GND" H 2455 877 50  0000 C CNN
F 2 "" H 2450 1050 50  0001 C CNN
F 3 "" H 2450 1050 50  0001 C CNN
	1    2450 1050
	1    0    0    -1  
$EndComp
Text GLabel 2450 1050 1    50   Input ~ 0
GB_GND
Text GLabel 1350 2050 0    50   Input ~ 0
GB_DATA_0
$Comp
L Device:R R5
U 1 1 5C3B9719
P 1350 4000
F 0 "R5" H 1420 4046 50  0000 L CNN
F 1 "510" H 1420 3955 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1280 4000 50  0001 C CNN
F 3 "~" H 1350 4000 50  0001 C CNN
F 4 "R" H 1350 4000 50  0001 C CNN "Spice_Primitive"
F 5 "510" H 1350 4000 50  0001 C CNN "Spice_Model"
F 6 "Y" H 1350 4000 50  0001 C CNN "Spice_Netlist_Enabled"
	1    1350 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 5C3B9722
P 1350 4300
F 0 "R6" H 1420 4346 50  0000 L CNN
F 1 "1k" H 1420 4255 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1280 4300 50  0001 C CNN
F 3 "~" H 1350 4300 50  0001 C CNN
F 4 "R" H 1350 4300 50  0001 C CNN "Spice_Primitive"
F 5 "1k" H 1350 4300 50  0001 C CNN "Spice_Model"
F 6 "Y" H 1350 4300 50  0001 C CNN "Spice_Netlist_Enabled"
	1    1350 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 4150 1600 4150
Connection ~ 1350 4150
$Comp
L Power:GND #PWR0103
U 1 1 5C3B972A
P 1350 4450
F 0 "#PWR0103" H 1350 4200 50  0001 C CNN
F 1 "GND" H 1355 4277 50  0000 C CNN
F 2 "" H 1350 4450 50  0001 C CNN
F 3 "" H 1350 4450 50  0001 C CNN
	1    1350 4450
	1    0    0    -1  
$EndComp
Text GLabel 1350 3850 0    50   Input ~ 0
GB_PIXEL_CLK
$Comp
L Device:R R3
U 1 1 5C3B9C9F
P 1350 3100
F 0 "R3" H 1420 3146 50  0000 L CNN
F 1 "510" H 1420 3055 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1280 3100 50  0001 C CNN
F 3 "~" H 1350 3100 50  0001 C CNN
F 4 "R" H 1350 3100 50  0001 C CNN "Spice_Primitive"
F 5 "510" H 1350 3100 50  0001 C CNN "Spice_Model"
F 6 "Y" H 1350 3100 50  0001 C CNN "Spice_Netlist_Enabled"
	1    1350 3100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 5C3B9CA8
P 1350 3400
F 0 "R4" H 1420 3446 50  0000 L CNN
F 1 "1k" H 1420 3355 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1280 3400 50  0001 C CNN
F 3 "~" H 1350 3400 50  0001 C CNN
F 4 "R" H 1350 3400 50  0001 C CNN "Spice_Primitive"
F 5 "1k" H 1350 3400 50  0001 C CNN "Spice_Model"
F 6 "Y" H 1350 3400 50  0001 C CNN "Spice_Netlist_Enabled"
	1    1350 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 3250 1600 3250
Connection ~ 1350 3250
$Comp
L Power:GND #PWR0104
U 1 1 5C3B9CB0
P 1350 3550
F 0 "#PWR0104" H 1350 3300 50  0001 C CNN
F 1 "GND" H 1355 3377 50  0000 C CNN
F 2 "" H 1350 3550 50  0001 C CNN
F 3 "" H 1350 3550 50  0001 C CNN
	1    1350 3550
	1    0    0    -1  
$EndComp
Text GLabel 1350 2950 0    50   Input ~ 0
GB_DATA_1
$Comp
L Connector_Generic:Conn_02x14_Counter_Clockwise TinyFPGA_BX1
U 1 1 5C3BA172
P 5350 1400
F 0 "TinyFPGA_BX1" H 5400 2217 50  0000 C CNN
F 1 "Conn_02x14_Odd_Even" H 5400 2126 50  0000 C CNN
F 2 "pcb:TinyFPGA_BX" H 5350 1400 50  0001 C CNN
F 3 "~" H 5350 1400 50  0001 C CNN
	1    5350 1400
	1    0    0    -1  
$EndComp
$Comp
L Power:GND #PWR0105
U 1 1 5C3BA287
P 4650 600
F 0 "#PWR0105" H 4650 350 50  0001 C CNN
F 1 "GND" H 4655 427 50  0000 C CNN
F 2 "" H 4650 600 50  0001 C CNN
F 3 "" H 4650 600 50  0001 C CNN
	1    4650 600 
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 600  4950 600 
Wire Wire Line
	4950 600  4950 800 
Wire Wire Line
	4950 800  5150 800 
$Comp
L Connector:DB15_Female_HighDensity VGA1
U 1 1 5C3BA5BF
P 9850 1450
F 0 "VGA1" H 9850 2317 50  0000 C CNN
F 1 "VGA" H 9850 2226 50  0000 C CNN
F 2 "library:DSUB-15-HD_Female_Vertical_P2.29x1.98mm_MountingHoles" H 9850 1450 50  0001 C CNN
F 3 "~" H 9850 1450 50  0001 C CNN
	1    9850 1450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5C3BAA88
P 1350 4950
F 0 "R7" H 1420 4996 50  0000 L CNN
F 1 "510" H 1420 4905 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1280 4950 50  0001 C CNN
F 3 "~" H 1350 4950 50  0001 C CNN
F 4 "R" H 1350 4950 50  0001 C CNN "Spice_Primitive"
F 5 "510" H 1350 4950 50  0001 C CNN "Spice_Model"
F 6 "Y" H 1350 4950 50  0001 C CNN "Spice_Netlist_Enabled"
	1    1350 4950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5C3BAA91
P 1350 5250
F 0 "R8" H 1420 5296 50  0000 L CNN
F 1 "1k" H 1420 5205 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1280 5250 50  0001 C CNN
F 3 "~" H 1350 5250 50  0001 C CNN
F 4 "R" H 1350 5250 50  0001 C CNN "Spice_Primitive"
F 5 "1k" H 1350 5250 50  0001 C CNN "Spice_Model"
F 6 "Y" H 1350 5250 50  0001 C CNN "Spice_Netlist_Enabled"
	1    1350 5250
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 5100 1600 5100
Connection ~ 1350 5100
$Comp
L Power:GND #PWR0106
U 1 1 5C3BAA99
P 1350 5400
F 0 "#PWR0106" H 1350 5150 50  0001 C CNN
F 1 "GND" H 1355 5227 50  0000 C CNN
F 2 "" H 1350 5400 50  0001 C CNN
F 3 "" H 1350 5400 50  0001 C CNN
	1    1350 5400
	1    0    0    -1  
$EndComp
Text GLabel 1350 4800 0    50   Input ~ 0
GB_VSYNC
Text GLabel 9550 1050 0    50   Input ~ 0
VGA_R
Text GLabel 9550 1250 0    50   Input ~ 0
VGA_G
Text GLabel 9550 1450 0    50   Input ~ 0
VGA_B
Text GLabel 10150 1450 2    50   Input ~ 0
VGA_HSYNC
Text GLabel 10150 1650 2    50   Input ~ 0
VGA_VSYNC
Text GLabel 9550 1150 0    50   UnSpc ~ 0
VGA_GND
Text GLabel 9550 1350 0    50   UnSpc ~ 0
VGA_GND
Text GLabel 9550 950  0    50   UnSpc ~ 0
VGA_GND
Text GLabel 9550 1750 0    50   UnSpc ~ 0
VGA_GND
Text GLabel 9550 1850 0    50   UnSpc ~ 0
VGA_GND
Text GLabel 10850 1400 1    50   UnSpc ~ 0
VGA_GND
$Comp
L Power:GND #PWR0107
U 1 1 5C3BCF2D
P 10850 1400
F 0 "#PWR0107" H 10850 1150 50  0001 C CNN
F 1 "GND" H 10855 1227 50  0000 C CNN
F 2 "" H 10850 1400 50  0001 C CNN
F 3 "" H 10850 1400 50  0001 C CNN
	1    10850 1400
	1    0    0    -1  
$EndComp
Text GLabel 1600 2350 2    50   Output ~ 0
IN_DATA_0
Text GLabel 1600 3250 2    50   Output ~ 0
IN_DATA_1
Text GLabel 1600 4150 2    50   Output ~ 0
IN_PIXEL_CLK
Text GLabel 1600 5100 2    50   Output ~ 0
IN_VSYNC
Text GLabel 5150 1300 0    50   Input ~ 0
IN_DATA_0
Text GLabel 5150 1500 0    50   Input ~ 0
IN_DATA_1
Text GLabel 5150 1800 0    50   Input ~ 0
IN_PIXEL_CLK
Text GLabel 5150 2100 0    50   Input ~ 0
IN_VSYNC
Text GLabel 5650 1100 2    50   Output ~ 0
OUT_R_1
Text GLabel 5650 1300 2    50   Output ~ 0
OUT_G_0
Text GLabel 5650 1600 2    50   Output ~ 0
OUT_B_0
Text GLabel 5650 2100 2    50   Output ~ 0
VGA_VSYNC
Text GLabel 5650 1900 2    50   Output ~ 0
VGA_HSYNC
Text Notes 2900 1900 2    50   ~ 0
GB 5v input, voltage dividers knocks down to 3.3v for FPGA
Text Notes 9500 2550 2    50   ~ 0
FPGA 3.3v signal needs dividing and laddering for VGA RGB 0 - 0.7V signal
Text GLabel 5650 1000 2    50   Output ~ 0
OUT_R_0
Text GLabel 5650 1400 2    50   Output ~ 0
OUT_G_1
Text GLabel 5650 1700 2    50   Output ~ 0
OUT_B_1
$Comp
L Device:R R10
U 1 1 5C3C361C
P 6850 3150
F 0 "R10" H 6920 3196 50  0000 L CNN
F 1 "470" H 6920 3105 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 6780 3150 50  0001 C CNN
F 3 "~" H 6850 3150 50  0001 C CNN
	1    6850 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 5C3C3676
P 6600 3150
F 0 "R9" H 6670 3196 50  0000 L CNN
F 1 "1k" H 6670 3105 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 6530 3150 50  0001 C CNN
F 3 "~" H 6600 3150 50  0001 C CNN
	1    6600 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 5C3C36DD
P 7050 3450
F 0 "R11" H 7120 3496 50  0000 L CNN
F 1 "10k" H 7120 3405 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 6980 3450 50  0001 C CNN
F 3 "~" H 7050 3450 50  0001 C CNN
	1    7050 3450
	1    0    0    -1  
$EndComp
$Comp
L Power:GND #PWR0108
U 1 1 5C3C3725
P 7050 3600
F 0 "#PWR0108" H 7050 3350 50  0001 C CNN
F 1 "GND" H 7055 3427 50  0000 C CNN
F 2 "" H 7050 3600 50  0001 C CNN
F 3 "" H 7050 3600 50  0001 C CNN
	1    7050 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 3300 6850 3300
Wire Wire Line
	7150 3300 7050 3300
Connection ~ 6850 3300
Text GLabel 6600 3000 1    50   Input ~ 0
OUT_R_0
Text GLabel 6850 3000 1    50   Input ~ 0
OUT_R_1
Text GLabel 7150 3300 2    50   Output ~ 0
VGA_R
Connection ~ 7050 3300
Wire Wire Line
	7050 3300 6850 3300
$Comp
L Device:R R13
U 1 1 5C3C4EDB
P 7800 3150
F 0 "R13" H 7870 3196 50  0000 L CNN
F 1 "470" H 7870 3105 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 7730 3150 50  0001 C CNN
F 3 "~" H 7800 3150 50  0001 C CNN
	1    7800 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R12
U 1 1 5C3C4EE1
P 7550 3150
F 0 "R12" H 7620 3196 50  0000 L CNN
F 1 "1k" H 7620 3105 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 7480 3150 50  0001 C CNN
F 3 "~" H 7550 3150 50  0001 C CNN
	1    7550 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R14
U 1 1 5C3C4EE7
P 8000 3450
F 0 "R14" H 8070 3496 50  0000 L CNN
F 1 "10k" H 8070 3405 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 7930 3450 50  0001 C CNN
F 3 "~" H 8000 3450 50  0001 C CNN
	1    8000 3450
	1    0    0    -1  
$EndComp
$Comp
L Power:GND #PWR0109
U 1 1 5C3C4EED
P 8000 3600
F 0 "#PWR0109" H 8000 3350 50  0001 C CNN
F 1 "GND" H 8005 3427 50  0000 C CNN
F 2 "" H 8000 3600 50  0001 C CNN
F 3 "" H 8000 3600 50  0001 C CNN
	1    8000 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 3300 7800 3300
Wire Wire Line
	8100 3300 8000 3300
Connection ~ 7800 3300
Text GLabel 7550 3000 1    50   Input ~ 0
OUT_G_0
Text GLabel 7800 3000 1    50   Input ~ 0
OUT_G_1
Text GLabel 8100 3300 2    50   Output ~ 0
VGA_G
Connection ~ 8000 3300
Wire Wire Line
	8000 3300 7800 3300
$Comp
L Device:R R16
U 1 1 5C3C5070
P 8750 3150
F 0 "R16" H 8820 3196 50  0000 L CNN
F 1 "470" H 8820 3105 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 8680 3150 50  0001 C CNN
F 3 "~" H 8750 3150 50  0001 C CNN
	1    8750 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R15
U 1 1 5C3C5076
P 8500 3150
F 0 "R15" H 8570 3196 50  0000 L CNN
F 1 "1k" H 8570 3105 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 8430 3150 50  0001 C CNN
F 3 "~" H 8500 3150 50  0001 C CNN
	1    8500 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R17
U 1 1 5C3C507C
P 8950 3450
F 0 "R17" H 9020 3496 50  0000 L CNN
F 1 "10k" H 9020 3405 50  0000 L CNN
F 2 "library:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 8880 3450 50  0001 C CNN
F 3 "~" H 8950 3450 50  0001 C CNN
	1    8950 3450
	1    0    0    -1  
$EndComp
$Comp
L Power:GND #PWR0110
U 1 1 5C3C5082
P 8950 3600
F 0 "#PWR0110" H 8950 3350 50  0001 C CNN
F 1 "GND" H 8955 3427 50  0000 C CNN
F 2 "" H 8950 3600 50  0001 C CNN
F 3 "" H 8950 3600 50  0001 C CNN
	1    8950 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 3300 8750 3300
Wire Wire Line
	9050 3300 8950 3300
Connection ~ 8750 3300
Text GLabel 8500 3000 1    50   Input ~ 0
OUT_B_0
Text GLabel 8750 3000 1    50   Input ~ 0
OUT_B_1
Text GLabel 9050 3300 2    50   Output ~ 0
VGA_B
Connection ~ 8950 3300
Wire Wire Line
	8950 3300 8750 3300
$EndSCHEMATC
