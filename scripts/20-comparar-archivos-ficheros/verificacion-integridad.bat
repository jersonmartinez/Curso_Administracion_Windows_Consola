@echo off
:: Verificación de integridad con hash
echo ========================================
echo      🔐 VERIFICACIÓN DE INTEGRIDAD
echo ========================================
echo.
set archivo=documento_importante.txt
echo 🔍 Calculando hash MD5 de %archivo%...
certutil -hashfile "%archivo%" MD5
echo.
echo 💡 Útil para: seguridad, verificación de descargas, auditorías
echo.
pause 