@echo off
:: Búsqueda de información sensible
echo ========================================
echo      🔐 BÚSQUEDA DE INFORMACIÓN SENSIBLE
echo ========================================
echo.
echo 🔍 Buscando información sensible...
findstr /s /i /r "password\|secret\|token\|key" *.txt *.ini *.cfg
echo.
echo 💡 Útil para: auditorías de seguridad, compliance, protección de datos
echo.
pause 