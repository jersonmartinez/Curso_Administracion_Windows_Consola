@echo off
echo ========================================
echo    CREAR PLAN DE ENERGIA PERSONALIZADO
echo ========================================
echo.

echo Creando plan de energia personalizado...
echo Creacion iniciada: %date% %time%

REM Obtener GUID del plan equilibrado
for /f "tokens=2 delims=:" %%i in ('powercfg /getactivescheme') do (
    set "guid_activo=%%i"
)

REM Crear copia del plan activo
echo === CREANDO COPIA DEL PLAN ACTIVO ===
powercfg /duplicatescheme %guid_activo% "Plan Personalizado - Optimizado"

REM Obtener GUID del nuevo plan
for /f "tokens=2 delims=:" %%i in ('powercfg /list ^| findstr "Plan Personalizado"') do (
    set "guid_nuevo=%%i"
)

REM Configurar parámetros del nuevo plan
echo === CONFIGURANDO PARAMETROS ===
powercfg /setacvalueindex %guid_nuevo% SUB_PROCESSOR PROCTHROTTLEMIN 5
powercfg /setacvalueindex %guid_nuevo% SUB_PROCESSOR PROCTHROTTLEMAX 90
powercfg /setacvalueindex %guid_nuevo% SUB_DISK DISKIDLE 300

REM Aplicar configuración
powercfg /setactive %guid_nuevo%

echo Plan de energia personalizado creado y activado
pause
