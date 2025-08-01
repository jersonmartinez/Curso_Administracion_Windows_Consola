@echo off
echo ========================================
echo    SINCRONIZAR RELOJ DEL SISTEMA
echo ========================================
echo.

echo Sincronizando reloj del sistema...
echo Sincronizacion iniciada: %date% %time%

REM Verificar estado del servicio de tiempo
echo === ESTADO DEL SERVICIO DE TIEMPO ===
w32tm /query /status

REM Configurar servidor de tiempo
echo.
echo === CONFIGURANDO SERVIDOR DE TIEMPO ===
w32tm /config /manualpeerlist:"time.windows.com,0x8 time.nist.gov,0x8" /syncfromflags:manual /reliable:yes /update

REM Iniciar servicio de tiempo
echo.
echo === INICIANDO SERVICIO DE TIEMPO ===
net start w32time

REM Forzar sincronización
echo.
echo === FORZANDO SINCRONIZACION ===
w32tm /resync /force

REM Verificar sincronización
echo.
echo === VERIFICANDO SINCRONIZACION ===
w32tm /query /status

echo Sincronizacion del reloj completada
pause
