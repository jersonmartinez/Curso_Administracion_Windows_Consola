@echo off
REM Verifica el estado y configuración de Windows Defender
set "log_file=defender_status.log"
echo Verificacion iniciada: %date% %time% > %log_file%
powershell -Command "Get-MpComputerStatus | Select-Object AntivirusEnabled, RealTimeProtectionEnabled, BehaviorMonitorEnabled, OnAccessProtectionEnabled, IoavProtectionEnabled | Format-List" >> %log_file%
powershell -Command "Get-MpThreatDetection | Select-Object ThreatID, ThreatName, InitialDetectionTime | Format-Table" >> %log_file%
powershell -Command "Get-MpThreatDetection | Measure-Object | Select-Object Count" >> %log_file%
powershell -Command "Get-MpPreference | Select-Object ExclusionPath, ExclusionProcess, ExclusionExtension" >> %log_file%
echo Verificacion de Windows Defender completada >> %log_file%
echo Log guardado en: %log_file%
pause
