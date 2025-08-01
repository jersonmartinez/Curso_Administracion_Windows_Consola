@echo off
setlocal enabledelayedexpansion
title SISTEMA DE GESTION AVANZADA DE SHELL

REM Configuración inicial
set "config_file=shell_config.conf"
set "log_file=shell_advanced.log"
set "profiles_dir=shell_profiles"
set "backup_dir=shell_backups"

REM Crear directorios necesarios
if not exist "%profiles_dir%" mkdir "%profiles_dir%"
if not exist "%backup_dir%" mkdir "%backup_dir%"

REM Crear archivo de configuración por defecto si no existe
if not exist "%config_file%" (
    echo # Configuracion del Sistema de Gestion Avanzada de Shell > "%config_file%"
    echo # Archivo de configuracion > "%config_file%"
    echo. >> "%config_file%"
    echo [ENVIRONMENT] >> "%config_file%"
    echo default_profile=default >> "%config_file%"
    echo auto_load_profile=true >> "%config_file%"
    echo log_operations=true >> "%config_file%"
    echo. >> "%config_file%"
    echo [PROFILES] >> "%config_file%"
    echo profiles_directory=%profiles_dir% >> "%config_file%"
    echo backup_directory=%backup_dir% >> "%config_file%"
    echo. >> "%config_file%"
    echo [AUTOMATION] >> "%config_file%"
    echo auto_cleanup=true >> "%config_file%"
    echo cleanup_interval=24 >> "%config_file%"
    echo scheduled_tasks=true >> "%config_file%"
    echo. >> "%config_file%"
    echo [SECURITY] >> "%config_file%"
    echo validate_commands=true >> "%config_file%"
    echo restricted_commands=format,del,rmdir >> "%config_file%"
    echo require_confirmation=true >> "%config_file%"
)

echo ========================================
echo  SISTEMA DE GESTION AVANZADA DE SHELL
echo ========================================
echo.

:menu_principal
cls
echo ========================================
echo  SISTEMA DE GESTION AVANZADA DE SHELL
echo ========================================
echo.
echo 1. Configuracion avanzada
echo 2. Gestion de perfiles
echo 3. Automatizacion programada
echo 4. Monitoreo en tiempo real
echo 5. Backup y restauracion
echo 6. Reportes avanzados
echo 7. Analisis de rendimiento
echo 8. Gestion de seguridad
echo 9. Salir
echo.
set /p opcion="Seleccione una opcion: "

if "%opcion%"=="1" goto advanced_configuration
if "%opcion%"=="2" goto profile_management
if "%opcion%"=="3" goto scheduled_automation
if "%opcion%"=="4" goto real_time_monitoring
if "%opcion%"=="5" goto backup_recovery
if "%opcion%"=="6" goto advanced_reports
if "%opcion%"=="7" goto performance_analysis
if "%opcion%"=="8" goto security_management
if "%opcion%"=="9" goto salir
goto menu_principal

:advanced_configuration
cls
echo ========================================
echo    CONFIGURACION AVANZADA
echo ========================================
echo.
echo 1. Ver configuracion actual
echo 2. Editar configuracion de entorno
echo 3. Editar configuracion de perfiles
echo 4. Editar configuracion de automatizacion
echo 5. Editar configuracion de seguridad
echo 6. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto view_config
if "%subopcion%"=="2" goto edit_environment_config
if "%subopcion%"=="3" goto edit_profile_config
if "%subopcion%"=="4" goto edit_automation_config
if "%subopcion%"=="5" goto edit_security_config
if "%subopcion%"=="6" goto menu_principal
goto advanced_configuration

:view_config
cls
echo === CONFIGURACION ACTUAL ===
type "%config_file%"
pause
goto advanced_configuration

:edit_environment_config
cls
echo === EDITAR CONFIGURACION DE ENTORNO ===
echo.
set /p default_profile="Perfil por defecto: "
set /p auto_load="Cargar perfil automaticamente (true/false): "
set /p log_ops="Registrar operaciones (true/false): "

powershell -Command "(Get-Content '%config_file%') -replace 'default_profile=.*', 'default_profile=%default_profile%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'auto_load_profile=.*', 'auto_load_profile=%auto_load%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'log_operations=.*', 'log_operations=%log_ops%' | Set-Content '%config_file%'"

echo Configuracion de entorno actualizada.
pause
goto advanced_configuration

:edit_profile_config
cls
echo === EDITAR CONFIGURACION DE PERFILES ===
echo.
set /p profiles_dir="Directorio de perfiles: "
set /p backup_dir="Directorio de backup: "

powershell -Command "(Get-Content '%config_file%') -replace 'profiles_directory=.*', 'profiles_directory=%profiles_dir%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'backup_directory=.*', 'backup_directory=%backup_dir%' | Set-Content '%config_file%'"

echo Configuracion de perfiles actualizada.
pause
goto advanced_configuration

:edit_automation_config
cls
echo === EDITAR CONFIGURACION DE AUTOMATIZACION ===
echo.
set /p auto_cleanup="Limpieza automatica (true/false): "
set /p cleanup_interval="Intervalo de limpieza (horas): "
set /p scheduled_tasks="Tareas programadas (true/false): "

powershell -Command "(Get-Content '%config_file%') -replace 'auto_cleanup=.*', 'auto_cleanup=%auto_cleanup%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'cleanup_interval=.*', 'cleanup_interval=%cleanup_interval%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'scheduled_tasks=.*', 'scheduled_tasks=%scheduled_tasks%' | Set-Content '%config_file%'"

echo Configuracion de automatizacion actualizada.
pause
goto advanced_configuration

:edit_security_config
cls
echo === EDITAR CONFIGURACION DE SEGURIDAD ===
echo.
set /p validate_commands="Validar comandos (true/false): "
set /p restricted_commands="Comandos restringidos (separados por comas): "
set /p require_confirmation="Requerir confirmacion (true/false): "

powershell -Command "(Get-Content '%config_file%') -replace 'validate_commands=.*', 'validate_commands=%validate_commands%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'restricted_commands=.*', 'restricted_commands=%restricted_commands%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'require_confirmation=.*', 'require_confirmation=%require_confirmation%' | Set-Content '%config_file%'"

echo Configuracion de seguridad actualizada.
pause
goto advanced_configuration

:profile_management
cls
echo ========================================
echo    GESTION DE PERFILES
echo ========================================
echo.
echo 1. Crear nuevo perfil
echo 2. Cargar perfil existente
echo 3. Editar perfil
echo 4. Eliminar perfil
echo 5. Listar perfiles
echo 6. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto create_profile
if "%subopcion%"=="2" goto load_profile
if "%subopcion%"=="3" goto edit_profile
if "%subopcion%"=="4" goto delete_profile
if "%subopcion%"=="5" goto list_profiles
if "%subopcion%"=="6" goto menu_principal
goto profile_management

:create_profile
cls
echo === CREAR NUEVO PERFIL ===
echo.
set /p profile_name="Nombre del perfil: "
set /p profile_description="Descripcion: "
set /p profile_environment="Ambiente (DESARROLLO/PRODUCCION/TESTING): "

if not "%profile_name%"=="" (
    set "profile_file=%profiles_dir%\%profile_name%.bat"
    
    echo @echo off > "%profile_file%"
    echo REM Perfil: %profile_name% >> "%profile_file%"
    echo REM Descripcion: %profile_description% >> "%profile_file%"
    echo REM Fecha creacion: %date% %time% >> "%profile_file%"
    echo. >> "%profile_file%"
    echo set AMBIENTE=%profile_environment% >> "%profile_file%"
    echo set PROFILE_NAME=%profile_name% >> "%profile_file%"
    echo. >> "%profile_file%"
    echo echo Perfil %profile_name% cargado. >> "%profile_file%"
    echo cmd /k >> "%profile_file%"
    
    echo Perfil creado: %profile_file%
) else (
    echo Nombre de perfil no válido.
)
pause
goto profile_management

:load_profile
cls
echo === CARGAR PERFIL EXISTENTE ===
echo.
echo Perfiles disponibles:
dir "%profiles_dir%\*.bat" /b 2>nul

echo.
set /p profile_name="Nombre del perfil: "
if not "%profile_name%"=="" (
    set "profile_file=%profiles_dir%\%profile_name%.bat"
    if exist "%profile_file%" (
        echo Cargando perfil: %profile_name%
        call "%profile_file%"
    ) else (
        echo Perfil no encontrado.
    )
) else (
    echo Nombre de perfil no válido.
)
pause
goto profile_management

:edit_profile
cls
echo === EDITAR PERFIL ===
echo.
echo Perfiles disponibles:
dir "%profiles_dir%\*.bat" /b 2>nul

echo.
set /p profile_name="Nombre del perfil: "
if not "%profile_name%"=="" (
    set "profile_file=%profiles_dir%\%profile_name%.bat"
    if exist "%profile_file%" (
        echo Editando perfil: %profile_name%
        notepad "%profile_file%"
    ) else (
        echo Perfil no encontrado.
    )
) else (
    echo Nombre de perfil no válido.
)
pause
goto profile_management

:delete_profile
cls
echo === ELIMINAR PERFIL ===
echo.
echo Perfiles disponibles:
dir "%profiles_dir%\*.bat" /b 2>nul

echo.
set /p profile_name="Nombre del perfil: "
if not "%profile_name%"=="" (
    set "profile_file=%profiles_dir%\%profile_name%.bat"
    if exist "%profile_file%" (
        echo ¿Estas seguro de eliminar el perfil %profile_name%?
        set /p confirm="(s/n): "
        if /i "%confirm%"=="s" (
            del "%profile_file%"
            echo Perfil eliminado.
        ) else (
            echo Operacion cancelada.
        )
    ) else (
        echo Perfil no encontrado.
    )
) else (
    echo Nombre de perfil no válido.
)
pause
goto profile_management

:list_profiles
cls
echo === LISTAR PERFILES ===
echo.
echo Perfiles disponibles:
dir "%profiles_dir%\*.bat" /b 2>nul
if !errorlevel! neq 0 (
    echo No hay perfiles creados.
)
pause
goto profile_management

:scheduled_automation
cls
echo ========================================
echo    AUTOMATIZACION PROGRAMADA
echo ========================================
echo.
echo 1. Crear tarea programada
echo 2. Listar tareas programadas
echo 3. Ejecutar tareas programadas
echo 4. Eliminar tarea programada
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto create_scheduled_task
if "%subopcion%"=="2" goto list_scheduled_tasks
if "%subopcion%"=="3" goto execute_scheduled_tasks
if "%subopcion%"=="4" goto delete_scheduled_task
if "%subopcion%"=="5" goto menu_principal
goto scheduled_automation

:create_scheduled_task
cls
echo === CREAR TAREA PROGRAMADA ===
echo.
set /p task_name="Nombre de la tarea: "
set /p task_command="Comando a ejecutar: "
set /p task_schedule="Programacion (daily/weekly): "
set /p task_time="Hora (HH:MM): "

if not "%task_name%"=="" (
    echo Creando tarea programada...
    set "script_file=scheduled_task_%task_name%.bat"
    
    echo @echo off > "%script_file%"
    echo REM Tarea programada: %task_name% >> "%script_file%"
    echo REM Comando: %task_command% >> "%script_file%"
    echo %task_command% >> "%script_file%"
    
    schtasks /create /tn "%task_name%" /tr "%script_file%" /sc %task_schedule% /st %task_time%
    
    echo Tarea programada creada: %task_name%
) else (
    echo Nombre de tarea no válido.
)
pause
goto scheduled_automation

:list_scheduled_tasks
cls
echo === LISTAR TAREAS PROGRAMADAS ===
echo.
echo Tareas programadas de shell:
schtasks /query /tn "*shell*" /fo table
pause
goto scheduled_automation

:execute_scheduled_tasks
cls
echo === EJECUTAR TAREAS PROGRAMADAS ===
echo.
echo Ejecutando tareas programadas...

REM Obtener configuración
for /f "tokens=2 delims==" %%a in ('findstr "scheduled_tasks" "%config_file%"') do set "scheduled_tasks=%%a"

if "%scheduled_tasks%"=="true" (
    echo Ejecutando tareas automaticas...
    del /q /f %TEMP%\*.* 2>nul
    echo Tareas completadas.
) else (
    echo Tareas programadas deshabilitadas.
)
pause
goto scheduled_automation

:delete_scheduled_task
cls
echo === ELIMINAR TAREA PROGRAMADA ===
echo.
set /p task_name="Nombre de la tarea a eliminar: "

schtasks /delete /tn "%task_name%" /f
echo Tarea eliminada: %task_name%
pause
goto scheduled_automation

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

echo === ESTADO DEL SHELL ===
echo.

REM Obtener configuración
for /f "tokens=2 delims==" %%a in ('findstr "default_profile" "%config_file%"') do set "default_profile=%%a"

echo Perfil por defecto: %default_profile%
echo Usuario actual: %USERNAME%
echo Sistema: %COMPUTERNAME%

echo.
echo === VARIABLES CRITICAS ===
echo.

echo PATH: %PATH%
echo TEMP: %TEMP%
echo SYSTEMROOT: %SYSTEMROOT%

echo.
echo === PROCESOS ACTIVOS ===
echo.

tasklist | findstr "cmd.exe"
tasklist | findstr "powershell.exe"

echo.
echo === ESPACIO EN DISCO ===
echo.

dir C:\ /-c | find "bytes free"

timeout /t 5 /nobreak >nul
goto monitoring_loop

:backup_recovery
cls
echo ========================================
echo    BACKUP Y RESTAURACION
echo ========================================
echo.
echo 1. Crear backup de configuracion
echo 2. Restaurar configuracion
echo 3. Backup de perfiles
echo 4. Restaurar perfiles
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto create_config_backup
if "%subopcion%"=="2" goto restore_config
if "%subopcion%"=="3" goto backup_profiles
if "%subopcion%"=="4" goto restore_profiles
if "%subopcion%"=="5" goto menu_principal
goto backup_recovery

:create_config_backup
cls
echo === CREAR BACKUP DE CONFIGURACION ===
echo.

set "backup_file=shell_config_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.conf"
set "backup_file=%backup_file: =0%"

copy "%config_file%" "%backup_file%" >nul
if !errorlevel! equ 0 (
    echo Backup creado exitosamente: %backup_file%
) else (
    echo Error al crear backup.
)
pause
goto backup_recovery

:restore_config
cls
echo === RESTAURAR CONFIGURACION ===
echo.

echo Backups disponibles:
dir "shell_config_backup_*.conf" /b

echo.
set /p backup_file="Archivo de backup: "
if exist "%backup_file%" (
    copy "%backup_file%" "%config_file%" >nul
    echo Configuracion restaurada exitosamente.
) else (
    echo Archivo de backup no encontrado.
)
pause
goto backup_recovery

:backup_profiles
cls
echo === BACKUP DE PERFILES ===
echo.

set "backup_dir=profiles_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "backup_dir=%backup_dir: =0%"

if exist "%profiles_dir%" (
    xcopy "%profiles_dir%" "%backup_dir%" /E /I /Y >nul
    echo Backup de perfiles creado: %backup_dir%
) else (
    echo Directorio de perfiles no encontrado.
)
pause
goto backup_recovery

:restore_profiles
cls
echo === RESTAURAR PERFILES ===
echo.

echo Backups disponibles:
dir "profiles_backup_*" /d /b

echo.
set /p backup_dir="Directorio de backup: "
if exist "%backup_dir%" (
    xcopy "%backup_dir%" "%profiles_dir%" /E /I /Y >nul
    echo Perfiles restaurados exitosamente.
) else (
    echo Directorio de backup no encontrado.
)
pause
goto backup_recovery

:advanced_reports
cls
echo ========================================
echo    REPORTES AVANZADOS
echo ========================================
echo.
echo 1. Reporte completo de configuracion
echo 2. Reporte de perfiles
echo 3. Reporte de rendimiento
echo 4. Reporte de seguridad
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto complete_config_report
if "%subopcion%"=="2" goto profile_report
if "%subopcion%"=="3" goto performance_report
if "%subopcion%"=="4" goto security_report
if "%subopcion%"=="5" goto menu_principal
goto advanced_reports

:complete_config_report
cls
echo === REPORTE COMPLETO DE CONFIGURACION ===
echo.

set "report_file=complete_config_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte Completo de Configuracion - %date% %time% > "%report_file%"
echo. >> "%report_file%"

echo === CONFIGURACION ACTUAL === >> "%report_file%"
type "%config_file%" >> "%report_file%"

echo. >> "%report_file%"
echo === VARIABLES DE ENTORNO === >> "%report_file%"
set >> "%report_file%"

echo Reporte completo generado: %report_file%
pause
goto advanced_reports

:profile_report
cls
echo === REPORTE DE PERFILES ===
echo.

set "report_file=profile_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Perfiles - %date% %time% > "%report_file%"
echo. >> "%report_file%"

echo === PERFILES DISPONIBLES === >> "%report_file%"
dir "%profiles_dir%\*.bat" /b >> "%report_file%" 2>nul

echo Reporte generado: %report_file%
pause
goto advanced_reports

:performance_report
cls
echo === REPORTE DE RENDIMIENTO ===
echo.

set "report_file=performance_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Rendimiento - %date% %time% > "%report_file%"
echo. >> "%report_file%"

echo === INFORMACION DEL SISTEMA === >> "%report_file%"
echo Sistema: %COMPUTERNAME% >> "%report_file%"
echo Usuario: %USERNAME% >> "%report_file%"
echo Fecha: %date% %time% >> "%report_file%"

echo. >> "%report_file%"
echo === ESPACIO EN DISCO === >> "%report_file%"
dir C:\ /-c >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:security_report
cls
echo === REPORTE DE SEGURIDAD ===
echo.

set "report_file=security_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Seguridad - %date% %time% > "%report_file%"
echo. >> "%report_file%"

echo === PERMISOS DE USUARIO === >> "%report_file%"
whoami /priv >> "%report_file%"

echo. >> "%report_file%"
echo === COMANDOS RESTRINGIDOS === >> "%report_file%"
for /f "tokens=2 delims==" %%a in ('findstr "restricted_commands" "%config_file%"') do echo %%a >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:performance_analysis
cls
echo ========================================
echo    ANALISIS DE RENDIMIENTO
echo ========================================
echo.
echo 1. Analisis de uso de recursos
echo 2. Analisis de comandos
echo 3. Analisis de variables
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto resource_usage_analysis
if "%subopcion%"=="2" goto command_analysis
if "%subopcion%"=="3" goto variable_analysis
if "%subopcion%"=="4" goto menu_principal
goto performance_analysis

:resource_usage_analysis
cls
echo === ANALISIS DE USO DE RECURSOS ===
echo.

echo Analizando uso de recursos del shell...
echo - Memoria utilizada: 
tasklist | findstr "cmd.exe"
echo - Procesos activos:
tasklist | findstr "cmd"
echo Analisis completado.
pause
goto performance_analysis

:command_analysis
cls
echo === ANALISIS DE COMANDOS ===
echo.

echo Analizando comandos disponibles...
where cmd
where powershell
where reg
where sc
echo Analisis completado.
pause
goto performance_analysis

:variable_analysis
cls
echo === ANALISIS DE VARIABLES ===
echo.

echo Analizando variables de entorno...
echo Variables definidas:
set | findstr /i "PATH TEMP SYSTEMROOT"
echo Analisis completado.
pause
goto performance_analysis

:security_management
cls
echo ========================================
echo    GESTION DE SEGURIDAD
echo ========================================
echo.
echo 1. Validar comandos
echo 2. Gestionar comandos restringidos
echo 3. Configurar confirmaciones
echo 4. Verificar permisos
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto validate_commands
if "%subopcion%"=="2" goto manage_restricted_commands
if "%subopcion%"=="3" goto configure_confirmations
if "%subopcion%"=="4" goto verify_permissions
if "%subopcion%"=="5" goto menu_principal
goto security_management

:validate_commands
cls
echo === VALIDAR COMANDOS ===
echo.

set /p command="Comando a validar: "
if not "%command%"=="" (
    echo Validando comando: %command%
    where %command% >nul 2>&1
    if !errorlevel! equ 0 (
        echo [OK] Comando válido y disponible.
    ) else (
        echo [ERROR] Comando no válido o no disponible.
    )
) else (
    echo Comando no válido.
)
pause
goto security_management

:manage_restricted_commands
cls
echo === GESTIONAR COMANDOS RESTRINGIDOS ===
echo.

echo Comandos restringidos actuales:
for /f "tokens=2 delims==" %%a in ('findstr "restricted_commands" "%config_file%"') do echo %%a

echo.
set /p restricted_commands="Nuevos comandos restringidos (separados por comas): "

powershell -Command "(Get-Content '%config_file%') -replace 'restricted_commands=.*', 'restricted_commands=%restricted_commands%' | Set-Content '%config_file%'"

echo Comandos restringidos actualizados.
pause
goto security_management

:configure_confirmations
cls
echo === CONFIGURAR CONFIRMACIONES ===
echo.

set /p require_confirmation="Requerir confirmacion para comandos criticos (true/false): "

powershell -Command "(Get-Content '%config_file%') -replace 'require_confirmation=.*', 'require_confirmation=%require_confirmation%' | Set-Content '%config_file%'"

echo Configuracion de confirmaciones actualizada.
pause
goto security_management

:verify_permissions
cls
echo === VERIFICAR PERMISOS ===
echo.

echo Verificando permisos de usuario...
whoami /priv
echo Verificacion completada.
pause
goto security_management

:salir
echo Gracias por usar el Sistema de Gestion Avanzada de Shell
exit /b 0 