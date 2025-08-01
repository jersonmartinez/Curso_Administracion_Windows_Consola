@echo off
echo Verificando usuarios conectados...
query user
echo.
set /p continuar="¿Deseas enviar un mensaje a todos los usuarios? (s/n): "
if /i "%continuar%"=="s" (
    set /p mensaje="Ingresa el mensaje: "
    msg * "%mensaje%"
    echo Mensaje enviado
)
pause 