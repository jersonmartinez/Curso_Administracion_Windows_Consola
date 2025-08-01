@echo off
:: Búsqueda con expresiones regulares
echo ========================================
echo      🎯 BÚSQUEDA CON REGEX
echo ========================================
echo.
echo 🔍 Buscando emails con regex...
findstr /s /r "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" *.txt
echo.
echo 💡 Útil para: análisis de datos, validación, extracción de información
echo.
pause 