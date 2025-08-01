@echo off
echo Verificando proceso antes de terminar...
set /p pid="Ingresa el PID del proceso: "
tasklist /FI "PID eq %pid%"
if %errorlevel%==0 (
    echo.
    set /p confirm="¿Deseas terminar este proceso? (s/n): "
    if /i "%confirm%"=="s" (
        taskkill /PID %pid% /F
        echo Proceso terminado
    )
) else (
    echo Proceso no encontrado
)
pause 