@echo off
echo ========================================
echo  RECUPERAR DATOS DE DISCO DAÑADO
echo ========================================
echo.

set /p disco="Numero de disco dañado: "
set /p destino="Unidad de destino para datos: "

REM Crear directorio de recuperación
mkdir "%destino%:\Recuperacion_Disco_%disco%" 2>nul

REM Script para recuperación de bajo nivel
echo select disk %disco% > disk_recovery.txt
echo list partition >> disk_recovery.txt
echo list volume >> disk_recovery.txt

REM Intentar montar volúmenes
echo.
echo Intentando montar volúmenes...
echo select disk %disco% >> disk_recovery.txt
echo list volume >> disk_recovery.txt

REM Para cada volumen encontrado, intentar asignar letra
echo select volume 0 >> disk_recovery.txt
echo assign letter=T >> disk_recovery.txt

echo exit >> disk_recovery.txt

diskpart /s disk_recovery.txt
del disk_recovery.txt

REM Copiar datos si el volumen se montó
if exist T:\ (
    echo Copiando datos del volumen T:...
    xcopy T:\ "%destino%:\Recuperacion_Disco_%disco%\" /E /H /C /I /Y
    
    REM Desmontar volumen temporal
    echo select volume T > unmount_temp.txt
    echo remove letter=T >> unmount_temp.txt
    echo exit >> unmount_temp.txt
    diskpart /s unmount_temp.txt
    del unmount_temp.txt
    
    echo Datos copiados a %destino%:\Recuperacion_Disco_%disco%\
) else (
    echo No se pudo montar el volumen para recuperación
)

pause
