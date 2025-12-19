# -------------------------------------------------
# Project configuration
# -------------------------------------------------
PROJECT = first
CPU     = cortex-m3
BOARD   = stm32vldiscovery

# -------------------------------------------------
# Toolchain
# -------------------------------------------------
CC      = arm-none-eabi-gcc
OBJDUMP = arm-none-eabi-objdump
READELF = arm-none-eabi-readelf
GDB     = gdb-multiarch
QEMU    = qemu-system-arm

# -------------------------------------------------
# Flags
# -------------------------------------------------
CFLAGS  = -mcpu=$(CPU) -mthumb -g -Wall -ffreestanding -nostdlib
LDFLAGS = -T map.ld -nostdlib

# -------------------------------------------------
# Default target
# -------------------------------------------------
all: qemu

# -------------------------------------------------
# Build + run in QEMU (paused, GDB ready)
# -------------------------------------------------
qemu: $(PROJECT).elf
	$(QEMU) -S \
	        -M $(BOARD) \
	        -cpu $(CPU) \
	        -nographic \
	        -kernel $(PROJECT).elf \
	        -gdb tcp::1234

# -------------------------------------------------
# ELF + analysis artifacts
# -------------------------------------------------
$(PROJECT).elf: $(PROJECT).o
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@
	$(OBJDUMP) -D -S $@ > $(PROJECT).elf.lst
	$(READELF) -a $@ > $(PROJECT).elf.debug

$(PROJECT).o: $(PROJECT).S
	$(CC) $(CFLAGS) -c $< -o $@

# -------------------------------------------------
# GDB attach (second terminal)
# -------------------------------------------------
gdb:
	$(GDB) -q $(PROJECT).elf \
	       -ex "target remote localhost:1234"

# -------------------------------------------------
# Cleanup
# -------------------------------------------------
clean:
	rm -f *.o *.elf *.elf.lst *.elf.debug
