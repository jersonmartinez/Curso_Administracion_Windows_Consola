@echo off
REM Monitoreo de sectores defectuosos en el disco para prevenir pérdida de datos
REM Utiliza CHKDSK y WMIC para detectar y reportar sectores defectuosos

echo ⚠️ MONITOREO DE SECTORES DEFECTUOSOS
echo ====================================

echo.
echo 🔍 Verificando sectores defectuosos en la unidad C:...
chkdsk C: /R /F

echo.
echo 📊 Información de sectores:
wmic diskdrive get model,status,mediatype,partitions,size,freespace /format:list | findstr "Status"

echo.
echo ✅ Monitoreo completado
echo.
pause
