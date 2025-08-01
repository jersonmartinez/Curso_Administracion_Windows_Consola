@echo off
setlocal enabledelayedexpansion
title GESTION COMPLETA CON WMIC

REM Verificar privilegios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Este script requiere privilegios de administrador.
    echo Por favor, ejecuta como administrador.
    pause
    exit /b 1
)

echo ========================================
echo    GESTION COMPLETA CON WMIC
echo ========================================
echo.

:menu_principal
cls
echo ========================================
echo    GESTION COMPLETA CON WMIC
echo ========================================
echo.
echo 1. Informacion del sistema
echo 2. Gestionar procesos
echo 3. Gestionar servicios
echo 4. Gestionar productos
echo 5. Gestionar sistema operativo
echo 6. Gestionar equipo
echo 7. Gestionar BIOS
echo 8. Gestionar discos logicos
echo 9. Gestionar memoria
echo 10. Programar tareas WMIC
echo 11. Generar reportes
echo 12. Salir
echo.
set /p opcion="Seleccione una opcion: "

if "%opcion%"=="1" goto informacion_sistema
if "%opcion%"=="2" goto gestionar_procesos
if "%opcion%"=="3" goto gestionar_servicios
if "%opcion%"=="4" goto gestionar_productos
if "%opcion%"=="5" goto gestionar_os
if "%opcion%"=="6" goto gestionar_equipo
if "%opcion%"=="7" goto gestionar_bios
if "%opcion%"=="8" goto gestionar_discos
if "%opcion%"=="9" goto gestionar_memoria
if "%opcion%"=="10" goto programar_tareas
if "%opcion%"=="11" goto generar_reportes
if "%opcion%"=="12" goto salir
goto menu_principal

:informacion_sistema
cls
echo ========================================
echo    INFORMACION DEL SISTEMA
echo ========================================
echo.
echo 1. Informacion de CPU
echo 2. Informacion de OS
echo 3. Informacion de Computadora
echo 4. Informacion de BIOS
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto info_cpu
if "%subopcion%"=="2" goto info_os
if "%subopcion%"=="3" goto info_computadora
if "%subopcion%"=="4" goto info_bios
if "%subopcion%"=="5" goto menu_principal
goto informacion_sistema

:info_cpu
cls
echo === INFORMACION DE CPU ===
echo.
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors,CurrentClockSpeed,MaxClockSpeed /format:list
pause
goto informacion_sistema

:info_os
cls
echo === INFORMACION DE SISTEMA OPERATIVO ===
echo.
wmic os get Caption,Version,BuildNumber,OSArchitecture,InstallDate,LastBootUpTime /format:list
pause
goto informacion_sistema

:info_computadora
cls
echo === INFORMACION DE COMPUTADORA ===
echo.
wmic computersystem get Name,Domain,Workgroup,Manufacturer,Model,SystemType /format:list
pause
goto informacion_sistema

:info_bios
cls
echo === INFORMACION DE BIOS ===
echo.
wmic bios get Manufacturer,SMBIOSBIOSVersion,Version,ReleaseDate /format:list
pause
goto informacion_sistema

:gestionar_procesos
cls
echo ========================================
echo    GESTIONAR PROCESOS
echo ========================================
echo.
echo 1. Listar procesos
echo 2. Terminar proceso por PID
echo 3. Terminar proceso por nombre
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto listar_procesos
if "%subopcion%"=="2" goto terminar_proceso_pid
if "%subopcion%"=="3" goto terminar_proceso_nombre
if "%subopcion%"=="4" goto menu_principal
goto gestionar_procesos

:listar_procesos
cls
echo === LISTAR PROCESOS ===
echo.
wmic process get Name,ProcessId,ParentProcessId,CommandLine,WorkingSetSize /format:list
pause
goto gestionar_procesos

:terminar_proceso_pid
cls
echo === TERMINAR PROCESO POR PID ===
echo.
set /p pid="Ingrese el PID del proceso a terminar: "
if not "%pid%"=="" (
    wmic process where "ProcessId='%pid%'" call terminate
    if !errorlevel! equ 0 (
        echo Proceso con PID %pid% terminado.
    ) else (
        echo Error al terminar el proceso.
    )
) else (
    echo PID no valido.
)
pause
goto gestionar_procesos

:terminar_proceso_nombre
cls
echo === TERMINAR PROCESO POR NOMBRE ===
echo.
set /p nombre="Ingrese el nombre del proceso a terminar: "
if not "%nombre%"=="" (
    wmic process where "Name='%nombre%'" call terminate
    if !errorlevel! equ 0 (
        echo Proceso(s) con nombre %nombre% terminado.
    ) else (
        echo Error al terminar el proceso(s).
    )
) else (
    echo Nombre no valido.
)
pause
goto gestionar_procesos

:gestionar_servicios
cls
echo ========================================
echo    GESTIONAR SERVICIOS
echo ========================================
echo.
echo 1. Listar servicios
echo 2. Iniciar servicio
echo 3. Detener servicio
echo 4. Reiniciar servicio
echo 5. Cambiar modo de inicio
echo 6. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto listar_servicios
if "%subopcion%"=="2" goto iniciar_servicio
if "%subopcion%"=="3" goto detener_servicio
if "%subopcion%"=="4" goto reiniciar_servicio
if "%subopcion%"=="5" goto cambiar_modo_inicio
if "%subopcion%"=="6" goto menu_principal
goto gestionar_servicios

:listar_servicios
cls
echo === LISTAR SERVICIOS ===
echo.
wmic service get Name,State,StartMode,DisplayName,ProcessId /format:list
pause
goto gestionar_servicios

:iniciar_servicio
cls
echo === INICIAR SERVICIO ===
echo.
set /p nombre="Ingrese el nombre del servicio a iniciar: "
if not "%nombre%"=="" (
    wmic service where "Name='%nombre%'" call startservice
    if !errorlevel! equ 0 (
        echo Servicio %nombre% iniciado.
    ) else (
        echo Error al iniciar el servicio.
    )
) else (
    echo Nombre no valido.
)
pause
goto gestionar_servicios

:detener_servicio
cls
echo === DETENER SERVICIO ===
echo.
set /p nombre="Ingrese el nombre del servicio a detener: "
if not "%nombre%"=="" (
    wmic service where "Name='%nombre%'" call stopservice
    if !errorlevel! equ 0 (
        echo Servicio %nombre% detenido.
    ) else (
        echo Error al detener el servicio.
    )
) else (
    echo Nombre no valido.
)
pause
goto gestionar_servicios

:reiniciar_servicio
cls
echo === REINICIAR SERVICIO ===
echo.
set /p nombre="Ingrese el nombre del servicio a reiniciar: "
if not "%nombre%"=="" (
    wmic service where "Name='%nombre%'" call stopservice >nul 2>&1
    wmic service where "Name='%nombre%'" call startservice >nul 2>&1
    if !errorlevel! equ 0 (
        echo Servicio %nombre% reiniciado.
    ) else (
        echo Error al reiniciar el servicio.
    )
) else (
    echo Nombre no valido.
)
pause
goto gestionar_servicios

:cambiar_modo_inicio
cls
echo === CAMBIAR MODO DE INICIO ===
echo.
set /p nombre="Ingrese el nombre del servicio: "
set /p modo="Nuevo modo de inicio (Auto/Manual/Disabled): "
if not "%nombre%"=="" (
    wmic service where "Name='%nombre%'" call ChangeStartMode "%modo%"
    if !errorlevel! equ 0 (
        echo Modo de inicio de %nombre% cambiado a %modo%.
    ) else (
        echo Error al cambiar el modo de inicio.
    )
) else (
    echo Nombre no valido.
)
pause
goto gestionar_servicios

:gestionar_productos
cls
echo ========================================
echo    GESTIONAR PRODUCTOS
echo ========================================
echo.
echo 1. Listar productos instalados
echo 2. Desinstalar producto
echo 3. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto listar_productos
if "%subopcion%"=="2" goto desinstalar_producto
if "%subopcion%"=="3" goto menu_principal
goto gestionar_productos

:listar_productos
cls
echo === LISTAR PRODUCTOS INSTALADOS ===
echo.
wmic product get Name,Version,Vendor,InstallDate /format:list
pause
goto gestionar_productos

:desinstalar_producto
cls
echo === DESINSTALAR PRODUCTO ===
echo.
set /p nombre="Ingrese el nombre del producto a desinstalar: "
if not "%nombre%"=="" (
    wmic product where "Name='%nombre%'" call uninstall /nointeractive
    if !errorlevel! equ 0 (
        echo Producto %nombre% desinstalado.
    ) else (
        echo Error al desinstalar el producto.
    )
) else (
    echo Nombre no valido.
)
pause
goto gestionar_productos

:gestionar_os
cls
echo ========================================
echo    GESTIONAR SISTEMA OPERATIVO
echo ========================================
echo.
echo 1. Informacion de OS
echo 2. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto info_os_full
if "%subopcion%"=="2" goto menu_principal
goto gestionar_os

:info_os_full
cls
echo === INFORMACION COMPLETA DE SISTEMA OPERATIVO ===
echo.
wmic os get /format:list
pause
goto gestionar_os

:gestionar_equipo
cls
echo ========================================
echo    GESTIONAR EQUIPO
echo ========================================
echo.
echo 1. Informacion de Computadora
echo 2. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto info_computadora_full
if "%subopcion%"=="2" goto menu_principal
goto gestionar_equipo

:info_computadora_full
cls
echo === INFORMACION COMPLETA DE COMPUTADORA ===
echo.
wmic computersystem get /format:list
pause
goto gestionar_equipo

:gestionar_bios
cls
echo ========================================
echo    GESTIONAR BIOS
echo ========================================
echo.
echo 1. Informacion de BIOS
echo 2. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto info_bios_full
if "%subopcion%"=="2" goto menu_principal
goto gestionar_bios

:info_bios_full
cls
echo === INFORMACION COMPLETA DE BIOS ===
echo.
wmic bios get /format:list
pause
goto gestionar_bios

:gestionar_discos
cls
echo ========================================
echo    GESTIONAR DISCOS LOGICOS
echo ========================================
echo.
echo 1. Listar discos logicos
echo 2. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto listar_discos
if "%subopcion%"=="2" goto menu_principal
goto gestionar_discos

:listar_discos
cls
echo === LISTAR DISCOS LOGICOS ===
echo.
wmic logicaldisk get Caption,Description,FileSystem,FreeSpace,Size,VolumeName /format:list
pause
goto gestionar_discos

:gestionar_memoria
cls
echo ========================================
echo    GESTIONAR MEMORIA
echo ========================================
echo.
echo 1. Informacion de memoria fisica
echo 2. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto info_memoria
if "%subopcion%"=="2" goto menu_principal
goto gestionar_memoria

:info_memoria
cls
echo === INFORMACION DE MEMORIA FISICA ===
echo.
wmic memorychip get Capacity,Speed,Manufacturer,DeviceLocator /format:list
pause
goto gestionar_memoria

:programar_tareas
cls
echo ========================================
echo    PROGRAMAR TAREAS WMIC
echo ========================================
echo.
echo 1. Crear tarea programada
echo 2. Listar tareas programadas
echo 3. Eliminar tarea programada
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto crear_tarea_wmic
if "%subopcion%"=="2" goto listar_tareas_wmic
if "%subopcion%"=="3" goto eliminar_tarea_wmic
if "%subopcion%"=="4" goto menu_principal
goto programar_tareas

:crear_tarea_wmic
cls
echo === CREAR TAREA PROGRAMADA WMIC ===
echo.
set /p task_name="Nombre de la tarea: "
set /p wmic_command="Comando WMIC (ej: wmic os get Caption): "
set /p schedule="Frecuencia (daily/weekly/monthly): "
set /p time="Hora (HH:MM): "

if not "%task_name%"=="" (
    schtasks /create /tn "%task_name%" /tr "%wmic_command%" /sc %schedule% /st %time%
    if !errorlevel! equ 0 (
        echo Tarea programada '%task_name%' creada.
    ) else (
        echo Error al crear la tarea programada.
    )
) else (
    echo Nombre de tarea no valido.
)
pause
goto programar_tareas

:listar_tareas_wmic
cls
echo === LISTAR TAREAS PROGRAMADAS WMIC ===
echo.
schtasks /query /tn "WMIC_*" /fo table
pause
goto programar_tareas

:eliminar_tarea_wmic
cls
echo === ELIMINAR TAREA PROGRAMADA WMIC ===
echo.
set /p task_name="Nombre de la tarea a eliminar: "
if not "%task_name%"=="" (
    schtasks /delete /tn "%task_name%" /f
    if !errorlevel! equ 0 (
        echo Tarea programada '%task_name%' eliminada.
    ) else (
        echo Error al eliminar la tarea programada.
    )
) else (
    echo Nombre de tarea no valido.
)
pause
goto programar_tareas

:generar_reportes
cls
echo ========================================
echo    GENERAR REPORTES
echo ========================================
echo.
echo 1. Reporte de sistema
echo 2. Reporte de procesos
echo 3. Reporte de servicios
echo 4. Reporte completo
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto reporte_sistema
if "%subopcion%"=="2" goto reporte_procesos
if "%subopcion%"=="3" goto reporte_servicios
if "%subopcion%"=="4" goto reporte_completo
if "%subopcion%"=="5" goto menu_principal
goto generar_reportes

:reporte_sistema
cls
echo === REPORTE DE SISTEMA ===
echo.
set "report_file=reporte_sistema_wmic_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Sistema WMIC - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === INFORMACION DE CPU === >> "%report_file%"
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors,CurrentClockSpeed,MaxClockSpeed >> "%report_file%"
echo. >> "%report_file%"

echo === INFORMACION DE OS === >> "%report_file%"
wmic os get Caption,Version,BuildNumber,OSArchitecture >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto generar_reportes

:reporte_procesos
cls
echo === REPORTE DE PROCESOS ===
echo.
set "report_file=reporte_procesos_wmic_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Procesos WMIC - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === LISTA DE PROCESOS === >> "%report_file%"
wmic process get Name,ProcessId,WorkingSetSize,CommandLine >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto generar_reportes

:reporte_servicios
cls
echo === REPORTE DE SERVICIOS ===
echo.
set "report_file=reporte_servicios_wmic_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte de Servicios WMIC - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === LISTA DE SERVICIOS === >> "%report_file%"
wmic service get Name,State,StartMode,DisplayName >> "%report_file%"
echo. >> "%report_file%"

echo Reporte generado: %report_file%
pause
goto generar_reportes

:reporte_completo
cls
echo === REPORTE COMPLETO ===
echo.
set "report_file=reporte_completo_wmic_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

echo Reporte Completo WMIC - %date% %time% > "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo === INFORMACION DE SISTEMA === >> "%report_file%"
wmic os get Caption,Version,BuildNumber,OSArchitecture >> "%report_file%"
wmic computersystem get Name,Manufacturer,Model >> "%report_file%"
wmic cpu get Name,NumberOfCores >> "%report_file%"
wmic memorychip get Capacity >> "%report_file%"
echo. >> "%report_file%"

echo === PROCESOS ACTIVOS === >> "%report_file%"
wmic process get Name,ProcessId,WorkingSetSize >> "%report_file%"
echo. >> "%report_file%"

echo === SERVICIOS ACTIVOS === >> "%report_file%"
wmic service get Name,State,StartMode >> "%report_file%"
echo. >> "%report_file%"

echo Reporte completo generado: %report_file%
pause
goto generar_reportes

:salir
echo Gracias por usar la Gestion Completa con WMIC
exit /b 0 