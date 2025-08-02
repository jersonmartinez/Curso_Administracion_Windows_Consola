@echo off
:: Búsqueda por fecha de modificación
echo ========================================
echo    📅 BUSCADOR POR FECHA
echo ========================================
echo.
echo 🔍 Archivos modificados en los últimos 7 días...
forfiles /s /m *.* /d -7 /c "cmd /c echo @path - @fdate"
echo.
echo 💡 Útil para: auditorías, detección de cambios, backups
echo.
pause 