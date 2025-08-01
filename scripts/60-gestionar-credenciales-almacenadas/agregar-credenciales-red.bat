@echo off
REM Agregar credenciales de red
set "servidor=servidor-empresa"
set "usuario=usuario_red"
set "log_file=agregar_credenciales.log"
echo Agregar credenciales iniciado: %date% %time% > %log_file%
set /p password="Ingrese la contraseña: "
cmdkey /add:%servidor% /user:%usuario% /pass:%password% >> %log_file% 2>&1
cmdkey /list | findstr %servidor% >> %log_file%
if %errorlevel%==0 (
    echo [EXITO] Credenciales agregadas correctamente
) else (
    echo [ERROR] Error al agregar credenciales
)
echo Agregar credenciales completado >> %log_file%
echo Log guardado en: %log_file%
pause
