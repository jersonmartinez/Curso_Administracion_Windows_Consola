@echo off
REM Limpiar credenciales y certificados expirados
set "log_file=limpiar_credenciales.log"
echo Limpieza iniciada: %date% %time% > %log_file%
certutil -store -user MY | findstr "Expired" >> %log_file%
certutil -store MY | findstr "Expired" >> %log_file%
for /f "tokens=*" %%c in ('certutil -store -user MY ^| findstr "Expired"') do (
    certutil -delstore -user MY "%%c" >> %log_file% 2>&1
)
for /f "tokens=*" %%c in ('certutil -store MY ^| findstr "Expired"') do (
    certutil -delstore MY "%%c" >> %log_file% 2>&1
)
echo Limpieza de credenciales completada >> %log_file%
echo Log guardado en: %log_file%
pause
