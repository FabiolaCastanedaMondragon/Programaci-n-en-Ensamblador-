.model small
.stack 64

numero1 db 0
numero2 db 0
suma db 0
resta db 0

mensaje1 db 10,13, "ingresa el primer numero","$"
mensaje2 db 10,13, "ingresa el segundo numero","$"
mensaje3 db 10,13, "La suma es  ", "$"
mensaje4 db 10,13, "La resta es  ","$"

.code
begin proc far

mov ax,@data
mov ds,ax
mov ah,09h
lea dx,mensaje1
int 21h
mov ah,01h
int 21h
sub al,30h
mov numero1,al

mov ah,09h
lea dx,mensaje2
int 21h
mov ah,01h
int 21h
sub al,30h
mov numero2,al

mov al,numero1
add al,numero2
mov suma,al

mov al, numero1
sub al, numero2
mov resta,al

mov ah,09h
lea dx,mensaje3
int 21h
mov al,suma
add al,30h
mov ah,02h
int 21h

mov ah,09h  
lea dx,mensaje4
int 21h
mov al,resta
add al,30h
mov ah,02h
int 21h

mov ax,4c00h;salir del programa
int 21h
begin endp;termina procedimiento
end begin
