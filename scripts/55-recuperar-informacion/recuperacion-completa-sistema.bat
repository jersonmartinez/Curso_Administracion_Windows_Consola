@echo off
echo ========================================
echo  RECUPERACION COMPLETA DEL SISTEMA
echo ========================================
echo.

echo Verificando entorno de recuperación...
if not exist "C:\Windows\System32\winload.exe" (
    echo ERROR: Ejecute desde modo recuperación
    pause
    exit /b 1
)

echo Iniciando recuperación completa del sistema...
echo.

echo [1/6] Reparando sector de arranque...
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd

echo [2/6] Verificando integridad del disco...
chkdsk C: /f /r /x

echo [3/6] Reparando archivos del sistema...
sfc /scannow

echo [4/6] Reparando imagen del sistema...
DISM /Online /Cleanup-Image /RestoreHealth

echo [5/6] Verificando servicios críticos...
sc query "Windows Update" | find "RUNNING" >nul
if errorlevel 1 (
    echo Reiniciando servicio Windows Update...
    net stop wuauserv
    net start wuauserv
)

echo [6/6] Verificando conectividad de red...
ipconfig /renew
ipconfig /flushdns

echo.
echo ========================================
echo    RECUPERACION COMPLETADA
echo ========================================
echo.
echo Sistema recuperado exitosamente
echo Reinicie el sistema para aplicar cambios
pause
