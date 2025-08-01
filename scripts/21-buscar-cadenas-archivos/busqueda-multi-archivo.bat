@echo off
:: Búsqueda en múltiples tipos de archivo
echo ========================================
echo      🔄 BÚSQUEDA MULTI-ARCHIVO
echo ========================================
echo.
echo 🔍 Buscando en múltiples tipos de archivo...
findstr /s /i "config" *.txt *.ini *.cfg *.xml *.json
echo.
echo 💡 Útil para: auditorías comprehensivas, análisis de sistema
echo.
pause 