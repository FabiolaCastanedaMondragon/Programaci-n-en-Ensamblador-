.model small          ; Define el modelo de memoria "small" con segmentos de 64 KB
.stack 64             ; Define el tama?o de la pila como 64 bytes
.data
msg db "mensaje$"     ; Declara una cadena llamada "msg" con el texto "mensaje", terminada en "$"
.code
inicio:
    mov ax, @data     ; Carga el segmento de datos en AX
    mov ds, ax        ; Mueve el valor de AX (segmento de datos) al registro DS

    ; Encontrar la longitud de la cadena (hasta el car?cter "$")
    mov cx, 0         ; Inicializa el contador en 0
    mov si, 0         ; Inicializa el ?ndice SI en 0
contar:
    mov al, msg[si]   ; Carga el car?cter actual en AL
    cmp al, '$'       ; Compara el car?cter con "$" (fin de la cadena)
    je imprimir_invertido ; Si encuentra "$", pasa al proceso de imprimir en orden inverso
    inc si            ; Incrementa SI para el siguiente car?cter
    inc cx            ; Incrementa CX para contar la longitud
    jmp contar        ; Repite hasta encontrar el final de la cadena

imprimir_invertido:
    dec cx            ; Ajusta CX para apuntar al ?ltimo car?cter de la cadena (sin el "$")
imprimir_ciclo:
    mov dl, msg[cx]   ; Carga el car?cter actual en DL
    mov ah, 02h       ; Funci?n 02h de DOS, imprime un solo car?cter
    int 21h           ; Llama a la interrupci?n 21h para mostrar el car?cter

    ; Imprimir nueva l?nea despu?s de cada car?cter
    mov dl, 0Dh       ; C?digo ASCII para retorno de carro
    int 21h           ; Llama a la interrupci?n 21h para retorno de carro
    mov dl, 0Ah       ; C?digo ASCII para nueva l?nea
    int 21h           ; Llama a la interrupci?n 21h para nueva l?nea

    dec cx            ; Decrementa CX para apuntar al car?cter anterior
    cmp cx, -1        ; Comprueba si CX es -1 (fin del recorrido hacia atr?s)
    jge imprimir_ciclo ; Si CX >= 0, contin?a el ciclo

salida:
    mov ax, 4c00h     ; C?digo de salida de DOS
    int 21h           ; Llama a la interrupci?n 21h para terminar el programa
end inicio            ; Marca el final del programa


