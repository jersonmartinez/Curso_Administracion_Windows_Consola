@echo off
REM Formatea un disco con compresión habilitada para ahorrar espacio

echo 📦 FORMATEO CON COMPRESIÓN
echo ===========================

echo.
echo 📦 Formateando unidad H: con compresión...
echo 📁 Sistema de archivos: NTFS
echo 🔄 Compresión habilitada

format H: /FS:NTFS /Q /V:COMPRIMIDO /Y

echo.
echo 🔧 Habilitando compresión del sistema de archivos...
compact /c /s H:\ /i /q

echo ✅ Formateo con compresión completado
echo.
pause
