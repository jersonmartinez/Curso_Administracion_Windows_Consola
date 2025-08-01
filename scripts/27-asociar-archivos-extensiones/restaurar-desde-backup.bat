@echo off
:: Restaurar desde backup
echo Restaurando asociaciones desde backup...

:: Verificar si existe backup
if exist "asociaciones_backup.txt" (
    echo 🔄 Restaurando asociaciones...
    for /f "tokens=1,2 delims==" %%a in (asociaciones_backup.txt) do (
        assoc %%a=%%b
    )
    echo ✅ Asociaciones restauradas
) else (
    echo ❌ Archivo de backup no encontrado
)
pause 