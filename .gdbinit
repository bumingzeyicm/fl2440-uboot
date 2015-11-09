target remote 127.0.0.1:3333
monitor reset
monitor halt
monitor wait_halt
monitor arm920t cp15 2 0
monitor step

echo Configuring system...\n
#disable watchdog
monitor mww 0x53000000 0

#disalbe interrupt --- int-mask register 
monitor mww 0x4A000008 0xFFFFFFFF

#disalbe interrupt --- int-sub-mask register 
monitor mww 0x4A00001C 0x7FFF 

#initialize system clocks --- locktime register
monitor mww 0x4C000000 0xFF000000

#initialize system clocks --- clock-divn register
#CLKDVIN_400_148�������S3C2410(1:2:4), ��Ϊ0x3
monitor mww 0x4C000014 0x5

#initialize system clocks --- upll register
# �����S3C2410����Ϊ0x280102
monitor mww 0x4C000008 0x38022

#initialize system clocks --- mpll register
# 12M for FCLK=400M, �����S3C2410(200MHz)����Ϊ0x5c0400
monitor mww 0x4C000004 0x5c011

#setup memory controller
echo Configuring the SDRAM controller...\n
#conw
monitor mww 0x48000000 0x2201d110
#bank0
monitor mww 0x48000004 0x00000700
#bank1
monitor mww 0x48000008 0x00000700
#bank2
monitor mww 0x4800000c 0x00000700
#bank3
monitor mww 0x48000010 0x00001f4c
#bank4
monitor mww 0x48000014 0x00001f88
#bank5
monitor mww 0x48000018 0x00007ffc
#bank6
monitor mww 0x4800001c 0x00018005
#bank7
monitor mww 0x48000020 0x00018005
#vREFRESH HCLK=100MHz
monitor mww 0x48000024 0x008C04F4
#vBANKSIZE
monitor mww 0x48000028 0xB1
#vMRSRB6
monitor mww 0x4800002c 0x30
#vMRSRB7
monitor mww 0x48000030 0x30

load
break main
continue
