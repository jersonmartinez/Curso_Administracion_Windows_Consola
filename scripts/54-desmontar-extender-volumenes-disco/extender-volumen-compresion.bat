@echo off
echo ========================================
echo  EXTENDER VOLUMEN CON COMPRESION
echo ========================================
echo.
set /p unidad="Unidad a extender: "
set /p tamano="Tamaño a agregar en MB: "
REM Extender volumen
echo select volume %unidad% > extend_compressed.txt
echo extend size=%tamano% >> extend_compressed.txt
echo exit >> extend_compressed.txt
diskpart /s extend_compressed.txt
del extend_compressed.txt
REM Habilitar compresión en el volumen extendido
compact /c /s:%unidad%:\ /i /q
echo Volumen %unidad%: extendido y compresión habilitada
echo Espacio optimizado con compresión NTFS
pause
