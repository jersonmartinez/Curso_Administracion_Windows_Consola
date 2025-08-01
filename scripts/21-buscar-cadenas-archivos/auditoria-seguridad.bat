@echo off
:: Auditoría de seguridad
echo ========================================
echo      🛡️ AUDITORÍA DE SEGURIDAD
echo ========================================
echo.
echo 🔍 Realizando auditoría de seguridad...
findstr /s /i /r "admin\|root\|password.*=.*[a-zA-Z0-9]\|secret.*=.*[a-zA-Z0-9]" *.ini *.cfg *.txt
echo.
echo 💡 Útil para: compliance, auditorías, protección de datos
echo.
pause 