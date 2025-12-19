.section .vectors
vector_table:
    .word 0xFF0
    .word reset_handler
    .zero 400

    .section .text
    .align 1
    .type reset_handler, %function
    .type COUNT, %function
COUNT:
    MOVS R0,#10
    MOVS R1,#0
    ADDS R2,R1,#1
    SUBS R0,#1
    BEQ COUNT
    B.

