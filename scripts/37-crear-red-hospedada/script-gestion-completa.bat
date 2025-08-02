@echo off
title Gestión de Redes Hospedadas
color 0A

:menu
cls
echo ========================================
echo    GESTION DE REDES HOSPEDADAS
echo ========================================
echo.
echo 1. Crear nueva red hospedada
echo 2. Iniciar red existente
echo 3. Detener red activa
echo 4. Ver estado de la red
echo 5. Verificar adaptadores
echo 6. Configurar compartir conexión
echo 7. Monitorear clientes
echo 8. Salir
echo.
set /p opcion="Selecciona una opción (1-8): "

if "%opcion%"=="1" goto crear
if "%opcion%"=="2" goto iniciar
if "%opcion%"=="3" goto detener
if "%opcion%"=="4" goto estado
if "%opcion%"=="5" goto adaptadores
if "%opcion%"=="6" goto compartir
if "%opcion%"=="7" goto monitorear
if "%opcion%"=="8" goto salir
goto menu

:crear
cls
echo === CREAR NUEVA RED HOSPEDADA ===
set /p ssid="Nombre de la red (SSID): "
set /p key="Contraseña (mínimo 8 caracteres): "
echo.
echo Configurando red "%ssid%"...
netsh wlan set hostednetwork mode=allow ssid="%ssid%" key="%key%"
if %errorlevel%==0 (
    echo Red configurada exitosamente
    set /p iniciar="¿Deseas iniciar la red ahora? (s/n): "
    if /i "%iniciar%"=="s" goto iniciar
) else (
    echo Error al configurar la red
)
pause
goto menu

:iniciar
cls
echo === INICIAR RED HOSPEDADA ===
netsh wlan start hostednetwork
if %errorlevel%==0 (
    echo Red hospedada iniciada correctamente
) else (
    echo Error al iniciar la red
)
pause
goto menu

:detener
cls
echo === DETENER RED HOSPEDADA ===
netsh wlan stop hostednetwork
if %errorlevel%==0 (
    echo Red hospedada detenida correctamente
) else (
    echo Error al detener la red
)
pause
goto menu

:estado
cls
echo === ESTADO DE LA RED HOSPEDADA ===
netsh wlan show hostednetwork
pause
goto menu

:adaptadores
cls
echo === VERIFICAR ADAPTADORES ===
netsh wlan show drivers | findstr "Hosted network supported"
pause
goto menu

:compartir
cls
echo === CONFIGURAR COMPARTIR CONEXIÓN ===
echo Habilitando compartir de conexión...
netsh interface set interface "Ethernet" sharing=enabled
echo Compartir configurado
pause
goto menu

:monitorear
cls
echo === MONITOREAR CLIENTES ===
echo Presiona Ctrl+C para salir del monitoreo
timeout /t 3 /nobreak >nul
:loop
cls
netsh wlan show hostednetwork
timeout /t 5 /nobreak >nul
goto loop

:salir
echo Gracias por usar el gestor de redes hospedadas
exit 