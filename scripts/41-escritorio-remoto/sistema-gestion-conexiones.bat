@echo off
setlocal enabledelayedexpansion
title Sistema de Gestión de Conexiones Remotas
color 0B

:: Configuración
set "config_file=conexiones_remotas.conf"
set "log_file=conexiones_remotas.log"

:: Crear archivo de configuración si no existe
if not exist "%config_file%" (
    echo # Configuración de conexiones remotas > "%config_file%"
    echo # Formato: nombre|servidor|usuario|resolucion >> "%config_file%"
    echo servidor_web|192.168.1.100|admin|1920x1080 >> "%config_file%"
    echo servidor_db|192.168.1.101|administrador|1366x768 >> "%config_file%"
    echo servidor_app|192.168.1.102|usuario|1600x900 >> "%config_file%"
)

:: Función de logging
:log
echo [%date% %time%] %~1 >> "%log_file%"
goto :eof

:: Función para mostrar menú principal
:mostrar_menu
cls
echo.
echo ========================================
echo    SISTEMA DE GESTIÓN DE CONEXIONES
echo ========================================
echo.
echo [1] Listar conexiones configuradas
echo [2] Conectar a servidor
echo [3] Agregar nueva conexión
echo [4] Editar conexión existente
echo [5] Eliminar conexión
echo [6] Monitoreo de servidores
echo [7] Backup de configuraciones
echo [8] Ver logs
echo [9] Salir
echo.
set /p opcion="Selecciona una opción: "
goto :eof

:: Función para listar conexiones
:listar_conexiones
echo.
echo Conexiones configuradas:
echo -------------------------
for /f "tokens=1-4 delims=|" %%a in (%config_file%) do (
    if not "%%a"=="#" (
        echo Nombre: %%a
        echo Servidor: %%b
        echo Usuario: %%c
        echo Resolución: %%d
        echo -------------------------
    )
)
pause
goto menu_principal

:: Función para conectar
:conectar_servidor
echo.
set /p nombre="Nombre de la conexión: "
for /f "tokens=1-4 delims=|" %%a in (%config_file%) do (
    if "%%a"=="%nombre%" (
        call :log "Conectando a %%b como %%c"
        mstsc /v:%%b /u:%%c /w:%%d:~0,4 /h:%%d:~5,4
        goto menu_principal
    )
)
echo Conexión no encontrada.
pause
goto menu_principal

:: Función para agregar conexión
:agregar_conexion
echo.
set /p nombre="Nombre de la conexión: "
set /p servidor="Servidor: "
set /p usuario="Usuario: "
set /p resolucion="Resolución: "
echo %nombre%^|%servidor%^|%usuario%^|%resolucion% >> "%config_file%"
call :log "Nueva conexión agregada: %nombre%"
echo Conexión agregada exitosamente.
pause
goto menu_principal

:: Función para editar conexión
:editar_conexion
echo.
set /p nombre="Nombre de la conexión a editar: "
set "temp_file=%temp%\temp_config.txt"
if exist "%temp_file%" del "%temp_file%"

for /f "tokens=1-4 delims=|" %%a in (%config_file%) do (
    if "%%a"=="%nombre%" (
        set /p nuevo_servidor="Nuevo servidor [%%b]: "
        set /p nuevo_usuario="Nuevo usuario [%%c]: "
        set /p nueva_resolucion="Nueva resolución [%%d]: "
        
        if "!nuevo_servidor!"=="" set "nuevo_servidor=%%b"
        if "!nuevo_usuario!"=="" set "nuevo_usuario=%%c"
        if "!nueva_resolucion!"=="" set "nueva_resolucion=%%d"
        
        echo %%a^|!nuevo_servidor!^|!nuevo_usuario!^|!nueva_resolucion! >> "%temp_file%"
        call :log "Conexión editada: %nombre%"
    ) else (
        echo %%a^|%%b^|%%c^|%%d >> "%temp_file%"
    )
)
move /y "%temp_file%" "%config_file%" >nul
echo Conexión editada exitosamente.
pause
goto menu_principal

:: Función para eliminar conexión
:eliminar_conexion
echo.
set /p nombre="Nombre de la conexión a eliminar: "
set "temp_file=%temp%\temp_config.txt"
if exist "%temp_file%" del "%temp_file%"

for /f "tokens=1-4 delims=|" %%a in (%config_file%) do (
    if not "%%a"=="%nombre%" (
        echo %%a^|%%b^|%%c^|%%d >> "%temp_file%"
    )
)
move /y "%temp_file%" "%config_file%" >nul
call :log "Conexión eliminada: %nombre%"
echo Conexión eliminada exitosamente.
pause
goto menu_principal

:: Función para monitoreo
:monitoreo_servidores
echo.
echo Monitoreando servidores configurados...
echo Presiona Ctrl+C para detener
echo.

:monitoreo_loop
cls
echo ========================================
echo    MONITOREO DE SERVIDORES
echo    Hora: %time%
echo ========================================
echo.

for /f "tokens=1-4 delims=|" %%a in (%config_file%) do (
    if not "%%a"=="#" (
        echo Servidor: %%b
        echo -------------------------
        quser /server:%%b 2>nul
        if errorlevel 1 (
            echo Estado: No accesible
        )
        echo.
    )
)

echo Actualizando en 30 segundos...
timeout /t 30 /nobreak >nul
goto monitoreo_loop

:: Función para backup
:backup_configuraciones
echo.
set "backup_file=backup_conexiones_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.conf"
copy "%config_file%" "%backup_file%" >nul
call :log "Backup creado: %backup_file%"
echo Backup creado: %backup_file%
pause
goto menu_principal

:: Función para ver logs
:ver_logs
echo.
echo Últimas 20 entradas del log:
echo -----------------------------
for /f "skip=-20" %%a in (%log_file%) do echo %%a
pause
goto menu_principal

:: Menú principal
:menu_principal
call :mostrar_menu

if "%opcion%"=="1" goto listar_conexiones
if "%opcion%"=="2" goto conectar_servidor
if "%opcion%"=="3" goto agregar_conexion
if "%opcion%"=="4" goto editar_conexion
if "%opcion%"=="5" goto eliminar_conexion
if "%opcion%"=="6" goto monitoreo_servidores
if "%opcion%"=="7" goto backup_configuraciones
if "%opcion%"=="8" goto ver_logs
if "%opcion%"=="9" goto salir

goto menu_principal

:salir
echo.
echo ¡Hasta luego!
exit /b 0 