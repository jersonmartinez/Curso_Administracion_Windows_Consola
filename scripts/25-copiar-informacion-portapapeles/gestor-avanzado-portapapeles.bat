@echo off
:: Gestor avanzado de portapapeles
title 📋 Gestor Avanzado de Portapapeles
color 0A

:menu
cls
echo ========================================
echo    📋 GESTOR AVANZADO DE PORTAPAPELES
echo ========================================
echo.
echo 1. 📋 Copiar al portapapeles
echo 2. 📖 Leer del portapapeles
echo 3. 🧹 Limpiar portapapeles
echo 4. 📊 Información del sistema
echo 5. 🌐 Información de red
echo 6. 🔧 Información de servicios
echo 7. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto copiar_portapapeles
if "%opcion%"=="2" goto leer_portapapeles
if "%opcion%"=="3" goto limpiar_portapapeles
if "%opcion%"=="4" goto info_sistema
if "%opcion%"=="5" goto info_red
if "%opcion%"=="6" goto info_servicios
if "%opcion%"=="7" goto salir
goto menu

:copiar_portapapeles
cls
echo ========================================
echo         📋 COPIAR AL PORTAPAPELES
echo ========================================
echo.
set /p contenido="Contenido a copiar: "
echo %contenido% | clip
echo ✅ Contenido copiado al portapapeles
pause
goto menu

:leer_portapapeles
cls
echo ========================================
echo         📖 LEER DEL PORTAPAPELES
echo ========================================
echo.
echo 📋 Contenido del portapapeles:
powershell -Command "Get-Clipboard"
echo.
pause
goto menu

:limpiar_portapapeles
cls
echo ========================================
echo         🧹 LIMPIAR PORTAPAPELES
echo ========================================
echo.
echo "" | clip
echo ✅ Portapapeles limpiado
pause
goto menu

:info_sistema
cls
echo ========================================
echo         📊 INFORMACIÓN DEL SISTEMA
echo ========================================
echo.
echo 🔄 Copiando información del sistema...
systeminfo | clip
echo ✅ Información del sistema copiada al portapapeles
pause
goto menu

:info_red
cls
echo ========================================
echo         🌐 INFORMACIÓN DE RED
echo ========================================
echo.
echo 🔄 Copiando información de red...
ipconfig | clip
echo ✅ Información de red copiada al portapapeles
pause
goto menu

:info_servicios
cls
echo ========================================
echo         🔧 INFORMACIÓN DE SERVICIOS
echo ========================================
echo.
echo 🔄 Copiando información de servicios...
sc query | clip
echo ✅ Información de servicios copiada al portapapeles
pause
goto menu

:salir
exit 