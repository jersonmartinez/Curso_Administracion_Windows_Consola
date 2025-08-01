@echo off
:: Ordenar logs por timestamp
echo Ordenando logs por timestamp...

:: Ordenar archivo de log por timestamp
if exist "app.log" (
    sort "app.log" > "app_sorted.log"
    echo ✅ Logs ordenados cronológicamente
) else (
    echo ❌ Archivo de log no encontrado
)
pause 