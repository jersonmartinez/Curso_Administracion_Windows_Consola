@echo off
REM Formatea una unidad de datos con sistema de archivos NTFS (formateo rápido)

echo 🖥️ FORMATEO BÁSICO DE UNIDAD
echo =============================

echo.
echo ⚠️  Formateando unidad D: con NTFS...
echo 📁 Sistema de archivos: NTFS
echo 🔄 Formateo rápido activado

format D: /FS:NTFS /Q /Y

echo.
echo ✅ Formateo completado
echo.
pause
