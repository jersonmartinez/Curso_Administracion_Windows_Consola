@echo off
echo ========================================
echo    ANALIZAR SERVICIOS DEL SISTEMA
echo ========================================
echo.

echo Analizando servicios del sistema...
echo Analisis iniciado: %date% %time%

REM Servicios en ejecución
echo === SERVICIOS EN EJECUCION ===
sc query type= service state= running

REM Servicios detenidos
echo.
echo === SERVICIOS DETENIDOS ===
sc query type= service state= stopped

REM Información detallada de servicios críticos
echo.
echo === INFORMACION DE SERVICIOS CRITICOS ===
for %%s in (spooler eventlog themes) do (
    echo --- Servicio: %%s ---
    echo.
)

REM Servicios con inicio automático
echo === SERVICIOS CON INICIO AUTOMATICO ===
wmic service where "startmode='Auto'" get name,displayname,state /format:table

echo Analisis de servicios completado
pause
