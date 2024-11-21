global start

section .text
BITS 32
align 4
start:
    ; print "hello world"
    mov edx, hello_msg
    call print_string

hang:
    ; halt the CPU
    hlt
    jmp hang

; print directly to video memory
print_string:
    mov esi, edx         ; load edx into esi
    mov edi, 0xb8000     ; point edi to the start of video memory
    mov ah, 0x2F         ; attr byte (green highlighting)
.next_char:
    lodsb                ; load byte at ds:si into al
    test al, al          ; check if end of string
    jz .done             ; if zero, we out (because it's null terminated)
    mov [edi], ax        ; write character and attribute to video memory
    add edi, 2           ; move to the next character position
    jmp .next_char       ; repeat
.done:
    ret

section .data
hello_msg db 'hello world', 0

section .bss
align 4
stack_space resb 8192    ; 8KB reserved for the stack

section .fill
times 510-($-$$) db 0    ; fill the rest of the boot sector with zeros
dw 0xAA55                ; boot signature