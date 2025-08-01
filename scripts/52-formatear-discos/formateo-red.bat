@echo off
REM Prepara un disco para uso en red con configuraciones específicas

echo 🌐 FORMATEO PARA ALMACENAMIENTO DE RED
echo ======================================

echo.
echo 🌐 Preparando disco para almacenamiento de red...
echo 📁 Sistema de archivos: NTFS
echo 🔧 Optimizado para acceso de red

format I: /FS:NTFS /A:32768 /Q /V:RED /Y

echo.
echo 🔧 Configurando optimizaciones de red...
fsutil behavior set disablelastaccess 1
fsutil behavior set mftzone 2

echo ✅ Disco preparado para almacenamiento de red
echo.
pause
