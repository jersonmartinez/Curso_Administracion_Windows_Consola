@echo off
:: Monitoreo en tiempo real
title 📊 Monitoreo en Tiempo Real
color 0B

echo ========================================
echo    📊 MONITOREO EN TIEMPO REAL
echo ========================================
echo.

:menu_monitoreo
echo 1. 🔥 Monitoreo de CPU
echo 2. 💾 Monitoreo de memoria
echo 3. 💿 Monitoreo de disco
echo 4. 🌐 Monitoreo de red
echo 5. 🔥 Monitoreo de procesos
echo 6. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto monitoreo_cpu
if "%opcion%"=="2" goto monitoreo_memoria
if "%opcion%"=="3" goto monitoreo_disco
if "%opcion%"=="4" goto monitoreo_red
if "%opcion%"=="5" goto monitoreo_procesos
if "%opcion%"=="6" goto salir
goto menu_monitoreo

:monitoreo_cpu
cls
echo ========================================
echo         🔥 MONITOREO DE CPU
echo ========================================
echo.
echo 🔄 Monitoreando CPU (Ctrl+C para salir)...
:loop_cpu
wmic cpu get loadpercentage
timeout /t 5 /nobreak >nul
goto loop_cpu

:monitoreo_memoria
cls
echo ========================================
echo         💾 MONITOREO DE MEMORIA
echo ========================================
echo.
echo 🔄 Monitoreando memoria (Ctrl+C para salir)...
:loop_memoria
wmic OS get freephysicalmemory,totalvisiblememorysize
timeout /t 5 /nobreak >nul
goto loop_memoria

:monitoreo_disco
cls
echo ========================================
echo         💿 MONITOREO DE DISCO
echo ========================================
echo.
echo 🔄 Monitoreando disco (Ctrl+C para salir)...
:loop_disco
wmic logicaldisk get size,freespace,caption
timeout /t 10 /nobreak >nul
goto loop_disco

:monitoreo_red
cls
echo ========================================
echo         🌐 MONITOREO DE RED
echo ========================================
echo.
echo 🔄 Monitoreando red (Ctrl+C para salir)...
:loop_red
netstat -an | findstr "ESTABLISHED"
timeout /t 5 /nobreak >nul
goto loop_red

:monitoreo_procesos
cls
echo ========================================
echo         🔥 MONITOREO DE PROCESOS
echo ========================================
echo.
echo 🔄 Monitoreando procesos (Ctrl+C para salir)...
:loop_procesos
tasklist /fo table | findstr /i "Image Name"
timeout /t 10 /nobreak >nul
goto loop_procesos

:salir
exit 