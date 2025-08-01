@echo off
echo ========================================
echo    SINCRONIZACION DE SERVIDOR WEB
echo ========================================
echo.

REM Configuración de servidores
set "servidor_dev=\\dev-server\wwwroot"
set "servidor_prod=\\prod-server\wwwroot"
set "archivos_excluir=*.tmp *.log *.bak"

echo Sincronizando servidor de desarrollo con produccion...
echo Sincronizacion iniciada: %date% %time%

REM Sincronización inteligente
robocopy "%servidor_dev%" "%servidor_prod%" /E /MIR /XF %archivos_excluir% /XD "temp" "logs" /R:5 /W:15 /MT:16 /LOG:web_sync.log /TEE

REM Verificar resultado y enviar notificación
if %errorlevel% leq 7 (
    echo [EXITO] Sincronizacion completada
    echo Enviando notificacion de exito...
    msg administrador "Sincronizacion web completada exitosamente"
) else (
    echo [ERROR] Errores en sincronizacion
    echo Enviando alerta...
    msg administrador "ERROR: Problemas en sincronizacion web"
)

echo Sincronizacion finalizada: %date% %time%
pause
