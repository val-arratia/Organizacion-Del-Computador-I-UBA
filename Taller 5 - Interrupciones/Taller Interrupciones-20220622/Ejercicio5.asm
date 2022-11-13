SET R4, 0x0F
STR [0xF0], R4     ; Sensor
SET R0, 0x00       ; Flag estamosEnCurva
SET R3, 0x02       ; Volumen de la bocina
STR [0xF1], R3     
SET R2, 0x00       ; Contador de curvas
SET R6, rai	       ; Guardo la direccion de la RAI en R6
STR [0x00], R6     ; Guardo la direccion de la RAI en la memoria
STI

motor:
LOAD R4, [0xF0]          ; Leemos el sensor
SET R7, 0x0C             
CMP R4, R7               ; Nos fijamos si está en una curva
JZ disminuyoVelocidad
SET R1, 0xFA             ; Cambiamos la velocidad (FA = FAST)
JMP motor

disminuyoVelocidad:
SET R1, 0x01            ; Cambiamos la velocidad
JMP motor

rai:                   ; interrupción
SET R7, 0x00
CMP R0, R7
JZ  estamosEnCurva     ; Estamos en una curva
JMP noEstamosEnCurva   ; No estamos en una curva

estamosEnCurva:
SET R0, 0x01           ; Nuestra flag indica que estamos en una curva
SET R4, 0x0C
STR [0xF0], R4         ; Cambiamos sensor para que diga que estamos en una curva
IRET

noEstamosEnCurva:
SET R0, 0x00          ; Nuestra flag indica que no estamos en una curva
SET R7, 0x0F
STR [0xF0], R7        ; Cambiamos sensor para que diga que no estamos en una curva
INC R2                ; incrementamos cantidad de curvas
SET R4, 0xFF
CMP R2, R4
JZ incrementarBocina
IRET

incrementarBocina:
LOAD R3, [0XF1]
INC R3
STR [0XF1], R3
SET R2, 0x00        ; reiniciamos contador de curvas
IRET

