@echo off
:: Búsqueda avanzada con PowerShell
echo ========================================
echo      🎯 BÚSQUEDA AVANZADA CON POWERSHELL
echo ========================================
echo.
echo 🔍 Búsqueda avanzada con PowerShell...
powershell -command "Get-ChildItem -Recurse -Include *.txt,*.log | Select-String -Pattern 'error|fail' -CaseSensitive"
echo.
echo 💡 Útil para: búsquedas complejas, análisis avanzado
echo.
pause 