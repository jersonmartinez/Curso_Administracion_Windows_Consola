@echo off
:: Generador de reportes de búsqueda
echo ========================================
echo      📊 GENERADOR DE REPORTES
echo ========================================
echo.
echo 🔍 Generando reporte de archivos grandes...
echo Reporte de archivos grandes - %date% %time% > reporte_archivos.txt
echo ======================================== >> reporte_archivos.txt
echo. >> reporte_archivos.txt
echo Archivos mayores a 10MB: >> reporte_archivos.txt
forfiles /s /m *.* /c "cmd /c if @fsize gtr 10485760 echo @path - @fsize bytes" >> reporte_archivos.txt
echo. >> reporte_archivos.txt
echo Reporte completado: reporte_archivos.txt
echo.
pause 