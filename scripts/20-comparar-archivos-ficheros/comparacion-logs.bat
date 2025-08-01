@echo off
:: Comparación de logs del sistema
echo ========================================
echo      📊 COMPARACIÓN DE LOGS
echo ========================================
echo.
echo 🔍 Comparando logs del sistema...
fc /n C:\Windows\System32\winevt\Logs\System.evtx C:\backup\System_backup.evtx
echo.
echo 💡 Útil para: análisis de eventos, troubleshooting, auditorías
echo.
pause 