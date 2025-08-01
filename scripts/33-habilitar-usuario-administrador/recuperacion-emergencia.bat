@echo off
:: Script de recuperación de emergencia para habilitar Administrador
title 🚨 Recuperación de Emergencia
color 0C

echo ========================================
echo    🚨 RECUPERACIÓN DE EMERGENCIA
echo ========================================
echo.
echo ⚠️ ADVERTENCIA: Este script está diseñado para situaciones de emergencia
echo donde el acceso administrativo normal no está disponible.
echo.

:menu
echo 1. 🚨 Habilitar Administrador (Emergencia)
echo 2. 🔐 Establecer contraseña de emergencia
echo 3. 🔧 Configuración mínima
echo 4. 📊 Verificar acceso
echo 5. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto emergencia_habilitar
if "%opcion%"=="2" goto emergencia_password
if "%opcion%"=="3" goto emergencia_config
if "%opcion%"=="4" goto emergencia_verificar
if "%opcion%"=="5" goto salir
goto menu

:emergencia_habilitar
cls
echo ========================================
echo         🚨 HABILITAR ADMINISTRADOR
echo ========================================
echo.
echo 🔄 Intentando habilitar Administrador...
echo.

echo Método 1: NET USER
net user Administrator /active:yes
if %errorlevel%==0 (
    echo ✅ Administrador habilitado con NET USER
    goto emergencia_exito
)

echo Método 2: WMIC
wmic useraccount where name="Administrator" set disabled=false
if %errorlevel%==0 (
    echo ✅ Administrador habilitado con WMIC
    goto emergencia_exito
)

echo Método 3: PowerShell
powershell -Command "Set-LocalUser -Name 'Administrator' -Enabled $true" 2>nul
if %errorlevel%==0 (
    echo ✅ Administrador habilitado con PowerShell
    goto emergencia_exito
)

echo ❌ No se pudo habilitar el Administrador
pause
goto menu

:emergencia_exito
echo.
echo 🎉 ¡Administrador habilitado exitosamente!
echo Ahora puedes acceder con la cuenta Administrator
pause
goto menu

:emergencia_password
cls
echo ========================================
echo         🔐 CONTRASEÑA DE EMERGENCIA
echo ========================================
echo.
echo 🔄 Estableciendo contraseña de emergencia...
net user Administrator EmergencyPass123
if %errorlevel%==0 (
    echo ✅ Contraseña establecida: EmergencyPass123
    echo ⚠️ IMPORTANTE: Cambia esta contraseña inmediatamente
) else (
    echo ❌ Error al establecer contraseña
)
pause
goto menu

:emergencia_config
cls
echo ========================================
echo         🔧 CONFIGURACIÓN MÍNIMA
echo ========================================
echo.
echo 🔄 Configurando Administrador para emergencia...
net user Administrator /passwordreq:yes /passwordchg:yes /expires:never
net localgroup Administradores Administrator /add
echo ✅ Configuración mínima aplicada
pause
goto menu

:emergencia_verificar
cls
echo ========================================
echo         📊 VERIFICAR ACCESO
echo ========================================
echo.
echo 🔍 Verificando acceso del Administrador...
net user Administrator | findstr "Cuenta activa"
if %errorlevel%==0 (
    echo ✅ Administrador está habilitado
) else (
    echo ❌ Administrador no está habilitado
)
echo.
echo === GRUPOS ===
net user Administrator | findstr "Miembros de grupo"
pause
goto menu

:salir
exit 