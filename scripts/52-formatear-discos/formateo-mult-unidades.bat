@echo off
REM Formatea múltiples unidades de manera sistemática con configuraciones específicas

echo 🔄 FORMATEO DE MÚLTIPLES UNIDADES
echo ==================================

echo.
echo 🔄 Formateando múltiples unidades...

echo 📁 Formateando unidad D: (Datos)...
format D: /FS:NTFS /Q /V:DATOS /Y

echo 📁 Formateando unidad E: (Respaldo)...
format E: /FS:NTFS /Q /V:RESPALDO /Y

echo 📁 Formateando unidad F: (Temporal)...
format F: /FS:FAT32 /Q /V:TEMPORAL /Y

echo ✅ Formateo de múltiples unidades completado
echo.
pause
