@echo off
:: Gestor avanzado de credenciales guardadas
title 🔑 Gestor de Credenciales
color 0A

:menu
cls
echo ========================================
echo    🔑 GESTOR AVANZADO DE CREDENCIALES
echo ========================================
echo.
echo 1. 👁️ Ver credenciales
echo 2. ➕ Agregar credencial
echo 3. ❌ Eliminar credencial
echo 4. 🔍 Buscar credencial
echo 5. 📊 Auditoría de credenciales
echo 6. 💾 Backup de credenciales
echo 7. 🧹 Limpiar credenciales
echo 8. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto ver_credenciales
if "%opcion%"=="2" goto agregar_credencial
if "%opcion%"=="3" goto eliminar_credencial
if "%opcion%"=="4" goto buscar_credencial
if "%opcion%"=="5" goto auditoria_credenciales
if "%opcion%"=="6" goto backup_credenciales
if "%opcion%"=="7" goto limpiar_credenciales
if "%opcion%"=="8" goto salir
goto menu

:ver_credenciales
cls
echo ========================================
echo         👁️ VER CREDENCIALES
echo ========================================
echo.
echo 🔍 Listando credenciales almacenadas...
cmdkey /list
echo.
pause
goto menu

:agregar_credencial
cls
echo ========================================
echo         ➕ AGREGAR CREDENCIAL
echo ========================================
echo.
set /p target="Nombre del objetivo (ej: servidor.local): "
set /p username="Nombre de usuario: "
set /p password="Contraseña: "
if defined target if defined username if defined password (
    echo 🔄 Agregando credencial...
    cmdkey /add:%target% /user:%username% /pass:%password%
    echo ✅ Credencial agregada
) else (
    echo ❌ Datos incompletos
)
pause
goto menu

:eliminar_credencial
cls
echo ========================================
echo         ❌ ELIMINAR CREDENCIAL
echo ========================================
echo.
echo 🔍 Credenciales disponibles:
cmdkey /list
echo.
set /p target="Nombre del objetivo a eliminar: "
if defined target (
    echo ⚠️ ¿Eliminar credencial %target%?
    set /p confirm="(S/N): "
    if /i "%confirm%"=="S" (
        cmdkey /delete:%target%
        echo ✅ Credencial eliminada
    ) else (
        echo ❌ Operación cancelada
    )
) else (
    echo ❌ Objetivo no especificado
)
pause
goto menu

:buscar_credencial
cls
echo ========================================
echo         🔍 BUSCAR CREDENCIAL
echo ========================================
echo.
set /p patron="Patrón de búsqueda: "
if defined patron (
    echo 🔍 Buscando credenciales que coincidan con: %patron%
    cmdkey /list | findstr /i "%patron%"
) else (
    echo ❌ Patrón no especificado
)
pause
goto menu

:auditoria_credenciales
cls
echo ========================================
echo         📊 AUDITORÍA DE CREDENCIALES
echo ========================================
echo.
echo 🔍 Realizando auditoría de credenciales...
echo.
echo === CREDENCIALES DE RED ===
cmdkey /list | findstr /i "TERMSRV\|DOMAIN"
echo.
echo === CREDENCIALES DE SERVICIOS ===
cmdkey /list | findstr /i "SERVICE\|SYSTEM"
echo.
echo === CREDENCIALES GENÉRICAS ===
cmdkey /list | findstr /i "GENERIC"
echo.
echo === TOTAL DE CREDENCIALES ===
cmdkey /list | find /c "Objetivo"
pause
goto menu

:backup_credenciales
cls
echo ========================================
echo         💾 BACKUP DE CREDENCIALES
echo ========================================
echo.
echo 🔄 Creando backup de credenciales...
set archivo=backup_credenciales_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.txt
echo === BACKUP DE CREDENCIALES === > %archivo%
echo Fecha: %date% %time% >> %archivo%
echo. >> %archivo%
cmdkey /list >> %archivo%
echo ✅ Backup creado en %archivo%
pause
goto menu

:limpiar_credenciales
cls
echo ========================================
echo         🧹 LIMPIAR CREDENCIALES
echo ========================================
echo.
echo ⚠️ ADVERTENCIA: Esta operación eliminará credenciales obsoletas
echo.
echo 1. Limpiar credenciales de red obsoletas
echo 2. Limpiar credenciales de servicios
echo 3. Limpiar todas las credenciales
echo.
set /p tipo="Selecciona tipo de limpieza: "

if "%tipo%"=="1" (
    echo 🔄 Limpiando credenciales de red obsoletas...
    for /f "tokens=1,2 delims= " %%a in ('cmdkey /list ^| findstr "TERMSRV"') do (
        echo Eliminando: %%b
        cmdkey /delete:%%b
    )
) else if "%tipo%"=="2" (
    echo 🔄 Limpiando credenciales de servicios...
    for /f "tokens=1,2 delims= " %%a in ('cmdkey /list ^| findstr "SERVICE"') do (
        echo Eliminando: %%b
        cmdkey /delete:%%b
    )
) else if "%tipo%"=="3" (
    echo ⚠️ ¿Eliminar TODAS las credenciales?
    set /p confirm="(S/N): "
    if /i "%confirm%"=="S" (
        echo 🔄 Limpiando todas las credenciales...
        for /f "tokens=1,2 delims= " %%a in ('cmdkey /list') do (
            cmdkey /delete:%%b
        )
    )
)
echo ✅ Limpieza completada
pause
goto menu

:salir
exit 