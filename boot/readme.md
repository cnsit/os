# Instructions
- nasm boot.asm -o boot.bin
- dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc
- bochs -f test.bxrc

# Debug
- pbreak 0x7c00, stop at the entry point
- n, next step
- info cpu, cpu registers and stacks information
- c, continue
