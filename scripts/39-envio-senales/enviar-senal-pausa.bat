@echo off
echo Pausando proceso...
set /p pid="Ingresa el PID del proceso: "
wmic process where "ProcessId=%pid%" call suspend
if %errorlevel%==0 (
    echo Proceso %pid% pausado
    set /p reanudar="¿Deseas reanudar el proceso? (s/n): "
    if /i "%reanudar%"=="s" (
        wmic process where "ProcessId=%pid%" call resume
        echo Proceso reanudado
    )
) else (
    echo Error al pausar el proceso
)
pause 