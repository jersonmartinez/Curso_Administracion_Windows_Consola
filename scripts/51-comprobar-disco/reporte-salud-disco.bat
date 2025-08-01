@echo off
echo 📋 REPORTE COMPLETO DE SALUD DEL DISCO
echo ======================================

echo.
echo 📝 Generando reporte completo...
echo Fecha: %date% %time% > "reporte_salud_disco.txt"
echo ================================ >> "reporte_salud_disco.txt"
echo REPORTE DE SALUD DE DISCOS >> "reporte_salud_disco.txt"
echo ================================ >> "reporte_salud_disco.txt"
echo. >> "reporte_salud_disco.txt"

echo 📊 INFORMACIÓN GENERAL DE DISCOS: >> "reporte_salud_disco.txt"
wmic logicaldisk get size,freespace,caption,mediatype,status >> "reporte_salud_disco.txt"
echo. >> "reporte_salud_disco.txt"

echo 🔍 INFORMACIÓN SMART: >> "reporte_salud_disco.txt"
wmic diskdrive get model,status,mediatype,partitions,size,freespace >> "reporte_salud_disco.txt"
echo. >> "reporte_salud_disco.txt"

echo 📈 ANÁLISIS DE FRAGMENTACIÓN: >> "reporte_salud_disco.txt"
defrag C: /A /V >> "reporte_salud_disco.txt"
echo. >> "reporte_salud_disco.txt"

echo 🔧 ESTADO DEL SISTEMA DE ARCHIVOS: >> "reporte_salud_disco.txt"
fsutil fsinfo ntfsinfo C: >> "reporte_salud_disco.txt"
echo. >> "reporte_salud_disco.txt"

echo ✅ Reporte guardado en: reporte_salud_disco.txt
echo.
pause
