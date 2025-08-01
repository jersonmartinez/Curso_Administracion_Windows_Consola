@echo off
:: Diagnóstico completo del sistema
title 💻 Diagnóstico del Sistema
color 0A

echo ========================================
echo    💻 DIAGNÓSTICO COMPLETO DEL SISTEMA
echo ========================================
echo.

:menu
echo 1. 📊 Información general
echo 2. 🔧 Información de hardware
echo 3. 🔥 Procesos y rendimiento
echo 4. 🌐 Información de red
echo 5. 🔧 Servicios y drivers
echo 6. 👥 Información de usuarios
echo 7. ⚡ Información de energía
echo 8. 📋 Reporte completo
echo 9. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto info_general
if "%opcion%"=="2" goto info_hardware
if "%opcion%"=="3" goto info_procesos
if "%opcion%"=="4" goto info_red
if "%opcion%"=="5" goto info_servicios
if "%opcion%"=="6" goto info_usuarios
if "%opcion%"=="7" goto info_energia
if "%opcion%"=="8" goto reporte_completo
if "%opcion%"=="9" goto salir
goto menu

:info_general
cls
echo ========================================
echo         📊 INFORMACIÓN GENERAL
echo ========================================
echo.
echo 🔄 Obteniendo información general...
systeminfo | findstr /i "OS Name,OS Version,Total Physical Memory"
echo.
pause
goto menu

:info_hardware
cls
echo ========================================
echo         🔧 INFORMACIÓN DE HARDWARE
echo ========================================
echo.
echo 🔄 Obteniendo información de hardware...
echo === CPU ===
wmic cpu get name,numberofcores
echo === MEMORIA ===
wmic computersystem get totalphysicalmemory
echo === DISCO ===
wmic logicaldisk get size,freespace,caption
echo.
pause
goto menu

:info_procesos
cls
echo ========================================
echo         🔥 PROCESOS Y RENDIMIENTO
echo ========================================
echo.
echo 🔄 Obteniendo información de procesos...
tasklist /fo table | findstr /i "Image Name"
echo.
echo === RENDIMIENTO ===
wmic cpu get loadpercentage
echo.
pause
goto menu

:info_red
cls
echo ========================================
echo         🌐 INFORMACIÓN DE RED
echo ========================================
echo.
echo 🔄 Obteniendo información de red...
ipconfig | findstr /i "IPv4"
echo.
echo === CONEXIONES ===
netstat -an | findstr "ESTABLISHED"
echo.
pause
goto menu

:info_servicios
cls
echo ========================================
echo         🔧 SERVICIOS Y DRIVERS
echo ========================================
echo.
echo 🔄 Obteniendo información de servicios...
sc query | findstr "RUNNING"
echo.
echo === DRIVERS ===
driverquery | findstr /i "running"
echo.
pause
goto menu

:info_usuarios
cls
echo ========================================
echo         👥 INFORMACIÓN DE USUARIOS
echo ========================================
echo.
echo 🔄 Obteniendo información de usuarios...
net user
echo.
echo === USUARIOS ACTIVOS ===
query user
echo.
pause
goto menu

:info_energia
cls
echo ========================================
echo         ⚡ INFORMACIÓN DE ENERGÍA
echo ========================================
echo.
echo 🔄 Obteniendo información de energía...
powercfg /list
echo.
echo === BATERÍA ===
wmic path win32_battery get estimatedchargeremaining 2>nul
echo.
pause
goto menu

:reporte_completo
cls
echo ========================================
echo         📋 REPORTE COMPLETO
echo ========================================
echo.
echo 🔄 Generando reporte completo...
echo === REPORTE DEL SISTEMA === > reporte_sistema.txt
echo Fecha: %date% %time% >> reporte_sistema.txt
echo. >> reporte_sistema.txt
systeminfo >> reporte_sistema.txt
echo. >> reporte_sistema.txt
echo === PROCESOS === >> reporte_sistema.txt
tasklist >> reporte_sistema.txt
echo. >> reporte_sistema.txt
echo === RED === >> reporte_sistema.txt
ipconfig /all >> reporte_sistema.txt
echo ✅ Reporte generado en reporte_sistema.txt
pause
goto menu

:salir
exit 