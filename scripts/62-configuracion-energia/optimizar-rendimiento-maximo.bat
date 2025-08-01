@echo off
echo ========================================
echo    OPTIMIZAR PARA RENDIMIENTO MAXIMO
echo ========================================
echo.

echo Optimizando para rendimiento maximo...
echo Optimizacion iniciada: %date% %time%

REM Obtener GUID del plan de alto rendimiento
for /f "tokens=2 delims=:" %%i in ('powercfg /list ^| findstr "Alto rendimiento"') do (
    set "guid_rendimiento=%%i"
)

REM Configurar procesador para máximo rendimiento
echo === CONFIGURANDO PROCESADOR ===
powercfg /setacvalueindex %guid_rendimiento% SUB_PROCESSOR PROCTHROTTLEMIN 100
powercfg /setacvalueindex %guid_rendimiento% SUB_PROCESSOR PROCTHROTTLEMAX 100
powercfg /setacvalueindex %guid_rendimiento% SUB_PROCESSOR PERFBOOSTMODE 2

REM Configurar disco para máximo rendimiento
echo === CONFIGURANDO DISCO ===
powercfg /setacvalueindex %guid_rendimiento% SUB_DISK DISKIDLE 0
powercfg /setacvalueindex %guid_rendimiento% SUB_DISK DISKIDLE 0

REM Configurar USB para máximo rendimiento
echo === CONFIGURANDO USB ===
powercfg /setacvalueindex %guid_rendimiento% SUB_USB USBSELECTIVESUSPEND 0

REM Aplicar configuración
powercfg /setactive %guid_rendimiento%

echo Optimizacion para rendimiento maximo completada
pause
