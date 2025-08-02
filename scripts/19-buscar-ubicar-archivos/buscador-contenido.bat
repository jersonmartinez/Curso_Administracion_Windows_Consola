@echo off
:: Búsqueda de contenido en archivos
echo ========================================
echo      🔍 BUSCADOR DE CONTENIDO
echo ========================================
echo.
echo 🔍 Buscando archivos que contengan "password"...
findstr /s /i "password" *.txt *.ini *.cfg
echo.
echo 💡 Útil para: configuraciones, documentación, debugging
echo.
pause 