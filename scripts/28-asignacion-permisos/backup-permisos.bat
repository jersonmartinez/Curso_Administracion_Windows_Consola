@echo off
:: Backup de permisos
echo Creando backup de permisos...

:: Exportar permisos actuales
icacls "directorio/" /save permisos_backup.txt /t

echo.
echo ✅ Backup de permisos creado
pause 