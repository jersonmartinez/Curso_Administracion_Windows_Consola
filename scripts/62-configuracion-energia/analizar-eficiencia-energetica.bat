@echo off
echo ========================================
echo    ANALIZAR EFICIENCIA ENERGETICA
echo ========================================
echo.

echo Analizando eficiencia energetica...
echo Analisis iniciado: %date% %time%

REM Configuración
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "reporte=analisis_eficiencia_%fecha%.txt"

REM Crear reporte
echo ANALISIS DE EFICIENCIA ENERGETICA > %reporte%
echo ======================================== >> %reporte%
echo Fecha: %date% %time% >> %reporte%
echo Sistema: %COMPUTERNAME% >> %reporte%
echo Usuario: %USERNAME% >> %reporte%
echo. >> %reporte%

REM Información de hardware
echo INFORMACION DE HARDWARE: >> %reporte%
wmic computersystem get model,manufacturer /format:table >> %reporte%
wmic cpu get name,maxclockspeed /format:table >> %reporte%
echo. >> %reporte%

REM Información de energía
echo INFORMACION DE ENERGIA: >> %reporte%
powercfg /energy /output %reporte%_powercfg.html /duration 60

echo Analisis de eficiencia energetica completado
pause
