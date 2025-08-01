@echo off
echo ========================================
echo    OPTIMIZAR PARA AHORRO DE BATERIA
echo ========================================
echo.

echo Optimizando para ahorro de bateria...
echo Optimizacion iniciada: %date% %time%

REM Crear plan de ahorro de batería
echo === CREANDO PLAN DE AHORRO ===
powercfg /duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e "Ahorro de Bateria - Personalizado"

REM Obtener GUID del nuevo plan
for /f "tokens=2 delims=:" %%i in ('powercfg /list ^| findstr "Ahorro de Bateria"') do (
    set "guid_ahorro=%%i"
)

REM Configurar procesador para ahorro
echo === CONFIGURANDO PROCESADOR PARA AHORRO ===
powercfg /setdcvalueindex %guid_ahorro% SUB_PROCESSOR PROCTHROTTLEMIN 5
powercfg /setdcvalueindex %guid_ahorro% SUB_PROCESSOR PROCTHROTTLEMAX 50
powercfg /setdcvalueindex %guid_ahorro% SUB_PROCESSOR PERFBOOSTMODE 0

REM Configurar disco para ahorro
echo === CONFIGURANDO DISCO PARA AHORRO ===
powercfg /setdcvalueindex %guid_ahorro% SUB_DISK DISKIDLE 60
powercfg /setdcvalueindex %guid_ahorro% SUB_DISK DISKIDLE 60

REM Configurar USB para ahorro
echo === CONFIGURANDO USB PARA AHORRO ===
powercfg /setdcvalueindex %guid_ahorro% SUB_USB USBSELECTIVESUSPEND 1

REM Configurar tiempo de suspensión
echo === CONFIGURANDO TIEMPO DE SUSPENSION ===
powercfg /setdcvalueindex %guid_ahorro% SUB_SLEEP SLEEPIDLE 300

REM Aplicar configuración
powercfg /setactive %guid_ahorro%

echo Optimizacion para ahorro de bateria completada
pause
