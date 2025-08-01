@echo off
:: Ordenar archivos por fecha de modificación
echo Ordenando archivos por fecha...

:: Listar archivos ordenados por fecha (más recientes primero)
dir /O:D /T:W | findstr /v "DIR"

echo.
echo ✅ Archivos ordenados por fecha de modificación
pause 