@echo off
echo Verificando permisos de administrador...
net session >nul 2>&1
if %errorlevel%==0 (
    echo Ya tienes permisos de administrador
    set /p app="Aplicación a ejecutar: "
    start %app%
) else (
    echo Solicitando privilegios de administrador...
    set /p app="Aplicación a ejecutar: "
    runas /user:administrador "%app%"
)
pause 