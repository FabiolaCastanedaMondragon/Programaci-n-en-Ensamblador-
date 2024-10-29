.model small
.stack 64
.data
msg db "mensaje$"
.code
inicio:
    mov ax,@data
    mov ds,ax
    mov ah,09h
    mov dx,offset msg
    int 21h

    mov ah,02
    mov dl,0ah
    int 21h

    mov ah,02
    mov dl,0dh
    int 21h

    mov SI,0
ciclo:
    mov dl,msg[SI]
    cmp dl,24h
    je fuera_ciclo

    mov ah,02
    mov dl,dl
    int 21h

    inc SI
    jmp ciclo

fuera_ciclo:
    mov ah,02
    mov dl,0ah
    int 21h
