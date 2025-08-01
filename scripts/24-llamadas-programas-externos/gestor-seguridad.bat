@echo off
:: Gestor de herramientas de seguridad
title 🛡️ Gestor de Seguridad
color 0A

echo ========================================
echo    🛡️ GESTOR DE HERRAMIENTAS DE SEGURIDAD
echo ========================================
echo.

:: Escaneo con antivirus externo
if exist "C:\Program Files\Avast Software\Avast\ashCmd.exe" (
    echo 🔍 Escaneando sistema con Avast...
    "C:\Program Files\Avast Software\Avast\ashCmd.exe" /scan C:\ /report
) else (
    echo ⚠️ Avast no encontrado
)

:: Análisis con herramientas de malware
if exist "C:\Tools\malwarebytes\mbam.exe" (
    echo 🦠 Escaneando con Malwarebytes...
    "C:\Tools\malwarebytes\mbam.exe" /scan
) else (
    echo ⚠️ Malwarebytes no encontrado
)

:: Análisis de archivos sospechosos
if exist "C:\Tools\peid\PEiD.exe" (
    echo 🔍 Analizando archivos ejecutables...
    "C:\Tools\peid\PEiD.exe" C:\Windows\System32\*.exe
) else (
    echo ⚠️ PEiD no encontrado
)

echo.
pause 