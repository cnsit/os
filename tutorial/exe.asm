; nasm -f macho64 exe.asm -o exe.o
; ld exe.o -e _main -lc -no_pie -o exe
global _main
section .text

_main:
    mov     rax, 0x2000004 ; write
    mov     rdi, 1 ; stdout
    mov     rsi, msg
    mov     rdx, msg.len
    syscall

    mov     rax, 0x2000001 ; exit
    mov     rdi, 9
    syscall

section .data

msg:    db      "Assalam O Alaikum Dear", 10
.len:   equ     $ - msg
