@echo off
:: Monitoreo de procesos en tiempo real
title 📊 Monitoreo en Tiempo Real
color 0A

echo ========================================
echo    📊 MONITOREO DE PROCESOS EN TIEMPO REAL
echo ========================================
echo.

:menu
echo 1. 📈 Monitoreo general
echo 2. 🔍 Monitoreo específico
echo 3. 🚨 Alertas de memoria
echo 4. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto monitoreo_general
if "%opcion%"=="2" goto monitoreo_especifico
if "%opcion%"=="3" goto alertas_memoria
if "%opcion%"=="4" goto salir
goto menu

:monitoreo_general
cls
echo ========================================
echo         📈 MONITOREO GENERAL
echo ========================================
echo.
echo 🔄 Monitoreando procesos (Ctrl+C para salir)...
echo.
:loop_general
cls
echo ========================================
echo         📈 MONITOREO GENERAL
echo ========================================
echo Fecha: %date% %time%
echo.
echo === PROCESOS PRINCIPALES ===
tasklist /fo table | findstr /i "chrome\|firefox\|explorer\|svchost"
echo.
echo === USO DE MEMORIA ===
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /format:table
timeout /t 5 /nobreak >nul
goto loop_general

:monitoreo_especifico
cls
echo ========================================
echo         🔍 MONITOREO ESPECÍFICO
echo ========================================
echo.
set /p proceso="Proceso a monitorear: "
if defined proceso (
    echo 🔄 Monitoreando %proceso% (Ctrl+C para salir)...
    :loop_especifico
    cls
    echo ========================================
    echo         🔍 MONITOREO: %proceso%
    echo ========================================
    echo Fecha: %date% %time%
    echo.
    tasklist | findstr /i "%proceso%"
    echo.
    echo === INFORMACIÓN DETALLADA ===
    tasklist /v | findstr /i "%proceso%"
    timeout /t 3 /nobreak >nul
    goto loop_especifico
) else (
    echo ❌ Proceso no especificado
    pause
    goto menu
)

:alertas_memoria
cls
echo ========================================
echo         🚨 ALERTAS DE MEMORIA
echo ========================================
echo.
echo 🔄 Monitoreando uso de memoria (Ctrl+C para salir)...
echo.
:loop_alertas
cls
echo ========================================
echo         🚨 ALERTAS DE MEMORIA
echo ========================================
echo Fecha: %date% %time%
echo.
echo === PROCESOS CON MÁS DE 100MB ===
tasklist /v | findstr /i "memusage" | findstr /r "[0-9][0-9][0-9],"
echo.
echo === ALERTAS ===
for /f "tokens=5" %%i in ('tasklist /v ^| findstr /i "memusage" ^| findstr /r "[0-9][0-9][0-9],"') do (
    set mem=%%i
    set mem=!mem:,=!
    if !mem! gtr 200000 (
        echo ⚠️ Proceso usando más de 200MB detectado
    )
)
timeout /t 10 /nobreak >nul
goto loop_alertas

:salir
exit 