@echo off
set /p app="Ingresa la ruta de la aplicación: "
echo Ejecutando %app% como administrador...
runas /user:administrador "%app%"
if %errorlevel%==0 (
    echo Aplicación ejecutada exitosamente
) else (
    echo Error al ejecutar la aplicación
)
pause 