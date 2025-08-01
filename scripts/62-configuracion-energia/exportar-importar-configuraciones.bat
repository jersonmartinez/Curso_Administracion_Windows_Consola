@echo off
echo ========================================
echo    EXPORTAR E IMPORTAR CONFIGURACIONES
echo ========================================
echo.

echo Exportando e importando configuraciones...
echo Proceso iniciado: %date% %time%

REM Configuración
set "fecha=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "backup_dir=C:\Backups\Energia"

REM Crear directorio de backup
if not exist "%backup_dir%" mkdir "%backup_dir%"

REM Exportar todos los planes de energía
echo === EXPORTANDO PLANES DE ENERGIA ===
for /f "tokens=2 delims=:" %%i in ('powercfg /list') do (
    if not "%%i"=="" (
        powercfg /export "%backup_dir%\plan_%%i_%fecha%.pow" %%i
    )
)

REM Exportar configuración actual
echo === EXPORTANDO CONFIGURACION ACTUAL ===
for /f "tokens=2 delims=:" %%i in ('powercfg /getactivescheme') do (
    powercfg /export "%backup_dir%\configuracion_actual_%fecha%.pow" %%i
)

REM Crear script de restauración
echo @echo off > "%backup_dir%\restaurar_energia.bat"
echo echo Restaurando configuracion de energia... >> "%backup_dir%\restaurar_energia.bat"
echo powercfg /import "%backup_dir%\configuracion_actual_%fecha%.pow" >> "%backup_dir%\restaurar_energia.bat"

echo Configuraciones exportadas a: %backup_dir%
pause
