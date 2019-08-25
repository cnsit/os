org 0x7c00
bos equ 0x7c00
bol equ 0x1000 	;bol<<4 + ool = 0x10000 即BIOS执行完引导程序后转向的地址
ool equ 0x0000

rds equ 14 		;根目录占用的扇区数量(BPB_RootEntCnt * 32 + (512 - 1) )/512
snrd equ 19 	;根目录的起始扇区号。根目录在引导扇区和两个分区表（互为备份）之后，因此前面有1+9*2=19个扇区。
snfs equ 1 		;第一个分区表（FAT1）的起始扇区号。0号扇区留给了本boot程序，因此FAT分区表从1号扇区开始。
secb equ 17 	;目录起始与分区表起始扇区的差值
;上面这些都不占用磁盘存储

;下面开始的内容才写入引导磁盘
jmp short lb_start
nop
BS_OEMName 		db "CNSIT-FD" 	;8字节
BPB_BytesPerSec dw 512
BPB_SecPerClus 	db 1
BPB_RsvdSecCnt 	dw 1
BPB_NumFATs 	db 1
BPB_RootEntCnt 	dw 224
BPB_TotSec16 	dw 2880
BPB_Media 		db 0xf0 		;软驱
BPB_FATSz16 	dw 9 			;分区表占用的扇区，一般会有两个分区表互相备份，分区表存储所有文件的链接信息。类似链表。
BPB_SecPerTrk 	dw 18
BPB_NumHeads 	dw 2
BPB_hiddSec 	dd 0
BPB_TopSec32 	dd 0
BS_DrvNum 		dd 0
BS_Reserved1 	dd 0
BS_RootSig 		dd 0x29
BS_VolID 		dd 0
BS_VolLab 		db "Boot Loader" 	;11字节
BS_FileSysType 	db "FAT12   " 		;8字节

fn_fd_read_one_sector:
	push bp;
	mov bp, sp
	
lb_start:
