@echo off
echo ========================================
echo  RECUPERAR SECTOR DE ARRANQUE
echo ========================================
echo.

REM Verificar si estamos en modo recuperación
echo Verificando entorno de recuperación...
if not exist "C:\Windows\System32\winload.exe" (
    echo ERROR: No se detectó Windows. Ejecute desde modo recuperación.
    pause
    exit /b 1
)

REM Reparar sector de arranque
echo Reparando sector de arranque...
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd

REM Verificar resultado
echo.
echo Verificando reparación...
bootrec /scanos

echo Sector de arranque reparado
echo Reinicie el sistema para verificar
pause
