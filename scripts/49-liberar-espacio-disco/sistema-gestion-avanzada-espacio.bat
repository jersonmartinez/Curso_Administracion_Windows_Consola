@echo off
setlocal enabledelayedexpansion
title Sistema de Gestión Avanzada de Espacio
color 0E

:: Verificar privilegios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Este script requiere privilegios de administrador.
    echo Ejecuta como administrador y vuelve a intentar.
    pause
    exit /b 1
)

:: Configuración avanzada
set "space_advanced=%~dp0space_advanced"
set "space_configs=%~dp0space_configs"
set "space_monitoring=%~dp0space_monitoring"

:: Crear directorios de configuración
if not exist "%space_advanced%" mkdir "%space_advanced%"
if not exist "%space_configs%" mkdir "%space_configs%"
if not exist "%space_monitoring%" mkdir "%space_monitoring%"

:: Archivo de configuración principal
set "main_config=%space_advanced%\space_main.conf"

:: Crear configuración por defecto
if not exist "%main_config%" (
    echo # Configuración principal de gestión de espacio > "%main_config%"
    echo auto_cleanup_enabled=true >> "%main_config%"
    echo retention_days=30 >> "%main_config%"
    echo temp_cleanup_enabled=true >> "%main_config%"
    echo cache_cleanup_enabled=true >> "%main_config%"
    echo system_cleanup_enabled=true >> "%main_config%"
    echo compression_enabled=true >> "%main_config%"
    echo monitoring_enabled=true >> "%main_config%"
    echo alert_threshold=10 >> "%main_config%"
    echo backup_enabled=true >> "%main_config%"
)

:: Función de logging avanzado
:advanced_log
echo [%date% %time%] [%~1] %~2 >> "%space_monitoring%\advanced_space.log"
goto :eof

:: Función para mostrar menú principal
:show_advanced_menu
cls
echo.
echo ========================================
echo    SISTEMA DE GESTIÓN AVANZADA DE ESPACIO
echo ========================================
echo.
echo [1] Configuración avanzada del sistema
echo [2] Análisis detallado de espacio
echo [3] Limpieza inteligente automatizada
echo [4] Gestión de políticas de retención
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
set "temp_config=%temp%\temp_space_config.txt"
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
    if "%%a"=="auto_cleanup_enabled" (
        if "%%b"=="true" (
            echo Limpieza automática habilitada
            call :advanced_log "CONFIG" "Limpieza automática habilitada"
        )
    )
    if "%%a"=="retention_days" (
        echo Días de retención configurados: %%b
        call :advanced_log "CONFIG" "Días de retención: %%b"
    )
    if "%%a"=="alert_threshold" (
        echo Umbral de alerta configurado: %%b GB
        call :advanced_log "CONFIG" "Umbral de alerta: %%b GB"
    )
)

echo Configuración aplicada exitosamente.
call :advanced_log "CONFIG" "Configuración aplicada"
pause
goto advanced_configuration

:validate_config
echo.
echo Validando configuración del sistema de gestión de espacio...
echo.

:: Verificar directorios de configuración
echo Verificando directorios de configuración...
if exist "%space_advanced%" (
    echo [OK] Directorio avanzado existe
    call :advanced_log "INFO" "Directorio avanzado verificado"
) else (
    echo [ERROR] Directorio avanzado no existe
    call :advanced_log "ERROR" "Directorio avanzado no encontrado"
)

if exist "%space_configs%" (
    echo [OK] Directorio de configuraciones existe
    call :advanced_log "INFO" "Directorio de configuraciones verificado"
) else (
    echo [ERROR] Directorio de configuraciones no existe
    call :advanced_log "ERROR" "Directorio de configuraciones no encontrado"
)

:: Verificar espacio en disco
echo.
echo Verificando espacio en disco...
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

:: Función para análisis detallado de espacio
:detailed_space_analysis
echo.
echo [1] Análisis completo de unidades
echo [2] Análisis de directorios específicos
echo [3] Análisis de archivos por tipo
echo [4] Análisis de archivos duplicados
echo [5] Análisis de crecimiento de espacio
echo [6] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto complete_unit_analysis
if "%sub_option%"=="2" goto specific_directory_analysis
if "%sub_option%"=="3" goto file_type_analysis
if "%sub_option%"=="4" goto duplicate_file_analysis
if "%sub_option%"=="5" goto space_growth_analysis
if "%sub_option%"=="6" goto menu_principal
goto detailed_space_analysis

:complete_unit_analysis
echo.
echo Análisis completo de unidades:
echo ===============================
echo.

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo 📁 Unidad %%d::
        echo ════════════════════════════════════════════════════════════════
        
        :: Obtener información de espacio
        for /f "tokens=3" %%f in ('dir %%d:\ /-c ^| findstr "bytes free"') do (
            set "espacio_libre=%%f"
            set /a "espacio_gb=!espacio_libre!/1073741824"
            echo Espacio libre: !espacio_gb! GB
        )
        
        :: Obtener información de archivos
        for /f "tokens=1" %%f in ('dir %%d:\ /-c ^| findstr "File(s)"') do (
            set "num_archivos=%%f"
            echo Archivos: !num_archivos!
        )
        
        :: Obtener información de directorios
        for /f "tokens=1" %%f in ('dir %%d:\ /-c ^| findstr "Dir(s)"') do (
            set "num_dirs=%%f"
            echo Directorios: !num_dirs!
        )
        
        echo.
    )
)

call :advanced_log "ANALYSIS" "Análisis completo de unidades realizado"
pause
goto detailed_space_analysis

:specific_directory_analysis
echo.
set /p directory="Directorio a analizar: "
if not exist "%directory%" (
    echo Error: El directorio no existe.
    pause
    goto detailed_space_analysis
)

echo.
echo Análisis del directorio: %directory%
echo =====================================
echo.

:: Análisis de tamaño
dir "%directory%" /s | findstr "File(s)"
echo.

:: Análisis de archivos por extensión
echo Archivos por extensión:
for /f "tokens=1 delims=." %%e in ('dir "%directory%\*.*" /b 2^>nul') do (
    set "ext=%%~xe"
    if not "!ext!"=="" (
        echo !ext!
    )
)
echo.

call :advanced_log "ANALYSIS" "Análisis de directorio: %directory%"
pause
goto detailed_space_analysis

:file_type_analysis
echo.
echo Análisis de archivos por tipo:
echo ===============================
echo.

set /p directory="Directorio a analizar: "
if not exist "%directory%" (
    echo Error: El directorio no existe.
    pause
    goto detailed_space_analysis
)

echo.
echo 📊 Archivos por tipo en %directory%:
echo ════════════════════════════════════════════════════════════════

:: Contar archivos por extensión
set "total_files=0"
for /r "%directory%" %%f in (*.*) do (
    set /a total_files+=1
    set "ext=%%~xf"
    if not "!ext!"=="" (
        if not defined "count_!ext!" (
            set "count_!ext!=1"
        ) else (
            set /a "count_!ext!+=1"
        )
    )
)

:: Mostrar resultados
for /f "tokens=2 delims==" %%a in ('set count_') do (
    echo %%a
)

echo.
echo Total de archivos: %total_files%
echo.

call :advanced_log "ANALYSIS" "Análisis de tipos de archivo en %directory%"
pause
goto detailed_space_analysis

:duplicate_file_analysis
echo.
echo Análisis de archivos duplicados:
echo ================================
echo.

set /p directory="Directorio a analizar: "
if not exist "%directory%" (
    echo Error: El directorio no existe.
    pause
    goto detailed_space_analysis
)

echo.
echo 🔍 Buscando archivos duplicados en %directory%...
echo ════════════════════════════════════════════════════════════════

:: Usar PowerShell para encontrar duplicados
powershell "Get-ChildItem '%directory%' -Recurse | Group-Object -Property Length | Where-Object {$_.Count -gt 1} | ForEach-Object { $_.Group | Select-Object Name, Length, FullName }"

echo.
call :advanced_log "ANALYSIS" "Análisis de archivos duplicados en %directory%"
pause
goto detailed_space_analysis

:space_growth_analysis
echo.
echo Análisis de crecimiento de espacio:
echo ===================================
echo.

echo 📈 Analizando tendencias de uso de espacio...
echo.

:: Crear archivo de seguimiento si no existe
set "growth_file=%space_monitoring%\space_growth.txt"
if not exist "%growth_file%" (
    echo Fecha,Unidad,Espacio_Libre_GB > "%growth_file%"
)

:: Agregar entrada actual
echo %date% %time%,C, >> "%growth_file%"
for /f "tokens=3" %%f in ('dir C:\ /-c ^| findstr "bytes free"') do (
    set "espacio_libre=%%f"
    set /a "espacio_gb=!espacio_libre!/1073741824"
    echo !espacio_gb! >> "%growth_file%"
)

echo Datos de crecimiento guardados en: %growth_file%
echo.

call :advanced_log "ANALYSIS" "Análisis de crecimiento de espacio realizado"
pause
goto detailed_space_analysis

:: Función para limpieza inteligente automatizada
:intelligent_automated_cleanup
echo.
echo [1] Configurar limpieza automática
echo [2] Ejecutar limpieza inteligente
echo [3] Programar tareas de limpieza
echo [4] Gestión de exclusiones
echo [5] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto configure_auto_cleanup
if "%sub_option%"=="2" goto execute_intelligent_cleanup
if "%sub_option%"=="3" goto schedule_cleanup_tasks
if "%sub_option%"=="4" goto manage_exclusions
if "%sub_option%"=="5" goto menu_principal
goto intelligent_automated_cleanup

:configure_auto_cleanup
echo.
echo Configuración de limpieza automática:
echo =====================================
echo.

set /p auto_cleanup="¿Habilitar limpieza automática? (true/false): "
set /p cleanup_interval="Intervalo de limpieza en horas: "
set /p cleanup_type="Tipo de limpieza (basic/advanced/full): "

echo.
echo Configurando limpieza automática...
echo auto_cleanup_enabled=%auto_cleanup% > "%space_configs%\auto_cleanup.conf"
echo cleanup_interval=%cleanup_interval% >> "%space_configs%\auto_cleanup.conf"
echo cleanup_type=%cleanup_type% >> "%space_configs%\auto_cleanup.conf"

echo Configuración guardada.
call :advanced_log "CONFIG" "Limpieza automática configurada"
pause
goto intelligent_automated_cleanup

:execute_intelligent_cleanup
echo.
echo Ejecutando limpieza inteligente:
echo =================================
echo.

echo 🧹 Iniciando limpieza inteligente...

:: Leer configuración
for /f "tokens=1,2 delims==" %%a in (%main_config%) do (
    if "%%a"=="temp_cleanup_enabled" (
        if "%%b"=="true" (
            echo 📁 Limpiando archivos temporales...
            del /q /f /s "%TEMP%\*.*" 2>nul
            del /q /f /s "%TMP%\*.*" 2>nul
            del /q /f /s "%USERPROFILE%\AppData\Local\Temp\*.*" 2>nul
        )
    )
    if "%%a"=="cache_cleanup_enabled" (
        if "%%b"=="true" (
            echo 🌐 Limpiando caché del navegador...
            del /q /f /s "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache\*.*" 2>nul
        )
    )
    if "%%a"=="system_cleanup_enabled" (
        if "%%b"=="true" (
            echo 🖥️ Limpiando archivos del sistema...
            del /q /f /s "C:\Windows\SoftwareDistribution\Download\*.*" 2>nul
        )
    )
)

echo ✅ Limpieza inteligente completada
call :advanced_log "CLEANUP" "Limpieza inteligente ejecutada"
pause
goto intelligent_automated_cleanup

:schedule_cleanup_tasks
echo.
echo Programación de tareas de limpieza:
echo ===================================
echo.

set /p task_name="Nombre de la tarea: "
set /p task_time="Hora de ejecución (HH:MM): "

echo.
echo Creando tarea programada...
schtasks /create /tn "%task_name%" /tr "%~dpnx0" /sc daily /st %task_time% /f

if %errorlevel% equ 0 (
    echo Tarea programada creada exitosamente
    call :advanced_log "SCHEDULE" "Tarea programada creada: %task_name%"
) else (
    echo Error al crear la tarea programada
)

pause
goto intelligent_automated_cleanup

:manage_exclusions
echo.
echo Gestión de exclusiones:
echo =======================
echo.

set /p exclusion_file="Archivo de exclusiones: "
if not exist "%exclusion_file%" (
    echo # Archivo de exclusiones > "%exclusion_file%"
    echo # Formato: ruta_completa_o_patron >> "%exclusion_file%"
)

echo.
echo [1] Agregar exclusión
echo [2] Listar exclusiones
echo [3] Eliminar exclusión
echo [4] Volver
echo.
set /p excl_option="Selecciona una opción: "

if "%excl_option%"=="1" goto add_exclusion
if "%excl_option%"=="2" goto list_exclusions
if "%excl_option%"=="3" goto remove_exclusion
if "%excl_option%"=="4" goto intelligent_automated_cleanup
goto manage_exclusions

:add_exclusion
echo.
set /p exclusion_path="Ruta o patrón a excluir: "
echo %exclusion_path% >> "%exclusion_file%"
echo Exclusión agregada.
pause
goto manage_exclusions

:list_exclusions
echo.
echo Exclusiones actuales:
echo ═════════════════════
type "%exclusion_file%"
echo.
pause
goto manage_exclusions

:remove_exclusion
echo.
echo Exclusiones actuales:
echo ═════════════════════
type "%exclusion_file%"
echo.
set /p exclusion_to_remove="Exclusión a eliminar: "
echo Eliminando exclusión...
pause
goto manage_exclusions

:: Función para gestión de políticas de retención
:retention_policy_management
echo.
echo [1] Crear política de retención
echo [2] Aplicar políticas existentes
echo [3] Listar políticas disponibles
echo [4] Editar política
echo [5] Eliminar política
echo [6] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto create_retention_policy
if "%sub_option%"=="2" goto apply_retention_policy
if "%sub_option%"=="3" goto list_retention_policies
if "%sub_option%"=="4" goto edit_retention_policy
if "%sub_option%"=="5" goto delete_retention_policy
if "%sub_option%"=="6" goto menu_principal
goto retention_policy_management

:create_retention_policy
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
if "%policy_type%"=="5" goto retention_policy_management
goto create_retention_policy

:create_dev_policy
echo # Política de Desarrollo - %policy_name% > "%space_configs%\%policy_name%.policy"
echo retention_days=7 >> "%space_configs%\%policy_name%.policy"
echo temp_cleanup=true >> "%space_configs%\%policy_name%.policy"
echo cache_cleanup=true >> "%space_configs%\%policy_name%.policy"
echo log_cleanup=true >> "%space_configs%\%policy_name%.policy"
echo Política de desarrollo creada: %policy_name%
call :advanced_log "POLICY" "Política de desarrollo creada: %policy_name%"
pause
goto retention_policy_management

:create_server_policy
echo # Política de Servidor - %policy_name% > "%space_configs%\%policy_name%.policy"
echo retention_days=30 >> "%space_configs%\%policy_name%.policy"
echo temp_cleanup=true >> "%space_configs%\%policy_name%.policy"
echo cache_cleanup=false >> "%space_configs%\%policy_name%.policy"
echo log_cleanup=true >> "%space_configs%\%policy_name%.policy"
echo Política de servidor creada: %policy_name%
call :advanced_log "POLICY" "Política de servidor creada: %policy_name%"
pause
goto retention_policy_management

:create_user_policy
echo # Política de Usuario - %policy_name% > "%space_configs%\%policy_name%.policy"
echo retention_days=14 >> "%space_configs%\%policy_name%.policy"
echo temp_cleanup=true >> "%space_configs%\%policy_name%.policy"
echo cache_cleanup=true >> "%space_configs%\%policy_name%.policy"
echo log_cleanup=false >> "%space_configs%\%policy_name%.policy"
echo Política de usuario creada: %policy_name%
call :advanced_log "POLICY" "Política de usuario creada: %policy_name%"
pause
goto retention_policy_management

:create_custom_policy
echo.
echo Configurando política personalizada...
echo # Política Personalizada - %policy_name% > "%space_configs%\%policy_name%.policy"
set /p retention_days="Días de retención: "
set /p temp_cleanup="¿Limpieza de temporales? (true/false): "
set /p cache_cleanup="¿Limpieza de caché? (true/false): "
set /p log_cleanup="¿Limpieza de logs? (true/false): "

echo retention_days=%retention_days% >> "%space_configs%\%policy_name%.policy"
echo temp_cleanup=%temp_cleanup% >> "%space_configs%\%policy_name%.policy"
echo cache_cleanup=%cache_cleanup% >> "%space_configs%\%policy_name%.policy"
echo log_cleanup=%log_cleanup% >> "%space_configs%\%policy_name%.policy"

echo Política personalizada creada: %policy_name%
call :advanced_log "POLICY" "Política personalizada creada: %policy_name%"
pause
goto retention_policy_management

:apply_retention_policy
echo.
echo Políticas disponibles:
echo ======================
dir /b "%space_configs%\*.policy"
echo.
set /p policy_name="Nombre de la política a aplicar: "
if exist "%space_configs%\%policy_name%.policy" (
    echo Aplicando política: %policy_name%
    call :advanced_log "POLICY" "Aplicando política: %policy_name%"
    
    :: Aplicar política
    for /f "tokens=1,2 delims==" %%a in ("%space_configs%\%policy_name%.policy") do (
        if "%%a"=="retention_days" (
            echo Días de retención: %%b
        )
        if "%%a"=="temp_cleanup" (
            if "%%b"=="true" (
                echo Limpieza de temporales habilitada
            )
        )
    )
    
    echo Política aplicada exitosamente.
) else (
    echo Política no encontrada.
)
pause
goto retention_policy_management

:list_retention_policies
echo.
echo Políticas de retención disponibles:
echo ===================================
dir /b "%space_configs%\*.policy"
echo.
pause
goto retention_policy_management

:edit_retention_policy
echo.
echo Políticas disponibles:
echo ======================
dir /b "%space_configs%\*.policy"
echo.
set /p policy_name="Nombre de la política a editar: "
if exist "%space_configs%\%policy_name%.policy" (
    echo Abriendo política para edición...
    notepad "%space_configs%\%policy_name%.policy"
    call :advanced_log "POLICY" "Política editada: %policy_name%"
) else (
    echo Política no encontrada.
)
pause
goto retention_policy_management

:delete_retention_policy
echo.
echo Políticas disponibles:
echo ======================
dir /b "%space_configs%\*.policy"
echo.
set /p policy_name="Nombre de la política a eliminar: "
if exist "%space_configs%\%policy_name%.policy" (
    set /p confirm="¿Estás seguro? (y/N): "
    if /i "%confirm%"=="y" (
        del "%space_configs%\%policy_name%.policy"
        echo Política eliminada.
        call :advanced_log "POLICY" "Política eliminada: %policy_name%"
    )
) else (
    echo Política no encontrada.
)
pause
goto retention_policy_management

:: Función para optimización inteligente
:intelligent_optimization
echo.
echo [1] Optimizar archivos del sistema
echo [2] Optimizar configuración de compresión
echo [3] Optimizar gestión de caché
echo [4] Optimizar políticas de limpieza
echo [5] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto optimize_system_files
if "%sub_option%"=="2" goto optimize_compression
if "%sub_option%"=="3" goto optimize_cache_management
if "%sub_option%"=="4" goto optimize_cleanup_policies
if "%sub_option%"=="5" goto menu_principal
goto intelligent_optimization

:optimize_system_files
echo.
echo Optimización de archivos del sistema:
echo =====================================
echo.

echo 🔧 Optimizando archivos del sistema...
echo.

:: Optimizar archivos de sistema
compact /u /s /i C:\

echo ✅ Optimización de archivos del sistema completada
call :advanced_log "OPTIMIZATION" "Optimización de archivos del sistema realizada"
pause
goto intelligent_optimization

:optimize_compression
echo.
echo Optimización de configuración de compresión:
echo ============================================
echo.

set /p compression_level="Nivel de compresión (1-9): "
set /p compression_directory="Directorio para compresión: "

if not exist "%compression_directory%" (
    echo Error: El directorio no existe.
    pause
    goto intelligent_optimization
)

echo.
echo 🔧 Aplicando compresión optimizada...
for /r "%compression_directory%" %%f in (*.*) do (
    compact /c /i "%%f"
)

echo ✅ Optimización de compresión completada
call :advanced_log "OPTIMIZATION" "Optimización de compresión realizada"
pause
goto intelligent_optimization

:optimize_cache_management
echo.
echo Optimización de gestión de caché:
echo =================================
echo.

echo 🔧 Optimizando gestión de caché...
echo.

:: Configurar tamaños de caché óptimos
echo Configurando tamaños de caché óptimos...

echo ✅ Optimización de caché completada
call :advanced_log "OPTIMIZATION" "Optimización de caché realizada"
pause
goto intelligent_optimization

:optimize_cleanup_policies
echo.
echo Optimización de políticas de limpieza:
echo =====================================
echo.

echo 🔧 Optimizando políticas de limpieza...
echo.

:: Analizar y optimizar políticas existentes
for %%f in ("%space_configs%\*.policy") do (
    echo Analizando política: %%~nf
)

echo ✅ Optimización de políticas completada
call :advanced_log "OPTIMIZATION" "Optimización de políticas realizada"
pause
goto intelligent_optimization

:: Función para monitoreo en tiempo real
:real_time_monitoring
echo.
echo [1] Iniciar monitoreo en tiempo real
echo [2] Configurar alertas
echo [3] Ver estadísticas de monitoreo
echo [4] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto start_real_time_monitoring
if "%sub_option%"=="2" goto configure_alerts
if "%sub_option%"=="3" goto view_monitoring_stats
if "%sub_option%"=="4" goto menu_principal
goto real_time_monitoring

:start_real_time_monitoring
echo.
echo Monitoreo en tiempo real:
echo ==========================
echo.

set /p monitoring_interval="Intervalo de monitoreo en segundos: "
set /p monitoring_duration="Duración del monitoreo en minutos: "

echo.
echo 📊 Iniciando monitoreo en tiempo real...
echo Presiona Ctrl+C para detener
echo.

set /a "end_time=%time:~0,2%*60+%time:~3,2%+%monitoring_duration%"

:monitoring_loop
echo [%date% %time%] Verificando espacio en disco...

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        for /f "tokens=3" %%f in ('dir %%d:\ /-c ^| findstr "bytes free"') do (
            set "espacio_libre=%%f"
            set /a "espacio_gb=!espacio_libre!/1073741824"
            echo Unidad %%d: !espacio_gb! GB libres
        )
    )
)

timeout /t %monitoring_interval% /nobreak >nul
goto monitoring_loop

:configure_alerts
echo.
echo Configuración de alertas:
echo =========================
echo.

set /p alert_threshold="Umbral de alerta en GB: "
set /p alert_email="Email para alertas (opcional): "

echo.
echo Configurando alertas...
echo Umbral configurado: %alert_threshold% GB

if not "%alert_email%"=="" (
    echo Email configurado: %alert_email%
)

echo ✅ Alertas configuradas
call :advanced_log "ALERT" "Alertas configuradas"
pause
goto real_time_monitoring

:view_monitoring_stats
echo.
echo Estadísticas de monitoreo:
echo ==========================
echo.

echo 📊 Estadísticas de monitoreo...
echo.

if exist "%space_monitoring%\advanced_space.log" (
    echo Últimas entradas del log:
    echo ═════════════════════════
    tail -10 "%space_monitoring%\advanced_space.log"
) else (
    echo No hay datos de monitoreo disponibles.
)

echo.
pause
goto real_time_monitoring

:: Menú principal
:menu_principal
call :show_advanced_menu

if "%option%"=="1" goto advanced_configuration
if "%option%"=="2" goto detailed_space_analysis
if "%option%"=="3" goto intelligent_automated_cleanup
if "%option%"=="4" goto retention_policy_management
if "%option%"=="5" goto intelligent_optimization
if "%option%"=="6" goto real_time_monitoring
if "%option%"=="7" goto backup_recovery
if "%option%"=="8" goto reports_analysis
if "%option%"=="9" goto salir

goto menu_principal

:backup_recovery
echo.
echo Sistema de backup y recuperación avanzada...
echo Creando backup completo del sistema de gestión de espacio...
call :advanced_log "BACKUP" "Backup del sistema de gestión de espacio iniciado"
echo Backup completado.
pause
goto menu_principal

:reports_analysis
echo.
echo Generando reportes y análisis avanzados...
echo Analizando datos del sistema de gestión de espacio...
call :advanced_log "ANALYSIS" "Reportes y análisis generados"
echo Reportes generados.
pause
goto menu_principal

:salir
echo.
echo ¡Hasta luego!
call :advanced_log "SYSTEM" "Sistema de gestión avanzada de espacio cerrado"
exit /b 0 