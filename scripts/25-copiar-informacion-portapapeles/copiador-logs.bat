@echo off
:: Copiador de logs al portapapeles
title 📊 Copiador de Logs
color 0D

echo ========================================
echo    📊 COPIADOR DE LOGS AL PORTAPAPELES
echo ========================================
echo.

:: Copiar eventos del sistema
echo 🔄 Copiando eventos del sistema...
wevtutil qe System /c:10 /f:text | clip
echo ✅ Últimos 10 eventos del sistema copiados

:: Copiar eventos de aplicación
echo 🔄 Copiando eventos de aplicación...
wevtutil qe Application /c:10 /f:text | clip
echo ✅ Últimos 10 eventos de aplicación copiados

:: Copiar eventos de seguridad
echo 🔄 Copiando eventos de seguridad...
wevtutil qe Security /c:10 /f:text | clip
echo ✅ Últimos 10 eventos de seguridad copiados

echo.
echo 🎉 Logs copiados al portapapeles
pause 