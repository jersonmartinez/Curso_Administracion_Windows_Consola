@echo off
:: Ordenar procesos por uso de memoria
echo Analizando procesos por consumo de memoria...

:: Obtener procesos y ordenarlos por memoria
tasklist /FO CSV | findstr /v "Image Name" | sort /R /+2

echo.
echo ✅ Procesos ordenados por consumo de memoria (mayor a menor)
pause 