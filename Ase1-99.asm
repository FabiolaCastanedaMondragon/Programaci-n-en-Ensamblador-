.model small
.stack 100h

.data
    mensaje db 'Conteo ascendente:', 0Dh, 0Ah, '$'
    numero db '00', 0Dh, 0Ah, '$'  ; Variable para almacenar el n?mero a imprimir

.code
main:
    mov ax, @data        ; Inicializar segmento de datos
    mov ds, ax

    ; Mostrar el mensaje inicial
    mov ah, 09h          ; Funci?n 09h de DOS para imprimir cadena
    lea dx, mensaje      ; Cargar la direcci?n del mensaje en DX
    int 21h              ; Llamar a la interrupci?n de DOS

    ; Configurar el contador
    mov cx, 99           ; N?mero de iteraciones (1 a 99)
    mov bx, 1            ; Valor inicial del contador (1)
    mov si, 10           ; Divisor para obtener decenas y unidades

loop_conteo_ascendente:
    ; Dividir BX entre 10 para obtener decenas y unidades
    mov ax, bx           ; Mover el valor de BX a AX
    xor dx, dx           ; Limpiar DX antes de la divisi?n
    div si               ; AX / 10 => AL = decenas, DL = unidades

    ; Convertir las decenas a ASCII si es necesario
    cmp al, 0            ; Verificar si hay decenas
    je sin_decenas_ascendente
    add al, '0'          ; Convertir decenas a car?cter ASCII
    mov [numero], al     ; Almacenar el car?cter de decenas en 'numero'
    jmp convertir_unidades_ascendente

sin_decenas_ascendente:
    mov byte ptr [numero], ' '  ; Si no hay decenas, poner un espacio

convertir_unidades_ascendente:
    add dl, '0'          ; Convertir unidades a car?cter ASCII
    mov [numero+1], dl   ; Almacenar el car?cter de unidades en 'numero'

    ; Mostrar el n?mero
    mov ah, 09h          ; Funci?n 09h de DOS para imprimir cadena
    lea dx, numero       ; Cargar la direcci?n de 'numero' en DX
    int 21h              ; Llamar a la interrupci?n de DOS

    ; Incrementar el contador
    inc bx               ; Incrementar BX para el siguiente n?mero

    ; Decrementar CX y repetir si no es cero
    loop loop_conteo_ascendente

    ; Finalizar el programa
    mov ah, 4Ch          ; Funci?n 4Ch de DOS para terminar el programa
    int 21h              ; Llamar a la interrupci?n de DOS

end main



