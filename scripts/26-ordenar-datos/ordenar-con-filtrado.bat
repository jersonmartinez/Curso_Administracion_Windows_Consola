@echo off
:: Ordenar con filtrado
echo Ordenando archivos .txt por fecha...

:: Filtrar archivos .txt y ordenarlos por fecha
dir *.txt /O:D /T:W 2>nul | findstr /v "DIR"

echo.
echo ✅ Archivos .txt ordenados por fecha
pause 