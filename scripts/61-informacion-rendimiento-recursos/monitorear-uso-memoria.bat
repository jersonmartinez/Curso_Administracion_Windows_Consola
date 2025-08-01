@echo off
echo ========================================
echo    MONITOREAR USO DE MEMORIA
echo ========================================
echo.

echo Monitoreando uso de memoria...
echo Monitoreo iniciado: %date% %time%

REM Información de memoria física
echo === MEMORIA FISICA ===
wmic computersystem get TotalPhysicalMemory /format:value
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /format:table

REM Procesos con mayor uso de memoria
echo.
echo === PROCESOS CON MAYOR USO DE MEMORIA ===
tasklist /FI "MEMUSAGE gt 50000" /FO TABLE

REM Información detallada de memoria
echo.
echo === INFORMACION DETALLADA DE MEMORIA ===
wmic memorychip get capacity,speed,manufacturer /format:table

echo Monitoreo de memoria completado
pause
