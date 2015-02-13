@AREA Lab1, CODE, READONLY
.section .text

@ We will write ThumbV1 code
.thumb

@ Import some global symbols:
@ The address to read from to read the button
.extern GPIOA_IDR
@ The address to write to to light the LEDs
.extern GPIOB_ODR
@ The address to read a timer value from
.extern TIM2_CNT
@ Define the first line of user code
.global Lab_Start

.thumb_func
Lab_Start:
@ ===================
@ Your code goes here
@ ===================

	LDR r1, =GPIOB_ODR
	LDR r2, =0x00
	STR r2, [r1]

@ ================
@ End your program
@ ================
Stop:
	B Stop @ an infinite loop
.end @ Mark end of file
