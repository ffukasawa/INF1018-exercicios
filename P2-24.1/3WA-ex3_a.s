/*
void foo (double *vd, int n) {
while (n--) {
*vd = 0.0;
vd++;
}
}*/


.text
.globl foo
foo:
    #------prologo---------
    pushq %rbp
    movq %rsp, %rbp

    #------inicializacao----
    movl $0, %ecx           # int temp = 0
    CVTSI2SD %ecx, %xmm0    # (double)temp

    WHILE:
        cmp $0, %esi        # comparando 0 e n
        jle FIM

        MOVSD %xmm0, (%rdi)  # *vd = temp; ---> *vd = 0.0;
        addq $8, %rdi       # vd++;
        decl %esi            # n--;
        jmp WHILE
    FIM:
        #--------epilogo--------
        leave 
        ret

