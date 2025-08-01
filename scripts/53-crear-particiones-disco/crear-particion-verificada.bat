@echo off
echo ========================================
echo  PARTICION CON VERIFICACION
echo ========================================
echo.
REM Crear partición con verificación completa
echo select disk 0 > verified_partition.txt
echo create partition primary size=75000 >> verified_partition.txt
echo assign letter=V >> verified_partition.txt
echo format fs=ntfs label="VERIFICADA" >> verified_partition.txt
echo exit >> verified_partition.txt
diskpart /s verified_partition.txt
del verified_partition.txt
REM Verificar la partición creada
chkdsk V: /f /r
echo Particion verificada creada en unidad V:
pause
