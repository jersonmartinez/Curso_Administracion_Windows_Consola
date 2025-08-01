@echo off
REM Realiza un formateo completo y verifica la integridad posteriormente

echo 🔍 FORMATEO CON VERIFICACIÓN DE INTEGRIDAD
echo ==========================================

echo.
echo 🔍 Fase 1: Formateo completo...
format J: /FS:NTFS /V:VERIFICADO /Y

echo.
echo 🔍 Fase 2: Verificación de integridad...
chkdsk J: /F /R

echo.
echo 🔍 Fase 3: Análisis del sistema de archivos...
fsutil fsinfo ntfsinfo J:

echo ✅ Formateo con verificación completado
echo.
pause
