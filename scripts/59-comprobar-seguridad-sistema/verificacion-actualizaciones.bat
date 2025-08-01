@echo off
REM Verifica el estado de las actualizaciones del sistema
set "log_file=actualizaciones.log"
echo Verificacion iniciada: %date% %time% > %log_file%
wmic qfe list brief >> %log_file%
powershell -Command "Get-HotFix | Sort-Object -Property InstalledOn -Descending | Select-Object -First 10" >> %log_file%
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" >> %log_file%
sc query wuauserv >> %log_file%
sc query bits >> %log_file%
echo Verificacion de actualizaciones completada >> %log_file%
echo Log guardado en: %log_file%
pause
