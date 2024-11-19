.model small
.stack 64
.data

numero1_tens db 0
numero1_units db 0
numero2_tens db 0
numero2_units db 0
numero1 dw 0      ; Almacenar el primer n?mero completo (16 bits)
numero2 dw 0      ; Almacenar el segundo n?mero completo (16 bits)
mult dw 0         ; Resultado de la multiplicaci?n (16 bits)
divi db 0         ; Cociente de la divisi?n (8 bits)
modu db 0         ; Residuo de la divisi?n (m?dulo, 8 bits)

mensaje1 db 10,13, "Ingresa el primer numero (dos digitos): $"
mensaje2 db 10,13, "Ingresa el segundo numero (dos digitos): $"
mensaje3 db 10,13, "La multiplicacion es: $"
mensaje4 db 10,13, "La division es: $"
mensaje5 db 10,13, "El modulo es: $"

buffer db 6, '$'   ; Buffer para imprimir los n?meros

.code
start:
    ; Inicializaci?n del segmento de datos
    mov ax, @data
    mov ds, ax

    ; Mostrar mensaje1
    mov ah, 09h
    lea dx, mensaje1
    int 21h

    ; Leer el primer n?mero (dos d?gitos)
    mov ah, 01h
    int 21h
    sub al, 30h      ; Convertir decenas de ASCII a n?mero
    mov numero1_tens, al
    mov ah, 01h
    int 21h
    sub al, 30h      ; Convertir unidades de ASCII a n?mero
    mov numero1_units, al

    ; Mostrar mensaje2
    mov ah, 09h
    lea dx, mensaje2
    int 21h

    ; Leer el segundo n?mero (dos d?gitos)
    mov ah, 01h
    int 21h
    sub al, 30h      ; Convertir decenas de ASCII a n?mero
    mov numero2_tens, al
    mov ah, 01h
    int 21h
    sub al, 30h      ; Convertir unidades de ASCII a n?mero
    mov numero2_units, al

    ; Combinar decenas y unidades para formar n?meros de 2 d?gitos
    mov al, numero1_tens
    mov ah, 0
    mov bl, 10
    mul bl             ; Multiplicar por 10
    add al, numero1_units
    mov numero1, ax    ; Guardar el n?mero completo en numero1

    mov al, numero2_tens
    mov ah, 0
    mul bl             ; Multiplicar por 10
    add al, numero2_units
    mov numero2, ax    ; Guardar el n?mero completo en numero2

    ; Multiplicaci?n
    mov ax, numero1
    mov bx, numero2
    mul bx             ; Multiplicar AX por BX, resultado en DX:AX
    mov mult, ax       ; Guardar el resultado en mult

    ; Divisi?n y m?dulo
    mov ax, numero1    ; Cargar el primer n?mero en AX
    xor dx, dx         ; Limpiar DX para la divisi?n
    div bx             ; AX / BX -> Cociente en AX, residuo en DX
    mov divi, al       ; Guardar el cociente en divi
    mov modu, dl       ; Guardar el residuo (m?dulo) en modu

    ; Mostrar mensaje3 (Multiplicaci?n)
    mov ah, 09h
    lea dx, mensaje3
    int 21h
    mov ax, [mult]
    call print_number

    ; Mostrar mensaje4 (Divisi?n)
    mov ah, 09h
    lea dx, mensaje4
    int 21h
    mov al, divi
    call print_digit

    ; Mostrar mensaje5 (M?dulo)
    mov ah, 09h
    lea dx, mensaje5
    int 21h
    mov al, modu
    call print_digit

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

; Rutina para imprimir un n?mero de 16 bits (almacenado en AX)
print_number:
    ; Conversi?n de n?mero a caracteres ASCII
    mov bx, 10          ; Divisor
    xor cx, cx          ; Reiniciar contador de d?gitos
next_digit:
    xor dx, dx          ; Limpiar DX para la divisi?n
    div bx              ; AX = AX / BX, residuo en DX, cociente en AX
    add dl, 30h         ; Convertir el residuo a ASCII
    push dx             ; Guardar el car?cter en la pila
    inc cx              ; Incrementar el contador de d?gitos
    test ax, ax         ; Si AX = 0, terminar
    jnz next_digit

print_loop:
    pop dx              ; Recuperar el car?cter
    mov ah, 02h         ; Funci?n para mostrar car?cter
    int 21h             ; Imprimir car?cter
    loop print_loop     ; Repetir para todos los d?gitos
    ret

; Rutina para imprimir un n?mero de 1 d?gito (almacenado en AL)
print_digit:
    add al, 30h         ; Convertir a ASCII
    mov ah, 02h         ; Funci?n para mostrar car?cter
    mov dl, al
    int 21h             ; Imprimir car?cter
    ret

end start
