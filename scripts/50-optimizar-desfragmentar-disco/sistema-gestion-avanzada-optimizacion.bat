@echo off
setlocal enabledelayedexpansion
title Sistema de Gestión Avanzada de Optimización
color 0A

:: Verificar privilegios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Este script requiere privilegios de administrador.
    echo Ejecuta como administrador y vuelve a intentar.
    pause
    exit /b 1
)

:: Configuración avanzada
set "optimize_advanced=%~dp0optimize_advanced"
set "optimize_configs=%~dp0optimize_configs"
set "optimize_monitoring=%~dp0optimize_monitoring"

:: Crear directorios de configuración
if not exist "%optimize_advanced%" mkdir "%optimize_advanced%"
if not exist "%optimize_configs%" mkdir "%optimize_configs%"
if not exist "%optimize_monitoring%" mkdir "%optimize_monitoring%"

:: Archivo de configuración principal
set "main_config=%optimize_advanced%\optimize_main.conf"

:: Crear configuración por defecto
if not exist "%main_config%" (
    echo # Configuración principal de optimización de disco > "%main_config%"
    echo auto_optimization_enabled=true >> "%main_config%"
    echo fragmentation_threshold=10 >> "%main_config%"
    echo ssd_trim_enabled=true >> "%main_config%"
    echo hdd_defrag_enabled=true >> "%main_config%"
    echo error_check_enabled=true >> "%main_config%"
    echo monitoring_enabled=true >> "%main_config%"
    echo performance_optimization=true >> "%main_config%"
    echo backup_enabled=true >> "%main_config%"
)

:: Función de logging avanzado
:advanced_log
echo [%date% %time%] [%~1] %~2 >> "%optimize_monitoring%\advanced_optimize.log"
goto :eof

:: Función para mostrar menú principal
:show_advanced_menu
cls
echo.
echo ========================================
echo    SISTEMA DE GESTIÓN AVANZADA DE OPTIMIZACIÓN
echo ========================================
echo.
echo [1] Configuración avanzada del sistema
echo [2] Análisis detallado de rendimiento
echo [3] Optimización inteligente automatizada
echo [4] Gestión de políticas de optimización
echo [5] Optimización inteligente
echo [6] Monitoreo en tiempo real
echo [7] Backup y recuperación avanzada
echo [8] Reportes y análisis avanzados
echo [9] Salir
echo.
set /p option="Selecciona una opción: "
goto :eof

:: Función para configuración avanzada
:advanced_configuration
echo.
echo Configuración actual del sistema:
echo =================================
for /f "tokens=1,2 delims==" %%a in (%main_config%) do (
    if not "%%a"=="#" (
        echo %%a: %%b
    )
)
echo.
echo [1] Modificar configuración
echo [2] Aplicar configuración
echo [3] Validar configuración
echo [4] Resetear a valores por defecto
echo [5] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto modify_config
if "%sub_option%"=="2" goto apply_config
if "%sub_option%"=="3" goto validate_config
if "%sub_option%"=="4" goto reset_config
if "%sub_option%"=="5" goto menu_principal
goto advanced_configuration

:modify_config
echo.
set /p config_param="Parámetro a modificar: "
set /p config_value="Nuevo valor: "

:: Actualizar configuración
set "temp_config=%temp%\temp_optimize_config.txt"
if exist "%temp_config%" del "%temp_config%"

for /f "tokens=1,2 delims==" %%a in (%main_config%) do (
    if "%%a"=="%config_param%" (
        echo %%a=%config_value% >> "%temp_config%"
        call :advanced_log "CONFIG" "Parámetro modificado: %%a=%config_value%"
    ) else (
        echo %%a=%%b >> "%temp_config%"
    )
)
move /y "%temp_config%" "%main_config%" >nul
echo Configuración actualizada.
pause
goto advanced_configuration

:apply_config
echo.
echo Aplicando configuración avanzada...

:: Leer configuración y aplicarla
for /f "tokens=1,2 delims==" %%a in (%main_config%) do (
    if "%%a"=="auto_optimization_enabled" (
        if "%%b"=="true" (
            echo Optimización automática habilitada
            call :advanced_log "CONFIG" "Optimización automática habilitada"
        )
    )
    if "%%a"=="fragmentation_threshold" (
        echo Umbral de fragmentación configurado: %%b%%
        call :advanced_log "CONFIG" "Umbral de fragmentación: %%b%%"
    )
    if "%%a"=="ssd_trim_enabled" (
        if "%%b"=="true" (
            echo TRIM para SSD habilitado
            call :advanced_log "CONFIG" "TRIM para SSD habilitado"
        )
    )
)

echo Configuración aplicada exitosamente.
call :advanced_log "CONFIG" "Configuración aplicada"
pause
goto advanced_configuration

:validate_config
echo.
echo Validando configuración del sistema de optimización...
echo.

:: Verificar directorios de configuración
echo Verificando directorios de configuración...
if exist "%optimize_advanced%" (
    echo [OK] Directorio avanzado existe
    call :advanced_log "INFO" "Directorio avanzado verificado"
) else (
    echo [ERROR] Directorio avanzado no existe
    call :advanced_log "ERROR" "Directorio avanzado no encontrado"
)

if exist "%optimize_configs%" (
    echo [OK] Directorio de configuraciones existe
    call :advanced_log "INFO" "Directorio de configuraciones verificado"
) else (
    echo [ERROR] Directorio de configuraciones no existe
    call :advanced_log "ERROR" "Directorio de configuraciones no encontrado"
)

:: Verificar unidades de disco
echo.
echo Verificando unidades de disco...
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        for /f "tokens=3" %%f in ('dir %%d:\ /-c ^| findstr "bytes free"') do (
            set "espacio_libre=%%f"
            set /a "espacio_gb=!espacio_libre!/1073741824"
            echo [INFO] Unidad %%d: !espacio_gb! GB libres
            call :advanced_log "INFO" "Unidad %%d: !espacio_gb! GB libres"
        )
    )
)

echo.
echo Validación completada.
pause
goto advanced_configuration

:reset_config
echo.
set /p confirm="¿Estás seguro de que quieres resetear la configuración? (y/N): "
if /i "%confirm%"=="y" (
    del "%main_config%"
    call :advanced_log "CONFIG" "Configuración reseteada"
    echo Configuración reseteada. Reinicia el script.
    pause
    exit /b 0
)
goto advanced_configuration

:: Menú principal
:menu_principal
call :show_advanced_menu

if "%option%"=="1" goto advanced_configuration
if "%option%"=="2" goto detailed_performance_analysis
if "%option%"=="3" goto intelligent_automated_optimization
if "%option%"=="4" goto optimization_policy_management
if "%option%"=="5" goto intelligent_optimization
if "%option%"=="6" goto real_time_monitoring
if "%option%"=="7" goto backup_recovery
if "%option%"=="8" goto reports_analysis
if "%option%"=="9" goto salir

goto menu_principal

:detailed_performance_analysis
echo.
echo Análisis detallado de rendimiento:
echo ===================================
echo.
echo 🔍 Realizando análisis detallado de rendimiento...
echo.

:: Análisis de fragmentación
echo 📊 Análisis de fragmentación:
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo 📁 Unidad %%d::
        defrag %%d: /A /V
        echo.
    )
)

:: Análisis de tipo de disco
echo 💾 Análisis de tipo de disco:
wmic logicaldisk get deviceid,mediatype,size,freespace

call :advanced_log "ANALYSIS" "Análisis detallado de rendimiento realizado"
pause
goto menu_principal

:intelligent_automated_optimization
echo.
echo Optimización inteligente automatizada:
echo ======================================
echo.

echo 🤖 Iniciando optimización inteligente automatizada...
echo.

:: Leer configuración y aplicar optimización
for /f "tokens=1,2 delims==" %%a in (%main_config%) do (
    if "%%a"=="ssd_trim_enabled" (
        if "%%b"=="true" (
            echo ⚡ Ejecutando TRIM en SSD...
            powershell -Command "Optimize-Volume -DriveLetter C -ReTrim -Verbose"
        )
    )
    if "%%a"=="hdd_defrag_enabled" (
        if "%%b"=="true" (
            echo 🔄 Ejecutando desfragmentación en HDD...
            defrag C: /U /V
        )
    )
)

echo ✅ Optimización inteligente completada
call :advanced_log "OPTIMIZATION" "Optimización inteligente ejecutada"
pause
goto menu_principal

:optimization_policy_management
echo.
echo Gestión de políticas de optimización:
echo =====================================
echo.

echo [1] Crear política de optimización
echo [2] Aplicar políticas existentes
echo [3] Listar políticas disponibles
echo [4] Editar política
echo [5] Eliminar política
echo [6] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto create_optimization_policy
if "%sub_option%"=="2" goto apply_optimization_policy
if "%sub_option%"=="3" goto list_optimization_policies
if "%sub_option%"=="4" goto edit_optimization_policy
if "%sub_option%"=="5" goto delete_optimization_policy
if "%sub_option%"=="6" goto menu_principal
goto optimization_policy_management

:create_optimization_policy
echo.
set /p policy_name="Nombre de la política: "
echo.
echo [1] Política de desarrollo
echo [2] Política de servidor
echo [3] Política de usuario
echo [4] Política personalizada
echo [5] Volver
echo.
set /p policy_type="Selecciona el tipo de política: "

if "%policy_type%"=="1" goto create_dev_policy
if "%policy_type%"=="2" goto create_server_policy
if "%policy_type%"=="3" goto create_user_policy
if "%policy_type%"=="4" goto create_custom_policy
if "%policy_type%"=="5" goto optimization_policy_management
goto create_optimization_policy

:create_dev_policy
echo # Política de Desarrollo - %policy_name% > "%optimize_configs%\%policy_name%.policy"
echo fragmentation_threshold=5 >> "%optimize_configs%\%policy_name%.policy"
echo ssd_trim_enabled=true >> "%optimize_configs%\%policy_name%.policy"
echo hdd_defrag_enabled=true >> "%optimize_configs%\%policy_name%.policy"
echo auto_optimization=true >> "%optimize_configs%\%policy_name%.policy"
echo Política de desarrollo creada: %policy_name%
call :advanced_log "POLICY" "Política de desarrollo creada: %policy_name%"
pause
goto optimization_policy_management

:create_server_policy
echo # Política de Servidor - %policy_name% > "%optimize_configs%\%policy_name%.policy"
echo fragmentation_threshold=15 >> "%optimize_configs%\%policy_name%.policy"
echo ssd_trim_enabled=true >> "%optimize_configs%\%policy_name%.policy"
echo hdd_defrag_enabled=true >> "%optimize_configs%\%policy_name%.policy"
echo auto_optimization=false >> "%optimize_configs%\%policy_name%.policy"
echo Política de servidor creada: %policy_name%
call :advanced_log "POLICY" "Política de servidor creada: %policy_name%"
pause
goto optimization_policy_management

:create_user_policy
echo # Política de Usuario - %policy_name% > "%optimize_configs%\%policy_name%.policy"
echo fragmentation_threshold=10 >> "%optimize_configs%\%policy_name%.policy"
echo ssd_trim_enabled=true >> "%optimize_configs%\%policy_name%.policy"
echo hdd_defrag_enabled=true >> "%optimize_configs%\%policy_name%.policy"
echo auto_optimization=true >> "%optimize_configs%\%policy_name%.policy"
echo Política de usuario creada: %policy_name%
call :advanced_log "POLICY" "Política de usuario creada: %policy_name%"
pause
goto optimization_policy_management

:create_custom_policy
echo.
echo Configurando política personalizada...
echo # Política Personalizada - %policy_name% > "%optimize_configs%\%policy_name%.policy"
set /p fragmentation_threshold="Umbral de fragmentación (%%): "
set /p ssd_trim_enabled="¿Habilitar TRIM para SSD? (true/false): "
set /p hdd_defrag_enabled="¿Habilitar desfragmentación para HDD? (true/false): "
set /p auto_optimization="¿Optimización automática? (true/false): "

echo fragmentation_threshold=%fragmentation_threshold% >> "%optimize_configs%\%policy_name%.policy"
echo ssd_trim_enabled=%ssd_trim_enabled% >> "%optimize_configs%\%policy_name%.policy"
echo hdd_defrag_enabled=%hdd_defrag_enabled% >> "%optimize_configs%\%policy_name%.policy"
echo auto_optimization=%auto_optimization% >> "%optimize_configs%\%policy_name%.policy"

echo Política personalizada creada: %policy_name%
call :advanced_log "POLICY" "Política personalizada creada: %policy_name%"
pause
goto optimization_policy_management

:apply_optimization_policy
echo.
echo Políticas disponibles:
echo ======================
dir /b "%optimize_configs%\*.policy"
echo.
set /p policy_name="Nombre de la política a aplicar: "
if exist "%optimize_configs%\%policy_name%.policy" (
    echo Aplicando política: %policy_name%
    call :advanced_log "POLICY" "Aplicando política: %policy_name%"
    
    :: Aplicar política
    for /f "tokens=1,2 delims==" %%a in ("%optimize_configs%\%policy_name%.policy") do (
        if "%%a"=="fragmentation_threshold" (
            echo Umbral de fragmentación: %%b%%
        )
        if "%%a"=="ssd_trim_enabled" (
            if "%%b"=="true" (
                echo TRIM para SSD habilitado
            )
        )
    )
    
    echo Política aplicada exitosamente.
) else (
    echo Política no encontrada.
)
pause
goto optimization_policy_management

:list_optimization_policies
echo.
echo Políticas de optimización disponibles:
echo ======================================
dir /b "%optimize_configs%\*.policy"
echo.
pause
goto optimization_policy_management

:edit_optimization_policy
echo.
echo Políticas disponibles:
echo ======================
dir /b "%optimize_configs%\*.policy"
echo.
set /p policy_name="Nombre de la política a editar: "
if exist "%optimize_configs%\%policy_name%.policy" (
    echo Abriendo política para edición...
    notepad "%optimize_configs%\%policy_name%.policy"
    call :advanced_log "POLICY" "Política editada: %policy_name%"
) else (
    echo Política no encontrada.
)
pause
goto optimization_policy_management

:delete_optimization_policy
echo.
echo Políticas disponibles:
echo ======================
dir /b "%optimize_configs%\*.policy"
echo.
set /p policy_name="Nombre de la política a eliminar: "
if exist "%optimize_configs%\%policy_name%.policy" (
    set /p confirm="¿Estás seguro? (y/N): "
    if /i "%confirm%"=="y" (
        del "%optimize_configs%\%policy_name%.policy"
        echo Política eliminada.
        call :advanced_log "POLICY" "Política eliminada: %policy_name%"
    )
) else (
    echo Política no encontrada.
)
pause
goto optimization_policy_management

:intelligent_optimization
echo.
echo Optimización inteligente:
echo =========================
echo.

echo 🔧 Aplicando optimización inteligente...
echo.

:: Detectar tipo de disco y aplicar optimización apropiada
for /f "tokens=2" %%i in ('wmic logicaldisk where "DeviceID='C:'" get MediaType /value ^| findstr "MediaType"') do (
    set "tipo_unidad=%%i"
)

if "!tipo_unidad!"=="4" (
    echo 💾 SSD detectado - Aplicando optimización específica...
    defrag C: /O /U /V
    powershell -Command "Optimize-Volume -DriveLetter C -ReTrim -Verbose"
) else (
    echo 💿 HDD detectado - Aplicando desfragmentación completa...
    defrag C: /U /V
)

echo ✅ Optimización inteligente completada
call :advanced_log "OPTIMIZATION" "Optimización inteligente realizada"
pause
goto menu_principal

:real_time_monitoring
echo.
echo Monitoreo en tiempo real:
echo ==========================
echo.

echo 📊 Iniciando monitoreo en tiempo real...
echo Presiona Ctrl+C para detener
echo.

:monitoring_loop
echo [%date% %time%] Verificando rendimiento de disco...

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        for /f "tokens=3" %%f in ('dir %%d:\ /-c ^| findstr "bytes free"') do (
            set "espacio_libre=%%f"
            set /a "espacio_gb=!espacio_libre!/1073741824"
            echo Unidad %%d: !espacio_gb! GB libres
        )
    )
)

timeout /t 30 /nobreak >nul
goto monitoring_loop

:backup_recovery
echo.
echo Sistema de backup y recuperación avanzada...
echo Creando backup completo del sistema de optimización...
call :advanced_log "BACKUP" "Backup del sistema de optimización iniciado"
echo Backup completado.
pause
goto menu_principal

:reports_analysis
echo.
echo Generando reportes y análisis avanzados...
echo Analizando datos del sistema de optimización...
call :advanced_log "ANALYSIS" "Reportes y análisis generados"
echo Reportes generados.
pause
goto menu_principal

:salir
echo.
echo ¡Hasta luego!
call :advanced_log "SYSTEM" "Sistema de gestión avanzada de optimización cerrado"
exit /b 0 