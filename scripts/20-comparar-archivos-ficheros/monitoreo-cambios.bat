@echo off
:: Monitoreo de cambios en tiempo real
echo ========================================
echo      📈 MONITOREO DE CAMBIOS
echo ========================================
echo.
echo 🔍 Monitoreando cambios en archivo crítico...
:monitor
fc /q archivo_original.txt archivo_actual.txt >nul
if %errorlevel% neq 0 (
    echo ⚠️ ¡Cambio detectado en %time%!
    fc archivo_original.txt archivo_actual.txt
)
timeout /t 30 >nul
goto monitor
echo.
echo 💡 Útil para: monitoreo de seguridad, auditorías, detección de cambios
echo.
pause 