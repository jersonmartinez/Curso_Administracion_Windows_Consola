@echo off
:: Análisis de datos ordenados
title 📈 Análisis de Datos
color 0B

echo ========================================
echo    📈 ANÁLISIS DE DATOS ORDENADOS
echo ========================================
echo.

:menu_analisis
echo 1. 📊 Estadísticas de archivos
echo 2. 📅 Análisis temporal
echo 3. 📏 Análisis de tamaños
echo 4. 🔍 Búsqueda ordenada
echo 5. 📋 Reporte ordenado
echo 6. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto estadisticas
if "%opcion%"=="2" goto temporal
if "%opcion%"=="3" goto tamanos
if "%opcion%"=="4" goto busqueda
if "%opcion%"=="5" goto reporte
if "%opcion%"=="6" goto salir
goto menu_analisis

:estadisticas
cls
echo ========================================
echo         📊 ESTADÍSTICAS DE ARCHIVOS
echo ========================================
echo.
set /p directorio="Directorio a analizar: "
if exist "%directorio%" (
    echo 🔄 Generando estadísticas...
    dir "%directorio%" /O:S | findstr /v "DIR" | findstr /c:" archivos"
    echo ✅ Estadísticas generadas
) else (
    echo ❌ Directorio no encontrado
)
pause
goto menu_analisis

:temporal
cls
echo ========================================
echo         📅 ANÁLISIS TEMPORAL
echo ========================================
echo.
set /p directorio="Directorio a analizar: "
if exist "%directorio%" (
    echo 🔄 Analizando fechas...
    dir "%directorio%" /O:D /T:W | findstr /v "DIR" | head -10
    echo ✅ Análisis temporal completado
) else (
    echo ❌ Directorio no encontrado
)
pause
goto menu_analisis

:tamanos
cls
echo ========================================
echo         📏 ANÁLISIS DE TAMAÑOS
echo ========================================
echo.
set /p directorio="Directorio a analizar: "
if exist "%directorio%" (
    echo 🔄 Analizando tamaños...
    dir "%directorio%" /O:S /T:W | findstr /v "DIR" | head -10
    echo ✅ Análisis de tamaños completado
) else (
    echo ❌ Directorio no encontrado
)
pause
goto menu_analisis

:busqueda
cls
echo ========================================
echo         🔍 BÚSQUEDA ORDENADA
echo ========================================
echo.
set /p directorio="Directorio a buscar: "
set /p patron="Patrón de búsqueda: "
if exist "%directorio%" (
    echo 🔄 Buscando y ordenando...
    dir "%directorio%" /s /b | findstr "%patron%" | sort
    echo ✅ Búsqueda ordenada completada
) else (
    echo ❌ Directorio no encontrado
)
pause
goto menu_analisis

:reporte
cls
echo ========================================
echo         📋 REPORTE ORDENADO
echo ========================================
echo.
set /p directorio="Directorio para reporte: "
if exist "%directorio%" (
    echo 🔄 Generando reporte ordenado...
    echo === REPORTE DE ARCHIVOS === > reporte.txt
    dir "%directorio%" /O:D /T:W | findstr /v "DIR" >> reporte.txt
    echo ✅ Reporte generado en reporte.txt
) else (
    echo ❌ Directorio no encontrado
)
pause
goto menu_analisis

:salir
exit 