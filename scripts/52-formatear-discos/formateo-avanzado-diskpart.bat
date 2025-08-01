@echo off
REM Usa DISKPART para formateo avanzado con control total sobre el proceso

echo 🔧 FORMATEO AVANZADO CON DISKPART
echo ==================================

echo.
echo 🔧 Creando script de DISKPART...
echo select disk 1 > "%TEMP%\format_script.txt"
echo clean >> "%TEMP%\format_script.txt"
echo create partition primary >> "%TEMP%\format_script.txt"
echo format fs=ntfs quick label="DATOS" >> "%TEMP%\format_script.txt"
echo assign letter=D >> "%TEMP%\format_script.txt"
echo exit >> "%TEMP%\format_script.txt"

echo ⚠️  Ejecutando formateo con DISKPART...
diskpart /s "%TEMP%\format_script.txt"

echo 🗑️ Limpiando archivo temporal...
del "%TEMP%\format_script.txt"

echo ✅ Formateo con DISKPART completado
echo.
pause
