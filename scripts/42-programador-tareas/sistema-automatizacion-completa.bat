@echo off
setlocal enabledelayedexpansion
title Sistema de Automatización Completa
color 0C

:: Configuración
set "config_dir=%~dp0config"
set "scripts_dir=%~dp0scripts"
set "logs_dir=%~dp0logs"

:: Crear directorios si no existen
if not exist "%config_dir%" mkdir "%config_dir%"
if not exist "%scripts_dir%" mkdir "%scripts_dir%"
if not exist "%logs_dir%" mkdir "%logs_dir%"

:: Archivo de configuración
set "config_file=%config_dir%\automatizacion.conf"

:: Crear configuración por defecto si no existe
if not exist "%config_file%" (
    echo # Configuración de automatización > "%config_file%"
    echo # Formato: categoria|nombre|comando|frecuencia|hora|activo >> "%config_file%"
    echo backup|backup_diario|C:\scripts\backup.bat|daily|02:00|1 >> "%config_file%"
    echo limpieza|limpieza_semanal|C:\scripts\limpieza.bat|weekly|01:00|1 >> "%config_file%"
    echo monitoreo|monitoreo_continuo|C:\scripts\monitor.bat|minute|30|1 >> "%config_file%"
    echo reporte|reporte_mensual|C:\scripts\reporte.bat|monthly|09:00|1 >> "%config_file%"
)

:: Función de logging
:log
echo [%date% %time%] %~1 >> "%logs_dir%\automatizacion.log"
goto :eof

:: Función para mostrar menú principal
:mostrar_menu
cls
echo.
echo ========================================
echo    SISTEMA DE AUTOMATIZACIÓN COMPLETA
echo ========================================
echo.
echo [1] Configurar automatizaciones
echo [2] Crear tareas desde configuración
echo [3] Monitorear tareas activas
echo [4] Generar reportes de ejecución
echo [5] Backup de configuraciones
echo [6] Restaurar configuraciones
echo [7] Limpiar tareas antiguas
echo [8] Ver logs del sistema
echo [9] Salir
echo.
set /p opcion="Selecciona una opción: "
goto :eof

:: Función para configurar automatizaciones
:configurar_automatizaciones
echo.
echo Configuraciones actuales:
echo -------------------------
for /f "tokens=1-6 delims=|" %%a in (%config_file%) do (
    if not "%%a"=="#" (
        echo Categoría: %%a
        echo Nombre: %%b
        echo Comando: %%c
        echo Frecuencia: %%d
        echo Hora: %%e
        echo Activo: %%f
        echo -------------------------
    )
)
echo.
echo [1] Agregar nueva configuración
echo [2] Editar configuración existente
echo [3] Eliminar configuración
echo [4] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto agregar_config
if "%sub_opcion%"=="2" goto editar_config
if "%sub_opcion%"=="3" goto eliminar_config
if "%sub_opcion%"=="4" goto menu_principal
goto configurar_automatizaciones

:agregar_config
echo.
set /p categoria="Categoría: "
set /p nombre="Nombre: "
set /p comando="Comando: "
set /p frecuencia="Frecuencia (daily/weekly/monthly/minute): "
set /p hora="Hora (HH:MM): "
echo %categoria%^|%nombre%^|%comando%^|%frecuencia%^|%hora%^|1 >> "%config_file%"
call :log "Nueva configuración agregada: %nombre%"
echo Configuración agregada exitosamente.
pause
goto configurar_automatizaciones

:editar_config
echo.
set /p nombre_editar="Nombre de la configuración a editar: "
set "temp_file=%temp%\temp_config.txt"
if exist "%temp_file%" del "%temp_file%"

for /f "tokens=1-6 delims=|" %%a in (%config_file%) do (
    if "%%b"=="%nombre_editar%" (
        set /p nueva_categoria="Nueva categoría [%%a]: "
        set /p nuevo_comando="Nuevo comando [%%c]: "
        set /p nueva_frecuencia="Nueva frecuencia [%%d]: "
        set /p nueva_hora="Nueva hora [%%e]: "
        
        if "!nueva_categoria!"=="" set "nueva_categoria=%%a"
        if "!nuevo_comando!"=="" set "nuevo_comando=%%c"
        if "!nueva_frecuencia!"=="" set "nueva_frecuencia=%%d"
        if "!nueva_hora!"=="" set "nueva_hora=%%e"
        
        echo !nueva_categoria!^|%%b^|!nuevo_comando!^|!nueva_frecuencia!^|!nueva_hora!^|%%f >> "%temp_file%"
        call :log "Configuración editada: %nombre_editar%"
    ) else (
        echo %%a^|%%b^|%%c^|%%d^|%%e^|%%f >> "%temp_file%"
    )
)
move /y "%temp_file%" "%config_file%" >nul
echo Configuración editada exitosamente.
pause
goto configurar_automatizaciones

:eliminar_config
echo.
set /p nombre_eliminar="Nombre de la configuración a eliminar: "
set "temp_file=%temp%\temp_config.txt"
if exist "%temp_file%" del "%temp_file%"

for /f "tokens=1-6 delims=|" %%a in (%config_file%) do (
    if not "%%b"=="%nombre_eliminar%" (
        echo %%a^|%%b^|%%c^|%%d^|%%e^|%%f >> "%temp_file%"
    )
)
move /y "%temp_file%" "%config_file%" >nul
call :log "Configuración eliminada: %nombre_eliminar%"
echo Configuración eliminada exitosamente.
pause
goto configurar_automatizaciones

:: Función para crear tareas desde configuración
:crear_tareas_desde_config
echo.
echo Creando tareas desde configuración...
for /f "tokens=1-6 delims=|" %%a in (%config_file%) do (
    if not "%%a"=="#" (
        if "%%f"=="1" (
            echo Creando tarea: %%b
            schtasks /create /tn "%%b" /tr "%%c" /sc %%d /st %%e /f 2>nul
            if errorlevel 1 (
                echo Error al crear tarea: %%b
                call :log "Error al crear tarea: %%b"
            ) else (
                echo Tarea creada exitosamente: %%b
                call :log "Tarea creada: %%b"
            )
        )
    )
)
echo.
echo Proceso completado.
pause
goto menu_principal

:: Función para monitorear tareas activas
:monitorear_tareas
echo.
echo Monitoreando tareas activas...
echo Presiona Ctrl+C para detener
echo.

:monitoreo_loop
cls
echo ========================================
echo    MONITOREO DE TAREAS ACTIVAS
echo    Hora: %time%
echo ========================================
echo.

for /f "tokens=1-6 delims=|" %%a in (%config_file%) do (
    if not "%%a"=="#" (
        if "%%f"=="1" (
            echo Tarea: %%b
            echo Estado: 
            schtasks /query /tn "%%b" 2>nul | findstr "Ready"
            if errorlevel 1 (
                echo Estado: No encontrada o con error
            )
            echo -------------------------
        )
    )
)

echo Actualizando en 60 segundos...
timeout /t 60 /nobreak >nul
goto monitoreo_loop

:: Función para generar reportes
:generar_reportes
echo.
set /p reporte_nombre="Nombre del reporte: "
echo.
echo Generando reporte de ejecución...

echo Reporte de Tareas Programadas > "%logs_dir%\%reporte_nombre%.txt"
echo Fecha: %date% %time% >> "%logs_dir%\%reporte_nombre%.txt"
echo ======================================== >> "%logs_dir%\%reporte_nombre%.txt"
echo. >> "%logs_dir%\%reporte_nombre%.txt"

schtasks /query /fo table >> "%logs_dir%\%reporte_nombre%.txt"

echo Reporte generado: %logs_dir%\%reporte_nombre%.txt
call :log "Reporte generado: %reporte_nombre%"
pause
goto menu_principal

:: Función para backup de configuraciones
:backup_configuraciones
echo.
set "backup_file=backup_automatizacion_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.zip"
echo Creando backup de configuraciones...
powershell -command "Compress-Archive -Path '%config_dir%', '%scripts_dir%' -DestinationPath '%logs_dir%\%backup_file%'"
echo Backup creado: %logs_dir%\%backup_file%
call :log "Backup creado: %backup_file%"
pause
goto menu_principal

:: Función para restaurar configuraciones
:restaurar_configuraciones
echo.
set /p backup_file="Archivo de backup a restaurar: "
echo Restaurando configuraciones...
powershell -command "Expand-Archive -Path '%backup_file%' -DestinationPath '%~dp0' -Force"
echo Configuraciones restauradas.
call :log "Configuraciones restauradas desde: %backup_file%"
pause
goto menu_principal

:: Función para limpiar tareas antiguas
:limpiar_tareas_antiguas
echo.
set /p dias="Eliminar tareas más antiguas que (días): "
echo.
echo Limpiando tareas antiguas...

for /f "tokens=1-6 delims=|" %%a in (%config_file%) do (
    if not "%%a"=="#" (
        echo Verificando tarea: %%b
        schtasks /query /tn "%%b" 2>nul | findstr "Ready"
        if errorlevel 1 (
            echo Eliminando tarea no encontrada: %%b
            schtasks /delete /tn "%%b" /f 2>nul
        )
    )
)

echo Limpieza completada.
call :log "Limpieza de tareas antiguas completada"
pause
goto menu_principal

:: Función para ver logs
:ver_logs
echo.
echo Últimas 30 entradas del log:
echo -----------------------------
for /f "skip=-30" %%a in ("%logs_dir%\automatizacion.log") do echo %%a
pause
goto menu_principal

:: Menú principal
:menu_principal
call :mostrar_menu

if "%opcion%"=="1" goto configurar_automatizaciones
if "%opcion%"=="2" goto crear_tareas_desde_config
if "%opcion%"=="3" goto monitorear_tareas
if "%opcion%"=="4" goto generar_reportes
if "%opcion%"=="5" goto backup_configuraciones
if "%opcion%"=="6" goto restaurar_configuraciones
if "%opcion%"=="7" goto limpiar_tareas_antiguas
if "%opcion%"=="8" goto ver_logs
if "%opcion%"=="9" goto salir

goto menu_principal

:salir
echo.
echo ¡Hasta luego!
exit /b 0 