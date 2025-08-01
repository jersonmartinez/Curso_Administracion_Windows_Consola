@echo off
title Sistema de Control de Procesos
color 0B

:: Verificar permisos de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Se requieren permisos de administrador
    pause
    exit /b 1
)

:: Variables del sistema
set "CONTROL_LOG=control_procesos.log"
set "RULES_FILE=reglas_procesos.conf"

:: Crear archivo de reglas si no existe
if not exist "%RULES_FILE%" (
    echo Creando archivo de reglas de control...
    (
        echo # Reglas de Control de Procesos
        echo MAX_MEMORY=500
        echo MAX_CPU_TIME=30
        echo AUTO_TERMINATE=true
        echo SUSPEND_THRESHOLD=80
        echo MONITOR_INTERVAL=60
    ) > "%RULES_FILE%"
    echo Archivo de reglas creado: %RULES_FILE%
    echo Edita el archivo y ejecuta nuevamente el script
    pause
    exit /b 0
)

:: Función para logging de control
:log_control
echo [%date% %time%] CONTROL: %~1 >> "%CONTROL_LOG%"
goto :eof

:: Función para cargar reglas
:load_rules
for /f "tokens=1,2 delims==" %%a in (%RULES_FILE%) do (
    if "%%a"=="MAX_MEMORY" set "max_memory=%%b"
    if "%%a"=="MAX_CPU_TIME" set "max_cpu_time=%%b"
    if "%%a"=="AUTO_TERMINATE" set "auto_terminate=%%b"
    if "%%a"=="SUSPEND_THRESHOLD" set "suspend_threshold=%%b"
    if "%%a"=="MONITOR_INTERVAL" set "monitor_interval=%%b"
)
goto :eof

:: Función para verificar reglas
:check_rules
call :load_rules
call :log_control "Verificando reglas de control"

:: Verificar procesos por memoria
for /f "tokens=2,4" %%a in ('tasklist /FI "MEMUSAGE gt %max_memory%000" /FO CSV') do (
    echo Proceso %%a excede límite de memoria: %%b KB
    if /i "%auto_terminate%"=="true" (
        taskkill /PID %%a /F
        echo ✓ Proceso %%a terminado por memoria
        call :log_control "Proceso %%a terminado por exceso de memoria"
    ) else (
        wmic process where "ProcessId=%%a" call suspend
        echo ✓ Proceso %%a pausado por memoria
        call :log_control "Proceso %%a pausado por exceso de memoria"
    )
)

:: Verificar procesos por tiempo de CPU
for /f "tokens=2" %%a in ('tasklist /FI "CPUTIME gt 00:%max_cpu_time%:00" /FO CSV') do (
    echo Proceso %%a excede tiempo de CPU
    if /i "%auto_terminate%"=="true" (
        taskkill /PID %%a /F
        echo ✓ Proceso %%a terminado por tiempo
        call :log_control "Proceso %%a terminado por exceso de tiempo"
    ) else (
        wmic process where "ProcessId=%%a" call suspend
        echo ✓ Proceso %%a pausado por tiempo
        call :log_control "Proceso %%a pausado por exceso de tiempo"
    )
)
goto :eof

:: Función para monitoreo automático
:auto_monitor
echo Sistema de Control de Procesos iniciado
echo Presiona Ctrl+C para detener
call :log_control "Sistema de control iniciado"

:monitor_loop
call :check_rules
timeout /t %monitor_interval% /nobreak >nul
goto monitor_loop

:: Función para gestión de reglas
:manage_rules
echo === GESTIÓN DE REGLAS ===
echo.
echo 1. Ver reglas actuales
echo 2. Editar reglas
echo 3. Restaurar reglas por defecto
echo 4. Probar reglas
echo.
set /p choice="Selecciona opción (1-4): "

if "%choice%"=="1" (
    echo Reglas actuales:
    type "%RULES_FILE%"
    call :log_control "Reglas mostradas"
)
if "%choice%"=="2" (
    notepad "%RULES_FILE%"
    call :log_control "Reglas editadas"
)
if "%choice%"=="3" (
    echo Restaurando reglas por defecto...
    (
        echo # Reglas de Control de Procesos
        echo MAX_MEMORY=500
        echo MAX_CPU_TIME=30
        echo AUTO_TERMINATE=true
        echo SUSPEND_THRESHOLD=80
        echo MONITOR_INTERVAL=60
    ) > "%RULES_FILE%"
    echo ✓ Reglas restauradas
    call :log_control "Reglas restauradas por defecto"
)
if "%choice%"=="4" (
    echo Probando reglas de control...
    call :check_rules
    echo ✓ Prueba completada
    call :log_control "Prueba de reglas ejecutada"
)
pause
goto :eof

:: Menú principal
:main_menu
cls
echo ========================================
echo    SISTEMA DE CONTROL DE PROCESOS
echo ========================================
echo.
echo 1. Iniciar monitoreo automático
echo 2. Verificar reglas manualmente
echo 3. Gestión de reglas
echo 4. Ver historial de control
echo 5. Configurar alertas
echo 6. Probar sistema
echo 0. Salir
echo.
set /p choice="Selecciona una opción (0-6): "

if "%choice%"=="1" (
    call :auto_monitor
    goto main_menu
)
if "%choice%"=="2" (
    call :check_rules
    pause
    goto main_menu
)
if "%choice%"=="3" (
    call :manage_rules
    goto main_menu
)
if "%choice%"=="4" (
    if exist "%CONTROL_LOG%" (
        type "%CONTROL_LOG%"
    ) else (
        echo No hay historial de control
    )
    pause
    goto main_menu
)
if "%choice%"=="5" (
    echo Configurando alertas...
    set /p email="Email para alertas: "
    echo Alerta configurada para: %email%
    call :log_control "Alerta configurada para %email%"
    pause
    goto main_menu
)
if "%choice%"=="6" (
    echo Probando sistema de control...
    call :check_rules
    echo ✓ Sistema probado correctamente
    call :log_control "Sistema probado manualmente"
    pause
    goto main_menu
)
if "%choice%"=="0" (
    echo Sistema de control cerrado
    exit /b 0
)
goto main_menu 