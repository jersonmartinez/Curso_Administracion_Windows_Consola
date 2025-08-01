@echo off
:: Información de servicios
echo Obteniendo información de servicios...

:: Listar servicios y su estado
sc query | findstr "SERVICE_NAME"

echo.
echo ✅ Información de servicios obtenida
pause 