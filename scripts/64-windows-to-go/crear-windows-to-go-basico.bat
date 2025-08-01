@echo off
echo ========================================
echo    CREAR WINDOWS TO GO BASICO
echo ========================================
echo.

echo Creando Windows To Go basico...
echo Creacion iniciada: %date% %time%

REM Configuración
set "usb_drive=E:"
set "image_file=D:\Sources\install.wim"
set "image_index=1"

REM Verificar que el USB esté disponible
if not exist "%usb_drive%" (
    echo [ERROR] Unidad USB %usb_drive% no encontrada
    exit /b 1
)

REM Aplicar imagen de Windows
echo === APLICANDO IMAGEN DE WINDOWS ===
dism /apply-image /imagefile:"%image_file%" /index:%image_index% /applydir:%usb_drive% /checkintegrity

REM Crear configuración de arranque
echo === CREANDO CONFIGURACION DE ARRANQUE ===
bcdboot %usb_drive%\Windows /s %usb_drive% /f all

echo Windows To Go creado exitosamente en %usb_drive%
pause
