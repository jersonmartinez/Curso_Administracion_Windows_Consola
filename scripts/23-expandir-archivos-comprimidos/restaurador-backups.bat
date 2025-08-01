@echo off
:: Restaurador de backups comprimidos
title 🗄️ Restaurador de Backups
color 0C

set /p backup="Archivo de backup: "
set /p destino="Directorio de restauración: "

echo ========================================
echo    🗄️ RESTAURADOR DE BACKUPS
echo ========================================
echo.

:: Verificar espacio disponible
for %%d in ("%destino%") do set "espacio_destino=%%~zd"
for %%f in ("%backup%") do set "tamaño_backup=%%~zf"

echo 📊 Información de restauración:
echo - Backup: %backup%
echo - Tamaño: %tamaño_backup% bytes
echo - Destino: %destino%
echo.

:: Crear directorio de destino con timestamp
set "destino_final=%destino%\restauracion_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%"
set "destino_final=%destino_final: =0%"
mkdir "%destino_final%"

echo 🔄 Restaurando backup...
powershell -Command "Expand-Archive -Path '%backup%' -DestinationPath '%destino_final%' -Force"

if %errorlevel%==0 (
    echo ✅ Backup restaurado exitosamente en: %destino_final%
    
    :: Mostrar contenido restaurado
    echo 📋 Contenido restaurado:
    dir "%destino_final%" /s /b
) else (
    echo ❌ Error al restaurar backup
)

echo.
pause 