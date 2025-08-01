@echo off
echo ========================================
echo    VERIFICAR USO BASICO DE CPU
echo ========================================
echo.

echo Verificando procesos con alto uso de CPU...
echo Verificacion iniciada: %date% %time%

REM Mostrar procesos con alto uso de CPU
echo === PROCESOS CON ALTO USO DE CPU ===
tasklist /FI "CPU gt 5" /FO TABLE

REM Mostrar los 5 procesos que más CPU consumen
echo.
echo === TOP 5 PROCESOS POR CPU ===
tasklist /FO CSV | findstr /v "Image Name" | sort /R /+2

REM Verificar información del procesador
echo.
echo === INFORMACION DEL PROCESADOR ===
wmic cpu get name,numberofcores,maxclockspeed /format:table

echo Verificacion de CPU completada
pause
