@echo off
:: Buscador avanzado de cadenas
title 🔍 Buscador Avanzado de Cadenas
color 0D

:menu
cls
echo ========================================
echo      🔍 BUSCADOR AVANZADO DE CADENAS
echo ========================================
echo.
echo 1. 🔍 Búsqueda simple
echo 2. 🎯 Búsqueda con regex
echo 3. 📊 Búsqueda con líneas
echo 4. 🔐 Búsqueda sensible
echo 5. 📈 Búsqueda de errores
echo 6. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto busqueda_simple
if "%opcion%"=="2" goto busqueda_regex
if "%opcion%"=="3" goto busqueda_lineas
if "%opcion%"=="4" goto busqueda_sensible
if "%opcion%"=="5" goto busqueda_errores
if "%opcion%"=="6" goto salir
goto menu

:busqueda_simple
cls
echo ========================================
echo         🔍 BÚSQUEDA SIMPLE
echo ========================================
echo.
set /p texto="Texto a buscar: "
echo.
echo 🔍 Buscando "%texto%"...
findstr /s /i "%texto%" *.txt *.log *.ini
echo.
pause
goto menu

:busqueda_regex
cls
echo ========================================
echo         🎯 BÚSQUEDA CON REGEX
echo ========================================
echo.
set /p patron="Patrón regex: "
echo.
echo 🔍 Buscando con regex "%patron%"...
findstr /s /r "%patron%" *.txt *.log
echo.
pause
goto menu

:busqueda_lineas
cls
echo ========================================
echo         📊 BÚSQUEDA CON LÍNEAS
echo ========================================
echo.
set /p texto="Texto a buscar: "
echo.
echo 🔍 Buscando "%texto%" con números de línea...
findstr /s /i /n "%texto%" *.txt *.log
echo.
pause
goto menu

:busqueda_sensible
cls
echo ========================================
echo         🔐 BÚSQUEDA SENSIBLE
echo ========================================
echo.
echo 🔍 Buscando información sensible...
findstr /s /i /r "password\|secret\|token\|key\|api" *.txt *.ini *.cfg
echo.
pause
goto menu

:busqueda_errores
cls
echo ========================================
echo         📈 BÚSQUEDA DE ERRORES
echo ========================================
echo.
echo 🔍 Buscando errores en logs...
findstr /s /i /n "error\|fail\|exception\|critical\|warning" *.log
echo.
pause
goto menu

:salir
exit 