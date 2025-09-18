.model small
.stack 64

numero1 db 0
numero2 db 0
mult db 0
divi db 0
modu db 0

mensaje1 db 10,13, "ingresa el primer numero","$"
mensaje2 db 10,13, "ingresa el segundo numero","$"
mensaje3 db 10,13, "La multiplicacion es es  ", "$"
mensaje4 db 10,13, "La division es es  ","$"
mensaje5 db 10,13, "El modulo es  ","$"

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
mul numero2
mov mult,al

mov al,numero1
div numero2
mov divi,al

mov al,numero1
div numero2
mov modu,ah

mov ah,09h
lea dx,mensaje3
int 21h
mov al,mult
add al,30h
mov ah,02h
int 21h

mov ah,09h
lea dx,mensaje4
int 21h
mov al,divi
add al,30h
mov ah,02h
int 21h

mov ah,09h
lea dx,mensaje5
int 21h
mov al,modu
add al,30h
mov ah,02h
int 21h

mov ax,4c00h;salir del programa
int 21h
begin endp;termina procedimiento
end begin
