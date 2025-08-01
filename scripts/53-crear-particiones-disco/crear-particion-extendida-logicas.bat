@echo off
echo ========================================
echo  PARTICION EXTENDIDA CON LOGICAS
echo ========================================
echo.
REM Crear partición extendida con unidades lógicas
echo select disk 0 > extended_partition.txt
echo create partition extended size=200000 >> extended_partition.txt
echo create partition logical size=50000 >> extended_partition.txt
echo assign letter=G >> extended_partition.txt
echo format fs=ntfs quick label="PROYECTOS" >> extended_partition.txt
echo create partition logical size=50000 >> extended_partition.txt
echo assign letter=H >> extended_partition.txt
echo format fs=ntfs quick label="DESARROLLO" >> extended_partition.txt
echo create partition logical >> extended_partition.txt
echo assign letter=I >> extended_partition.txt
echo format fs=ntfs quick label="TESTING" >> extended_partition.txt
echo exit >> extended_partition.txt
diskpart /s extended_partition.txt
del extended_partition.txt
echo Particiones lógicas creadas: G:, H:, I:
pause
