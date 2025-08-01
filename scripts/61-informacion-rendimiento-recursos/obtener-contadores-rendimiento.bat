@echo off
echo ========================================
echo    OBTENER CONTADORES DE RENDIMIENTO
echo ========================================
echo.

echo Obteniendo contadores de rendimiento...
echo Obtencion iniciada: %date% %time%

REM Contador de CPU
echo === CONTADOR DE CPU ===
powershell -Command "Get-Counter '\Processor(_Total)\% Processor Time' | Select-Object -ExpandProperty CounterSamples | Select-Object InstanceName, CookedValue"

REM Contador de memoria
echo.
echo === CONTADOR DE MEMORIA ===
powershell -Command "Get-Counter '\Memory\Available MBytes' | Select-Object -ExpandProperty CounterSamples | Select-Object InstanceName, CookedValue"

REM Contador de disco
echo.
echo === CONTADOR DE DISCO ===
powershell -Command "Get-Counter '\PhysicalDisk(_Total)\% Disk Time' | Select-Object -ExpandProperty CounterSamples | Select-Object InstanceName, CookedValue"

REM Contador de red
echo.
echo === CONTADOR DE RED ===
powershell -Command "Get-Counter '\Network Interface(*)\Bytes Total/sec' | Select-Object -ExpandProperty CounterSamples | Select-Object InstanceName, CookedValue"

echo Obtencion de contadores completada
pause
