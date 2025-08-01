@echo off
:: Backup de asociaciones
echo Creando backup de asociaciones...

:: Exportar asociaciones actuales
assoc > asociaciones_backup.txt
ftype > tipos_backup.txt

echo.
echo ✅ Backup de asociaciones creado
pause 