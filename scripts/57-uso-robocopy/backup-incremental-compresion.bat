@echo off
echo ========================================
echo    BACKUP INCREMENTAL CON COMPRESION
echo ========================================
echo.

REM Configuración del backup
set "origen=C:\Datos_Empresa"
set "destino=\\backup-server\backups"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "log_file=backup_%fecha%.log"

echo Iniciando backup incremental...
echo Backup iniciado: %date% %time% > %log_file%

REM Crear directorio de backup con fecha
if not exist "%destino%\%fecha%" mkdir "%destino%\%fecha%"

REM Backup incremental con compresión
robocopy "%origen%" "%destino%\%fecha%" /E /XO /COPY:DAT /COMPRESS /R:3 /W:10 /MT:8 /LOG+:%log_file% /TEE

REM Verificar espacio en disco después del backup
for %%A in ("%destino%") do set "espacio_libre=%%~zA"
echo Espacio libre en destino: %espacio_libre% bytes >> %log_file%

REM Limpiar backups antiguos (más de 30 días)
forfiles /p "%destino%" /d -30 /c "cmd /c if @isdir==TRUE rmdir /s /q @path" 2>nul

echo Backup incremental completado: %date% %time%
echo Log guardado en: %log_file%
pause
