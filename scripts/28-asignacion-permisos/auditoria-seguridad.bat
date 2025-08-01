@echo off
:: Auditoría de seguridad
title 🔍 Auditoría de Seguridad
color 0B

echo ========================================
echo    🔍 AUDITORÍA DE SEGURIDAD
echo ========================================
echo.

:menu_auditoria
echo 1. 📊 Reporte de permisos
echo 2. 🔍 Buscar archivos sin permisos
echo 3. ⚠️ Detectar permisos excesivos
echo 4. 👑 Verificar propietarios
echo 5. 📋 Listar usuarios con acceso
echo 6. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto reporte_permisos
if "%opcion%"=="2" goto archivos_sin_permisos
if "%opcion%"=="3" goto permisos_excesivos
if "%opcion%"=="4" goto verificar_propietarios
if "%opcion%"=="5" goto listar_usuarios
if "%opcion%"=="6" goto salir
goto menu_auditoria

:reporte_permisos
cls
echo ========================================
echo         📊 REPORTE DE PERMISOS
echo ========================================
echo.
set /p ruta="Ruta a auditar: "
if defined ruta (
    echo 🔄 Generando reporte...
    echo === REPORTE DE PERMISOS === > reporte_permisos.txt
    echo Fecha: %date% %time% >> reporte_permisos.txt
    echo Ruta: %ruta% >> reporte_permisos.txt
    echo. >> reporte_permisos.txt
    icacls "%ruta%" >> reporte_permisos.txt
    echo ✅ Reporte generado en reporte_permisos.txt
) else (
    echo ❌ Ruta no especificada
)
pause
goto menu_auditoria

:archivos_sin_permisos
cls
echo ========================================
echo         🔍 ARCHIVOS SIN PERMISOS
echo ========================================
echo.
set /p ruta="Ruta a verificar: "
if defined ruta (
    echo 🔍 Buscando archivos sin permisos...
    for /r "%ruta%" %%f in (*) do (
        icacls "%%f" | findstr /i "Everyone" >nul || echo ⚠️ %%f - Sin permisos para Everyone
    )
    echo ✅ Verificación completada
) else (
    echo ❌ Ruta no especificada
)
pause
goto menu_auditoria

:permisos_excesivos
cls
echo ========================================
echo         ⚠️ PERMISOS EXCESIVOS
echo ========================================
echo.
set /p ruta="Ruta a verificar: "
if defined ruta (
    echo 🔍 Detectando permisos excesivos...
    for /r "%ruta%" %%f in (*) do (
        icacls "%%f" | findstr /i "Everyone.*F" >nul && echo ⚠️ %%f - Permisos completos para Everyone
    )
    echo ✅ Detección completada
) else (
    echo ❌ Ruta no especificada
)
pause
goto menu_auditoria

:verificar_propietarios
cls
echo ========================================
echo         👑 VERIFICAR PROPIETARIOS
echo ========================================
echo.
set /p ruta="Ruta a verificar: "
if defined ruta (
    echo 🔍 Verificando propietarios...
    for /r "%ruta%" %%f in (*) do (
        echo Propietario de %%f:
        takeown /f "%%f" /a /r 2>nul
    )
    echo ✅ Verificación completada
) else (
    echo ❌ Ruta no especificada
)
pause
goto menu_auditoria

:listar_usuarios
cls
echo ========================================
echo         📋 LISTAR USUARIOS CON ACCESO
echo ========================================
echo.
set /p ruta="Ruta a verificar: "
if defined ruta (
    echo 🔍 Listando usuarios con acceso...
    icacls "%ruta%" | findstr /v "processed" | findstr /v "Successfully"
    echo ✅ Listado completado
) else (
    echo ❌ Ruta no especificada
)
pause
goto menu_auditoria

:salir
exit 