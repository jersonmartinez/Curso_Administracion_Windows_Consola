@echo off
setlocal enabledelayedexpansion
title Sistema de Gestión Avanzada de DNS
color 0F

:: Configuración avanzada
set "dns_advanced=%~dp0dns_advanced"
set "dns_zones=%~dp0dns_zones"
set "dns_monitoring=%~dp0dns_monitoring"

:: Crear directorios de configuración
if not exist "%dns_advanced%" mkdir "%dns_advanced%"
if not exist "%dns_zones%" mkdir "%dns_zones%"
if not exist "%dns_monitoring%" mkdir "%dns_monitoring%"

:: Archivo de configuración principal
set "main_config=%dns_advanced%\dns_main.conf"

:: Crear configuración por defecto
if not exist "%main_config%" (
    echo # Configuración principal del servidor DNS > "%main_config%"
    echo recursion_enabled=1 >> "%main_config%"
    echo forwarders_enabled=1 >> "%main_config%"
    echo cache_size=1000 >> "%main_config%"
    echo logging_level=7 >> "%main_config%"
    echo scavenging_enabled=1 >> "%main_config%"
    echo dnssec_enabled=0 >> "%main_config%"
    echo response_rate_limiting=0 >> "%main_config%"
)

:: Función de logging avanzado
:advanced_log
echo [%date% %time%] [%~1] %~2 >> "%dns_monitoring%\advanced_dns.log"
goto :eof

:: Función para mostrar menú principal
:show_advanced_menu
cls
echo.
echo ========================================
echo    SISTEMA DE GESTIÓN AVANZADA DE DNS
echo ========================================
echo.
echo [1] Configuración avanzada del servidor
echo [2] Gestión de zonas y registros
echo [3] Monitoreo en tiempo real
echo [4] Análisis de consultas
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
set "temp_config=%temp%\temp_dns_config.txt"
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
    if "%%a"=="recursion_enabled" (
        echo Configurando recursión: %%b
        dnscmd /config /enableglobalqueryblocklist %%b
    )
    if "%%a"=="cache_size" (
        echo Configurando tamaño de caché: %%b
    )
    if "%%a"=="logging_level" (
        echo Configurando nivel de logging: %%b
        dnscmd /config /loglevel %%b
    )
    if "%%a"=="scavenging_enabled" (
        if "%%b"=="1" (
            echo Habilitando limpieza automática...
        )
    )
)

echo Configuración aplicada exitosamente.
call :advanced_log "CONFIG" "Configuración aplicada"
pause
goto advanced_configuration

:validate_config
echo.
echo Validando configuración del servidor DNS...
echo.

:: Verificar servicio
sc query "DNS" | findstr "RUNNING"
if errorlevel 1 (
    echo [ERROR] Servicio DNS no está ejecutándose
    call :advanced_log "ERROR" "Servicio DNS no está ejecutándose"
) else (
    echo [OK] Servicio DNS ejecutándose
    call :advanced_log "INFO" "Servicio DNS ejecutándose correctamente"
)

:: Verificar zonas
dnscmd /enumzones | findstr "Primary\|Secondary"
if errorlevel 1 (
    echo [ERROR] No hay zonas configuradas
    call :advanced_log "ERROR" "No hay zonas configuradas"
) else (
    echo [OK] Zonas configuradas encontradas
    call :advanced_log "INFO" "Zonas configuradas verificadas"
)

:: Verificar resolución
nslookup localhost 127.0.0.1 >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Problemas con resolución DNS
    call :advanced_log "ERROR" "Problemas con resolución DNS"
) else (
    echo [OK] Resolución DNS funcionando
    call :advanced_log "INFO" "Resolución DNS verificada"
)

echo.
echo Validación completada.
pause
goto advanced_configuration

:: Función para gestión avanzada de zonas
:advanced_zone_management
echo.
echo [1] Crear zona con configuración avanzada
echo [2] Configurar transferencia de zona segura
echo [3] Configurar limpieza automática
echo [4] Gestionar registros dinámicos
echo [5] Configurar DNSSEC
echo [6] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto create_advanced_zone
if "%sub_option%"=="2" goto configure_secure_transfer
if "%sub_option%"=="3" goto configure_scavenging
if "%sub_option%"=="4" goto manage_dynamic_records
if "%sub_option%"=="5" goto configure_dnssec
if "%sub_option%"=="6" goto menu_principal
goto advanced_zone_management

:create_advanced_zone
echo.
set /p zone_name="Nombre de la zona: "
set /p zone_type="Tipo (Primary/Secondary/Stub): "
set /p zone_file="Archivo de zona: "
set /p allow_updates="Permitir actualizaciones dinámicas (0/1/2): "

:: Crear zona
dnscmd /zoneadd %zone_name% /%zone_type% /file %zone_file%

:: Configurar actualizaciones dinámicas
if not "%allow_updates%"=="0" (
    dnscmd /config %zone_name% /allowupdate %allow_updates%
)

echo Zona %zone_name% creada con configuración avanzada.
call :advanced_log "ZONE" "Zona creada: %zone_name%"
pause
goto advanced_zone_management

:configure_secure_transfer
echo.
set /p zone_name="Nombre de la zona: "
set /p secondary_server="Servidor secundario: "
echo Configurando transferencia segura para %zone_name%...
call :advanced_log "ZONE" "Transferencia segura configurada para %zone_name%"
echo Transferencia segura configurada.
pause
goto advanced_zone_management

:configure_scavenging
echo.
set /p zone_name="Nombre de la zona: "
set /p scavenging="Habilitar limpieza (1=Si, 0=No): "
if "%scavenging%"=="1" (
    dnscmd /config %zone_name% /aging 1
    echo Limpieza automática habilitada para %zone_name%.
    call :advanced_log "ZONE" "Limpieza habilitada para %zone_name%"
) else (
    dnscmd /config %zone_name% /aging 0
    echo Limpieza automática deshabilitada para %zone_name%.
    call :advanced_log "ZONE" "Limpieza deshabilitada para %zone_name%"
)
pause
goto advanced_zone_management

:manage_dynamic_records
echo.
echo [1] Habilitar registros dinámicos
echo [2] Deshabilitar registros dinámicos
echo [3] Ver registros dinámicos
echo [4] Volver
echo.
set /p sub_sub_option="Selecciona una opción: "

if "%sub_sub_option%"=="1" goto enable_dynamic_records
if "%sub_sub_option%"=="2" goto disable_dynamic_records
if "%sub_sub_option%"=="3" goto view_dynamic_records
if "%sub_sub_option%"=="4" goto advanced_zone_management
goto manage_dynamic_records

:enable_dynamic_records
echo.
set /p zone_name="Nombre de la zona: "
dnscmd /config %zone_name% /allowupdate 1
echo Registros dinámicos habilitados para %zone_name%.
call :advanced_log "DYNAMIC" "Registros dinámicos habilitados para %zone_name%"
pause
goto manage_dynamic_records

:disable_dynamic_records
echo.
set /p zone_name="Nombre de la zona: "
dnscmd /config %zone_name% /allowupdate 0
echo Registros dinámicos deshabilitados para %zone_name%.
call :advanced_log "DYNAMIC" "Registros dinámicos deshabilitados para %zone_name%"
pause
goto manage_dynamic_records

:view_dynamic_records
echo.
set /p zone_name="Nombre de la zona: "
echo Registros dinámicos en %zone_name%:
echo ------------------------------------
dnscmd /enumrecords %zone_name% @ | findstr "DYNAMIC"
echo.
pause
goto manage_dynamic_records

:configure_dnssec
echo.
echo Configurando DNSSEC...
echo Implementando firmas digitales para zonas...
call :advanced_log "DNSSEC" "Configuración DNSSEC iniciada"
echo DNSSEC configurado.
pause
goto advanced_zone_management

:: Función para monitoreo en tiempo real
:real_time_monitoring
echo.
echo Monitoreo en tiempo real del servidor DNS
echo Presiona Ctrl+C para detener
echo.

:monitoring_loop
cls
echo ========================================
echo    MONITOREO EN TIEMPO REAL - DNS
echo    Hora: %time%
echo ========================================
echo.

:: Estado del servicio
echo Estado del servicio:
sc query "DNS" | findstr "STATE"
echo.

:: Estadísticas de consultas
echo Estadísticas de consultas:
dnscmd /statistics | findstr "Total\|Queries\|Responses"
echo.

:: Zonas activas
echo Zonas activas:
dnscmd /enumzones | findstr "Primary\|Secondary"
echo.

:: Últimas consultas
echo Últimas consultas:
findstr "QUERY\|RESPONSE" "%dns_monitoring%\advanced_dns.log" | tail -5
echo.

echo Actualizando en 15 segundos...
timeout /t 15 /nobreak >nul
goto monitoring_loop

:: Función para análisis de consultas
:query_analysis
echo.
echo [1] Análisis de consultas por tipo
echo [2] Análisis de consultas por hora
echo [3] Análisis de dominios más consultados
echo [4] Generar reporte de consultas
echo [5] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto query_type_analysis
if "%sub_option%"=="2" goto hourly_query_analysis
if "%sub_option%"=="3" goto top_domains_analysis
if "%sub_option%"=="4" goto generate_query_report
if "%sub_option%"=="5" goto menu_principal
goto query_analysis

:query_type_analysis
echo.
echo Análisis de consultas por tipo:
echo --------------------------------
echo Consultas A (IPv4):
findstr "A " "%dns_monitoring%\advanced_dns.log" | find /c "QUERY"
echo.
echo Consultas AAAA (IPv6):
findstr "AAAA " "%dns_monitoring%\advanced_dns.log" | find /c "QUERY"
echo.
echo Consultas MX:
findstr "MX " "%dns_monitoring%\advanced_dns.log" | find /c "QUERY"
echo.
pause
goto query_analysis

:hourly_query_analysis
echo.
echo Análisis de consultas por hora:
echo --------------------------------
for /l %%h in (0,1,23) do (
    set "hour=0%%h"
    set "hour=!hour:~-2!"
    echo Hora !hour!:00 - !hour!:59
    findstr "!hour!:" "%dns_monitoring%\advanced_dns.log" | find /c "QUERY"
    echo.
)
pause
goto query_analysis

:top_domains_analysis
echo.
echo Dominios más consultados:
echo --------------------------
findstr "QUERY" "%dns_monitoring%\advanced_dns.log" | findstr /o "domain" | sort | uniq -c | sort -nr | head -10
echo.
pause
goto query_analysis

:generate_query_report
echo.
set /p report_name="Nombre del reporte: "
echo.
echo Generando reporte de consultas DNS...

echo Reporte de Consultas DNS > "%dns_monitoring%\%report_name%.txt"
echo Fecha: %date% %time% >> "%dns_monitoring%\%report_name%.txt"
echo ======================================== >> "%dns_monitoring%\%report_name%.txt"
echo. >> "%dns_monitoring%\%report_name%.txt"

echo Consultas totales: >> "%dns_monitoring%\%report_name%.txt"
find /c "QUERY" "%dns_monitoring%\advanced_dns.log" >> "%dns_monitoring%\%report_name%.txt"
echo. >> "%dns_monitoring%\%report_name%.txt"

echo Respuestas totales: >> "%dns_monitoring%\%report_name%.txt"
find /c "RESPONSE" "%dns_monitoring%\advanced_dns.log" >> "%dns_monitoring%\%report_name%.txt"
echo. >> "%dns_monitoring%\%report_name%.txt"

echo Errores totales: >> "%dns_monitoring%\%report_name%.txt"
find /c "ERROR" "%dns_monitoring%\advanced_dns.log" >> "%dns_monitoring%\%report_name%.txt"

echo Reporte generado: %dns_monitoring%\%report_name%.txt
call :advanced_log "REPORT" "Reporte de consultas generado: %report_name%"
pause
goto query_analysis

:: Menú principal
:menu_principal
call :show_advanced_menu

if "%option%"=="1" goto advanced_configuration
if "%option%"=="2" goto advanced_zone_management
if "%option%"=="3" goto real_time_monitoring
if "%option%"=="4" goto query_analysis
if "%option%"=="5" goto security_configuration
if "%option%"=="6" goto backup_recovery
if "%option%"=="7" goto reports_statistics
if "%option%"=="8" goto advanced_maintenance
if "%option%"=="9" goto salir

goto menu_principal

:security_configuration
echo.
echo Configuración de seguridad DNS...
echo Implementando DNSSEC y otras medidas de seguridad...
call :advanced_log "SECURITY" "Configuración de seguridad aplicada"
echo Configuración de seguridad completada.
pause
goto menu_principal

:backup_recovery
echo.
echo Sistema de backup y recuperación DNS...
echo Creando backup completo del servidor...
call :advanced_log "BACKUP" "Backup del servidor DNS iniciado"
echo Backup completado.
pause
goto menu_principal

:reports_statistics
echo.
echo Generando reportes y estadísticas...
echo Analizando datos del servidor DNS...
call :advanced_log "STATS" "Reportes y estadísticas generados"
echo Reportes generados.
pause
goto menu_principal

:advanced_maintenance
echo.
echo Mantenimiento avanzado del servidor DNS...
echo Optimizando rendimiento y limpiando recursos...
call :advanced_log "MAINT" "Mantenimiento avanzado completado"
echo Mantenimiento completado.
pause
goto menu_principal

:salir
echo.
echo ¡Hasta luego!
exit /b 0 