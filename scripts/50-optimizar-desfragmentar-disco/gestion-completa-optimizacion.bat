@echo off
setlocal enabledelayedexpansion
title Gestión Completa de Optimización de Disco
color 0B

:: Verificar privilegios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Este script requiere privilegios de administrador.
    echo Ejecuta como administrador y vuelve a intentar.
    pause
    exit /b 1
)

:: Configuración
set "optimize_config=C:\Optimize_Config"
set "optimize_logs=C:\Optimize_Logs"
set "optimize_backup=C:\Optimize_Backup"

:: Crear directorios si no existen
if not exist "%optimize_config%" mkdir "%optimize_config%"
if not exist "%optimize_logs%" mkdir "%optimize_logs%"
if not exist "%optimize_backup%" mkdir "%optimize_backup%"

echo.
echo ========================================
echo    GESTIÓN COMPLETA DE OPTIMIZACIÓN DE DISCO
echo ========================================
echo.

:menu_principal
echo [1] Análisis de fragmentación
echo [2] Desfragmentación básica
echo [3] Optimización de SSD
echo [4] Optimización de HDD
echo [5] Verificación de errores
echo [6] Optimización de todas las unidades
echo [7] Programar tareas de optimización
echo [8] Reportes y auditoría
echo [9] Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto analisis_fragmentacion
if "%opcion%"=="2" goto desfragmentacion_basica
if "%opcion%"=="3" goto optimizacion_ssd
if "%opcion%"=="4" goto optimizacion_hdd
if "%opcion%"=="5" goto verificacion_errores
if "%opcion%"=="6" goto optimizacion_todas_unidades
if "%opcion%"=="7" goto programar_tareas
if "%opcion%"=="8" goto reportes_auditoria
if "%opcion%"=="9" goto salir
goto menu_principal

:analisis_fragmentacion
echo.
echo Análisis de fragmentación:
echo ===========================
echo.

echo 🔍 Analizando fragmentación de todas las unidades...
echo.

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo 📁 Unidad %%d::
        echo ════════════════════════════════════════════════════════════════
        defrag %%d: /A /V
        echo.
    )
)

echo ✅ Análisis de fragmentación completado
echo.
pause
goto menu_principal

:desfragmentacion_basica
echo.
echo Desfragmentación básica:
echo ========================
echo.

set /p unidad="Unidad a desfragmentar (ej: C): "
if not exist "%unidad%:\" (
    echo Error: La unidad no existe.
    pause
    goto desfragmentacion_basica
)

echo.
echo ⚠️ Iniciando desfragmentación de la unidad %unidad%:...
echo ⏰ Este proceso puede tomar varios minutos...
echo.

defrag %unidad%: /U /V

echo.
echo ✅ Desfragmentación completada
echo.
pause
goto menu_principal

:optimizacion_ssd
echo.
echo Optimización de SSD:
echo ====================
echo.

echo 🔧 Verificando tipo de unidad...
wmic logicaldisk where "DeviceID='C:'" get MediaType

echo.
echo ⚡ Ejecutando optimización específica para SSD...

:: Optimización específica para SSD
defrag C: /O /U /V

echo.
echo 🔄 Ejecutando TRIM en SSD...
powershell -Command "Optimize-Volume -DriveLetter C -ReTrim -Verbose"

echo.
echo ✅ Optimización de SSD completada
echo.
pause
goto menu_principal

:optimizacion_hdd
echo.
echo Optimización de HDD:
echo ====================
echo.

echo 🔧 Verificando tipo de unidad...
wmic logicaldisk where "DeviceID='C:'" get MediaType

echo.
echo 💿 Ejecutando optimización específica para HDD...

:: Optimización específica para HDD
defrag C: /U /V

echo.
echo ✅ Optimización de HDD completada
echo.
pause
goto menu_principal

:verificacion_errores
echo.
echo Verificación de errores:
echo ========================
echo.

echo 🔍 Verificando integridad del disco antes de optimización...
echo.

chkdsk C: /F /R

echo.
echo ✅ Verificación de errores completada
echo.
pause
goto menu_principal

:optimizacion_todas_unidades
echo.
echo Optimización de todas las unidades:
echo ====================================
echo.

echo ⚠️ Esta operación optimizará todas las unidades del sistema.
echo ⏰ Este proceso puede tomar mucho tiempo...
echo.

set /p confirmar="¿Continuar? (S/N): "
if /i not "%confirmar%"=="S" goto menu_principal

echo.
echo 🔄 Iniciando optimización de todas las unidades...

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo 📁 Optimizando unidad %%d:...
        
        :: Detectar tipo de unidad
        for /f "tokens=2" %%i in ('wmic logicaldisk where "DeviceID='%%d:'" get MediaType /value ^| findstr "MediaType"') do (
            set "tipo_unidad=%%i"
        )
        
        if "!tipo_unidad!"=="4" (
            echo 💾 SSD detectado - Aplicando optimización específica...
            defrag %%d: /O /U /V
            powershell -Command "Optimize-Volume -DriveLetter %%d -ReTrim -Verbose"
        ) else (
            echo 💿 HDD detectado - Aplicando desfragmentación completa...
            defrag %%d: /U /V
        )
        echo.
    )
)

echo ✅ Optimización de todas las unidades completada
echo.
pause
goto menu_principal

:programar_tareas
echo.
echo Programación de tareas de optimización:
echo =======================================
echo.

echo [1] Optimización semanal
echo [2] Optimización mensual
echo [3] Optimización personalizada
echo [4] Ver tareas programadas
echo [5] Eliminar tareas programadas
echo [6] Volver al menú principal
echo.
set /p opcion_prog="Selecciona una opción: "

if "%opcion_prog%"=="1" goto optimizacion_semanal
if "%opcion_prog%"=="2" goto optimizacion_mensual
if "%opcion_prog%"=="3" goto optimizacion_personalizada
if "%opcion_prog%"=="4" goto ver_tareas
if "%opcion_prog%"=="5" goto eliminar_tareas
if "%opcion_prog%"=="6" goto menu_principal
goto programar_tareas

:optimizacion_semanal
echo.
echo 📅 Configurando optimización semanal...
schtasks /create /tn "Optimizacion_Disco_Semanal" /tr "defrag C: /U /V" /sc weekly /d SUN /st 02:00 /ru SYSTEM

if %errorlevel% equ 0 (
    echo ✅ Tarea semanal configurada exitosamente
) else (
    echo ❌ Error al configurar tarea semanal
)

pause
goto programar_tareas

:optimizacion_mensual
echo.
echo 📅 Configurando optimización mensual...
schtasks /create /tn "Optimizacion_Disco_Mensual" /tr "defrag C: /U /V" /sc monthly /d 1 /st 02:00 /ru SYSTEM

if %errorlevel% equ 0 (
    echo ✅ Tarea mensual configurada exitosamente
) else (
    echo ❌ Error al configurar tarea mensual
)

pause
goto programar_tareas

:optimizacion_personalizada
echo.
set /p dias="Días entre optimizaciones (ej: 7): "
set /p hora="Hora de ejecución (ej: 02:00): "

echo.
echo 📅 Configurando optimización personalizada...
schtasks /create /tn "Optimizacion_Disco_Personalizada" /tr "defrag C: /U /V" /sc daily /mo %dias% /st %hora% /ru SYSTEM

if %errorlevel% equ 0 (
    echo ✅ Tarea personalizada configurada exitosamente
) else (
    echo ❌ Error al configurar tarea personalizada
)

pause
goto programar_tareas

:ver_tareas
echo.
echo 📋 Tareas programadas de optimización:
echo ════════════════════════════════════════════════════════════════
schtasks /query | findstr "Optimizacion"
echo.
pause
goto programar_tareas

:eliminar_tareas
echo.
echo 🗑️ Eliminando tareas de optimización...
schtasks /delete /tn "Optimizacion_Disco_Semanal" /f 2>nul
schtasks /delete /tn "Optimizacion_Disco_Mensual" /f 2>nul
schtasks /delete /tn "Optimizacion_Disco_Personalizada" /f 2>nul
echo ✅ Tareas eliminadas
echo.
pause
goto programar_tareas

:reportes_auditoria
echo.
echo [1] Generar reporte de optimización
echo [2] Análisis de rendimiento
echo [3] Auditoría de fragmentación
echo [4] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto generar_reporte
if "%sub_opcion%"=="2" goto analisis_rendimiento
if "%sub_opcion%"=="3" goto auditoria_fragmentacion
if "%sub_opcion%"=="4" goto menu_principal
goto reportes_auditoria

:generar_reporte
echo.
set /p report_name="Nombre del reporte: "
echo.
echo Generando reporte de optimización...

echo Reporte de Optimización de Disco > "%optimize_logs%\%report_name%.txt"
echo Fecha: %date% %time% >> "%optimize_logs%\%report_name%.txt"
echo ======================================== >> "%optimize_logs%\%report_name%.txt"
echo. >> "%optimize_logs%\%report_name%.txt"

echo ANÁLISIS DE FRAGMENTACIÓN: >> "%optimize_logs%\%report_name%.txt"
echo ════════════════════════════════════════════════════════════════ >> "%optimize_logs%\%report_name%.txt"
defrag C: /A /V >> "%optimize_logs%\%report_name%.txt"
echo. >> "%optimize_logs%\%report_name%.txt"

echo INFORMACIÓN DE UNIDADES: >> "%optimize_logs%\%report_name%.txt"
echo ════════════════════════════════════════════════════════════════ >> "%optimize_logs%\%report_name%.txt"
wmic logicaldisk get size,freespace,caption,mediatype >> "%optimize_logs%\%report_name%.txt"

echo Reporte generado: %optimize_logs%\%report_name%.txt
pause
goto reportes_auditoria

:analisis_rendimiento
echo.
echo Análisis de rendimiento:
echo ========================
echo.

echo 📊 Analizando rendimiento de disco...
echo.

:: Análisis básico de rendimiento
echo Información de unidades:
wmic logicaldisk get deviceid,size,freespace,mediatype

echo.
echo Análisis de fragmentación actual:
defrag C: /A /V

echo.
pause
goto reportes_auditoria

:auditoria_fragmentacion
echo.
echo Auditoría de fragmentación:
echo ============================
echo.

echo 🔍 Realizando auditoría completa de fragmentación...
echo.

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo 📁 Unidad %%d::
        echo ════════════════════════════════════════════════════════════════
        defrag %%d: /A /V
        echo.
    )
)

echo ✅ Auditoría de fragmentación completada
echo.
pause
goto reportes_auditoria

:salir
echo.
echo ¡Hasta luego!
exit /b 0 