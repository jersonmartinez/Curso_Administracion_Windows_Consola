@echo off
title Gestión Avanzada de Redes Hospedadas
color 0B

:: Verificar permisos de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Este script requiere permisos de administrador
    echo Ejecuta como administrador y vuelve a intentar
    pause
    exit /b 1
)

:: Variables globales
set "CONFIG_FILE=red_hospedada.conf"
set "LOG_FILE=red_hospedada.log"

:: Función para logging
:log
echo [%date% %time%] %~1 >> "%LOG_FILE%"
goto :eof

:: Función para verificar compatibilidad
:check_compatibility
call :log "Verificando compatibilidad del sistema"
netsh wlan show drivers | findstr "Hosted network supported" >nul
if %errorlevel% neq 0 (
    echo ERROR: Tu adaptador no soporta redes hospedadas
    call :log "Error: Adaptador no compatible"
    pause
    exit /b 1
)
echo ✓ Sistema compatible con redes hospedadas
call :log "Sistema verificado como compatible"
goto :eof

:: Función para crear configuración
:create_config
echo === CONFIGURACIÓN DE RED HOSPEDADA ===
echo.
set /p SSID="Nombre de la red (SSID): "
set /p KEY="Contraseña (mínimo 8 caracteres): "
set /p MAX_CLIENTS="Máximo número de clientes (1-20): "
set /p AUTO_START="¿Iniciar automáticamente? (s/n): "

:: Guardar configuración
echo SSID=%SSID% > "%CONFIG_FILE%"
echo KEY=%KEY% >> "%CONFIG_FILE%"
echo MAX_CLIENTS=%MAX_CLIENTS% >> "%CONFIG_FILE%"
echo AUTO_START=%AUTO_START% >> "%CONFIG_FILE%"

call :log "Configuración guardada: %SSID%"
echo ✓ Configuración guardada en %CONFIG_FILE%
goto :eof

:: Función para aplicar configuración
:apply_config
if not exist "%CONFIG_FILE%" (
    echo ERROR: Archivo de configuración no encontrado
    goto :eof
)

for /f "tokens=1,2 delims==" %%a in (%CONFIG_FILE%) do set "%%a=%%b"

echo Aplicando configuración...
netsh wlan set hostednetwork mode=allow ssid="%SSID%" key="%KEY%"
if %errorlevel%==0 (
    echo ✓ Red configurada: %SSID%
    call :log "Red configurada exitosamente: %SSID%"
    
    if /i "%AUTO_START%"=="s" (
        netsh wlan start hostednetwork
        if %errorlevel%==0 (
            echo ✓ Red iniciada automáticamente
            call :log "Red iniciada automáticamente"
        )
    )
) else (
    echo ✗ Error al configurar la red
    call :log "Error al configurar red"
)
goto :eof

:: Función para monitoreo avanzado
:advanced_monitor
echo === MONITOREO AVANZADO ===
echo Presiona 'q' para salir, 'r' para refrescar
:monitor_loop
cls
echo [%date% %time%] - Monitoreo de Red Hospedada
echo ===========================================
netsh wlan show hostednetwork
echo.
echo Estadísticas de red:
netsh wlan show hostednetwork | findstr "Number of clients"
echo.
echo Comandos: q=salir, r=refrescar
choice /c qr /n /t 5 /d r >nul
if errorlevel 2 goto monitor_loop
if errorlevel 1 goto :eof
goto monitor_loop

:: Menú principal
:main_menu
cls
echo ========================================
echo    GESTION AVANZADA DE REDES HOSPEDADAS
echo ========================================
echo.
echo 1. Verificar compatibilidad del sistema
echo 2. Crear nueva configuración
echo 3. Aplicar configuración existente
echo 4. Iniciar red hospedada
echo 5. Detener red hospedada
echo 6. Estado de la red
echo 7. Monitoreo avanzado
echo 8. Configurar compartir de conexión
echo 9. Ver logs del sistema
echo 0. Salir
echo.
set /p choice="Selecciona una opción (0-9): "

if "%choice%"=="1" (
    call :check_compatibility
    pause
    goto main_menu
)
if "%choice%"=="2" (
    call :create_config
    pause
    goto main_menu
)
if "%choice%"=="3" (
    call :apply_config
    pause
    goto main_menu
)
if "%choice%"=="4" (
    netsh wlan start hostednetwork
    if %errorlevel%==0 (
        echo ✓ Red iniciada
        call :log "Red iniciada manualmente"
    ) else (
        echo ✗ Error al iniciar
        call :log "Error al iniciar red"
    )
    pause
    goto main_menu
)
if "%choice%"=="5" (
    netsh wlan stop hostednetwork
    if %errorlevel%==0 (
        echo ✓ Red detenida
        call :log "Red detenida manualmente"
    ) else (
        echo ✗ Error al detener
        call :log "Error al detener red"
    )
    pause
    goto main_menu
)
if "%choice%"=="6" (
    netsh wlan show hostednetwork
    pause
    goto main_menu
)
if "%choice%"=="7" (
    call :advanced_monitor
    goto main_menu
)
if "%choice%"=="8" (
    echo Configurando compartir de conexión...
    netsh interface set interface "Ethernet" sharing=enabled
    echo ✓ Compartir configurado
    call :log "Compartir de conexión configurado"
    pause
    goto main_menu
)
if "%choice%"=="9" (
    if exist "%LOG_FILE%" (
        type "%LOG_FILE%"
    ) else (
        echo No hay logs disponibles
    )
    pause
    goto main_menu
)
if "%choice%"=="0" (
    echo Gracias por usar el gestor avanzado
    exit /b 0
)
goto main_menu 