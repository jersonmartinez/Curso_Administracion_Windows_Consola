@echo off
echo Ejecutando aplicación con parámetros...
runas /user:administrador "cmd.exe /k ipconfig /all"
echo Comando ejecutado con privilegios de administrador
pause 