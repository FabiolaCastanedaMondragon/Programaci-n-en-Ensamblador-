.model small
.stack 64
.data
    num1 db ?              ; Variable para el primer n?mero
    num2 db ?              ; Variable para el segundo n?mero
    resultado_mul db ?     ; Variable para el resultado de la multiplicaci?n
    resultado_div db ?     ; Variable para el resultado de la divisi?n
    resultado_mod db ?     ; Variable para el resultado del m?dulo
    msg1 db "Ingrese el primer numero (0-9): $"
    msg2 db "Ingrese el segundo numero (0-9): $"
    msg_mul db "El resultado de la multiplicacion es: $"
    msg_div db "El resultado de la division es: $"
    msg_mod db "El resultado del modulo es: $"
    salto db 0ah, 0dh, '$' ; Salto de l?nea y retorno de carro

.code
inicio:
    ; Inicializaci?n del segmento de datos
    mov ax, @data          ; Carga la direcci?n del segmento de datos en AX
    mov ds, ax             ; Mueve la direcci?n del segmento de datos a DS
    ; Solicitar el primer n?mero
    mov dx, offset salto    ; Prepara la direcci?n del salto de l?nea
    mov ah, 09h             ; Funci?n para mostrar un string
    int 21h                 ; Llama a la interrupci?n 21h para mostrar el salto de l?nea
    mov dx, offset msg1     ; Carga la direcci?n del mensaje para el primer n?mero
    mov ah, 09h             ; Funci?n para mostrar un string
    int 21h                 ; Llama a la interrupci?n 21h para mostrar el mensaje
    ; Leer el primer n?mero
    mov ah, 01h             ; Funci?n para leer un car?cter
    int 21h                 ; Llama a la interrupci?n 21h para leer un car?cter
    sub al, '0'             ; Convierte el car?cter a n?mero (ASCII a valor num?rico)
    mov num1, al           ; Guarda el primer n?mero en la variable num1
    ; Solicitar el segundo n?mero
    mov dx, offset salto    ; Prepara la direcci?n del salto de l?nea
    mov ah, 09h             ; Funci?n para mostrar un string
    int 21h                 ; Llama a la interrupci?n 21h para mostrar el salto de l?nea
    mov dx, offset msg2     ; Carga la direcci?n del mensaje para el segundo n?mero
    mov ah, 09h             ; Funci?n para mostrar un string
    int 21h                 ; Llama a la interrupci?n 21h para mostrar el mensaje
    ; Leer el segundo n?mero
    mov ah, 01h             ; Funci?n para leer un car?cter
    int 21h                 ; Llama a la interrupci?n 21h para leer un car?cter
    sub al, '0'             ; Convierte el car?cter a n?mero (ASCII a valor num?rico)
    mov num2, al           ; Guarda el segundo n?mero en la variable num2
    ; Multiplicaci?n
    mov al, num1            ; Carga el primer n?mero en AL
    mul num2                ; Multiplica AL * num2, resultado en AX (AL: resultado, AH: 0)
    mov resultado_mul, al   ; Guarda el resultado de la multiplicaci?n en resultado_mul
    ; Divisi?n y m?dulo
    mov al, num1            ; Carga el primer n?mero en AL
    mov ah, 0               ; Limpia AH antes de la divisi?n (necesario para la divisi?n)
    div num2                ; Divide AL / num2, cociente en AL, residuo en AH
    mov resultado_div, al   ; Guarda el cociente en resultado_div
    mov resultado_mod, ah   ; Guarda el residuo (m?dulo) en resultado_mod
    ; Mostrar el resultado de la multiplicaci?n
    mov dx, offset salto     ; Prepara la direcci?n del salto de l?nea
    mov ah, 09h              ; Funci?n para mostrar un string
    int 21h                  ; Llama a la interrupci?n 21h para mostrar el salto de l?nea
    mov dx, offset msg_mul    ; Carga la direcci?n del mensaje de multiplicaci?n
    mov ah, 09h              ; Funci?n para mostrar un string
    int 21h                  ; Llama a la interrupci?n 21h para mostrar el mensaje
    add resultado_mul, '0'   ; Convierte el resultado de la multiplicaci?n a car?cter ASCII
    mov dl, resultado_mul     ; Mueve el car?cter ASCII a DL
    mov ah, 02h              ; Funci?n para mostrar un car?cter
    int 21h                  ; Llama a la interrupci?n 21h para mostrar el car?cter
    ; Mostrar el resultado de la divisi?n
    mov dx, offset salto     ; Prepara la direcci?n del salto de l?nea
    mov ah, 09h              ; Funci?n para mostrar un string
    int 21h                  ; Llama a la interrupci?n 21h para mostrar el salto de l?nea
    mov dx, offset msg_div    ; Carga la direcci?n del mensaje de divisi?n
    mov ah, 09h              ; Funci?n para mostrar un string
    int 21h                  ; Llama a la interrupci?n 21h para mostrar el mensaje
    add resultado_div, '0'   ; Convierte el resultado de la divisi?n a car?cter ASCII
    mov dl, resultado_div     ; Mueve el car?cter ASCII a DL
    mov ah, 02h              ; Funci?n para mostrar un car?cter
    int 21h                  ; Llama a la interrupci?n 21h para mostrar el car?cter
    ; Mostrar el resultado del m?dulo
    mov dx, offset salto     ; Prepara la direcci?n del salto de l?nea
    mov ah, 09h              ; Funci?n para mostrar un string
    int 21h                  ; Llama a la interrupci?n 21h para mostrar el salto de l?nea
    mov dx, offset msg_mod    ; Carga la direcci?n del mensaje de m?dulo
    mov ah, 09h              ; Funci?n para mostrar un string
    int 21h                  ; Llama a la interrupci?n 21h para mostrar el mensaje
    add resultado_mod, '0'   ; Convierte el resultado del m?dulo a car?cter ASCII
    mov dl, resultado_mod     ; Mueve el car?cter ASCII a DL
    mov ah, 02h              ; Funci?n para mostrar un car?cter
    int 21h                  ; Llama a la interrupci?n 21h para mostrar el car?cter
    ; Terminar el programa
    mov ax, 4c00h            ; C?digo de finalizaci?n del programa
    int 21h                  ; Llama a la interrupci?n 21h para terminar el programa
end inicio
