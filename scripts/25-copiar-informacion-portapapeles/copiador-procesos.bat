@echo off
:: Copiador de información de procesos
title 🔥 Copiador de Procesos
color 0F

echo ========================================
echo    🔥 COPIADOR DE INFORMACIÓN DE PROCESOS
echo ========================================
echo.

:: Copiar lista de procesos
echo 🔄 Copiando lista de procesos...
tasklist /v | clip
echo ✅ Lista de procesos copiada al portapapeles

:: Copiar información detallada de procesos
echo 🔄 Copiando información detallada...
wmic process get name,processid,workingsetsize,commandline | clip
echo ✅ Información detallada copiada al portapapeles

:: Copiar procesos con mayor uso de CPU
echo 🔄 Copiando procesos con mayor uso de CPU...
wmic process get name,processid,workingsetsize /format:list | findstr /C:"Name=" /C:"ProcessId=" /C:"WorkingSetSize=" | clip
echo ✅ Procesos con mayor uso de CPU copiados al portapapeles

echo.
echo 🎉 Información de procesos copiada al portapapeles
pause 