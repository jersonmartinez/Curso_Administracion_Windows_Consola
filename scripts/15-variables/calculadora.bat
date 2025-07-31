@echo off
echo Bienvenido a la calculadora aritmetica.
SET /P PrimerValor=Ingresa el primer valor:
SET /P SegundoValor=Ingresa el segundo valor:
SET /A "adicion=%PrimerValor%+%SegundoValor%"
SET /A "sustraccion=%PrimerValor%-%SegundoValor%"
SET /A "multiplicacion=%PrimerValor%*%SegundoValor%"
SET /A "division=%PrimerValor%/%SegundoValor%"
echo Suma: %adicion%
echo Resta: %sustraccion%
echo Multiplicacion: %multiplicacion%
echo Division: %division%
pause 