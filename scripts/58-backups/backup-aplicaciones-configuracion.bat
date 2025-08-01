@echo off
REM Backup de aplicaciones y configuraciones
set "backup_path=D:\Backups\Aplicaciones"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
echo Backup de aplicaciones iniciado: %date% %time%
if not exist "%backup_path%\%fecha%" mkdir "%backup_path%\%fecha%"
robocopy "C:\ProgramData" "%backup_path%\%fecha%\ProgramData" /E /XO /COPY:DAT /R:3 /W:10 /MT:8
robocopy "%APPDATA%" "%backup_path%\%fecha%\AppData\Roaming" /E /XO /COPY:DAT /R:3 /W:10 /MT:8
robocopy "%LOCALAPPDATA%" "%backup_path%\%fecha%\AppData\Local" /E /XO /COPY:DAT /XD "Temp" "Cache" /R:3 /W:10 /MT:8
echo Backup de aplicaciones completado
pause
