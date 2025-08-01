@echo off
REM Audita usuarios y permisos del sistema
set "log_file=auditoria_usuarios.log"
echo Auditoria iniciada: %date% %time% > %log_file%
wmic useraccount get name,description,disabled,lockout >> %log_file%
net localgroup administrators >> %log_file%
wmic service get name,startname,state >> %log_file%
net accounts >> %log_file%
wmic useraccount where "lockout=true" get name >> %log_file%
echo Auditoria de usuarios completada >> %log_file%
echo Log guardado en: %log_file%
pause
