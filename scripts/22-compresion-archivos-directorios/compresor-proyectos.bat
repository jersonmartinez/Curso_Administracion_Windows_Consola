@echo off
:: Compresor de proyectos de desarrollo
title 🚀 Compresor de Proyectos
color 0D

set /p proyecto="Nombre del proyecto: "
set "ruta_proyecto=C:\Proyectos\%proyecto%"

echo ========================================
echo    🚀 COMPRESOR DE PROYECTOS DEV
echo ========================================
echo.

:: Crear directorio temporal sin archivos innecesarios
set "temp_dir=%TEMP%\proyecto_temp"
if exist "%temp_dir%" rmdir /s /q "%temp_dir%"
mkdir "%temp_dir%"

echo 🔄 Copiando archivos del proyecto...
xcopy "%ruta_proyecto%" "%temp_dir%" /E /I /H /Y /EXCLUDE:exclude.txt

:: Crear ZIP del proyecto limpio
echo 📦 Creando archivo ZIP...
powershell -Command "Compress-Archive -Path '%temp_dir%' -DestinationPath 'C:\Distribucion\%proyecto%.zip' -Force"

:: Limpiar directorio temporal
rmdir /s /q "%temp_dir%"

echo ✅ Proyecto %proyecto% comprimido exitosamente.
echo 📁 Ubicación: C:\Distribucion\%proyecto%.zip
pause 