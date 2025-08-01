@echo off
:: Expansor con verificación de integridad
title 🔐 Expansor Seguro
color 0B

set /p archivo="Archivo comprimido: "
set /p destino="Directorio de destino: "

echo ========================================
echo    🔐 EXPANSOR CON VERIFICACIÓN
echo ========================================
echo.

:: Verificar que el archivo existe
if not exist "%archivo%" (
    echo ❌ Archivo no encontrado: %archivo%
    pause
    exit /b 1
)

:: Crear directorio de destino si no existe
if not exist "%destino%" mkdir "%destino%"

:: Calcular hash del archivo comprimido
echo 🔍 Calculando hash del archivo comprimido...
certutil -hashfile "%archivo%" MD5 > hash_comprimido.txt

:: Expandir archivo
echo 📦 Expandiendo archivo...
powershell -Command "Expand-Archive -Path '%archivo%' -DestinationPath '%destino%' -Force"

if %errorlevel%==0 (
    echo ✅ Archivo expandido exitosamente
    
    :: Verificar archivos extraídos
    echo 🔍 Verificando archivos extraídos...
    dir "%destino%" /s /b > archivos_extraidos.txt
    
    echo 📊 Resumen de expansión:
    echo - Archivo original: %archivo%
    echo - Directorio destino: %destino%
    echo - Archivos extraídos: 
    type archivos_extraidos.txt
    
) else (
    echo ❌ Error al expandir archivo
)

:: Limpiar archivos temporales
del hash_comprimido.txt archivos_extraidos.txt 2>nul

echo.
pause 