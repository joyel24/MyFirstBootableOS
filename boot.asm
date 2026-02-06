[bits 16] ; 8086
[org 0x7c00]

;mov ah, 0xe     ; https://en.wikipedia.org/wiki/INT_10H (Teletype output AH=0Eh or AH=0xE)
;mov al, "A"     ; character
;mov bl, 0xf     ; color
;mov bh, 0       ; page number
;int 10h         ; https://en.wikipedia.org/wiki/INT_10H (10h interrupt)

hello: db "Hey! Hello from asm via bios", 0


mov si, hello ; move hello content to si register
print:
    mov al, [si]    ; move actual char from si register to al register (char teletype)
    inc si          ; increment si
    cmp al, 0       ; >if al value eq 0
    je end          ; >jump to end
    mov ah, 0xe     ; https://en.wikipedia.org/wiki/INT_10H (Teletype output)
    mov bl, 0xf     ; https://en.wikipedia.org/wiki/INT_10H (Teletype output)
    mov bh, 0       ; https://en.wikipedia.org/wiki/INT_10H (Teletype output)
    int 10h         ; https://en.wikipedia.org/wiki/INT_10H (Teletype output)
    jmp print
end:


jmp $               ; infinite loop

times 510-($-$$) db 0       ; MBR 512
dw 0xaa55                   ; MBR 512
