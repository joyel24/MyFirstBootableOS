[bits 16]
[org 0x7c00]

mov ah, 0xe     ; https://en.wikipedia.org/wiki/INT_10H (Teletype output)
mov al, "A"     ; character
mov bl, 0xff    ; color
mov bh, 0       ; page number
int 10h         ; https://en.wikipedia.org/wiki/INT_10H (10h interrupt)

jmp $

times 510-($-$$) db 0       ; MBR 512
dw 0xaa55                   ; MBR 512
