@echo off
echo ========================================
echo    MONITOREAR ACTIVIDAD DE RED
echo ========================================
echo.

echo Monitoreando actividad de red...
echo Monitoreo iniciado: %date% %time%

REM Conexiones activas
echo === CONEXIONES ACTIVAS ===
netstat -an | findstr ESTABLISHED

REM Estadísticas de red
echo.
echo === ESTADISTICAS DE RED ===
netstat -s

REM Procesos con conexiones de red
echo.
echo === PROCESOS CON CONEXIONES DE RED ===
netstat -ano | findstr LISTENING

REM Información de interfaces de red
echo.
echo === INTERFACES DE RED ===
wmic nic get name,speed,adaptertype /format:table

echo Monitoreo de red completado
pause
