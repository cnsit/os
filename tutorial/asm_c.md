# c call asm
- nasm -f elf32 add.asm -o add.o
- gcc -m32 main.c add.o -o main
- ./main
# asm call c
- nasm -f elf32 print.asm -o print.o
- gcc -m32 print.o -o print
- ./print
