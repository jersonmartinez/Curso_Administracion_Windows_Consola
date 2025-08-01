@echo off
echo Enviando mensaje a múltiples equipos...
set mensaje="Mantenimiento programado para hoy a las 18:00"
msg /server:PC01 * %mensaje%
msg /server:PC02 * %mensaje%
msg /server:PC03 * %mensaje%
echo Mensajes enviados a todos los equipos
pause 