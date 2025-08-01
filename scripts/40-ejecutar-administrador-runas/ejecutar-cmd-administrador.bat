@echo off
echo Abriendo CMD como administrador...
runas /user:administrador "cmd.exe"
if %errorlevel%==0 (
    echo CMD abierto con privilegios de administrador
) else (
    echo Error al abrir CMD como administrador
)
pause 