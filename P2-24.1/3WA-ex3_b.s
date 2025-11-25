/*
struct exam { float val; int tipo; };
double inv (double val);

float boo (double d, float bias) {
int i; #4
struct exam temp[5]; #40

for (i=0; i<5; i++) {
temp[i].val = inv(d);
temp[i].tipo = i;
}
return temp[0].val + bias;
}
*/


.text
.globl boo
boo:
#------prologo---------
    pushq %rbp
    movq %rsp, %rbp
    subq $80, %rsp

#------inicializacao----
    movq %rbx, -8(%rbp)         # i 

    MOVSD %xmm0, -16(%rbp)      # d 
    MOVSS %xmm1, -20(%rbp)      # bias

    movq %r12, -28(%rbp)        # abrindo espaco para o endereco do vetor temp
    leaq -68(%rbp), %r12        # temp[5]

#------logica-------------
    movl $0, %ebx               # i=0;

    FOR:
        cmp $5, %ebx            # comparando 5 e i
        jge FIM

        MOVSD -16(%rbp), %xmm0  # d como primeiro argumento 
        call inv                # retorna em %xmm0

        movl %ebx, %ecx         # iTemporario = i (pq iTemporario deve ser i*8 entao nao podem ser o mesmo i)
        imull $8, %ecx          # iTemporario = i*8
        movslq %ecx,%rcx

        movq %r12, %r8          # endTemp = &temp[0] -> para nao mudarmos %r12 e perdermos o end inicial 
        addq %rcx, %r8          # &temp[i].val

        CVTSD2SS %xmm0, %xmm0   # (float)inv(d)
        MOVSS %xmm0, (%r8)      # temp[i].val = inv(d);
        movl %ebx, 4(%r8)       # temp[i].tipo = i;

        incl %ebx
        jmp FOR

    FIM:
        MOVSS (%r12), %xmm0     # temp[0].val na variavel de retorno
        MOVSS -20(%rbp), %xmm1  # bias 
        ADDSS %xmm1, %xmm0      # temp[0].val + bias; 

#--------epilogo----------
        movq -8(%rbp), %rbx        
        movq -28(%rbp), %r12

        leave 
        ret

