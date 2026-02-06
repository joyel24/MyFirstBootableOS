[bits 16] ; 8086
[org 0x7c00]

mov ah, 0           ; >set video mode https://instrum.org/inter/int1000.htm
mov al, 0x13        ; >to 13h (640X480 256colors)
mov bl, 0           ; set color to 0 (invisible black)
int 10h

mov si, hello ; move hello content to si register
print:
    mov al, [si]    ; move actual char from si register to al register (char teletype)
    inc si          ; increment si
    cmp al, 0       ; >if al value eq 0
    je end          ; >jump to end
    mov ah, 0xe     ; https://en.wikipedia.org/wiki/INT_10H
    mov bh, 0       ; https://en.wikipedia.org/wiki/INT_10H
    int 10h         ; interrupt https://en.wikipedia.org/wiki/INT_10H
    inc bl          ; change color every character

    mov ah, 0x86    ; https://en.wikipedia.org/wiki/BIOS_interrupt_call (86h wait for delay)
    mov al, 0
    mov dx, 0xffff
    mov cx, 0
    int 15h         ; https://en.wikipedia.org/wiki/BIOS_interrupt_call

    jmp print
end:

jmp $               ; infinite loop

%include "print.asm"

disk_error: db "Cannot read disk", 13, 10, 0

hello: db "Hey! Hello from asm via bios 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890", 0

times 510-($-$$) db 0       ; MBR 512
dw 0xaa55                   ; MBR 512
