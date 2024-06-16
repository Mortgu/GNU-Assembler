.equ LIMIT, 3
.section .rodata
content:
.asciz "%c"
space:
.asciz " "
end:
.asciz "\n"
.section .text
.globl main
.type main, @function
main:
    pushq %rbp
    movq %rsp, %rbp

    // k = 1
    movb $1, %r14b

    .DO:
        // i = 1
        movb $1, %r12b
        jmp .FOR_2

        .FOR_1:
            // j = 1
            movb $1, %r13b
            jmp .WHILE_TEST

            .WHILE_BODY:
                movq $content, %rdi
                movzbq %r13b, %rsi
                addq $48, %rsi

                // printf("%d", j++);
                call printf

                // j++;
                incb %r13b

            // WHILE TEST EXPRESSION
            .WHILE_TEST:
                cmpb $LIMIT, %r13b
                jle .WHILE_BODY

            movq $space, %rdi
            call printf

            //addb $1, %r12b
            incb %r12b

        // FOR TEST EXPRESSION
        .FOR_2:
            cmpb $LIMIT, %r12b
            jle .FOR_1
        
        // puts("")
        movq $end, %rdi
        call puts
        // k++
        incb %r14b
        
        // OUTER WHILE TEST
        cmpb $LIMIT, %r14b
        jle .DO

    movq $0, %rax
    popq %rbp
    ret