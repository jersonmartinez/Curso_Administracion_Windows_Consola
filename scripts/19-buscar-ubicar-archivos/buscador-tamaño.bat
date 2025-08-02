@echo off
:: Búsqueda por tamaño de archivo
echo ========================================
echo      📊 BUSCADOR POR TAMAÑO
echo ========================================
echo.
echo 🔍 Archivos mayores a 100MB...
forfiles /s /m *.* /c "cmd /c if @fsize gtr 104857600 echo @path - @fsize bytes"
echo.
echo 💡 Útil para: limpieza de disco, archivos multimedia, backups
echo.
pause 