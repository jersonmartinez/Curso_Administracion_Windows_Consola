@echo off
echo Configurando mensaje programado...
set /p hora="Hora de envío (HH:MM): "
set /p mensaje="Mensaje a enviar: "
echo Programando mensaje para las %hora%...
at %hora% msg * "%mensaje%"
echo Mensaje programado exitosamente
pause 