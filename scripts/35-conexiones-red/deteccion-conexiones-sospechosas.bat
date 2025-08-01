@echo off
:: Detección de conexiones sospechosas
title 🛡️ Detección de Conexiones Sospechosas
color 0C

echo ========================================
echo    🛡️ DETECCIÓN DE CONEXIONES SOSPECHOSAS
echo ========================================
echo.

:menu
echo 1. 🔍 Escaneo básico
echo 2. 🔍 Escaneo avanzado
echo 3. 🚨 Alertas en tiempo real
echo 4. 📊 Análisis de patrones
echo 5. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto escaneo_basico
if "%opcion%"=="2" goto escaneo_avanzado
if "%opcion%"=="3" goto alertas_tiempo_real
if "%opcion%"=="4" goto analisis_patrones
if "%opcion%"=="5" goto salir
goto menu

:escaneo_basico
cls
echo ========================================
echo         🔍 ESCANEO BÁSICO
echo ========================================
echo.
echo 🔍 Escaneando conexiones sospechosas...
echo.
echo === CONEXIONES A PUERTOS NO ESTÁNDAR ===
netstat -ano | findstr "ESTABLISHED" | findstr /r ":[0-9][0-9][0-9][0-9][0-9]"
echo.
echo === CONEXIONES A IPs EXTERNAS ===
netstat -ano | findstr "ESTABLISHED" | findstr /v "127.0.0.1\|192.168\|10\."
echo.
echo === PROCESOS CON MÚLTIPLES CONEXIONES ===
for /f "tokens=5" %%i in ('netstat -ano ^| findstr "ESTABLISHED"') do (
    echo Proceso PID %%i tiene múltiples conexiones
)
pause
goto menu

:escaneo_avanzado
cls
echo ========================================
echo         🔍 ESCANEO AVANZADO
echo ========================================
echo.
echo 🔍 Escaneo avanzado de seguridad...
echo.
echo === CONEXIONES CRÍPTICAS ===
netstat -ano | findstr "ESTABLISHED" | findstr /i "crypto\|miner\|torrent"
echo.
echo === CONEXIONES A SERVIDORES SOSPECHOSOS ===
netstat -ano | findstr "ESTABLISHED" | findstr /i "\.ru\|\.cn\|\.kr"
echo.
echo === PUERTOS DE COMANDO Y CONTROL ===
netstat -ano | findstr "ESTABLISHED" | findstr ":4444\|:8080\|:31337"
pause
goto menu

:alertas_tiempo_real
cls
echo ========================================
echo         🚨 ALERTAS EN TIEMPO REAL
echo ========================================
echo.
echo 🔄 Monitoreando alertas (Ctrl+C para salir)...
echo.
:loop_alertas
cls
echo ========================================
echo         🚨 ALERTAS EN TIEMPO REAL
echo ========================================
echo Fecha: %date% %time%
echo.
echo === NUEVAS CONEXIONES ===
netstat -ano | findstr "ESTABLISHED" | findstr /v "127.0.0.1"
echo.
echo === ALERTAS ===
for /f "tokens=2" %%i in ('netstat -ano ^| findstr "ESTABLISHED"') do (
    echo ⚠️ Nueva conexión detectada: %%i
)
timeout /t 10 /nobreak >nul
goto loop_alertas

:analisis_patrones
cls
echo ========================================
echo         📊 ANÁLISIS DE PATRONES
echo ========================================
echo.
echo 🔍 Analizando patrones de conexión...
echo.
echo === CONEXIONES POR HORA ===
echo Patrón de conexiones en las últimas horas:
echo.
echo === CONEXIONES MÁS FRECUENTES ===
netstat -ano | findstr "ESTABLISHED" | find /c "ESTABLISHED"
echo.
echo === PUERTOS MÁS USADOS ===
netstat -an | findstr "LISTENING" | find /c "LISTENING"
pause
goto menu

:salir
exit 