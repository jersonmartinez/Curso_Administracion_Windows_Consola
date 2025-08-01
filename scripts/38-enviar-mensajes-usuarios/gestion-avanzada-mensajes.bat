@echo off
title Gestión Avanzada de Mensajes de Red
color 0D

:: Verificar permisos de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Este script requiere permisos de administrador
    echo Ejecuta como administrador y vuelve a intentar
    pause
    exit /b 1
)

:: Variables globales
set "LOG_FILE=mensajes.log"
set "CONFIG_FILE=mensajes.conf"

:: Función para logging
:log
echo [%date% %time%] %~1 >> "%LOG_FILE%"
goto :eof

:: Función para verificar conectividad
:check_connectivity
call :log "Verificando conectividad de red"
ping -n 1 8.8.8.8 >nul
if %errorlevel% neq 0 (
    echo ERROR: No hay conectividad de red
    call :log "Error: Sin conectividad de red"
    pause
    exit /b 1
)
echo ✓ Conectividad de red verificada
call :log "Conectividad verificada correctamente"
goto :eof

:: Función para obtener usuarios conectados
:get_connected_users
call :log "Obteniendo lista de usuarios conectados"
query user > temp_users.txt
echo Usuarios conectados:
type temp_users.txt
call :log "Lista de usuarios obtenida"
goto :eof

:: Función para enviar mensaje masivo
:send_mass_message
set /p message="Mensaje a enviar: "
set /p confirm="¿Confirmar envío masivo? (s/n): "
if /i not "%confirm%"=="s" goto :eof

call :log "Iniciando envío masivo de mensajes"
set "sent=0"
set "failed=0"

for /f "skip=1 tokens=1" %%u in (temp_users.txt) do (
    echo Enviando a: %%u
    msg %%u "%message%"
    if !errorlevel!==0 (
        echo ✓ Enviado a %%u
        set /a sent+=1
        call :log "Mensaje enviado exitosamente a %%u"
    ) else (
        echo ✗ Error enviando a %%u
        set /a failed+=1
        call :log "Error enviando mensaje a %%u"
    )
)

echo.
echo ========================================
echo RESUMEN DE ENVÍO MASIVO
echo ========================================
echo Mensajes enviados: %sent%
echo Errores: %failed%
echo Total: %sent% + %failed%
call :log "Envío masivo completado - Enviados: %sent%, Errores: %failed%"
goto :eof

:: Función para mensajes programados
:scheduled_messages
echo === MENSAJES PROGRAMADOS ===
echo.
echo 1. Programar mensaje único
echo 2. Programar mensaje recurrente
echo 3. Ver mensajes programados
echo 4. Cancelar mensaje programado
echo.
set /p choice="Selecciona opción (1-4): "

if "%choice%"=="1" (
    set /p time="Hora (HH:MM): "
    set /p message="Mensaje: "
    at %time% msg * "%message%"
    echo ✓ Mensaje programado para las %time%
    call :log "Mensaje programado para las %time%"
)
if "%choice%"=="2" (
    set /p days="Días (LUN,MAR,MIE,JUE,VIE,SAB,DOM): "
    set /p time="Hora (HH:MM): "
    set /p message="Mensaje: "
    at %time% /every:%days% msg * "%message%"
    echo ✓ Mensaje recurrente programado
    call :log "Mensaje recurrente programado"
)
if "%choice%"=="3" (
    at
    call :log "Mostrando mensajes programados"
)
if "%choice%"=="4" (
    at
    set /p id="ID del mensaje a cancelar: "
    at %id% /delete
    echo ✓ Mensaje cancelado
    call :log "Mensaje %id% cancelado"
)
pause
goto :eof

:: Función para plantillas de mensajes
:message_templates
echo === PLANTILLAS DE MENSAJES ===
echo.
echo 1. Mantenimiento programado
echo 2. Actualización del sistema
echo 3. Alerta de seguridad
echo 4. Recordatorio de respaldo
echo 5. Mensaje personalizado
echo.
set /p template="Selecciona plantilla (1-5): "

if "%template%"=="1" (
    set /p time="Hora del mantenimiento: "
    set message="Mantenimiento programado: El sistema se reiniciará a las %time%. Guarde su trabajo."
)
if "%template%"=="2" (
    set message="Actualización del sistema: Se aplicarán actualizaciones importantes. El equipo se reiniciará automáticamente."
)
if "%template%"=="3" (
    set message="ALERTA DE SEGURIDAD: Se ha detectado actividad sospechosa. Contacte al administrador inmediatamente."
)
if "%template%"=="4" (
    set message="Recordatorio: Realice el respaldo de sus archivos importantes antes del final del día."
)
if "%template%"=="5" (
    set /p message="Mensaje personalizado: "
)

echo Mensaje preparado: %message%
set /p send="¿Enviar mensaje? (s/n): "
if /i "%send%"=="s" (
    msg * "%message%"
    echo ✓ Mensaje enviado
    call :log "Mensaje de plantilla enviado"
)
goto :eof

:: Función para monitoreo de mensajes
:message_monitor
echo === MONITOREO DE MENSAJES ===
echo Presiona 'q' para salir, 'r' para refrescar
:monitor_loop
cls
echo [%date% %time%] - Monitoreo de Mensajes
echo ======================================
echo.
echo Últimos mensajes enviados:
if exist "%LOG_FILE%" (
    tail -10 "%LOG_FILE%"
) else (
    echo No hay registros de mensajes
)
echo.
echo Usuarios actualmente conectados:
query user
echo.
echo Comandos: q=salir, r=refrescar
choice /c qr /n /t 10 /d r >nul
if errorlevel 2 goto monitor_loop
if errorlevel 1 goto :eof
goto monitor_loop

:: Menú principal
:main_menu
cls
echo ========================================
echo    GESTION AVANZADA DE MENSAJES
echo ========================================
echo.
echo 1. Verificar conectividad de red
echo 2. Ver usuarios conectados
echo 3. Enviar mensaje masivo
echo 4. Mensajes programados
echo 5. Plantillas de mensajes
echo 6. Monitoreo de mensajes
echo 7. Ver logs del sistema
echo 8. Limpiar archivos temporales
echo 0. Salir
echo.
set /p choice="Selecciona una opción (0-8): "

if "%choice%"=="1" (
    call :check_connectivity
    pause
    goto main_menu
)
if "%choice%"=="2" (
    call :get_connected_users
    pause
    goto main_menu
)
if "%choice%"=="3" (
    call :send_mass_message
    pause
    goto main_menu
)
if "%choice%"=="4" (
    call :scheduled_messages
    goto main_menu
)
if "%choice%"=="5" (
    call :message_templates
    pause
    goto main_menu
)
if "%choice%"=="6" (
    call :message_monitor
    goto main_menu
)
if "%choice%"=="7" (
    if exist "%LOG_FILE%" (
        type "%LOG_FILE%"
    ) else (
        echo No hay logs disponibles
    )
    pause
    goto main_menu
)
if "%choice%"=="8" (
    if exist "temp_users.txt" del "temp_users.txt"
    echo Archivos temporales limpiados
    call :log "Archivos temporales limpiados"
    pause
    goto main_menu
)
if "%choice%"=="0" (
    echo Gracias por usar el gestor avanzado de mensajes
    exit /b 0
)
goto main_menu 