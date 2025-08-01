@echo off
:: Gestor avanzado de compresión
title 📦 Gestor Avanzado de Compresión
color 0A

:menu
cls
echo ========================================
echo    📦 GESTOR AVANZADO DE COMPRESIÓN
echo ========================================
echo.
echo 1. 📁 Comprimir directorio
echo 2. 📦 Crear archivo ZIP
echo 3. 🔍 Ver estadísticas de compresión
echo 4. 🗜️ Descomprimir archivos
echo 5. 🧹 Limpiar archivos temporales
echo 6. 📊 Backup con compresión
echo 7. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto comprimir_directorio
if "%opcion%"=="2" goto crear_zip
if "%opcion%"=="3" goto ver_estadisticas
if "%opcion%"=="4" goto descomprimir
if "%opcion%"=="5" goto limpiar_temp
if "%opcion%"=="6" goto backup_compresion
if "%opcion%"=="7" goto salir
goto menu

:comprimir_directorio
cls
echo ========================================
echo         📁 COMPRIMIR DIRECTORIO
echo ========================================
echo.
set /p directorio="Ruta del directorio: "
if exist "%directorio%" (
    echo 🔄 Comprimiendo %directorio%...
    compact /c /s "%directorio%"
    echo ✅ Compresión completada.
) else (
    echo ❌ Directorio no encontrado.
)
pause
goto menu

:crear_zip
cls
echo ========================================
echo         📦 CREAR ARCHIVO ZIP
echo ========================================
echo.
set /p origen="Ruta de origen: "
set /p destino="Archivo ZIP de destino: "
if exist "%origen%" (
    echo 🔄 Creando ZIP...
    powershell -Command "Compress-Archive -Path '%origen%' -DestinationPath '%destino%' -Force"
    echo ✅ Archivo ZIP creado.
) else (
    echo ❌ Ruta de origen no encontrada.
)
pause
goto menu

:ver_estadisticas
cls
echo ========================================
echo         🔍 ESTADÍSTICAS DE COMPRESIÓN
echo ========================================
echo.
set /p ruta="Ruta a analizar: "
if exist "%ruta%" (
    echo 📊 Estadísticas de compresión:
    compact /s "%ruta%"
) else (
    echo ❌ Ruta no encontrada.
)
pause
goto menu

:descomprimir
cls
echo ========================================
echo         🗜️ DESCOMPRIMIR ARCHIVOS
echo ========================================
echo.
set /p archivo="Archivo a descomprimir: "
if exist "%archivo%" (
    echo 🔄 Descomprimiendo...
    compact /u /s "%archivo%"
    echo ✅ Descompresión completada.
) else (
    echo ❌ Archivo no encontrado.
)
pause
goto menu

:limpiar_temp
cls
echo ========================================
echo         🧹 LIMPIAR ARCHIVOS TEMP
echo ========================================
echo.
echo 🔄 Limpiando archivos temporales...
del /q /f %TEMP%\*.* 2>nul
echo ✅ Limpieza completada.
pause
goto menu

:backup_compresion
cls
echo ========================================
echo         📊 BACKUP CON COMPRESIÓN
echo ========================================
echo.
set /p origen="Directorio a respaldar: "
set /p destino="Ubicación del backup: "
if exist "%origen%" (
    echo 🔄 Creando backup comprimido...
    powershell -Command "Compress-Archive -Path '%origen%' -DestinationPath '%destino%\backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip' -Force"
    echo ✅ Backup creado exitosamente.
) else (
    echo ❌ Directorio de origen no encontrado.
)
pause
goto menu

:salir
exit 