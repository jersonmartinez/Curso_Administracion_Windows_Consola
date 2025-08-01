@echo off
:: Extractor de archivos de red
title 🌐 Extractor de Red
color 0A

set /p ruta_red="Ruta de red del archivo: "
set /p destino_local="Directorio local de destino: "

echo ========================================
echo    🌐 EXTRACTOR DE ARCHIVOS DE RED
echo ========================================
echo.

:: Verificar conectividad de red
if exist "%ruta_red%" (
    echo ✅ Conexión de red establecida
    
    :: Crear directorio de destino
    if not exist "%destino_local%" mkdir "%destino_local%"
    
    :: Extraer archivo de red
    echo 🔄 Extrayendo archivo de red...
    powershell -Command "Expand-Archive -Path '%ruta_red%' -DestinationPath '%destino_local%' -Force"
    
    if %errorlevel%==0 (
        echo ✅ Archivo extraído exitosamente desde red
    ) else (
        echo ❌ Error al extraer archivo de red
    )
) else (
    echo ❌ No se puede acceder al archivo de red
    echo 💡 Verifica la conectividad y permisos de red
)

echo.
pause 