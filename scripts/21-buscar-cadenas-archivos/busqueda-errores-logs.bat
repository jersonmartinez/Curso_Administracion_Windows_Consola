@echo off
:: Búsqueda de errores en logs
echo ========================================
echo      📈 BÚSQUEDA DE ERRORES
echo ========================================
echo.
echo 🔍 Buscando errores en logs...
findstr /s /i /n "error\|fail\|exception\|critical" *.log
echo.
echo 💡 Útil para: troubleshooting, monitoreo, análisis de eventos
echo.
pause 