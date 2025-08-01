@echo off
:: Ordenamiento inteligente de archivos
title 📊 Ordenamiento Inteligente
color 0A

echo ========================================
echo    📊 ORDENAMIENTO INTELIGENTE
echo ========================================
echo.

:menu
echo 1. 📅 Ordenar por fecha
echo 2. 📏 Ordenar por tamaño
echo 3. 📝 Ordenar por nombre
echo 4. 🔤 Ordenar por extensión
echo 5. 📊 Ordenar por múltiples criterios
echo 6. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto por_fecha
if "%opcion%"=="2" goto por_tamaño
if "%opcion%"=="3" goto por_nombre
if "%opcion%"=="4" goto por_extension
if "%opcion%"=="5" goto multiples_criterios
if "%opcion%"=="6" goto salir
goto menu

:por_fecha
cls
echo ========================================
echo         📅 ORDENAR POR FECHA
echo ========================================
echo.
set /p directorio="Directorio a ordenar: "
if exist "%directorio%" (
    echo 🔄 Ordenando por fecha...
    dir "%directorio%" /O:D /T:W | findstr /v "DIR"
    echo ✅ Ordenamiento por fecha completado
) else (
    echo ❌ Directorio no encontrado
)
pause
goto menu

:por_tamaño
cls
echo ========================================
echo         📏 ORDENAR POR TAMAÑO
echo ========================================
echo.
set /p directorio="Directorio a ordenar: "
if exist "%directorio%" (
    echo 🔄 Ordenando por tamaño...
    dir "%directorio%" /O:S /T:W | findstr /v "DIR"
    echo ✅ Ordenamiento por tamaño completado
) else (
    echo ❌ Directorio no encontrado
)
pause
goto menu

:por_nombre
cls
echo ========================================
echo         📝 ORDENAR POR NOMBRE
echo ========================================
echo.
set /p directorio="Directorio a ordenar: "
if exist "%directorio%" (
    echo 🔄 Ordenando por nombre...
    dir "%directorio%" /O:N | findstr /v "DIR"
    echo ✅ Ordenamiento por nombre completado
) else (
    echo ❌ Directorio no encontrado
)
pause
goto menu

:por_extension
cls
echo ========================================
echo         🔤 ORDENAR POR EXTENSIÓN
echo ========================================
echo.
set /p directorio="Directorio a ordenar: "
if exist "%directorio%" (
    echo 🔄 Ordenando por extensión...
    dir "%directorio%" /O:E | findstr /v "DIR"
    echo ✅ Ordenamiento por extensión completado
) else (
    echo ❌ Directorio no encontrado
)
pause
goto menu

:multiples_criterios
cls
echo ========================================
echo         📊 MÚLTIPLES CRITERIOS
echo ========================================
echo.
set /p archivo="Archivo a ordenar: "
if exist "%archivo%" (
    echo 🔄 Ordenando por múltiples criterios...
    sort "%archivo%" /+10
    echo ✅ Ordenamiento por múltiples criterios completado
) else (
    echo ❌ Archivo no encontrado
)
pause
goto menu

:salir
exit 