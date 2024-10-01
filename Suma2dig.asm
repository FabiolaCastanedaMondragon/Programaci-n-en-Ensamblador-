.MODEL SMALL               ; Define el modelo de memoria como peque?o
.STACK 100h                ; Reserva 256 bytes para la pila

.DATA                      ; Inicio del segmento de datos
    num1 db 0              ; Variable para almacenar el primer n?mero
    num2 db 0              ; Variable para almacenar el segundo n?mero
    resultado db 0         ; Variable para almacenar el resultado de la suma
    mensaje db 10, 13, "Primer n?mero (dos d?gitos): $"; Mensaje para solicitar el primer n?mero
    mensaje2 db 10, 13, "Segundo n?mero (dos d?gitos): $"; Mensaje para solicitar el segundo n?mero
    mensaje3 db 10, 13, "La suma es: $"; Mensaje para mostrar la suma
    mensaje_error db 10, 13, "Cifra no adecuada: el resultado tiene tres d?gitos.$" ; Mensaje para resultado >= 100
    nueva_linea db 10, 13, "$"; Nueva l?nea para mejorar la visualizaci?n

.CODE                      ; Inicio del segmento de c?digo
main proc                  ; Inicio del procedimiento principal
    mov ax, @data          ; Cargar la direcci?n del segmento de datos en AX
    mov ds, ax             ; Mover el valor de AX a DS para acceder a las variables

    ; Solicitar el primer n?mero de dos d?gitos
    mov ah, 09h            ; Funci?n 09H para imprimir cadenas
    lea dx, mensaje        ; Cargar la direcci?n del mensaje en DX
    int 21h                ; Llamar a la interrupci?n para mostrar el mensaje

    ; Leer el primer d?gito del primer n?mero
    mov ah, 01h            ; Funci?n 01H para leer un car?cter del teclado
    int 21h                ; Interrupci?n para obtener el car?cter
    sub al, 30h            ; Convertir car?cter ASCII a n?mero (0-9)
    mov bl, al             ; Guardar el primer d?gito en BL

    ; Leer el segundo d?gito del primer n?mero
    mov ah, 01h            ; Funci?n 01H para leer el siguiente car?cter
    int 21h                ; Interrupci?n para obtener el car?cter
    sub al, 30h            ; Convertir car?cter ASCII a n?mero
    mov bh, al             ; Guardar el segundo d?gito en BH

    ; Calcular num1 = (primer_digito * 10) + segundo_digito
    mov al, bl             ; Mover el primer d?gito a AL
    mov ah, 0              ; Limpiar AH para que AX tenga solo el primer d?gito
    mov cl, 10             ; Cargar 10 en CL para multiplicar
    mul cl                 ; Multiplicar el primer d?gito por 10
    add al, bh             ; Sumar el segundo d?gito
    mov num1, al           ; Guardar el n?mero final en num1

    ; Solicitar el segundo n?mero de dos d?gitos
    mov ah, 09h            ; Funci?n 09H para imprimir cadenas
    lea dx, mensaje2       ; Cargar la direcci?n del mensaje2 en DX
    int 21h                ; Llamar a la interrupci?n para mostrar el mensaje

    ; Leer el primer d?gito del segundo n?mero
    mov ah, 01h            ; Funci?n 01H para leer un car?cter
    int 21h                ; Interrupci?n para obtener el car?cter
    sub al, 30h            ; Convertir car?cter ASCII a n?mero
    mov bl, al             ; Guardar el primer d?gito en BL

    ; Leer el segundo d?gito del segundo n?mero
    mov ah, 01h            ; Funci?n 01H para leer el siguiente car?cter
    int 21h                ; Interrupci?n para obtener el car?cter
    sub al, 30h            ; Convertir car?cter ASCII a n?mero
    mov bh, al             ; Guardar el segundo d?gito en BH

    ; Calcular num2 = (primer_digito * 10) + segundo_digito
    mov al, bl             ; Mover el primer d?gito a AL
    mov ah, 0              ; Limpiar AH
    mul cl                 ; Multiplicar por 10
    add al, bh             ; Sumar el segundo d?gito
    mov num2, al           ; Guardar el n?mero final en num2

    ; Sumar num1 y num2
    mov al, num1           ; Cargar num1 en AL
    add al, num2           ; Sumar num2 a AL
    mov resultado, al      ; Guardar la suma en resultado

    ; Verificar si el resultado es de tres d?gitos (mayor o igual a 100)
    cmp resultado, 100     ; Comparar el resultado con 100
    jae mostrar_error      ; Si es mayor o igual a 100, saltar a mostrar_error

    ; Mostrar el mensaje de la suma
    mov ah, 09h            ; Funci?n 09H para imprimir cadenas
    lea dx, mensaje3       ; Cargar la direcci?n del mensaje de resultado en DX
    int 21h                ; Mostrar el mensaje en pantalla

    ; Preparar para mostrar el resultado
    mov al, resultado       ; Cargar resultado en AL
    xor ah, ah             ; Limpiar AH para que AX tenga solo el resultado
    cmp al, 0              ; Verificar si el resultado es cero
    je mostrar_cero         ; Si es cero, ir a mostrar_cero

    ; Convertir a caracteres ASCII
    mov bx, 10             ; Divisor
    xor cx, cx             ; Limpiar CX para contar los d?gitos

convertir:
    xor dx, dx             ; Limpiar DX antes de dividir
    div bx                  ; Dividir AX entre 10
    push dx                 ; Guardar el residuo (d?gito)
    inc cx                  ; Incrementar el contador de d?gitos
    test ax, ax             ; Verificar si AX es cero
    jnz convertir           ; Repetir hasta que AX sea cero

    ; Mostrar los d?gitos en orden
mostrar_digitos:
    pop dx                  ; Obtener el d?gito
    add dl, 30h             ; Convertir a ASCII
    mov ah, 02h             ; Funci?n 02H para mostrar un car?cter
    int 21h                 ; Mostrar d?gito
    loop mostrar_digitos    ; Repetir para todos los d?gitos

    jmp fin                 ; Ir a la secci?n de finalizaci?n

mostrar_cero:
    ; Mostrar "0"
    mov dl, '0'             ; Cargar el car?cter '0'
    mov ah, 02h             ; Funci?n 02H para mostrar un car?cter
    int 21h                 ; Mostrar el car?cter '0'
    jmp fin

mostrar_error:
    ; Mostrar el mensaje de error para cifra no adecuada
    mov ah, 09h             ; Funci?n 09H para imprimir cadenas
    lea dx, mensaje_error   ; Cargar la direcci?n del mensaje de error
    int 21h                 ; Mostrar el mensaje de error en pantalla
    jmp fin                 ; Ir a la secci?n de finalizaci?n

fin:
    ; Nueva l?nea
    mov ah, 09h             ; Funci?n 09H para imprimir cadenas
    lea dx, nueva_linea     ; Cargar la direcci?n de nueva l?nea en DX
    int 21h                 ; Mostrar nueva l?nea

    ; Terminar el programa
    mov ax, 4C00h           ; Funci?n 4CH para salir
    int 21h                 ; Llamar a la interrupci?n para salir

main endp                  ; Fin del procedimiento principal
end main                   ; Fin del programa22222222