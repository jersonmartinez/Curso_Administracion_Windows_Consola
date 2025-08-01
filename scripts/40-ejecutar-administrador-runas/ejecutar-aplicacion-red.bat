@echo off
echo Ejecutando aplicación de red...
runas /user:dominio\usuario /netonly "cmd.exe"
echo CMD ejecutado con credenciales de red
pause 