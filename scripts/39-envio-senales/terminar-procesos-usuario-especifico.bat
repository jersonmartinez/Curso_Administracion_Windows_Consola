@echo off
echo Terminando procesos de usuario específico...
set /p usuario="Ingresa el nombre del usuario: "
taskkill /FI "USERNAME eq %usuario%" /F
if %errorlevel%==0 (
    echo Procesos del usuario %usuario% terminados
) else (
    echo Error al terminar procesos
)
pause 