all: bootloader/boot.asm kernel/entry.asm kernel/kernel.c
	nasm -f bin bootloader/boot.asm -o boot
	nasm -f elf32 kernel/entry.asm -o entry.o
	i386-elf-gcc -o kernel.o kernel/kernel.c -nolibc -nostdlib
	i386-elf-ld -T linker.ld -o kernel.bin entry.o kernel.o --oformat binary
	cat boot kernel.bin > os.bin

run: all
	qemu-system-i386 -m 512M -drive file=os.bin,format=raw

debug: all
	qemu-system-i386 -m 512M -drive file=boot,format=raw -s -S
