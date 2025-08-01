@echo off
echo ========================================
echo    CREAR REPORTE DE RENDIMIENTO
echo ========================================
echo.

REM Configuración
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "reporte=reporte_rendimiento_%fecha%.txt"

echo Creando reporte de rendimiento...
echo Reporte iniciado: %date% %time%

REM Crear reporte
echo REPORTE DE RENDIMIENTO DEL SISTEMA > %reporte%
echo ======================================== >> %reporte%
echo Fecha: %date% %time% >> %reporte%
echo Sistema: %COMPUTERNAME% >> %reporte%
echo Usuario: %USERNAME% >> %reporte%
echo. >> %reporte%

REM Información del procesador
echo INFORMACION DEL PROCESADOR: >> %reporte%
wmic cpu get name,numberofcores,maxclockspeed /format:table >> %reporte%
echo. >> %reporte%

REM Información de memoria
echo INFORMACION DE MEMORIA: >> %reporte%
wmic OS get totalvisiblememorysize,freephysicalmemory /format:table >> %reporte%
echo. >> %reporte%

REM Información de discos
echo INFORMACION DE DISCOS: >> %reporte%
wmic logicaldisk get deviceid,size,freespace /format:table >> %reporte%
echo. >> %reporte%

REM Procesos con alto uso de recursos
echo PROCESOS CON ALTO USO DE RECURSOS: >> %reporte%
tasklist /FI "MEMUSAGE gt 50000" /FO TABLE >> %reporte%
echo. >> %reporte%

echo Reporte generado: %reporte%
echo Reporte de rendimiento completado
pause
