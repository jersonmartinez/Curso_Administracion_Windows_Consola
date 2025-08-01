@echo off
:: Ordenar datos numéricos
echo Ordenando datos numéricos...

:: Crear archivo con datos numéricos
echo 150 > numeros.txt
echo 23 >> numeros.txt
echo 456 >> numeros.txt
echo 78 >> numeros.txt
echo 901 >> numeros.txt

:: Ordenar numéricamente
sort /+1 numeros.txt

echo.
echo ✅ Datos numéricos ordenados
pause 