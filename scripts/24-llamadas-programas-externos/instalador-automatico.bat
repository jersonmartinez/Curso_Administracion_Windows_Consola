@echo off
:: Instalador automático de software
title 🚀 Instalador Automático
color 0A

echo ========================================
echo    🚀 INSTALADOR AUTOMÁTICO DE SOFTWARE
echo ========================================
echo.

:: Instalar Chrome
echo 🔄 Instalando Google Chrome...
start /wait "" "C:\Instaladores\chrome_installer.exe" /silent /install

if %errorlevel%==0 (
    echo ✅ Chrome instalado exitosamente
) else (
    echo ❌ Error al instalar Chrome
)

:: Instalar 7-Zip
echo 🔄 Instalando 7-Zip...
start /wait "" "C:\Instaladores\7z1900-x64.exe" /S

if %errorlevel%==0 (
    echo ✅ 7-Zip instalado exitosamente
) else (
    echo ❌ Error al instalar 7-Zip
)

:: Instalar Notepad++
echo 🔄 Instalando Notepad++...
start /wait "" "C:\Instaladores\npp.8.4.2.Installer.x64.exe" /S

if %errorlevel%==0 (
    echo ✅ Notepad++ instalado exitosamente
) else (
    echo ❌ Error al instalar Notepad++
)

echo.
echo 🎉 Instalación completada.
pause 