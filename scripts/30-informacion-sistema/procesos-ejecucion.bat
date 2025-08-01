@echo off
:: Procesos en ejecución
echo Mostrando procesos en ejecución...

:: Listar procesos con información detallada
tasklist /v /fo table

echo.
echo ✅ Procesos mostrados
pause 