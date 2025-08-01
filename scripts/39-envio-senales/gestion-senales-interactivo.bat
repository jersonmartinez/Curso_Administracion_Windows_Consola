@echo off
title Gestión de Señales de Procesos
color 0F

:menu
cls
echo ========================================
echo    GESTION DE SEÑALES DE PROCESOS
echo ========================================
echo.
echo 1. Ver procesos activos
echo 2. Terminar proceso por PID
echo 3. Terminar proceso por nombre
echo 4. Terminar procesos de usuario
echo 5. Pausar/Reanudar proceso
echo 6. Terminar procesos por memoria
echo 7. Terminar procesos por tiempo
echo 8. Enviar señal remota
echo 9. Salir
echo.
set /p opcion="Selecciona una opción (1-9): "

if "%opcion%"=="1" goto procesos
if "%opcion%"=="2" goto pid
if "%opcion%"=="3" goto nombre
if "%opcion%"=="4" goto usuario
if "%opcion%"=="5" goto pausar
if "%opcion%"=="6" goto memoria
if "%opcion%"=="7" goto tiempo
if "%opcion%"=="8" goto remoto
if "%opcion%"=="9" goto salir
goto menu

:procesos
cls
echo === PROCESOS ACTIVOS ===
tasklist /FO TABLE
pause
goto menu

:pid
cls
echo === TERMINAR POR PID ===
set /p pid="PID del proceso: "
taskkill /PID %pid% /F
if %errorlevel%==0 (
    echo ✓ Proceso %pid% terminado
) else (
    echo ✗ Error al terminar proceso
)
pause
goto menu

:nombre
cls
echo === TERMINAR POR NOMBRE ===
set /p nombre="Nombre del proceso: "
taskkill /IM "%nombre%" /F
if %errorlevel%==0 (
    echo ✓ Procesos "%nombre%" terminados
) else (
    echo ✗ Error al terminar procesos
)
pause
goto menu

:usuario
cls
echo === TERMINAR POR USUARIO ===
set /p usuario="Nombre del usuario: "
taskkill /FI "USERNAME eq %usuario%" /F
if %errorlevel%==0 (
    echo ✓ Procesos del usuario %usuario% terminados
) else (
    echo ✗ Error al terminar procesos
)
pause
goto menu

:pausar
cls
echo === PAUSAR/REANUDAR PROCESO ===
set /p pid="PID del proceso: "
set /p accion="Acción (p=pausar, r=reanudar): "
if /i "%accion%"=="p" (
    wmic process where "ProcessId=%pid%" call suspend
    echo ✓ Proceso pausado
) else if /i "%accion%"=="r" (
    wmic process where "ProcessId=%pid%" call resume
    echo ✓ Proceso reanudado
)
pause
goto menu

:memoria
cls
echo === TERMINAR POR MEMORIA ===
set /p limite="Límite de memoria (MB): "
for /f "tokens=2" %%a in ('tasklist /FI "MEMUSAGE gt %limite%000" /FO CSV') do (
    taskkill /PID %%a /F
    echo ✓ Proceso %%a terminado
)
pause
goto menu

:tiempo
cls
echo === TERMINAR POR TIEMPO ===
set /p tiempo="Tiempo máximo (minutos): "
for /f "tokens=2" %%a in ('tasklist /FI "CPUTIME gt %tiempo%:00" /FO CSV') do (
    taskkill /PID %%a /F
    echo ✓ Proceso %%a terminado
)
pause
goto menu

:remoto
cls
echo === SEÑAL REMOTA ===
set /p equipo="Equipo remoto: "
set /p pid="PID del proceso: "
taskkill /S %equipo% /PID %pid% /F
if %errorlevel%==0 (
    echo ✓ Señal enviada a %equipo%
) else (
    echo ✗ Error al enviar señal
)
pause
goto menu

:salir
echo Gracias por usar el gestor de señales
exit 