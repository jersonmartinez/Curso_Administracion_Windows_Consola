@echo off
:: Ordenar resultados de búsqueda
echo Ordenando resultados de búsqueda...

:: Buscar archivos y ordenar resultados
dir /s /b *.log | findstr "error" | sort

echo.
echo ✅ Resultados de búsqueda ordenados
pause 