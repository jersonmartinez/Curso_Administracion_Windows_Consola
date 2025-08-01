@echo off
echo ========================================
echo  PARTICION CON COMPRESION
echo ========================================
echo.
REM Crear partición con compresión
echo select disk 0 > compressed_partition.txt
echo create partition primary size=60000 >> compressed_partition.txt
echo assign letter=Z >> compressed_partition.txt
echo format fs=ntfs quick label="COMPRIMIDA" >> compressed_partition.txt
echo exit >> compressed_partition.txt
diskpart /s compressed_partition.txt
del compressed_partition.txt
REM Habilitar compresión en la partición
compact /c /s:Z:\ /i /q
echo Particion con compresion creada en unidad Z:
echo La compresion NTFS esta habilitada
pause
