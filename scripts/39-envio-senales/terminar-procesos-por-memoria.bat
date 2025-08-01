@echo off
echo Buscando procesos con alto uso de memoria...
set /p limite="Límite de memoria en MB: "
for /f "tokens=2,5" %%a in ('tasklist /FI "MEMUSAGE gt %limite%000" /FO CSV') do (
    echo Terminando proceso %%a (%%b KB)
    taskkill /PID %%a /F
)
echo Procesos con alto uso de memoria terminados
pause 