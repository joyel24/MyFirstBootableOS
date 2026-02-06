[bits 16] ; 8086
[org 0x7c00]

BOOT_DISK equ 0x800
mov [BOOT_DISK], dl ;get current disk fro bios

mov sp, 0x4000      ;> https://wiki.osdev.org/Memory_Map_(x86)
mov bp, 0x4000      ;> https://wiki.osdev.org/Memory_Map_(x86)

mov ah, 0           ; >set video mode https://instrum.org/inter/int1000.htm
mov al, 0x13        ; >to 13h (640X480 256colors)
mov bl, 0xffff      ; set color to
int 10h


mov ah, 0x2                 ;INT 13h AH=02h: Read Sectors From Drive https://en.wikipedia.org/wiki/INT_13H
mov al, 0x1                 ;Sectors To Read Count
mov ch, 0x0                 ;Cylinder
mov cl, 0x2                 ;Sector
mov dh, 0x0                 ;Head
mov bx, 0x7e00              ;Buffer Address Pointer
mov dl, [BOOT_DISK]         ;Drive
int 13h                     ;interrupt

jmp 0x7e00

times 510-($-$$) db 0       ; MBR 512
dw 0xaa55                   ; MBR 512



mov si, hello ; move hello content to si register
call error

jmp $               ; infinite loop

%include "print.asm"

disk_error: db "Cannot read disk", 13, 10, 0

hello: db "Hey! Hello from asm via bios", 0

times 1000 db 0 ;add 1000 times zeros to the end
