@echo off
setlocal enabledelayedexpansion
title SISTEMA DE MONITOREO DE RENDIMIENTO

echo ========================================
echo  SISTEMA DE MONITOREO DE RENDIMIENTO
echo ========================================
echo.

REM Configuración
set "log_dir=C:\Logs\Rendimiento"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"

REM Crear directorio de logs
if not exist "%log_dir%" mkdir "%log_dir%"

:menu_principal
cls
echo ========================================
echo    SISTEMA DE MONITOREO DE RENDIMIENTO
echo ========================================
echo.
echo 1. Monitoreo completo del sistema
echo 2. Analisis de CPU
echo 3. Analisis de memoria
echo 4. Analisis de disco
echo 5. Analisis de red
echo 6. Analisis de servicios
echo 7. Analisis de procesos
echo 8. Monitoreo continuo
echo 9. Generar reporte completo
echo 10. Configurar alertas
echo 11. Salir
echo.
set /p opcion="Seleccione una opcion: "

if "%opcion%"=="1" goto monitoreo_completo
if "%opcion%"=="2" goto analisis_cpu
if "%opcion%"=="3" goto analisis_memoria
if "%opcion%"=="4" goto analisis_disco
if "%opcion%"=="5" goto analisis_red
if "%opcion%"=="6" goto analisis_servicios
if "%opcion%"=="7" goto analisis_procesos
if "%opcion%"=="8" goto monitoreo_continuo
if "%opcion%"=="9" goto generar_reporte
if "%opcion%"=="10" goto configurar_alertas
if "%opcion%"=="11" goto salir
goto menu_principal

:monitoreo_completo
echo.
echo === MONITOREO COMPLETO DEL SISTEMA ===
echo.
set "log_file=%log_dir%\monitoreo_completo_%fecha%.log"

echo Iniciando monitoreo completo...
echo Monitoreo completo iniciado: %date% %time% > %log_file%

REM CPU
echo === CPU === >> %log_file%
wmic cpu get name,numberofcores,maxclockspeed /format:table >> %log_file%

REM Memoria
echo === MEMORIA === >> %log_file%
wmic OS get totalvisiblememorysize,freephysicalmemory /format:table >> %log_file%

REM Disco
echo === DISCO === >> %log_file%
wmic logicaldisk get deviceid,size,freespace /format:table >> %log_file%

echo Monitoreo completo finalizado: %date% %time% >> %log_file%
echo Monitoreo completo completado
pause
goto menu_principal

:analisis_cpu
echo.
echo === ANALISIS DE CPU ===
echo.
set "log_file=%log_dir%\cpu_%fecha%.log"

echo Analizando CPU...
echo Analisis iniciado: %date% %time% > %log_file%

tasklist /FI "CPU gt 5" /FO TABLE >> %log_file%
wmic cpu get name,numberofcores,maxclockspeed /format:table >> %log_file%

echo Analisis completado
pause
goto menu_principal

:analisis_memoria
echo.
echo === ANALISIS DE MEMORIA ===
echo.
set "log_file=%log_dir%\memoria_%fecha%.log"

echo Analizando memoria...
echo Analisis iniciado: %date% %time% > %log_file%

wmic OS get totalvisiblememorysize,freephysicalmemory /format:table >> %log_file%
tasklist /FI "MEMUSAGE gt 50000" /FO TABLE >> %log_file%

echo Analisis completado
pause
goto menu_principal

:analisis_disco
echo.
echo === ANALISIS DE DISCO ===
echo.
set "log_file=%log_dir%\disco_%fecha%.log"

echo Analizando disco...
echo Analisis iniciado: %date% %time% > %log_file%

wmic logicaldisk get deviceid,size,freespace,volumename /format:table >> %log_file%

echo Analisis completado
pause
goto menu_principal

:analisis_red
echo.
echo === ANALISIS DE RED ===
echo.
set "log_file=%log_dir%\red_%fecha%.log"

echo Analizando red...
echo Analisis iniciado: %date% %time% > %log_file%

netstat -an | findstr ESTABLISHED >> %log_file%
wmic nic get name,speed,adaptertype /format:table >> %log_file%

echo Analisis completado
pause
goto menu_principal

:analisis_servicios
echo.
echo === ANALISIS DE SERVICIOS ===
echo.
set "log_file=%log_dir%\servicios_%fecha%.log"

echo Analizando servicios...
echo Analisis iniciado: %date% %time% > %log_file%

sc query type= service state= running >> %log_file%

echo Analisis completado
pause
goto menu_principal

:analisis_procesos
echo.
echo === ANALISIS DE PROCESOS ===
echo.
set "log_file=%log_dir%\procesos_%fecha%.log"

echo Analizando procesos...
echo Analisis iniciado: %date% %time% > %log_file%

tasklist /FI "MEMUSAGE gt 100000" /FO TABLE >> %log_file%

echo Analisis completado
pause
goto menu_principal

:monitoreo_continuo
echo.
echo === MONITOREO CONTINUO ===
echo.
set "log_file=%log_dir%\continuo_%fecha%.log"

echo Iniciando monitoreo continuo...
echo Monitoreo continuo iniciado: %date% %time% > %log_file%

echo Presione Ctrl+C para detener
echo.

:monitor_loop
echo %date% %time% >> %log_file%
powershell -Command "Get-Counter '\Processor(_Total)\% Processor Time' | Select-Object -ExpandProperty CounterSamples | Select-Object CookedValue" >> %log_file%
timeout /t 30 /nobreak >nul
goto monitor_loop

:generar_reporte
echo.
echo === GENERAR REPORTE COMPLETO ===
echo.
set "reporte=%log_dir%\reporte_completo_%fecha%.txt"

echo REPORTE COMPLETO DE RENDIMIENTO > %reporte%
echo ======================================== >> %reporte%
echo Fecha: %date% %time% >> %reporte%
echo Sistema: %COMPUTERNAME% >> %reporte%
echo Usuario: %USERNAME% >> %reporte%
echo. >> %reporte%

REM Resumen de recursos
echo RESUMEN DE RECURSOS: >> %reporte%
wmic cpu get name,numberofcores /format:table >> %reporte%
wmic OS get totalvisiblememorysize,freephysicalmemory /format:table >> %reporte%
wmic logicaldisk get deviceid,size,freespace /format:table >> %reporte%

echo Reporte generado: %reporte%
pause
goto menu_principal

:configurar_alertas
echo.
echo === CONFIGURAR ALERTAS ===
echo.
echo Creando tarea programada para monitoreo...
schtasks /create /tn "MonitoreoRendimiento" /tr "C:\Scripts\monitoreo_rendimiento.bat" /sc minute /mo 5
echo Tarea programada creada
pause
goto menu_principal

:salir
echo Gracias por usar el Sistema de Monitoreo de Rendimiento
exit
