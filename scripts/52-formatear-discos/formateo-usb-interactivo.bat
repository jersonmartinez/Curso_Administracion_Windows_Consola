@echo off
REM Formateo para dispositivos USB con selección de sistema de archivos

echo 📱 FORMATEO PARA DISPOSITIVOS USB (INTERACTIVO)
echo =================================================
echo [1] FAT32 (Máxima compatibilidad)
echo [2] exFAT (Archivos grandes)
echo [3] NTFS (Windows)
set /p tipo_usb="Selecciona tipo de formateo: "
set /p unidad="Letra de unidad USB (ej: F): "
set /p etiqueta="Etiqueta del volumen (ej: USB_DATOS): "

if "%tipo_usb%"=="1" (
    echo 📱 Formateando con FAT32...
    format %unidad%: /FS:FAT32 /Q /V:%etiqueta% /Y
) else if "%tipo_usb%"=="2" (
    echo 📱 Formateando con exFAT...
    format %unidad%: /FS:exFAT /Q /V:%etiqueta% /Y
) else if "%tipo_usb%"=="3" (
    echo 📱 Formateando con NTFS...
    format %unidad%: /FS:NTFS /Q /V:%etiqueta% /Y
)

echo ✅ Formateo USB completado
echo.
pause
