@echo off
:: Búsqueda con múltiples criterios
echo ========================================
echo      🎯 BÚSQUEDA MÚLTIPLE
echo ========================================
echo.
echo 🔍 Buscando errores críticos en logs...
findstr /s /i "error" *.log | findstr /i "critical\|fatal"
echo.
echo 💡 Útil para: análisis avanzado, auditorías comprehensivas
echo.
pause 