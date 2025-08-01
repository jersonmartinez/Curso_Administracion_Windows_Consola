@echo off
echo ========================================
echo    LISTAR SERVICIOS DEL SISTEMA
echo ========================================
echo.

echo Listando servicios del sistema...
echo Listado iniciado: %date% %time%

REM Mostrar todos los servicios
echo === TODOS LOS SERVICIOS ===
sc query type= service state= all

REM Mostrar solo servicios en ejecución
echo.
echo === SERVICIOS EN EJECUCION ===
sc query type= service state= running

REM Mostrar servicios detenidos
echo.
echo === SERVICIOS DETENIDOS ===
sc query type= service state= stopped

REM Mostrar servicios con inicio automático
echo.
echo === SERVICIOS CON INICIO AUTOMATICO ===
sc query type= service start= auto

echo Listado de servicios completado
pause
