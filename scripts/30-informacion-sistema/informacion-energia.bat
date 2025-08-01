@echo off
:: Información de energía
echo Obteniendo información de energía...

:: Configuraciones de energía
powercfg /list

:: Información de batería (si aplica)
wmic path win32_battery get estimatedchargeremaining

echo.
echo ✅ Información de energía obtenida
pause 