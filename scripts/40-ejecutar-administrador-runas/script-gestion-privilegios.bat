@echo off
title Gestión de Privilegios - RUNAS
color 0E

:menu
cls
echo ========================================
echo    GESTION DE PRIVILEGIOS - RUNAS
echo ========================================
echo.
echo 1. Ejecutar CMD como administrador
echo 2. Ejecutar aplicación específica
echo 3. Ejecutar con credenciales guardadas
echo 4. Ejecutar con perfil completo
echo 5. Ejecutar aplicación de red
echo 6. Ejecutar herramientas administrativas
echo 7. Verificar permisos actuales
echo 8. Salir
echo.
set /p opcion="Selecciona una opción (1-8): "

if "%opcion%"=="1" goto cmd_admin
if "%opcion%"=="2" goto app_specific
if "%opcion%"=="3" goto save_cred
if "%opcion%"=="4" goto full_profile
if "%opcion%"=="5" goto network_app
if "%opcion%"=="6" goto admin_tools
if "%opcion%"=="7" goto check_perms
if "%opcion%"=="8" goto salir
goto menu

:cmd_admin
cls
echo === CMD COMO ADMINISTRADOR ===
runas /user:administrador "cmd.exe"
if %errorlevel%==0 (
    echo ✓ CMD abierto como administrador
) else (
    echo ✗ Error al abrir CMD
)
pause
goto menu

:app_specific
cls
echo === APLICACIÓN ESPECÍFICA ===
set /p app="Ruta de la aplicación: "
runas /user:administrador "%app%"
if %errorlevel%==0 (
    echo ✓ Aplicación ejecutada
) else (
    echo ✗ Error al ejecutar aplicación
)
pause
goto menu

:save_cred
cls
echo === CREDENCIALES GUARDADAS ===
set /p app="Aplicación: "
runas /user:administrador /savecred "%app%"
echo ✓ Aplicación ejecutada con credenciales guardadas
pause
goto menu

:full_profile
cls
echo === PERFIL COMPLETO ===
set /p app="Aplicación: "
runas /user:administrador /profile "%app%"
echo ✓ Aplicación ejecutada con perfil completo
pause
goto menu

:network_app
cls
echo === APLICACIÓN DE RED ===
set /p domain="Dominio: "
set /p user="Usuario: "
set /p app="Aplicación: "
runas /user:%domain%\%user% /netonly "%app%"
echo ✓ Aplicación ejecutada con credenciales de red
pause
goto menu

:admin_tools
cls
echo === HERRAMIENTAS ADMINISTRATIVAS ===
echo 1. Administrador de servicios
echo 2. Administrador de equipos
echo 3. Visor de eventos
echo 4. Editor de registro
echo.
set /p tool="Selecciona herramienta (1-4): "
if "%tool%"=="1" runas /user:administrador /savecred "services.msc"
if "%tool%"=="2" runas /user:administrador /savecred "compmgmt.msc"
if "%tool%"=="3" runas /user:administrador /savecred "eventvwr.msc"
if "%tool%"=="4" runas /user:administrador /savecred "regedit.exe"
echo ✓ Herramienta ejecutada
pause
goto menu

:check_perms
cls
echo === VERIFICAR PERMISOS ===
net session >nul 2>&1
if %errorlevel%==0 (
    echo ✓ Tienes permisos de administrador
) else (
    echo ✗ No tienes permisos de administrador
)
pause
goto menu

:salir
echo Gracias por usar el gestor de privilegios
exit 