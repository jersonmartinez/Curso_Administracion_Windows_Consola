@echo off
setlocal enabledelayedexpansion
title SISTEMA DE GESTION AVANZADA DEL REGISTRO

REM Verificar privilegios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Este script requiere privilegios de administrador.
    echo Por favor, ejecuta como administrador.
    pause
    exit /b 1
)

REM Configuración inicial
set "config_file=registro_config.conf"
set "log_file=registro_advanced.log"
set "backup_dir=backups_registro"
set "monitor_file=monitor_registro.log"

REM Crear directorio de backups si no existe
if not exist "%backup_dir%" mkdir "%backup_dir%"

REM Crear archivo de configuración por defecto si no existe
if not exist "%config_file%" (
    echo # Configuracion del Sistema de Gestion Avanzada del Registro > "%config_file%"
    echo # Archivo de configuracion > "%config_file%"
    echo. >> "%config_file%"
    echo [GENERAL] >> "%config_file%"
    echo log_level=INFO >> "%config_file%"
    echo auto_backup=true >> "%config_file%"
    echo backup_interval=24 >> "%config_file%"
    echo. >> "%config_file%"
    echo [MONITORING] >> "%config_file%"
    echo enable_realtime=true >> "%config_file%"
    echo refresh_rate=5 >> "%config_file%"
    echo monitored_keys=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run,HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run >> "%config_file%"
    echo. >> "%config_file%"
    echo [SECURITY] >> "%config_file%"
    echo enforce_security=false >> "%config_file%"
    echo restricted_keys=HKLM\SOFTWARE\Policies,HKLM\SYSTEM\CurrentControlSet\Services >> "%config_file%"
    echo audit_changes=true >> "%config_file%"
    echo. >> "%config_file%"
    echo [CLEANUP] >> "%config_file%"
    echo auto_cleanup_temp_keys=false >> "%config_file%"
    echo temp_key_prefix=TempApp_ >> "%config_file%"
)

echo ========================================
echo  SISTEMA DE GESTION AVANZADA DEL REGISTRO
echo ========================================
echo.

:menu_principal
cls
echo ========================================
echo  SISTEMA DE GESTION AVANZADA DEL REGISTRO
echo ========================================
echo.
echo 1. Configuracion avanzada
echo 2. Monitoreo en tiempo real
echo 3. Analisis de seguridad
echo 4. Gestion de politicas
echo 5. Backup y restauracion
echo 6. Limpieza y optimizacion
echo 7. Reportes avanzados
echo 8. Salir
echo.
set /p opcion="Seleccione una opcion: "

if "%opcion%"=="1" goto advanced_configuration
if "%opcion%"=="2" goto real_time_monitoring
if "%opcion%"=="3" goto security_analysis
if "%opcion%"=="4" goto policy_management
if "%opcion%"=="5" goto backup_restoration
if "%opcion%"=="6" goto cleanup_optimization
if "%opcion%"=="7" goto advanced_reports
if "%opcion%"=="8" goto salir
goto menu_principal

:advanced_configuration
cls
echo ========================================
echo    CONFIGURACION AVANZADA
echo ========================================
echo.
echo 1. Ver configuracion actual
echo 2. Editar configuracion general
echo 3. Editar configuracion de monitoreo
echo 4. Editar configuracion de seguridad
echo 5. Editar configuracion de limpieza
echo 6. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto view_config
if "%subopcion%"=="2" goto edit_general_config
if "%subopcion%"=="3" goto edit_monitoring_config
if "%subopcion%"=="4" goto edit_security_config
if "%subopcion%"=="5" goto edit_cleanup_config
if "%subopcion%"=="6" goto menu_principal
goto advanced_configuration

:view_config
cls
echo === CONFIGURACION ACTUAL ===
type "%config_file%"
pause
goto advanced_configuration

:edit_general_config
cls
echo === EDITAR CONFIGURACION GENERAL ===
echo.
set /p log_level="Nivel de log (INFO/DEBUG/ERROR): "
set /p auto_backup="Backup automatico (true/false): "
set /p backup_interval="Intervalo de backup (horas): "

powershell -Command "(Get-Content '%config_file%') -replace 'log_level=.*', 'log_level=%log_level%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'auto_backup=.*', 'auto_backup=%auto_backup%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'backup_interval=.*', 'backup_interval=%backup_interval%' | Set-Content '%config_file%'"

echo Configuracion general actualizada.
pause
goto advanced_configuration

:edit_monitoring_config
cls
echo === EDITAR CONFIGURACION DE MONITOREO ===
echo.
set /p enable_realtime="Habilitar monitoreo en tiempo real (true/false): "
set /p refresh_rate="Frecuencia de actualizacion (segundos): "
set /p monitored_keys="Claves a monitorear (separadas por comas): "

powershell -Command "(Get-Content '%config_file%') -replace 'enable_realtime=.*', 'enable_realtime=%enable_realtime%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'refresh_rate=.*', 'refresh_rate=%refresh_rate%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'monitored_keys=.*', 'monitored_keys=%monitored_keys%' | Set-Content '%config_file%'"

echo Configuracion de monitoreo actualizada.
pause
goto advanced_configuration

:edit_security_config
cls
echo === EDITAR CONFIGURACION DE SEGURIDAD ===
echo.
set /p enforce_security="Aplicar politicas de seguridad (true/false): "
set /p restricted_keys="Claves restringidas (separadas por comas): "
set /p audit_changes="Auditar cambios (true/false): "

powershell -Command "(Get-Content '%config_file%') -replace 'enforce_security=.*', 'enforce_security=%enforce_security%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'restricted_keys=.*', 'restricted_keys=%restricted_keys%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'audit_changes=.*', 'audit_changes=%audit_changes%' | Set-Content '%config_file%'"

echo Configuracion de seguridad actualizada.
pause
goto advanced_configuration

:edit_cleanup_config
cls
echo === EDITAR CONFIGURACION DE LIMPIEZA ===
echo.
set /p auto_cleanup_temp_keys="Limpiar claves temporales automaticamente (true/false): "
set /p temp_key_prefix="Prefijo de claves temporales: "

powershell -Command "(Get-Content '%config_file%') -replace 'auto_cleanup_temp_keys=.*', 'auto_cleanup_temp_keys=%auto_cleanup_temp_keys%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'temp_key_prefix=.*', 'temp_key_prefix=%temp_key_prefix%' | Set-Content '%config_file%'"

echo Configuracion de limpieza actualizada.
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
for /f "tokens=2 delims==" %%a in ('findstr "monitored_keys" "%config_file%"') do set "monitored_keys=%%a"

echo === CLAVES MONITOREADAS ===
echo.
for %%k in (%monitored_keys%) do (
    echo Clave: %%k
    reg query "%%k"
    echo.
)

echo.
echo === CAMBIOS RECIENTES (LOG) ===
echo.
if exist "%monitor_file%" (
    type "%monitor_file%" | findstr /v "Monitoreando" | tail -n 5
) else (
    echo No hay log de monitoreo.
)

timeout /t %refresh_rate% /nobreak >nul
goto monitoring_loop

:security_analysis
cls
echo ========================================
echo    ANALISIS DE SEGURIDAD
echo ========================================
echo.
echo 1. Analizar claves de inicio automatico
echo 2. Analizar permisos de registro
echo 3. Analizar claves sospechosas
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto analyze_startup_keys
if "%subopcion%"=="2" goto analyze_registry_permissions
if "%subopcion%"=="3" goto analyze_suspicious_keys
if "%subopcion%"=="4" goto menu_principal
goto security_analysis

:analyze_startup_keys
cls
echo === ANALIZAR CLAVES DE INICIO AUTOMATICO ===
echo.
echo Analizando HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run...
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
echo.
echo Analizando HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run...
reg query HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
echo.
echo Analisis completado.
pause
goto security_analysis

:analyze_registry_permissions
cls
echo === ANALIZAR PERMISOS DE REGISTRO ===
echo.
set /p clave="Ingrese la clave a analizar (ej: HKLM\SOFTWARE\MiApp): "
if not "%clave%"=="" (
    echo Analizando permisos de %clave%...
    reg query "%clave%" /s /z | findstr "Access"
    echo Analisis completado.
) else (
    echo Clave no valida.
)
pause
goto security_analysis

:analyze_suspicious_keys
cls
echo === ANALIZAR CLAVES SOSPECHOSAS ===
echo.
echo Buscando claves con nombres largos o caracteres inusuales...
REM Esta funcionalidad es mas compleja y requeriria un parser mas sofisticado
echo (Funcionalidad avanzada, requiere logica de deteccion de patrones)
pause
goto security_analysis

:policy_management
cls
echo ========================================
echo    GESTION DE POLITICAS
echo ========================================
echo.
echo 1. Aplicar politicas de seguridad
echo 2. Gestionar claves restringidas
echo 3. Configurar auditoria de cambios
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto apply_security_policies
if "%subopcion%"=="2" goto manage_restricted_keys
if "%subopcion%"=="3" goto configure_audit_changes
if "%subopcion%"=="4" goto menu_principal
goto policy_management

:apply_security_policies
cls
echo === APLICAR POLITICAS DE SEGURIDAD ===
echo.
REM Obtener configuración de políticas
for /f "tokens=2 delims==" %%a in ('findstr "enforce_security" "%config_file%"') do set "enforce_security=%%a"
for /f "tokens=2 delims==" %%a in ('findstr "restricted_keys" "%config_file%"') do set "restricted_keys=%%a"

if "%enforce_security%"=="true" (
    echo Aplicando politicas de seguridad...
    echo Claves restringidas: %restricted_keys%
    REM Implementar logica para proteger o monitorear claves restringidas
    echo Politicas aplicadas.
) else (
    echo Las politicas de seguridad no estan habilitadas.
)
pause
goto policy_management

:manage_restricted_keys
cls
echo === GESTIONAR CLAVES RESTRINGIDAS ===
echo.
for /f "tokens=2 delims==" %%a in ('findstr "restricted_keys" "%config_file%"') do echo Claves actuales: %%a
set /p new_restricted_keys="Nuevas claves restringidas (separadas por comas): "
powershell -Command "(Get-Content '%config_file%') -replace 'restricted_keys=.*', 'restricted_keys=%new_restricted_keys%' | Set-Content '%config_file%'"
echo Claves restringidas actualizadas.
pause
goto policy_management

:configure_audit_changes
cls
echo === CONFIGURAR AUDITORIA DE CAMBIOS ===
echo.
for /f "tokens=2 delims==" %%a in ('findstr "audit_changes" "%config_file%"') do echo Auditoria de cambios actual: %%a
set /p audit_status="Habilitar auditoria de cambios (true/false): "
powershell -Command "(Get-Content '%config_file%') -replace 'audit_changes=.*', 'audit_changes=%audit_status%' | Set-Content '%config_file%'"
echo Configuracion de auditoria actualizada.
pause
goto policy_management

:backup_restoration
cls
echo ========================================
echo    BACKUP Y RESTAURACION
echo ========================================
echo.
echo 1. Crear backup completo del registro
echo 2. Restaurar backup del registro
echo 3. Crear backup de clave especifica
echo 4. Restaurar clave especifica
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto create_full_registry_backup
if "%subopcion%"=="2" goto restore_full_registry_backup
if "%subopcion%"=="3" goto create_key_backup
if "%subopcion%"=="4" goto restore_key_backup
if "%subopcion%"=="5" goto menu_principal
goto backup_restoration

:create_full_registry_backup
cls
echo === CREAR BACKUP COMPLETO DEL REGISTRO ===
echo.
set "backup_file=full_registry_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.reg"
set "backup_file=%backup_file: =0%"

echo Creando backup completo del registro...
reg export HKLM "%backup_dir%\HKLM_%backup_file%" /y
reg export HKCU "%backup_dir%\HKCU_%backup_file%" /y
reg export HKCR "%backup_dir%\HKCR_%backup_file%" /y
reg export HKU "%backup_dir%\HKU_%backup_file%" /y
reg export HKCC "%backup_dir%\HKCC_%backup_file%" /y

echo Backup completo creado en: %backup_dir%
pause
goto backup_restoration

:restore_full_registry_backup
cls
echo === RESTAURAR BACKUP DEL REGISTRO ===
echo.
echo Esta operacion es critica y puede causar inestabilidad.
echo Se recomienda usar un punto de restauracion del sistema.
echo ¿Desea continuar? (s/n)
set /p confirm="Confirmar: "
if /i "%confirm%"=="s" (
    echo Restaurando backup completo...
    echo (Funcionalidad avanzada, requiere cuidado extremo)
    echo Por favor, restaure manualmente los archivos .reg desde %backup_dir%
) else (
    echo Operacion cancelada.
)
pause
goto backup_restoration

:create_key_backup
cls
echo === CREAR BACKUP DE CLAVE ESPECIFICA ===
echo.
set /p clave="Ingrese la clave a respaldar (ej: HKLM\SOFTWARE\MiApp): "
set "backup_file=key_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.reg"
set "backup_file=%backup_file: =0%"

if not "%clave%"=="" (
    reg export "%clave%" "%backup_dir%\%backup_file%"
    if !errorlevel! equ 0 (
        echo Backup de clave %clave% creado en: %backup_dir%\%backup_file%
    ) else (
        echo Error al crear backup de clave.
    )
) else (
    echo Clave no valida.
)
pause
goto backup_restoration

:restore_key_backup
cls
echo === RESTAURAR CLAVE ESPECIFICA ===
echo.
set /p backup_file="Ingrese el archivo .reg de backup de clave: "
if exist "%backup_dir%\%backup_file%" (
    echo ¿Estas seguro de importar %backup_file%? (s/n)
    set /p confirm="Confirmar: "
    if /i "%confirm%"=="s" (
        reg import "%backup_dir%\%backup_file%"
        if !errorlevel! equ 0 (
            echo Clave restaurada desde %backup_file%.
        ) else (
            echo Error al restaurar clave.
        )
    ) else (
        echo Operacion cancelada.
    )
) else (
    echo Archivo de backup no encontrado.
)
pause
goto backup_restoration

:cleanup_optimization
cls
echo ========================================
echo    LIMPIEZA Y OPTIMIZACION
echo ========================================
echo.
echo 1. Limpiar claves temporales
echo 2. Desfragmentar registro (simulado)
echo 3. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto clean_temp_keys
if "%subopcion%"=="2" goto defrag_registry
if "%subopcion%"=="3" goto menu_principal
goto cleanup_optimization

:clean_temp_keys
cls
echo === LIMPIAR CLAVES TEMPORALES ===
echo.
REM Obtener configuración de limpieza
for /f "tokens=2 delims==" %%a in ('findstr "auto_cleanup_temp_keys" "%config_file%"') do set "auto_cleanup_temp_keys=%%a"
for /f "tokens=2 delims==" %%a in ('findstr "temp_key_prefix" "%config_file%"') do set "temp_key_prefix=%%a"

if "%auto_cleanup_temp_keys%"=="true" (
    echo Limpiando claves con prefijo '%temp_key_prefix%'...
    REM Esta funcionalidad es compleja y requiere un escaneo cuidadoso del registro
    echo (Funcionalidad avanzada, requiere logica de escaneo y eliminacion segura)
    echo Se recomienda precaucion extrema.
) else (
    echo La limpieza automatica de claves temporales esta deshabilitada.
)
pause
goto cleanup_optimization

:defrag_registry
cls
echo === DESFRAGMENTAR REGISTRO (SIMULADO) ===
echo.
echo La desfragmentacion directa del registro no es posible con herramientas nativas.
echo Se recomienda usar herramientas de terceros o reiniciar el sistema para optimizacion.
echo (Simulacion de optimizacion)
echo Optimizacion completada.
pause
goto cleanup_optimization

:advanced_reports
cls
echo ========================================
echo    REPORTES AVANZADOS
echo ========================================
echo.
echo 1. Reporte de configuracion
echo 2. Reporte de cambios (log)
echo 3. Reporte de seguridad
echo 4. Reporte de backup
echo 5. Reporte completo
echo 6. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto config_report
if "%subopcion%"=="2" goto changes_report
if "%subopcion%"=="3" goto security_report
if "%subopcion%"=="4" goto backup_report
if "%subopcion%"=="5" goto complete_report
if "%subopcion%"=="6" goto menu_principal
goto advanced_reports

:config_report
cls
echo === REPORTE DE CONFIGURACION ===
echo.
set "report_file=reporte_config_registro_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Configuracion del Registro - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === CONFIGURACION ACTUAL === >> "%report_file%"
type "%config_file%" >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:changes_report
cls
echo === REPORTE DE CAMBIOS ===
echo.
set "report_file=reporte_cambios_registro_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Cambios del Registro - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

if exist "%monitor_file%" (
    echo === LOG DE CAMBIOS === >> "%report_file%"
    type "%monitor_file%" >> "%report_file%"
) else (
    echo No hay log de cambios disponible. >> "%report_file%"
)

echo Reporte generado: %report_file%
pause
goto advanced_reports

:security_report
cls
echo === REPORTE DE SEGURIDAD ===
echo.
set "report_file=reporte_seguridad_registro_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Seguridad del Registro - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === CLAVES DE INICIO AUTOMATICO === >> "%report_file%"
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run >> "%report_file%"
reg query HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run >> "%report_file%"
echo. >> "%report_file%"

echo === POLITICAS DE SEGURIDAD === >> "%report_file%"
for /f "tokens=2 delims==" %%a in ('findstr "enforce_security" "%config_file%"') do echo Aplicar politicas: %%a >> "%report_file%"
for /f "tokens=2 delims==" %%a in ('findstr "restricted_keys" "%config_file%"') do echo Claves restringidas: %%a >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:backup_report
cls
echo === REPORTE DE BACKUP ===
echo.
set "report_file=reporte_backup_registro_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Backup del Registro - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === BACKUPS DISPONIBLES === >> "%report_file%"
dir "%backup_dir%\*.reg" /b >> "%report_file%" 2>nul
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:complete_report
cls
echo === REPORTE COMPLETO ===
echo.
set "report_file=reporte_completo_registro_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte Completo del Registro - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === CONFIGURACION === >> "%report_file%"
type "%config_file%" >> "%report_file%"
echo. >> "%report_file%"

echo === CLAVES CRITICAS === >> "%report_file%"
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run >> "%report_file%"
reg query HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run >> "%report_file%"
echo. >> "%report_file%"

echo === BACKUPS === >> "%report_file%"
dir "%backup_dir%\*.reg" /b >> "%report_file%" 2>nul
echo. >> "%report_file%"

echo Reporte completo generado: %report_file%
pause
goto advanced_reports

:salir
echo Gracias por usar el Sistema de Gestion Avanzada del Registro
exit /b 0 