@echo off
:: Extractor de paquetes de software
title 🚀 Extractor de Software
color 0D

set /p paquete="Paquete de software: "
set /p version="Versión (ej: 1.0.0): "

echo ========================================
echo    🚀 EXTRACTOR DE PAQUETES DE SOFTWARE
echo ========================================
echo.

:: Directorio de instalación
set "dir_instalacion=C:\Software\%version%"

:: Crear directorio de instalación
if exist "%dir_instalacion%" (
    echo ⚠️ El directorio ya existe. ¿Sobrescribir? (S/N)
    set /p confirmar=
    if /i "%confirmar%"=="S" (
        rmdir /s /q "%dir_instalacion%"
    ) else (
        echo ❌ Operación cancelada
        pause
        exit /b 1
    )
)

mkdir "%dir_instalacion%"

echo 🔄 Extrayendo paquete de software...
powershell -Command "Expand-Archive -Path '%paquete%' -DestinationPath '%dir_instalacion%' -Force"

if %errorlevel%==0 (
    echo ✅ Software extraído exitosamente
    
    :: Buscar archivos de instalación
    echo 🔍 Buscando archivos de instalación...
    dir "%dir_instalacion%" /s /b | findstr /i "setup\|install\|\.exe" > archivos_instalacion.txt
    
    if exist archivos_instalacion.txt (
        echo 📋 Archivos de instalación encontrados:
        type archivos_instalacion.txt
    )
    
    del archivos_instalacion.txt 2>nul
) else (
    echo ❌ Error al extraer software
)

echo.
pause 