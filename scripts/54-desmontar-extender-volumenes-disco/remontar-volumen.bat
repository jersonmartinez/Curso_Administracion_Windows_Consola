@echo off
echo ========================================
echo  REMONTAR VOLUMEN
echo ========================================
echo.
set /p volumen="Numero de volumen a remontar: "
set /p nueva_letra="Nueva letra de unidad: "
REM Remontar volumen
echo select volume %volumen% > remount_volume.txt
echo assign letter=%nueva_letra% >> remount_volume.txt
echo exit >> remount_volume.txt
diskpart /s remount_volume.txt
del remount_volume.txt
echo Volumen %volumen% remontado como %nueva_letra%:
echo Verificando acceso...
dir %nueva_letra%:\
pause
