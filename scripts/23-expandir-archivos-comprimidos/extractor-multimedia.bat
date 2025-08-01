@echo off
:: Extractor de archivos multimedia
title 🎨 Extractor Multimedia
color 0E

set /p archivo="Archivo multimedia comprimido: "
set /p categoria="Categoría (imagenes/videos/audio): "

echo ========================================
echo    🎨 EXTRACTOR DE ARCHIVOS MULTIMEDIA
echo ========================================
echo.

:: Directorios por categoría
if /i "%categoria%"=="imagenes" set "destino=C:\Multimedia\Imagenes"
if /i "%categoria%"=="videos" set "destino=C:\Multimedia\Videos"
if /i "%categoria%"=="audio" set "destino=C:\Multimedia\Audio"

if not exist "%destino%" mkdir "%destino%"

echo 🔄 Extrayendo archivos multimedia...
powershell -Command "Expand-Archive -Path '%archivo%' -DestinationPath '%destino%' -Force"

if %errorlevel%==0 (
    echo ✅ Archivos multimedia extraídos
    
    :: Mostrar estadísticas
    echo 📊 Estadísticas de extracción:
    dir "%destino%" /s /b | find /c /v "" > temp_count.txt
    set /p count=<temp_count.txt
    echo - Archivos extraídos: %count%
    del temp_count.txt
    
    :: Mostrar tipos de archivos
    echo 📋 Tipos de archivos encontrados:
    dir "%destino%" /s /b | findstr /i "\.jpg\|\.png\|\.gif\|\.mp4\|\.avi\|\.mp3\|\.wav"
) else (
    echo ❌ Error al extraer archivos multimedia
)

echo.
pause 