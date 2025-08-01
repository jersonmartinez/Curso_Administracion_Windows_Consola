@echo off
echo ========================================
echo    LISTAR PLANES DE ENERGIA DISPONIBLES
echo ========================================
echo.

echo Listando planes de energia disponibles...
echo Listado iniciado: %date% %time%

REM Mostrar todos los planes de energía
echo === PLANES DE ENERGIA DISPONIBLES ===
powercfg /list

REM Mostrar plan activo actualmente
echo.
echo === PLAN ACTIVO ACTUALMENTE ===
powercfg /getactivescheme

REM Mostrar información detallada del plan activo
echo.
echo === INFORMACION DETALLADA DEL PLAN ACTIVO ===
for /f "tokens=2 delims=:" %%i in ('powercfg /getactivescheme') do (
    powercfg /query %%i
)

echo Listado de planes de energia completado
pause
