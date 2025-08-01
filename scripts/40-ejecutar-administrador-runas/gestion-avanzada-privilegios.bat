@echo off
title Gestión Avanzada de Privilegios - RUNAS
color 0A

:: Verificar si ya se ejecuta como administrador
net session >nul 2>&1
if %errorlevel%==0 (
    echo ADVERTENCIA: Este script ya se ejecuta como administrador
    echo No es necesario usar RUNAS
    pause
)

:: Variables globales
set "LOG_FILE=privilegios.log"
set "CONFIG_FILE=privilegios.conf"

:: Función para logging
:log
echo [%date% %time%] %~1 >> "%LOG_FILE%"
goto :eof

:: Función para verificar usuario administrador
:check_admin_user
call :log "Verificando usuario administrador"
wmic useraccount where "name='administrator'" get name,disabled /format:csv | findstr "administrator" >nul
if %errorlevel%==0 (
    echo ✓ Usuario administrador encontrado
    call :log "Usuario administrador verificado"
) else (
    echo ✗ Usuario administrador no encontrado o deshabilitado
    call :log "Error: Usuario administrador no disponible"
)
goto :eof

:: Función para ejecutar con privilegios elevados
:run_elevated
set "app=%~1"
set "params=%~2"
echo Ejecutando %app% con privilegios elevados...
runas /user:administrator "%app% %params%"
if %errorlevel%==0 (
    echo ✓ Aplicación ejecutada con privilegios elevados
    call :log "Aplicación %app% ejecutada exitosamente"
) else (
    echo ✗ Error al ejecutar aplicación
    call :log "Error al ejecutar aplicación %app%"
)
goto :eof

:: Función para ejecutar con credenciales guardadas
:run_saved_credentials
set "app=%~1"
echo Ejecutando %app% con credenciales guardadas...
runas /user:administrator /savecred "%app%"
if %errorlevel%==0 (
    echo ✓ Aplicación ejecutada con credenciales guardadas
    call :log "Aplicación %app% ejecutada con credenciales guardadas"
) else (
    echo ✗ Error al ejecutar aplicación
    call :log "Error al ejecutar aplicación %app% con credenciales guardadas"
)
goto :eof

:: Función para ejecutar con perfil completo
:run_full_profile
set "app=%~1"
echo Ejecutando %app% con perfil completo...
runas /user:administrator /profile "%app%"
if %errorlevel%==0 (
    echo ✓ Aplicación ejecutada con perfil completo
    call :log "Aplicación %app% ejecutada con perfil completo"
) else (
    echo ✗ Error al ejecutar aplicación
    call :log "Error al ejecutar aplicación %app% con perfil completo"
)
goto :eof

:: Función para ejecutar aplicación de red
:run_network_app
set "domain=%~1"
set "user=%~2"
set "app=%~3"
echo Ejecutando %app% con credenciales de red...
runas /user:%domain%\%user% /netonly "%app%"
if %errorlevel%==0 (
    echo ✓ Aplicación ejecutada con credenciales de red
    call :log "Aplicación %app% ejecutada con credenciales de red"
) else (
    echo ✗ Error al ejecutar aplicación
    call :log "Error al ejecutar aplicación %app% con credenciales de red"
)
goto :eof

:: Función para herramientas administrativas
:admin_tools_menu
echo === HERRAMIENTAS ADMINISTRATIVAS ===
echo.
echo 1. Administrador de servicios
echo 2. Administrador de equipos
echo 3. Visor de eventos
echo 4. Editor de registro
echo 5. Política de grupo
echo 6. Administrador de dispositivos
echo 7. Configuración del sistema
echo 8. Volver al menú principal
echo.
set /p choice="Selecciona herramienta (1-8): "

if "%choice%"=="1" (
    call :run_saved_credentials "services.msc"
    call :log "Administrador de servicios ejecutado"
)
if "%choice%"=="2" (
    call :run_saved_credentials "compmgmt.msc"
    call :log "Administrador de equipos ejecutado"
)
if "%choice%"=="3" (
    call :run_saved_credentials "eventvwr.msc"
    call :log "Visor de eventos ejecutado"
)
if "%choice%"=="4" (
    call :run_saved_credentials "regedit.exe"
    call :log "Editor de registro ejecutado"
)
if "%choice%"=="5" (
    call :run_saved_credentials "gpedit.msc"
    call :log "Política de grupo ejecutada"
)
if "%choice%"=="6" (
    call :run_saved_credentials "devmgmt.msc"
    call :log "Administrador de dispositivos ejecutado"
)
if "%choice%"=="7" (
    call :run_saved_credentials "msconfig.exe"
    call :log "Configuración del sistema ejecutada"
)
if "%choice%"=="8" (
    goto :eof
)
pause
goto :eof

:: Función para ejecutar scripts administrativos
:run_admin_scripts
echo === SCRIPTS ADMINISTRATIVOS ===
echo.
echo 1. Script de limpieza del sistema
echo 2. Script de respaldo
echo 3. Script de instalación
echo 4. Script personalizado
echo.
set /p choice="Selecciona script (1-4): "

if "%choice%"=="1" (
    call :run_elevated "cmd.exe" "/c cleanmgr.exe"
    call :log "Script de limpieza ejecutado"
)
if "%choice%"=="2" (
    set /p backup_path="Ruta de respaldo: "
    call :run_elevated "cmd.exe" "/c robocopy C:\ %backup_path% /MIR"
    call :log "Script de respaldo ejecutado"
)
if "%choice%"=="3" (
    set /p installer="Ruta del instalador: "
    call :run_elevated "%installer%"
    call :log "Script de instalación ejecutado"
)
if "%choice%"=="4" (
    set /p script_path="Ruta del script: "
    call :run_elevated "cmd.exe" "/c %script_path%"
    call :log "Script personalizado ejecutado"
)
pause
goto :eof

:: Función para monitoreo de privilegios
:privilege_monitor
echo === MONITOREO DE PRIVILEGIOS ===
echo Presiona 'q' para salir, 'r' para refrescar
:monitor_loop
cls
echo [%date% %time%] - Monitoreo de Privilegios
echo ========================================
echo.
echo Usuario actual:
whoami
echo.
echo Verificando permisos de administrador:
net session >nul 2>&1
if %errorlevel%==0 (
    echo ✓ Tienes permisos de administrador
) else (
    echo ✗ No tienes permisos de administrador
)
echo.
echo Procesos con privilegios elevados:
tasklist /FI "USERNAME eq administrator" /FO TABLE
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
echo    GESTION AVANZADA DE PRIVILEGIOS
echo ========================================
echo.
echo 1. Verificar usuario administrador
echo 2. Ejecutar aplicación con privilegios elevados
echo 3. Ejecutar con credenciales guardadas
echo 4. Ejecutar con perfil completo
echo 5. Ejecutar aplicación de red
echo 6. Herramientas administrativas
echo 7. Scripts administrativos
echo 8. Monitoreo de privilegios
echo 9. Ver logs del sistema
echo 0. Salir
echo.
set /p choice="Selecciona una opción (0-9): "

if "%choice%"=="1" (
    call :check_admin_user
    pause
    goto main_menu
)
if "%choice%"=="2" (
    set /p app="Aplicación: "
    set /p params="Parámetros (opcional): "
    call :run_elevated "%app%" "%params%"
    pause
    goto main_menu
)
if "%choice%"=="3" (
    set /p app="Aplicación: "
    call :run_saved_credentials "%app%"
    pause
    goto main_menu
)
if "%choice%"=="4" (
    set /p app="Aplicación: "
    call :run_full_profile "%app%"
    pause
    goto main_menu
)
if "%choice%"=="5" (
    set /p domain="Dominio: "
    set /p user="Usuario: "
    set /p app="Aplicación: "
    call :run_network_app "%domain%" "%user%" "%app%"
    pause
    goto main_menu
)
if "%choice%"=="6" (
    call :admin_tools_menu
    goto main_menu
)
if "%choice%"=="7" (
    call :run_admin_scripts
    goto main_menu
)
if "%choice%"=="8" (
    call :privilege_monitor
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
    echo Gracias por usar el gestor avanzado de privilegios
    exit /b 0
)
goto main_menu 