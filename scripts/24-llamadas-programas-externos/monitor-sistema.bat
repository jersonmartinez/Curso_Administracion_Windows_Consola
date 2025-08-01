@echo off
:: Monitor de sistema con herramientas externas
title 📊 Monitor de Sistema
color 0B

echo ========================================
echo    📊 MONITOR DE SISTEMA CON HERRAMIENTAS EXTERNAS
echo ========================================
echo.

:: Información del sistema con herramientas nativas
echo 💻 Información del sistema:
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"Total Physical Memory"

:: Monitoreo de CPU con herramientas externas
if exist "C:\Tools\cpuz\cpuz.exe" (
    echo 🔥 Información de CPU:
    "C:\Tools\cpuz\cpuz.exe" -txt=cpu_info.txt
    type cpu_info.txt
) else (
    echo ⚠️ CPU-Z no encontrado
)

:: Monitoreo de memoria
if exist "C:\Tools\rammap\rammap.exe" (
    echo 🧠 Análisis de memoria:
    "C:\Tools\rammap\rammap.exe" -E
) else (
    echo ⚠️ RAMMap no encontrado
)

:: Monitoreo de disco
if exist "C:\Program Files\CrystalDiskInfo\DiskInfo.exe" (
    echo 💾 Estado de discos:
    "C:\Program Files\CrystalDiskInfo\DiskInfo.exe" /CopyExit
) else (
    echo ⚠️ CrystalDiskInfo no encontrado
)

echo.
pause 