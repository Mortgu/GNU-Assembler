.section .rodata
intarr:
    .quad 1004, 999, 729, -33, 1002, 1006, 2000
.align 8
.L1:
    .quad .L2 # Case result = 1 // 999
    .quad .L6 # // 1000 
    .quad .L6 # // 1001 
    .quad .L3 # Case result = 2 // 1002
    .quad .L6 # // 1003
    .quad .L4 # Case result = 3 // 1004
    .quad .L6 # // 1005
    .quad .L5 # Case result = 3 // 1006
    .quad .L6 # Case default result = 0
.section .text
.globl _start
.type _start, @function
_start:
    pushq %rbp
    movq %rsp, %rbp

    # int64_t result = 0
    movq $0, %rax

    # int i = 0
    movq $0, %rcx

    jmp .FOR_TEST

    .FOR:
        # body
        movq intarr(, %rcx, 8), %rsi
        subq $999, %rsi
        
        .SWITCH:
            # compare %rsi for switch
            cmp $7, %rsi

            # JUMP TO DEFAULT CASE IF NUMBER IS GREATER THAN POSIBLE
            ja .L6
            jmp *.L1(, %rsi, 8)

            .L2:
                movq $1, %rax # result = 1
                jmp .LDONE
            .L3:
                movq $2, %rax # result = 2
                jmp .LDONE
            .L4:
            .L5:
                movq $3, %rax # result = 3
                jmp .LDONE
            .L6:
                movq $0, %rax # result = 0
                jmp .LDONE
            .LDONE:
                

        # Update expression
        incq %rcx

    # i <= 6
    .FOR_TEST:
        cmpq $6, %rcx
        jle .FOR

    end:
    movq $60, %rax
    xor %rdi, %rdi
    popq %rbp
    syscall