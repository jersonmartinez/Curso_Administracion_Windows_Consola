@echo off
echo ========================================
echo    GESTIONAR SERVICIO ESPECIFICO
echo ========================================
echo.

echo Gestionando servicio especifico...
echo Gestion iniciada: %date% %time%

REM Configuración del servicio
set "servicio=spooler"

REM Mostrar información del servicio
echo === INFORMACION DEL SERVICIO: %servicio% ===
sc query %servicio%

REM Verificar estado actual
echo.
echo === VERIFICANDO ESTADO ACTUAL ===
sc query %servicio% | findstr STATE

REM Iniciar servicio si está detenido
echo.
echo === INICIANDO SERVICIO ===
sc start %servicio%

REM Pausar brevemente para verificar
timeout /t 2 /nobreak >nul

REM Verificar estado después del inicio
echo.
echo === ESTADO DESPUES DEL INICIO ===
sc query %servicio% | findstr STATE

REM Mostrar configuración del servicio
echo.
echo === CONFIGURACION DEL SERVICIO ===
sc qc %servicio%

echo Gestion del servicio %servicio% completada
pause
