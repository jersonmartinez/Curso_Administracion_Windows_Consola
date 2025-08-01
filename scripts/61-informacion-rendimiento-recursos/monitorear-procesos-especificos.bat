@echo off
echo ========================================
echo    MONITOREAR PROCESOS ESPECIFICOS
echo ========================================
echo.

echo Monitoreando procesos especificos...
echo Monitoreo iniciado: %date% %time%

REM Procesos del sistema
echo === PROCESOS DEL SISTEMA ===
tasklist /FI "IMAGENAME eq svchost.exe" /V

REM Procesos de usuario
echo.
echo === PROCESOS DE USUARIO ===
tasklist /FI "USERNAME eq %USERNAME%" /FO TABLE

REM Información detallada de procesos
echo.
echo === INFORMACION DETALLADA DE PROCESOS ===
wmic process where "name='explorer.exe'" get processid,workingsetsize,virtualsize /format:table

REM Procesos con mayor tiempo de CPU
echo.
echo === PROCESOS CON MAYOR TIEMPO DE CPU ===
tasklist /FO CSV | findstr /v "Image Name" | sort /R /+3

echo Monitoreo de procesos completado
pause
