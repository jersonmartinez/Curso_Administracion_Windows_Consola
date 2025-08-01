@echo off
:: Diagnóstico con portapapeles
title 🔍 Diagnóstico con Portapapeles
color 0C

echo ========================================
echo    🔍 DIAGNÓSTICO CON PORTAPAPELES
echo ========================================
echo.

:: Crear archivo temporal para recopilar información
set "temp_file=%TEMP%\diagnostico_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"

echo ===== DIAGNÓSTICO DEL SISTEMA ===== > "%temp_file%"
echo Fecha: %date% %time% >> "%temp_file%"
echo. >> "%temp_file%"

:: Información del sistema
echo ===== INFORMACIÓN DEL SISTEMA ===== >> "%temp_file%"
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"Total Physical Memory" >> "%temp_file%"
echo. >> "%temp_file%"

:: Información de red
echo ===== INFORMACIÓN DE RED ===== >> "%temp_file%"
ipconfig | findstr /C:"IPv4" /C:"Default Gateway" >> "%temp_file%"
echo. >> "%temp_file%"

:: Información de disco
echo ===== INFORMACIÓN DE DISCO ===== >> "%temp_file%"
wmic logicaldisk get size,freespace,caption >> "%temp_file%"
echo. >> "%temp_file%"

:: Información de memoria
echo ===== INFORMACIÓN DE MEMORIA ===== >> "%temp_file%"
wmic memorychip get capacity,speed >> "%temp_file%"
echo. >> "%temp_file%"

:: Copiar todo al portapapeles
type "%temp_file%" | clip

echo ✅ Diagnóstico completo copiado al portapapeles
echo 📄 Archivo temporal: %temp_file%

:: Limpiar archivo temporal
del "%temp_file%"

pause 