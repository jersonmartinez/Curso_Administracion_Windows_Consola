@echo off
REM Backup incremental de archivos usando Robocopy
set "origen=C:\Datos_Importantes"
set "destino=D:\Backups\Incremental"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
echo Creando backup incremental...
echo Backup incremental iniciado: %date% %time%
if not exist "%destino%\%fecha%" mkdir "%destino%\%fecha%"
robocopy "%origen%" "%destino%\%fecha%" /E /XO /COPY:DAT /R:3 /W:10 /MT:8 /LOG:incremental_%fecha%.log /TEE
echo %date% %time% > "%destino%\%fecha%\backup_marker.txt"
echo Backup incremental completado
pause
