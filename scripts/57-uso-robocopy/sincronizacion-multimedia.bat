@echo off
echo ========================================
echo    SINCRONIZACION MULTIMEDIA
echo ========================================
echo.

REM Configuración multimedia
set "biblioteca_local=C:\Multimedia"
set "dispositivo_externo=E:\Multimedia"
set "tipos_archivo=*.mp4 *.avi *.mkv *.mp3 *.flac *.jpg *.png"

echo Sincronizando biblioteca multimedia...
echo Sincronizacion iniciada: %date% %time%

REM Sincronización optimizada para archivos grandes
robocopy "%biblioteca_local%" "%dispositivo_externo%" %tipos_archivo% /E /XO /COPY:DAT /MT:32 /R:3 /W:10 /LOG:multimedia_sync.log /TEE

REM Verificar espacio en dispositivo externo
for %%A in ("%dispositivo_externo%") do set "espacio=%%~zA"
echo Espacio disponible: %espacio% bytes

REM Limpiar archivos temporales
del /q "%biblioteca_local%\*.tmp" 2>nul
del /q "%dispositivo_externo%\*.tmp" 2>nul

echo Sincronizacion multimedia completada
pause
