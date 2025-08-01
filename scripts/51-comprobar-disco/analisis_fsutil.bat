@echo off
REM Análisis detallado del sistema de archivos y su estado actual
REM Utiliza FSUTIL para obtener información avanzada de NTFS y volumen

echo 📋 ANÁLISIS DETALLADO DEL SISTEMA DE ARCHIVOS
echo ==============================================

echo.
echo 📊 Información del sistema de archivos:
fsutil fsinfo ntfsinfo C:

echo.
echo 📈 Estadísticas de uso:
fsutil volume diskfree C:

echo.
echo 🔍 Verificando integridad del sistema de archivos:
fsutil dirty query C:

echo ✅ Análisis completado
echo.
pause
