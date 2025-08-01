@echo off
:: Gestor avanzado de procesos del sistema
title 🔥 Gestor de Procesos
color 0A

:menu
cls
echo ========================================
echo    🔥 GESTOR AVANZADO DE PROCESOS
echo ========================================
echo.
echo 1. 👁️ Ver procesos
echo 2. 🔍 Buscar proceso
echo 3. ❌ Terminar proceso
echo 4. 📊 Análisis de rendimiento
echo 5. 🛡️ Procesos sospechosos
echo 6. 📋 Reporte de procesos
echo 7. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto ver_procesos
if "%opcion%"=="2" goto buscar_proceso
if "%opcion%"=="3" goto terminar_proceso
if "%opcion%"=="4" goto analisis_rendimiento
if "%opcion%"=="5" goto procesos_sospechosos
if "%opcion%"=="6" goto reporte_procesos
if "%opcion%"=="7" goto salir
goto menu

:ver_procesos
cls
echo ========================================
echo         👁️ VER PROCESOS
echo ========================================
echo.
echo 1. Lista básica
echo 2. Información detallada
echo 3. Con servicios
echo 4. Con módulos DLL
echo.
set /p tipo="Selecciona tipo de vista: "

if "%tipo%"=="1" (
    echo 🔍 Listando procesos básicos...
    tasklist
) else if "%tipo%"=="2" (
    echo 🔍 Listando procesos detallados...
    tasklist /v
) else if "%tipo%"=="3" (
    echo 🔍 Listando procesos con servicios...
    tasklist /svc
) else if "%tipo%"=="4" (
    echo 🔍 Listando procesos con módulos...
    tasklist /m
)
pause
goto menu

:buscar_proceso
cls
echo ========================================
echo         🔍 BUSCAR PROCESO
echo ========================================
echo.
set /p nombre="Nombre del proceso: "
if defined nombre (
    echo 🔍 Buscando proceso: %nombre%
    tasklist | findstr /i "%nombre%"
) else (
    echo ❌ Nombre no especificado
)
pause
goto menu

:terminar_proceso
cls
echo ========================================
echo         ❌ TERMINAR PROCESO
echo ========================================
echo.
echo 1. Por nombre
echo 2. Por PID
echo 3. Forzar terminación
echo.
set /p metodo="Método de terminación: "

if "%metodo%"=="1" (
    set /p nombre="Nombre del proceso: "
    echo ⚠️ ¿Terminar proceso %nombre%?
    set /p confirm="(S/N): "
    if /i "%confirm%"=="S" (
        taskkill /im "%nombre%"
        echo ✅ Proceso terminado
    )
) else if "%metodo%"=="2" (
    set /p pid="PID del proceso: "
    echo ⚠️ ¿Terminar proceso PID %pid%?
    set /p confirm="(S/N): "
    if /i "%confirm%"=="S" (
        taskkill /pid %pid%
        echo ✅ Proceso terminado
    )
) else if "%metodo%"=="3" (
    set /p nombre="Nombre del proceso: "
    echo ⚠️ ¿Forzar terminación de %nombre%?
    set /p confirm="(S/N): "
    if /i "%confirm%"=="S" (
        taskkill /im "%nombre%" /f
        echo ✅ Proceso terminado forzadamente
    )
)
pause
goto menu

:analisis_rendimiento
cls
echo ========================================
echo         📊 ANÁLISIS DE RENDIMIENTO
echo ========================================
echo.
echo 🔍 Analizando rendimiento del sistema...
echo.
echo === PROCESOS CON MÁS MEMORIA ===
tasklist /v | findstr /i "memusage" | sort /r
echo.
echo === PROCESOS CON MÁS CPU ===
wmic process get name,processid,workingsetsize /format:table | findstr /i "chrome"
echo.
echo === USO TOTAL DE MEMORIA ===
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /format:table
pause
goto menu

:procesos_sospechosos
cls
echo ========================================
echo         🛡️ PROCESOS SOSPECHOSOS
echo ========================================
echo.
echo 🔍 Buscando procesos sospechosos...
echo.
echo === PROCESOS SIN NOMBRE DE USUARIO ===
tasklist /v | findstr /i "N/A"
echo.
echo === PROCESOS CON NOMBRES SUSPECTOS ===
tasklist | findstr /i "cryptominer\|malware\|virus"
echo.
echo === PROCESOS CON MÚLTIPLES INSTANCIAS ===
tasklist | findstr /i "chrome\|firefox\|explorer" | find /c "chrome"
pause
goto menu

:reporte_procesos
cls
echo ========================================
echo         📋 REPORTE DE PROCESOS
echo ========================================
echo.
echo 🔄 Generando reporte de procesos...
echo === REPORTE DE PROCESOS === > reporte_procesos.txt
echo Fecha: %date% %time% >> reporte_procesos.txt
echo. >> reporte_procesos.txt
echo === PROCESOS ACTIVOS === >> reporte_procesos.txt
tasklist /v >> reporte_procesos.txt
echo. >> reporte_procesos.txt
echo === SERVICIOS === >> reporte_procesos.txt
tasklist /svc >> reporte_procesos.txt
echo. >> reporte_procesos.txt
echo === USO DE MEMORIA === >> reporte_procesos.txt
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /format:table >> reporte_procesos.txt
echo ✅ Reporte generado en reporte_procesos.txt
pause
goto menu

:salir
exit 