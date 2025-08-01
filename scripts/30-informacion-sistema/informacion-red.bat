@echo off
:: Información de red
echo Obteniendo información de red...

:: Configuración de red
echo === CONFIGURACIÓN DE RED ===
ipconfig /all

:: Conexiones activas
echo === CONEXIONES ACTIVAS ===
netstat -an

echo.
echo ✅ Información de red obtenida
pause 