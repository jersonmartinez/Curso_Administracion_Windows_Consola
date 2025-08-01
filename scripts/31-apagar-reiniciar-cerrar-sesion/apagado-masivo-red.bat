@echo off
:: Apagado masivo de computadoras en red
title 🌐 Apagado Masivo de Red
color 0A

echo ========================================
echo    🌐 APAGADO MASIVO DE RED
echo ========================================
echo.

:menu
echo 1. 📋 Listar computadoras
echo 2. 🔌 Apagar computadoras
echo 3. 🔄 Reiniciar computadoras
echo 4. 👤 Cerrar sesiones remotas
echo 5. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto listar_pcs
if "%opcion%"=="2" goto apagar_pcs
if "%opcion%"=="3" goto reiniciar_pcs
if "%opcion%"=="4" goto cerrar_sesiones
if "%opcion%"=="5" goto salir
goto menu

:listar_pcs
cls
echo ========================================
echo         📋 LISTAR COMPUTADORAS
echo ========================================
echo.
set /p archivo="Archivo con lista de PCs: "
if exist "%archivo%" (
    echo 📋 Computadoras en la lista:
    type "%archivo%"
) else (
    echo ❌ Archivo no encontrado
)
pause
goto menu

:apagar_pcs
cls
echo ========================================
echo         🔌 APAGAR COMPUTADORAS
echo ========================================
echo.
set /p archivo="Archivo con lista de PCs: "
set /p tiempo="Tiempo de espera (segundos): "
if exist "%archivo%" (
    echo 🔌 Apagando computadoras...
    for /f %%i in (%archivo%) do (
        echo Apagando: %%i
        shutdown /s /t %tiempo% /m \\%%i
    )
    echo ✅ Proceso de apagado iniciado
) else (
    echo ❌ Archivo no encontrado
)
pause
goto menu

:reiniciar_pcs
cls
echo ========================================
echo         🔄 REINICIAR COMPUTADORAS
echo ========================================
echo.
set /p archivo="Archivo con lista de PCs: "
set /p tiempo="Tiempo de espera (segundos): "
if exist "%archivo%" (
    echo 🔄 Reiniciando computadoras...
    for /f %%i in (%archivo%) do (
        echo Reiniciando: %%i
        shutdown /r /t %tiempo% /m \\%%i
    )
    echo ✅ Proceso de reinicio iniciado
) else (
    echo ❌ Archivo no encontrado
)
pause
goto menu

:cerrar_sesiones
cls
echo ========================================
echo         👤 CERRAR SESIONES REMOTAS
echo ========================================
echo.
set /p archivo="Archivo con lista de PCs: "
if exist "%archivo%" (
    echo 👤 Cerrando sesiones remotas...
    for /f %%i in (%archivo%) do (
        echo Cerrando sesión en: %%i
        shutdown /l /m \\%%i
    )
    echo ✅ Sesiones cerradas
) else (
    echo ❌ Archivo no encontrado
)
pause
goto menu

:salir
exit 