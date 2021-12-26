%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
    
    lea esi,[a] ;сообщаем в esi адрес массива a
    lea edi,[b] ;сообщаем в edi адрес массива b
    mov ecx, 8 ; заносим в ecx количество элементов массива
    mov al,[esi]
    mov dl,8    ; заносим в al количество битов,для того,чтобы вести подсчет
third:;начинаем с 3 байта, так как подсчет идет с конца
    cmp dl,3
    jl second; если счетчик меньше 2 или 2, переходим ко второму байту
    mov dh,al
    and dh,0x7;логическое умножение позволяет "выделить" 3 нужных бита
    mov [edi],dh; переводим эти биты в распакованный массив 
    inc edi;смещение на единичку
    shr al,0x3; удаляем эти три разряда за счет сдвига
    sub dl,3;отнимаем 3 бита
    jmp gonnaCycle;идем к следующим битам    
second:;идем к 2 байту
    inc esi;смещение в упакованном массиве
    cmp dl,2
    jl firstone;когда счетчик меньше 2 или 2
    mov dh,al
    mov al,[esi];след байт
    and al,0x1  ;т.к. в предыдущем байте осталось 2 бита, из следующего выделяем 1 бит
    shl al,2    ;сдвигаем этот бит на 2 разряда вправо
    or dh,al    ;складываем биты
    mov [edi],dh ;занесение выделенного элемента в массив 
    inc edi     ;смещение+1
    mov al,[esi] 
    shr al,1    ;удалить младший бит
    mov dl,7    ;осталось 7 бит
    jmp gonnaCycle   ; след элемент
firstone:
    cmp dl,1
    jl third; так как во втором байте всего 1 бит, переходим к 1ому байту    
    mov dh,al
    mov al,[esi];переходим к следующему байту
    and al,0x3 ;из последующего байта выделяем всего 2 бита
    shl al,1    ;сдвигаем на 1 разряд
    or dh,al    ;складываем эти биты
    mov [edi],dh ;заносим в массив 3 бита
    inc edi     ;смещаем на единицу
    mov al,[esi]
    shr al,2    ;удаляем 2 оставшихся бита
    mov dl,6    ;всего еще 6 бит
    jmp gonnaCycle
imtired:
    mov al,[esi]
    mov dl,8    ;переводим счетчик к 8 битам
    jmp third
gonnaCycle:
    loop third
    ret
    
section .data
; Теперь переведем байты в 16-ичную систему счисления
a: DB 0x88, 0xc6, 0xfa;запакованный массив
b: DB 0,0,0,0,0,0,0,0;в этот массив распаковываем