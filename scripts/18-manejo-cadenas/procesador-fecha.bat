@echo off
:: Extraer componentes de la fecha actual
echo ========================================
echo        PROCESADOR DE FECHA
echo ========================================
echo.
echo 📅 Fecha actual: %date%
echo.
echo 📊 Componentes extraídos:
echo    📆 Día: %date:~0,2%
echo    📅 Mes: %date:~3,2%
echo    📈 Año: %date:~6,4%
echo.
echo 💡 Útil para: nombres de archivos, logs, reportes
echo.
pause 