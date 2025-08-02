@echo off
setlocal enabledelayedexpansion
title Gestion Completa de Windows To Go
color 0F

:: Configuración
set "wtg_config=%~dp0wtg_config"
set "wtg_backups=%~dp0wtg_backups"

:: Crear directorios de configuración
if not exist "%wtg_config%" mkdir "%wtg_config%"
if not exist "%wtg_backups%" mkdir "%wtg_backups%"

:: Función de logging
:log_action
echo [%date% %time%] %~1 >> "%wtg_config%\wtg_actions.log"
goto :eof

:: Función para mostrar menú principal
:show_menu
cls
echo.
echo ========================================
echo    GESTION COMPLETA DE WINDOWS TO GO
echo ========================================
echo.
echo [1] Crear Windows To Go
echo [2] Configurar arranque dual
echo [3] Crear workspace personalizado
echo [4] Gestionar instalaciones
echo [5] Backup y restauracion
echo [6] Salir
echo.
set /p opcion="Seleccione una opcion: "
goto :eof

:: Función para crear Windows To Go
:crear_wtg
echo.
echo === CREAR WINDOWS TO GO ===
echo.
set /p usb="Unidad USB (ej: E:): "
set /p image="Ruta de imagen WIM: "

echo Verificando unidad USB...
if not exist "%usb%" (
    echo [ERROR] La unidad %usb% no existe
    call :log_action "ERROR: Unidad %usb% no encontrada"
    pause
    goto menu_principal
)

echo Verificando imagen WIM...
if not exist "%image%" (
    echo [ERROR] La imagen %image% no existe
    call :log_action "ERROR: Imagen %image% no encontrada"
    pause
    goto menu_principal
)

echo.
echo Iniciando creación de Windows To Go...
echo Aplicando imagen a %usb%...
dism /apply-image /imagefile:"%image%" /index:1 /applydir:%usb% /checkintegrity

if errorlevel 1 (
    echo [ERROR] Error al aplicar la imagen
    call :log_action "ERROR: Fallo al aplicar imagen %image%"
    pause
    goto menu_principal
)

echo Configurando arranque...
bcdboot %usb%\Windows /s %usb% /f all

if errorlevel 1 (
    echo [ERROR] Error al configurar arranque
    call :log_action "ERROR: Fallo al configurar arranque en %usb%"
    pause
    goto menu_principal
)

echo.
echo [EXITO] Windows To Go creado exitosamente en %usb%
call :log_action "EXITO: Windows To Go creado en %usb%"
pause
goto menu_principal

:: Función para configurar arranque
:configurar_arranque
echo.
echo === CONFIGURAR ARRANQUE ===
echo.
set /p usb="Unidad USB: "

if not exist "%usb%\boot\bcd" (
    echo [ERROR] No se encontró BCD en %usb%
    call :log_action "ERROR: BCD no encontrado en %usb%"
    pause
    goto menu_principal
)

echo Configurando timeout de arranque...
bcdedit /store %usb%\boot\bcd /set {bootmgr} timeout 10

if errorlevel 1 (
    echo [ERROR] Error al configurar timeout
    call :log_action "ERROR: Fallo al configurar timeout en %usb%"
) else (
    echo [EXITO] Arranque configurado exitosamente
    call :log_action "EXITO: Arranque configurado en %usb%"
)

pause
goto menu_principal

:: Función para crear workspace personalizado
:crear_workspace
echo.
echo === CREAR WORKSPACE PERSONALIZADO ===
echo.
set /p usb="Unidad USB: "
set /p workspace_name="Nombre del workspace: "

if not exist "%usb%\Users" (
    echo [ERROR] Windows To Go no encontrado en %usb%
    call :log_action "ERROR: Windows To Go no encontrado en %usb%"
    pause
    goto menu_principal
)

set "workspace_path=%usb%\Workspaces\%workspace_name%"
mkdir "%workspace_path%" 2>nul

echo Creando estructura de workspace...
mkdir "%workspace_path%\Documents" 2>nul
mkdir "%workspace_path%\Projects" 2>nul
mkdir "%workspace_path%\Tools" 2>nul
mkdir "%workspace_path%\Config" 2>nul

echo Creando archivo de configuración...
echo # Configuración de Workspace: %workspace_name% > "%workspace_path%\Config\workspace.conf"
echo Fecha_creacion=%date% %time% >> "%workspace_path%\Config\workspace.conf"
echo Unidad=%usb% >> "%workspace_path%\Config\workspace.conf"

echo.
echo [EXITO] Workspace '%workspace_name%' creado en %workspace_path%
call :log_action "EXITO: Workspace %workspace_name% creado en %usb%"
pause
goto menu_principal

:: Función para gestionar instalaciones
:gestionar_instalaciones
echo.
echo === GESTIONAR INSTALACIONES ===
echo.
echo Buscando instalaciones de Windows To Go...
echo.

set "found_installations=0"
for %%d in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\Windows\System32" (
        echo [ENCONTRADO] Dispositivo: %%d: - Windows To Go detectado
        set /a found_installations+=1
        
        :: Verificar espacio disponible
        for /f "tokens=3" %%s in ('dir %%d: ^| find "bytes free"') do (
            echo    Espacio libre: %%s
        )
        
        :: Verificar fecha de instalación
        if exist "%%d:\Windows\System32\config\SYSTEM" (
            for /f "tokens=1,2" %%a in ('dir "%%d:\Windows\System32\config\SYSTEM" ^| find "SYSTEM"') do (
                echo    Fecha: %%a %%b
            )
        )
        echo.
    )
)

if %found_installations%==0 (
    echo [INFO] No se encontraron instalaciones de Windows To Go
    call :log_action "INFO: No se encontraron instalaciones WTG"
) else (
    echo Total de instalaciones encontradas: %found_installations%
    call :log_action "INFO: %found_installations% instalaciones WTG encontradas"
)

pause
goto menu_principal

:: Función para backup y restauración
:backup_restauracion
echo.
echo === BACKUP Y RESTAURACION ===
echo.
echo [1] Crear backup
echo [2] Restaurar backup
echo [3] Listar backups
echo [4] Volver al menú principal
echo.
set /p backup_option="Seleccione una opción: "

if "%backup_option%"=="1" goto crear_backup
if "%backup_option%"=="2" goto restaurar_backup
if "%backup_option%"=="3" goto listar_backups
if "%backup_option%"=="4" goto menu_principal
goto backup_restauracion

:crear_backup
echo.
set /p usb="Unidad USB: "
set /p backup_name="Nombre del backup: "

if not exist "%usb%\Windows" (
    echo [ERROR] Windows To Go no encontrado en %usb%
    call :log_action "ERROR: WTG no encontrado para backup en %usb%"
    pause
    goto backup_restauracion
)

set "backup_path=%wtg_backups%\%backup_name%.wim"
echo.
echo Creando backup de %usb%...
echo Archivo: %backup_path%
echo.

dism /capture-image /imagefile:"%backup_path%" /capturedir:%usb% /name:"WTG Backup - %backup_name%" /description:"Backup creado el %date% %time%"

if errorlevel 1 (
    echo [ERROR] Error al crear backup
    call :log_action "ERROR: Fallo al crear backup %backup_name%"
) else (
    echo [EXITO] Backup creado exitosamente
    call :log_action "EXITO: Backup %backup_name% creado"
)

pause
goto backup_restauracion

:restaurar_backup
echo.
echo Backups disponibles:
echo --------------------
dir /b "%wtg_backups%\*.wim" 2>nul
echo.
set /p backup_file="Nombre del archivo de backup: "

if not exist "%wtg_backups%\%backup_file%" (
    echo [ERROR] Archivo de backup no encontrado
    call :log_action "ERROR: Backup %backup_file% no encontrado"
    pause
    goto backup_restauracion
)

set /p usb="Unidad USB destino: "

echo.
echo Restaurando backup a %usb%...
dism /apply-image /imagefile:"%wtg_backups%\%backup_file%" /index:1 /applydir:%usb% /checkintegrity

if errorlevel 1 (
    echo [ERROR] Error al restaurar backup
    call :log_action "ERROR: Fallo al restaurar backup %backup_file%"
) else (
    echo [EXITO] Backup restaurado exitosamente
    call :log_action "EXITO: Backup %backup_file% restaurado a %usb%"
)

pause
goto backup_restauracion

:listar_backups
echo.
echo Backups disponibles:
echo --------------------
dir /b "%wtg_backups%\*.wim" 2>nul
echo.
pause
goto backup_restauracion

:: Menú principal
:menu_principal
call :show_menu

if "%opcion%"=="1" goto crear_wtg
if "%opcion%"=="2" goto configurar_arranque
if "%opcion%"=="3" goto crear_workspace
if "%opcion%"=="4" goto gestionar_instalaciones
if "%opcion%"=="5" goto backup_restauracion
if "%opcion%"=="6" goto salir

goto menu_principal

:salir
echo.
echo Gracias por usar la Gestion de Windows To Go
call :log_action "INFO: Sesión terminada"
exit /b 0 