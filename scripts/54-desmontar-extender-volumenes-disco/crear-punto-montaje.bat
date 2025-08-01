@echo off
echo ========================================
echo  CREAR PUNTO DE MONTAJE
echo ========================================
echo.
REM Crear carpeta de montaje
mkdir C:\MountPoints\Datos
REM Montar volumen en la carpeta
echo select volume D > mount_point.txt
echo assign mount=C:\MountPoints\Datos >> mount_point.txt
echo exit >> mount_point.txt
diskpart /s mount_point.txt
del mount_point.txt
echo Volumen montado en C:\MountPoints\Datos
echo Verificando acceso...
dir C:\MountPoints\Datos
pause
