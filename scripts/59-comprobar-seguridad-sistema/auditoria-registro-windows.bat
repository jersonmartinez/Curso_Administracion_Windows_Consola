@echo off
REM Audita configuraciones del registro de Windows
set "log_file=registro_auditoria.log"
echo Auditoria iniciada: %date% %time% > %log_file%
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" >> %log_file%
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" >> %log_file%
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" >> %log_file%
reg query "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy" >> %log_file%
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Audit" >> %log_file%
echo Auditoria del registro completada >> %log_file%
echo Log guardado en: %log_file%
pause
