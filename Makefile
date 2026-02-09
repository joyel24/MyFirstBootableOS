CFLAGS=-Wall -Wextra -Iinclude

all: bootloader/boot.asm kernel/entry.asm kernel/kernel.c
	mkdir make_temp &
	nasm -f bin bootloader/boot.asm -o make_temp/boot
	nasm -f elf32 kernel/entry.asm -o make_temp/entry.o
	i386-elf-gcc $(CFLAGS) -c -o make_temp/kernel.o kernel/kernel.c -nolibc -nostdlib
	i386-elf-gcc $(CFLAGS) -c -o make_temp/io.o kernel/io.c -nolibc -nostdlib
	i386-elf-ld -T linker.ld -o make_temp/kernel.bin make_temp/entry.o make_temp/kernel.o make_temp/io.o --oformat binary
	cat make_temp/boot make_temp/kernel.bin > os.bin

run: all
	qemu-system-i386 -m 512M -drive file=os.bin,format=raw

debug: all
	qemu-system-i386 -m 512M -drive file=os.bin,format=raw -s -S

clean:
	rm -rf make_temp/ os.bin
