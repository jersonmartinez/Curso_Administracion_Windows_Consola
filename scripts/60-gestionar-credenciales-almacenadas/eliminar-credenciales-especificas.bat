@echo off
REM Eliminar credenciales específicas
set "servidor=servidor-antiguo"
set "log_file=eliminar_credenciales.log"
echo Eliminar credenciales iniciado: %date% %time% > %log_file%
cmdkey /list | findstr %servidor% >> %log_file%
if %errorlevel%==0 (
    cmdkey /delete:%servidor% >> %log_file% 2>&1
    cmdkey /list | findstr %servidor% >> %log_file%
    if %errorlevel%==1 (
        echo [EXITO] Credenciales eliminadas correctamente
    ) else (
        echo [ERROR] Error al eliminar credenciales
    )
) else (
    echo [INFO] No se encontraron credenciales para eliminar
)
echo Eliminar credenciales completado >> %log_file%
echo Log guardado en: %log_file%
pause
