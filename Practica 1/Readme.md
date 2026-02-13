Decodificación de Número Primo con 4 Variables en FPGA 
Objetivo: Implementar un sistema en Verilog que lea el valor de 4 switches de la FPGA , interprete su valor como un número binario y determine si es un número primo. El resultado se mostrará encendiendo un LED.

Materiales Necesarios:

Tarjeta FPGA DE10-Lite
Cable USB Blaster para la programación
Software Intel Quartus Prime Lite
Código en Verilog
Descripción del Funcionamiento:

Los 4 switches de la FPGA representan un número en binario.
El valor ingresado en los switches se verifica para determinar si es un número primo.
Se enciende el led cuando el numero es primo.
Desarrollo de la Práctica:

Definir las entradas y salidas:

Entradas: 4 switches (SW[3:0])
Salidas: LED
