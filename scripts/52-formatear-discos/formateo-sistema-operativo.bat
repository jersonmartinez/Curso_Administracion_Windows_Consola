@echo off
REM Prepara un disco para la instalación de un sistema operativo con configuración optimizada

echo 🖥️ FORMATEO PARA SISTEMA OPERATIVO
echo ===================================

echo.
echo 🖥️ Preparando disco para sistema operativo...
echo ⚠️  Formateo completo con verificación de sectores...

format C: /FS:NTFS /V:SISTEMA /Y

echo.
echo 🔧 Configurando optimizaciones del sistema...
fsutil behavior set disablelastaccess 1
fsutil behavior set disable8dot3 1

echo ✅ Disco preparado para sistema operativo
echo.
pause
