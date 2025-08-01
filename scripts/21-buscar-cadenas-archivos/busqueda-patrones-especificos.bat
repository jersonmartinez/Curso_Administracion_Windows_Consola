@echo off
:: Búsqueda de patrones específicos
echo ========================================
echo      📈 BÚSQUEDA DE PATRONES
echo ========================================
echo.
echo 🔍 Buscando IPs en archivos...
findstr /s /r "\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b" *.txt *.log
echo.
echo 💡 Útil para: análisis de red, auditorías, extracción de datos
echo.
pause 