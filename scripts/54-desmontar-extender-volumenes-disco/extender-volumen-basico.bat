@echo off
echo ========================================
echo    EXTENDER VOLUMEN BASICO
echo ========================================
echo.
REM Script para extender volumen
echo select volume D > extend_volume.txt
echo extend size=50000 >> extend_volume.txt
echo exit >> extend_volume.txt
REM Ejecutar extensión
diskpart /s extend_volume.txt
del extend_volume.txt
echo Volumen D: extendido en 50GB
echo Verificando espacio disponible...
dir D:\
pause
