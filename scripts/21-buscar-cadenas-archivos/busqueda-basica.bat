@echo off
:: Búsqueda básica de texto
echo ========================================
echo        🔍 BÚSQUEDA BÁSICA
echo ========================================
echo.
echo 🔍 Buscando "password" en archivos .txt...
findstr /s /i "password" *.txt
echo.
echo 💡 Útil para: configuraciones, documentación, debugging
echo.
pause 