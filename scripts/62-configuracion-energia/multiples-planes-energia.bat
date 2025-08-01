@echo off
echo ========================================
echo    GESTIONAR MULTIPLES PLANES DE ENERGIA
echo ========================================
echo.

echo Gestionando multiples planes de energia...
echo Gestion iniciada: %date% %time%

REM Crear plan para trabajo
echo === CREANDO PLAN PARA TRABAJO ===
powercfg /duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e "Trabajo - Equilibrado"
for /f "tokens=2 delims=:" %%i in ('powercfg /list ^| findstr "Trabajo"') do (
    powercfg /setacvalueindex %%i SUB_PROCESSOR PROCTHROTTLEMAX 80
    powercfg /setacvalueindex %%i SUB_DISK DISKIDLE 300
)

REM Crear plan para gaming
echo === CREANDO PLAN PARA GAMING ===
powercfg /duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c "Gaming - Maximo Rendimiento"
for /f "tokens=2 delims=:" %%i in ('powercfg /list ^| findstr "Gaming"') do (
    powercfg /setacvalueindex %%i SUB_PROCESSOR PROCTHROTTLEMAX 100
    powercfg /setacvalueindex %%i SUB_DISK DISKIDLE 0
)

REM Crear plan para presentaciones
echo === CREANDO PLAN PARA PRESENTACIONES ===
powercfg /duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e "Presentacion - Sin Suspension"
for /f "tokens=2 delims=:" %%i in ('powercfg /list ^| findstr "Presentacion"') do (
    powercfg /setacvalueindex %%i SUB_SLEEP SLEEPIDLE 0
    powercfg /setacvalueindex %%i SUB_DISPLAY VIDEODIM 0
)

echo Multiples planes de energia creados
pause
