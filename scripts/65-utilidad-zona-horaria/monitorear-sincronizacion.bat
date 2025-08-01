@echo off
REM Monitorea la sincronización de tiempo en Windows
w32tm /query /status
w32tm /query /configuration
echo Monitoreo de sincronización completado
pause
