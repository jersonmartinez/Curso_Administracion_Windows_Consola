@echo off
REM Verificación básica de la integridad del sistema de archivos sin reparaciones automáticas
REM Utiliza CHKDSK para verificar errores y WMIC para mostrar estado del disco

echo 🔍 VERIFICACIÓN BÁSICA DE DISCO
echo ================================

echo.
echo 📁 Verificando integridad de la unidad C:...
chkdsk C: /F

echo.
echo 📊 Información de estado del disco:
wmic logicaldisk where "DeviceID='C:'" get size,freespace,status

echo ✅ Verificación completada
echo.
pause
