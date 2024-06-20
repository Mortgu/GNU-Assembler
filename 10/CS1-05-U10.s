.section .rodata
out: .asciz "Result: %ld\n"

.section .text
.globl main
.type main, @function
main:
    pushq %rbp
    movq %rsp, %rbp

    # 1th & 2th argument
    movq $1, %rdi
    movq $2, %rsi

    # Save sum
    subq $8, %rsp
    movq $0, (%rsp)
    movq %rsp, %rax # save address of sum in rax

    # rdi und rsi auf stack für die später addition (caller saved)
    pushq %rdi
    pushq %rsi

    # Prepare for function call
    subq $24, %rsp
    movq %rax, 16(%rsp)
    movq $8, 8(%rsp)
    movq $7, (%rsp)
    movq $6, %r9
    movq $5, %r8
    movq $4, %rcx
    movq $3, %rdx

    # Function call
    call calculateSumAndMultiply

    # Restore rsi & rdi
    popq %rsi # addq $8, %rsp
    popq %rdi # addq $8, %rsp

    # Prepare for printf
    addq %rdi, %rsi # add 1 + 2 -> %rsi as 2th argument
    addq %rax, %rsi # add 3 + return from calculateSumAndMultiply -> rsi as 2th argument
    movq $out, %rdi

    addq $8, %rsp # Free allocated memory and align stack pointer
    call printf

    movq $0, %rax
    popq %rbp
    ret

.globl calculateSumAndMultiply
.type calculateSumAndMultiply, @function
calculateSumAndMultiply:
    popq %r13 # ret address
    popq %r10 # 7th argument
    popq %r11 # 8th argument
    popq %r12 # 9th argument

    movq %rdi, %rax
    addq %rsi, %rax
    addq %rdx, %rax
    addq %rcx, %rax
    addq %r8, %rax
    addq %r9, %rax
    addq %r10, %rax
    addq %r11, %rax

    movq %rax, (%r12)

    # Prepare for function call multiply
    movq %r12, %rdx
    movq $3, %rsi
    movq $2, %rdi

    call multiply

    pushq %r13 # Push the return address back on the stack
    ret

.globl multiply
.type multiply, @function
multiply:
    movq (%rdx), %rax
    mulq %rsi
    mulq %rdi
    ret
