@echo off
setlocal enabledelayedexpansion
title AUDITORIA COMPLETA DE SEGURIDAD
set "log_dir=C:\Logs\Seguridad"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
if not exist "%log_dir%" mkdir "%log_dir%"
REM Menú principal omitido para script directo
REM Ejecución de todas las auditorías
set "log_file=!log_dir!\auditoria_completa_!fecha!.log"
echo Auditoria completa iniciada: %date% %time% > !log_file!
secedit /analyze /db %WINDIR%\security\database\secedit.sdb /cfg %WINDIR%\inf\defltbase.inf /log temp_secedit.log
type temp_secedit.log >> !log_file!
del temp_secedit.log
powershell -Command "Get-MpComputerStatus | Format-List" >> !log_file!
wmic useraccount get name,description,disabled,lockout >> !log_file!
net localgroup administrators >> !log_file!
for %%s in (wscsvc MpsSvc BFE SharedAccess) do (
    sc query %%s >> !log_file!
)
netstat -an | findstr LISTENING >> !log_file!
wmic qfe list brief >> !log_file!
reg query "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" >> !log_file!
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" >> !log_file!
sfc /scannow >> !log_file!
wevtutil qe Security /c:100 /f:text >> !log_file!
ipconfig /all >> !log_file!
netsh advfirewall show allprofiles >> !log_file!
echo Auditoria completa finalizada: %date% %time% >> !log_file!
echo Auditoria completa completada
pause
