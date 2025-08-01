@echo off
:: Ordenar por múltiples criterios
echo Ordenando por múltiples criterios...

:: Crear archivo con datos estructurados
echo Juan,25,Desarrollador > empleados.txt
echo Ana,30,Gerente >> empleados.txt
echo Carlos,28,Analista >> empleados.txt
echo Maria,32,Desarrollador >> empleados.txt

:: Ordenar por departamento y luego por edad
sort empleados.txt /+15

echo.
echo ✅ Datos ordenados por departamento y edad
pause 