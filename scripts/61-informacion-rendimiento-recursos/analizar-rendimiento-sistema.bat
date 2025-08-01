@echo off
echo ========================================
echo    ANALIZAR RENDIMIENTO DEL SISTEMA
echo ========================================
echo.

echo Analizando rendimiento del sistema...
echo Analisis iniciado: %date% %time%

REM Información general del sistema
echo === INFORMACION GENERAL DEL SISTEMA ===
systeminfo | findstr /C:"Total Physical Memory" /C:"Available Physical Memory" /C:"Virtual Memory: Max Size" /C:"Virtual Memory: Available"

REM Información del procesador
echo.
echo === INFORMACION DEL PROCESADOR ===
wmic cpu get name,numberofcores,numberoflogicalprocessors,maxclockspeed /format:table

REM Información de memoria
echo.
echo === INFORMACION DE MEMORIA ===
wmic computersystem get totalphysicalmemory /format:value
wmic OS get totalvisiblememorysize,freephysicalmemory /format:table

REM Información de discos
echo.
echo === INFORMACION DE DISCOS ===
wmic logicaldisk get deviceid,size,freespace,volumename /format:table

echo Analisis del sistema completado
pause
