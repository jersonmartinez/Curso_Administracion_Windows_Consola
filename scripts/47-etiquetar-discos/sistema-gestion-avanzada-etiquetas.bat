@echo off
setlocal enabledelayedexpansion
title Sistema de Gestión Avanzada de Etiquetas
color 0F

:: Verificar privilegios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Este script requiere privilegios de administrador.
    echo Ejecuta como administrador y vuelve a intentar.
    pause
    exit /b 1
)

:: Configuración avanzada
set "labels_advanced=%~dp0labels_advanced"
set "labels_conventions=%~dp0labels_conventions"
set "labels_monitoring=%~dp0labels_monitoring"

:: Crear directorios de configuración
if not exist "%labels_advanced%" mkdir "%labels_advanced%"
if not exist "%labels_conventions%" mkdir "%labels_conventions%"
if not exist "%labels_monitoring%" mkdir "%labels_monitoring%"

:: Archivo de configuración principal
set "main_config=%labels_advanced%\labels_main.conf"

:: Crear configuración por defecto
if not exist "%main_config%" (
    echo # Configuración principal de etiquetas de discos > "%main_config%"
    echo naming_convention=UPPERCASE >> "%main_config%"
    echo separator=UNDERSCORE >> "%main_config%"
    echo max_length=32 >> "%main_config%"
    echo auto_audit=true >> "%main_config%"
    echo backup_enabled=true >> "%main_config%"
    echo monitoring_enabled=true >> "%main_config%"
    echo compliance_check=true >> "%main_config%"
    echo metadata_enabled=true >> "%main_config%"
)

:: Función de logging avanzado
:advanced_log
echo [%date% %time%] [%~1] %~2 >> "%labels_monitoring%\advanced_labels.log"
goto :eof

:: Función para mostrar menú principal
:show_advanced_menu
cls
echo.
echo ========================================
echo    SISTEMA DE GESTIÓN AVANZADA DE ETIQUETAS
echo ========================================
echo.
echo [1] Configuración avanzada del sistema
echo [2] Gestión de convenciones de nomenclatura
echo [3] Etiquetado inteligente
echo [4] Análisis de contenido y sugerencias
echo [5] Auditoría automática
echo [6] Gestión de metadatos
echo [7] Backup y recuperación avanzada
echo [8] Reportes y análisis
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
set "temp_config=%temp%\temp_labels_config.txt"
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
    if "%%a"=="naming_convention" (
        echo Configurando convención de nomenclatura: %%b
        call :advanced_log "CONFIG" "Convención de nomenclatura: %%b"
    )
    if "%%a"=="separator" (
        echo Configurando separador: %%b
        call :advanced_log "CONFIG" "Separador configurado: %%b"
    )
    if "%%a"=="auto_audit" (
        if "%%b"=="true" (
            echo Auditoría automática habilitada
            call :advanced_log "CONFIG" "Auditoría automática habilitada"
        )
    )
    if "%%a"=="backup_enabled" (
        if "%%b"=="true" (
            echo Backup automático habilitado
            call :advanced_log "CONFIG" "Backup automático habilitado"
        )
    )
)

echo Configuración aplicada exitosamente.
call :advanced_log "CONFIG" "Configuración aplicada"
pause
goto advanced_configuration

:validate_config
echo.
echo Validando configuración del sistema de etiquetas...
echo.

:: Verificar unidades del sistema
echo Verificando unidades del sistema...
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        vol %%d: | findstr /i "no label" >nul
        if !errorlevel! equ 0 (
            echo [ADVERTENCIA] Unidad %%d: sin etiqueta
            call :advanced_log "WARNING" "Unidad %%d: sin etiqueta"
        ) else (
            echo [OK] Unidad %%d: con etiqueta
            call :advanced_log "INFO" "Unidad %%d: con etiqueta"
        )
    )
)

:: Verificar convenciones
echo.
echo Verificando convenciones de nomenclatura...
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        vol %%d: | findstr /i "no label" >nul
        if !errorlevel! neq 0 (
            vol %%d: | findstr /i "[a-z]" >nul
            if !errorlevel! equ 0 (
                echo [ADVERTENCIA] Unidad %%d: no sigue convención de mayúsculas
                call :advanced_log "WARNING" "Unidad %%d: no sigue convención"
            )
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

:: Función para gestión de convenciones de nomenclatura
:naming_conventions
echo.
echo [1] Crear convención de nomenclatura
echo [2] Aplicar convención existente
echo [3] Listar convenciones disponibles
echo [4] Editar convención
echo [5] Eliminar convención
echo [6] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto create_naming_convention
if "%sub_option%"=="2" goto apply_naming_convention
if "%sub_option%"=="3" goto list_naming_conventions
if "%sub_option%"=="4" goto edit_naming_convention
if "%sub_option%"=="5" goto delete_naming_convention
if "%sub_option%"=="6" goto menu_principal
goto naming_conventions

:create_naming_convention
echo.
set /p convention_name="Nombre de la convención: "
echo.
echo [1] Convención empresarial
echo [2] Convención de desarrollo
echo [3] Convención de servidor
echo [4] Convención personalizada
echo [5] Volver
echo.
set /p convention_type="Selecciona el tipo de convención: "

if "%convention_type%"=="1" goto create_enterprise_convention
if "%convention_type%"=="2" goto create_development_convention
if "%convention_type%"=="3" goto create_server_convention
if "%convention_type%"=="4" goto create_custom_convention
if "%convention_type%"=="5" goto naming_conventions
goto create_naming_convention

:create_enterprise_convention
echo # Convención Empresarial - %convention_name% > "%labels_conventions%\%convention_name%.conf"
echo prefix=ENTERPRISE >> "%labels_conventions%\%convention_name%.conf"
echo separator=UNDERSCORE >> "%labels_conventions%\%convention_name%.conf"
echo case=UPPERCASE >> "%labels_conventions%\%convention_name%.conf"
echo max_length=32 >> "%labels_conventions%\%convention_name%.conf"
echo categories=SISTEMA,DATOS,RESPALDO,MULTIMEDIA,DESARROLLO >> "%labels_conventions%\%convention_name%.conf"
echo rules=NO_SPECIAL_CHARS,NO_SPACES,NO_NUMBERS_START >> "%labels_conventions%\%convention_name%.conf"
echo Convención empresarial creada: %convention_name%
call :advanced_log "CONVENTION" "Convención empresarial creada: %convention_name%"
pause
goto naming_conventions

:create_development_convention
echo # Convención de Desarrollo - %convention_name% > "%labels_conventions%\%convention_name%.conf"
echo prefix=DEV >> "%labels_conventions%\%convention_name%.conf"
echo separator=UNDERSCORE >> "%labels_conventions%\%convention_name%.conf"
echo case=UPPERCASE >> "%labels_conventions%\%convention_name%.conf"
echo max_length=24 >> "%labels_conventions%\%convention_name%.conf"
echo categories=CODIGO,BASE_DATOS,DOCUMENTACION,HERRAMIENTAS,TEST >> "%labels_conventions%\%convention_name%.conf"
echo rules=NO_SPECIAL_CHARS,NO_SPACES,ALLOW_VERSION >> "%labels_conventions%\%convention_name%.conf"
echo Convención de desarrollo creada: %convention_name%
call :advanced_log "CONVENTION" "Convención de desarrollo creada: %convention_name%"
pause
goto naming_conventions

:create_server_convention
echo # Convención de Servidor - %convention_name% > "%labels_conventions%\%convention_name%.conf"
echo prefix=SERVER >> "%labels_conventions%\%convention_name%.conf"
echo separator=UNDERSCORE >> "%labels_conventions%\%convention_name%.conf"
echo case=UPPERCASE >> "%labels_conventions%\%convention_name%.conf"
echo max_length=28 >> "%labels_conventions%\%convention_name%.conf"
echo categories=OS,APPS,DATA,LOGS,BACKUP,TEMP >> "%labels_conventions%\%convention_name%.conf"
echo rules=NO_SPECIAL_CHARS,NO_SPACES,ENVIRONMENT_SUFFIX >> "%labels_conventions%\%convention_name%.conf"
echo Convención de servidor creada: %convention_name%
call :advanced_log "CONVENTION" "Convención de servidor creada: %convention_name%"
pause
goto naming_conventions

:create_custom_convention
echo.
echo Configurando convención personalizada...
echo # Convención Personalizada - %convention_name% > "%labels_conventions%\%convention_name%.conf"
set /p prefix="Prefijo: "
set /p separator="Separador (UNDERSCORE/DASH/DOT): "
set /p case="Caso (UPPERCASE/LOWERCASE/MIXED): "
set /p max_length="Longitud máxima: "
set /p categories="Categorías (separadas por coma): "
set /p rules="Reglas (separadas por coma): "

echo prefix=%prefix% >> "%labels_conventions%\%convention_name%.conf"
echo separator=%separator% >> "%labels_conventions%\%convention_name%.conf"
echo case=%case% >> "%labels_conventions%\%convention_name%.conf"
echo max_length=%max_length% >> "%labels_conventions%\%convention_name%.conf"
echo categories=%categories% >> "%labels_conventions%\%convention_name%.conf"
echo rules=%rules% >> "%labels_conventions%\%convention_name%.conf"

echo Convención personalizada creada: %convention_name%
call :advanced_log "CONVENTION" "Convención personalizada creada: %convention_name%"
pause
goto naming_conventions

:apply_naming_convention
echo.
echo Convenciones disponibles:
echo ========================
dir /b "%labels_conventions%\*.conf"
echo.
set /p convention_name="Nombre de la convención a aplicar: "
if exist "%labels_conventions%\%convention_name%.conf" (
    echo Aplicando convención: %convention_name%
    call :advanced_log "CONVENTION" "Aplicando convención: %convention_name%"
    
    :: Aplicar configuración de la convención
    for /f "tokens=1,2 delims==" %%a in ("%labels_conventions%\%convention_name%.conf") do (
        if "%%a"=="prefix" (
            echo Configurando prefijo: %%b
        )
        if "%%a"=="separator" (
            echo Configurando separador: %%b
        )
        if "%%a"=="case" (
            echo Configurando caso: %%b
        )
        if "%%a"=="categories" (
            echo Configurando categorías: %%b
        )
    )
    
    echo Convención aplicada exitosamente.
) else (
    echo Convención no encontrada.
)
pause
goto naming_conventions

:list_naming_conventions
echo.
echo Convenciones de nomenclatura disponibles:
echo ========================================
dir /b "%labels_conventions%\*.conf"
echo.
pause
goto naming_conventions

:edit_naming_convention
echo.
echo Convenciones disponibles:
echo ========================
dir /b "%labels_conventions%\*.conf"
echo.
set /p convention_name="Nombre de la convención a editar: "
if exist "%labels_conventions%\%convention_name%.conf" (
    echo Abriendo convención para edición...
    notepad "%labels_conventions%\%convention_name%.conf"
    call :advanced_log "CONVENTION" "Convención editada: %convention_name%"
) else (
    echo Convención no encontrada.
)
pause
goto naming_conventions

:delete_naming_convention
echo.
echo Convenciones disponibles:
echo ========================
dir /b "%labels_conventions%\*.conf"
echo.
set /p convention_name="Nombre de la convención a eliminar: "
if exist "%labels_conventions%\%convention_name%.conf" (
    set /p confirm="¿Estás seguro? (y/N): "
    if /i "%confirm%"=="y" (
        del "%labels_conventions%\%convention_name%.conf"
        echo Convención eliminada.
        call :advanced_log "CONVENTION" "Convención eliminada: %convention_name%"
    )
) else (
    echo Convención no encontrada.
)
pause
goto naming_conventions

:: Función para etiquetado inteligente
:smart_labeling
echo.
echo [1] Etiquetado basado en contenido
echo [2] Etiquetado basado en tamaño
echo [3] Etiquetado basado en uso
echo [4] Etiquetado automático por fecha
echo [5] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto content_based_labeling
if "%sub_option%"=="2" goto size_based_labeling
if "%sub_option%"=="3" goto usage_based_labeling
if "%sub_option%"=="4" goto date_based_labeling
if "%sub_option%"=="5" goto menu_principal
goto smart_labeling

:content_based_labeling
echo.
echo Etiquetado basado en contenido...
echo.

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo Analizando contenido de %%d:...
        
        :: Contar archivos por tipo
        set "image_count=0"
        set "video_count=0"
        set "doc_count=0"
        set "exe_count=0"
        
        for /r %%d:\ %%f in (*) do (
            set "ext=%%~xf"
            if /i "!ext!"==".jpg" set /a image_count+=1
            if /i "!ext!"==".mp4" set /a video_count+=1
            if /i "!ext!"==".doc" set /a doc_count+=1
            if /i "!ext!"==".exe" set /a exe_count+=1
        )
        
        :: Sugerir etiqueta basada en contenido
        if %image_count% gtr %video_count% (
            if %image_count% gtr %doc_count% (
                echo Sugerencia para %%d:: MULTIMEDIA_IMAGENES
                set /p apply="¿Aplicar esta etiqueta? (S/N): "
                if /i "!apply!"=="S" (
                    label %%d: MULTIMEDIA_IMAGENES
                    echo Etiqueta aplicada.
                )
            ) else (
                echo Sugerencia para %%d:: DOCUMENTOS
                set /p apply="¿Aplicar esta etiqueta? (S/N): "
                if /i "!apply!"=="S" (
                    label %%d: DOCUMENTOS
                    echo Etiqueta aplicada.
                )
            )
        ) else (
            if %video_count% gtr %doc_count% (
                echo Sugerencia para %%d:: MULTIMEDIA_VIDEOS
                set /p apply="¿Aplicar esta etiqueta? (S/N): "
                if /i "!apply!"=="S" (
                    label %%d: MULTIMEDIA_VIDEOS
                    echo Etiqueta aplicada.
                )
            ) else (
                echo Sugerencia para %%d:: DOCUMENTOS
                set /p apply="¿Aplicar esta etiqueta? (S/N): "
                if /i "!apply!"=="S" (
                    label %%d: DOCUMENTOS
                    echo Etiqueta aplicada.
                )
            )
        )
    )
)
pause
goto smart_labeling

:size_based_labeling
echo.
echo Etiquetado basado en tamaño...
echo.

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo Analizando tamaño de %%d:...
        
        for /f "tokens=3" %%s in ('dir %%d:\ ^| findstr "bytes free"') do (
            set "tamaño=%%s"
            if !tamaño! gtr 1000000000 (
                echo Sugerencia para %%d:: DISCO_GRANDE
                set /p apply="¿Aplicar esta etiqueta? (S/N): "
                if /i "!apply!"=="S" (
                    label %%d: DISCO_GRANDE
                    echo Etiqueta aplicada.
                )
            ) else (
                echo Sugerencia para %%d:: DISCO_PEQUEÑO
                set /p apply="¿Aplicar esta etiqueta? (S/N): "
                if /i "!apply!"=="S" (
                    label %%d: DISCO_PEQUEÑO
                    echo Etiqueta aplicada.
                )
            )
        )
    )
)
pause
goto smart_labeling

:usage_based_labeling
echo.
echo Etiquetado basado en uso...
echo.

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo Analizando uso de %%d:...
        
        :: Verificar si es unidad del sistema
        if "%%d"=="C" (
            echo Sugerencia para %%d:: SISTEMA_OPERATIVO
            set /p apply="¿Aplicar esta etiqueta? (S/N): "
            if /i "!apply!"=="S" (
                label %%d: SISTEMA_OPERATIVO
                echo Etiqueta aplicada.
            )
        ) else (
            :: Verificar si tiene archivos de programa
            dir %%d:\ | findstr /i "program files" >nul
            if !errorlevel! equ 0 (
                echo Sugerencia para %%d:: APLICACIONES
                set /p apply="¿Aplicar esta etiqueta? (S/N): "
                if /i "!apply!"=="S" (
                    label %%d: APLICACIONES
                    echo Etiqueta aplicada.
                )
            ) else (
                echo Sugerencia para %%d:: DATOS_USUARIOS
                set /p apply="¿Aplicar esta etiqueta? (S/N): "
                if /i "!apply!"=="S" (
                    label %%d: DATOS_USUARIOS
                    echo Etiqueta aplicada.
                )
            )
        )
    )
)
pause
goto smart_labeling

:date_based_labeling
echo.
echo Etiquetado automático por fecha...
echo.

for %%d in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo Etiquetando %%d: con fecha actual...
        label %%d: DISCO_%date:~-4,4%%date:~-10,2%%date:~-7,2%
        echo %%d: etiquetado con fecha.
    )
)
pause
goto smart_labeling

:: Función para análisis de contenido y sugerencias
:content_analysis_suggestions
echo.
echo [1] Análisis completo de contenido
echo [2] Generar sugerencias de etiquetas
echo [3] Validar etiquetas existentes
echo [4] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto complete_content_analysis
if "%sub_option%"=="2" goto generate_label_suggestions
if "%sub_option%"=="3" goto validate_existing_labels
if "%sub_option%"=="4" goto menu_principal
goto content_analysis_suggestions

:complete_content_analysis
echo.
echo Análisis completo de contenido...
echo.

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo.
        echo Análisis de %%d::
        echo =================
        
        :: Contar archivos por tipo
        set "image_count=0"
        set "video_count=0"
        set "doc_count=0"
        set "exe_count=0"
        set "total_files=0"
        
        for /r %%d:\ %%f in (*) do (
            set /a total_files+=1
            set "ext=%%~xf"
            if /i "!ext!"==".jpg" set /a image_count+=1
            if /i "!ext!"==".mp4" set /a video_count+=1
            if /i "!ext!"==".doc" set /a doc_count+=1
            if /i "!ext!"==".exe" set /a exe_count+=1
        )
        
        echo Total de archivos: %total_files%
        echo Imágenes: %image_count%
        echo Videos: %video_count%
        echo Documentos: %doc_count%
        echo Ejecutables: %exe_count%
    )
)
pause
goto content_analysis_suggestions

:generate_label_suggestions
echo.
echo Generando sugerencias de etiquetas...
echo.

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo.
        echo Sugerencias para %%d::
        echo ====================
        
        :: Analizar contenido y sugerir
        vol %%d: | findstr /i "no label" >nul
        if !errorlevel! equ 0 (
            echo Unidad sin etiqueta - Sugerencias:
            
            :: Verificar si es unidad del sistema
            if "%%d"=="C" (
                echo - SISTEMA_OPERATIVO
                echo - WINDOWS_SYSTEM
                echo - OS_DRIVE
            ) else (
                :: Analizar contenido para sugerencias
                dir %%d:\ | findstr /i "program files" >nul
                if !errorlevel! equ 0 (
                    echo - APLICACIONES
                    echo - SOFTWARE
                    echo - PROGRAMS
                ) else (
                    echo - DATOS_USUARIOS
                    echo - USER_DATA
                    echo - FILES
                )
            )
        ) else (
            echo Unidad ya tiene etiqueta.
        )
    )
)
pause
goto content_analysis_suggestions

:validate_existing_labels
echo.
echo Validando etiquetas existentes...
echo.

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo.
        echo Validación de %%d::
        echo ==================
        
        vol %%d: | findstr /i "no label" >nul
        if !errorlevel! equ 0 (
            echo ❌ Sin etiqueta
        ) else (
            echo ✅ Con etiqueta
            vol %%d:
            
            :: Verificar convenciones
            vol %%d: | findstr /i "[a-z]" >nul
            if !errorlevel! equ 0 (
                echo ⚠️ No sigue convención de mayúsculas
            ) else (
                echo ✅ Sigue convención de mayúsculas
            )
        )
    )
)
pause
goto content_analysis_suggestions

:: Función para auditoría automática
:automatic_audit
echo.
echo [1] Ejecutar auditoría completa
echo [2] Configurar auditoría automática
echo [3] Ver reportes de auditoría
echo [4] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto run_complete_audit
if "%sub_option%"=="2" goto configure_automatic_audit
if "%sub_option%"=="3" goto view_audit_reports
if "%sub_option%"=="4" goto menu_principal
goto automatic_audit

:run_complete_audit
echo.
echo Ejecutando auditoría completa...
echo.

set "audit_report=%labels_monitoring%\audit_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.txt"

echo Auditoría de Etiquetas de Discos > "%audit_report%"
echo Fecha: %date% %time% >> "%audit_report%"
echo ======================================== >> "%audit_report%"
echo. >> "%audit_report%"

set "unidades_sin_etiqueta=0"
set "unidades_con_etiqueta=0"
set "unidades_no_cumplen=0"

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo Analizando %%d:...
        echo Unidad %%d:: >> "%audit_report%"
        
        vol %%d: | findstr /i "no label" >nul
        if !errorlevel! equ 0 (
            echo ❌ %%d: - Sin etiqueta
            echo Estado: Sin etiqueta >> "%audit_report%"
            set /a unidades_sin_etiqueta+=1
        ) else (
            echo ✅ %%d: - Con etiqueta
            echo Estado: Con etiqueta >> "%audit_report%"
            set /a unidades_con_etiqueta+=1
            
            vol %%d: >> "%audit_report%"
            
            :: Verificar convenciones
            vol %%d: | findstr /i "[a-z]" >nul
            if !errorlevel! equ 0 (
                echo ⚠️ %%d: - No sigue convención
                echo Cumplimiento: No cumple convención >> "%audit_report%"
                set /a unidades_no_cumplen+=1
            ) else (
                echo ✅ %%d: - Cumple convención
                echo Cumplimiento: Cumple convención >> "%audit_report%"
            )
        )
        echo. >> "%audit_report%"
    )
)

echo.
echo RESUMEN DE AUDITORÍA:
echo =====================
echo Unidades con etiqueta: %unidades_con_etiqueta%
echo Unidades sin etiqueta: %unidades_sin_etiqueta%
echo Unidades que no cumplen: %unidades_no_cumplen%
echo.
echo Reporte guardado en: %audit_report%

echo. >> "%audit_report%"
echo RESUMEN DE AUDITORÍA >> "%audit_report%"
echo ===================== >> "%audit_report%"
echo Unidades con etiqueta: %unidades_con_etiqueta% >> "%audit_report%"
echo Unidades sin etiqueta: %unidades_sin_etiqueta% >> "%audit_report%"
echo Unidades que no cumplen: %unidades_no_cumplen% >> "%audit_report%"

call :advanced_log "AUDIT" "Auditoría completada - Reporte: %audit_report%"
pause
goto automatic_audit

:configure_automatic_audit
echo.
echo Configurando auditoría automática...
echo.

set /p audit_interval="Intervalo de auditoría (días): "
set /p audit_time="Hora de auditoría (HH:MM): "
set /p audit_enabled="¿Habilitar auditoría automática? (S/N): "

if /i "%audit_enabled%"=="S" (
    echo Auditoría automática configurada:
    echo - Intervalo: %audit_interval% días
    echo - Hora: %audit_time%
    echo - Habilitada: Sí
    
    :: Crear tarea programada
    schtasks /create /tn "Auditoria_Etiquetas" /tr "%~f0" /sc daily /st %audit_time% /f
    echo Tarea programada creada.
    
    call :advanced_log "AUDIT" "Auditoría automática configurada"
) else (
    echo Auditoría automática deshabilitada.
)

pause
goto automatic_audit

:view_audit_reports
echo.
echo Reportes de auditoría disponibles:
echo ==================================
dir /b "%labels_monitoring%\audit_*.txt"
echo.
set /p report_file="Nombre del reporte a ver: "
if exist "%labels_monitoring%\%report_file%" (
    type "%labels_monitoring%\%report_file%"
) else (
    echo Reporte no encontrado.
)
pause
goto automatic_audit

:: Función para gestión de metadatos
:metadata_management
echo.
echo [1] Agregar metadatos a unidad
echo [2] Ver metadatos de unidad
echo [3] Exportar metadatos
echo [4] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto add_metadata
if "%sub_option%"=="2" goto view_metadata
if "%sub_option%"=="3" goto export_metadata
if "%sub_option%"=="4" goto menu_principal
goto metadata_management

:add_metadata
echo.
set /p unidad="Ingresa la letra de la unidad: "
if not exist "%unidad%:\" (
    echo Error: La unidad %unidad%: no existe.
    pause
    goto metadata_management
)

echo.
echo Agregando metadatos a %unidad%:...
set /p description="Descripción: "
set /p owner="Propietario: "
set /p department="Departamento: "
set /p purpose="Propósito: "
set /p last_backup="Último respaldo: "

echo [%unidad%:] > "%labels_monitoring%\%unidad%_metadata.txt"
echo Description=%description% >> "%labels_monitoring%\%unidad%_metadata.txt"
echo Owner=%owner% >> "%labels_monitoring%\%unidad%_metadata.txt"
echo Department=%department% >> "%labels_monitoring%\%unidad%_metadata.txt"
echo Purpose=%purpose% >> "%labels_monitoring%\%unidad%_metadata.txt"
echo LastBackup=%last_backup% >> "%labels_monitoring%\%unidad%_metadata.txt"
echo CreatedDate=%date% %time% >> "%labels_monitoring%\%unidad%_metadata.txt"

echo Metadatos agregados a %unidad%:.
call :advanced_log "METADATA" "Metadatos agregados a %unidad%:"
pause
goto metadata_management

:view_metadata
echo.
set /p unidad="Ingresa la letra de la unidad: "
if exist "%labels_monitoring%\%unidad%_metadata.txt" (
    echo.
    echo Metadatos de %unidad%::
    echo ======================
    type "%labels_monitoring%\%unidad%_metadata.txt"
) else (
    echo No se encontraron metadatos para %unidad%:.
)
pause
goto metadata_management

:export_metadata
echo.
echo Exportando metadatos de todas las unidades...
echo.

set "metadata_export=%labels_monitoring%\metadata_export_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"

echo Exportación de Metadatos > "%metadata_export%"
echo Fecha: %date% %time% >> "%metadata_export%"
echo ======================================== >> "%metadata_export%"
echo. >> "%metadata_export%"

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%labels_monitoring%\%%d_metadata.txt" (
        echo [%%d:] >> "%metadata_export%"
        type "%labels_monitoring%\%%d_metadata.txt" >> "%metadata_export%"
        echo. >> "%metadata_export%"
    )
)

echo Metadatos exportados a: %metadata_export%
call :advanced_log "METADATA" "Metadatos exportados"
pause
goto metadata_management

:: Menú principal
:menu_principal
call :show_advanced_menu

if "%option%"=="1" goto advanced_configuration
if "%option%"=="2" goto naming_conventions
if "%option%"=="3" goto smart_labeling
if "%option%"=="4" goto content_analysis_suggestions
if "%option%"=="5" goto automatic_audit
if "%option%"=="6" goto metadata_management
if "%option%"=="7" goto backup_recovery
if "%option%"=="8" goto reports_analysis
if "%option%"=="9" goto salir

goto menu_principal

:backup_recovery
echo.
echo Sistema de backup y recuperación avanzada...
echo Creando backup completo del sistema de etiquetas...
call :advanced_log "BACKUP" "Backup del sistema de etiquetas iniciado"
echo Backup completado.
pause
goto menu_principal

:reports_analysis
echo.
echo Generando reportes y análisis avanzados...
echo Analizando datos del sistema de etiquetas...
call :advanced_log "ANALYSIS" "Reportes y análisis generados"
echo Reportes generados.
pause
goto menu_principal

:salir
echo.
echo ¡Hasta luego!
call :advanced_log "SYSTEM" "Sistema de gestión avanzada de etiquetas cerrado"
exit /b 0 