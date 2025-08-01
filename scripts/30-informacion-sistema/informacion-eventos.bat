@echo off
:: Información de eventos
echo Obteniendo información de eventos...

:: Eventos recientes del sistema
wevtutil qe System /c:10 /f:text

echo.
echo ✅ Información de eventos obtenida
pause 