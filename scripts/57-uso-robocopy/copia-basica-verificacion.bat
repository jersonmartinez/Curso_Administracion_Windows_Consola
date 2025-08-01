@echo off
echo ========================================
echo    COPIA BASICA CON VERIFICACION
echo ========================================
echo.

REM Configuración de la copia
set "origen=C:\Documentos_Importantes"
set "destino=D:\Backup_Documentos"
set "log_file=robocopy_log_%date:~-4,4%%date:~-10,2%%date:~-7,2%.log"

echo Iniciando copia de %origen% a %destino%...
echo Copia iniciada: %date% %time% > %log_file%

REM Ejecutar Robocopy con opciones robustas
robocopy "%origen%" "%destino%" /E /COPY:DAT /R:3 /W:10 /MT:8 /LOG+:%log_file% /TEE

REM Verificar el resultado
if %errorlevel% leq 7 (
    echo.
    echo [EXITO] Copia completada exitosamente
    echo Archivos copiados: %errorlevel%
    echo Log guardado en: %log_file%
) else (
    echo.
    echo [ERROR] Errores durante la copia
    echo Codigo de error: %errorlevel%
    echo Revisar log: %log_file%
)

echo.
echo Resumen de la operacion:
echo ========================================
type %log_file% | findstr /C:"Files :" /C:"Dirs :" /C:"Bytes :"
pause
