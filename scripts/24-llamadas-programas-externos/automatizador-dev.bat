@echo off
:: Automatizador de desarrollo
title 🚀 Automatizador Dev
color 0F

echo ========================================
echo    🚀 AUTOMATIZADOR DE DESARROLLO
echo ========================================
echo.

:: Limpiar build anterior
echo 🧹 Limpiando build anterior...
if exist "build" rmdir /s /q "build"
mkdir build

:: Compilar con herramientas externas
echo 🔨 Compilando proyecto...
if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" (
    "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" proyecto.sln /p:Configuration=Release /p:Platform=x64
) else (
    echo ⚠️ MSBuild no encontrado
)

:: Ejecutar tests
echo 🧪 Ejecutando tests...
if exist "C:\Program Files\dotnet\dotnet.exe" (
    dotnet test
) else (
    echo ⚠️ .NET no encontrado
)

:: Crear paquete de distribución
echo 📦 Creando paquete de distribución...
if exist "C:\Program Files\7-Zip\7z.exe" (
    "C:\Program Files\7-Zip\7z.exe" a -tzip release.zip build\*
) else (
    echo ⚠️ 7-Zip no encontrado
)

echo.
echo 🎉 Automatización completada.
pause 