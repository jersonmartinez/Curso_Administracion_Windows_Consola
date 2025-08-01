@echo off
setlocal enabledelayedexpansion
title MONITOREO CONTINUO DE INTEGRIDAD

echo ========================================
echo    MONITOREO CONTINUO DE INTEGRIDAD
echo ========================================
echo.

REM Directorio a monitorear
set "directorio=C:\Archivos_Criticos"
set "log_file=integrity_monitor.log"

echo Iniciando monitoreo de %directorio%...
echo Monitoreo iniciado: %date% %time% >> %log_file%

:monitor_loop
for %%f in ("%directorio%\*.dat") do (
    certutil -hashfile "%%f" MD5 > temp_hash.txt
    for /f "skip=1 tokens=*" %%h in (temp_hash.txt) do set "hash_actual=%%h"
    
    REM Verificar si el hash cambió (simplificado)
    if not exist "%%f.hash" (
        echo !hash_actual! > "%%f.hash"
        echo Nuevo archivo detectado: %%f >> %log_file%
    ) else (
        for /f %%i in ("%%f.hash") do set "hash_anterior=%%i"
        if not "!hash_actual!"=="!hash_anterior!" (
            echo [ALERTA] Cambio detectado en %%f >> %log_file%
            echo !hash_actual! > "%%f.hash"
        )
    )
    del temp_hash.txt
)

timeout /t 30 /nobreak >nul
goto monitor_loop
