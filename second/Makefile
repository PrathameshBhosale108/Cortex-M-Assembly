PROJECT = second
CPU = cortex--m3
BOARD = stm32vldiscovery

CC = arm-none-eabi-gcc
OBJDUMP = arm-none-eabi-objdump
READELF = arm-none-eabi-readelf
GDB = gdb-multiarch
QEMU = qemu-system-arm

CFLAGS = -mcpu=$(CPU) -mthumb -g -Wall -ffreestanding -nostdlib
LDFLAGS = -T map2.ld -nostdlib

all: qemu

qemu: $(PROJECT).elf
	$(QEMU) -S \
			-M $(BOARD) \
			-cpu $(CPU) \
			-nographic
			-kernel $(PROJECT).elf \
			-gdb tcp::1234

$(PROJECT).elf: $(PROJECT).o 
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@
	$(OBJDUMP) -D -S $@ > $(PROJECT).elf.lst
	$(READELF) -a $@ > $(PROJECT).elf.debug

$(PROJECT).o: $(PROJECT).S 
	$(CC) $(CFLAGS) -c $< -o $@

gdb:
	$(GDB) -q $(PROJECT).elf \
		   -ex "target remote localhost:1234"

clean:
	rm -f *.o *.elf *elf.lst *.elf.debug
