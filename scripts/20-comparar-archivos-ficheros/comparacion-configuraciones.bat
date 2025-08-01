@echo off
:: Comparación de configuraciones del sistema
echo ========================================
echo      🔄 COMPARACIÓN DE CONFIGURACIONES
echo ========================================
echo.
echo 🔍 Comparando configuraciones del sistema...
fc C:\Windows\System32\drivers\etc\hosts C:\backup\hosts_backup
echo.
echo 💡 Útil para: auditorías de seguridad, troubleshooting, monitoreo
echo.
pause 