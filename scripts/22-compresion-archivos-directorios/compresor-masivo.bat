@echo off
:: Compresor masivo de directorios
title 🏭 Compresor Masivo
color 0E

echo ========================================
echo    🏭 COMPRESOR MASIVO DE DIRECTORIOS
echo ========================================
echo.

:: Lista de directorios a comprimir
set "directorios=C:\Logs C:\Temp C:\Cache C:\Backups"

for %%d in (%directorios%) do (
    if exist "%%d" (
        echo 🔄 Comprimiendo: %%d
        compact /c /s "%%d" /q
        if !errorlevel!==0 (
            echo ✅ %%d comprimido exitosamente
        ) else (
            echo ❌ Error al comprimir %%d
        )
    ) else (
        echo ⚠️ Directorio no encontrado: %%d
    )
)

echo.
echo 🎉 Compresión masiva completada.
pause 