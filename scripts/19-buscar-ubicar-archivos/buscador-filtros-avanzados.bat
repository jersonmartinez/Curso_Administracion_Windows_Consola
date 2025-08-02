@echo off
:: Búsqueda con filtros avanzados
echo ========================================
echo      ⚡ BUSCADOR CON FILTROS
echo ========================================
echo.
echo 🔍 Archivos .txt modificados hoy y que contengan "error"...
forfiles /s /m *.txt /d 0 /c "cmd /c findstr /i /m \"error\" @path && echo @path - @fdate"
echo.
echo 💡 Útil para: debugging, auditorías, investigación
echo.
pause 