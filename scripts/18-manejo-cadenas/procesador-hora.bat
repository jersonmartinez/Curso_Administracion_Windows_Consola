@echo off
:: Extraer componentes de la hora actual
echo ========================================
echo        PROCESADOR DE HORA
echo ========================================
echo.
echo ⏰ Hora actual: %time%
echo.
echo 📊 Componentes extraídos:
echo    🕐 Hora: %time:~0,2%
echo    ⏱️ Minutos: %time:~3,2%
echo    ⏲️ Segundos: %time:~6,2%
echo.
echo 💡 Útil para: timestamps, logs de auditoría, programación
echo.
pause 