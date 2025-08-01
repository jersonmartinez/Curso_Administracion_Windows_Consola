@echo off
:: Ver permisos de un archivo
echo Verificando permisos del archivo...

:: Mostrar permisos detallados
icacls "documento.txt"

echo.
echo ✅ Permisos mostrados
pause 