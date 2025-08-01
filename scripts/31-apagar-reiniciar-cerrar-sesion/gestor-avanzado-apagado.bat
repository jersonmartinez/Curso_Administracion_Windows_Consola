@echo off
:: Gestor avanzado de apagado del sistema
title 🔌 Gestor de Apagado del Sistema
color 0A

:menu
cls
echo ========================================
echo    🔌 GESTOR AVANZADO DE APAGADO
echo ========================================
echo.
echo 1. 🔌 Apagar sistema
echo 2. 🔄 Reiniciar sistema
echo 3. 👤 Cerrar sesión
echo 4. ⏰ Programar apagado
echo 5. ❌ Cancelar apagado
echo 6. 🌙 Hibernar sistema
echo 7. 📊 Estado del sistema
echo 8. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto apagar_sistema
if "%opcion%"=="2" goto reiniciar_sistema
if "%opcion%"=="3" goto cerrar_sesion
if "%opcion%"=="4" goto programar_apagado
if "%opcion%"=="5" goto cancelar_apagado
if "%opcion%"=="6" goto hibernar_sistema
if "%opcion%"=="7" goto estado_sistema
if "%opcion%"=="8" goto salir
goto menu

:apagar_sistema
cls
echo ========================================
echo         🔌 APAGAR SISTEMA
echo ========================================
echo.
echo 1. Apagado inmediato
echo 2. Apagado con tiempo de espera
echo 3. Apagado forzado
echo.
set /p tipo="Selecciona tipo de apagado: "
if "%tipo%"=="1" (
    echo 🔌 Apagando sistema inmediatamente...
    shutdown /s /t 0
) else if "%tipo%"=="2" (
    set /p tiempo="Tiempo en segundos: "
    shutdown /s /t %tiempo%
) else if "%tipo%"=="3" (
    echo 🔌 Apagado forzado...
    shutdown /s /f /t 0
)
pause
goto menu

:reiniciar_sistema
cls
echo ========================================
echo         🔄 REINICIAR SISTEMA
echo ========================================
echo.
echo 1. Reinicio inmediato
echo 2. Reinicio con tiempo de espera
echo 3. Reinicio forzado
echo.
set /p tipo="Selecciona tipo de reinicio: "
if "%tipo%"=="1" (
    echo 🔄 Reiniciando sistema...
    shutdown /r /t 0
) else if "%tipo%"=="2" (
    set /p tiempo="Tiempo en segundos: "
    shutdown /r /t %tiempo%
) else if "%tipo%"=="3" (
    echo 🔄 Reinicio forzado...
    shutdown /r /f /t 0
)
pause
goto menu

:cerrar_sesion
cls
echo ========================================
echo         👤 CERRAR SESIÓN
echo ========================================
echo.
echo 🔄 Cerrando sesión actual...
shutdown /l
pause
goto menu

:programar_apagado
cls
echo ========================================
echo         ⏰ PROGRAMAR APAGADO
echo ========================================
echo.
set /p tiempo="Tiempo en segundos: "
set /p mensaje="Mensaje (opcional): "
if defined mensaje (
    shutdown /s /t %tiempo% /c "%mensaje%"
) else (
    shutdown /s /t %tiempo%
)
echo ✅ Apagado programado
pause
goto menu

:cancelar_apagado
cls
echo ========================================
echo         ❌ CANCELAR APAGADO
echo ========================================
echo.
echo 🔄 Cancelando apagado programado...
shutdown /a
echo ✅ Apagado cancelado
pause
goto menu

:hibernar_sistema
cls
echo ========================================
echo         🌙 HIBERNAR SISTEMA
echo ========================================
echo.
echo 🌙 Poniendo sistema en hibernación...
shutdown /h
pause
goto menu

:estado_sistema
cls
echo ========================================
echo         📊 ESTADO DEL SISTEMA
echo ========================================
echo.
echo 🔍 Verificando estado del sistema...
echo === TIEMPO ACTIVO ===
net statistics server | findstr "Statistics since"
echo === USUARIOS CONECTADOS ===
query user
echo === PROCESOS CRÍTICOS ===
tasklist | findstr /i "explorer winlogon services"
pause
goto menu

:salir
exit 