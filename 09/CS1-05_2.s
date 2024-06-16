.section .bss
.align 16
    # minimal gepackte Datenstruktur (c (1-Byte), n (4-Byte), *pN (8-Byte))
    .global object_1
    .lcomm object_1, 13
    # natural alignment (c (4-Byte), n (4-Byte), *pN (8-Byte))
    .global object_2
    .lcomm object_2, 16
    # Optimieren des Alignments durch Umordnung (n (4-Byte), *pN (8-Byte), c (1-Byte))
    .global object_3
    .lcomm object_3, 13

.section .data
out:.ascii "Summe: %i\n"

.section .text
.extern printf
.globl main
.type main, @function
main:
    pushq %rbp
    movq %rsp, %rbp

    # minimal gepackte Datenstruktur (c (1-Byte), n (4-Byte), *pN (8-Byte))
    movq $object_1, %rbx

    movb $97, (%rbx) # 
    movl $7, 1(%rbx) # 1 = offset
    leaq 1(%rbx), %r8 # Addresse von n in r8
    movq %r8, 5(%rbx) # Addresse von r8 an 1 + 4-Byte struct

    # natural alignment (c (4-Byte), n (4-Byte), *pN (8-Byte))
    movq $object_2, %rcx

    movb $97, (%rcx)
    movl $0, 1(%rcx)
    movl $36, 4(%rcx)
    leaq 4(%rcx), %r9
    movq %r9, 8(%rcx)

    # Optimieren des Alignments durch Umordnung (n (4-Byte), *pN (8-Byte), c (1-Byte))
    movq $object_3, %rdx

    movb $66, (%rdx)
    leaq (%rdx), %r10
    movq %r10, 4(%rdx)
    movb $97, 12(%rdx)

    movl 1(%rbx), %eax
    addl 4(%rcx), %eax
    addl (%rdx), %eax

    leaq out, %rdi
    movl %eax, %esi
    movq $0, %rax
    call printf

    popq %rbp
    ret