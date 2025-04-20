.model small
.stack 100h
.data
    mensaje1 db 10,13,"Ingresa el primer n?mero: $"
    mensaje2 db 10,13,"Ingresa el segundo n?mero: $"
    mayor_mensaje db 10,13,"El n?mero mayor es: $"
    numero1 db ?
    numero2 db ?
    resultado db 0
.code
main proc
    ; Configurar segmento de datos
    mov ax, @data
    mov ds, ax

    ; Pedir el primer n?mero
    mov ah, 09h            ; Mostrar mensaje 1
    lea dx, mensaje1
    int 21h

    mov ah, 01h            ; Leer primer n?mero del teclado
    int 21h
    sub al, 30h            ; Convertir de ASCII a valor num?rico
    mov numero1, al        ; Guardar el primer n?mero en numero1

    ; Pedir el segundo n?mero
    mov ah, 09h            ; Mostrar mensaje 2
    lea dx, mensaje2
    int 21h

    mov ah, 01h            ; Leer segundo n?mero del teclado
    int 21h
    sub al, 30h            ; Convertir de ASCII a valor num?rico
    mov numero2, al        ; Guardar el segundo n?mero en numero2

    ; Comparar los n?meros
    mov al, numero1        ; Cargar numero1 en al
    mov bl, numero2        ; Cargar numero2 en bl
    cmp al, bl             ; Comparar los n?meros
    jg es_mayor            ; Si al > bl, saltar a es_mayor

    ; Si no, bl es mayor o igual
    mov al, bl             ; Cargar el n?mero mayor en al

es_mayor:
    mov resultado, al      ; Guardar el resultado (el n?mero mayor)

    ; Mostrar el resultado
    mov ah, 09h            ; Mostrar mensaje "El n?mero mayor es: "
    lea dx, mayor_mensaje
    int 21h

    ; Convertir el n?mero a ASCII para mostrarlo
    mov al, resultado
    add al, 30h            ; Convertir de valor num?rico a ASCII

    ; Mostrar el n?mero
    mov dl, al
    mov ah, 02h
    int 21h

    ; Finalizar el programa
    mov ah, 4Ch
    int 21h
main endp
end main