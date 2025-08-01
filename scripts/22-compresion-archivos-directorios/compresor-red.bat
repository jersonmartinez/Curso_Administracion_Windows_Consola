@echo off
:: Compresor de archivos de red
title 🌐 Compresor de Red
color 0B

set /p ruta_red="Ruta de red (ej: \\servidor\compartido): "

echo ========================================
echo    🌐 COMPRESOR DE ARCHIVOS DE RED
echo ========================================
echo.

if exist "%ruta_red%" (
    echo 🔄 Comprimiendo archivos en red...
    compact /c /s "%ruta_red%" /q
    
    echo 📊 Estadísticas de compresión:
    compact /s "%ruta_red%"
) else (
    echo ❌ No se puede acceder a la ruta de red
)

echo.
pause 