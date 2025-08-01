@echo off
title Sistema de Gestión de Credenciales
color 0B

:: Verificar permisos de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Se requieren permisos de administrador
    pause
    exit /b 1
)

:: Variables del sistema
set "CRED_LOG=credenciales.log"
set "CRED_FILE=credenciales.conf"

:: Crear archivo de configuración si no existe
if not exist "%CRED_FILE%" (
    echo Creando archivo de configuración de credenciales...
    (
        echo # Configuración de Credenciales
        echo ADMIN_USER=administrator
        echo DOMAIN_USER=dominio\usuario
        echo SAVE_CREDENTIALS=true
        echo AUTO_ELEVATE=false
        echo LOG_ACTIVITY=true
    ) > "%CRED_FILE%"
    echo Archivo de configuración creado: %CRED_FILE%
    echo Edita el archivo y ejecuta nuevamente el script
    pause
    exit /b 0
)

:: Función para logging de credenciales
:log_cred
echo [%date% %time%] CRED: %~1 >> "%CRED_LOG%"
goto :eof

:: Función para cargar configuración
:load_config
for /f "tokens=1,2 delims==" %%a in (%CRED_FILE%) do (
    if "%%a"=="ADMIN_USER" set "admin_user=%%b"
    if "%%a"=="DOMAIN_USER" set "domain_user=%%b"
    if "%%a"=="SAVE_CREDENTIALS" set "save_credentials=%%b"
    if "%%a"=="AUTO_ELEVATE" set "auto_elevate=%%b"
    if "%%a"=="LOG_ACTIVITY" set "log_activity=%%b"
)
goto :eof

:: Función para ejecutar con credenciales guardadas
:run_saved_creds
set "app=%~1"
call :load_config
call :log_cred "Ejecutando %app% con credenciales guardadas"
runas /user:%admin_user% /savecred "%app%"
if %errorlevel%==0 (
    echo ✓ Aplicación ejecutada con credenciales guardadas
    call :log_cred "Aplicación %app% ejecutada exitosamente"
) else (
    echo ✗ Error al ejecutar aplicación
    call :log_cred "Error al ejecutar aplicación %app%"
)
goto :eof

:: Función para ejecutar con credenciales de red
:run_network_creds
set "app=%~1"
call :load_config
call :log_cred "Ejecutando %app% con credenciales de red"
runas /user:%domain_user% /netonly "%app%"
if %errorlevel%==0 (
    echo ✓ Aplicación ejecutada con credenciales de red
    call :log_cred "Aplicación %app% ejecutada con credenciales de red"
) else (
    echo ✗ Error al ejecutar aplicación
    call :log_cred "Error al ejecutar aplicación %app% con credenciales de red"
)
goto :eof

:: Función para gestión de credenciales
:manage_credentials
echo === GESTIÓN DE CREDENCIALES ===
echo.
echo 1. Ver credenciales guardadas
echo 2. Limpiar credenciales guardadas
echo 3. Configurar credenciales automáticas
echo 4. Probar credenciales
echo.
set /p choice="Selecciona opción (1-4): "

if "%choice%"=="1" (
    echo Credenciales guardadas:
    cmdkey /list
    call :log_cred "Credenciales guardadas mostradas"
)
if "%choice%"=="2" (
    echo Limpiando credenciales guardadas...
    cmdkey /delete:*
    echo ✓ Credenciales limpiadas
    call :log_cred "Credenciales guardadas limpiadas"
)
if "%choice%"=="3" (
    echo Configurando credenciales automáticas...
    set /p user="Usuario: "
    set /p pass="Contraseña: "
    cmdkey /add:localhost /user:%user% /pass:%pass%
    echo ✓ Credenciales configuradas
    call :log_cred "Credenciales automáticas configuradas"
)
if "%choice%"=="4" (
    echo Probando credenciales...
    call :run_saved_creds "cmd.exe"
    call :log_cred "Prueba de credenciales ejecutada"
)
pause
goto :eof

:: Función para ejecución automática
:auto_execution
call :load_config
if /i "%auto_elevate%"=="true" (
    echo Ejecutando con elevación automática...
    set /p app="Aplicación: "
    call :run_saved_creds "%app%"
    call :log_cred "Ejecución automática de %app%"
) else (
    echo Elevación automática deshabilitada
    call :log_cred "Elevación automática deshabilitada"
)
goto :eof

:: Menú principal
:main_menu
cls
echo ========================================
echo    SISTEMA DE GESTIÓN DE CREDENCIALES
echo ========================================
echo.
echo 1. Ejecutar con credenciales guardadas
echo 2. Ejecutar con credenciales de red
echo 3. Gestión de credenciales
echo 4. Ejecución automática
echo 5. Ver configuración actual
echo 6. Editar configuración
echo 7. Ver historial de credenciales
echo 8. Probar sistema
echo 0. Salir
echo.
set /p choice="Selecciona una opción (0-8): "

if "%choice%"=="1" (
    set /p app="Aplicación: "
    call :run_saved_creds "%app%"
    pause
    goto main_menu
)
if "%choice%"=="2" (
    set /p app="Aplicación: "
    call :run_network_creds "%app%"
    pause
    goto main_menu
)
if "%choice%"=="3" (
    call :manage_credentials
    goto main_menu
)
if "%choice%"=="4" (
    call :auto_execution
    pause
    goto main_menu
)
if "%choice%"=="5" (
    echo Configuración actual:
    type "%CRED_FILE%"
    call :log_cred "Configuración mostrada"
    pause
    goto main_menu
)
if "%choice%"=="6" (
    notepad "%CRED_FILE%"
    call :log_cred "Configuración editada"
    goto main_menu
)
if "%choice%"=="7" (
    if exist "%CRED_LOG%" (
        type "%CRED_LOG%"
    ) else (
        echo No hay historial de credenciales
    )
    pause
    goto main_menu
)
if "%choice%"=="8" (
    echo Probando sistema de credenciales...
    call :run_saved_creds "cmd.exe"
    echo ✓ Sistema probado correctamente
    call :log_cred "Sistema probado manualmente"
    pause
    goto main_menu
)
if "%choice%"=="0" (
    echo Sistema de gestión de credenciales cerrado
    exit /b 0
)
goto main_menu 