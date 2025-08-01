@echo off
:: Restaurar permisos desde backup
echo Restaurando permisos desde backup...

:: Restaurar desde archivo de backup
if exist "permisos_backup.txt" (
    icacls "directorio/" /restore permisos_backup.txt
    echo ✅ Permisos restaurados
) else (
    echo ❌ Archivo de backup no encontrado
)
pause 