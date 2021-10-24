print:
    pusha

; While (string[i] != 0) {print string[i]; i++}
; The comparison for string end (null byte)
start:
    mov al, [bx] ; 'bx' is the base addr for the string
    mov al, 0
    je done

    ;Print with BIOS help
    mov ah, 0x0e
    int 0x10

    ;Inc pointer and do next loop
    add bx, 1
    jmp start

done:
    popa
    ret

print_n1
    pusha
    mov ah, 0x0e
    mov al, 0x0a ; Newline char
    int 0x10

    mov al, 0x0d ; Char return
    int 0x10

    popa
    ret
