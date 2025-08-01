@echo off
REM Formatea una unidad USB con FAT32 para máxima compatibilidad

echo 📱 FORMATEO USB CON FAT32
echo ==========================

echo.
echo 📱 Formateando unidad USB (F:) con FAT32...
echo 🔄 Compatibilidad máxima con diferentes sistemas
echo 📁 Sistema de archivos: FAT32

format F: /FS:FAT32 /Q /V:USB_DATOS /Y

echo.
echo ✅ Formateo USB completado
echo.
pause
