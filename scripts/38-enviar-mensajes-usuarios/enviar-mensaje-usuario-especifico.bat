@echo off
set /p usuario="Ingresa el nombre del usuario: "
set /p mensaje="Ingresa el mensaje: "
echo Enviando mensaje a %usuario%...
msg %usuario% "%mensaje%"
if %errorlevel%==0 (
    echo Mensaje enviado exitosamente a %usuario%
) else (
    echo Error al enviar mensaje
)
pause 