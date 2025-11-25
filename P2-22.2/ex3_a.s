/*
float boba (float v, float li) {
return v + li;
}
*/

.text
.globl boba
#-------prologo---------
    pushq %rbp
    movq %rsp, %rbp

#--------logica-----------
    ADDSS %xmm1, %xmm0

#-------epilogo---------
    leave 
    ret