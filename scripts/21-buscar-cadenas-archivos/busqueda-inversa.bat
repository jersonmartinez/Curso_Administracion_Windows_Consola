@echo off
:: Búsqueda inversa
echo ========================================
echo      🔍 BÚSQUEDA INVERSA
echo ========================================
echo.
echo 🔍 Buscando líneas que NO contienen "debug"...
findstr /s /i /v "debug" *.log
echo.
echo 💡 Útil para: filtrado de logs, exclusión de información
echo.
pause 