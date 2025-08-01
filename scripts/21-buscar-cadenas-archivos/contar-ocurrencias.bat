@echo off
:: Contar ocurrencias
echo ========================================
echo      📊 CONTAR OCURRENCIAS
echo ========================================
echo.
echo 🔍 Contando ocurrencias de "error"...
findstr /s /i /c "error" *.log | find /c /v ""
echo.
echo 💡 Útil para: análisis estadísticos, auditorías, monitoreo
echo.
pause 