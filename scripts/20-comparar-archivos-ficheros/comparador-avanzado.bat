@echo off
:: Comparador avanzado de archivos
title 🔍 Comparador Avanzado de Archivos
color 0C

:menu
cls
echo ========================================
echo      🔍 COMPARADOR AVANZADO
echo ========================================
echo.
echo 1. 🔍 Comparar archivos
echo 2. 🐐 Verificar hash
echo 3. ⚖️ Comparación byte por byte
echo 4. 📋 Comparar directorios
echo 5. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto comparar_archivos
if "%opcion%"=="2" goto verificar_hash
if "%opcion%"=="3" goto comparar_bytes
if "%opcion%"=="4" goto comparar_directorios
if "%opcion%"=="5" goto salir
goto menu

:comparar_archivos
cls
echo ========================================
echo         🔍 COMPARAR ARCHIVOS
echo ========================================
echo.
set /p archivo1="Primer archivo: "
set /p archivo2="Segundo archivo: "
echo.
echo 🔍 Comparando archivos...
fc "%archivo1%" "%archivo2%"
echo.
pause
goto menu

:verificar_hash
cls
echo ========================================
echo         🐐 VERIFICAR HASH
echo ========================================
echo.
set /p archivo="Archivo a verificar: "
echo.
echo 🔍 Calculando hash MD5...
certutil -hashfile "%archivo%" MD5
echo.
pause
goto menu

:comparar_bytes
cls
echo ========================================
echo      ⚖️ COMPARACIÓN BYTE POR BYTE
echo ========================================
echo.
set /p archivo1="Primer archivo: "
set /p archivo2="Segundo archivo: "
echo.
echo 🔍 Comparando byte por byte...
comp "%archivo1%" "%archivo2%" /d
echo.
pause
goto menu

:comparar_directorios
cls
echo ========================================
echo      📋 COMPARAR DIRECTORIOS
echo ========================================
echo.
set /p dir1="Primer directorio: "
set /p dir2="Segundo directorio: "
echo.
echo 🔍 Comparando directorios...
fc /s "%dir1%\*.*" "%dir2%\*.*"
echo.
pause
goto menu

:salir
exit 