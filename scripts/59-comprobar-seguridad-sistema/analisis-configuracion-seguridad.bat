@echo off
REM Analiza la configuración de seguridad del sistema
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "log_file=analisis_seguridad_%fecha%.log"
echo Analisis iniciado: %date% %time% > %log_file%
secedit /analyze /db %WINDIR%\security\database\secedit.sdb /cfg %WINDIR%\inf\defltbase.inf /log %log_file%
auditpol /get /category:* >> %log_file%
netsh advfirewall show allprofiles >> %log_file%
echo Analisis de seguridad completado >> %log_file%
echo Log guardado en: %log_file%
pause
