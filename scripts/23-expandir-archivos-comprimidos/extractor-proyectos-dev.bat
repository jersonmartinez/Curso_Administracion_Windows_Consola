@echo off
:: Extractor de proyectos de desarrollo
title 💻 Extractor de Proyectos Dev
color 0F

set /p proyecto="Proyecto comprimido: "
set /p lenguaje="Lenguaje de programación: "

echo ========================================
echo    💻 EXTRACTOR DE PROYECTOS DE DESARROLLO
echo ========================================
echo.

:: Directorio de proyectos
set "dir_proyectos=C:\Proyectos\%lenguaje%"
if not exist "%dir_proyectos%" mkdir "%dir_proyectos%"

:: Extraer proyecto
echo 🔄 Extrayendo proyecto...
powershell -Command "Expand-Archive -Path '%proyecto%' -DestinationPath '%dir_proyectos%' -Force"

if %errorlevel%==0 (
    echo ✅ Proyecto extraído exitosamente
    
    :: Buscar archivos de configuración del proyecto
    echo 🔍 Analizando estructura del proyecto...
    
    :: Buscar archivos de configuración comunes
    dir "%dir_proyectos%" /s /b | findstr /i "package\.json\|requirements\.txt\|pom\.xml\|\.sln\|\.csproj" > config_files.txt
    
    if exist config_files.txt (
        echo 📋 Archivos de configuración encontrados:
        type config_files.txt
    )
    
    :: Buscar archivos de código fuente
    echo 📝 Archivos de código fuente:
    dir "%dir_proyectos%" /s /b | findstr /i "\.js\|\.py\|\.java\|\.cs\|\.cpp\|\.h" | find /c /v ""
    
    del config_files.txt 2>nul
) else (
    echo ❌ Error al extraer proyecto
)

echo.
pause 