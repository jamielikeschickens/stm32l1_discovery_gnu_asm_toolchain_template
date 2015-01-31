@ COMS20001 Skeleton for Lab1
@ (C) Simon J. Hollis, Jan 2015
@ simon@cs.bris.ac.uk
@ Define this file as containing code and called "Lab1"

@AREA Lab1, CODE, READONLY
.section .text

@ We will write ThumbV1 code
.code 16

@ Import some global symbols:
@ The address to read from to read the button
.extern GPIOA_IDR
@ The address to write to to light the LEDs
.extern GPIOB_ODR
@ The address to read a timer value from
.extern TIM2_CNT
@ Define the first line of user code
.global Lab_Start
Lab_Start:
@ ===================
@ Your code goes here
@ ===================
@ ================
@ End your program
@ ================
Stop:
	B Stop @ an infinite loop
.end @ Mark end of file
