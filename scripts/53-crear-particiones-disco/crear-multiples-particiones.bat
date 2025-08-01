@echo off
echo ========================================
echo  CREANDO MULTIPLES PARTICIONES
echo ========================================
echo.
REM Script para crear particiones organizadas
echo select disk 0 > multi_partition.txt
echo create partition primary size=100000 >> multi_partition.txt
echo assign letter=D >> multi_partition.txt
echo format fs=ntfs quick label="DATOS" >> multi_partition.txt
echo create partition primary size=50000 >> multi_partition.txt
echo assign letter=E >> multi_partition.txt
echo format fs=ntfs quick label="BACKUP" >> multi_partition.txt
echo create partition primary >> multi_partition.txt
echo assign letter=F >> multi_partition.txt
echo format fs=ntfs quick label="MULTIMEDIA" >> multi_partition.txt
echo exit >> multi_partition.txt
diskpart /s multi_partition.txt
del multi_partition.txt
echo Particiones creadas: D: (Datos), E: (Backup), F: (Multimedia)
pause
