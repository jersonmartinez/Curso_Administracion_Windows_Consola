@echo off
:: Generador de reportes de búsqueda
echo ========================================
echo      📋 GENERADOR DE REPORTES
echo ========================================
echo.
echo 🔍 Generando reporte de búsqueda...
echo Reporte de búsqueda - %date% %time% > reporte_busqueda.txt
echo ======================================== >> reporte_busqueda.txt
findstr /s /i /n "error\|fail\|critical" *.log >> reporte_busqueda.txt
echo.
echo ✅ Reporte guardado en reporte_busqueda.txt
echo 💡 Útil para: documentación, auditorías, análisis
echo.
pause 