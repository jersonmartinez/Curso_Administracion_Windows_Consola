@echo off
:: Búsqueda con números de línea
echo ========================================
echo      📊 BÚSQUEDA CON LÍNEAS
echo ========================================
echo.
echo 🔍 Buscando "error" con números de línea...
findstr /s /i /n "error" *.log
echo.
echo 💡 Útil para: debugging, análisis de logs, revisión de código
echo.
pause 