@echo off
:: Expansor programado de backups
title ⏰ Expansor Programado
color 0C

:: Configuración
set "dir_backups=C:\Backups\Comprimidos"
set "dir_restauracion=C:\Backups\Restaurados"
set "log_file=C:\Logs\expansion_%date:~-4,4%%date:~-10,2%%date:~-7,2%.log"

echo ========================================
echo    ⏰ EXPANSOR PROGRAMADO DE BACKUPS
echo ========================================
echo Fecha: %date% %time%
echo.

:: Crear directorio de restauración si no existe
if not exist "%dir_restauracion%" mkdir "%dir_restauracion%"

:: Procesar backups comprimidos
for %%f in ("%dir_backups%\*.zip") do (
    echo [%time%] Procesando: %%~nxf
    powershell -Command "Expand-Archive -Path '%%f' -DestinationPath '%dir_restauracion%' -Force" >> "%log_file%" 2>&1
    
    if !errorlevel!==0 (
        echo [%time%] ✅ %%~nxf expandido exitosamente
    ) else (
        echo [%time%] ❌ Error al expandir %%~nxf
    )
)

echo ✅ Procesamiento de backups completado.
echo 📄 Log guardado en: %log_file% 