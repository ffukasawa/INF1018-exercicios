/*
#define TAM 5
struct S {
 char c; 
 double d;
};

double corta (float f);
int indexa(int qtd);

double boba (float val, double *x, int n) {
 int i;
 struct S reg[TAM];

 while(n) {
 i = indexa(TAM);
 reg[i].c = i;
 reg[i].d = corta(val);
 n--
 }
 return reg[0].d;
}
*/



.text
.globl boba
boba:
#------prologo---------
    pushq %rbp
    movq %rsp, %rbp
    subq $128, %rsp
#------inicializacao----
    movq %rbx, -8(%rbp)             # i

    MOVSS %xmm0, -12(%rbp)          # val
    movq %rdi, -20(%rbp)            # &x
    movq %rsi, -28(%rbp)            # n

    movq %r12, -36(%rbp)    
    leaq -116(%rbp), %r12           # &reg[]

#---------logica---------
    movl %esi, %ecx                 # n
    WHILE:
        cmp $0, %ecx
        jle FIM

        movl $5, %edi
        call indexa

        movl %eax, %ebx         # i = indexa(TAM);

        movl %ebx, %r8d         #   iTemp = i 
        imull $16, %r8d         # iTemp = i * 16

        movq %r12, %r9          # vTemp
        movslq %r8d, %r8
        addq %r8, %r9           # &reg[i].c
        movslb %ebx, %bl        # i 
        movb %bl, (%r9)         # reg[i].c = i;

        movss -12(%rbp), %xmm0
        call corta

        movsd %xmm0, 8(%r9)
        decl %ecx
        jmp WHILE
    FIM:
    movsd -116(%rbp), %xmm0
#----------epilogo---------
    movq -8(%rbp), %rbx
    movq -20(%rbp), %rdi
    movq -28(%rbp), %rsi
    movq -36(%rbp), %r12

    leave 
    ret


        






