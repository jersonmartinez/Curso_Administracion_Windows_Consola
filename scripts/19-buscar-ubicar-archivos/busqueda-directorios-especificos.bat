@echo off
:: Búsqueda en directorios específicos
echo ========================================
echo      📁 BUSCADOR EN DIRECTORIOS
echo ========================================
echo.
echo 🔍 Buscando en directorios específicos...
dir C:\Users\%username%\Documents\*.doc /s
dir C:\Users\%username%\Desktop\*.pdf /s
dir C:\Users\%username%\Downloads\*.zip /s
echo.
echo 💡 Útil para: trabajo personal, auditorías, organización
echo.
pause 