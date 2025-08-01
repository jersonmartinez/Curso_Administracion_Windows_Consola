@echo off
echo Terminando proceso por PID...
set /p pid="Ingresa el PID del proceso: "
taskkill /PID %pid% /F
if %errorlevel%==0 (
    echo Proceso %pid% terminado exitosamente
) else (
    echo Error al terminar el proceso
)
pause 