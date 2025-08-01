@echo off
REM Formateo avanzado con DISKPART de forma interactiva

echo 🔧 FORMATEO AVANZADO CON DISKPART (INTERACTIVO)
echo ================================================

echo ⚠️  Esta operación requiere conocimientos avanzados
set /p disco="Número de disco (ej: 1): "
set /p unidad="Letra de unidad (ej: D): "
set /p etiqueta="Etiqueta del volumen (ej: DISKPART): "

echo 🔧 Creando script de DISKPART...
echo select disk %disco% > "%TEMP%\diskpart_script.txt"
echo clean >> "%TEMP%\diskpart_script.txt"
echo create partition primary >> "%TEMP%\diskpart_script.txt"
echo format fs=ntfs quick label="%etiqueta%" >> "%TEMP%\diskpart_script.txt"
echo assign letter=%unidad% >> "%TEMP%\diskpart_script.txt"
echo exit >> "%TEMP%\diskpart_script.txt"

echo ⚠️  Ejecutando formateo con DISKPART...
diskpart /s "%TEMP%\diskpart_script.txt"

echo 🗑️ Limpiando archivo temporal...
del "%TEMP%\diskpart_script.txt"

echo ✅ Formateo con DISKPART completado
echo.
pause
