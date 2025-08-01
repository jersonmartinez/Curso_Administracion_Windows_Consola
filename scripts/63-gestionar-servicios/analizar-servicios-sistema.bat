@echo off
REM Analiza todos los servicios del sistema y genera estadísticas
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "reporte=analisis_servicios_%fecha%.txt"
echo ANALISIS DE SERVICIOS DEL SISTEMA > %reporte%
echo ======================================== >> %reporte%
echo Fecha: %date% %time% >> %reporte%
echo Sistema: %COMPUTERNAME% >> %reporte%
echo Usuario: %USERNAME% >> %reporte%
echo. >> %reporte%
echo ESTADISTICAS GENERALES: >> %reporte%
echo ------------------------ >> %reporte%
sc query type= service state= running | find /c "SERVICE_NAME" >> %reporte%
sc query type= service state= stopped | find /c "SERVICE_NAME" >> %reporte%
sc query type= service start= auto | find /c "SERVICE_NAME" >> %reporte%
echo. >> %reporte%
echo SERVICIOS CRITICOS: >> %reporte%
echo ------------------- >> %reporte%
for %%s in (spooler eventlog themes) do (
    echo --- %%s --- >> %reporte%
    sc query %%s | findstr STATE >> %reporte%
    sc qc %%s | findstr START_TYPE >> %reporte%
    echo. >> %reporte%
)
echo SERVICIOS CON PROBLEMAS: >> %reporte%
echo ------------------------- >> %reporte%
sc query type= service state= stopped | findstr "SERVICE_NAME" >> %reporte%
echo Analisis de servicios completado
echo Reporte generado: %reporte%
pause
