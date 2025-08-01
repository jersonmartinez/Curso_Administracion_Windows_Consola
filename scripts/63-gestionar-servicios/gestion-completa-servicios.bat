@echo off
setlocal enabledelayedexpansion
title GESTION COMPLETA DE SERVICIOS
set "log_dir=C:\Logs\Servicios"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
if not exist "%log_dir%" mkdir "%log_dir%"
:menu_principal
cls
echo ========================================
echo    GESTION COMPLETA DE SERVICIOS
echo ========================================
echo.
echo 1. Listar todos los servicios
echo 2. Gestionar servicio especifico
echo 3. Configurar tipos de inicio
echo 4. Gestionar dependencias
echo 5. Crear servicio personalizado
echo 6. Monitorear servicios criticos
echo 7. Backup y restauracion
echo 8. Analizar servicios
echo 9. Optimizar servicios
echo 10. Crear servicio de monitoreo
echo 11. Salir
echo.
set /p opcion="Seleccione una opcion: "
if "%opcion%"=="1" goto listar_servicios
if "%opcion%"=="2" goto gestionar_especifico
if "%opcion%"=="3" goto configurar_inicio
if "%opcion%"=="4" goto gestionar_dependencias
if "%opcion%"=="5" goto crear_personalizado
if "%opcion%"=="6" goto monitorear_criticos
if "%opcion%"=="7" goto backup_restauracion
if "%opcion%"=="8" goto analizar_servicios
if "%opcion%"=="9" goto optimizar_servicios
if "%opcion%"=="10" goto crear_monitoreo
if "%opcion%"=="11" goto salir
goto menu_principal
:listar_servicios
echo.
echo === LISTAR TODOS LOS SERVICIOS ===
echo.
sc query type= service state= all
pause
goto menu_principal
:gestionar_especifico
echo.
echo === GESTIONAR SERVICIO ESPECIFICO ===
echo.
set /p servicio="Nombre del servicio: "
echo.
echo 1. Iniciar servicio
echo 2. Detener servicio
echo 3. Pausar servicio
echo 4. Continuar servicio
echo 5. Ver informacion
echo 6. Volver al menu
echo.
set /p accion="Seleccione accion: "
if "%accion%"=="1" sc start %servicio%
if "%accion%"=="2" sc stop %servicio%
if "%accion%"=="3" sc pause %servicio%
if "%accion%"=="4" sc continue %servicio%
if "%accion%"=="5" sc query %servicio%
if "%accion%"=="6" goto menu_principal
pause
goto gestionar_especifico
:configurar_inicio
echo.
echo === CONFIGURAR TIPOS DE INICIO ===
echo.
set /p servicio="Nombre del servicio: "
echo.
echo 1. Automatico
echo 2. Manual
echo 3. Deshabilitado
echo.
set /p tipo="Tipo de inicio: "
if "%tipo%"=="1" sc config %servicio% start= auto
if "%tipo%"=="2" sc config %servicio% start= demand
if "%tipo%"=="3" sc config %servicio% start= disabled
echo Configuracion aplicada
pause
goto menu_principal
:gestionar_dependencias
echo.
echo === GESTIONAR DEPENDENCIAS ===
echo.
set /p servicio="Nombre del servicio: "
set /p dependencias="Dependencias (separadas por espacios): "
sc config %servicio% depend= %dependencias%
echo Dependencias configuradas
pause
goto menu_principal
:crear_personalizado
echo.
echo === CREAR SERVICIO PERSONALIZADO ===
echo.
set /p nombre="Nombre del servicio: "
set /p binpath="Ruta del ejecutable: "
set /p display="Nombre para mostrar: "
sc create %nombre% binpath= "%binpath%" displayname= "%display%" start= auto
echo Servicio creado
pause
goto menu_principal
:monitorear_criticos
echo.
echo === MONITOREAR SERVICIOS CRITICOS ===
echo.
set "log_file=%log_dir%\monitor_%fecha%.log"
echo Monitoreo iniciado: %date% %time% > %log_file%
for %%s in (spooler eventlog themes) do (
    sc query %%s | findstr "RUNNING" >nul
    if !errorlevel! neq 0 (
        echo [ALERTA] %%s no esta ejecutandose >> %log_file%
        sc start %%s
    ) else (
        echo [OK] %%s funcionando >> %log_file%
    )
)
echo Monitoreo completado: %log_file%
pause
goto menu_principal
:backup_restauracion
echo.
echo === BACKUP Y RESTAURACION ===
echo.
set "backup_dir=%log_dir%\backup_%fecha%"
if not exist "%backup_dir%" mkdir "%backup_dir%"
for %%s in (spooler eventlog themes) do (
    sc qc %%s > "%backup_dir%\%%s_config.txt"
)
echo Backup completado: %backup_dir%
pause
goto menu_principal
:analizar_servicios
echo.
echo === ANALIZAR SERVICIOS ===
echo.
set "reporte=%log_dir%\analisis_%fecha%.txt"
echo ANALISIS DE SERVICIOS > %reporte%
echo Fecha: %date% %time% >> %reporte%
sc query type= service state= running | find /c "SERVICE_NAME" >> %reporte%
sc query type= service state= stopped | find /c "SERVICE_NAME" >> %reporte%
echo Analisis completado: %reporte%
pause
goto menu_principal
:optimizar_servicios
echo.
echo === OPTIMIZAR SERVICIOS ===
echo.
for %%s in (spooler eventlog) do (
    sc config %%s start= auto
    sc start %%s
)
for %%s in (themes) do (
    sc config %%s start= demand
)
echo Optimizacion completada
pause
goto menu_principal
:crear_monitoreo
echo.
echo === CREAR SERVICIO DE MONITOREO ===
echo.
echo @echo off > "C:\Scripts\monitor.bat"
echo for %%s in (spooler eventlog themes) do ( >> "C:\Scripts\monitor.bat"
echo     sc query %%s ^| findstr "RUNNING" ^>nul >> "C:\Scripts\monitor.bat"
echo     if !errorlevel! neq 0 sc start %%s >> "C:\Scripts\monitor.bat"
echo ) >> "C:\Scripts\monitor.bat"
echo timeout /t 300 /nobreak ^>nul >> "C:\Scripts\monitor.bat"
echo goto :eof >> "C:\Scripts\monitor.bat"
sc create "MonitorServicios" binpath= "C:\Scripts\monitor.bat" start= auto
echo Servicio de monitoreo creado
pause
goto menu_principal
:salir
echo Gracias por usar la Gestion Completa de Servicios
exit
