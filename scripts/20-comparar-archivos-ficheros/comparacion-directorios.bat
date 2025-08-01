@echo off
:: Comparación de directorios
echo ========================================
echo      📋 COMPARACIÓN DE DIRECTORIOS
echo ========================================
echo.
echo 🔍 Comparando directorios completos...
fc /s directorio1\*.* directorio2\*.*
echo.
echo 💡 Útil para: sincronización, versiones de software, auditorías
echo.
pause 