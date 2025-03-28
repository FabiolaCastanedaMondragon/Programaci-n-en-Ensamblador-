.model small
.stack 64
.data
msg db "mensaje", 0   ; Mensaje terminado en nulo
.code 
inicio:
    mov ax, @data
    mov ds, ax

    ; Calcular la longitud del mensaje (excluyendo el terminador nulo)
    mov si, 0          ; ?ndice para recorrer el mensaje
longitud:
    cmp msg[si], 0     ; Comprobar el final del string
    je imprime          ; Si encontramos el terminador, vamos a imprimir
    inc si             ; Incrementar ?ndice
    jmp longitud       ; Volver a comprobar
imprime:
    dec si             ; Ajustar si al ?ltimo ?ndice (longitud - 1)

    ; Imprimir el mensaje en orden inverso
ciclo:
    mov al, msg[si]    ; Cargar el car?cter correspondiente en AL
    mov ah, 02h
    mov dl, al         ; Mover el car?cter a DL
    int 21h            ; Imprimir car?cter

    ; Imprimir nueva l?nea
    mov ah, 02h
    mov dl, 0dh       ; Retorno de carro
    int 21h
    mov dl, 0ah       ; Salto de l?nea
    int 21h

    dec si             ; Decrementar el ?ndice
    cmp si, -1         ; Verificar si hemos alcanzado el principio
    jge ciclo          ; Si no, repetir el ciclo

    ; Terminar el programa
    mov ax, 4c00h
    int 21h

end inicio
