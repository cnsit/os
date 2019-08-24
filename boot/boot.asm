org 0x7c00 		;ip = 0x7c00
bos equ 0x7c00 	;base of stack, equ 不会分配存储空间
start:
	mov ax, cs 	;cs = 0, so ax = 0, cs:ip
	mov ds, ax 	;设置数据段寄存器
	mov es, ax 	;附加段（目的数据）
	mov ss, ax 	;堆栈段
	mov sp, bos ;堆栈指针, ss:sp
cls:
	mov ax, 0x0600 	;ah=06 屏幕初始化或者上卷；ah=00，全屏幕为空白
	mov bx, 0x0700 	;白色
	mov cx, 0 		;左上角行列
	mov dx, 0x184f 	;24行，79列（对应25行x80列字符模式）
	int 0x10
cursor:
	mov ax, 0x0200 	;设置光标
	mov bx, 0 		;？图形模式
	mov dx, 0 		;左上角地址
	int 0x10
string:
	mov ax, 0x1301 	;显示字符串，字符属性由BX设置，且光标移至字符串末尾
	mov bx, 0x000e 	;
	mov dx, 0 		;坐标
	mov cx, len
	push ax
	mov ax, ds 		;es:bp 字符串地址
	mov es, ax
	pop ax
	mov bp, msg
	int 0x10
fdreset:
	xor ah, ah 		;set ah=0
	xor dl, dl 		;set dl=0, fd0, driver A
	int 0x13
	jmp $ 			;loop
data:
	msg db "Booting..."
	len equ $ - msg
times 510 - ($ - $$) db 0
dw 0xaa55
