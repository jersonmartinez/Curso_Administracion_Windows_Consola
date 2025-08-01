@echo off
echo ========================================
echo    CREAR WORKSPACE PERSONALIZADO
echo ========================================
echo.

echo Creando workspace personalizado...
echo Creacion iniciada: %date% %time%

REM Configuración
set "usb_drive=E:"
set "workspace_dir=%usb_drive%\Workspace"

REM Crear estructura de directorios
echo === CREANDO ESTRUCTURA DE DIRECTORIOS ===
mkdir "%workspace_dir%"
mkdir "%workspace_dir%\Apps"
mkdir "%workspace_dir%\Data"
mkdir "%workspace_dir%\Config"

REM Copiar aplicaciones portátiles
echo === COPIANDO APLICACIONES PORTATILES ===
xcopy "C:\PortableApps\*" "%workspace_dir%\Apps\" /E /I /H /Y

REM Crear script de configuración automática
echo @echo off > "%workspace_dir%\setup_workspace.bat"
echo echo Configurando workspace... >> "%workspace_dir%\setup_workspace.bat"
echo echo Workspace configurado: %%date%% %%time%% >> "%workspace_dir%\setup_workspace.bat"

echo Workspace personalizado creado en %workspace_dir%
pause
