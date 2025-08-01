@echo off
REM Restaurar credenciales desde backup
set "backup_dir=D:\Backups\Credenciales"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "log_file=restaurar_credenciales.log"
echo Restauracion iniciada: %date% %time% > %log_file%
if exist "%backup_dir%\%fecha%" (
    if exist "%backup_dir%\%fecha%\credenciales.reg" (
        reg import "%backup_dir%\%fecha%\credenciales.reg" >> %log_file% 2>&1
    )
    if exist "%backup_dir%\%fecha%\certificados_usuario.txt" (
        certutil -store -user MY "%backup_dir%\%fecha%\certificados_usuario.txt" >> %log_file% 2>&1
    )
    echo [EXITO] Restauracion de credenciales completada
) else (
    echo [ERROR] Backup no encontrado: %backup_dir%\%fecha%
)
echo Restauracion de credenciales completada >> %log_file%
echo Log guardado en: %log_file%
pause
