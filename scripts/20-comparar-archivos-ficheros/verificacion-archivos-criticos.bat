@echo off
:: Verificación de archivos críticos
echo ========================================
echo      🛡️ VERIFICACIÓN DE ARCHIVOS CRÍTICOS
echo ========================================
echo.
echo 🔍 Verificando archivos críticos del sistema...
certutil -hashfile C:\Windows\System32\kernel32.dll MD5
certutil -hashfile C:\Windows\System32\user32.dll MD5
echo.
echo 💡 Útil para: seguridad, detección de malware, auditorías
echo.
pause 