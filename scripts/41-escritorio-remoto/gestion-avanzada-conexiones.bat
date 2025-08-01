@echo off
setlocal enabledelayedexpansion
title Gestión Avanzada de Escritorio Remoto
color 0A

echo.
echo ========================================
echo    GESTIÓN AVANZADA DE ESCRITORIO REMOTO
echo ========================================
echo.

:menu_principal
echo [1] Conectar a servidor
echo [2] Ver usuarios conectados
echo [3] Cerrar sesión de usuario
echo [4] Información de sesiones
echo [5] Configurar nueva conexión
echo [6] Monitoreo continuo
echo [7] Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto conectar
if "%opcion%"=="2" goto ver_usuarios
if "%opcion%"=="3" goto cerrar_sesion
if "%opcion%"=="4" goto info_sesiones
if "%opcion%"=="5" goto configurar
if "%opcion%"=="6" goto monitoreo
if "%opcion%"=="7" goto salir
goto menu_principal

:conectar
echo.
set /p servidor="Servidor (IP o nombre): "
set /p usuario="Usuario (opcional): "
set /p resolucion="Resolución (1920x1080, 1366x768, etc.): "

if "%usuario%"=="" (
    mstsc /v:%servidor% /w:!resolucion:~0,4! /h:!resolucion:~5,4!
) else (
    mstsc /v:%servidor% /u:%usuario% /w:!resolucion:~0,4! /h:!resolucion:~5,4!
)
goto menu_principal

:ver_usuarios
echo.
set /p servidor="Servidor: "
echo.
echo Usuarios conectados en %servidor%:
echo ----------------------------------------
quser /server:%servidor%
echo.
pause
goto menu_principal

:cerrar_sesion
echo.
set /p servidor="Servidor: "
set /p id_sesion="ID de sesión: "
echo.
echo Cerrando sesión %id_sesion% en %servidor%...
logoff %id_sesion% /server:%servidor%
echo Sesión cerrada.
pause
goto menu_principal

:info_sesiones
echo.
set /p servidor="Servidor: "
echo.
echo Información detallada de sesiones:
echo ----------------------------------------
query session /server:%servidor%
echo.
pause
goto menu_principal

:configurar
echo.
set /p nombre="Nombre de la conexión: "
set /p servidor="Servidor: "
set /p usuario="Usuario: "
set /p resolucion="Resolución: "

echo screen mode id:i:2 > "%nombre%.rdp"
echo use multimon:i:0 >> "%nombre%.rdp"
echo desktopwidth:i:!resolucion:~0,4! >> "%nombre%.rdp"
echo desktopheight:i:!resolucion:~5,4! >> "%nombre%.rdp"
echo session bpp:i:32 >> "%nombre%.rdp"
echo winposstr:s:0,1,0,0,800,600 >> "%nombre%.rdp"
echo compression:i:1 >> "%nombre%.rdp"
echo keyboardhook:i:2 >> "%nombre%.rdp"
echo audiocapturemode:i:0 >> "%nombre%.rdp"
echo videoplaybackmode:i:1 >> "%nombre%.rdp"
echo connection type:i:7 >> "%nombre%.rdp"
echo networkautodetect:i:1 >> "%nombre%.rdp"
echo bandwidthautodetect:i:1 >> "%nombre%.rdp"
echo displayconnectionbar:i:1 >> "%nombre%.rdp"
echo username:s:%usuario% >> "%nombre%.rdp"
echo full address:s:%servidor% >> "%nombre%.rdp"
echo prompt for credentials:i:1 >> "%nombre%.rdp"

echo Archivo de configuración creado: %nombre%.rdp
pause
goto menu_principal

:monitoreo
echo.
set /p servidor="Servidor: "
set /p intervalo="Intervalo de monitoreo (segundos): "
echo.
echo Monitoreando conexiones en %servidor%...
echo Presiona Ctrl+C para detener
echo.

:monitoreo_loop
cls
echo ========================================
echo    MONITOREO DE CONEXIONES REMOTAS
echo    Servidor: %servidor%
echo    Hora: %time%
echo ========================================
echo.
quser /server:%servidor%
echo.
echo Actualizando en %intervalo% segundos...
timeout /t %intervalo% /nobreak >nul
goto monitoreo_loop

:salir
echo.
echo ¡Hasta luego!
exit /b 0 