@echo off
REM Verifica servicios críticos de seguridad
set "log_file=servicios_criticos.log"
echo Verificacion iniciada: %date% %time% > %log_file%
set "servicios_criticos=wscsvc MpsSvc BFE SharedAccess"
echo === SERVICIOS CRITICOS DE SEGURIDAD === >> %log_file%
for %%s in (%servicios_criticos%) do (
    sc query %%s >> %log_file%
    echo. >> %log_file%
)
wmic service where "startname='LocalSystem'" get name,displayname,state >> %log_file%
wmic service where "startmode='Auto'" get name,displayname,state >> %log_file%
wmic service where "state='Stopped'" get name,displayname,startmode >> %log_file%
echo Verificacion de servicios completada >> %log_file%
echo Log guardado en: %log_file%
pause
