@echo off
REM Backup automatizado con programación
set "backup_path=D:\Backups\Automatizado"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "log_file=backup_automatizado_%fecha%.log"
echo Backup automatizado iniciado: %date% %time% > %log_file%
robocopy "C:\Users\%USERNAME%\Documents" "%backup_path%\%fecha%\Documents" /E /XO /COPY:DAT /R:3 /W:10 /MT:8 /LOG+:%log_file%
robocopy "C:\Users\%USERNAME%\Pictures" "%backup_path%\%fecha%\Pictures" /E /XO /COPY:DAT /R:3 /W:10 /MT:8 /LOG+:%log_file%
reg export HKCU "%backup_path%\%fecha%\HKCU.reg" /y >> %log_file% 2>&1
forfiles /p "%backup_path%" /d -30 /c "cmd /c if @isdir==TRUE rmdir /s /q @path" 2>nul
echo Backup automatizado completado
pause
