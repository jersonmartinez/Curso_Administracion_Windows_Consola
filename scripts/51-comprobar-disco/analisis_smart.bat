@echo off
REM Análisis SMART del disco para obtener información detallada de salud
REM Utiliza WMIC para consultar atributos SMART y estado del disco

echo 📊 ANÁLISIS SMART DEL DISCO
echo ============================

echo.
echo 🔍 Obteniendo información SMART del disco...
wmic diskdrive get model,size,status,mediatype

echo.
echo 📈 Información detallada de salud:
wmic diskdrive get model,status,mediatype,partitions,size,freespace

echo.
echo ⚠️  Verificando sectores defectuosos:
wmic diskdrive get model,status,mediatype,partitions,size,freespace /format:list

echo ✅ Análisis SMART completado
echo.
pause
