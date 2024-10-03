.model small ; se asigna tama?o de memeoria
.stack ;modelo de pila 
.data ;inicio de datos 
x db 10
y db 5
mensaje db 10,13,7, "Numero menor", "$"
mensaje2 db 10,13,7, "Numero mayor", "$"
.code ;inicio de codigo
main proc ;inicia proceso principal

mov al,x
mov bl,y
cmp al,bl
jg mayor
mayor:
mov ax, SEG @data
mov ds,ax
mov ah,09h
lea dx, mensaje2
int 21h
jmp fin
menor:
mov ax, SEG @data
mov ds,ax
mov ah,09h
lea dx,mensaje
int 21h

jmp fin
fin:
mov ax,4c00h
int 21h
main endp

end main 
