[bits 16] ; 8086
[org 0x7c00]

BOOT_DISK equ 0x800
KERNEL_LOCATION equ 0x1000

mov [BOOT_DISK], dl ;get current disk fro bios

mov sp, 0x4000      ;> https://wiki.osdev.org/Memory_Map_(x86)
mov bp, 0x4000      ;> https://wiki.osdev.org/Memory_Map_(x86)

mov ah, 0           ; >set video mode https://instrum.org/inter/int1000.htm
mov al, 0x3       ; >to 13h (640X480 256colors)
;mov bl, 0x0f        ; set color to
int 10h


mov ah, 0x2                 ;INT 13h AH=02h: Read Sectors From Drive https://en.wikipedia.org/wiki/INT_13H
mov al, 0x1                 ;Sectors To Read Count
mov ch, 0x0                 ;Cylinder
mov dh, 0x0                 ;Head
mov cl, 0x2                 ;Sector
mov bx, KERNEL_LOCATION     ;0x7e00              ;Buffer Address Pointer
mov dl, [BOOT_DISK]         ;Drive
int 13h                     ;interrupt

; Check if read error
jb read_error

CODE_SEG equ GDT_code - GDT_start
DATA_SEG equ GDT_data - GDT_start

cli
lgdt [GDT_descriptor]
mov eax, cr0
or eax, 1
mov cr0, eax

jmp CODE_SEG:start_protected_mode

read_error:
    mov si, disk_error
    call error
    jmp $

%include "bootloader/print.asm"

disk_error: db "Cannot read disk", 13, 10, 0

GDT_start:
    GDT_null:
        dd 0
        dd 0
    GDT_code:
        dw 0xFFFF
        dw 0x0
        db 0x0
        db 0b10011011
        db 0b11001111
        db 0x0
    GDT_data:
        dw 0xFFFF
        dw 0
        db 0
        db 0b10010011
        db 0b11001111
        db 0
GDT_end:

GDT_descriptor:
    dw GDT_end - GDT_start - 1
    dd GDT_start

[bits 32]
start_protected_mode:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    jmp KERNEL_LOCATION

jmp $

times 510-($-$$) db 0
dw 0xaa55
