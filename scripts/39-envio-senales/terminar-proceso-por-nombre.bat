@echo off
echo Terminando proceso por nombre...
set /p nombre="Ingresa el nombre del proceso: "
taskkill /IM "%nombre%" /F
if %errorlevel%==0 (
    echo Todos los procesos "%nombre%" terminados
) else (
    echo Error al terminar los procesos
)
pause 