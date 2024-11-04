.model small
.stack
.data

mensaje1 db 10,13,7,"Resultado de la pila:  ","$"

.code
main proc


mov ax, SEG @data
mov ds,ax

mov ah,09h
lea dx,mensaje1
int 21h

mov ax,0e59h
mov bx,0e41h
mov cx,0e4bh
mov dx,0e4fh

push ax
push bx
push cx
push dx

mov bx,0071h
pop ax
int 10h
pop ax
int 10h
pop ax
int 10h
pop ax
int 10h

mov ah,4ch
int 21h

main endp

end main