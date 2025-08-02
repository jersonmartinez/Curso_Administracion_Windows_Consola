@echo off
:: Contar caracteres en cadena
echo ========================================
echo        CONTADOR DE CARACTERES
echo ========================================
echo.
set texto=Hola Mundo
echo 📝 Texto: %texto%
echo.

set "temp=%texto%"
set "contador=0"
:contar
if "%temp%"=="" goto mostrar
set "temp=%temp:~1%"
set /a "contador+=1"
goto contar

:mostrar
echo 🔢 Número de caracteres: %contador%
echo.
echo 💡 Útil para: validación, análisis de texto, límites
echo.
pause 