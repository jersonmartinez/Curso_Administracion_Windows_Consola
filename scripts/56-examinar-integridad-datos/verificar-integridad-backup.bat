@echo off
echo ========================================
echo    VERIFICACION DE INTEGRIDAD DE BACKUP
echo ========================================
echo.

set "backup_dir=C:\Backups"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"

echo Verificando backups del %fecha%...

for %%f in ("%backup_dir%\*%fecha%*.bak") do (
    echo Verificando %%f...
    certutil -hashfile "%%f" SHA256 > temp_hash.txt
    for /f "skip=1 tokens=*" %%h in (temp_hash.txt) do set "hash=%%h"
    for %%A in ("%%f") do set "tamano=%%~zA"
    echo [OK] %%f - Tamaño: !tamano! bytes
    echo Hash SHA256: !hash!
    echo.
    del temp_hash.txt
)

echo Verificacion de backup completada
pause
