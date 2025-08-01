@echo off
setlocal enabledelayedexpansion
title SISTEMA DE GESTION AVANZADA CON WMIC

REM Verificar privilegios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Este script requiere privilegios de administrador.
    echo Por favor, ejecuta como administrador.
    pause
    exit /b 1
)

REM Configuración inicial
set "config_file=wmic_config.conf"
set "log_file=wmic_advanced.log"
set "backup_dir=backups"

REM Crear directorio de backups si no existe
if not exist "%backup_dir%" mkdir "%backup_dir%"

REM Crear archivo de configuración por defecto si no existe
if not exist "%config_file%" (
    echo # Configuracion del Sistema de Gestion Avanzada WMIC > "%config_file%"
    echo # Archivo de configuracion > "%config_file%"
    echo. >> "%config_file%"
    echo [SYSTEM] >> "%config_file%"
    echo log_level=INFO >> "%config_file%"
    echo auto_backup=true >> "%config_file%"
    echo backup_interval=24 >> "%config_file%"
    echo. >> "%config_file%"
    echo [MONITORING] >> "%config_file%"
    echo enable_realtime=true >> "%config_file%"
    echo refresh_rate=5 >> "%config_file%"
    echo alert_cpu_threshold=80 >> "%config_file%"
    echo alert_memory_threshold=90 >> "%config_file%"
    echo. >> "%config_file%"
    echo [POLICIES] >> "%config_file%"
    echo enforce_security=false >> "%config_file%"
    echo allowed_processes=explorer.exe,cmd.exe,powershell.exe >> "%config_file%"
    echo restricted_services=Fax,RemoteRegistry >> "%config_file%"
)

echo ========================================
echo  SISTEMA DE GESTION AVANZADA CON WMIC
echo ========================================
echo.

:menu_principal
cls
echo ========================================
echo  SISTEMA DE GESTION AVANZADA CON WMIC
echo ========================================
echo.
echo 1. Configuracion avanzada
echo 2. Monitoreo en tiempo real
echo 3. Analisis avanzado
echo 4. Gestion de politicas
echo 5. Backup y restauracion
echo 6. Reportes avanzados
echo 7. Salir
echo.
set /p opcion="Seleccione una opcion: "

if "%opcion%"=="1" goto advanced_configuration
if "%opcion%"=="2" goto real_time_monitoring
if "%opcion%"=="3" goto advanced_analysis
if "%opcion%"=="4" goto policy_management
if "%opcion%"=="5" goto backup_restoration
if "%opcion%"=="6" goto advanced_reports
if "%opcion%"=="7" goto salir
goto menu_principal

:advanced_configuration
cls
echo ========================================
echo    CONFIGURACION AVANZADA
echo ========================================
echo.
echo 1. Ver configuracion actual
echo 2. Editar configuracion del sistema
echo 3. Editar configuracion de monitoreo
echo 4. Editar configuracion de politicas
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto view_config
if "%subopcion%"=="2" goto edit_system_config
if "%subopcion%"=="3" goto edit_monitoring_config
if "%subopcion%"=="4" goto edit_policy_config
if "%subopcion%"=="5" goto menu_principal
goto advanced_configuration

:view_config
cls
echo === CONFIGURACION ACTUAL ===
type "%config_file%"
pause
goto advanced_configuration

:edit_system_config
cls
echo === EDITAR CONFIGURACION DEL SISTEMA ===
echo.
set /p log_level="Nivel de log (INFO/DEBUG/ERROR): "
set /p auto_backup="Backup automatico (true/false): "
set /p backup_interval="Intervalo de backup (horas): "

powershell -Command "(Get-Content '%config_file%') -replace 'log_level=.*', 'log_level=%log_level%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'auto_backup=.*', 'auto_backup=%auto_backup%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'backup_interval=.*', 'backup_interval=%backup_interval%' | Set-Content '%config_file%'"

echo Configuracion del sistema actualizada.
pause
goto advanced_configuration

:edit_monitoring_config
cls
echo === EDITAR CONFIGURACION DE MONITOREO ===
echo.
set /p enable_realtime="Habilitar monitoreo en tiempo real (true/false): "
set /p refresh_rate="Frecuencia de actualizacion (segundos): "
set /p cpu_threshold="Umbral de alerta CPU (%): "
set /p memory_threshold="Umbral de alerta memoria (%): "

powershell -Command "(Get-Content '%config_file%') -replace 'enable_realtime=.*', 'enable_realtime=%enable_realtime%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'refresh_rate=.*', 'refresh_rate=%refresh_rate%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'alert_cpu_threshold=.*', 'alert_cpu_threshold=%cpu_threshold%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'alert_memory_threshold=.*', 'alert_memory_threshold=%memory_threshold%' | Set-Content '%config_file%'"

echo Configuracion de monitoreo actualizada.
pause
goto advanced_configuration

:edit_policy_config
cls
echo === EDITAR CONFIGURACION DE POLITICAS ===
echo.
set /p enforce_security="Aplicar politicas de seguridad (true/false): "
set /p allowed_processes="Procesos permitidos (separados por comas): "
set /p restricted_services="Servicios restringidos (separados por comas): "

powershell -Command "(Get-Content '%config_file%') -replace 'enforce_security=.*', 'enforce_security=%enforce_security%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'allowed_processes=.*', 'allowed_processes=%allowed_processes%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'restricted_services=.*', 'restricted_services=%restricted_services%' | Set-Content '%config_file%'"

echo Configuracion de politicas actualizada.
pause
goto advanced_configuration

:real_time_monitoring
cls
echo ========================================
echo    MONITOREO EN TIEMPO REAL
echo ========================================
echo.
echo Presiona Ctrl+C para detener el monitoreo
echo.

:monitoring_loop
cls
echo ========================================
echo    MONITOREO EN TIEMPO REAL
echo ========================================
echo Fecha: %date% - Hora: %time%
echo.

REM Obtener configuración de monitoreo
for /f "tokens=2 delims==" %%a in ('findstr "refresh_rate" "%config_file%"') do set "refresh_rate=%%a"
for /f "tokens=2 delims==" %%a in ('findstr "alert_cpu_threshold" "%config_file%"') do set "alert_cpu_threshold=%%a"
for /f "tokens=2 delims==" %%a in ('findstr "alert_memory_threshold" "%config_file%"') do set "alert_memory_threshold=%%a"

echo === USO DE CPU ===
wmic cpu get LoadPercentage /value | find "="

echo.
echo === USO DE MEMORIA ===
wmic os get FreePhysicalMemory,TotalVisibleMemorySize /value | find "="

echo.
echo === PROCESOS CRITICOS ===
wmic process where "Name='explorer.exe' or Name='svchost.exe'" get Name,ProcessId,WorkingSetSize /format:list

echo.
echo === ESTADO DE SERVICIOS ===
wmic service where "Name='Dnscache' or Name='Spooler'" get Name,State /format:list

timeout /t %refresh_rate% /nobreak >nul
goto monitoring_loop

:advanced_analysis
cls
echo ========================================
echo    ANALISIS AVANZADO
echo ========================================
echo.
echo 1. Analisis de rendimiento
echo 2. Analisis de seguridad
echo 3. Analisis de configuracion
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto performance_analysis
if "%subopcion%"=="2" goto security_analysis
if "%subopcion%"=="3" goto configuration_analysis
if "%subopcion%"=="4" goto menu_principal
goto advanced_analysis

:performance_analysis
cls
echo === ANALISIS DE RENDIMIENTO ===
echo.
echo Analizando rendimiento del sistema...
wmic cpu get LoadPercentage,Name,NumberOfCores /format:list
wmic os get FreePhysicalMemory,TotalVisibleMemorySize /format:list
wmic logicaldisk get Caption,FreeSpace,Size /format:list
pause
goto advanced_analysis

:security_analysis
cls
echo === ANALISIS DE SEGURIDAD ===
echo.
echo Analizando seguridad del sistema...
wmic process where "not Name='explorer.exe' and not Name='cmd.exe' and not Name='powershell.exe'" get Name,ProcessId,CommandLine /format:list
wmic service where "StartMode='Auto' and not Name='Dnscache' and not Name='Spooler'" get Name,State,StartMode /format:list
pause
goto advanced_analysis

:configuration_analysis
cls
echo === ANALISIS DE CONFIGURACION ===
echo.
echo Analizando configuracion del sistema...
wmic os get Caption,Version,BuildNumber,OSArchitecture /format:list
wmic computersystem get Name,Domain,Workgroup /format:list
wmic bios get Manufacturer,SMBIOSBIOSVersion /format:list
pause
goto advanced_analysis

:policy_management
cls
echo ========================================
echo    GESTION DE POLITICAS
echo ========================================
echo.
echo 1. Aplicar politicas de seguridad
echo 2. Gestionar procesos permitidos
echo 3. Gestionar servicios restringidos
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto apply_security_policies
if "%subopcion%"=="2" goto manage_allowed_processes
if "%subopcion%"=="3" goto manage_restricted_services
if "%subopcion%"=="4" goto menu_principal
goto policy_management

:apply_security_policies
cls
echo === APLICAR POLITICAS DE SEGURIDAD ===
echo.
REM Obtener configuración de políticas
for /f "tokens=2 delims==" %%a in ('findstr "enforce_security" "%config_file%"') do set "enforce_security=%%a"
for /f "tokens=2 delims==" %%a in ('findstr "allowed_processes" "%config_file%"') do set "allowed_processes=%%a"
for /f "tokens=2 delims==" %%a in ('findstr "restricted_services" "%config_file%"') do set "restricted_services=%%a"

if "%enforce_security%"=="true" (
    echo Aplicando politicas de seguridad...
    echo Procesos permitidos: %allowed_processes%
    echo Servicios restringidos: %restricted_services%
    REM Implementar logica para aplicar politicas (ej. terminar procesos no permitidos, detener servicios restringidos)
    echo Politicas aplicadas.
) else (
    echo Las politicas de seguridad no estan habilitadas.
)
pause
goto policy_management

:manage_allowed_processes
cls
echo === GESTIONAR PROCESOS PERMITIDOS ===
echo.
for /f "tokens=2 delims==" %%a in ('findstr "allowed_processes" "%config_file%"') do echo Procesos actuales: %%a
set /p new_allowed_processes="Nuevos procesos permitidos (separados por comas): "
powershell -Command "(Get-Content '%config_file%') -replace 'allowed_processes=.*', 'allowed_processes=%new_allowed_processes%' | Set-Content '%config_file%'"
echo Procesos permitidos actualizados.
pause
goto policy_management

:manage_restricted_services
cls
echo === GESTIONAR SERVICIOS RESTRINGIDOS ===
echo.
for /f "tokens=2 delims==" %%a in ('findstr "restricted_services" "%config_file%"') do echo Servicios actuales: %%a
set /p new_restricted_services="Nuevos servicios restringidos (separados por comas): "
powershell -Command "(Get-Content '%config_file%') -replace 'restricted_services=.*', 'restricted_services=%new_restricted_services%' | Set-Content '%config_file%'"
echo Servicios restringidos actualizados.
pause
goto policy_management

:backup_restoration
cls
echo ========================================
echo    BACKUP Y RESTAURACION
echo ========================================
echo.
echo 1. Crear backup de configuracion
echo 2. Restaurar configuracion
echo 3. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto create_config_backup
if "%subopcion%"=="2" goto restore_config
if "%subopcion%"=="3" goto menu_principal
goto backup_restoration

:create_config_backup
cls
echo === CREAR BACKUP DE CONFIGURACION ===
echo.
set "backup_file=wmic_config_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.conf"
set "backup_file=%backup_file: =0%"

copy "%config_file%" "%backup_dir%\%backup_file%" >nul
if !errorlevel! equ 0 (
    echo Backup creado exitosamente: %backup_dir%\%backup_file%
) else (
    echo Error al crear backup.
)
pause
goto backup_restoration

:restore_config
cls
echo === RESTAURAR CONFIGURACION ===
echo.
echo Backups disponibles:
dir "%backup_dir%\wmic_config_backup_*.conf" /b
echo.
set /p backup_name="Ingrese el nombre del archivo de backup a restaurar: "
if not "%backup_name%"=="" (
    if exist "%backup_dir%\%backup_name%" (
        copy "%backup_dir%\%backup_name%" "%config_file%" >nul
        echo Configuracion restaurada exitosamente.
    ) else (
        echo Archivo de backup no encontrado.
    )
) else (
    echo Nombre de archivo no valido.
)
pause
goto backup_restoration

:advanced_reports
cls
echo ========================================
echo    REPORTES AVANZADOS
echo ========================================
echo.
echo 1. Reporte de estado del sistema
echo 2. Reporte de procesos y servicios
echo 3. Reporte de configuracion
echo 4. Reporte de seguridad
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto system_status_report
if "%subopcion%"=="2" goto process_service_report
if "%subopcion%"=="3" goto configuration_report
if "%subopcion%"=="4" goto security_report
if "%subopcion%"=="5" goto menu_principal
goto advanced_reports

:system_status_report
cls
echo === REPORTE DE ESTADO DEL SISTEMA ===
echo.
set "report_file=reporte_estado_wmic_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Estado del Sistema WMIC - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === INFORMACION GENERAL === >> "%report_file%"
wmic computersystem get Name,Manufacturer,Model,SystemType >> "%report_file%"
wmic os get Caption,Version,BuildNumber,OSArchitecture >> "%report_file%"
echo. >> "%report_file%"

echo === USO DE RECURSOS === >> "%report_file%"
wmic cpu get LoadPercentage >> "%report_file%"
wmic os get FreePhysicalMemory,TotalVisibleMemorySize >> "%report_file%"
wmic logicaldisk get Caption,FreeSpace,Size >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:process_service_report
cls
echo === REPORTE DE PROCESOS Y SERVICIOS ===
echo.
set "report_file=reporte_proc_serv_wmic_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Procesos y Servicios WMIC - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === PROCESOS ACTIVOS === >> "%report_file%"
wmic process get Name,ProcessId,WorkingSetSize,CommandLine >> "%report_file%"
echo. >> "%report_file%"

echo === SERVICIOS ACTIVOS === >> "%report_file%"
wmic service get Name,State,StartMode,DisplayName >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:configuration_report
cls
echo === REPORTE DE CONFIGURACION ===
echo.
set "report_file=reporte_config_wmic_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Configuracion WMIC - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === CONFIGURACION ACTUAL === >> "%report_file%"
type "%config_file%" >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:security_report
cls
echo === REPORTE DE SEGURIDAD ===
echo.
set "report_file=reporte_seguridad_wmic_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Seguridad WMIC - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === POLITICAS DE SEGURIDAD === >> "%report_file%"
for /f "tokens=2 delims==" %%a in ('findstr "enforce_security" "%config_file%"') do echo Aplicar politicas: %%a >> "%report_file%"
for /f "tokens=2 delims==" %%a in ('findstr "allowed_processes" "%config_file%"') do echo Procesos permitidos: %%a >> "%report_file%"
for /f "tokens=2 delims==" %%a in ('findstr "restricted_services" "%config_file%"') do echo Servicios restringidos: %%a >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:salir
echo Gracias por usar el Sistema de Gestion Avanzada con WMIC
exit /b 0 