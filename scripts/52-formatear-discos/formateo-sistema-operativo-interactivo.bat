@echo off
REM Formateo para sistema operativo de forma interactiva

echo 🖥️ FORMATEO PARA SISTEMA OPERATIVO (INTERACTIVO)
echo ==================================================
set /p unidad="Letra de unidad del sistema (ej: C): "
set /p etiqueta="Etiqueta del sistema (ej: SISTEMA): "

echo 🖥️ Preparando disco para sistema operativo...
format %unidad%: /FS:NTFS /V:%etiqueta% /Y

echo 🔧 Configurando optimizaciones del sistema...
fsutil behavior set disablelastaccess 1
fsutil behavior set disable8dot3 1

echo ✅ Disco preparado para sistema operativo
echo.
pause
