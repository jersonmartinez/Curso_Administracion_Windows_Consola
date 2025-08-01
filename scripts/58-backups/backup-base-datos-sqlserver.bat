@echo off
REM Backup de base de datos SQL Server con verificación de integridad
set "sql_server=localhost"
set "database=MiBaseDatos"
set "backup_path=D:\Backups\SQL"
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
echo Creando backup de base de datos...
echo Backup de BD iniciado: %date% %time%
if not exist "%backup_path%\%fecha%" mkdir "%backup_path%\%fecha%"
REM Backup completo de la base de datos
sqlcmd -S %sql_server% -Q "BACKUP DATABASE [%database%] TO DISK = '%backup_path%\%fecha%\%database%_%fecha%.bak' WITH COMPRESSION, CHECKSUM"
REM Verificar integridad del backup
sqlcmd -S %sql_server% -Q "RESTORE VERIFYONLY FROM DISK = '%backup_path%\%fecha%\%database%_%fecha%.bak'"
if %errorlevel%==0 (
    echo [EXITO] Backup de base de datos completado y verificado
) else (
    echo [ERROR] Error en backup de base de datos
)
echo Backup de base de datos finalizado
pause
