.MODEL SMALL
.STACK 100H
.DATA
; Definimos la cadena a mostrar en hexadecimal
msg db 'TESJI', '$'

.CODE
; Macro para mostrar un car?cter en hexadecimal
SHOW_HEX MACRO char
    MOV AH, 02H          ; Funci?n 02h de INT 21h (mostrar car?cter)
    MOV DL, char         ; Coloca el car?cter en DL
    INT 21H              ; Llama a la interrupci?n para mostrar
ENDM

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Llamamos a la macro SHOW_HEX con cada letra en hexadecimal
    SHOW_HEX 54H         ; 'T'
    SHOW_HEX 45H         ; 'E'
    SHOW_HEX 53H         ; 'S'
    SHOW_HEX 4AH         ; 'J'
    SHOW_HEX 49H         ; 'I'

    ; Finalizamos el programa
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN