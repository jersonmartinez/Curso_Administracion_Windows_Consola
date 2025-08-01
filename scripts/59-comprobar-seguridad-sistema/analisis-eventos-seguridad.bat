@echo off
REM Analiza eventos de seguridad del sistema
set "log_file=eventos_seguridad.log"
echo Analisis iniciado: %date% %time% > %log_file%
wevtutil qe Security /c:100 /f:text >> %log_file%
wevtutil qe Security /q:"*[System[EventID=4625]]" /c:50 /f:text >> %log_file%
wevtutil qe Security /q:"*[System[EventID=4672]]" /c:50 /f:text >> %log_file%
wevtutil qe Security /q:"*[System[EventID=4723]]" /c:50 /f:text >> %log_file%
echo Analisis de eventos completado >> %log_file%
echo Log guardado en: %log_file%
pause
