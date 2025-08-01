@echo off
setlocal enabledelayedexpansion
title Gestión Avanzada de Tareas Programadas
color 0E

echo.
echo ========================================
echo    GESTIÓN AVANZADA DE TAREAS PROGRAMADAS
echo ========================================
echo.

:menu_principal
echo [1] Crear nueva tarea
echo [2] Listar tareas existentes
echo [3] Ejecutar tarea
echo [4] Eliminar tarea
echo [5] Modificar tarea
echo [6] Crear tarea de backup automático
echo [7] Crear tarea de limpieza
echo [8] Crear tarea de monitoreo
echo [9] Exportar configuración
echo [10] Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto crear_tarea
if "%opcion%"=="2" goto listar_tareas
if "%opcion%"=="3" goto ejecutar_tarea
if "%opcion%"=="4" goto eliminar_tarea
if "%opcion%"=="5" goto modificar_tarea
if "%opcion%"=="6" goto tarea_backup
if "%opcion%"=="7" goto tarea_limpieza
if "%opcion%"=="8" goto tarea_monitoreo
if "%opcion%"=="9" goto exportar_config
if "%opcion%"=="10" goto salir
goto menu_principal

:crear_tarea
echo.
set /p nombre="Nombre de la tarea: "
set /p comando="Comando a ejecutar: "
set /p frecuencia="Frecuencia (daily/weekly/monthly/onstart): "
set /p hora="Hora (HH:MM): "
set /p usuario="Usuario (opcional): "

if "%usuario%"=="" (
    schtasks /create /tn "%nombre%" /tr "%comando%" /sc %frecuencia% /st %hora%
) else (
    set /p contraseña="Contraseña: "
    schtasks /create /tn "%nombre%" /tr "%comando%" /sc %frecuencia% /st %hora% /ru "%usuario%" /rp "%contraseña%"
)

echo Tarea creada exitosamente.
pause
goto menu_principal

:listar_tareas
echo.
echo Tareas programadas en el sistema:
echo ----------------------------------------
schtasks /query /fo table
echo.
pause
goto menu_principal

:ejecutar_tarea
echo.
set /p nombre="Nombre de la tarea: "
echo.
echo Ejecutando tarea %nombre%...
schtasks /run /tn "%nombre%"
echo Tarea ejecutada.
pause
goto menu_principal

:eliminar_tarea
echo.
set /p nombre="Nombre de la tarea a eliminar: "
echo.
echo Eliminando tarea %nombre%...
schtasks /delete /tn "%nombre%" /f
echo Tarea eliminada.
pause
goto menu_principal

:modificar_tarea
echo.
set /p nombre="Nombre de la tarea a modificar: "
set /p nuevo_comando="Nuevo comando: "
echo.
echo Modificando tarea %nombre%...
schtasks /change /tn "%nombre%" /tr "%nuevo_comando%"
echo Tarea modificada.
pause
goto menu_principal

:tarea_backup
echo.
set /p nombre="Nombre de la tarea de backup: "
set /p origen="Directorio origen: "
set /p destino="Directorio destino: "
set /p hora="Hora de backup (HH:MM): "

:: Crear script de backup
echo @echo off > "backup_%nombre%.bat"
echo echo Iniciando backup... >> "backup_%nombre%.bat"
echo robocopy "%origen%" "%destino%" /MIR /R:3 /W:10 /LOG:backup_%nombre%.log >> "backup_%nombre%.bat"
echo echo Backup completado. >> "backup_%nombre%.bat"

:: Crear tarea programada
schtasks /create /tn "%nombre%" /tr "%~dp0backup_%nombre%.bat" /sc daily /st %hora%

echo Tarea de backup creada: %nombre%
echo Script generado: backup_%nombre%.bat
pause
goto menu_principal

:tarea_limpieza
echo.
set /p nombre="Nombre de la tarea de limpieza: "
set /p directorio="Directorio a limpiar: "
set /p dias="Archivos más antiguos que (días): "

:: Crear script de limpieza
echo @echo off > "limpieza_%nombre%.bat"
echo echo Iniciando limpieza... >> "limpieza_%nombre%.bat"
echo forfiles /p "%directorio%" /s /m *.* /d -%dias% /c "cmd /c del @path" >> "limpieza_%nombre%.bat"
echo echo Limpieza completada. >> "limpieza_%nombre%.bat"

:: Crear tarea programada
schtasks /create /tn "%nombre%" /tr "%~dp0limpieza_%nombre%.bat" /sc weekly /d SUN /st "01:00"

echo Tarea de limpieza creada: %nombre%
echo Script generado: limpieza_%nombre%.bat
pause
goto menu_principal

:tarea_monitoreo
echo.
set /p nombre="Nombre de la tarea de monitoreo: "
set /p intervalo="Intervalo (minutos): "

:: Crear script de monitoreo
echo @echo off > "monitor_%nombre%.bat"
echo echo Monitoreando sistema... >> "monitor_%nombre%.bat"
echo systeminfo ^| findstr /C:"Total Physical Memory" /C:"Available Physical Memory" >> "monitor_%nombre%.bat"
echo tasklist ^| findstr /C:"chrome.exe" /C:"firefox.exe" >> "monitor_%nombre%.bat"
echo echo Monitoreo completado. >> "monitor_%nombre%.bat"

:: Crear tarea programada
schtasks /create /tn "%nombre%" /tr "%~dp0monitor_%nombre%.bat" /sc minute /mo %intervalo%

echo Tarea de monitoreo creada: %nombre%
echo Script generado: monitor_%nombre%.bat
pause
goto menu_principal

:exportar_config
echo.
set /p archivo="Nombre del archivo de exportación: "
echo.
echo Exportando configuración de tareas...
schtasks /query /fo csv > "%archivo%.csv"
echo Configuración exportada a: %archivo%.csv
pause
goto menu_principal

:salir
echo.
echo ¡Hasta luego!
exit /b 0 