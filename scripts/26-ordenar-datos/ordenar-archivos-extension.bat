@echo off
:: Ordenar archivos por extensión
echo Ordenando archivos por extensión...

:: Listar archivos ordenados por extensión
dir /O:E | findstr /v "DIR"

echo.
echo ✅ Archivos ordenados por extensión
pause 