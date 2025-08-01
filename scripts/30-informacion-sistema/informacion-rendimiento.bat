@echo off
:: Información de rendimiento
echo Obteniendo información de rendimiento...

:: Uso de CPU y memoria
wmic cpu get loadpercentage
wmic OS get freephysicalmemory,totalvisiblememorysize

:: Información de disco
wmic logicaldisk get size,freespace,caption

echo.
echo ✅ Información de rendimiento obtenida
pause 