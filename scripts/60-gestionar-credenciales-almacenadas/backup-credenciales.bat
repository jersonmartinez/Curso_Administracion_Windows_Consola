@echo off
REM Backup de credenciales almacenadas
set "backup_dir=D:\Backups\Credenciales"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "log_file=backup_credenciales.log"
echo Backup iniciado: %date% %time% > %log_file%
if not exist "%backup_dir%\%fecha%" mkdir "%backup_dir%\%fecha%"
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Credentials" "%backup_dir%\%fecha%\credenciales.reg" /y >> %log_file%
certutil -store -user MY "%backup_dir%\%fecha%\certificados_usuario.txt" >> %log_file%
certutil -store MY "%backup_dir%\%fecha%\certificados_sistema.txt" >> %log_file%
cmdkey /list > "%backup_dir%\%fecha%\credenciales_lista.txt" 2>&1
echo RESUMEN DE BACKUP > "%backup_dir%\%fecha%\resumen.txt"
echo Fecha: %date% %time% >> "%backup_dir%\%fecha%\resumen.txt"
echo Usuario: %USERNAME% >> "%backup_dir%\%fecha%\resumen.txt"
echo Sistema: %COMPUTERNAME% >> "%backup_dir%\%fecha%\resumen.txt"
echo Backup de credenciales completado >> %log_file%
echo Log guardado en: %log_file%
pause
