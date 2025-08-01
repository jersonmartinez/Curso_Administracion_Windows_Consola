@echo off
REM Auditoría de credenciales almacenadas
set "log_file=auditoria_credenciales.log"
echo Auditoria iniciada: %date% %time% > %log_file%
cmdkey /list >> %log_file%
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Credentials" >> %log_file%
certutil -store -user MY | findstr "Expired" >> %log_file%
certutil -store MY | findstr "Expired" >> %log_file%
net accounts >> %log_file%
reg query "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" /v "PasswordHistory" >> %log_file%
echo Auditoria de credenciales completada >> %log_file%
echo Log guardado en: %log_file%
pause
