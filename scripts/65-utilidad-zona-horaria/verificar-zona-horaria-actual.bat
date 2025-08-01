@echo off
echo ========================================
echo    VERIFICAR ZONA HORARIA ACTUAL
echo ========================================
echo.

echo Verificando zona horaria actual...
echo Verificacion iniciada: %date% %time%

REM Obtener zona horaria actual
echo === ZONA HORARIA ACTUAL ===
tzutil /g

REM Mostrar información detallada
echo.
echo === INFORMACION DETALLADA ===
w32tm /tz

REM Verificar configuración de horario de verano
echo.
echo === CONFIGURACION DE HORARIO DE VERANO ===
reg query "HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /v DaylightStart

echo Verificacion de zona horaria completada
pause
