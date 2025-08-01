@echo off
REM Archivo a verificar
set "archivo=config.xml"
set "hash_original=5d41402abc4b2a76b9719d911017c592"

echo Verificando integridad de %archivo%...
certutil -hashfile "%archivo%" MD5 > temp_hash.txt

REM Extraer hash calculado
for /f "skip=1 tokens=*" %%i in (temp_hash.txt) do (
    set "hash_calculado=%%i"
    goto :comparar
)

:comparar
if "%hash_calculado%"=="%hash_original%" (
    echo [OK] Archivo %archivo% - Integridad verificada
) else (
    echo [ERROR] Archivo %archivo% - Integridad comprometida
    echo Hash original: %hash_original%
    echo Hash actual: %hash_calculado%
)

del temp_hash.txt
pause
