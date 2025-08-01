@echo off
echo ========================================
echo    MIGRACION DE DATOS CON VERIFICACION
echo ========================================
echo.

REM Configuración de migración
set "servidor_antiguo=\\old-server\datos"
set "servidor_nuevo=\\new-server\datos"
set "log_migracion=migracion_datos.log"

echo Iniciando migracion de datos...
echo Migracion iniciada: %date% %time% > %log_migracion%

REM Fase 1: Copia inicial
echo FASE 1: Copia inicial de datos... >> %log_migracion%
robocopy "%servidor_antiguo%" "%servidor_nuevo%" /E /COPY:DAT /R:5 /W:30 /MT:16 /LOG+:%log_migracion% /TEE

REM Fase 2: Verificación de integridad
echo FASE 2: Verificacion de integridad... >> %log_migracion%
robocopy "%servidor_antiguo%" "%servidor_nuevo%" /E /COPY:DAT /L /LOG+:%log_migracion%

REM Fase 3: Sincronización final
echo FASE 3: Sincronizacion final... >> %log_migracion%
robocopy "%servidor_antiguo%" "%servidor_nuevo%" /E /COPY:DAT /R:3 /W:10 /MT:8 /LOG+:%log_migracion% /TEE

REM Generar reporte de migración
echo REPORTE DE MIGRACION >> %log_migracion%
echo ======================================== >> %log_migracion%
echo Fecha: %date% %time% >> %log_migracion%
echo Origen: %servidor_antiguo% >> %log_migracion%
echo Destino: %servidor_nuevo% >> %log_migracion%

echo Migracion completada. Revisar log: %log_migracion%
pause
