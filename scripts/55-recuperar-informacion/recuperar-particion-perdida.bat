@echo off
echo ========================================
echo  RECUPERAR PARTICION PERDIDA
echo ========================================
echo.

echo Discos disponibles:
diskpart /s <(echo list disk)

echo.
set /p disco="Numero de disco a analizar: "

REM Crear script para recuperar partición
echo select disk %disco% > recover_partition.txt
echo list partition >> recover_partition.txt
echo list volume >> recover_partition.txt

echo.
echo Buscando particiones eliminadas...
echo select disk %disco% >> recover_partition.txt
echo list partition >> recover_partition.txt

echo.
echo Intentando recuperar partición...
echo select disk %disco% >> recover_partition.txt
echo recover >> recover_partition.txt

echo exit >> recover_partition.txt

diskpart /s recover_partition.txt
del recover_partition.txt

echo Partición recuperada si fue encontrada
echo Verifique con: diskpart /s <(echo list volume)
pause
