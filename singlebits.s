.section .data
byte_91:
    .byte 0b01011011 
.section .text
.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    movb $0b00000100, %al 
    movb byte_91, %bl 
    andb %al, %bl 

    jz bit_not_set 

    mov $1, %eax
    jmp end
bit_not_set:
    mov $0, %eax
end:
    movq $0, %rax
    popq %rbp
    ret