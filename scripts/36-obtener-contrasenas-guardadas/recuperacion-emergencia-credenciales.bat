@echo off
:: Recuperación de emergencia de credenciales
title 🚨 Recuperación de Credenciales
color 0C

echo ========================================
echo    🚨 RECUPERACIÓN DE CREDENCIALES
echo ========================================
echo.

:menu
echo 1. 🔍 Escaneo de emergencia
echo 2. 🔑 Recuperar credenciales críticas
echo 3. 📋 Generar reporte de emergencia
echo 4. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto escaneo_emergencia
if "%opcion%"=="2" goto recuperar_criticas
if "%opcion%"=="3" goto reporte_emergencia
if "%opcion%"=="4" goto salir
goto menu

:escaneo_emergencia
cls
echo ========================================
echo         🔍 ESCANEO DE EMERGENCIA
echo ========================================
echo.
echo 🔍 Escaneando credenciales críticas...
echo.
echo === CREDENCIALES DE ADMINISTRACIÓN ===
cmdkey /list | findstr /i "admin\|administrator"
echo.
echo === CREDENCIALES DE DOMINIO ===
cmdkey /list | findstr /i "domain\|corp"
echo.
echo === CREDENCIALES DE SERVIDORES ===
cmdkey /list | findstr /i "server\|srv"
echo.
echo === CREDENCIALES DE SERVICIOS ===
cmdkey /list | findstr /i "service\|system"
pause
goto menu

:recuperar_criticas
cls
echo ========================================
echo         🔑 RECUPERAR CRÍTICAS
echo ========================================
echo.
echo 🔄 Recuperando credenciales críticas...
echo.
echo === CREDENCIALES DE ADMINISTRACIÓN ===
for /f "tokens=1,2 delims= " %%a in ('cmdkey /list ^| findstr "admin"') do (
    echo Credencial encontrada: %%b
    echo Usuario: %%a
)
echo.
echo === CREDENCIALES DE DOMINIO ===
for /f "tokens=1,2 delims= " %%a in ('cmdkey /list ^| findstr "domain"') do (
    echo Credencial encontrada: %%b
    echo Usuario: %%a
)
pause
goto menu

:reporte_emergencia
cls
echo ========================================
echo         📋 REPORTE DE EMERGENCIA
echo ========================================
echo.
echo 🔄 Generando reporte de emergencia...
set archivo=emergencia_credenciales_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.txt
echo === REPORTE DE EMERGENCIA === > %archivo%
echo Fecha: %date% %time% >> %archivo%
echo. >> %archivo%
echo === CREDENCIALES CRÍTICAS === >> %archivo%
cmdkey /list >> %archivo%
echo. >> %archivo%
echo === ANÁLISIS DE SEGURIDAD === >> %archivo%
echo Credenciales de administración: >> %archivo%
cmdkey /list | findstr /i "admin" >> %archivo%
echo ✅ Reporte generado en %archivo%
pause
goto menu

:salir
exit 