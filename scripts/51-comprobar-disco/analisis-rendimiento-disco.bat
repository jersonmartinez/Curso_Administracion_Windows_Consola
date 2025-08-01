@echo off
echo 📈 ANÁLISIS DE RENDIMIENTO DEL DISCO
echo =====================================

echo.
echo 📊 Información de rendimiento:
wmic logicaldisk get size,freespace,caption,mediatype,status

echo.
echo 🔍 Verificando fragmentación:
defrag C: /A /V

echo.
echo 📈 Estadísticas de uso del disco:
fsutil volume diskfree C:

echo ✅ Análisis de rendimiento completado
echo.
pause
