@echo off
:: Configurar herencia de permisos
echo Configurando herencia de permisos...

:: Habilitar herencia
icacls "directorio/" /inheritance:e

echo.
echo ✅ Herencia configurada
pause 