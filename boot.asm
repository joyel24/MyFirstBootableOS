[bits 16]
[org 0x7c00] ;OS BootSector https://wiki.osdev.org/Memory_Map_(x86)

jmp $
times 510-($-$$) db 0
dw 0xaa55
