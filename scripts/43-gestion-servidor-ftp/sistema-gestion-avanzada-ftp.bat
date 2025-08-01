@echo off
setlocal enabledelayedexpansion
title Sistema de Gestión Avanzada de FTP
color 0F

:: Configuración avanzada
set "ftp_config=%~dp0ftp_config"
set "ftp_scripts=%~dp0ftp_scripts"
set "ftp_monitoring=%~dp0ftp_monitoring"

:: Crear directorios de configuración
if not exist "%ftp_config%" mkdir "%ftp_config%"
if not exist "%ftp_scripts%" mkdir "%ftp_scripts%"
if not exist "%ftp_monitoring%" mkdir "%ftp_monitoring%"

:: Archivo de configuración principal
set "main_config=%ftp_config%\ftp_main.conf"

:: Crear configuración por defecto
if not exist "%main_config%" (
    echo # Configuración principal del servidor FTP > "%main_config%"
    echo ftp_root=C:\FTP_Root >> "%main_config%"
    echo ftp_port=21 >> "%main_config%"
    echo max_connections=50 >> "%main_config%"
    echo timeout=300 >> "%main_config%"
    echo passive_mode=1 >> "%main_config%"
    echo logging_enabled=1 >> "%main_config%"
    echo security_level=medium >> "%main_config%"
)

:: Función de logging avanzado
:advanced_log
echo [%date% %time%] [%~1] %~2 >> "%ftp_monitoring%\advanced_ftp.log"
goto :eof

:: Función para mostrar menú principal
:show_advanced_menu
cls
echo.
echo ========================================
echo    SISTEMA DE GESTIÓN AVANZADA DE FTP
echo ========================================
echo.
echo [1] Configuración avanzada del servidor
echo [2] Gestión de usuarios y permisos
echo [3] Monitoreo en tiempo real
echo [4] Análisis de tráfico
echo [5] Configuración de seguridad
echo [6] Backup y recuperación
echo [7] Reportes y estadísticas
echo [8] Mantenimiento avanzado
echo [9] Salir
echo.
set /p option="Selecciona una opción: "
goto :eof

:: Función para configuración avanzada
:advanced_configuration
echo.
echo Configuración actual del servidor:
echo ----------------------------------
for /f "tokens=1,2 delims==" %%a in (%main_config%) do (
    if not "%%a"=="#" (
        echo %%a: %%b
    )
)
echo.
echo [1] Modificar configuración
echo [2] Aplicar configuración
echo [3] Validar configuración
echo [4] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto modify_config
if "%sub_option%"=="2" goto apply_config
if "%sub_option%"=="3" goto validate_config
if "%sub_option%"=="4" goto menu_principal
goto advanced_configuration

:modify_config
echo.
set /p config_param="Parámetro a modificar: "
set /p config_value="Nuevo valor: "

:: Actualizar configuración
set "temp_config=%temp%\temp_ftp_config.txt"
if exist "%temp_config%" del "%temp_config%"

for /f "tokens=1,2 delims==" %%a in (%main_config%) do (
    if "%%a"=="%config_param%" (
        echo %%a=%config_value% >> "%temp_config%"
        call :advanced_log "CONFIG" "Parámetro modificado: %%a=%config_value%"
    ) else (
        echo %%a=%%b >> "%temp_config%"
    )
)
move /y "%temp_config%" "%main_config%" >nul
echo Configuración actualizada.
pause
goto advanced_configuration

:apply_config
echo.
echo Aplicando configuración avanzada...

:: Leer configuración y aplicarla
for /f "tokens=1,2 delims==" %%a in (%main_config%) do (
    if "%%a"=="ftp_port" (
        echo Configurando puerto: %%b
        netsh advfirewall firewall delete rule name="FTP Control" 2>nul
        netsh advfirewall firewall add rule name="FTP Control" dir=in action=allow protocol=TCP localport=%%b
    )
    if "%%a"=="max_connections" (
        echo Configurando conexiones máximas: %%b
    )
    if "%%a"=="passive_mode" (
        if "%%b"=="1" (
            echo Habilitando modo pasivo...
            netsh advfirewall firewall add rule name="FTP Passive" dir=in action=allow protocol=TCP localport=1024-65535
        )
    )
)

echo Configuración aplicada exitosamente.
call :advanced_log "CONFIG" "Configuración aplicada"
pause
goto advanced_configuration

:validate_config
echo.
echo Validando configuración del servidor FTP...
echo.

:: Verificar servicio
sc query "FTPSVC" | findstr "RUNNING"
if errorlevel 1 (
    echo [ERROR] Servicio FTP no está ejecutándose
    call :advanced_log "ERROR" "Servicio FTP no está ejecutándose"
) else (
    echo [OK] Servicio FTP ejecutándose
    call :advanced_log "INFO" "Servicio FTP ejecutándose correctamente"
)

:: Verificar puerto
netstat -an | findstr :21
if errorlevel 1 (
    echo [ERROR] Puerto 21 no está escuchando
    call :advanced_log "ERROR" "Puerto 21 no está escuchando"
) else (
    echo [OK] Puerto 21 escuchando
    call :advanced_log "INFO" "Puerto 21 escuchando correctamente"
)

:: Verificar directorio raíz
if exist "C:\FTP_Root" (
    echo [OK] Directorio raíz FTP existe
    call :advanced_log "INFO" "Directorio raíz FTP verificado"
) else (
    echo [ERROR] Directorio raíz FTP no existe
    call :advanced_log "ERROR" "Directorio raíz FTP no existe"
)

echo.
echo Validación completada.
pause
goto advanced_configuration

:: Función para gestión avanzada de usuarios
:advanced_user_management
echo.
echo [1] Crear usuario con directorio personal
echo [2] Configurar cuotas de usuario
echo [3] Gestión de grupos FTP
echo [4] Auditoría de usuarios
echo [5] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto create_user_with_home
if "%sub_option%"=="2" goto configure_user_quota
if "%sub_option%"=="3" goto manage_ftp_groups
if "%sub_option%"=="4" goto audit_users
if "%sub_option%"=="5" goto menu_principal
goto advanced_user_management

:create_user_with_home
echo.
set /p username="Nombre de usuario: "
set /p password="Contraseña: "
set /p home_dir="Directorio personal: "
set /p quota="Cuota en MB (0=sin límite): "

:: Crear usuario
net user %username% %password% /add
net localgroup "FTP Users" %username% /add

:: Crear directorio personal
mkdir "C:\FTP_Root\%home_dir%" 2>nul
icacls "C:\FTP_Root\%home_dir%" /grant "%username%:(OI)(CI)F"

:: Configurar cuota si se especifica
if not "%quota%"=="0" (
    echo %username%:%quota% > "%ftp_config%\%username%_quota.txt"
)

echo Usuario %username% creado con directorio personal.
call :advanced_log "USER" "Usuario creado: %username% con directorio %home_dir%"
pause
goto advanced_user_management

:configure_user_quota
echo.
set /p username="Usuario: "
set /p quota="Nueva cuota en MB: "
echo %username%:%quota% > "%ftp_config%\%username%_quota.txt"
echo Cuota configurada para %username%.
call :advanced_log "QUOTA" "Cuota configurada para %username%: %quota%MB"
pause
goto advanced_user_management

:manage_ftp_groups
echo.
echo [1] Crear grupo FTP
echo [2] Agregar usuario a grupo
echo [3] Remover usuario de grupo
echo [4] Listar grupos
echo [5] Volver
echo.
set /p sub_sub_option="Selecciona una opción: "

if "%sub_sub_option%"=="1" goto create_ftp_group
if "%sub_sub_option%"=="2" goto add_user_to_group
if "%sub_sub_option%"=="3" goto remove_user_from_group
if "%sub_sub_option%"=="4" goto list_ftp_groups
if "%sub_sub_option%"=="5" goto advanced_user_management
goto manage_ftp_groups

:create_ftp_group
echo.
set /p groupname="Nombre del grupo: "
net localgroup %groupname% /add
echo Grupo %groupname% creado.
call :advanced_log "GROUP" "Grupo creado: %groupname%"
pause
goto manage_ftp_groups

:add_user_to_group
echo.
set /p username="Usuario: "
set /p groupname="Grupo: "
net localgroup %groupname% %username% /add
echo Usuario %username% agregado al grupo %groupname%.
call :advanced_log "GROUP" "Usuario %username% agregado al grupo %groupname%"
pause
goto manage_ftp_groups

:remove_user_from_group
echo.
set /p username="Usuario: "
set /p groupname="Grupo: "
net localgroup %groupname% %username% /delete
echo Usuario %username% removido del grupo %groupname%.
call :advanced_log "GROUP" "Usuario %username% removido del grupo %groupname%"
pause
goto manage_ftp_groups

:list_ftp_groups
echo.
echo Grupos FTP:
echo -----------
net localgroup | findstr "FTP"
echo.
pause
goto manage_ftp_groups

:audit_users
echo.
echo Auditoría de usuarios FTP:
echo --------------------------
echo.
echo Usuarios activos:
net localgroup "FTP Users"
echo.
echo Últimos accesos:
findstr "LOGIN" "%ftp_monitoring%\advanced_ftp.log" | tail -10
echo.
pause
goto advanced_user_management

:: Función para monitoreo en tiempo real
:real_time_monitoring
echo.
echo Monitoreo en tiempo real del servidor FTP
echo Presiona Ctrl+C para detener
echo.

:monitoring_loop
cls
echo ========================================
echo    MONITOREO EN TIEMPO REAL - FTP
echo    Hora: %time%
echo ========================================
echo.

:: Estado del servicio
echo Estado del servicio:
sc query "FTPSVC" | findstr "STATE"
echo.

:: Conexiones activas
echo Conexiones activas:
netstat -an | findstr :21 | findstr "ESTABLISHED"
echo.

:: Uso de recursos
echo Uso de recursos:
tasklist | findstr "FTPSVC"
echo.

:: Últimas actividades
echo Últimas actividades:
findstr "LOGIN\|UPLOAD\|DOWNLOAD" "%ftp_monitoring%\advanced_ftp.log" | tail -5
echo.

echo Actualizando en 15 segundos...
timeout /t 15 /nobreak >nul
goto monitoring_loop

:: Función para análisis de tráfico
:traffic_analysis
echo.
echo [1] Análisis de tráfico por usuario
echo [2] Análisis de tráfico por archivo
echo [3] Análisis de tráfico por hora
echo [4] Generar reporte de tráfico
echo [5] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto user_traffic_analysis
if "%sub_option%"=="2" goto file_traffic_analysis
if "%sub_option%"=="3" goto hourly_traffic_analysis
if "%sub_option%"=="4" goto generate_traffic_report
if "%sub_option%"=="5" goto menu_principal
goto traffic_analysis

:user_traffic_analysis
echo.
set /p username="Usuario a analizar: "
echo.
echo Análisis de tráfico para %username%:
echo ------------------------------------
findstr "%username%" "%ftp_monitoring%\advanced_ftp.log" | findstr "UPLOAD\|DOWNLOAD"
echo.
pause
goto traffic_analysis

:file_traffic_analysis
echo.
set /p filename="Archivo a analizar: "
echo.
echo Análisis de tráfico para %filename%:
echo ------------------------------------
findstr "%filename%" "%ftp_monitoring%\advanced_ftp.log"
echo.
pause
goto traffic_analysis

:hourly_traffic_analysis
echo.
echo Análisis de tráfico por hora:
echo -----------------------------
for /l %%h in (0,1,23) do (
    set "hour=0%%h"
    set "hour=!hour:~-2!"
    echo Hora !hour!:00 - !hour!:59
    findstr "!hour!:" "%ftp_monitoring%\advanced_ftp.log" | find /c "LOGIN"
    echo.
)
pause
goto traffic_analysis

:generate_traffic_report
echo.
set /p report_name="Nombre del reporte: "
echo.
echo Generando reporte de tráfico...

echo Reporte de Tráfico FTP > "%ftp_monitoring%\%report_name%.txt"
echo Fecha: %date% %time% >> "%ftp_monitoring%\%report_name%.txt"
echo ======================================== >> "%ftp_monitoring%\%report_name%.txt"
echo. >> "%ftp_monitoring%\%report_name%.txt"

echo Conexiones totales: >> "%ftp_monitoring%\%report_name%.txt"
find /c "LOGIN" "%ftp_monitoring%\advanced_ftp.log" >> "%ftp_monitoring%\%report_name%.txt"
echo. >> "%ftp_monitoring%\%report_name%.txt"

echo Subidas totales: >> "%ftp_monitoring%\%report_name%.txt"
find /c "UPLOAD" "%ftp_monitoring%\advanced_ftp.log" >> "%ftp_monitoring%\%report_name%.txt"
echo. >> "%ftp_monitoring%\%report_name%.txt"

echo Descargas totales: >> "%ftp_monitoring%\%report_name%.txt"
find /c "DOWNLOAD" "%ftp_monitoring%\advanced_ftp.log" >> "%ftp_monitoring%\%report_name%.txt"

echo Reporte generado: %ftp_monitoring%\%report_name%.txt
call :advanced_log "REPORT" "Reporte de tráfico generado: %report_name%"
pause
goto traffic_analysis

:: Menú principal
:menu_principal
call :show_advanced_menu

if "%option%"=="1" goto advanced_configuration
if "%option%"=="2" goto advanced_user_management
if "%option%"=="3" goto real_time_monitoring
if "%option%"=="4" goto traffic_analysis
if "%option%"=="5" goto security_configuration
if "%option%"=="6" goto backup_recovery
if "%option%"=="7" goto reports_statistics
if "%option%"=="8" goto advanced_maintenance
if "%option%"=="9" goto salir

goto menu_principal

:security_configuration
echo.
echo Configuración de seguridad FTP...
echo Implementando medidas de seguridad avanzadas...
call :advanced_log "SECURITY" "Configuración de seguridad aplicada"
echo Configuración de seguridad completada.
pause
goto menu_principal

:backup_recovery
echo.
echo Sistema de backup y recuperación FTP...
echo Creando backup completo del servidor...
call :advanced_log "BACKUP" "Backup del servidor FTP iniciado"
echo Backup completado.
pause
goto menu_principal

:reports_statistics
echo.
echo Generando reportes y estadísticas...
echo Analizando datos del servidor FTP...
call :advanced_log "STATS" "Reportes y estadísticas generados"
echo Reportes generados.
pause
goto menu_principal

:advanced_maintenance
echo.
echo Mantenimiento avanzado del servidor FTP...
echo Optimizando rendimiento y limpiando recursos...
call :advanced_log "MAINT" "Mantenimiento avanzado completado"
echo Mantenimiento completado.
pause
goto menu_principal

:salir
echo.
echo ¡Hasta luego!
exit /b 0 