@echo off
echo ========================================
echo    VERIFICACION DE BASE DE DATOS
echo ========================================
echo.

REM Archivos de base de datos
set "db_files=master.mdf tempdb.mdf model.mdf msdb.mdf"

for %%f in (%db_files%) do (
    echo Verificando %%f...
    certutil -hashfile "%%f" MD5
)
echo.
echo Verificación completada
pause
