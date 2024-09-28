CR EQU 13                        ; Definici?n del car?cter de retorno de carro (Carriage Return)
LF EQU 10                        ; Definici?n del car?cter de salto de l?nea (Line Feed)
CP EQU 32                        ; Definici?n del espacio en blanco

DATOS SEGMENT                   ; Inicio del segmento de datos
    LINEA1 DB CP, LF, 'Fabiola Castaneda Mondragon', CR, LF, '$'  ; Primera l?nea de texto
    LINEA2 DB CP, LF, 'Tecnologico de Estudios Superiores de Jilotepec', CR, LF, '$'  ; Segunda l?nea de texto
    LINEA3 DB CP, LF, 'Ing. Sistemas Computacionales', CR, LF, '$'  ; Tercera l?nea de texto
    LINEA4 DB CP, LF, 'Fabs ', CR, LF, '$'  ; Cuarta l?nea de texto
DATOS ENDS                      ; Fin del segmento de datos

PILA SEGMENT STACK              ; Inicio del segmento de pila
    DB 64 DUP(?)                ; Reservar 64 bytes para la pila
PILA ENDS                       ; Fin del segmento de pila

CODIGO SEGMENT                  ; Inicio del segmento de c?digo
    ASSUME CS:CODIGO, DS:DATOS, SS:PILA  ; Asignar segmentos a los registros apropiados
    
    LN PROC FAR                 ; Inicio del procedimiento LN
        MOV AX, DATOS          ; Cargar la direcci?n del segmento de datos en AX
        MOV DS, AX             ; Mover el contenido de AX al registro DS
        
        LEA DX, LINEA1        ; Cargar la direcci?n de LINEA1 en DX
        CALL ESCRIBE           ; Llamar a la funci?n ESCRIBE para imprimir LINEA1
        
        LEA DX, LINEA2        ; Cargar la direcci?n de LINEA2 en DX
        CALL ESCRIBE           ; Llamar a la funci?n ESCRIBE para imprimir LINEA2
        
        LEA DX, LINEA3        ; Cargar la direcci?n de LINEA3 en DX
        CALL ESCRIBE           ; Llamar a la funci?n ESCRIBE para imprimir LINEA3
        
        LEA DX, LINEA4        ; Cargar la direcci?n de LINEA4 en DX
        CALL ESCRIBE           ; Llamar a la funci?n ESCRIBE para imprimir LINEA4
        
        MOV AX, 4C00H         ; C?digo para finalizar el programa correctamente
        INT 21H                ; Llamada a la interrupci?n 21h para salir
    LN ENDP                     ; Fin del procedimiento LN

    ESCRIBE PROC                ; Inicio del procedimiento ESCRIBE
        MOV AH, 9              ; Funci?n 09H para imprimir cadenas en DOS
        INT 21H                ; Llamada a la interrupci?n 21h para ejecutar la funci?n
        RET                     ; Regresar al procedimiento que llam?
    ESCRIBE ENDP                ; Fin del procedimiento ESCRIBE
CODIGO ENDS                     ; Fin del segmento de c?digo

END LN                          ; Fin del programa, inicia la ejecuci?n desde el procedimiento LN
