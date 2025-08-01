@echo off
REM Verifica configuraciones de red
set "log_file=configuracion_red.log"
echo Verificacion iniciada: %date% %time% > %log_file%
ipconfig /all >> %log_file%
nslookup google.com >> %log_file%
netsh advfirewall show allprofiles >> %log_file%
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" >> %log_file%
net share >> %log_file%
echo Verificacion de red completada >> %log_file%
echo Log guardado en: %log_file%
pause
