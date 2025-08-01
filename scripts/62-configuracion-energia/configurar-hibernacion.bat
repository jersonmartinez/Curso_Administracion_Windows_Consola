@echo off
echo ========================================
echo    CONFIGURAR HIBERNACION
echo ========================================
echo.

echo Configurando hibernacion...
echo Configuracion iniciada: %date% %time%

REM Verificar estado actual de hibernación
echo === ESTADO ACTUAL DE HIBERNACION ===
powercfg /hibernate /query

REM Habilitar hibernación
echo === HABILITANDO HIBERNACION ===
powercfg /hibernate /on

REM Configurar tiempo de hibernación
echo === CONFIGURANDO TIEMPO DE HIBERNACION ===
for /f "tokens=2 delims=:" %%i in ('powercfg /getactivescheme') do (
    powercfg /setacvalueindex %%i SUB_SLEEP HIBERNATEIDLE 1800
    powercfg /setdcvalueindex %%i SUB_SLEEP HIBERNATEIDLE 900
)

REM Aplicar configuración
for /f "tokens=2 delims=:" %%i in ('powercfg /getactivescheme') do (
    powercfg /setactive %%i
)

echo Hibernacion configurada exitosamente
pause
