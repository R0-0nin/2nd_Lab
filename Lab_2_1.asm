%include "io.inc"

section .text
global CMAIN
counter:
    INC ESI
    CMP CX,0
    INC EDI
    JZ break
    LOOP COMPARE
zero:
    CMP CX,0
    JZ break
    INC ESI
    LOOP COMPARE
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    LEA ESI, [a]
    CMP CX,0
    JZ break
    MOV ECX, 5
    XOR EDX,EDX
    XOR EDI,EDI
COMPARE:
    CMP CX,0
    JZ break
    XOR DL, DL
    XOR BL, BL
    XOR EAX, EAX
    MOV AL, [ESI]
    ADD BL, AL
    MOV DL, 2
    DIV DL
    MUL DL   
    CMP AL,BL 
    JNZ counter
    JZ zero
    LOOP COMPARE
break:
    SUB DL, 1
    PRINT_UDEC 1, EDI
    ret

section .data
a: DB 2, 23, 5, 3, 2
