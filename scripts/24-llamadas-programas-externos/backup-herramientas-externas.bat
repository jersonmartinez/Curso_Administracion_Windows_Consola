@echo off
:: Sistema de backup con herramientas externas
title 🗄️ Backup con Herramientas Externas
color 0C

set "origen=C:\DatosImportantes"
set "destino=D:\Backups"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"

echo ========================================
echo    🗄️ SISTEMA DE BACKUP CON HERRAMIENTAS EXTERNAS
echo ========================================
echo.

:: Crear backup con 7-Zip
echo 🔄 Creando backup comprimido con 7-Zip...
"C:\Program Files\7-Zip\7z.exe" a -t7z "%destino%\backup_%fecha%.7z" "%origen%\*" -mx9

if %errorlevel%==0 (
    echo ✅ Backup 7-Zip creado exitosamente
) else (
    echo ❌ Error al crear backup 7-Zip
)

:: Crear backup con Robocopy
echo 🔄 Creando backup con Robocopy...
robocopy "%origen%" "%destino%\backup_%fecha%" /MIR /R:3 /W:10 /LOG:"%destino%\backup_%fecha%.log"

if %errorlevel% leq 7 (
    echo ✅ Backup Robocopy completado
) else (
    echo ❌ Error en backup Robocopy
)

echo.
echo 🎉 Proceso de backup completado.
pause 