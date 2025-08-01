@echo off
REM Optimiza servicios del sistema, configurando críticos y deshabilitando innecesarios
set "servicios_criticos=spooler eventlog themes"
set "servicios_optimizables=themes"
set "backup_file=backup_servicios_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
echo Backup de servicios - %date% %time% > %backup_file%
for %%s in (%servicios_criticos%) do (
    sc qc %%s >> %backup_file%
    echo. >> %backup_file%
)
for %%s in (%servicios_criticos%) do (
    sc config %%s start= auto
)
for %%s in (%servicios_optimizables%) do (
    sc config %%s start= demand
)
for %%s in (%servicios_criticos%) do (
    sc start %%s
)
echo. 
for %%s in (%servicios_criticos%) do (
    sc query %%s | findstr STATE
)
echo Optimizacion de servicios completada
echo Backup guardado en: %backup_file%
pause
