@echo off
echo 📅 VERIFICACIÓN PROGRAMADA
echo ===========================

echo.
echo ⏰ Configurando verificación semanal automática...
schtasks /create /tn "Verificacion_Disco_Semanal" /tr "chkdsk C: /F /R" /sc weekly /d SUN /st 03:00 /ru SYSTEM

echo.
echo 📋 Verificando tarea creada...
schtasks /query /tn "Verificacion_Disco_Semanal"

echo ✅ Verificación programada configurada
echo.
pause
