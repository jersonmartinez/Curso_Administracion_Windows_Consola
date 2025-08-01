@echo off
:: Asociar con parámetros específicos
echo Configurando asociación con parámetros...

:: Asociar con parámetros de línea de comandos
ftype txtfile="C:\Program Files\Notepad++\notepad++.exe" -multiInst "%1"

echo.
echo ✅ Asociación configurada con parámetros
pause 