@echo off
setlocal enabledelayedexpansion
title Gestión Completa de Etiquetas de Discos
color 0E

:: Verificar privilegios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Este script requiere privilegios de administrador.
    echo Ejecuta como administrador y vuelve a intentar.
    pause
    exit /b 1
)

:: Configuración
set "labels_config=C:\Labels_Config"
set "labels_logs=C:\Labels_Logs"
set "labels_backup=C:\Labels_Backup"

:: Crear directorios si no existen
if not exist "%labels_config%" mkdir "%labels_config%"
if not exist "%labels_logs%" mkdir "%labels_logs%"
if not exist "%labels_backup%" mkdir "%labels_backup%"

echo.
echo ========================================
echo    GESTIÓN COMPLETA DE ETIQUETAS DE DISCOS
echo ========================================
echo.

:menu_principal
echo [1] Ver etiquetas actuales
echo [2] Crear nueva etiqueta
echo [3] Cambiar etiqueta existente
echo [4] Eliminar etiqueta
echo [5] Etiquetar múltiples unidades
echo [6] Validar etiquetas
echo [7] Organización por categorías
echo [8] Backup y restauración
echo [9] Reportes y auditoría
echo [10] Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto ver_etiquetas
if "%opcion%"=="2" goto crear_etiqueta
if "%opcion%"=="3" goto cambiar_etiqueta
if "%opcion%"=="4" goto eliminar_etiqueta
if "%opcion%"=="5" goto etiquetar_multiple
if "%opcion%"=="6" goto validar_etiquetas
if "%opcion%"=="7" goto organizacion_categorias
if "%opcion%"=="8" goto backup_restauracion
if "%opcion%"=="9" goto reportes_auditoria
if "%opcion%"=="10" goto salir
goto menu_principal

:ver_etiquetas
echo.
echo Etiquetas actuales de todas las unidades:
echo =========================================
echo.
echo Unidad | Etiqueta                    | Sistema de Archivos
echo ════════════════════════════════════════════════════════════════

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        set "etiqueta="
        for /f "tokens=*" %%i in ('vol %%d: 2^>nul ^| findstr /v "Volume"') do (
            set "etiqueta=%%i"
        )
        if "!etiqueta!"=="" (
            echo [%%d:]  | Sin etiqueta                    | NTFS
        ) else (
            echo [%%d:]  | !etiqueta! | NTFS
        )
    )
)
echo.
pause
goto menu_principal

:crear_etiqueta
echo.
set /p unidad="Ingresa la letra de la unidad (ej: D): "
if not exist "%unidad%:\" (
    echo Error: La unidad %unidad%: no existe.
    pause
    goto crear_etiqueta
)

set /p nueva_etiqueta="Ingresa la nueva etiqueta: "
if "%nueva_etiqueta%"=="" (
    echo Error: La etiqueta no puede estar vacía.
    pause
    goto crear_etiqueta
)

echo.
echo Creando etiqueta "%nueva_etiqueta%" en %unidad%:...
label %unidad%: %nueva_etiqueta%

if %errorlevel% equ 0 (
    echo Etiqueta creada exitosamente.
    echo.
    echo Verificando...
    vol %unidad%:
) else (
    echo Error al crear la etiqueta.
)
pause
goto menu_principal

:cambiar_etiqueta
echo.
set /p unidad="Ingresa la letra de la unidad (ej: D): "
if not exist "%unidad%:\" (
    echo Error: La unidad %unidad%: no existe.
    pause
    goto cambiar_etiqueta
)

echo.
echo Etiqueta actual de %unidad%::
vol %unidad%:
echo.

set /p nueva_etiqueta="Ingresa la nueva etiqueta: "
if "%nueva_etiqueta%"=="" (
    echo Error: La etiqueta no puede estar vacía.
    pause
    goto cambiar_etiqueta
)

echo.
echo Cambiando etiqueta a "%nueva_etiqueta%" en %unidad%:...
label %unidad%: %nueva_etiqueta%

if %errorlevel% equ 0 (
    echo Etiqueta cambiada exitosamente.
    echo.
    echo Nueva etiqueta:
    vol %unidad%:
) else (
    echo Error al cambiar la etiqueta.
)
pause
goto menu_principal

:eliminar_etiqueta
echo.
set /p unidad="Ingresa la letra de la unidad (ej: D): "
if not exist "%unidad%:\" (
    echo Error: La unidad %unidad%: no existe.
    pause
    goto eliminar_etiqueta
)

echo.
echo Etiqueta actual de %unidad%::
vol %unidad%:
echo.

set /p confirmar="¿Estás seguro de eliminar la etiqueta? (S/N): "
if /i not "%confirmar%"=="S" goto menu_principal

echo.
echo Eliminando etiqueta de %unidad%:...
label %unidad%:

if %errorlevel% equ 0 (
    echo Etiqueta eliminada exitosamente.
    echo.
    echo Verificando:
    vol %unidad%:
) else (
    echo Error al eliminar la etiqueta.
)
pause
goto menu_principal

:etiquetar_multiple
echo.
echo [1] Etiquetado estándar de servidor
echo [2] Etiquetado de desarrollo
echo [3] Etiquetado personalizado
echo [4] Etiquetado con fecha
echo [5] Volver al menú principal
echo.
set /p opcion_multiple="Selecciona una opción: "

if "%opcion_multiple%"=="1" goto etiquetado_servidor
if "%opcion_multiple%"=="2" goto etiquetado_desarrollo
if "%opcion_multiple%"=="3" goto etiquetado_personalizado
if "%opcion_multiple%"=="4" goto etiquetado_fecha
if "%opcion_multiple%"=="5" goto menu_principal
goto etiquetar_multiple

:etiquetado_servidor
echo.
echo Configurando etiquetas estándar de servidor...
label C: SISTEMA_OPERATIVO
label D: DATOS_USUARIOS
label E: RESPALDO_DIARIO
label F: LOGS_SISTEMA
label G: BASE_DE_DATOS
echo Etiquetas de servidor configuradas.
pause
goto menu_principal

:etiquetado_desarrollo
echo.
echo Configurando etiquetas de desarrollo...
label C: SISTEMA_DEV
label D: CODIGO_FUENTE
label E: BASE_DATOS_DEV
label F: DOCUMENTACION
label G: HERRAMIENTAS_DEV
echo Etiquetas de desarrollo configuradas.
pause
goto menu_principal

:etiquetado_personalizado
echo.
set /p unidades="Ingresa las unidades a etiquetar (ej: D E F): "
set /p prefijo="Ingresa el prefijo para las etiquetas: "
for %%u in (%unidades%) do (
    if exist "%%u:\" (
        label %%u: %prefijo%_%%u
        echo %%u: etiquetado como %prefijo%_%%u
    )
)
pause
goto menu_principal

:etiquetado_fecha
echo.
echo Etiquetando con fecha actual...
for %%d in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        label %%d: DISCO_%date:~-4,4%%date:~-10,2%%date:~-7,2%
        echo %%d: etiquetado con fecha
    )
)
pause
goto menu_principal

:validar_etiquetas
echo.
echo Validando etiquetas de todas las unidades...
echo ===========================================
echo.

set "unidades_sin_etiqueta=0"
set "unidades_con_etiqueta=0"

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        vol %%d: | findstr /i "no label" >nul
        if !errorlevel! equ 0 (
            echo ❌ %%d: - Sin etiqueta
            set /a unidades_sin_etiqueta+=1
        ) else (
            echo ✅ %%d: - Con etiqueta
            set /a unidades_con_etiqueta+=1
        )
    )
)

echo.
echo RESUMEN DE VALIDACIÓN:
echo ======================
echo Unidades con etiqueta: %unidades_con_etiqueta%
echo Unidades sin etiqueta: %unidades_sin_etiqueta%
echo.

if %unidades_sin_etiqueta% gtr 0 (
    echo ⚠️ Se encontraron unidades sin etiquetar.
    echo Considera etiquetarlas para mejor organización.
) else (
    echo 🎉 ¡Todas las unidades están correctamente etiquetadas!
)
pause
goto menu_principal

:organizacion_categorias
echo.
echo [1] Categoría: SISTEMA
echo [2] Categoría: DATOS
echo [3] Categoría: RESPALDO
echo [4] Categoría: MULTIMEDIA
echo [5] Categoría: DESARROLLO
echo [6] Volver al menú principal
echo.
set /p categoria="Selecciona una categoría: "

if "%categoria%"=="1" goto categoria_sistema
if "%categoria%"=="2" goto categoria_datos
if "%categoria%"=="3" goto categoria_respaldo
if "%categoria%"=="4" goto categoria_multimedia
if "%categoria%"=="5" goto categoria_desarrollo
if "%categoria%"=="6" goto menu_principal
goto organizacion_categorias

:categoria_sistema
echo.
echo Configurando categoría SISTEMA...
label C: SISTEMA_OPERATIVO
label D: SISTEMA_LOGS
label E: SISTEMA_TEMP
echo Categoría SISTEMA configurada.
pause
goto menu_principal

:categoria_datos
echo.
echo Configurando categoría DATOS...
label F: DATOS_USUARIOS
label G: DATOS_APLICACIONES
label H: DATOS_CRITICOS
echo Categoría DATOS configurada.
pause
goto menu_principal

:categoria_respaldo
echo.
echo Configurando categoría RESPALDO...
label I: RESPALDO_DIARIO
label J: RESPALDO_SEMANAL
label K: RESPALDO_MENSUAL
echo Categoría RESPALDO configurada.
pause
goto menu_principal

:categoria_multimedia
echo.
echo Configurando categoría MULTIMEDIA...
label L: MULTIMEDIA_VIDEOS
label M: MULTIMEDIA_IMAGENES
label N: MULTIMEDIA_AUDIO
echo Categoría MULTIMEDIA configurada.
pause
goto menu_principal

:categoria_desarrollo
echo.
echo Configurando categoría DESARROLLO...
label O: DESARROLLO_CODIGO
label P: DESARROLLO_DB
label Q: DESARROLLO_DOCS
echo Categoría DESARROLLO configurada.
pause
goto menu_principal

:backup_restauracion
echo.
echo [1] Crear backup de etiquetas
echo [2] Restaurar etiquetas desde backup
echo [3] Exportar configuración actual
echo [4] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto crear_backup_etiquetas
if "%sub_opcion%"=="2" goto restaurar_etiquetas
if "%sub_opcion%"=="3" goto exportar_configuracion
if "%sub_opcion%"=="4" goto menu_principal
goto backup_restauracion

:crear_backup_etiquetas
echo.
set /p backup_name="Nombre del backup: "
echo.
echo Creando backup de etiquetas...

echo [Disk_Labels] > "%labels_backup%\%backup_name%.ini"
echo Backup_Date=%date% %time% >> "%labels_backup%\%backup_name%.ini"
echo. >> "%labels_backup%\%backup_name%.ini"

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo [%%d:] >> "%labels_backup%\%backup_name%.ini"
        vol %%d: >> "%labels_backup%\%backup_name%.ini" 2>nul
        echo. >> "%labels_backup%\%backup_name%.ini"
    )
)

echo Backup creado: %labels_backup%\%backup_name%.ini
pause
goto backup_restauracion

:restaurar_etiquetas
echo.
echo Backups disponibles:
echo ====================
dir /b "%labels_backup%\*.ini"
echo.
set /p backup_file="Nombre del archivo de backup: "
if exist "%labels_backup%\%backup_file%" (
    echo Restaurando etiquetas desde %backup_file%...
    echo Restauración manual requerida.
) else (
    echo Backup no encontrado.
)
pause
goto backup_restauracion

:exportar_configuracion
echo.
set /p export_file="Nombre del archivo de exportación: "
echo.
echo Exportando configuración actual...

echo Configuración de Etiquetas de Discos > "%labels_logs%\%export_file%.txt"
echo Fecha: %date% %time% >> "%labels_logs%\%export_file%.txt"
echo ======================================== >> "%labels_logs%\%export_file%.txt"
echo. >> "%labels_logs%\%export_file%.txt"

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo Unidad %%d:: >> "%labels_logs%\%export_file%.txt"
        vol %%d: >> "%labels_logs%\%export_file%.txt" 2>nul
        echo. >> "%labels_logs%\%export_file%.txt"
    )
)

echo Configuración exportada: %labels_logs%\%export_file%.txt
pause
goto backup_restauracion

:reportes_auditoria
echo.
echo [1] Generar reporte completo
echo [2] Auditoría de cumplimiento
echo [3] Estadísticas de etiquetas
echo [4] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto reporte_completo
if "%sub_opcion%"=="2" goto auditoria_cumplimiento
if "%sub_opcion%"=="3" goto estadisticas_etiquetas
if "%sub_opcion%"=="4" goto menu_principal
goto reportes_auditoria

:reporte_completo
echo.
set /p report_name="Nombre del reporte: "
echo.
echo Generando reporte completo de etiquetas...

echo Reporte Completo de Etiquetas de Discos > "%labels_logs%\%report_name%.txt"
echo Fecha: %date% %time% >> "%labels_logs%\%report_name%.txt"
echo ======================================== >> "%labels_logs%\%report_name%.txt"
echo. >> "%labels_logs%\%report_name%.txt"

echo Unidad | Etiqueta | Sistema | Tamaño >> "%labels_logs%\%report_name%.txt"
echo ════════════════════════════════════════════════════════════════ >> "%labels_logs%\%report_name%.txt"

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        set "etiqueta="
        for /f "tokens=*" %%i in ('vol %%d: 2^>nul ^| findstr /v "Volume"') do (
            set "etiqueta=%%i"
        )
        if "!etiqueta!"=="" (
            echo [%%d:] | Sin etiqueta | NTFS | >> "%labels_logs%\%report_name%.txt"
        ) else (
            echo [%%d:] | !etiqueta! | NTFS | >> "%labels_logs%\%report_name%.txt"
        )
    )
)

echo Reporte generado: %labels_logs%\%report_name%.txt
pause
goto reportes_auditoria

:auditoria_cumplimiento
echo.
echo Auditoría de cumplimiento de etiquetas:
echo =======================================
echo.

set "cumplimiento=0"
set "total_unidades=0"

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        set /a total_unidades+=1
        vol %%d: | findstr /i "no label" >nul
        if !errorlevel! equ 0 (
            echo ❌ %%d: - NO CUMPLE
        ) else (
            echo ✅ %%d: - CUMPLE
            set /a cumplimiento+=1
        )
    )
)

echo.
echo RESUMEN DE CUMPLIMIENTO:
echo ========================
echo Unidades que cumplen: %cumplimiento%/%total_unidades%
echo Porcentaje de cumplimiento: %cumplimiento%/%total_unidades%
pause
goto reportes_auditoria

:estadisticas_etiquetas
echo.
echo Estadísticas de etiquetas:
echo ==========================
echo.

set "etiquetas_sistema=0"
set "etiquetas_datos=0"
set "etiquetas_respaldo=0"
set "etiquetas_multimedia=0"
set "etiquetas_desarrollo=0"
set "otras_etiquetas=0"

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        vol %%d: | findstr /i "SISTEMA" >nul
        if !errorlevel! equ 0 set /a etiquetas_sistema+=1
        
        vol %%d: | findstr /i "DATOS" >nul
        if !errorlevel! equ 0 set /a etiquetas_datos+=1
        
        vol %%d: | findstr /i "RESPALDO" >nul
        if !errorlevel! equ 0 set /a etiquetas_respaldo+=1
        
        vol %%d: | findstr /i "MULTIMEDIA" >nul
        if !errorlevel! equ 0 set /a etiquetas_multimedia+=1
        
        vol %%d: | findstr /i "DESARROLLO" >nul
        if !errorlevel! equ 0 set /a etiquetas_desarrollo+=1
    )
)

echo Categorías de etiquetas:
echo - SISTEMA: %etiquetas_sistema%
echo - DATOS: %etiquetas_datos%
echo - RESPALDO: %etiquetas_respaldo%
echo - MULTIMEDIA: %etiquetas_multimedia%
echo - DESARROLLO: %etiquetas_desarrollo%
echo.
pause
goto reportes_auditoria

:salir
echo.
echo ¡Hasta luego!
exit /b 0 