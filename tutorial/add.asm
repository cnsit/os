global Add
Add:
	push ebp
	mov ebp, esp
	mov eax, [ebp+8]
	add eax, 10
	mov esp, ebp
	pop ebp
	ret
	
