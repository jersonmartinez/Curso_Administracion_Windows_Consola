@echo off
REM Verifica la integridad de archivos críticos del sistema
set "log_file=archivos_sistema.log"
echo Verificacion iniciada: %date% %time% > %log_file%
sfc /scannow >> %log_file%
for %%f in (kernel32.dll ntdll.dll user32.dll) do (
    certutil -hashfile "C:\Windows\System32\%%f" SHA256 >> %log_file%
)
for %%f in (hosts services) do (
    if exist "C:\Windows\System32\drivers\etc\%%f" (
        certutil -hashfile "C:\Windows\System32\drivers\etc\%%f" MD5 >> %log_file%
    )
)
echo Verificacion de archivos completada >> %log_file%
echo Log guardado en: %log_file%
pause
