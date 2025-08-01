@echo off
echo ========================================
echo    GESTIONAR DEPENDENCIAS DE SERVICIOS
echo ========================================
echo.

echo Gestionando dependencias de servicios...
echo Gestion iniciada: %date% %time%

REM Mostrar dependencias actuales
echo === DEPENDENCIAS ACTUALES ===
for %%s in (spooler eventlog) do (
    echo --- Servicio: %%s ---
    echo.
)

REM Configurar dependencias para el servicio de impresión
echo === CONFIGURANDO DEPENDENCIAS ===
echo Configurando dependencias para spooler...
sc config spooler depend= RPCSS

echo Configurando dependencias para eventlog...
sc config eventlog depend= RPCSS

REM Verificar dependencias configuradas
echo.
echo === DEPENDENCIAS CONFIGURADAS ===
for %%s in (spooler eventlog) do (
    echo --- Servicio: %%s ---
    echo.
)

REM Mostrar servicios dependientes
echo === SERVICIOS DEPENDIENTES ===
sc enumdepend spooler

echo Gestion de dependencias completada
pause
