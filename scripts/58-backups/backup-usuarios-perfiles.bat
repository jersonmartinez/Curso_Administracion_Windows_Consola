@echo off
REM Backup de usuarios y perfiles
set "backup_path=D:\Backups\Usuarios"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
echo Backup de usuarios y perfiles iniciado: %date% %time%
if not exist "%backup_path%\%fecha%" mkdir "%backup_path%\%fecha%"
for %%u in ("C:\Users\*") do (
    robocopy "%%u" "%backup_path%\%fecha%\%%~nxu" /E /XO /COPY:DAT /XD "AppData\Local\Temp" "AppData\Local\Microsoft\Windows\INetCache" /R:3 /W:10 /MT:8
)
wmic useraccount get name,description,disabled > "%backup_path%\%fecha%\usuarios_sistema.txt"
echo Backup de usuarios y perfiles completado
pause
