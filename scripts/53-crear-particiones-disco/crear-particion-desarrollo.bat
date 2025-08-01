@echo off
echo ========================================
echo  PARTICION PARA DESARROLLO
echo ========================================
echo.
REM Crear partición para desarrollo
echo select disk 0 > dev_partition.txt
echo create partition primary size=80000 >> dev_partition.txt
echo assign letter=D >> dev_partition.txt
echo format fs=ntfs quick label="DESARROLLO" >> dev_partition.txt
echo exit >> dev_partition.txt
diskpart /s dev_partition.txt
del dev_partition.txt
REM Crear estructura de carpetas para desarrollo
mkdir D:\Proyectos
mkdir D:\Librerias
mkdir D:\Documentacion
mkdir D:\Backups
mkdir D:\Logs
REM Configurar permisos para desarrolladores
icacls D:\ /grant Desarrolladores:(OI)(CI)F
echo Particion de desarrollo creada en unidad D:
echo Estructura de carpetas configurada
echo Permisos asignados a grupo Desarrolladores
pause
