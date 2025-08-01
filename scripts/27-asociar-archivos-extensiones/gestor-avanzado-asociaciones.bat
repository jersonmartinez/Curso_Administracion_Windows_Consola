@echo off
:: Gestor avanzado de asociaciones
title 🔗 Gestor de Asociaciones
color 0A

echo ========================================
echo    🔗 GESTOR AVANZADO DE ASOCIACIONES
echo ========================================
echo.

:menu
echo 1. 👁️ Ver asociaciones
echo 2. 🔍 Buscar asociación
echo 3. ✏️ Cambiar asociación
echo 4. ➕ Crear nueva asociación
echo 5. 🔄 Restaurar por defecto
echo 6. 💾 Crear backup
echo 7. 📥 Restaurar backup
echo 8. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto ver_asociaciones
if "%opcion%"=="2" goto buscar_asociacion
if "%opcion%"=="3" goto cambiar_asociacion
if "%opcion%"=="4" goto crear_asociacion
if "%opcion%"=="5" goto restaurar_default
if "%opcion%"=="6" goto crear_backup
if "%opcion%"=="7" goto restaurar_backup
if "%opcion%"=="8" goto salir
goto menu

:ver_asociaciones
cls
echo ========================================
echo         👁️ VER ASOCIACIONES
echo ========================================
echo.
echo 🔄 Mostrando asociaciones...
assoc | more
echo.
pause
goto menu

:buscar_asociacion
cls
echo ========================================
echo         🔍 BUSCAR ASOCIACIÓN
echo ========================================
echo.
set /p extension="Extensión a buscar (ej: .txt): "
if defined extension (
    echo 🔍 Buscando asociación para %extension%...
    assoc %extension%
    echo.
    ftype | findstr /i "%extension%"
) else (
    echo ❌ Extensión no especificada
)
pause
goto menu

:cambiar_asociacion
cls
echo ========================================
echo         ✏️ CAMBIAR ASOCIACIÓN
echo ========================================
echo.
set /p extension="Extensión a cambiar: "
set /p programa="Ruta del programa: "
if defined extension if defined programa (
    echo 🔄 Cambiando asociación...
    assoc %extension%=%extension:~1%file
    ftype %extension:~1%file="%programa%" "%1"
    echo ✅ Asociación cambiada
) else (
    echo ❌ Datos incompletos
)
pause
goto menu

:crear_asociacion
cls
echo ========================================
echo         ➕ CREAR NUEVA ASOCIACIÓN
echo ========================================
echo.
set /p extension="Nueva extensión: "
set /p tipo="Tipo de archivo: "
set /p programa="Ruta del programa: "
if defined extension if defined tipo if defined programa (
    echo 🔄 Creando nueva asociación...
    assoc %extension%=%tipo%
    ftype %tipo%="%programa%" "%1"
    echo ✅ Nueva asociación creada
) else (
    echo ❌ Datos incompletos
)
pause
goto menu

:restaurar_default
cls
echo ========================================
echo         🔄 RESTAURAR POR DEFECTO
echo ========================================
echo.
set /p extension="Extensión a restaurar: "
if defined extension (
    echo 🔄 Restaurando asociación por defecto...
    if "%extension%"==".txt" (
        assoc .txt=txtfile
        ftype txtfile=%SystemRoot%\system32\NOTEPAD.EXE %1
    )
    echo ✅ Asociación restaurada
) else (
    echo ❌ Extensión no especificada
)
pause
goto menu

:crear_backup
cls
echo ========================================
echo         💾 CREAR BACKUP
echo ========================================
echo.
echo 🔄 Creando backup de asociaciones...
assoc > asociaciones_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt
ftype > tipos_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt
echo ✅ Backup creado
pause
goto menu

:restaurar_backup
cls
echo ========================================
echo         📥 RESTAURAR BACKUP
echo ========================================
echo.
set /p archivo="Archivo de backup: "
if exist "%archivo%" (
    echo 🔄 Restaurando desde backup...
    for /f "tokens=1,2 delims==" %%a in (%archivo%) do (
        assoc %%a=%%b
    )
    echo ✅ Backup restaurado
) else (
    echo ❌ Archivo de backup no encontrado
)
pause
goto menu

:salir
exit 