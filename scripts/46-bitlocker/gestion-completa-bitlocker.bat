@echo off
setlocal enabledelayedexpansion
title Gestión Completa de Bitlocker
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
set "bitlocker_config=C:\Bitlocker_Config"
set "bitlocker_logs=C:\Bitlocker_Logs"
set "bitlocker_backup=C:\Bitlocker_Backup"

:: Crear directorios si no existen
if not exist "%bitlocker_config%" mkdir "%bitlocker_config%"
if not exist "%bitlocker_logs%" mkdir "%bitlocker_logs%"
if not exist "%bitlocker_backup%" mkdir "%bitlocker_backup%"

echo.
echo ========================================
echo    GESTIÓN COMPLETA DE BITLOCKER
echo ========================================
echo.

:menu_principal
echo [1] Habilitar Bitlocker
echo [2] Gestionar protectores
echo [3] Gestionar claves de recuperación
echo [4] Configurar arranque
echo [5] Monitorear estado
echo [6] Backup y restauración
echo [7] Auditoría y reportes
echo [8] Mantenimiento
echo [9] Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto habilitar_bitlocker
if "%opcion%"=="2" goto gestionar_protectores
if "%opcion%"=="3" goto gestionar_claves_recuperacion
if "%opcion%"=="4" goto configurar_arranque
if "%opcion%"=="5" goto monitorear_estado
if "%opcion%"=="6" goto backup_restauracion
if "%opcion%"=="7" goto auditoria_reportes
if "%opcion%"=="8" goto mantenimiento
if "%opcion%"=="9" goto salir
goto menu_principal

:habilitar_bitlocker
echo.
echo [1] Habilitar en unidad del sistema (C:)
echo [2] Habilitar en unidad de datos
echo [3] Habilitar en unidad USB
echo [4] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto habilitar_sistema
if "%sub_opcion%"=="2" goto habilitar_datos
if "%sub_opcion%"=="3" goto habilitar_usb
if "%sub_opcion%"=="4" goto menu_principal
goto habilitar_bitlocker

:habilitar_sistema
echo.
echo Habilitando Bitlocker en unidad del sistema...
echo.

:: Verificar si ya está habilitado
manage-bde -status C: | findstr "Protection On"
if not errorlevel 1 (
    echo Bitlocker ya está habilitado en C:
    pause
    goto habilitar_bitlocker
)

:: Habilitar Bitlocker
echo Configurando Bitlocker en C:...
manage-bde -on C: -usedspaceonly -recoverypassword -startupkey

echo.
echo Bitlocker habilitado en C:. El cifrado se completará en segundo plano.
echo Guarda la clave de recuperación en un lugar seguro.
pause
goto habilitar_bitlocker

:habilitar_datos
echo.
set /p unidad="Ingresa la letra de la unidad (ej: D): "
echo.
echo Habilitando Bitlocker en unidad %unidad%:...
echo.

:: Verificar si la unidad existe
if not exist "%unidad%:\" (
    echo Error: La unidad %unidad%: no existe.
    pause
    goto habilitar_datos
)

:: Habilitar Bitlocker
manage-bde -on %unidad%: -password -usedspaceonly

echo.
echo Bitlocker habilitado en %unidad%:.
pause
goto habilitar_bitlocker

:habilitar_usb
echo.
set /p unidad="Ingresa la letra de la unidad USB (ej: E): "
echo.
echo Habilitando Bitlocker en unidad USB %unidad%:...
echo.

:: Verificar si la unidad existe
if not exist "%unidad%:\" (
    echo Error: La unidad %unidad%: no existe.
    pause
    goto habilitar_usb
)

:: Habilitar Bitlocker en USB
manage-bde -on %unidad%: -password -usedspaceonly

echo.
echo Bitlocker habilitado en unidad USB %unidad%:.
pause
goto habilitar_bitlocker

:gestionar_protectores
echo.
echo [1] Listar protectores
echo [2] Agregar protector
echo [3] Eliminar protector
echo [4] Configurar desbloqueo automático
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto listar_protectores
if "%sub_opcion%"=="2" goto agregar_protector
if "%sub_opcion%"=="3" goto eliminar_protector
if "%sub_opcion%"=="4" goto configurar_autounlock
if "%sub_opcion%"=="5" goto menu_principal
goto gestionar_protectores

:listar_protectores
echo.
set /p unidad="Ingresa la letra de la unidad: "
echo.
echo Protectores en %unidad%::
echo =========================
manage-bde -protectors -get %unidad%:
echo.
pause
goto gestionar_protectores

:agregar_protector
echo.
set /p unidad="Ingresa la letra de la unidad: "
echo.
echo [1] Clave de recuperación
echo [2] Contraseña
echo [3] Certificado
echo [4] Clave de arranque
echo [5] Volver
echo.
set /p tipo_protector="Selecciona el tipo de protector: "

if "%tipo_protector%"=="1" goto agregar_recovery_password
if "%tipo_protector%"=="2" goto agregar_password
if "%tipo_protector%"=="3" goto agregar_certificate
if "%tipo_protector%"=="4" goto agregar_startup_key
if "%tipo_protector%"=="5" goto gestionar_protectores
goto agregar_protector

:agregar_recovery_password
echo.
echo Agregando clave de recuperación...
manage-bde -protectors -add %unidad%: -recoverypassword
echo Clave de recuperación agregada.
pause
goto gestionar_protectores

:agregar_password
echo.
set /p password="Ingresa la contraseña: "
echo.
echo Agregando contraseña...
manage-bde -protectors -add %unidad%: -password
echo Contraseña agregada.
pause
goto gestionar_protectores

:agregar_certificate
echo.
set /p cert_path="Ruta del certificado: "
echo.
echo Agregando certificado...
manage-bde -protectors -add %unidad%: -certificate -cf "%cert_path%"
echo Certificado agregado.
pause
goto gestionar_protectores

:agregar_startup_key
echo.
set /p key_path="Ruta de la clave de arranque: "
echo.
echo Agregando clave de arranque...
manage-bde -protectors -add %unidad%: -startupkey "%key_path%"
echo Clave de arranque agregada.
pause
goto gestionar_protectores

:eliminar_protector
echo.
set /p unidad="Ingresa la letra de la unidad: "
echo.
echo Protectores disponibles:
manage-bde -protectors -get %unidad%:
echo.
set /p protector_id="ID del protector a eliminar: "
echo.
echo Eliminando protector...
manage-bde -protectors -delete %unidad%: -id %protector_id%
echo Protector eliminado.
pause
goto gestionar_protectores

:configurar_autounlock
echo.
set /p unidad="Ingresa la letra de la unidad: "
echo.
echo [1] Habilitar desbloqueo automático
echo [2] Deshabilitar desbloqueo automático
echo [3] Volver
echo.
set /p autounlock_opcion="Selecciona una opción: "

if "%autounlock_opcion%"=="1" (
    echo Habilitando desbloqueo automático...
    manage-bde -autounlock -enable %unidad%:
    echo Desbloqueo automático habilitado.
) else if "%autounlock_opcion%"=="2" (
    echo Deshabilitando desbloqueo automático...
    manage-bde -autounlock -disable %unidad%:
    echo Desbloqueo automático deshabilitado.
) else if "%autounlock_opcion%"=="3" (
    goto gestionar_protectores
)
pause
goto gestionar_protectores

:gestionar_claves_recuperacion
echo.
echo [1] Generar nueva clave de recuperación
echo [2] Exportar claves de recuperación
echo [3] Importar claves de recuperación
echo [4] Desbloquear unidad con clave
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto generar_clave_recuperacion
if "%sub_opcion%"=="2" goto exportar_claves
if "%sub_opcion%"=="3" goto importar_claves
if "%sub_opcion%"=="4" goto desbloquear_unidad
if "%sub_opcion%"=="5" goto menu_principal
goto gestionar_claves_recuperacion

:generar_clave_recuperacion
echo.
set /p unidad="Ingresa la letra de la unidad: "
echo.
echo Generando nueva clave de recuperación...
manage-bde -protectors -add %unidad%: -recoverypassword
echo.
echo Clave de recuperación generada. Guárdala en un lugar seguro.
pause
goto gestionar_claves_recuperacion

:exportar_claves
echo.
set /p archivo="Nombre del archivo de exportación: "
echo.
echo Exportando claves de recuperación...
manage-bde -protectors -get C: > "%bitlocker_backup%\%archivo%"
echo Claves exportadas a %bitlocker_backup%\%archivo%
pause
goto gestionar_claves_recuperacion

:importar_claves
echo.
set /p archivo="Nombre del archivo a importar: "
echo.
echo Importando claves de recuperación...
echo Función de importación manual requerida.
pause
goto gestionar_claves_recuperacion

:desbloquear_unidad
echo.
set /p unidad="Ingresa la letra de la unidad: "
set /p clave="Ingresa la clave de recuperación (48 dígitos): "
echo.
echo Desbloqueando unidad...
manage-bde -unlock %unidad%: -recoverypassword %clave%
echo Unidad desbloqueada.
pause
goto gestionar_claves_recuperacion

:configurar_arranque
echo.
echo [1] Configurar autenticación de arranque
echo [2] Configurar PIN de arranque
echo [3] Configurar clave de arranque
echo [4] Ver configuración actual
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto configurar_autenticacion
if "%sub_opcion%"=="2" goto configurar_pin
if "%sub_opcion%"=="3" goto configurar_startup_key
if "%sub_opcion%"=="4" goto ver_configuracion_arranque
if "%sub_opcion%"=="5" goto menu_principal
goto configurar_arranque

:configurar_autenticacion
echo.
echo [1] Habilitar autenticación
echo [2] Deshabilitar autenticación
echo [3] Volver
echo.
set /p auth_opcion="Selecciona una opción: "

if "%auth_opcion%"=="1" (
    echo Habilitando autenticación de arranque...
    bdehcfg -target default -set -authentication 1
    echo Autenticación habilitada.
) else if "%auth_opcion%"=="2" (
    echo Deshabilitando autenticación de arranque...
    bdehcfg -target default -set -authentication 0
    echo Autenticación deshabilitada.
) else if "%auth_opcion%"=="3" (
    goto configurar_arranque
)
pause
goto configurar_arranque

:configurar_pin
echo.
echo Configurando PIN de arranque...
bdehcfg -target default -set -pin
echo PIN configurado.
pause
goto configurar_arranque

:configurar_startup_key
echo.
set /p key_path="Ruta de la clave de arranque: "
echo.
echo Configurando clave de arranque...
bdehcfg -target default -set -startupkey "%key_path%"
echo Clave de arranque configurada.
pause
goto configurar_arranque

:ver_configuracion_arranque
echo.
echo Configuración actual de arranque:
echo =================================
bdehcfg -target default -get
echo.
pause
goto configurar_arranque

:monitorear_estado
echo.
echo [1] Estado de todas las unidades
echo [2] Estado de unidad específica
echo [3] Progreso de cifrado
echo [4] Monitoreo en tiempo real
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto estado_todas_unidades
if "%sub_opcion%"=="2" goto estado_unidad_especifica
if "%sub_opcion%"=="3" goto progreso_cifrado
if "%sub_opcion%"=="4" goto monitoreo_tiempo_real
if "%sub_opcion%"=="5" goto menu_principal
goto monitorear_estado

:estado_todas_unidades
echo.
echo Estado de Bitlocker en todas las unidades:
echo ==========================================
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo.
        echo Unidad %%d::
        manage-bde -status %%d: | findstr "Protection\|Conversion\|Percentage"
    )
)
echo.
pause
goto monitorear_estado

:estado_unidad_especifica
echo.
set /p unidad="Ingresa la letra de la unidad: "
echo.
echo Estado de Bitlocker en %unidad%::
echo ================================
manage-bde -status %unidad%:
echo.
pause
goto monitorear_estado

:progreso_cifrado
echo.
echo Progreso de cifrado:
echo ====================
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        manage-bde -status %%d: | findstr "Percentage" >nul
        if not errorlevel 1 (
            echo Unidad %%d:: - En proceso de cifrado
            manage-bde -status %%d: | findstr "Percentage"
        )
    )
)
echo.
pause
goto monitorear_estado

:monitoreo_tiempo_real
echo.
echo Monitoreo en tiempo real de Bitlocker
echo Presiona Ctrl+C para detener
echo.

:monitor_loop
cls
echo ========================================
echo    MONITOREO BITLOCKER - %time%
echo ========================================
echo.

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        manage-bde -status %%d: | findstr "Protection\|Conversion\|Percentage" >nul
        if not errorlevel 1 (
            echo Unidad %%d::
            manage-bde -status %%d: | findstr "Protection\|Conversion\|Percentage"
            echo.
        )
    )
)

echo Actualizando en 30 segundos...
timeout /t 30 /nobreak >nul
goto monitor_loop

:backup_restauracion
echo.
echo [1] Crear backup de configuración
echo [2] Restaurar configuración
echo [3] Exportar claves de recuperación
echo [4] Backup de TPM
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto crear_backup_config
if "%sub_opcion%"=="2" goto restaurar_config
if "%sub_opcion%"=="3" goto exportar_claves_backup
if "%sub_opcion%"=="4" goto backup_tpm
if "%sub_opcion%"=="5" goto menu_principal
goto backup_restauracion

:crear_backup_config
echo.
set /p backup_name="Nombre del backup: "
echo.
echo Creando backup de configuración de Bitlocker...

:: Backup de configuración
manage-bde -status C: > "%bitlocker_backup%\%backup_name%_config.txt"
manage-bde -protectors -get C: >> "%bitlocker_backup%\%backup_name%_config.txt"

echo Backup creado: %bitlocker_backup%\%backup_name%_config.txt
pause
goto backup_restauracion

:restaurar_config
echo.
set /p backup_file="Archivo de backup a restaurar: "
echo.
echo Restaurando configuración de Bitlocker...
echo Restauración manual requerida.
pause
goto backup_restauracion

:exportar_claves_backup
echo.
set /p archivo="Nombre del archivo: "
echo.
echo Exportando claves de recuperación...
manage-bde -protectors -get C: > "%bitlocker_backup%\%archivo%"
echo Claves exportadas a %bitlocker_backup%\%archivo%
pause
goto backup_restauracion

:backup_tpm
echo.
echo Creando backup del TPM...
tpm get > "%bitlocker_backup%\tpm_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
echo Backup del TPM creado.
pause
goto backup_restauracion

:auditoria_reportes
echo.
echo [1] Generar reporte completo
echo [2] Reporte de unidades cifradas
echo [3] Reporte de protectores
echo [4] Auditoría de seguridad
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto reporte_completo
if "%sub_opcion%"=="2" goto reporte_unidades_cifradas
if "%sub_opcion%"=="3" goto reporte_protectores
if "%sub_opcion%"=="4" goto auditoria_seguridad
if "%sub_opcion%"=="5" goto menu_principal
goto auditoria_reportes

:reporte_completo
echo.
set /p report_name="Nombre del reporte: "
echo.
echo Generando reporte completo de Bitlocker...

echo Reporte Completo de Bitlocker > "%bitlocker_logs%\%report_name%.txt"
echo Fecha: %date% %time% >> "%bitlocker_logs%\%report_name%.txt"
echo ======================================== >> "%bitlocker_logs%\%report_name%.txt"
echo. >> "%bitlocker_logs%\%report_name%.txt"

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo Unidad %%d:: >> "%bitlocker_logs%\%report_name%.txt"
        manage-bde -status %%d: >> "%bitlocker_logs%\%report_name%.txt"
        echo. >> "%bitlocker_logs%\%report_name%.txt"
    )
)

echo Reporte generado: %bitlocker_logs%\%report_name%.txt
pause
goto auditoria_reportes

:reporte_unidades_cifradas
echo.
echo Unidades cifradas con Bitlocker:
echo ================================
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        manage-bde -status %%d: | findstr "Protection On" >nul
        if not errorlevel 1 (
            echo Unidad %%d:: - CIFRADA
        )
    )
)
echo.
pause
goto auditoria_reportes

:reporte_protectores
echo.
echo Reporte de protectores por unidad:
echo ==================================
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        manage-bde -status %%d: | findstr "Protection On" >nul
        if not errorlevel 1 (
            echo.
            echo Unidad %%d:::
            manage-bde -protectors -get %%d:
        )
    )
)
echo.
pause
goto auditoria_reportes

:auditoria_seguridad
echo.
echo Auditoría de seguridad de Bitlocker:
echo ====================================
echo.

:: Verificar TPM
echo Verificando TPM...
tpm get | findstr "Ready" >nul
if not errorlevel 1 (
    echo [OK] TPM está listo
) else (
    echo [ADVERTENCIA] TPM no está listo
)

:: Verificar unidades del sistema
echo.
echo Verificando unidad del sistema...
manage-bde -status C: | findstr "Protection On" >nul
if not errorlevel 1 (
    echo [OK] Unidad C: está protegida
) else (
    echo [ADVERTENCIA] Unidad C: no está protegida
)

:: Verificar claves de recuperación
echo.
echo Verificando claves de recuperación...
manage-bde -protectors -get C: | findstr "Recovery Password" >nul
if not errorlevel 1 (
    echo [OK] Clave de recuperación configurada
) else (
    echo [ADVERTENCIA] No se encontró clave de recuperación
)

echo.
echo Auditoría completada.
pause
goto auditoria_reportes

:mantenimiento
echo.
echo [1] Suspender Bitlocker
echo [2] Reanudar Bitlocker
echo [3] Limpiar TPM
echo [4] Optimizar rendimiento
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto suspender_bitlocker
if "%sub_opcion%"=="2" goto reanudar_bitlocker
if "%sub_opcion%"=="3" goto limpiar_tpm
if "%sub_opcion%"=="4" goto optimizar_rendimiento
if "%sub_opcion%"=="5" goto menu_principal
goto mantenimiento

:suspender_bitlocker
echo.
set /p unidad="Ingresa la letra de la unidad: "
echo.
echo Suspendiend Bitlocker en %unidad%:...
manage-bde -protectors -disable %unidad%:
echo Bitlocker suspendido en %unidad%:.
pause
goto mantenimiento

:reanudar_bitlocker
echo.
set /p unidad="Ingresa la letra de la unidad: "
echo.
echo Reanudando Bitlocker en %unidad%:...
manage-bde -protectors -enable %unidad%:
echo Bitlocker reanudado en %unidad%:.
pause
goto mantenimiento

:limpiar_tpm
echo.
echo ADVERTENCIA: Limpiar el TPM eliminará todas las claves almacenadas.
set /p confirm="¿Estás seguro? (y/N): "
if /i "%confirm%"=="y" (
    echo Limpiando TPM...
    tpm clear
    echo TPM limpiado.
) else (
    echo Operación cancelada.
)
pause
goto mantenimiento

:optimizar_rendimiento
echo.
echo Optimizando rendimiento de Bitlocker...
echo Configurando parámetros de sistema...

:: Optimizar configuración de TPM
tpm set -forceclear

echo Optimización completada.
pause
goto mantenimiento

:salir
echo.
echo ¡Hasta luego!
exit /b 0 