@echo off
echo ========================================
echo    CONFIGURAR TIPO DE INICIO DE SERVICIOS
echo ========================================
echo.

echo Configurando tipo de inicio de servicios...
echo Configuracion iniciada: %date% %time%

REM Servicios a configurar
set "servicios=spooler eventlog themes"

REM Mostrar configuración actual
echo === CONFIGURACION ACTUAL ===
for %%s in (%servicios%) do (
    echo --- Servicio: %%s ---
    echo.
)

REM Configurar servicios para inicio automático
echo === CONFIGURANDO INICIO AUTOMATICO ===
for %%s in (%servicios%) do (
    echo Configurando %%s para inicio automatico...
    sc config %%s start= auto
)

REM Configurar servicios para inicio manual
echo.
echo === CONFIGURANDO INICIO MANUAL ===
for %%s in (themes) do (
    echo Configurando %%s para inicio manual...
    sc config %%s start= demand
)

REM Verificar configuración final
echo.
echo === CONFIGURACION FINAL ===
for %%s in (%servicios%) do (
    echo --- Servicio: %%s ---
    echo.
)

echo Configuracion de servicios completada
pause
