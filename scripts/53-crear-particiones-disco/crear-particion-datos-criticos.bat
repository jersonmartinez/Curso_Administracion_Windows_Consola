@echo off
echo ========================================
echo  PARTICION PARA DATOS CRITICOS
echo ========================================
echo.
REM Crear partición para datos críticos
echo select disk 0 > critical_partition.txt
echo create partition primary size=40000 >> critical_partition.txt
echo assign letter=K >> critical_partition.txt
echo format fs=ntfs quick label="DATOS_CRITICOS" >> critical_partition.txt
echo exit >> critical_partition.txt
diskpart /s critical_partition.txt
del critical_partition.txt
REM Configurar permisos de seguridad
icacls K:\ /inheritance:r
icacls K:\ /grant Administradores:F
icacls K:\ /grant Usuarios:(OI)(CI)RX
echo Particion para datos criticos creada en unidad K:
echo Permisos de seguridad configurados
pause
