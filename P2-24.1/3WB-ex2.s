/*
int calcula(float f);

double boba (float val) {
int i; #4
int pos; #4
double d[5]; #40

for (i=0; i<5; i++) {
pos = calcula(val);
d[pos] += val;
}
return d[0];
}
*/



.text
.globl boba
boba:

#------prologo---------
    pushq %rbp
    movq %rsp, %rbp
    subq $80, %rsp

#------inicializacao----
    movq %rbx, -8(%rbp)             # i 
    movq %r12, -16(%rbp)            # pos

    MOVSS %xmm0, -20(%rbp)          # val

    movq %r13, -28(%rbp)            # abrindo espaco p d[5]
    leaq -68(%rbp), %r13            # &d[]

#------logica-------------
    movl $0, %ebx                   # i=0
    FOR:
        cmp $5, %ebx                # i>=5?
        jge FIM                     # if True go to FIM

        MOVSS -20(%rbp), %xmm0      # val como argumento para a func
        call calcula

        movl %eax, %r12d            # pos = calcula(val)

        
        imull $8, %r12d             # pos *= 8
        movslq %r12d, %r12          # conversao para ponteiro

        movq %r13, %rcx             # vTemp = &d[]
        addq %r12, %rcx             # vTemp = d[pos]

        MOVSS -20(%rbp), %xmm0      # val
        CVTSS2SD %xmm0, %xmm0       # (double) val

        MOVSD (%rcx), %xmm1         # convertendo p fazer a soma
        ADDSD %xmm0, %xmm1          # d[pos] += val;
        MOVSD %xmm1, (%rcx)         # convertendo de volta

        incl %ebx                   # i++
        jmp FOR

    FIM:
    MOVSD (%r13), %xmm0

#-------epilogo=----------
    movq -8(%rbp), %rbx          
    movq -16(%rbp), %r12      
    movq -28(%rbp), %r13

    leave
    ret    
    



