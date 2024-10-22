.model small
.stack 100h
.data
    mensaje db 10,13,"Conteo ascendente: $"
.code
main proc
    ; Configurar segmento de datos
    mov ax, @data
    mov ds, ax

    ; Mostrar el mensaje inicial
    mov ah, 09h
    lea dx, mensaje
    int 21h

    ; Inicializar el contador en 1
    mov cl, 1

imprimir:
    ; Convertir el n?mero a ASCII
    mov al, cl
    add al, 30h
    
    ; Mostrar el n?mero en pantalla
    mov dl, al
    mov ah, 02h
    int 21h

    ; Pausa de salto de l?nea para que se vea mejor
    mov dl, 10   ; Salto de l?nea
    mov ah, 02h
    int 21h
    mov dl, 13   ; Retorno de carro
    mov ah, 02h
    int 21h

    ; Incrementar el contador
    inc cl
    cmp cl, 10   ; Comparar con 10, porque queremos de 1 a 9
    jne imprimir ; Si no es 10, seguir imprimiendo

    ; Finalizar el programa
    mov ah, 4Ch
    int 21h
main endp
end main