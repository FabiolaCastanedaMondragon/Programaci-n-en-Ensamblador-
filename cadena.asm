.model small          ; Define el modelo de memoria "small" con segmentos de 64 KB
.stack 64             ; Define el tama?o de la pila como 64 bytes
.data
msg db "mensaje$"     ; Declara una cadena llamada "msg" con el texto "mensaje", terminada en "$"
.code
inicio:
    mov ax, @data     ; Carga el segmento de datos en AX
    mov ds, ax        ; Mueve el valor de AX (segmento de datos) al registro DS

    mov ah, 09h       ; Funci?n 09h de DOS, imprime una cadena
    mov dx, offset msg ; Carga la direcci?n de "msg" en DX
    int 21h           ; Llama a la interrupci?n 21h para mostrar la cadena

    mov ah, 02        ; Funci?n 02h de DOS, imprime un solo car?cter
    mov dl, 0ah       ; C?digo ASCII para nueva l?nea
    int 21h           ; Llama a la interrupci?n 21h para nueva l?nea

    mov ah, 02        ; Funci?n 02h de DOS, imprime un solo car?cter
    mov dl, 0dh       ; C?digo ASCII para retorno de carro
    int 21h           ; Llama a la interrupci?n 21h para retorno de carro

    mov SI, 0         ; Inicializa el ?ndice SI en 0
ciclo:
    mov dl, msg[SI]   ; Carga el car?cter actual de "msg" en DL
    cmp dl, 24h       ; Compara el car?cter con "$" (fin de la cadena)
    je fuera_ciclo    ; Si encuentra "$", salta fuera del ciclo

    mov ah, 02        ; Funci?n 02h de DOS, imprime un solo car?cter
    mov dl, dl        ; Carga DL para imprimir el car?cter actual
    int 21h           ; Llama a la interrupci?n 21h para mostrar el car?cter

    mov ah, 02        ; Funci?n 02h de DOS, imprime un solo car?cter
    mov dl, 0ah       ; Nueva l?nea despu?s de imprimir el car?cter
    int 21h           ; Llama a la interrupci?n 21h para nueva l?nea
    inc SI            ; Incrementa SI para mover al siguiente car?cter
    jmp ciclo         ; Salta de nuevo al inicio del ciclo
fuera_ciclo:
    mov ax, 4c00h     ; C?digo de salida de DOS
    int 21h           ; Llama a la interrupci?n 21h para terminar el programa
end inicio            ; Marca el final del programa
