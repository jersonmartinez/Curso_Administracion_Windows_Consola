@echo off
REM Formateo para almacenamiento de red de forma interactiva

echo 🌐 FORMATEO PARA ALMACENAMIENTO DE RED (INTERACTIVO)
echo =====================================================
set /p unidad="Letra de unidad (ej: I): "
set /p etiqueta="Etiqueta del volumen (ej: RED): "

echo 🌐 Preparando disco para almacenamiento de red...
format %unidad%: /FS:NTFS /A:32768 /Q /V:%etiqueta% /Y

echo 🔧 Configurando optimizaciones de red...
fsutil behavior set disablelastaccess 1
fsutil behavior set mftzone 2

echo ✅ Disco preparado para almacenamiento de red
echo.
pause
