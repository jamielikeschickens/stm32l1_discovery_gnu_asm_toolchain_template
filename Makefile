SRCS = System_Init.s Lab1-Task1.s

PROJ_NAME = main

CC_PREFIX = arm-none-eabi-
CC = $(CC_PREFIX)gcc
OBJCOPY = $(CC_PREFIX)objcopy
GDB = $(CC_PREFIX)gdb
STARTUP = startup_stm32l1xx_md.s
CFLAGS += -mcpu=cortex-m3 -mthumb -nostdlib -g
LINKER_SCRIPT = ld/stm32.ld

## ST-UTIL ##
STUTIL = st-util
STFLASH = st-flash


## TARGETS ##
all: program flash

program: $(SRCS)	
	$(CC) $(CFLAGS) -T $(LINKER_SCRIPT) $^ $(STARTUP) -o $(PROJ_NAME).elf
	$(OBJCOPY) -O binary $(PROJ_NAME).elf $(PROJ_NAME).bin

debug: program $(SRCS)	
	$(GDB) $(PROJ_NAME).elf -ex="tar extended-remote :4242" -ex="load"	

flash: 
	$(STFLASH) write $(PROJ_NAME).bin 0x08000000 

clean:
	rm $(PROJ_NAME).elf $(PROJ_NAME).bin

.PHONY: clean all
