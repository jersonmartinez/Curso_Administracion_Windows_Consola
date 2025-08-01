@echo off
:: Extractor con manejo de errores
title 🛡️ Extractor Robusto
color 0D

set /p archivo="Archivo a extraer: "
set /p destino="Directorio de destino: "

echo ========================================
echo    🛡️ EXTRACTOR CON MANEJO DE ERRORES
echo ========================================
echo.

:: Verificar archivo de entrada
if not exist "%archivo%" (
    echo ❌ Error: Archivo no encontrado - %archivo%
    pause
    exit /b 1
)

:: Verificar espacio disponible
for %%d in ("%destino%") do set "espacio_destino=%%~zd"
for %%f in ("%archivo%") do set "tamaño_archivo=%%~zf"

if %tamaño_archivo% gtr %espacio_destino% (
    echo ❌ Error: Espacio insuficiente en destino
    echo - Tamaño archivo: %tamaño_archivo% bytes
    echo - Espacio disponible: %espacio_destino% bytes
    pause
    exit /b 1
)

:: Crear directorio de destino
if not exist "%destino%" (
    echo 🔄 Creando directorio de destino...
    mkdir "%destino%"
    if !errorlevel! neq 0 (
        echo ❌ Error: No se pudo crear directorio de destino
        pause
        exit /b 1
    )
)

:: Intentar extraer archivo
echo 🔄 Extrayendo archivo...
powershell -Command "Expand-Archive -Path '%archivo%' -DestinationPath '%destino%' -Force" 2>error.log

if %errorlevel%==0 (
    echo ✅ Archivo extraído exitosamente
    
    :: Verificar contenido extraído
    dir "%destino%" /b >nul 2>&1
    if !errorlevel!==0 (
        echo 📋 Contenido extraído:
        dir "%destino%" /b
    ) else (
        echo ⚠️ Advertencia: Directorio de destino está vacío
    )
) else (
    echo ❌ Error al extraer archivo
    echo 📄 Detalles del error:
    type error.log
)

:: Limpiar archivo de error
del error.log 2>nul

echo.
pause 