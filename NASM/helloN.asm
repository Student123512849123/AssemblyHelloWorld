segment .text ; this is body of the program
   global _start ; for linker
_start:
   mov edx,len ; length of the message
   mov ecx,msg ; write a message
   mov ebx,1 ; for output (sys_out)
   mov eax,4 ; (sys_write)
   int 0x80 ; call kernel
   
   mov eax,1 ; stop (sys_exit)
   int 0x80 ; call kernel
   
segment .data 
msg db 'Hello, World', 0xa ; message (0xa = \n(newline))
len equ $ - msg ; length of the string
