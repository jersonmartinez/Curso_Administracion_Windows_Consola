@echo off
:: Información de hardware específica
echo Obteniendo información de hardware...

:: Información de CPU
echo === INFORMACIÓN DE CPU ===
wmic cpu get name,numberofcores,maxclockspeed

:: Información de memoria
echo === INFORMACIÓN DE MEMORIA ===
wmic computersystem get totalphysicalmemory

:: Información de disco
echo === INFORMACIÓN DE DISCO ===
wmic logicaldisk get size,freespace,caption

echo.
echo ✅ Información de hardware obtenida
pause 