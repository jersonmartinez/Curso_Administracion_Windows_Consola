@echo off
REM Verificación completa del disco con reparación automática de errores
REM Utiliza CHKDSK con opciones /F /R /X para reparar y recuperar sectores

echo 🔧 VERIFICACIÓN COMPLETA CON REPARACIÓN
echo ========================================

echo.
echo ⚠️  Iniciando verificación completa de la unidad C:...
echo 🔧 Reparando errores automáticamente...
echo ⏰ Este proceso puede tomar varios minutos...

chkdsk C: /F /R /X

echo.
echo ✅ Verificación y reparación completadas
echo.
pause
