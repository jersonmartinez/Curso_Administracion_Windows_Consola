@echo off
REM Formateo completo con verificación posterior de la integridad (interactivo)

echo 🔍 FORMATEO CON VERIFICACIÓN DE INTEGRIDAD (INTERACTIVO)
echo =========================================================
set /p unidad="Letra de unidad (ej: J): "
set /p etiqueta="Etiqueta del volumen (ej: VERIFICADO): "

echo 🔍 Fase 1: Formateo completo...
format %unidad%: /FS:NTFS /V:%etiqueta% /Y

echo 🔍 Fase 2: Verificación de integridad...
chkdsk %unidad%: /F /R

echo 🔍 Fase 3: Análisis del sistema de archivos...
fsutil fsinfo ntfsinfo %unidad%:

echo ✅ Formateo con verificación completado
echo.
pause
