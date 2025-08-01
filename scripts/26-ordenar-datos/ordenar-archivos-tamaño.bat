@echo off
:: Ordenar archivos por tamaño
echo Ordenando archivos por tamaño...

:: Listar archivos ordenados por tamaño (más grandes primero)
dir /O:S /T:W | findstr /v "DIR"

echo.
echo ✅ Archivos ordenados por tamaño (mayor a menor)
pause 