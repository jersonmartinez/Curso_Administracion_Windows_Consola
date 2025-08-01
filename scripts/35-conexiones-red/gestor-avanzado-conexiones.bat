@echo off
:: Gestor avanzado de conexiones de red
title 🌐 Gestor de Conexiones de Red
color 0A

:menu
cls
echo ========================================
echo    🌐 GESTOR AVANZADO DE CONEXIONES
echo ========================================
echo.
echo 1. 👁️ Ver conexiones
echo 2. 🔍 Buscar conexiones
echo 3. 📊 Análisis de red
echo 4. 🛡️ Seguridad de red
echo 5. 📈 Monitoreo en tiempo real
echo 6. 📋 Reporte de red
echo 7. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto ver_conexiones
if "%opcion%"=="2" goto buscar_conexiones
if "%opcion%"=="3" goto analisis_red
if "%opcion%"=="4" goto seguridad_red
if "%opcion%"=="5" goto monitoreo_tiempo_real
if "%opcion%"=="6" goto reporte_red
if "%opcion%"=="7" goto salir
goto menu

:ver_conexiones
cls
echo ========================================
echo         👁️ VER CONEXIONES
echo ========================================
echo.
echo 1. Todas las conexiones
echo 2. Conexiones establecidas
echo 3. Puertos de escucha
echo 4. Con procesos
echo.
set /p tipo="Selecciona tipo de vista: "

if "%tipo%"=="1" (
    echo 🔍 Mostrando todas las conexiones...
    netstat -an
) else if "%tipo%"=="2" (
    echo 🔍 Mostrando conexiones establecidas...
    netstat -ano | findstr "ESTABLISHED"
) else if "%tipo%"=="3" (
    echo 🔍 Mostrando puertos de escucha...
    netstat -an | findstr "LISTENING"
) else if "%tipo%"=="4" (
    echo 🔍 Mostrando conexiones con procesos...
    netstat -ano
)
pause
goto menu

:buscar_conexiones
cls
echo ========================================
echo         🔍 BUSCAR CONEXIONES
echo ========================================
echo.
echo 1. Por puerto
echo 2. Por IP
echo 3. Por proceso
echo 4. Por protocolo
echo.
set /p metodo="Método de búsqueda: "

if "%metodo%"=="1" (
    set /p puerto="Puerto a buscar: "
    echo 🔍 Buscando conexiones en puerto %puerto%...
    netstat -ano | findstr ":%puerto%"
) else if "%metodo%"=="2" (
    set /p ip="IP a buscar: "
    echo 🔍 Buscando conexiones con IP %ip%...
    netstat -ano | findstr "%ip%"
) else if "%metodo%"=="3" (
    set /p proceso="Nombre del proceso: "
    echo 🔍 Buscando conexiones del proceso %proceso%...
    for /f "tokens=5" %%i in ('netstat -ano ^| findstr "ESTABLISHED"') do (
        tasklist | findstr "%%i" | findstr /i "%proceso%"
    )
) else if "%metodo%"=="4" (
    set /p protocolo="Protocolo (TCP/UDP): "
    echo 🔍 Buscando conexiones %protocolo%...
    netstat -an | findstr /i "%protocolo%"
)
pause
goto menu

:analisis_red
cls
echo ========================================
echo         📊 ANÁLISIS DE RED
echo ========================================
echo.
echo 🔍 Analizando red...
echo.
echo === ESTADÍSTICAS DE PROTOCOLOS ===
netstat -s
echo.
echo === CONEXIONES MÁS ACTIVAS ===
netstat -ano | findstr "ESTABLISHED" | find /c "ESTABLISHED"
echo.
echo === PUERTOS MÁS USADOS ===
netstat -an | findstr "LISTENING" | find /c "LISTENING"
pause
goto menu

:seguridad_red
cls
echo ========================================
echo         🛡️ SEGURIDAD DE RED
echo ========================================
echo.
echo 🔍 Analizando seguridad de red...
echo.
echo === CONEXIONES SOSPECHOSAS ===
echo Buscando conexiones a puertos no estándar...
netstat -ano | findstr "ESTABLISHED" | findstr /r ":[0-9][0-9][0-9][0-9][0-9]"
echo.
echo === CONEXIONES A IPs EXTERNAS ===
echo Buscando conexiones a rangos externos...
netstat -ano | findstr "ESTABLISHED" | findstr /r "[0-9][0-9][0-9]\.[0-9][0-9][0-9]\.[0-9][0-9][0-9]\.[0-9][0-9][0-9]"
echo.
echo === PUERTOS ABIERTOS ===
echo Puertos de escucha activos:
netstat -an | findstr "LISTENING"
pause
goto menu

:monitoreo_tiempo_real
cls
echo ========================================
echo         📈 MONITOREO EN TIEMPO REAL
echo ========================================
echo.
echo 🔄 Monitoreando conexiones (Ctrl+C para salir)...
echo.
:loop_monitoreo
cls
echo ========================================
echo         📈 MONITOREO EN TIEMPO REAL
echo ========================================
echo Fecha: %date% %time%
echo.
echo === CONEXIONES ACTIVAS ===
netstat -ano | findstr "ESTABLISHED" | find /c "ESTABLISHED"
echo.
echo === ÚLTIMAS CONEXIONES ===
netstat -ano | findstr "ESTABLISHED" | findstr /v "127.0.0.1" | head -10
timeout /t 5 /nobreak >nul
goto loop_monitoreo

:reporte_red
cls
echo ========================================
echo         📋 REPORTE DE RED
echo ========================================
echo.
echo 🔄 Generando reporte de red...
echo === REPORTE DE RED === > reporte_red.txt
echo Fecha: %date% %time% >> reporte_red.txt
echo. >> reporte_red.txt
echo === CONEXIONES ACTIVAS === >> reporte_red.txt
netstat -ano >> reporte_red.txt
echo. >> reporte_red.txt
echo === ESTADÍSTICAS === >> reporte_red.txt
netstat -s >> reporte_red.txt
echo. >> reporte_red.txt
echo === PUERTOS DE ESCUCHA === >> reporte_red.txt
netstat -an | findstr "LISTENING" >> reporte_red.txt
echo ✅ Reporte generado en reporte_red.txt
pause
goto menu

:salir
exit 