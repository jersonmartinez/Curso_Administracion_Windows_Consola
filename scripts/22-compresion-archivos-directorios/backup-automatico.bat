@echo off
:: Sistema de backup automático con compresión
title 🗄️ Backup Automático
color 0B

:: Configuración
set "origen=C:\DatosImportantes"
set "destino=D:\Backups"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"

echo ========================================
echo    🗄️ SISTEMA DE BACKUP AUTOMÁTICO
echo ========================================
echo.

:: Crear directorio de destino si no existe
if not exist "%destino%" mkdir "%destino%"

echo 📁 Origen: %origen%
echo 📦 Destino: %destino%
echo 📅 Fecha: %fecha%
echo.

:: Crear backup comprimido
echo 🔄 Creando backup comprimido...
powershell -Command "Compress-Archive -Path '%origen%' -DestinationPath '%destino%\backup_%fecha%.zip' -Force"

if %errorlevel%==0 (
    echo ✅ Backup creado exitosamente: backup_%fecha%.zip
) else (
    echo ❌ Error al crear backup
)

:: Limpiar backups antiguos (más de 30 días)
echo 🧹 Limpiando backups antiguos...
forfiles /p "%destino%" /s /m *.zip /d -30 /c "cmd /c del @path" 2>nul

echo.
echo 🎉 Proceso de backup completado.
pause 