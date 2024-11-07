.model small
.stack 64
.data

numero1_tens db 0           ; Declaraci?n de variable para las decenas del primer n?mero
numero1_units db 0          ; Declaraci?n de variable para las unidades del primer n?mero
numero2_tens db 0           ; Declaraci?n de variable para las decenas del segundo n?mero
numero2_units db 0          ; Declaraci?n de variable para las unidades del segundo n?mero
suma_tens db 0              ; Declaraci?n de variable para las decenas de la suma
suma_units db 0             ; Declaraci?n de variable para las unidades de la suma
resta_tens db 0             ; Declaraci?n de variable para las decenas de la resta
resta_units db 0            ; Declaraci?n de variable para las unidades de la resta

mensaje1 db 10,13, "Ingresa el primer n?mero (dos d?gitos): ", "$" ; Mensaje para el primer n?mero
mensaje2 db 10,13, "Ingresa el segundo n?mero (dos d?gitos): ", "$" ; Mensaje para el segundo n?mero
mensaje3 db 10,13, "La suma es: ", "$" ; Mensaje para mostrar la suma
mensaje4 db 10,13, "La resta es: ", "$" ; Mensaje para mostrar la resta

.code
begin proc far

mov ax,@data                ; Inicializa el segmento de datos
mov ds, ax                  ; Mueve el segmento de datos a DS

; Primer n?mero
mov ah,09h                  ; Funci?n para mostrar un string
lea dx,mensaje1             ; Carga la direcci?n del mensaje1
int 21h                     ; Llama a la interrupci?n 21h para mostrar el mensaje
mov ah,01                   ; Funci?n para leer un car?cter
int 21h                     ; Llama a la interrupci?n 21h para leer un car?cter
sub al, 30h                 ; Convierte el car?cter de ASCII a valor num?rico
mov numero1_tens, al       ; Guarda las decenas del primer n?mero
mov ah,01                   ; Funci?n para leer el siguiente car?cter
int 21h                     ; Llama a la interrupci?n 21h para leer un car?cter
sub al, 30h                 ; Convierte el car?cter de ASCII a valor num?rico
mov numero1_units, al       ; Guarda las unidades del primer n?mero

; Segundo n?mero
mov ah,09h                  ; Funci?n para mostrar un string
lea dx,mensaje2             ; Carga la direcci?n del mensaje2
int 21h                     ; Llama a la interrupci?n 21h para mostrar el mensaje
mov ah,01                   ; Funci?n para leer un car?cter
int 21h                     ; Llama a la interrupci?n 21h para leer un car?cter
sub al, 30h                 ; Convierte el car?cter de ASCII a valor num?rico
mov numero2_tens, al       ; Guarda las decenas del segundo n?mero
mov ah,01                   ; Funci?n para leer el siguiente car?cter
int 21h                     ; Llama a la interrupci?n 21h para leer un car?cter
sub al, 30h                 ; Convierte el car?cter de ASCII a valor num?rico
mov numero2_units, al       ; Guarda las unidades del segundo n?mero

; Suma
mov al, numero1_tens        ; Carga las decenas del primer n?mero en AL
add al, numero2_tens        ; Suma las decenas del segundo n?mero a AL
daa                          ; Ajusta el resultado para la suma BCD
mov suma_tens, al           ; Guarda el resultado en suma_tens
mov al, numero1_units        ; Carga las unidades del primer n?mero en AL
add al, numero2_units        ; Suma las unidades del segundo n?mero a AL
daa                          ; Ajusta el resultado para la suma BCD
mov suma_units, al          ; Guarda el resultado en suma_units

; Resta
mov al, numero1_tens        ; Carga las decenas del primer n?mero en AL
sub al, numero2_tens        ; Resta las decenas del segundo n?mero de AL
das                          ; Ajusta el resultado para la resta BCD
mov resta_tens, al          ; Guarda el resultado en resta_tens
mov al, numero1_units        ; Carga las unidades del primer n?mero en AL
sub al, numero2_units        ; Resta las unidades del segundo n?mero de AL
das                          ; Ajusta el resultado para la resta BCD
mov resta_units, al         ; Guarda el resultado en resta_units

; Mostrar suma
mov ah, 09h                 ; Funci?n para mostrar un string
lea dx,mensaje3             ; Carga la direcci?n del mensaje3
int 21h                     ; Llama a la interrupci?n 21h para mostrar el mensaje
mov al,suma_tens            ; Carga las decenas de la suma en AL
add al,30h                  ; Convierte el valor num?rico a car?cter ASCII
mov dl,al                   ; Mueve el car?cter ASCII a DL
mov ah, 02                  ; Funci?n para mostrar un car?cter
int 21h                     ; Llama a la interrupci?n 21h para mostrar el car?cter
mov al,suma_units           ; Carga las unidades de la suma en AL
add al,30h                  ; Convierte el valor num?rico a car?cter ASCII
mov dl,al                   ; Mueve el car?cter ASCII a DL
mov ah, 02                  ; Funci?n para mostrar un car?cter
int 21h                     ; Llama a la interrupci?n 21h para mostrar el car?cter

; Mostrar resta
mov ah, 09h                 ; Funci?n para mostrar un string
lea dx,mensaje4             ; Carga la direcci?n del mensaje4
int 21h                     ; Llama a la interrupci?n 21h para mostrar el mensaje
mov al,resta_tens           ; Carga las decenas de la resta en AL
add al,30h                  ; Convierte el valor num?rico a car?cter ASCII
mov dl,al                   ; Mueve el car?cter ASCII a DL
mov ah, 02                  ; Funci?n para mostrar un car?cter
int 21h                     ; Llama a la interrupci?n 21h para mostrar el car?cter
mov al,resta_units          ; Carga las unidades de la resta en AL
add al,30h                  ; Convierte el valor num?rico a car?cter ASCII
mov dl,al                   ; Mueve el car?cter ASCII a DL
mov ah, 02                  ; Funci?n para mostrar un car?cter
int 21h                     ; Llama a la interrupci?n 21h para mostrar el car?cter

begin endp
end begin
