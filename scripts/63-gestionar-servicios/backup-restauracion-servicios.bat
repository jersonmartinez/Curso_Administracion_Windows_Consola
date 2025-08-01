@echo off
REM Backup y restauración de servicios críticos
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "backup_dir=C:\Backups\Servicios\%fecha%"
set "servicios_backup=spooler eventlog themes"
if not exist "%backup_dir%" mkdir "%backup_dir%"
echo @echo off > "%backup_dir%\restaurar_servicios.bat"
echo echo Restaurando configuracion de servicios... >> "%backup_dir%\restaurar_servicios.bat"
echo echo Restauracion iniciada: %%date%% %%time%% >> "%backup_dir%\restaurar_servicios.bat"
for %%s in (%servicios_backup%) do (
    sc qc %%s > "%backup_dir%\%%s_config.txt"
    sc enumdepend %%s > "%backup_dir%\%%s_dependencias.txt" 2>&1
    echo echo Restaurando %%s... >> "%backup_dir%\restaurar_servicios.bat"
    echo sc config %%s start= auto >> "%backup_dir%\restaurar_servicios.bat"
    echo sc start %%s >> "%backup_dir%\restaurar_servicios.bat"
    echo. >> "%backup_dir%\restaurar_servicios.bat"
)
echo BACKUP DE SERVICIOS > "%backup_dir%\info_backup.txt"
echo ======================================== >> "%backup_dir%\info_backup.txt"
echo Fecha: %date% %time% >> "%backup_dir%\info_backup.txt"
echo Sistema: %COMPUTERNAME% >> "%backup_dir%\info_backup.txt"
echo Usuario: %USERNAME% >> "%backup_dir%\info_backup.txt"
echo. >> "%backup_dir%\info_backup.txt"
echo Servicios incluidos: >> "%backup_dir%\info_backup.txt"
for %%s in (%servicios_backup%) do (
    echo - %%s >> "%backup_dir%\info_backup.txt"
)
echo Backup de servicios completado
echo Backup guardado en: %backup_dir%
pause
