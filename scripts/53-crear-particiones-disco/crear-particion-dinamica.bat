@echo off
echo ========================================
echo  PARTICION CON TAMAÑO DINAMICO
echo ========================================
echo.
REM Crear partición que use todo el espacio restante
echo select disk 0 > dynamic_partition.txt
echo create partition primary >> dynamic_partition.txt
echo assign letter=X >> dynamic_partition.txt
echo format fs=ntfs quick label="ESPACIO_LIBRE" >> dynamic_partition.txt
echo exit >> dynamic_partition.txt
diskpart /s dynamic_partition.txt
del dynamic_partition.txt
echo Particion creada usando todo el espacio disponible en unidad X:
pause
