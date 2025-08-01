@echo off
echo Enviando señal a proceso remoto...
set /p equipo="Nombre/IP del equipo: "
set /p pid="PID del proceso: "
taskkill /S %equipo% /PID %pid% /F
if %errorlevel%==0 (
    echo Señal enviada al proceso %pid% en %equipo%
) else (
    echo Error al enviar señal remota
)
pause 