@echo off
echo ========================================
echo  DESMONTAR VOLUMEN TEMPORALMENTE
echo ========================================
echo.
set /p unidad="Unidad a desmontar (ej: E): "
REM Verificar que el volumen no esté en uso
echo Verificando uso del volumen...
net use | find "%unidad%:"
if %errorlevel%==0 (
    echo ERROR: El volumen está en uso por la red
    pause
    exit /b 1
)
REM Desmontar volumen
echo select volume %unidad% > unmount_volume.txt
echo remove letter=%unidad% >> unmount_volume.txt
echo exit >> unmount_volume.txt
diskpart /s unmount_volume.txt
del unmount_volume.txt
echo Volumen %unidad%: desmontado temporalmente
echo Para remontar, use: diskpart /s remount.txt
pause
