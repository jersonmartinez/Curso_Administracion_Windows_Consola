@echo off
:: Información de usuarios
echo Obteniendo información de usuarios...

:: Listar usuarios del sistema
net user

:: Información detallada de usuarios
wmic useraccount get name,disabled,lockout

echo.
echo ✅ Información de usuarios obtenida
pause 