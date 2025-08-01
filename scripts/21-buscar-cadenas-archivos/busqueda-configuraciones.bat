@echo off
:: Búsqueda de configuraciones
echo ========================================
echo      🔍 BÚSQUEDA DE CONFIGURACIONES
echo ========================================
echo.
echo 🔍 Buscando configuraciones de red...
findstr /s /i "ip\|gateway\|dns\|subnet" *.ini *.cfg *.conf
echo.
echo 💡 Útil para: troubleshooting de red, auditorías de configuración
echo.
pause 