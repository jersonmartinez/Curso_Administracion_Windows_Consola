@echo off
set /p equipo="Ingresa el nombre/IP del equipo: "
set /p mensaje="Ingresa el mensaje: "
echo Enviando mensaje al equipo %equipo%...
msg /server:%equipo% * "%mensaje%"
if %errorlevel%==0 (
    echo Mensaje enviado exitosamente al equipo %equipo%
) else (
    echo Error al enviar mensaje
)
pause 