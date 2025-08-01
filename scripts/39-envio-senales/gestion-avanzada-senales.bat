@echo off
title Gestión Avanzada de Señales de Procesos
color 0A

:: Verificar permisos de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Este script requiere permisos de administrador
    echo Ejecuta como administrador y vuelve a intentar
    pause
    exit /b 1
)

:: Variables globales
set "LOG_FILE=señales.log"
set "CONFIG_FILE=señales.conf"

:: Función para logging
:log
echo [%date% %time%] %~1 >> "%LOG_FILE%"
goto :eof

:: Función para verificar proceso
:check_process
set "pid=%~1"
tasklist /FI "PID eq %pid%" >nul 2>&1
if %errorlevel%==0 (
    echo ✓ Proceso %pid% encontrado
    call :log "Proceso %pid% verificado como existente"
) else (
    echo ✗ Proceso %pid% no encontrado
    call :log "Error: Proceso %pid% no encontrado"
)
goto :eof

:: Función para obtener información del proceso
:get_process_info
set "pid=%~1"
echo Obteniendo información del proceso %pid%...
for /f "tokens=1-5" %%a in ('tasklist /FI "PID eq %pid%" /FO CSV') do (
    echo Nombre: %%a
    echo PID: %%b
    echo Sesión: %%c
    echo Memoria: %%d
    echo Estado: %%e
)
call :log "Información del proceso %pid% obtenida"
goto :eof

:: Función para enviar señal de terminación suave
:send_soft_signal
set "pid=%~1"
echo Enviando señal de terminación suave al proceso %pid%...
taskkill /PID %pid%
if %errorlevel%==0 (
    echo ✓ Señal suave enviada al proceso %pid%
    call :log "Señal suave enviada exitosamente al proceso %pid%"
) else (
    echo ✗ Error al enviar señal suave
    call :log "Error al enviar señal suave al proceso %pid%"
)
goto :eof

:: Función para enviar señal de terminación forzada
:send_force_signal
set "pid=%~1"
echo Enviando señal de terminación forzada al proceso %pid%...
taskkill /PID %pid% /F
if %errorlevel%==0 (
    echo ✓ Señal forzada enviada al proceso %pid%
    call :log "Señal forzada enviada exitosamente al proceso %pid%"
) else (
    echo ✗ Error al enviar señal forzada
    call :log "Error al enviar señal forzada al proceso %pid%"
)
goto :eof

:: Función para pausar proceso
:suspend_process
set "pid=%~1"
echo Pausando proceso %pid%...
wmic process where "ProcessId=%pid%" call suspend
if %errorlevel%==0 (
    echo ✓ Proceso %pid% pausado
    call :log "Proceso %pid% pausado exitosamente"
) else (
    echo ✗ Error al pausar proceso
    call :log "Error al pausar proceso %pid%"
)
goto :eof

:: Función para reanudar proceso
:resume_process
set "pid=%~1"
echo Reanudando proceso %pid%...
wmic process where "ProcessId=%pid%" call resume
if %errorlevel%==0 (
    echo ✓ Proceso %pid% reanudado
    call :log "Proceso %pid% reanudado exitosamente"
) else (
    echo ✗ Error al reanudar proceso
    call :log "Error al reanudar proceso %pid%"
)
goto :eof

:: Función para monitoreo de procesos
:process_monitor
echo === MONITOREO DE PROCESOS ===
echo Presiona 'q' para salir, 'r' para refrescar
:monitor_loop
cls
echo [%date% %time%] - Monitoreo de Procesos
echo ======================================
echo.
echo Procesos con mayor uso de CPU:
tasklist /FO TABLE /FI "CPUTIME gt 00:05:00"
echo.
echo Procesos con mayor uso de memoria:
tasklist /FO TABLE /FI "MEMUSAGE gt 100000"
echo.
echo Comandos: q=salir, r=refrescar
choice /c qr /n /t 10 /d r >nul
if errorlevel 2 goto monitor_loop
if errorlevel 1 goto :eof
goto monitor_loop

:: Función para gestión masiva de procesos
:mass_process_management
echo === GESTIÓN MASIVA DE PROCESOS ===
echo.
echo 1. Terminar procesos por patrón de nombre
echo 2. Terminar procesos por uso de memoria
echo 3. Terminar procesos por tiempo de CPU
echo 4. Pausar todos los procesos de un usuario
echo.
set /p choice="Selecciona opción (1-4): "

if "%choice%"=="1" (
    set /p pattern="Patrón de nombre: "
    for /f "tokens=2" %%a in ('tasklist /FI "IMAGENAME eq %pattern%*" /FO CSV') do (
        taskkill /PID %%a /F
        echo ✓ Proceso %%a terminado
        call :log "Proceso %%a terminado por patrón %pattern%"
    )
)
if "%choice%"=="2" (
    set /p limit="Límite de memoria (MB): "
    for /f "tokens=2" %%a in ('tasklist /FI "MEMUSAGE gt %limit%000" /FO CSV') do (
        taskkill /PID %%a /F
        echo ✓ Proceso %%a terminado
        call :log "Proceso %%a terminado por memoria %limit%MB"
    )
)
if "%choice%"=="3" (
    set /p time="Tiempo máximo (HH:MM): "
    for /f "tokens=2" %%a in ('tasklist /FI "CPUTIME gt %time%" /FO CSV') do (
        taskkill /PID %%a /F
        echo ✓ Proceso %%a terminado
        call :log "Proceso %%a terminado por tiempo %time%"
    )
)
if "%choice%"=="4" (
    set /p user="Usuario: "
    for /f "tokens=2" %%a in ('tasklist /FI "USERNAME eq %user%" /FO CSV') do (
        wmic process where "ProcessId=%%a" call suspend
        echo ✓ Proceso %%a pausado
        call :log "Proceso %%a pausado para usuario %user%"
    )
)
pause
goto :eof

:: Función para señales remotas
:remote_signals
echo === SEÑALES REMOTAS ===
echo.
set /p computer="Equipo remoto: "
set /p action="Acción (list/terminate/suspend/resume): "

if /i "%action%"=="list" (
    tasklist /S %computer% /FO TABLE
    call :log "Lista de procesos obtenida del equipo %computer%"
)
if /i "%action%"=="terminate" (
    set /p pid="PID del proceso: "
    taskkill /S %computer% /PID %pid% /F
    echo ✓ Proceso %pid% terminado en %computer%
    call :log "Proceso %pid% terminado remotamente en %computer%"
)
if /i "%action%"=="suspend" (
    set /p pid="PID del proceso: "
    wmic /node:%computer% process where "ProcessId=%pid%" call suspend
    echo ✓ Proceso %pid% pausado en %computer%
    call :log "Proceso %pid% pausado remotamente en %computer%"
)
if /i "%action%"=="resume" (
    set /p pid="PID del proceso: "
    wmic /node:%computer% process where "ProcessId=%pid%" call resume
    echo ✓ Proceso %pid% reanudado en %computer%
    call :log "Proceso %pid% reanudado remotamente en %computer%"
)
pause
goto :eof

:: Menú principal
:main_menu
cls
echo ========================================
echo    GESTION AVANZADA DE SEÑALES
echo ========================================
echo.
echo 1. Verificar proceso por PID
echo 2. Obtener información de proceso
echo 3. Enviar señal de terminación suave
echo 4. Enviar señal de terminación forzada
echo 5. Pausar proceso
echo 6. Reanudar proceso
echo 7. Monitoreo de procesos
echo 8. Gestión masiva de procesos
echo 9. Señales remotas
echo 10. Ver logs del sistema
echo 0. Salir
echo.
set /p choice="Selecciona una opción (0-10): "

if "%choice%"=="1" (
    set /p pid="PID del proceso: "
    call :check_process %pid%
    pause
    goto main_menu
)
if "%choice%"=="2" (
    set /p pid="PID del proceso: "
    call :get_process_info %pid%
    pause
    goto main_menu
)
if "%choice%"=="3" (
    set /p pid="PID del proceso: "
    call :send_soft_signal %pid%
    pause
    goto main_menu
)
if "%choice%"=="4" (
    set /p pid="PID del proceso: "
    call :send_force_signal %pid%
    pause
    goto main_menu
)
if "%choice%"=="5" (
    set /p pid="PID del proceso: "
    call :suspend_process %pid%
    pause
    goto main_menu
)
if "%choice%"=="6" (
    set /p pid="PID del proceso: "
    call :resume_process %pid%
    pause
    goto main_menu
)
if "%choice%"=="7" (
    call :process_monitor
    goto main_menu
)
if "%choice%"=="8" (
    call :mass_process_management
    goto main_menu
)
if "%choice%"=="9" (
    call :remote_signals
    goto main_menu
)
if "%choice%"=="10" (
    if exist "%LOG_FILE%" (
        type "%LOG_FILE%"
    ) else (
        echo No hay logs disponibles
    )
    pause
    goto main_menu
)
if "%choice%"=="0" (
    echo Gracias por usar el gestor avanzado de señales
    exit /b 0
)
goto main_menu 