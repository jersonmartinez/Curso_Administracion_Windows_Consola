@echo off
REM Formatea un disco con tamaño de clúster específico para optimizar el rendimiento

echo ⚙️ FORMATEO CON CLÚSTER PERSONALIZADO
echo ======================================

echo.
echo ⚙️ Formateando unidad G: con clúster de 64KB...
echo 📁 Sistema de archivos: NTFS
echo 🔧 Tamaño de clúster: 64KB
echo 🚀 Optimizado para archivos grandes

format G: /FS:NTFS /A:65536 /Q /V:ARCHIVOS_GRANDES /Y

echo.
echo ✅ Formateo con clúster personalizado completado
echo.
pause
