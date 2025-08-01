@echo off
:: Ordenar lista de usuarios por nombre
echo Generando lista de usuarios ordenada...

:: Obtener usuarios y ordenarlos alfabéticamente
net user | findstr /v "comando" | sort

echo.
echo ✅ Lista de usuarios ordenada alfabéticamente
pause 