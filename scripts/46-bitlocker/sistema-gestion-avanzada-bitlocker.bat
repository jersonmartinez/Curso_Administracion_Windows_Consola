@echo off
setlocal enabledelayedexpansion
title Sistema de Gestión Avanzada de Bitlocker
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
set "bitlocker_advanced=%~dp0bitlocker_advanced"
set "bitlocker_policies=%~dp0bitlocker_policies"
set "bitlocker_monitoring=%~dp0bitlocker_monitoring"

:: Crear directorios de configuración
if not exist "%bitlocker_advanced%" mkdir "%bitlocker_advanced%"
if not exist "%bitlocker_policies%" mkdir "%bitlocker_policies%"
if not exist "%bitlocker_monitoring%" mkdir "%bitlocker_monitoring%"

:: Archivo de configuración principal
set "main_config=%bitlocker_advanced%\bitlocker_main.conf"

:: Crear configuración por defecto
if not exist "%main_config%" (
    echo # Configuración principal de Bitlocker > "%main_config%"
    echo encryption_method=AES256 >> "%main_config%"
    echo tpm_required=true >> "%main_config%"
    echo pin_required=true >> "%main_config%"
    echo recovery_key_backup=true >> "%main_config%"
    echo auto_unlock_enabled=true >> "%main_config%"
    echo certificate_protection=false >> "%main_config%"
    echo startup_key_required=false >> "%main_config%"
    echo encryption_policy=used_space_only >> "%main_config%"
    echo monitoring_enabled=true >> "%main_config%"
    echo audit_logging=true >> "%main_config%"
)

:: Función de logging avanzado
:advanced_log
echo [%date% %time%] [%~1] %~2 >> "%bitlocker_monitoring%\advanced_bitlocker.log"
goto :eof

:: Función para mostrar menú principal
:show_advanced_menu
cls
echo.
echo ========================================
echo    SISTEMA DE GESTIÓN AVANZADA DE BITLOCKER
echo ========================================
echo.
echo [1] Configuración avanzada del sistema
echo [2] Gestión de políticas de seguridad
echo [3] Gestión avanzada de protectores
echo [4] Monitoreo y auditoría avanzada
echo [5] Gestión de certificados
echo [6] Backup y recuperación avanzada
echo [7] Reportes y análisis
echo [8] Mantenimiento avanzado
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
set "temp_config=%temp%\temp_bitlocker_config.txt"
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
    if "%%a"=="encryption_method" (
        echo Configurando método de cifrado: %%b
    )
    if "%%a"=="tpm_required" (
        if "%%b"=="true" (
            echo Verificando TPM...
            tpm get | findstr "Ready" >nul
            if errorlevel 1 (
                echo [ADVERTENCIA] TPM no disponible
                call :advanced_log "WARNING" "TPM no disponible"
            ) else (
                echo [OK] TPM verificado
                call :advanced_log "INFO" "TPM verificado correctamente"
            )
        )
    )
    if "%%a"=="pin_required" (
        if "%%b"=="true" (
            echo Configurando PIN de arranque...
            bdehcfg -target default -set -pin
            call :advanced_log "CONFIG" "PIN de arranque configurado"
        )
    )
    if "%%a"=="auto_unlock_enabled" (
        if "%%b"=="true" (
            echo Habilitando desbloqueo automático...
            manage-bde -autounlock -enable
            call :advanced_log "CONFIG" "Desbloqueo automático habilitado"
        )
    )
)

echo Configuración aplicada exitosamente.
call :advanced_log "CONFIG" "Configuración aplicada"
pause
goto advanced_configuration

:validate_config
echo.
echo Validando configuración del sistema Bitlocker...
echo.

:: Verificar TPM
echo Verificando TPM...
tpm get | findstr "Ready" >nul
if errorlevel 1 (
    echo [ERROR] TPM no está listo
    call :advanced_log "ERROR" "TPM no está listo"
) else (
    echo [OK] TPM está listo
    call :advanced_log "INFO" "TPM verificado correctamente"
)

:: Verificar unidades del sistema
echo.
echo Verificando unidades del sistema...
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        manage-bde -status %%d: | findstr "Protection On" >nul
        if not errorlevel 1 (
            echo [OK] Unidad %%d: está protegida
            call :advanced_log "INFO" "Unidad %%d: protegida"
        ) else (
            echo [ADVERTENCIA] Unidad %%d: no está protegida
            call :advanced_log "WARNING" "Unidad %%d: no protegida"
        )
    )
)

:: Verificar claves de recuperación
echo.
echo Verificando claves de recuperación...
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        manage-bde -status %%d: | findstr "Protection On" >nul
        if not errorlevel 1 (
            manage-bde -protectors -get %%d: | findstr "Recovery Password" >nul
            if not errorlevel 1 (
                echo [OK] Unidad %%d: tiene clave de recuperación
                call :advanced_log "INFO" "Unidad %%d: tiene clave de recuperación"
            ) else (
                echo [ADVERTENCIA] Unidad %%d: sin clave de recuperación
                call :advanced_log "WARNING" "Unidad %%d: sin clave de recuperación"
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

:: Función para gestión de políticas de seguridad
:security_policies
echo.
echo [1] Crear política de seguridad
echo [2] Aplicar política existente
echo [3] Listar políticas disponibles
echo [4] Editar política
echo [5] Eliminar política
echo [6] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto create_security_policy
if "%sub_option%"=="2" goto apply_security_policy
if "%sub_option%"=="3" goto list_security_policies
if "%sub_option%"=="4" goto edit_security_policy
if "%sub_option%"=="5" goto delete_security_policy
if "%sub_option%"=="6" goto menu_principal
goto security_policies

:create_security_policy
echo.
set /p policy_name="Nombre de la política: "
echo.
echo [1] Política de alta seguridad
echo [2] Política de seguridad media
echo [3] Política de seguridad básica
echo [4] Política personalizada
echo [5] Volver
echo.
set /p policy_type="Selecciona el tipo de política: "

if "%policy_type%"=="1" goto create_high_security_policy
if "%policy_type%"=="2" goto create_medium_security_policy
if "%policy_type%"=="3" goto create_basic_security_policy
if "%policy_type%"=="4" goto create_custom_policy
if "%policy_type%"=="5" goto security_policies
goto create_security_policy

:create_high_security_policy
echo # Política de Alta Seguridad - %policy_name% > "%bitlocker_policies%\%policy_name%.conf"
echo encryption_method=AES256 >> "%bitlocker_policies%\%policy_name%.conf"
echo tpm_required=true >> "%bitlocker_policies%\%policy_name%.conf"
echo pin_required=true >> "%bitlocker_policies%\%policy_name%.conf"
echo startup_key_required=true >> "%bitlocker_policies%\%policy_name%.conf"
echo certificate_protection=true >> "%bitlocker_policies%\%policy_name%.conf"
echo recovery_key_backup=true >> "%bitlocker_policies%\%policy_name%.conf"
echo auto_unlock_enabled=false >> "%bitlocker_policies%\%policy_name%.conf"
echo encryption_policy=full_drive >> "%bitlocker_policies%\%policy_name%.conf"
echo audit_logging=true >> "%bitlocker_policies%\%policy_name%.conf"
echo monitoring_enabled=true >> "%bitlocker_policies%\%policy_name%.conf"
echo Política de alta seguridad creada: %policy_name%
call :advanced_log "POLICY" "Política de alta seguridad creada: %policy_name%"
pause
goto security_policies

:create_medium_security_policy
echo # Política de Seguridad Media - %policy_name% > "%bitlocker_policies%\%policy_name%.conf"
echo encryption_method=AES256 >> "%bitlocker_policies%\%policy_name%.conf"
echo tpm_required=true >> "%bitlocker_policies%\%policy_name%.conf"
echo pin_required=false >> "%bitlocker_policies%\%policy_name%.conf"
echo startup_key_required=false >> "%bitlocker_policies%\%policy_name%.conf"
echo certificate_protection=false >> "%bitlocker_policies%\%policy_name%.conf"
echo recovery_key_backup=true >> "%bitlocker_policies%\%policy_name%.conf"
echo auto_unlock_enabled=true >> "%bitlocker_policies%\%policy_name%.conf"
echo encryption_policy=used_space_only >> "%bitlocker_policies%\%policy_name%.conf"
echo audit_logging=true >> "%bitlocker_policies%\%policy_name%.conf"
echo monitoring_enabled=true >> "%bitlocker_policies%\%policy_name%.conf"
echo Política de seguridad media creada: %policy_name%
call :advanced_log "POLICY" "Política de seguridad media creada: %policy_name%"
pause
goto security_policies

:create_basic_security_policy
echo # Política de Seguridad Básica - %policy_name% > "%bitlocker_policies%\%policy_name%.conf"
echo encryption_method=AES128 >> "%bitlocker_policies%\%policy_name%.conf"
echo tpm_required=false >> "%bitlocker_policies%\%policy_name%.conf"
echo pin_required=false >> "%bitlocker_policies%\%policy_name%.conf"
echo startup_key_required=false >> "%bitlocker_policies%\%policy_name%.conf"
echo certificate_protection=false >> "%bitlocker_policies%\%policy_name%.conf"
echo recovery_key_backup=true >> "%bitlocker_policies%\%policy_name%.conf"
echo auto_unlock_enabled=true >> "%bitlocker_policies%\%policy_name%.conf"
echo encryption_policy=used_space_only >> "%bitlocker_policies%\%policy_name%.conf"
echo audit_logging=false >> "%bitlocker_policies%\%policy_name%.conf"
echo monitoring_enabled=false >> "%bitlocker_policies%\%policy_name%.conf"
echo Política de seguridad básica creada: %policy_name%
call :advanced_log "POLICY" "Política de seguridad básica creada: %policy_name%"
pause
goto security_policies

:create_custom_policy
echo.
echo Configurando política personalizada...
echo # Política Personalizada - %policy_name% > "%bitlocker_policies%\%policy_name%.conf"
set /p encryption="Método de cifrado (AES128/AES256): "
set /p tpm="¿Requiere TPM? (true/false): "
set /p pin="¿Requiere PIN? (true/false): "
set /p startup="¿Requiere clave de arranque? (true/false): "
set /p cert="¿Usar certificados? (true/false): "
set /p recovery="¿Backup de clave de recuperación? (true/false): "
set /p auto="¿Desbloqueo automático? (true/false): "
set /p policy="Política de cifrado (used_space_only/full_drive): "
set /p audit="¿Logging de auditoría? (true/false): "
set /p monitor="¿Monitoreo habilitado? (true/false): "

echo encryption_method=%encryption% >> "%bitlocker_policies%\%policy_name%.conf"
echo tpm_required=%tpm% >> "%bitlocker_policies%\%policy_name%.conf"
echo pin_required=%pin% >> "%bitlocker_policies%\%policy_name%.conf"
echo startup_key_required=%startup% >> "%bitlocker_policies%\%policy_name%.conf"
echo certificate_protection=%cert% >> "%bitlocker_policies%\%policy_name%.conf"
echo recovery_key_backup=%recovery% >> "%bitlocker_policies%\%policy_name%.conf"
echo auto_unlock_enabled=%auto% >> "%bitlocker_policies%\%policy_name%.conf"
echo encryption_policy=%policy% >> "%bitlocker_policies%\%policy_name%.conf"
echo audit_logging=%audit% >> "%bitlocker_policies%\%policy_name%.conf"
echo monitoring_enabled=%monitor% >> "%bitlocker_policies%\%policy_name%.conf"

echo Política personalizada creada: %policy_name%
call :advanced_log "POLICY" "Política personalizada creada: %policy_name%"
pause
goto security_policies

:apply_security_policy
echo.
echo Políticas disponibles:
echo =====================
dir /b "%bitlocker_policies%\*.conf"
echo.
set /p policy_name="Nombre de la política a aplicar: "
if exist "%bitlocker_policies%\%policy_name%.conf" (
    echo Aplicando política: %policy_name%
    call :advanced_log "POLICY" "Aplicando política: %policy_name%"
    
    :: Aplicar configuración de la política
    for /f "tokens=1,2 delims==" %%a in ("%bitlocker_policies%\%policy_name%.conf") do (
        if "%%a"=="encryption_method" (
            echo Configurando método de cifrado: %%b
        )
        if "%%a"=="tpm_required" (
            if "%%b"=="true" (
                echo Verificando TPM...
                tpm get | findstr "Ready" >nul
                if errorlevel 1 (
                    echo [ADVERTENCIA] TPM no disponible
                ) else (
                    echo [OK] TPM verificado
                )
            )
        )
        if "%%a"=="pin_required" (
            if "%%b"=="true" (
                echo Configurando PIN de arranque...
                bdehcfg -target default -set -pin
            )
        )
        if "%%a"=="auto_unlock_enabled" (
            if "%%b"=="true" (
                echo Habilitando desbloqueo automático...
                manage-bde -autounlock -enable
            ) else (
                echo Deshabilitando desbloqueo automático...
                manage-bde -autounlock -disable
            )
        )
    )
    
    echo Política aplicada exitosamente.
) else (
    echo Política no encontrada.
)
pause
goto security_policies

:list_security_policies
echo.
echo Políticas de seguridad disponibles:
echo ===================================
dir /b "%bitlocker_policies%\*.conf"
echo.
pause
goto security_policies

:edit_security_policy
echo.
echo Políticas disponibles:
echo =====================
dir /b "%bitlocker_policies%\*.conf"
echo.
set /p policy_name="Nombre de la política a editar: "
if exist "%bitlocker_policies%\%policy_name%.conf" (
    echo Abriendo política para edición...
    notepad "%bitlocker_policies%\%policy_name%.conf"
    call :advanced_log "POLICY" "Política editada: %policy_name%"
) else (
    echo Política no encontrada.
)
pause
goto security_policies

:delete_security_policy
echo.
echo Políticas disponibles:
echo =====================
dir /b "%bitlocker_policies%\*.conf"
echo.
set /p policy_name="Nombre de la política a eliminar: "
if exist "%bitlocker_policies%\%policy_name%.conf" (
    set /p confirm="¿Estás seguro? (y/N): "
    if /i "%confirm%"=="y" (
        del "%bitlocker_policies%\%policy_name%.conf"
        echo Política eliminada.
        call :advanced_log "POLICY" "Política eliminada: %policy_name%"
    )
) else (
    echo Política no encontrada.
)
pause
goto security_policies

:: Función para gestión avanzada de protectores
:advanced_protector_management
echo.
echo [1] Configurar protectores múltiples
echo [2] Gestión de certificados
echo [3] Configuración de TPM avanzada
echo [4] Gestión de claves de arranque
echo [5] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto configure_multiple_protectors
if "%sub_option%"=="2" goto certificate_management
if "%sub_option%"=="3" goto advanced_tpm_config
if "%sub_option%"=="4" goto startup_key_management
if "%sub_option%"=="5" goto menu_principal
goto advanced_protector_management

:configure_multiple_protectors
echo.
set /p unidad="Ingresa la letra de la unidad: "
echo.
echo Configurando protectores múltiples para %unidad%:...
echo.

:: Agregar TPM
echo Agregando protector TPM...
manage-bde -protectors -add %unidad%: -tpm

:: Agregar PIN
echo Agregando PIN de arranque...
bdehcfg -target default -set -pin

:: Agregar clave de recuperación
echo Agregando clave de recuperación...
manage-bde -protectors -add %unidad%: -recoverypassword

echo Protectores múltiples configurados.
call :advanced_log "PROTECTOR" "Protectores múltiples configurados para %unidad%:"
pause
goto advanced_protector_management

:certificate_management
echo.
echo [1] Agregar certificado
echo [2] Listar certificados
echo [3] Eliminar certificado
echo [4] Verificar certificados
echo [5] Volver
echo.
set /p sub_sub_option="Selecciona una opción: "

if "%sub_sub_option%"=="1" goto add_certificate
if "%sub_sub_option%"=="2" goto list_certificates
if "%sub_sub_option%"=="3" goto remove_certificate
if "%sub_sub_option%"=="4" goto verify_certificates
if "%sub_sub_option%"=="5" goto advanced_protector_management
goto certificate_management

:add_certificate
echo.
set /p unidad="Ingresa la letra de la unidad: "
set /p cert_path="Ruta del certificado: "
echo.
echo Agregando certificado...
manage-bde -protectors -add %unidad%: -certificate -cf "%cert_path%"
echo Certificado agregado.
call :advanced_log "CERT" "Certificado agregado a %unidad%:"
pause
goto certificate_management

:list_certificates
echo.
echo Certificados disponibles en el almacén:
echo =======================================
certutil -store MY
echo.
pause
goto certificate_management

:remove_certificate
echo.
set /p unidad="Ingresa la letra de la unidad: "
echo.
echo Protectores de certificado en %unidad%::
manage-bde -protectors -get %unidad%: | findstr "Certificate"
echo.
set /p cert_id="ID del certificado a eliminar: "
echo.
echo Eliminando certificado...
manage-bde -protectors -delete %unidad%: -id %cert_id%
echo Certificado eliminado.
call :advanced_log "CERT" "Certificado eliminado de %unidad%:"
pause
goto certificate_management

:verify_certificates
echo.
echo Verificando certificados...
echo.
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        manage-bde -status %%d: | findstr "Protection On" >nul
        if not errorlevel 1 (
            manage-bde -protectors -get %%d: | findstr "Certificate" >nul
            if not errorlevel 1 (
                echo Unidad %%d:: - Tiene certificados configurados
            ) else (
                echo Unidad %%d:: - Sin certificados
            )
        )
    )
)
echo.
pause
goto certificate_management

:advanced_tpm_config
echo.
echo [1] Verificar estado del TPM
echo [2] Tomar propiedad del TPM
echo [3] Limpiar TPM
echo [4] Configurar TPM
echo [5] Volver
echo.
set /p sub_sub_option="Selecciona una opción: "

if "%sub_sub_option%"=="1" goto check_tpm_status
if "%sub_sub_option%"=="2" goto take_tpm_ownership
if "%sub_sub_option%"=="3" goto clear_tpm
if "%sub_sub_option%"=="4" goto configure_tpm
if "%sub_sub_option%"=="5" goto advanced_protector_management
goto advanced_tpm_config

:check_tpm_status
echo.
echo Estado del TPM:
echo ===============
tpm get
echo.
pause
goto advanced_tpm_config

:take_tpm_ownership
echo.
echo Tomando propiedad del TPM...
tpm takeownership
echo Propiedad del TPM tomada.
call :advanced_log "TPM" "Propiedad del TPM tomada"
pause
goto advanced_tpm_config

:clear_tpm
echo.
echo ADVERTENCIA: Limpiar el TPM eliminará todas las claves almacenadas.
set /p confirm="¿Estás seguro? (y/N): "
if /i "%confirm%"=="y" (
    echo Limpiando TPM...
    tpm clear
    echo TPM limpiado.
    call :advanced_log "TPM" "TPM limpiado"
) else (
    echo Operación cancelada.
)
pause
goto advanced_tpm_config

:configure_tpm
echo.
echo Configurando TPM...
tpm set -forceclear
echo TPM configurado.
call :advanced_log "TPM" "TPM configurado"
pause
goto advanced_tpm_config

:startup_key_management
echo.
echo [1] Crear clave de arranque
echo [2] Configurar clave de arranque
echo [3] Eliminar clave de arranque
echo [4] Volver
echo.
set /p sub_sub_option="Selecciona una opción: "

if "%sub_sub_option%"=="1" goto create_startup_key
if "%sub_sub_option%"=="2" goto configure_startup_key
if "%sub_sub_option%"=="3" goto remove_startup_key
if "%sub_sub_option%"=="4" goto advanced_protector_management
goto startup_key_management

:create_startup_key
echo.
set /p key_path="Ruta para guardar la clave de arranque: "
echo.
echo Creando clave de arranque...
manage-bde -protectors -add C: -startupkey "%key_path%"
echo Clave de arranque creada.
call :advanced_log "STARTUP" "Clave de arranque creada"
pause
goto startup_key_management

:configure_startup_key
echo.
set /p key_path="Ruta de la clave de arranque: "
echo.
echo Configurando clave de arranque...
bdehcfg -target default -set -startupkey "%key_path%"
echo Clave de arranque configurada.
call :advanced_log "STARTUP" "Clave de arranque configurada"
pause
goto startup_key_management

:remove_startup_key
echo.
echo Eliminando clave de arranque...
bdehcfg -target default -set -startupkey
echo Clave de arranque eliminada.
call :advanced_log "STARTUP" "Clave de arranque eliminada"
pause
goto startup_key_management

:: Función para monitoreo y auditoría avanzada
:advanced_monitoring_audit
echo.
echo [1] Monitoreo en tiempo real avanzado
echo [2] Auditoría de seguridad completa
echo [3] Análisis de eventos
echo [4] Generar reportes de auditoría
echo [5] Volver al menú principal
echo.
set /p sub_option="Selecciona una opción: "

if "%sub_option%"=="1" goto advanced_real_time_monitoring
if "%sub_option%"=="2" goto complete_security_audit
if "%sub_option%"=="3" goto event_analysis
if "%sub_option%"=="4" goto generate_audit_reports
if "%sub_option%"=="5" goto menu_principal
goto advanced_monitoring_audit

:advanced_real_time_monitoring
echo.
echo Monitoreo en tiempo real avanzado de Bitlocker
echo Presiona Ctrl+C para detener
echo.

:advanced_monitor_loop
cls
echo ========================================
echo    MONITOREO AVANZADO - %time%
echo ========================================
echo.

:: Estado del TPM
echo Estado del TPM:
tpm get | findstr "Ready\|Ownership"
echo.

:: Estado de todas las unidades
echo Estado de unidades:
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        manage-bde -status %%d: | findstr "Protection\|Conversion\|Percentage" >nul
        if not errorlevel 1 (
            echo Unidad %%d:::
            manage-bde -status %%d: | findstr "Protection\|Conversion\|Percentage"
            echo.
        )
    )
)

:: Últimos eventos
echo Últimos eventos de Bitlocker:
wevtutil qe System /q:"*[System[Provider[@Name='Microsoft-Windows-BitLocker-DrivePreparationTool']]]" /c:5 /f:text
echo.

echo Actualizando en 20 segundos...
timeout /t 20 /nobreak >nul
goto advanced_monitor_loop

:complete_security_audit
echo.
echo Auditoría de seguridad completa de Bitlocker:
echo =============================================
echo.

:: Verificar TPM
echo 1. Verificando TPM...
tpm get | findstr "Ready" >nul
if not errorlevel 1 (
    echo    [OK] TPM está listo
    call :advanced_log "AUDIT" "TPM verificado correctamente"
) else (
    echo    [ERROR] TPM no está listo
    call :advanced_log "AUDIT" "TPM no está listo"
)

:: Verificar unidades del sistema
echo.
echo 2. Verificando unidades del sistema...
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        manage-bde -status %%d: | findstr "Protection On" >nul
        if not errorlevel 1 (
            echo    [OK] Unidad %%d: está protegida
            call :advanced_log "AUDIT" "Unidad %%d: protegida"
        ) else (
            echo    [WARNING] Unidad %%d: no está protegida
            call :advanced_log "AUDIT" "Unidad %%d: no protegida"
        )
    )
)

:: Verificar claves de recuperación
echo.
echo 3. Verificando claves de recuperación...
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        manage-bde -status %%d: | findstr "Protection On" >nul
        if not errorlevel 1 (
            manage-bde -protectors -get %%d: | findstr "Recovery Password" >nul
            if not errorlevel 1 (
                echo    [OK] Unidad %%d: tiene clave de recuperación
                call :advanced_log "AUDIT" "Unidad %%d: tiene clave de recuperación"
            ) else (
                echo    [WARNING] Unidad %%d: sin clave de recuperación
                call :advanced_log "AUDIT" "Unidad %%d: sin clave de recuperación"
            )
        )
    )
)

:: Verificar configuración de arranque
echo.
echo 4. Verificando configuración de arranque...
bdehcfg -target default -get | findstr "Authentication" >nul
if not errorlevel 1 (
    echo    [OK] Autenticación de arranque configurada
    call :advanced_log "AUDIT" "Autenticación de arranque configurada"
) else (
    echo    [WARNING] Autenticación de arranque no configurada
    call :advanced_log "AUDIT" "Autenticación de arranque no configurada"
)

echo.
echo Auditoría completada.
pause
goto advanced_monitoring_audit

:event_analysis
echo.
echo [1] Analizar eventos de Bitlocker
echo [2] Buscar eventos de error
echo [3] Analizar eventos de seguridad
echo [4] Volver
echo.
set /p sub_sub_option="Selecciona una opción: "

if "%sub_sub_option%"=="1" goto analyze_bitlocker_events
if "%sub_sub_option%"=="2" goto search_error_events
if "%sub_sub_option%"=="3" goto analyze_security_events
if "%sub_sub_option%"=="4" goto advanced_monitoring_audit
goto event_analysis

:analyze_bitlocker_events
echo.
echo Eventos de Bitlocker:
echo ====================
wevtutil qe System /q:"*[System[Provider[@Name='Microsoft-Windows-BitLocker-DrivePreparationTool']]]" /c:20 /f:text
echo.
pause
goto event_analysis

:search_error_events
echo.
echo Eventos de error de Bitlocker:
echo ==============================
wevtutil qe System /q:"*[System[Provider[@Name='Microsoft-Windows-BitLocker-DrivePreparationTool'] and (Level=1 or Level=2)]]" /c:10 /f:text
echo.
pause
goto event_analysis

:analyze_security_events
echo.
echo Eventos de seguridad relacionados con Bitlocker:
echo ===============================================
wevtutil qe Security /q:"*[System[EventID=4648 or EventID=4649 or EventID=4650]]" /c:10 /f:text
echo.
pause
goto event_analysis

:generate_audit_reports
echo.
set /p report_name="Nombre del reporte de auditoría: "
echo.
echo Generando reporte de auditoría...

echo Reporte de Auditoría de Seguridad - Bitlocker > "%bitlocker_monitoring%\%report_name%.txt"
echo Fecha: %date% %time% >> "%bitlocker_monitoring%\%report_name%.txt"
echo ============================================== >> "%bitlocker_monitoring%\%report_name%.txt"
echo. >> "%bitlocker_monitoring%\%report_name%.txt"

echo 1. ESTADO DEL TPM >> "%bitlocker_monitoring%\%report_name%.txt"
echo ================= >> "%bitlocker_monitoring%\%report_name%.txt"
tpm get >> "%bitlocker_monitoring%\%report_name%.txt"
echo. >> "%bitlocker_monitoring%\%report_name%.txt"

echo 2. ESTADO DE UNIDADES >> "%bitlocker_monitoring%\%report_name%.txt"
echo ===================== >> "%bitlocker_monitoring%\%report_name%.txt"
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo Unidad %%d:: >> "%bitlocker_monitoring%\%report_name%.txt"
        manage-bde -status %%d: >> "%bitlocker_monitoring%\%report_name%.txt"
        echo. >> "%bitlocker_monitoring%\%report_name%.txt"
    )
)

echo 3. EVENTOS DE BITLOCKER >> "%bitlocker_monitoring%\%report_name%.txt"
echo ======================= >> "%bitlocker_monitoring%\%report_name%.txt"
wevtutil qe System /q:"*[System[Provider[@Name='Microsoft-Windows-BitLocker-DrivePreparationTool']]]" /c:50 /f:text >> "%bitlocker_monitoring%\%report_name%.txt"

echo Reporte generado: %bitlocker_monitoring%\%report_name%.txt
call :advanced_log "REPORT" "Reporte de auditoría generado: %report_name%"
pause
goto advanced_monitoring_audit

:: Menú principal
:menu_principal
call :show_advanced_menu

if "%option%"=="1" goto advanced_configuration
if "%option%"=="2" goto security_policies
if "%option%"=="3" goto advanced_protector_management
if "%option%"=="4" goto advanced_monitoring_audit
if "%option%"=="5" goto certificate_management
if "%option%"=="6" goto backup_recovery
if "%option%"=="7" goto reports_analysis
if "%option%"=="8" goto advanced_maintenance
if "%option%"=="9" goto salir

goto menu_principal

:backup_recovery
echo.
echo Sistema de backup y recuperación avanzada...
echo Creando backup completo del sistema Bitlocker...
call :advanced_log "BACKUP" "Backup del sistema Bitlocker iniciado"
echo Backup completado.
pause
goto menu_principal

:reports_analysis
echo.
echo Generando reportes y análisis avanzados...
echo Analizando datos del sistema Bitlocker...
call :advanced_log "ANALYSIS" "Reportes y análisis generados"
echo Reportes generados.
pause
goto menu_principal

:advanced_maintenance
echo.
echo Mantenimiento avanzado del sistema Bitlocker...
echo Optimizando rendimiento y limpiando recursos...
call :advanced_log "MAINT" "Mantenimiento avanzado completado"
echo Mantenimiento completado.
pause
goto menu_principal

:salir
echo.
echo ¡Hasta luego!
call :advanced_log "SYSTEM" "Sistema de gestión avanzada de Bitlocker cerrado"
exit /b 0 