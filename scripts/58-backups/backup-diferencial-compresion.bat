@echo off
REM Backup diferencial con compresión usando Robocopy y PowerShell
set "origen=C:\Proyectos"
set "backup_base=D:\Backups\Diferencial"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
echo Creando backup diferencial...
echo Backup diferencial iniciado: %date% %time%
if not exist "%backup_base%\%fecha%" mkdir "%backup_base%\%fecha%"
robocopy "%origen%" "%backup_base%\%fecha%" /E /XO /COPY:DAT /COMPRESS /R:5 /W:15 /MT:16 /LOG:diferencial_%fecha%.log /TEE
powershell -Command "Compress-Archive -Path '%backup_base%\%fecha%' -DestinationPath '%backup_base%\%fecha%.zip' -Force"
rmdir /s /q "%backup_base%\%fecha%"
echo Backup diferencial comprimido completado
pause
