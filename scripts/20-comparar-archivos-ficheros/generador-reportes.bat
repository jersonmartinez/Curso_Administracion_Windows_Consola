@echo off
:: Generador de reportes de diferencias
echo ========================================
echo      📊 GENERADOR DE REPORTES
echo ========================================
echo.
echo 🔍 Generando reporte de diferencias...
echo Reporte de diferencias - %date% %time% > reporte_diferencias.txt
echo ======================================== >> reporte_diferencias.txt
fc archivo1.txt archivo2.txt >> reporte_diferencias.txt
echo.
echo ✅ Reporte guardado en reporte_diferencias.txt
echo 💡 Útil para: documentación, auditorías, análisis
echo.
pause 