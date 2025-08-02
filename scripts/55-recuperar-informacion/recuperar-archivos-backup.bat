@echo off
echo ========================================
echo  RECUPERAR ARCHIVOS DE BACKUP
echo ========================================
echo.

set /p backup_path="Ruta del backup: "
set /p destino="Ruta de destino: "

REM Verificar si existe el backup
if not exist "%backup_path%" (
    echo ERROR: No se encontró el backup en %backup_path%
    pause
    exit /b 1
)

REM Crear directorio de destino
mkdir "%destino%" 2>nul

REM Restaurar archivos
echo Restaurando archivos...
if exist "%backup_path%\*.zip" (
    REM Backup comprimido
    for %%f in ("%backup_path%\*.zip") do (
        echo Extrayendo %%f...
        powershell -command "Expand-Archive -Path '%%f' -DestinationPath '%destino%' -Force"
    )
) else (
    REM Backup directo
    xcopy "%backup_path%" "%destino%" /E /H /C /I /Y
)

REM Verificar restauración
echo.
echo Verificando restauración...
dir "%destino%"

echo Archivos restaurados en %destino%
pause
