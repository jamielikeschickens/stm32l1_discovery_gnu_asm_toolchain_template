.section .text	
		
@ #defines
@ Clock enable register for the I/O Bus
.equ RCC_AHBENR, 0x4002381c
@ In/Out mode selection for GPIO ports
.equ GPIOA_MODER, 0x40020000
.equ GPIOB_MODER, 0x40020400
@ The data output register for GPIOB
.equ GPIOB_ODR, 0x40020414
@ The data input register for GPIOA
.equ GPIOA_IDR, 0x40020010
	
@ Clock enables for Timers2-7
.equ RCC_APB1ENR, 0x40023824

@ Timer2 control
.equ TIM2_CR1, 0x40000000
@ Timer2 pre-scaler
.equ TIM2_PSC, 0x40000028
@ The Timer2 count
.equ TIM2_CNT, 0x40000024
	
@ make label globally visible for the linker
.global SystemInit
.global GPIOA_IDR
.global GPIOB_ODR
.global TIM2_CNT
		
	.extern Lab_Start
		
	@ This will be ThumbV1 code
	.code 16
	
SystemInit:
	@ intialise the LED pins to support flashing the LEDs
	@ Blue LED is on pin PB6@ Green LED is on pin PB7
	@ User switch is on pin PA0
	
	@ Enable GPIOA and GPIOB clocks
	LDR r0, =RCC_AHBENR
	MOV r1, #3
	STR r1, [r0]
	
	@ Configure GPIOA as input
	LDR r0, =GPIOA_MODER
	LDR r1, =0xA8000000
	STR r1, [r0]
	
	@ Configure GPIOB as output
	LDR r0, =GPIOB_MODER
	LDR r1, =0x55555780
	STR r1, [r0]
	
	@ Light only green LED
	LDR r0, =GPIOB_ODR
	LDR r1, =0x80
	STR r1, [r0]
	
	@ Set timers clock on
	LDR r0, =RCC_APB1ENR
	LDR r1, =0x3f
	STR r1, [r0]
	
	@ Set the pre-scaler to slow down the counter
	LDR r0, =TIM2_PSC
	MOV r1, #0x0f
	STR r1, [r0]
	
	@ Set Timer2 running
	LDR r0, =TIM2_CR1
	MOV r1, #0x01
	STR r1, [r0]
	
	@ Wait with blue LED off until
	@ User button is pressed
	@ Then light blue LED and continue
Button_Wait:
	LDR r2, =GPIOA_IDR
	LDR r1, [r2]
	MOV r3, #0x01
	AND r1, r1, r3
	BEQ Button_Wait
	
	@ Light both LEDs now
	LDR r0, =GPIOB_ODR
	LDR r1, =0xc0
	STR r1, [r0]
	B Init_End

Init_End:
	@LDR r0, =Lab_Start
	@BX r0
	BL Lab_Start

	@ Return point is reached only after Lab code is completed
	BX lr 
	.align
	
	.end
