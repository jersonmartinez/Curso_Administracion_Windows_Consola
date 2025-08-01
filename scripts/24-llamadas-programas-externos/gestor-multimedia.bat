@echo off
:: Gestor de herramientas multimedia
title 🎨 Gestor Multimedia
color 0C

echo ========================================
echo    🎨 GESTOR DE HERRAMIENTAS MULTIMEDIA
echo ========================================
echo.

:: Conversión de video con FFmpeg
if exist "C:\Tools\ffmpeg\bin\ffmpeg.exe" (
    echo 🎬 Convirtiendo video...
    "C:\Tools\ffmpeg\bin\ffmpeg.exe" -i "video_entrada.mp4" -c:v libx264 -c:a aac "video_salida.mp4"
) else (
    echo ⚠️ FFmpeg no encontrado
)

:: Procesamiento de imágenes con ImageMagick
if exist "C:\Program Files\ImageMagick-7.0.11-Q16\magick.exe" (
    echo 🖼️ Procesando imágenes...
    "C:\Program Files\ImageMagick-7.0.11-Q16\magick.exe" convert imagen.jpg -resize 800x600 imagen_redimensionada.jpg
) else (
    echo ⚠️ ImageMagick no encontrado
)

:: Edición de audio con Audacity
if exist "C:\Program Files\Audacity\audacity.exe" (
    echo 🎵 Editando audio...
    start "" "C:\Program Files\Audacity\audacity.exe" "audio.wav"
) else (
    echo ⚠️ Audacity no encontrado
)

echo.
pause 