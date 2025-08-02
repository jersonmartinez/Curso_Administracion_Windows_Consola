@echo off
:: Búsqueda de archivos de sistema
echo ========================================
echo      🎯 BUSCADOR DE ARCHIVOS DE SISTEMA
echo ========================================
echo.
echo 🔍 Archivos de configuración del sistema...
dir C:\Windows\*.ini /s /b
dir C:\Windows\System32\*.dll /s /b
echo.
echo 💡 Útil para: mantenimiento, troubleshooting, seguridad
echo.
pause 