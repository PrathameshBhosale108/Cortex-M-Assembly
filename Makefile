PROJECT = first
CPU ?= cortex-m3
BOARD ?= stm32vldiscovery

qemu:
	arm-none-eabi-as -mmthumb -mcpu=$(CPU) -ggdb -c first.S -o first.o
	arm-none-eabi-ld -Tmap.ld first.o -o first.elf
	arm-none-eabi-objdump -D -S first.elf > first.elf.lst
	arm-none-eabi-readelf -a first.elf > first.elf.debug 
	arm-none-eabi-arm -S -M $(BOARD) -cpu $(CPU) -nographic -kernel $(PROJECT).elf -gdb tcp::1234

gdb:
	gdb-multiarch -q $(PROJECT).elf -ex "target remote localhost:1234"

clean:
	rm -rf *.out *.elf .gdb_history *.lst *.debug *.o 