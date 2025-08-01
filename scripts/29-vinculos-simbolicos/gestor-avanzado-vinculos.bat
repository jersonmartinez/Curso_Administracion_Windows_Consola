@echo off
:: Gestor avanzado de vínculos
title 🔗 Gestor de Vínculos
color 0A

echo ========================================
echo    🔗 GESTOR AVANZADO DE VÍNCULOS
echo ========================================
echo.

:menu
echo 1. 🔗 Crear vínculo simbólico
echo 2. 📁 Crear vínculo de directorio
echo 3. 🔗 Crear enlace duro
echo 4. 🔗 Crear punto de unión
echo 5. 👁️ Ver vínculos
echo 6. ❌ Eliminar vínculo
echo 7. 🔍 Verificar vínculo
echo 8. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto crear_simbolico
if "%opcion%"=="2" goto crear_directorio
if "%opcion%"=="3" goto crear_duro
if "%opcion%"=="4" goto crear_union
if "%opcion%"=="5" goto ver_vinculos
if "%opcion%"=="6" goto eliminar_vinculo
if "%opcion%"=="7" goto verificar_vinculo
if "%opcion%"=="8" goto salir
goto menu

:crear_simbolico
cls
echo ========================================
echo         🔗 CREAR VÍNCULO SIMBÓLICO
echo ========================================
echo.
set /p origen="Archivo/directorio original: "
set /p destino="Nombre del vínculo: "
if defined origen if defined destino (
    echo 🔄 Creando vínculo simbólico...
    mklink "%destino%" "%origen%"
    echo ✅ Vínculo simbólico creado
) else (
    echo ❌ Datos incompletos
)
pause
goto menu

:crear_directorio
cls
echo ========================================
echo         📁 CREAR VÍNCULO DE DIRECTORIO
echo ========================================
echo.
set /p origen="Directorio original: "
set /p destino="Nombre del vínculo: "
if defined origen if defined destino (
    echo 🔄 Creando vínculo de directorio...
    mklink /d "%destino%" "%origen%"
    echo ✅ Vínculo de directorio creado
) else (
    echo ❌ Datos incompletos
)
pause
goto menu

:crear_duro
cls
echo ========================================
echo         🔗 CREAR ENLACE DURO
echo ========================================
echo.
set /p origen="Archivo original: "
set /p destino="Nombre del enlace: "
if defined origen if defined destino (
    echo 🔄 Creando enlace duro...
    mklink /h "%destino%" "%origen%"
    echo ✅ Enlace duro creado
) else (
    echo ❌ Datos incompletos
)
pause
goto menu

:crear_union
cls
echo ========================================
echo         🔗 CREAR PUNTO DE UNIÓN
echo ========================================
echo.
set /p origen="Directorio original: "
set /p destino="Nombre del punto de unión: "
if defined origen if defined destino (
    echo 🔄 Creando punto de unión...
    mklink /j "%destino%" "%origen%"
    echo ✅ Punto de unión creado
) else (
    echo ❌ Datos incompletos
)
pause
goto menu

:ver_vinculos
cls
echo ========================================
echo         👁️ VER VÍNCULOS
echo ========================================
echo.
echo 🔍 Mostrando vínculos en el directorio actual...
dir /al
echo.
pause
goto menu

:eliminar_vinculo
cls
echo ========================================
echo         ❌ ELIMINAR VÍNCULO
echo ========================================
echo.
set /p vinculo="Nombre del vínculo a eliminar: "
if defined vinculo (
    echo 🔄 Eliminando vínculo...
    del "%vinculo%"
    echo ✅ Vínculo eliminado
) else (
    echo ❌ Nombre no especificado
)
pause
goto menu

:verificar_vinculo
cls
echo ========================================
echo         🔍 VERIFICAR VÍNCULO
echo ========================================
echo.
set /p vinculo="Nombre del vínculo a verificar: "
if defined vinculo (
    echo 🔍 Verificando vínculo...
    dir "%vinculo%" | findstr "SYMLINK"
    echo ✅ Verificación completada
) else (
    echo ❌ Nombre no especificado
)
pause
goto menu

:salir
exit 