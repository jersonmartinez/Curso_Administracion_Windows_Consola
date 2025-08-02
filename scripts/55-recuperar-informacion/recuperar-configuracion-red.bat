@echo off
echo ========================================
echo  RECUPERAR CONFIGURACION DE RED
echo ========================================
echo.

REM Resetear configuración de red
echo Reseteando configuración de red...

REM Liberar y renovar IP
ipconfig /release
ipconfig /renew

REM Flush DNS
ipconfig /flushdns

REM Resetear Winsock
netsh winsock reset

REM Resetear configuración de TCP/IP
netsh int ip reset

REM Reiniciar servicios de red
net stop dnscache
net start dnscache

net stop "DHCP Client"
net start "DHCP Client"

REM Verificar conectividad
echo.
echo Verificando conectividad...
ping 8.8.8.8 -n 4

echo Configuración de red reseteada
pause
