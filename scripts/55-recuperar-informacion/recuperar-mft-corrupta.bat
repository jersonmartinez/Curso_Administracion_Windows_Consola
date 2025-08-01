@echo off
echo ========================================
echo  RECUPERAR MFT CORRUPTA
echo ========================================
echo.

set /p unidad="Unidad a reparar (ej: C): "

REM Verificar integridad del sistema de archivos
echo Verificando integridad del sistema de archivos...
chkdsk %unidad%: /f /r /x

REM Reparar archivos del sistema
echo.
echo Reparando archivos del sistema...
sfc /scannow

REM Verificar imagen del sistema
echo.
echo Verificando imagen del sistema...
DISM /Online /Cleanup-Image /RestoreHealth

REM Verificar resultado
echo.
echo Verificando resultado...
chkdsk %unidad%: /f

echo MFT reparada y sistema verificado
pause
