//la suma de los primeros  n numeros naturales. El valor resultante debe guardarse en R1, y se espera que el valor de
n sea le´ıdo de R0.

inicio:
SET R0, 0xn
SET R1, 0x00
SET R2, 0x00

ciclo:
CMP R0,R2
JZ salir
INC R2
ADD R1,R2
JMP ciclo

salir:
JMP salir

