@echo off
:: Análisis de logs del sistema
echo ========================================
echo      📊 ANÁLISIS DE LOGS
echo ========================================
echo.
echo 🔍 Analizando logs del sistema...
findstr /s /i /n "error\|fail\|denied\|blocked" C:\Windows\*.log
echo.
echo 💡 Útil para: troubleshooting, auditorías de seguridad, monitoreo
echo.
pause 