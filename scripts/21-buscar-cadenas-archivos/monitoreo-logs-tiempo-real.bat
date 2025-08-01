@echo off
:: Monitoreo de logs en tiempo real
echo ========================================
echo      📈 MONITOREO DE LOGS EN TIEMPO REAL
echo ========================================
echo.
echo 🔍 Monitoreando logs en tiempo real...
:monitor_logs
findstr /i "error\|critical\|alert" C:\Windows\System32\winevt\Logs\*.evtx
timeout /t 30 >nul
goto monitor_logs
echo.
echo 💡 Útil para: monitoreo de seguridad, detección de eventos
echo.
pause 