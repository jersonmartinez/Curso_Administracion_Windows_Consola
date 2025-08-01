@echo off
:: Restaurar permisos por defecto
echo Restaurando permisos por defecto...

:: Restaurar permisos heredados
icacls "directorio/" /reset /t

echo.
echo ✅ Permisos restaurados por defecto
pause 