.section .data
.section .text
.globl main
main:
    pushq %rbp
    movq %rsp, %rbp

    mov $1, %eax
    jmp end
end:
    movq $0, %rax
    popq %rbp
    ret