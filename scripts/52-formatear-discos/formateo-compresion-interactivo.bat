@echo off
REM Formateo con compresión habilitada de forma interactiva

echo 📦 FORMATEO CON COMPRESIÓN (INTERACTIVO)
echo =========================================
set /p unidad="Letra de unidad (ej: H): "
set /p etiqueta="Etiqueta del volumen (ej: COMPRIMIDO): "

echo 📦 Formateando con compresión...
format %unidad%: /FS:NTFS /Q /V:%etiqueta% /Y

echo 🔧 Habilitando compresión del sistema de archivos...
compact /c /s %unidad%:\ /i /q

echo ✅ Formateo con compresión completado
echo.
pause
