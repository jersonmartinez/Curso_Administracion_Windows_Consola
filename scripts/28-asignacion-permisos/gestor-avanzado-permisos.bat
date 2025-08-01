@echo off
:: Gestor avanzado de permisos
title 🛡️ Gestor de Permisos
color 0A

echo ========================================
echo    🛡️ GESTOR AVANZADO DE PERMISOS
echo ========================================
echo.

:menu
echo 1. 👁️ Ver permisos
echo 2. ➕ Otorgar permisos
echo 3. ❌ Denegar permisos
echo 4. 👑 Tomar propiedad
echo 5. 🔄 Configurar herencia
echo 6. 💾 Crear backup
echo 7. 📥 Restaurar backup
echo 8. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto ver_permisos
if "%opcion%"=="2" goto otorgar_permisos
if "%opcion%"=="3" goto denegar_permisos
if "%opcion%"=="4" goto tomar_propiedad
if "%opcion%"=="5" goto configurar_herencia
if "%opcion%"=="6" goto crear_backup
if "%opcion%"=="7" goto restaurar_backup
if "%opcion%"=="8" goto salir
goto menu

:ver_permisos
cls
echo ========================================
echo         👁️ VER PERMISOS
echo ========================================
echo.
set /p ruta="Ruta del archivo/directorio: "
if exist "%ruta%" (
    echo 🔍 Mostrando permisos...
    icacls "%ruta%"
) else (
    echo ❌ Ruta no encontrada
)
pause
goto menu

:otorgar_permisos
cls
echo ========================================
echo         ➕ OTORGAR PERMISOS
echo ========================================
echo.
set /p ruta="Ruta del archivo/directorio: "
set /p usuario="Usuario o grupo: "
set /p tipo="Tipo de permiso (F/M/R/W): "
if defined ruta if defined usuario if defined tipo (
    echo 🔄 Otorgando permisos...
    icacls "%ruta%" /grant "%usuario%:%tipo%" /t
    echo ✅ Permisos otorgados
) else (
    echo ❌ Datos incompletos
)
pause
goto menu

:denegar_permisos
cls
echo ========================================
echo         ❌ DENEGAR PERMISOS
echo ========================================
echo.
set /p ruta="Ruta del archivo/directorio: "
set /p usuario="Usuario o grupo: "
if defined ruta if defined usuario (
    echo 🔄 Denegando permisos...
    icacls "%ruta%" /deny "%usuario%:F" /t
    echo ✅ Permisos denegados
) else (
    echo ❌ Datos incompletos
)
pause
goto menu

:tomar_propiedad
cls
echo ========================================
echo         👑 TOMAR PROPIEDAD
echo ========================================
echo.
set /p ruta="Ruta del archivo/directorio: "
if defined ruta (
    echo 🔄 Tomando propiedad...
    takeown /f "%ruta%" /r /d y
    echo ✅ Propiedad tomada
) else (
    echo ❌ Ruta no especificada
)
pause
goto menu

:configurar_herencia
cls
echo ========================================
echo         🔄 CONFIGURAR HERENCIA
echo ========================================
echo.
set /p ruta="Ruta del directorio: "
echo 1. Habilitar herencia
echo 2. Deshabilitar herencia
echo 3. Remover permisos heredados
echo.
set /p herencia="Selecciona opción: "
if defined ruta if defined herencia (
    echo 🔄 Configurando herencia...
    if "%herencia%"=="1" icacls "%ruta%" /inheritance:e
    if "%herencia%"=="2" icacls "%ruta%" /inheritance:d
    if "%herencia%"=="3" icacls "%ruta%" /inheritance:r
    echo ✅ Herencia configurada
) else (
    echo ❌ Datos incompletos
)
pause
goto menu

:crear_backup
cls
echo ========================================
echo         💾 CREAR BACKUP
echo ========================================
echo.
set /p ruta="Ruta a respaldar: "
if defined ruta (
    echo 🔄 Creando backup de permisos...
    icacls "%ruta%" /save permisos_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt /t
    echo ✅ Backup creado
) else (
    echo ❌ Ruta no especificada
)
pause
goto menu

:restaurar_backup
cls
echo ========================================
echo         📥 RESTAURAR BACKUP
echo ========================================
echo.
set /p archivo="Archivo de backup: "
set /p ruta="Ruta de destino: "
if defined archivo if defined ruta (
    echo 🔄 Restaurando permisos...
    icacls "%ruta%" /restore "%archivo%"
    echo ✅ Permisos restaurados
) else (
    echo ❌ Datos incompletos
)
pause
goto menu

:salir
exit 