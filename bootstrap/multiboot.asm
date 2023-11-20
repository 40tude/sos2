
MULTIBOOT_STACK_SIZE equ 0x4000                ; 16KB

section .bss
align 16
stack_bottom:
	resb MULTIBOOT_STACK_SIZE				
stack_top:
				
global start									; entry point of the operating system
extern sos_main

section .text 									; once loaded by grub2 we are in protected mode, pagination is not set... 
bits 32 
start:
	mov esp, stack_top							; Set the stack 
	
	push 0										; clear flags
	popf
     
	push ebx									; Push the pointer to the Multiboot information structure
	push eax									; Push the magic value

    call sos_main
	hlt											; We should never, ever come here
