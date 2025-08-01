@echo off
:: Creación masiva de usuarios desde archivo CSV
title 📋 Creación Masiva de Usuarios
color 0A

echo ========================================
echo    📋 CREACIÓN MASIVA DE USUARIOS
echo ========================================
echo.

:menu
echo 1. 📄 Crear usuarios desde CSV
echo 2. 🔄 Crear usuarios de prueba
echo 3. 📊 Verificar usuarios creados
echo 4. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto crear_desde_csv
if "%opcion%"=="2" goto crear_prueba
if "%opcion%"=="3" goto verificar_usuarios
if "%opcion%"=="4" goto salir
goto menu

:crear_desde_csv
cls
echo ========================================
echo         📄 CREAR DESDE CSV
echo ========================================
echo.
set /p archivo="Archivo CSV (usuario,contraseña,nombre,grupo): "
if exist "%archivo%" (
    echo 🔄 Procesando archivo CSV...
    for /f "tokens=1-4 delims=," %%a in (%archivo%) do (
        echo Creando usuario: %%a
        net user %%a %%b /add /fullname:"%%c"
        if not "%%d"=="" net localgroup %%d %%a /add
    )
    echo ✅ Usuarios creados desde CSV
) else (
    echo ❌ Archivo no encontrado
)
pause
goto menu

:crear_prueba
cls
echo ========================================
echo         🔄 CREAR USUARIOS DE PRUEBA
echo ========================================
echo.
set /p cantidad="Cantidad de usuarios: "
set /p prefijo="Prefijo (ej: test): "
echo 🔄 Creando usuarios de prueba...
for /l %%i in (1,1,%cantidad%) do (
    set username=%prefijo%%%i
    set password=Test%%i123
    net user !username! !password! /add /fullname:"Usuario de Prueba %%i"
    echo Usuario creado: !username!
)
echo ✅ Usuarios de prueba creados
pause
goto menu

:verificar_usuarios
cls
echo ========================================
echo         📊 VERIFICAR USUARIOS
echo ========================================
echo.
echo 🔍 Verificando usuarios activos...
net user | findstr /v "Comando completado"
echo.
echo === USUARIOS RECIENTES ===
wmic useraccount get name,disabled,lockout 2>nul
pause
goto menu

:salir
exit 