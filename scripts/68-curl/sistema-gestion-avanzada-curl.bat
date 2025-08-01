@echo off
setlocal enabledelayedexpansion
title SISTEMA DE GESTION AVANZADA CON CURL

REM Configuración inicial
set "config_file=curl_config.conf"
set "log_file=curl_advanced.log"
set "backup_dir=backups_curl"
set "download_dir=downloads"
set "scheduled_file=scheduled_downloads.txt"

REM Crear directorios si no existen
if not exist "%backup_dir%" mkdir "%backup_dir%"
if not exist "%download_dir%" mkdir "%download_dir%"

REM Crear archivo de configuración por defecto si no existe
if not exist "%config_file%" (
    echo # Configuracion del Sistema de Gestion Avanzada CURL > "%config_file%"
    echo # Archivo de configuracion > "%config_file%"
    echo. >> "%config_file%"
    echo [GENERAL] >> "%config_file%"
    echo log_level=INFO >> "%config_file%"
    echo download_dir=downloads >> "%config_file%"
    echo max_retries=3 >> "%config_file%"
    echo timeout=30 >> "%config_file%"
    echo. >> "%config_file%"
    echo [SECURITY] >> "%config_file%"
    echo verify_ssl=true >> "%config_file%"
    echo user_agent=AdvancedCURL/1.0 >> "%config_file%"
    echo follow_redirects=true >> "%config_file%"
    echo. >> "%config_file%"
    echo [SCHEDULING] >> "%config_file%"
    echo auto_schedule=false >> "%config_file%"
    echo schedule_interval=24 >> "%config_file%"
    echo. >> "%config_file%"
    echo [MONITORING] >> "%config_file%"
    echo enable_monitoring=true >> "%config_file%"
    echo monitor_interval=60 >> "%config_file%"
    echo alert_on_failure=true >> "%config_file%"
)

echo ========================================
echo  SISTEMA DE GESTION AVANZADA CON CURL
echo ========================================
echo.

:menu_principal
cls
echo ========================================
echo  SISTEMA DE GESTION AVANZADA CON CURL
echo ========================================
echo.
echo 1. Configuracion avanzada
echo 2. Descargas programadas
echo 3. Verificacion de integridad
echo 4. Gestion de sesiones
echo 5. Monitoreo en tiempo real
echo 6. Backup y restauracion
echo 7. Reportes avanzados
echo 8. Salir
echo.
set /p opcion="Seleccione una opcion: "

if "%opcion%"=="1" goto advanced_configuration
if "%opcion%"=="2" goto scheduled_downloads
if "%opcion%"=="3" goto integrity_verification
if "%opcion%"=="4" goto session_management
if "%opcion%"=="5" goto real_time_monitoring
if "%opcion%"=="6" goto backup_restoration
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
echo 3. Editar configuracion de seguridad
echo 4. Editar configuracion de programacion
echo 5. Editar configuracion de monitoreo
echo 6. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto view_config
if "%subopcion%"=="2" goto edit_general_config
if "%subopcion%"=="3" goto edit_security_config
if "%subopcion%"=="4" goto edit_scheduling_config
if "%subopcion%"=="5" goto edit_monitoring_config
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
set /p download_dir="Directorio de descargas: "
set /p max_retries="Maximo de reintentos: "
set /p timeout="Timeout en segundos: "

powershell -Command "(Get-Content '%config_file%') -replace 'log_level=.*', 'log_level=%log_level%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'download_dir=.*', 'download_dir=%download_dir%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'max_retries=.*', 'max_retries=%max_retries%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'timeout=.*', 'timeout=%timeout%' | Set-Content '%config_file%'"

echo Configuracion general actualizada.
pause
goto advanced_configuration

:edit_security_config
cls
echo === EDITAR CONFIGURACION DE SEGURIDAD ===
echo.
set /p verify_ssl="Verificar SSL (true/false): "
set /p user_agent="User-Agent: "
set /p follow_redirects="Seguir redirecciones (true/false): "

powershell -Command "(Get-Content '%config_file%') -replace 'verify_ssl=.*', 'verify_ssl=%verify_ssl%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'user_agent=.*', 'user_agent=%user_agent%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'follow_redirects=.*', 'follow_redirects=%follow_redirects%' | Set-Content '%config_file%'"

echo Configuracion de seguridad actualizada.
pause
goto advanced_configuration

:edit_scheduling_config
cls
echo === EDITAR CONFIGURACION DE PROGRAMACION ===
echo.
set /p auto_schedule="Programacion automatica (true/false): "
set /p schedule_interval="Intervalo de programacion (horas): "

powershell -Command "(Get-Content '%config_file%') -replace 'auto_schedule=.*', 'auto_schedule=%auto_schedule%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'schedule_interval=.*', 'schedule_interval=%schedule_interval%' | Set-Content '%config_file%'"

echo Configuracion de programacion actualizada.
pause
goto advanced_configuration

:edit_monitoring_config
cls
echo === EDITAR CONFIGURACION DE MONITOREO ===
echo.
set /p enable_monitoring="Habilitar monitoreo (true/false): "
set /p monitor_interval="Intervalo de monitoreo (segundos): "
set /p alert_on_failure="Alertar en fallos (true/false): "

powershell -Command "(Get-Content '%config_file%') -replace 'enable_monitoring=.*', 'enable_monitoring=%enable_monitoring%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'monitor_interval=.*', 'monitor_interval=%monitor_interval%' | Set-Content '%config_file%'"
powershell -Command "(Get-Content '%config_file%') -replace 'alert_on_failure=.*', 'alert_on_failure=%alert_on_failure%' | Set-Content '%config_file%'"

echo Configuracion de monitoreo actualizada.
pause
goto advanced_configuration

:scheduled_downloads
cls
echo ========================================
echo    DESCARGAS PROGRAMADAS
echo ========================================
echo.
echo 1. Crear descarga programada
echo 2. Listar descargas programadas
echo 3. Ejecutar descargas programadas
echo 4. Eliminar descarga programada
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto create_scheduled_download
if "%subopcion%"=="2" goto list_scheduled_downloads
if "%subopcion%"=="3" goto execute_scheduled_downloads
if "%subopcion%"=="4" goto delete_scheduled_download
if "%subopcion%"=="5" goto menu_principal
goto scheduled_downloads

:create_scheduled_download
cls
echo === CREAR DESCARGA PROGRAMADA ===
echo.
set /p url="Ingrese la URL: "
set /p filename="Ingrese el nombre del archivo: "
set /p schedule="Programacion (daily/weekly/monthly): "
set /p time="Hora (HH:MM): "

if not "%url%"=="" (
    echo Agregando descarga programada...
    echo %url%|%filename%|%schedule%|%time% >> "%scheduled_file%"
    echo Descarga programada creada.
) else (
    echo URL no valida.
)
pause
goto scheduled_downloads

:list_scheduled_downloads
cls
echo === LISTAR DESCARGAS PROGRAMADAS ===
echo.
if exist "%scheduled_file%" (
    echo Descargas programadas:
    type "%scheduled_file%"
) else (
    echo No hay descargas programadas.
)
pause
goto scheduled_downloads

:execute_scheduled_downloads
cls
echo === EJECUTAR DESCARGAS PROGRAMADAS ===
echo.
if exist "%scheduled_file%" (
    echo Ejecutando descargas programadas...
    for /f "tokens=1,2 delims=|" %%u in (%scheduled_file%) do (
        echo Descargando: %%u como %%v
        curl -o "%download_dir%\%%v" "%%u"
        if !errorlevel! equ 0 (
            echo Descarga exitosa: %%v
        ) else (
            echo Error en descarga: %%v
        )
    )
    echo Proceso de descargas programadas completado.
) else (
    echo No hay descargas programadas.
)
pause
goto scheduled_downloads

:delete_scheduled_download
cls
echo === ELIMINAR DESCARGA PROGRAMADA ===
echo.
set /p url="Ingrese la URL a eliminar: "
if not "%url%"=="" (
    if exist "%scheduled_file%" (
        echo Eliminando descarga programada...
        powershell -Command "(Get-Content '%scheduled_file%') | Where-Object { $_ -notmatch '%url%' } | Set-Content '%scheduled_file%'"
        echo Descarga programada eliminada.
    ) else (
        echo No hay descargas programadas.
    )
) else (
    echo URL no valida.
)
pause
goto scheduled_downloads

:integrity_verification
cls
echo ========================================
echo    VERIFICACION DE INTEGRIDAD
echo ========================================
echo.
echo 1. Verificar archivo descargado
echo 2. Comparar archivos
echo 3. Verificar checksum
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto verify_downloaded_file
if "%subopcion%"=="2" goto compare_files
if "%subopcion%"=="3" goto verify_checksum
if "%subopcion%"=="4" goto menu_principal
goto integrity_verification

:verify_downloaded_file
cls
echo === VERIFICAR ARCHIVO DESCARGADO ===
echo.
set /p filename="Ingrese el nombre del archivo: "
if exist "%download_dir%\%filename%" (
    echo Verificando archivo: %filename%
    echo Tamaño: 
    dir "%download_dir%\%filename%" | findstr "%filename%"
    echo Verificacion completada.
) else (
    echo Archivo no encontrado.
)
pause
goto integrity_verification

:compare_files
cls
echo === COMPARAR ARCHIVOS ===
echo.
set /p file1="Ingrese el primer archivo: "
set /p file2="Ingrese el segundo archivo: "
if exist "%file1%" (
    if exist "%file2%" (
        echo Comparando archivos...
        fc "%file1%" "%file2%"
        if !errorlevel! equ 0 (
            echo Los archivos son identicos.
        ) else (
            echo Los archivos son diferentes.
        )
    ) else (
        echo Segundo archivo no encontrado.
    )
) else (
    echo Primer archivo no encontrado.
)
pause
goto integrity_verification

:verify_checksum
cls
echo === VERIFICAR CHECKSUM ===
echo.
set /p filename="Ingrese el nombre del archivo: "
if exist "%download_dir%\%filename%" (
    echo Calculando checksum de: %filename%
    certutil -hashfile "%download_dir%\%filename%" MD5
    echo Verificacion de checksum completada.
) else (
    echo Archivo no encontrado.
)
pause
goto integrity_verification

:session_management
cls
echo ========================================
echo    GESTION DE SESIONES
echo ========================================
echo.
echo 1. Crear sesion
echo 2. Gestionar cookies
echo 3. Autenticacion
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto create_session
if "%subopcion%"=="2" goto manage_cookies
if "%subopcion%"=="3" goto authentication
if "%subopcion%"=="4" goto menu_principal
goto session_management

:create_session
cls
echo === CREAR SESION ===
echo.
set /p url="Ingrese la URL: "
set /p cookie_file="Ingrese el archivo de cookies: "
if not "%url%"=="" (
    echo Creando sesion con: %url%
    curl -c "%cookie_file%" "%url%"
    if !errorlevel! equ 0 (
        echo Sesion creada exitosamente.
    ) else (
        echo Error al crear sesion.
    )
) else (
    echo URL no valida.
)
pause
goto session_management

:manage_cookies
cls
echo === GESTIONAR COOKIES ===
echo.
set /p cookie_file="Ingrese el archivo de cookies: "
if exist "%cookie_file%" (
    echo Cookies actuales:
    type "%cookie_file%"
) else (
    echo Archivo de cookies no encontrado.
)
pause
goto session_management

:authentication
cls
echo === AUTENTICACION ===
echo.
set /p url="Ingrese la URL: "
set /p username="Ingrese el usuario: "
set /p password="Ingrese la contraseña: "
if not "%url%"=="" (
    echo Autenticando en: %url%
    curl -u "%username%:%password%" "%url%"
    if !errorlevel! equ 0 (
        echo Autenticacion exitosa.
    ) else (
        echo Error en autenticacion.
    )
) else (
    echo URL no valida.
)
pause
goto session_management

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
for /f "tokens=2 delims==" %%a in ('findstr "monitor_interval" "%config_file%"') do set "monitor_interval=%%a"
for /f "tokens=2 delims==" %%a in ('findstr "enable_monitoring" "%config_file%"') do set "enable_monitoring=%%a"

if "%enable_monitoring%"=="true" (
    echo === ESTADO DE RED ===
    ping -n 1 8.8.8.8 >nul
    if !errorlevel! equ 0 (
        echo [OK] Conexion a internet activa
    ) else (
        echo [ERROR] Sin conexion a internet
    )
    
    echo.
    echo === ARCHIVOS DESCARGADOS ===
    dir "%download_dir%\*.*" /b 2>nul | find /c /v ""
    echo archivos en directorio de descargas
    
    echo.
    echo === DESCARGAS PROGRAMADAS ===
    if exist "%scheduled_file%" (
        type "%scheduled_file%" | find /c /v ""
        echo descargas programadas
    ) else (
        echo No hay descargas programadas
    )
) else (
    echo Monitoreo deshabilitado.
)

timeout /t %monitor_interval% /nobreak >nul
goto monitoring_loop

:backup_restoration
cls
echo ========================================
echo    BACKUP Y RESTAURACION
echo ========================================
echo.
echo 1. Crear backup de configuracion
echo 2. Restaurar configuracion
echo 3. Crear backup de descargas
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto create_config_backup
if "%subopcion%"=="2" goto restore_config
if "%subopcion%"=="3" goto create_downloads_backup
if "%subopcion%"=="4" goto menu_principal
goto backup_restoration

:create_config_backup
cls
echo === CREAR BACKUP DE CONFIGURACION ===
echo.
set "backup_file=curl_config_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.conf"
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
dir "%backup_dir%\curl_config_backup_*.conf" /b
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

:create_downloads_backup
cls
echo === CREAR BACKUP DE DESCARGAS ===
echo.
set "backup_file=downloads_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip"
set "backup_file=%backup_file: =0%"

echo Creando backup de descargas...
if exist "%download_dir%" (
    powershell -Command "Compress-Archive -Path '%download_dir%\*' -DestinationPath '%backup_dir%\%backup_file%' -Force"
    if !errorlevel! equ 0 (
        echo Backup de descargas creado: %backup_dir%\%backup_file%
    ) else (
        echo Error al crear backup de descargas.
    )
) else (
    echo Directorio de descargas no encontrado.
)
pause
goto backup_restoration

:advanced_reports
cls
echo ========================================
echo    REPORTES AVANZADOS
echo ========================================
echo.
echo 1. Reporte de configuracion
echo 2. Reporte de descargas programadas
echo 3. Reporte de rendimiento
echo 4. Reporte de seguridad
echo 5. Reporte completo
echo 6. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto config_report
if "%subopcion%"=="2" goto scheduled_report
if "%subopcion%"=="3" goto performance_report
if "%subopcion%"=="4" goto security_report
if "%subopcion%"=="5" goto complete_report
if "%subopcion%"=="6" goto menu_principal
goto advanced_reports

:config_report
cls
echo === REPORTE DE CONFIGURACION ===
echo.
set "report_file=reporte_config_curl_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Configuracion CURL - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === CONFIGURACION ACTUAL === >> "%report_file%"
type "%config_file%" >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:scheduled_report
cls
echo === REPORTE DE DESCARGAS PROGRAMADAS ===
echo.
set "report_file=reporte_programadas_curl_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Descargas Programadas CURL - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

if exist "%scheduled_file%" (
    echo === DESCARGAS PROGRAMADAS === >> "%report_file%"
    type "%scheduled_file%" >> "%report_file%"
) else (
    echo No hay descargas programadas. >> "%report_file%"
)
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:performance_report
cls
echo === REPORTE DE RENDIMIENTO ===
echo.
set "report_file=reporte_rendimiento_curl_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Rendimiento CURL - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === INFORMACION DEL SISTEMA === >> "%report_file%"
curl --version >> "%report_file%"
echo. >> "%report_file%"

echo === ARCHIVOS DESCARGADOS === >> "%report_file%"
dir "%download_dir%\*.*" /b >> "%report_file%" 2>nul
echo. >> "%report_file%"

echo === ESTADO DE RED === >> "%report_file%"
ping -n 1 8.8.8.8 >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:security_report
cls
echo === REPORTE DE SEGURIDAD ===
echo.
set "report_file=reporte_seguridad_curl_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Seguridad CURL - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === CONFIGURACION DE SEGURIDAD === >> "%report_file%"
for /f "tokens=2 delims==" %%a in ('findstr "verify_ssl" "%config_file%"') do echo Verificar SSL: %%a >> "%report_file%"
for /f "tokens=2 delims==" %%a in ('findstr "user_agent" "%config_file%"') do echo User-Agent: %%a >> "%report_file%"
for /f "tokens=2 delims==" %%a in ('findstr "follow_redirects" "%config_file%"') do echo Seguir redirecciones: %%a >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto advanced_reports

:complete_report
cls
echo === REPORTE COMPLETO ===
echo.
set "report_file=reporte_completo_curl_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte Completo CURL - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === CONFIGURACION === >> "%report_file%"
type "%config_file%" >> "%report_file%"
echo. >> "%report_file%"

echo === DESCARGAS PROGRAMADAS === >> "%report_file%"
if exist "%scheduled_file%" (
    type "%scheduled_file%" >> "%report_file%"
) else (
    echo No hay descargas programadas. >> "%report_file%"
)
echo. >> "%report_file%"

echo === ARCHIVOS DESCARGADOS === >> "%report_file%"
dir "%download_dir%\*.*" /b >> "%report_file%" 2>nul
echo. >> "%report_file%"

echo === BACKUPS === >> "%report_file%"
dir "%backup_dir%\*.*" /b >> "%report_file%" 2>nul
echo. >> "%report_file%"

echo Reporte completo generado: %report_file%
pause
goto advanced_reports

:salir
echo Gracias por usar el Sistema de Gestion Avanzada con CURL
exit /b 0 