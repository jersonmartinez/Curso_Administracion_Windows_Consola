@echo off
echo Ejecutando con credenciales guardadas...
runas /user:administrador /savecred "regedit.exe"
echo Editor de registro abierto como administrador
pause 