@echo off
echo ========================================
echo  RECUPERAR ARCHIVOS DE BACKUP
echo ========================================
echo.

set /p backup_path="Ruta del backup: "
set /p destino="Ruta de destino: "

if not exist "%backup_path%" (
    echo ERROR: No se encontró el backup en %backup_path%
    pause
    exit /b 1
)

mkdir "%destino%" 2>nul

echo Restaurando archivos...
if exist "%backup_path%\*.zip" (
    for %%f in ("%backup_path%\*.zip") do (
        echo Extrayendo %%f...
        powershell -command "Expand-Archive -Path '%%f' -DestinationPath '%destino%' -Force"
    )
) else (
    xcopy "%backup_path%" "%destino%" /E /H /C /I /Y
)

echo.
echo Verificando restauración...
dir "%destino%"
echo Archivos restaurados en %destino%
pause
