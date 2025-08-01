@echo off
REM Analiza puertos abiertos y conexiones de red
set "log_file=puertos_conexiones.log"
echo Analisis iniciado: %date% %time% > %log_file%
netstat -an | findstr LISTENING >> %log_file%
netstat -an | findstr ESTABLISHED >> %log_file%
netstat -ano | findstr LISTENING >> %log_file%
for %%p in (21 22 23 25 53 80 443 3389) do (
    netstat -ano | findstr :%%p >> %log_file%
)
netstat -an | findstr /C:"0.0.0.0" /C:"127.0.0.1" >> %log_file%
echo Analisis de puertos completado >> %log_file%
echo Log guardado en: %log_file%
pause
