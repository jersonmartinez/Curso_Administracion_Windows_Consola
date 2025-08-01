@echo off
echo ========================================
echo    VERIFICACION DE INTEGRIDAD DE ISO
echo ========================================
echo.

set "iso_dir=C:\ISOs"
set "hash_expected=abcdef1234567890"

for %%f in ("%iso_dir%\*.iso") do (
    echo Verificando %%f...
    certutil -hashfile "%%f" SHA256 > temp_hash.txt
    for /f "skip=1 tokens=*" %%h in (temp_hash.txt) do set "hash_actual=%%h"
    if "!hash_actual!"=="%hash_expected%" (
        echo [OK] %%f - Integridad verificada
    ) else (
        echo [ERROR] %%f - Integridad comprometida
        echo Hash esperado: %hash_expected%
        echo Hash actual: !hash_actual!
    )
    del temp_hash.txt
)

echo Verificacion de ISO completada
pause
