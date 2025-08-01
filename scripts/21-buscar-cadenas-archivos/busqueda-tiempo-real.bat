@echo off
:: Búsqueda en tiempo real
echo ========================================
echo      ⚡ BÚSQUEDA EN TIEMPO REAL
echo ========================================
echo.
echo 🔍 Monitoreando archivo en tiempo real...
:monitor
findstr /i "error\|critical" archivo.log
timeout /t 10 >nul
goto monitor
echo.
echo 💡 Útil para: monitoreo de seguridad, debugging en vivo
echo.
pause 