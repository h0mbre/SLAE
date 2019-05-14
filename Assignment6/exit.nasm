global _start


section .text

_start:

	xor eax, eax
	inc eax			; this should save us a byte
	xor ebx, ebx
	int 0x80
