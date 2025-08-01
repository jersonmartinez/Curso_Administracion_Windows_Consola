@echo off
echo ========================================
echo    CONFIGURAR ARRANQUE DUAL
echo ========================================
echo.

echo Configurando arranque dual...
echo Configuracion iniciada: %date% %time%

REM Configuración
set "usb_drive=E:"
set "windows_path=%usb_drive%\Windows"

REM Crear configuración de arranque principal
echo === CONFIGURANDO ARRANQUE PRINCIPAL ===
bcdboot %windows_path% /s %usb_drive% /f all

REM Configurar opciones de arranque
echo === CONFIGURANDO OPCIONES DE ARRANQUE ===
bcdedit /store %usb_drive%\boot\bcd /set {bootmgr} timeout 10
bcdedit /store %usb_drive%\boot\bcd /set {bootmgr} displaybootmenu yes

echo Arranque dual configurado exitosamente
pause
