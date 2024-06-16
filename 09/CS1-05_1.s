.section .data
aSh:
    .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
outResult:.asciz "%i\n"
.section .text
.globl main
.type main, @function
main:
    pushq %rbp
    movq %rsp, %rbp

    leaq aSh, %rdi
    movq $1, %rsi 
    movq $0, %rdx

    # X + 2 (4i + j)
    leaq (, %rsi, 4), %rax # 4 * i
    leaq (%rdi, %rax, 2), %rax # X + 8 * i
    movw (%rax, %rdx, 2), %ax  # (%ax) = 5

    movq $2, %rsi #i
    movq $3, %rdx #j
    leaq (, %rsi, 4), %rcx
    leaq (%rdi, %rcx, 2), %rcx
    movw (%rcx, %rdx, 2), %cx # (%cx) = 12

    addw %cx, %ax # 5 + 12

    movq $outResult, %rdi
    movswq %ax, %rsi
    call printf

    movq $0, %rax
    popq %rbp
    ret