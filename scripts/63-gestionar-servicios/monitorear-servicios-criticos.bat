@echo off
REM Monitorea servicios críticos y toma acciones automáticas si fallan
set "servicios_criticos=spooler eventlog themes"
set "log_file=monitor_servicios_%date:~-4,4%%date:~-10,2%%date:~-7,2%.log"
echo Monitoreo de servicios criticos - %date% %time% > %log_file%
for %%s in (%servicios_criticos%) do (
    sc query %%s | findstr STATE > temp_state.txt
    findstr "RUNNING" temp_state.txt >nul
    if !errorlevel! neq 0 (
        echo [ALERTA] Servicio %%s no esta ejecutandose >> %log_file%
        sc start %%s
    ) else (
        echo [OK] Servicio %%s funcionando correctamente >> %log_file%
    )
    echo. >> %log_file%
)
del temp_state.txt
echo Monitoreo de servicios criticos completado
echo Log guardado en: %log_file%
pause
