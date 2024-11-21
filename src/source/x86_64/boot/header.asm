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