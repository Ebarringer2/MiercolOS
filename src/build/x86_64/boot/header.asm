; follows multiboot2 spec for x86_64 system architecture
; fo now, it just prints "hello world" and then hangs the sys

BITS 32                  ; 32-bit mode

section .multiboot_header
align 8                  ; align to 8 bytes

multiboot_header:
    dd 0xe85250d6        ; magic num for multiboot2

    dd 0                 ; i386 architecture

    ; header length
    dd multiboot_header_end - multiboot_header

    ; ensure sum of fields is zero
    dd -(0xe85250d6 + 0 + (multiboot_header_end - multiboot_header))

    ; end of multiboot 2 header
    ; honestly doing this just to follow the spec -- it's not required
    dw 0                 ; end tag type
    dw 0                 ; reserved
    dd 8                 ; end tag size (8 bytes)

multiboot_header_end:

section .text
align 4
start:
    ; print "hello world"
    mov edx, hello_msg   ; load the address of the message into edx
    call print_string    ; print the string

hang:
    jmp hang             ; infinite loop to keep the system running (hang system)

print_string:
    mov esi, edx         ; load edx into esi
    mov ah, 0x0E         ; BIOS teletype function
.next_char:
    lodsb                ; load byte at ds:si into al
    test al, al          ; check if end of string
    jz .done             ; if zero, we out (because its null terminated)
    int 0x10             ; print the character
    jmp .next_char       ; repeat
.done:
    ret

section .data
hello_msg db 'hello world', 0  ; null-terminated string (keep in mind for future functions)

section .bss
align 4
stack_space resb 8192    ; 8KB reserved for the stack
stack_size equ $ - stack_space

times 510-($-$$) db 0    ; fill the rest of the boot sector with zeros
dw 0xAA55                ; boot signature