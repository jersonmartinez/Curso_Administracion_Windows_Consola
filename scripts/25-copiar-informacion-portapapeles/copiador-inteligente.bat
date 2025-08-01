@echo off
:: Copiador inteligente al portapapeles
title 📋 Copiador Inteligente
color 0A

:menu
cls
echo ========================================
echo    📋 COPIADOR INTELIGENTE AL PORTAPAPELES
echo ========================================
echo.
echo 1. 📊 Información del sistema
echo 2. 🌐 Información de red
echo 3. 💾 Información de disco
echo 4. 🔧 Información de servicios
echo 5. 📁 Lista de archivos
echo 6. 🚪 Salir
echo.
set /p opcion="Selecciona información a copiar: "

if "%opcion%"=="1" goto info_sistema
if "%opcion%"=="2" goto info_red
if "%opcion%"=="3" goto info_disco
if "%opcion%"=="4" goto info_servicios
if "%opcion%"=="5" goto lista_archivos
if "%opcion%"=="6" goto salir
goto menu

:info_sistema
echo 🔄 Copiando información del sistema...
systeminfo | clip
echo ✅ Información del sistema copiada al portapapeles
pause
goto menu

:info_red
echo 🔄 Copiando información de red...
ipconfig | clip
echo ✅ Información de red copiada al portapapeles
pause
goto menu

:info_disco
echo 🔄 Copiando información de disco...
wmic logicaldisk get size,freespace,caption | clip
echo ✅ Información de disco copiada al portapapeles
pause
goto menu

:info_servicios
echo 🔄 Copiando información de servicios...
sc query | clip
echo ✅ Información de servicios copiada al portapapeles
pause
goto menu

:lista_archivos
set /p directorio="Directorio a listar: "
echo 🔄 Copiando lista de archivos...
dir "%directorio%" /s /b | clip
echo ✅ Lista de archivos copiada al portapapeles
pause
goto menu

:salir
exit 