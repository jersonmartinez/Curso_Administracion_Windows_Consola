@echo off
REM Listar todas las credenciales almacenadas
set "log_file=credenciales_almacenadas.log"
echo Listado iniciado: %date% %time% > %log_file%
cmdkey /list >> %log_file%
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Credentials" >> %log_file%
certutil -store -user MY >> %log_file%
certutil -store MY >> %log_file%
echo Listado de credenciales completado >> %log_file%
echo Log guardado en: %log_file%
pause
