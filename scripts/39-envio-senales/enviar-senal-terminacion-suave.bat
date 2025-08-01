@echo off
echo Enviando señal de terminación suave...
set /p pid="Ingresa el PID del proceso: "
taskkill /PID %pid%
if %errorlevel%==0 (
    echo Señal de terminación enviada al proceso %pid%
) else (
    echo Error al enviar señal
)
pause 