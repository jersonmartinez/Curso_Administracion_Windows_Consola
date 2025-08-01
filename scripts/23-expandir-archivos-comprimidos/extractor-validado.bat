@echo off
:: Extractor con validación de contenido
title ✅ Extractor Validado
color 0B

set /p archivo="Archivo a extraer: "
set /p destino="Directorio de destino: "
set /p archivo_esperado="Archivo que debe contener (ej: README.txt): "

echo ========================================
echo    ✅ EXTRACTOR CON VALIDACIÓN
echo ========================================
echo.

:: Extraer archivo
echo 🔄 Extrayendo archivo...
powershell -Command "Expand-Archive -Path '%archivo%' -DestinationPath '%destino%' -Force"

if %errorlevel%==0 (
    echo ✅ Archivo extraído
    
    :: Validar contenido esperado
    echo 🔍 Validando contenido...
    if exist "%destino%\%archivo_esperado%" (
        echo ✅ Archivo esperado encontrado: %archivo_esperado%
        
        :: Mostrar información del archivo
        echo 📋 Información del archivo:
        dir "%destino%\%archivo_esperado%"
    ) else (
        echo ⚠️ Archivo esperado no encontrado: %archivo_esperado%
        echo 📋 Contenido extraído:
        dir "%destino%" /b
    )
) else (
    echo ❌ Error al extraer archivo
)

echo.
pause 