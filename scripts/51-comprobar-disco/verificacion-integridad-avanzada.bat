@echo off
echo 🔬 VERIFICACIÓN DE INTEGRIDAD AVANZADA
echo ======================================

echo.
echo 🔍 Fase 1: Verificación básica del sistema de archivos...
chkdsk C: /F

echo.
echo 🔬 Fase 2: Verificación de sectores físicos...
chkdsk C: /R

echo.
echo 📊 Fase 3: Análisis de metadatos...
fsutil fsinfo ntfsinfo C:

echo.
echo 🔍 Fase 4: Verificación de integridad de estructura...
fsutil dirty query C:

echo ✅ Verificación avanzada completada
echo.
pause
