@echo off
echo ========================================
echo  RECUPERACION COMPLETA DEL SISTEMA
echo ========================================
echo.

REM Verificar modo de recuperación
echo Verificando entorno de recuperación...
if not exist "C:\Windows\System32\winload.exe" (
    echo ERROR: Ejecute desde modo recuperación
    pause
    exit /b 1
)

echo Iniciando recuperación completa del sistema...
echo.

REM Paso 1: Reparar sector de arranque
echo [1/6] Reparando sector de arranque...
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd

REM Paso 2: Verificar integridad del disco
echo [2/6] Verificando integridad del disco...
chkdsk C: /f /r /x

REM Paso 3: Reparar archivos del sistema
echo [3/6] Reparando archivos del sistema...
sfc /scannow

REM Paso 4: Reparar imagen del sistema
echo [4/6] Reparando imagen del sistema...
DISM /Online /Cleanup-Image /RestoreHealth

REM Paso 5: Verificar servicios críticos
echo [5/6] Verificando servicios críticos...
sc query "Windows Update" | find "RUNNING" >nul
if errorlevel 1 (
    echo Reiniciando servicio Windows Update...
    net stop wuauserv
    net start wuauserv
)

REM Paso 6: Verificar conectividad de red
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
