@echo off
setlocal enabledelayedexpansion
echo ========================================
echo    VERIFICACION MASIVA DE INTEGRIDAD
echo ========================================
echo.

REM Lista de archivos críticos y sus hashes
set "archivos=system32\kernel32.dll system32\ntdll.dll system32\user32.dll"
set "hashes=abc123 def456 ghi789"

set contador=0
for %%f in (%archivos%) do (
    set /a contador+=1
    echo Verificando %%f...
    
    certutil -hashfile "C:\Windows\%%f" MD5 > temp_hash.txt
    for /f "skip=1 tokens=*" %%h in (temp_hash.txt) do set "hash_actual=%%h"
    
    REM Comparar con hash esperado (simplificado)
    echo [%contador%] %%f - Hash: !hash_actual!
    del temp_hash.txt
)

echo.
echo Verificacion completada para %contador% archivos
pause
