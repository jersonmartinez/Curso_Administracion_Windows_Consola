@echo off
echo ========================================
echo  VOLUMEN DISTRIBUIDO
echo ========================================
echo.
REM Crear volumen distribuido
echo select disk 0 > spanned_volume.txt
echo create volume simple size=100000 >> spanned_volume.txt
echo select disk 1 >> spanned_volume.txt
echo extend >> spanned_volume.txt
echo assign letter=S >> spanned_volume.txt
echo format fs=ntfs quick label="DISTRIBUIDO" >> spanned_volume.txt
echo exit >> spanned_volume.txt
diskpart /s spanned_volume.txt
del spanned_volume.txt
echo Volumen distribuido creado en unidad S:
echo Combina espacio de disco 0 y disco 1
pause
