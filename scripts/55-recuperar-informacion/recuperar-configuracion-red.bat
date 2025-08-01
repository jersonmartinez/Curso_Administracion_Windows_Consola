@echo off
echo ========================================
echo  RECUPERAR CONFIGURACION DE RED
echo ========================================
echo.

echo Reseteando configuración de red...
ipconfig /release
ipconfig /renew
ipconfig /flushdns
netsh winsock reset
netsh int ip reset
net stop dnscache
net start dnscache
net stop "DHCP Client"
net start "DHCP Client"

echo.
echo Verificando conectividad...
ping 8.8.8.8 -n 4

echo Configuración de red reseteada
pause
