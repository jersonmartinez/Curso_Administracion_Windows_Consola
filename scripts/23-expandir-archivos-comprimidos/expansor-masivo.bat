@echo off
:: Expansor masivo de archivos comprimidos
title 📦 Expansor Masivo
color 0A

set /p directorio="Directorio con archivos comprimidos: "
set /p destino="Directorio de destino: "

echo ========================================
echo    📦 EXPANSOR MASIVO DE ARCHIVOS
echo ========================================
echo.

if not exist "%destino%" mkdir "%destino%"

echo 🔍 Buscando archivos comprimidos...
echo.

:: Procesar archivos ZIP
for %%f in ("%directorio%\*.zip") do (
    echo 📦 Expandiendo: %%~nxf
    powershell -Command "Expand-Archive -Path '%%f' -DestinationPath '%destino%' -Force"
    if !errorlevel!==0 (
        echo ✅ %%~nxf expandido exitosamente
    ) else (
        echo ❌ Error al expandir %%~nxf
    )
)

:: Procesar archivos TAR
for %%f in ("%directorio%\*.tar") do (
    echo 📦 Expandiendo: %%~nxf
    tar -xf "%%f" -C "%destino%"
    if !errorlevel!==0 (
        echo ✅ %%~nxf expandido exitosamente
    ) else (
        echo ❌ Error al expandir %%~nxf
    )
)

:: Procesar archivos TAR.GZ
for %%f in ("%directorio%\*.tar.gz") do (
    echo 📦 Expandiendo: %%~nxf
    tar -xzf "%%f" -C "%destino%"
    if !errorlevel!==0 (
        echo ✅ %%~nxf expandido exitosamente
    ) else (
        echo ❌ Error al expandir %%~nxf
    )
)

echo.
echo 🎉 Expansión masiva completada.
pause 