DATA_SEG    SEGMENT
    MSG1    DB  'Resta de dos numeros',13,10,'$'
    MSG2    DB  13,10,'Ingresa el primer numero: $'
    MSG3    DB  13,10,'Ingrsa el segundo numero: $'
    MSG4    DB  13,10,'La resta de los numeros es: $'
    NUM1    DW  0               ; Almacena el primer n?mero ingresado
    NUM2    DW  0               ; Almacena el segundo n?mero ingresado
    MUL_FAC DB  10              ; Factor de multiplicaci?n para convertir a decimal
    ARR_NUM DW  50 DUP(0)       ; Array para almacenar el resultado en forma de caracteres
DATA_SEG    ENDS

CODE_SEG    SEGMENT
   ASSUME CS: CODE_SEG, DS:DATA_SEG
    START:  MOV     AX, DATA_SEG
            MOV     DS, AX
    ; Mostrar mensaje inicial
    INITIAL_MSG:
            MOV     AH, 09
            MOV     DX, OFFSET MSG1
            INT     21H
    ; Mostrar mensaje y solicitar el primer n?mero
    FIRST_MSG:
            MOV     AH, 09
            MOV     DX, OFFSET MSG2
            INT     21H
    ; Leer y convertir el primer n?mero a valor num?rico
    GET_1ST_NUM:
            MOV     AH, 01
            INT     21H
            CMP     AL,13              ; Comprobar si se presion? Enter (c?digo ASCII 13)
            JZ      SECOND_MSG         ; Si es Enter, pasa al siguiente n?mero
    CONVERT_1ST_NUM:
            SUB     AL, 48             ; Convierte el ASCII a n?mero
            MOV     BL, AL
            MOV     BH, 0
            MOV     AX, NUM1
            MUL     MUL_FAC            ; Multiplica por 10 para desplazar el d?gito
            ADD     BX, AX             ; Suma el nuevo d?gito
            MOV     NUM1, BX           ; Actualiza NUM1
            JMP     GET_1ST_NUM
    ; Mostrar mensaje y solicitar el segundo n?mero
    SECOND_MSG:
            MOV     AH, 09
            MOV     DX, OFFSET MSG3
            INT     21H
    ; Leer y convertir el segundo n?mero a valor num?rico
    GET_2ND_NUM:
            MOV     AH, 01
            INT     21H
            CMP     AL,13              ; Comprobar si se presion? Enter
            JZ      SUBTRACT_NUMS      ; Si es Enter, pasa a la resta
    CONVERT_2ND_NUM:
            SUB     AL, 48
            MOV     BL, AL
            MOV     BH, 0
            MOV     AX, NUM2
            MUL     MUL_FAC
            ADD     BX, AX
            MOV     NUM2, BX
            JMP     GET_2ND_NUM
    ; Realizar la resta de los n?meros
    SUBTRACT_NUMS:
            MOV     BX, NUM1
            MOV     CX, NUM2
            SUB     BX, CX             ; Realiza la resta NUM1 - NUM2
            MOV     CX, BX             ; Almacena el resultado en CX

            ; Mostrar mensaje del resultado
            MOV     AH, 09
            MOV     DX, OFFSET MSG4
            INT     21H
    ; Convertir el resultado a ASCII y mostrarlo
    DISPLAYING:
            MOV     AX, CX
            MOV     BX, 10
            MOV     DI, OFFSET ARR_NUM   ; DI apunta al array de resultado
    ; Desglose de d?gitos del resultado
    BREAKING_NUM:
            MOV     DX, 0
            DIV     BX                  ; Divide AX por 10 para obtener el ?ltimo d?gito
            ADD     DX, 48              ; Convierte el d?gito a ASCII
            MOV     [DI], DX
            INC     DI
            CMP     AX, 0
            JZ      JOIN_N_DISPLAY      ; Salta cuando el n?mero ha sido desglosado por completo
            JMP     BREAKING_NUM
    ; Mostrar los d?gitos desglosados
    JOIN_N_DISPLAY:
            DEC     DI
            MOV     DL, [DI]
            MOV     AH, 02
            INT     21H
            CMP     DI, OFFSET ARR_NUM
            JNZ     JOIN_N_DISPLAY
    ; Finalizar el programa
    EXIT_PROGRAM:
            MOV     AH, 4CH
            MOV     AL, 0
            INT     21H
CODE_SEG    ENDS
    END START
