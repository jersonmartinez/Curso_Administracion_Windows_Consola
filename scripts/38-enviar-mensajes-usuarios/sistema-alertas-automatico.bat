@echo off
title Sistema de Alertas Automático
color 0E

:: Verificar permisos de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Se requieren permisos de administrador
    pause
    exit /b 1
)

:: Variables del sistema
set "ALERT_LOG=alertas.log"
set "CONFIG_FILE=alertas.conf"

:: Crear archivo de configuración si no existe
if not exist "%CONFIG_FILE%" (
    echo Creando archivo de configuración de alertas...
    (
        echo # Configuración de Alertas Automáticas
        echo ALERTA_MANTENIMIENTO=18:00
        echo ALERTA_RESPALDO=17:00
        echo ALERTA_CIERRE=19:00
        echo MENSAJE_MANTENIMIENTO=Mantenimiento diario programado
        echo MENSAJE_RESPALDO=Realice el respaldo de sus archivos
        echo MENSAJE_CIERRE=El sistema se cerrará en 30 minutos
    ) > "%CONFIG_FILE%"
    echo Archivo de configuración creado: %CONFIG_FILE%
    echo Edita el archivo y ejecuta nuevamente el script
    pause
    exit /b 0
)

:: Función para logging de alertas
:log_alert
echo [%date% %time%] ALERTA: %~1 >> "%ALERT_LOG%"
goto :eof

:: Función para enviar alerta
:send_alert
set "message=%~1"
set "type=%~2"
echo Enviando alerta %type%: %message%
msg * "%message%"
call :log_alert "%type% - %message%"
goto :eof

:: Función para verificar hora de alertas
:check_alerts
for /f "tokens=1,2 delims==" %%a in (%CONFIG_FILE%) do (
    if "%%a"=="ALERTA_MANTENIMIENTO" set "hora_mantenimiento=%%b"
    if "%%a"=="ALERTA_RESPALDO" set "hora_respaldo=%%b"
    if "%%a"=="ALERTA_CIERRE" set "hora_cierre=%%b"
    if "%%a"=="MENSAJE_MANTENIMIENTO" set "msg_mantenimiento=%%b"
    if "%%a"=="MENSAJE_RESPALDO" set "msg_respaldo=%%b"
    if "%%a"=="MENSAJE_CIERRE" set "msg_cierre=%%b"
)

:: Obtener hora actual
for /f "tokens=1-3 delims=:." %%a in ("%time%") do (
    set "hora_actual=%%a:%%b"
)

:: Verificar si es hora de enviar alertas
if "%hora_actual%"=="%hora_mantenimiento%" (
    call :send_alert "%msg_mantenimiento%" "MANTENIMIENTO"
)
if "%hora_actual%"=="%hora_respaldo%" (
    call :send_alert "%msg_respaldo%" "RESPALDO"
)
if "%hora_actual%"=="%hora_cierre%" (
    call :send_alert "%msg_cierre%" "CIERRE"
)
goto :eof

:: Función para monitoreo continuo
:continuous_monitor
echo Sistema de Alertas Automático iniciado
echo Presiona Ctrl+C para detener
call :log_alert "Sistema de alertas iniciado"

:monitor_loop
call :check_alerts
timeout /t 60 /nobreak >nul
goto monitor_loop

:: Menú principal
:main_menu
cls
echo ========================================
echo    SISTEMA DE ALERTAS AUTOMÁTICO
echo ========================================
echo.
echo 1. Iniciar monitoreo automático
echo 2. Enviar alerta manual
echo 3. Ver configuración actual
echo 4. Editar configuración
echo 5. Ver historial de alertas
echo 6. Probar alertas
echo 0. Salir
echo.
set /p choice="Selecciona una opción (0-6): "

if "%choice%"=="1" (
    call :continuous_monitor
    goto main_menu
)
if "%choice%"=="2" (
    set /p mensaje="Mensaje de alerta: "
    call :send_alert "%mensaje%" "MANUAL"
    pause
    goto main_menu
)
if "%choice%"=="3" (
    echo Configuración actual:
    type "%CONFIG_FILE%"
    pause
    goto main_menu
)
if "%choice%"=="4" (
    notepad "%CONFIG_FILE%"
    goto main_menu
)
if "%choice%"=="5" (
    if exist "%ALERT_LOG%" (
        type "%ALERT_LOG%"
    ) else (
        echo No hay historial de alertas
    )
    pause
    goto main_menu
)
if "%choice%"=="6" (
    echo Enviando alerta de prueba...
    call :send_alert "Esta es una alerta de prueba del sistema" "PRUEBA"
    echo ✓ Alerta de prueba enviada
    pause
    goto main_menu
)
if "%choice%"=="0" (
    echo Sistema de alertas cerrado
    exit /b 0
)
goto main_menu 