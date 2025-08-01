@echo off
echo ========================================
echo  PARTICION PARA SISTEMA OPERATIVO
echo ========================================
echo.
REM Crear partición optimizada para SO
echo select disk 0 > os_partition.txt
echo create partition primary size=100000 >> os_partition.txt
echo assign letter=C >> os_partition.txt
echo format fs=ntfs quick label="WINDOWS_OS" >> os_partition.txt
echo active >> os_partition.txt
echo exit >> os_partition.txt
diskpart /s os_partition.txt
del os_partition.txt
echo Particion del sistema creada y marcada como activa
echo Tamaño: 100GB, Sistema: NTFS, Etiqueta: WINDOWS_OS
pause
