@echo off
set /p script="Ingresa la ruta del script: "
echo Ejecutando script como administrador...
runas /user:administrador "cmd.exe /c %script%"
if %errorlevel%==0 (
    echo Script ejecutado exitosamente
) else (
    echo Error al ejecutar el script
)
pause 