@echo off
REM Realiza un formateo completo con verificación de sectores defectuosos

echo 🔍 FORMATEO COMPLETO CON VERIFICACIÓN
echo ======================================

echo.
echo ⚠️  Iniciando formateo completo de la unidad E:...
echo 📁 Sistema de archivos: NTFS
echo 🔍 Verificando sectores defectuosos...
echo ⏰ Este proceso puede tomar varias horas...

format E: /FS:NTFS /V:Datos /Y

echo.
echo ✅ Formateo completo finalizado
echo.
pause
