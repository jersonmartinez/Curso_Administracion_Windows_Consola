@echo off
echo ========================================
echo    CREANDO PARTICION BASICA
echo ========================================
echo.
REM Crear script temporal para DISKPART
echo select disk 0 > temp_diskpart.txt
echo create partition primary size=50000 >> temp_diskpart.txt
echo assign letter=D >> temp_diskpart.txt
echo format fs=ntfs quick >> temp_diskpart.txt
echo exit >> temp_diskpart.txt
REM Ejecutar DISKPART con el script
diskpart /s temp_diskpart.txt
REM Limpiar archivo temporal
del temp_diskpart.txt
echo Particion creada exitosamente en unidad D:
pause
