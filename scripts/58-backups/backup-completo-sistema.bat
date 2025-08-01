@echo off
REM Backup completo del sistema usando WBADMIN
set "backup_target=D:"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "log_file=backup_sistema_%fecha%.log"
echo Iniciando backup completo del sistema...
echo Backup iniciado: %date% %time% > %log_file%
wbadmin start backup -backupTarget:%backup_target% -include:C: -allCritical -quiet >> %log_file% 2>&1
if %errorlevel%==0 (
    echo [EXITO] Backup del sistema completado
    echo Backup guardado en: %backup_target%
) else (
    echo [ERROR] Error en backup del sistema
    echo Revisar log: %log_file%
)
pause
