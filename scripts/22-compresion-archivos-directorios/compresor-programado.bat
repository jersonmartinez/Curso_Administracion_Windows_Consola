@echo off
:: Script de compresión programada
title ⏰ Compresión Programada
color 0A

:: Configuración
set "directorios=C:\Logs C:\Temp C:\Cache"
set "log_file=C:\Logs\compresion_%date:~-4,4%%date:~-10,2%%date:~-7,2%.log"

echo ========================================
echo    ⏰ COMPRESIÓN PROGRAMADA
echo ========================================
echo Fecha: %date% %time%
echo.

:: Redirigir salida al log
call :comprimir_directorios >> "%log_file%" 2>&1

echo ✅ Compresión programada completada.
echo 📄 Log guardado en: %log_file%
exit /b

:comprimir_directorios
for %%d in (%directorios%) do (
    if exist "%%d" (
        echo [%time%] Comprimiendo: %%d
        compact /c /s "%%d" /q
        if !errorlevel!==0 (
            echo [%time%] ✅ %%d comprimido exitosamente
        ) else (
            echo [%time%] ❌ Error al comprimir %%d
        )
    )
)
goto :eof 