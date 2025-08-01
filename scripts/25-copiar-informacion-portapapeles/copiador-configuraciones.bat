@echo off
:: Copiador de configuraciones
title ⚙️ Copiador de Configuraciones
color 0B

echo ========================================
echo    ⚙️ COPIADOR DE CONFIGURACIONES
echo ========================================
echo.

:: Copiar configuración de red
echo 🔄 Copiando configuración de red...
netsh interface ip show config | clip
echo ✅ Configuración de red copiada

:: Copiar configuración de firewall
echo 🔄 Copiando configuración de firewall...
netsh advfirewall show allprofiles | clip
echo ✅ Configuración de firewall copiada

:: Copiar configuración de servicios
echo 🔄 Copiando configuración de servicios...
sc query type= service state= all | clip
echo ✅ Configuración de servicios copiada

:: Copiar configuración de usuarios
echo 🔄 Copiando configuración de usuarios...
net user | clip
echo ✅ Configuración de usuarios copiada

echo.
echo 🎉 Todas las configuraciones copiadas al portapapeles
pause 