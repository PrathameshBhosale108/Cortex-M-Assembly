.section .vectors
vector_table:
    .word 0xABC0
    .word reset_handler
    .zero 400

    .section .text
    .align 1
    .type reset_handler, %function
reset_handler:
    MOV R1,#0x01
    MOV R2,#0x2
    ADD R3,R1,R2
    BL .