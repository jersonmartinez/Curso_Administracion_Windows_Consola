@echo off
setlocal enabledelayedexpansion
title GESTION COMPLETA DE SHELL

echo ========================================
echo    GESTION COMPLETA DE SHELL
echo ========================================
echo.

:menu_principal
cls
echo ========================================
echo    GESTION COMPLETA DE SHELL
echo ========================================
echo.
echo 1. Configurar entorno
echo 2. Gestionar variables
echo 3. Automatizar tareas
echo 4. Crear entornos multiples
echo 5. Diagnosticar shell
echo 6. Ejecutar comando
echo 7. Generar reportes
echo 8. Salir
echo.
set /p opcion="Seleccione una opcion: "

if "%opcion%"=="1" goto configurar_entorno
if "%opcion%"=="2" goto gestionar_variables
if "%opcion%"=="3" goto automatizar_tareas
if "%opcion%"=="4" goto entornos_multiples
if "%opcion%"=="5" goto diagnosticar_shell
if "%opcion%"=="6" goto ejecutar_comando
if "%opcion%"=="7" goto generar_reportes
if "%opcion%"=="8" goto salir
goto menu_principal

:configurar_entorno
cls
echo ========================================
echo    CONFIGURAR ENTORNO
echo ========================================
echo.
echo 1. Configurar variables basicas
echo 2. Configurar PATH personalizado
echo 3. Configurar prompt personalizado
echo 4. Configurar entorno de desarrollo
echo 5. Configurar entorno de produccion
echo 6. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto variables_basicas
if "%subopcion%"=="2" goto path_personalizado
if "%subopcion%"=="3" goto prompt_personalizado
if "%subopcion%"=="4" goto entorno_desarrollo
if "%subopcion%"=="5" goto entorno_produccion
if "%subopcion%"=="6" goto menu_principal
goto configurar_entorno

:variables_basicas
cls
echo === CONFIGURAR VARIABLES BASICAS ===
echo.
set /p app_name="Nombre de la aplicacion: "
set /p app_path="Ruta de la aplicacion: "
set /p app_version="Version: "
set /p ambiente="Ambiente (DESARROLLO/PRODUCCION): "

set APP_NAME=%app_name%
set APP_PATH=%app_path%
set APP_VERSION=%app_version%
set AMBIENTE=%ambiente%

echo Variables basicas configuradas:
echo APP_NAME: %APP_NAME%
echo APP_PATH: %APP_PATH%
echo APP_VERSION: %APP_VERSION%
echo AMBIENTE: %AMBIENTE%
pause
goto configurar_entorno

:path_personalizado
cls
echo === CONFIGURAR PATH PERSONALIZADO ===
echo.
set /p nueva_ruta="Nueva ruta a agregar: "
if not "%nueva_ruta%"=="" (
    set PATH=%PATH%;%nueva_ruta%
    echo PATH actualizado: %PATH%
) else (
    echo Ruta no válida.
)
pause
goto configurar_entorno

:prompt_personalizado
cls
echo === CONFIGURAR PROMPT PERSONALIZADO ===
echo.
echo Opciones de prompt:
echo 1. [Sistema:Directorio]$
echo 2. [Usuario@Sistema]$
echo 3. [Hora:Directorio]$
echo 4. Personalizado
echo.
set /p prompt_option="Seleccione opcion: "

if "%prompt_option%"=="1" (
    set PROMPT=[%COMPUTERNAME%:%CD%]$
) else if "%prompt_option%"=="2" (
    set PROMPT=[%USERNAME%@%COMPUTERNAME%]$
) else if "%prompt_option%"=="3" (
    set PROMPT=[%time:~0,5%:%CD%]$
) else if "%prompt_option%"=="4" (
    set /p prompt_custom="Prompt personalizado: "
    set PROMPT=%prompt_custom%
) else (
    echo Opcion no válida.
)

echo Prompt configurado: %PROMPT%
pause
goto configurar_entorno

:entorno_desarrollo
cls
echo === CONFIGURAR ENTORNO DE DESARROLLO ===
echo.
set AMBIENTE=DESARROLLO
set DEBUG=1
set LOG_LEVEL=DEBUG
set PATH=%PATH%;C:\DevTools;C:\SDK;C:\Git\bin

echo Entorno de desarrollo configurado:
echo AMBIENTE: %AMBIENTE%
echo DEBUG: %DEBUG%
echo LOG_LEVEL: %LOG_LEVEL%
pause
goto configurar_entorno

:entorno_produccion
cls
echo === CONFIGURAR ENTORNO DE PRODUCCION ===
echo.
set AMBIENTE=PRODUCCION
set DEBUG=0
set LOG_LEVEL=INFO
set PATH=%PATH%;C:\ProdTools

echo Entorno de produccion configurado:
echo AMBIENTE: %AMBIENTE%
echo DEBUG: %DEBUG%
echo LOG_LEVEL: %LOG_LEVEL%
pause
goto configurar_entorno

:gestionar_variables
cls
echo ========================================
echo    GESTIONAR VARIABLES
echo ========================================
echo.
echo 1. Crear variable
echo 2. Modificar variable
echo 3. Eliminar variable
echo 4. Listar variables
echo 5. Exportar variables
echo 6. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto crear_variable
if "%subopcion%"=="2" goto modificar_variable
if "%subopcion%"=="3" goto eliminar_variable
if "%subopcion%"=="4" goto listar_variables
if "%subopcion%"=="5" goto exportar_variables
if "%subopcion%"=="6" goto menu_principal
goto gestionar_variables

:crear_variable
cls
echo === CREAR VARIABLE ===
echo.
set /p var_name="Nombre de la variable: "
set /p var_value="Valor de la variable: "
if not "%var_name%"=="" (
    set %var_name%=%var_value%
    echo Variable %var_name% creada con valor: %var_value%
) else (
    echo Nombre de variable no válido.
)
pause
goto gestionar_variables

:modificar_variable
cls
echo === MODIFICAR VARIABLE ===
echo.
set /p var_name="Nombre de la variable: "
set /p var_value="Nuevo valor: "
if not "%var_name%"=="" (
    set %var_name%=%var_value%
    echo Variable %var_name% modificada con valor: %var_value%
) else (
    echo Nombre de variable no válido.
)
pause
goto gestionar_variables

:eliminar_variable
cls
echo === ELIMINAR VARIABLE ===
echo.
set /p var_name="Nombre de la variable: "
if not "%var_name%"=="" (
    set %var_name%=
    echo Variable %var_name% eliminada.
) else (
    echo Nombre de variable no válido.
)
pause
goto gestionar_variables

:listar_variables
cls
echo === LISTAR VARIABLES ===
echo.
echo Variables de entorno actuales:
set | findstr /i "APP_ AMBIENTE DEBUG LOG_"
pause
goto gestionar_variables

:exportar_variables
cls
echo === EXPORTAR VARIABLES ===
echo.
set /p archivo="Archivo de exportacion: "
if not "%archivo%"=="" (
    set > "%archivo%"
    echo Variables exportadas a: %archivo%
) else (
    echo Nombre de archivo no válido.
)
pause
goto gestionar_variables

:automatizar_tareas
cls
echo ========================================
echo    AUTOMATIZAR TAREAS
echo ========================================
echo.
echo 1. Limpieza de archivos temporales
echo 2. Verificacion de espacio en disco
echo 3. Verificacion de servicios
echo 4. Backup de configuracion
echo 5. Tarea personalizada
echo 6. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto limpieza_temporales
if "%subopcion%"=="2" goto verificar_espacio
if "%subopcion%"=="3" goto verificar_servicios
if "%subopcion%"=="4" goto backup_configuracion
if "%subopcion%"=="5" goto tarea_personalizada
if "%subopcion%"=="6" goto menu_principal
goto automatizar_tareas

:limpieza_temporales
cls
echo === LIMPIEZA DE ARCHIVOS TEMPORALES ===
echo.
echo Limpiando archivos temporales...
del /q /f %TEMP%\*.* 2>nul
del /q /f %USERPROFILE%\AppData\Local\Temp\*.* 2>nul
echo Limpieza completada.
pause
goto automatizar_tareas

:verificar_espacio
cls
echo === VERIFICAR ESPACIO EN DISCO ===
echo.
echo Verificando espacio en disco...
dir C:\ /-c | find "bytes free"
echo Verificacion completada.
pause
goto automatizar_tareas

:verificar_servicios
cls
echo === VERIFICAR SERVICIOS ===
echo.
echo Verificando servicios criticos...
sc query spooler | find "STATE"
sc query eventlog | find "STATE"
sc query themes | find "STATE"
echo Verificacion completada.
pause
goto automatizar_tareas

:backup_configuracion
cls
echo === BACKUP DE CONFIGURACION ===
echo.
set "backup_file=shell_config_%date:~-4,4%%date:~-10,2%%date:~-7,2%.bat"
set "backup_file=%backup_file: =0%"

echo @echo off > "%backup_file%"
echo REM Backup de configuracion de shell >> "%backup_file%"
echo REM Fecha: %date% %time% >> "%backup_file%"
echo. >> "%backup_file%"

if defined APP_NAME echo set APP_NAME=%APP_NAME% >> "%backup_file%"
if defined APP_PATH echo set APP_PATH=%APP_PATH% >> "%backup_file%"
if defined AMBIENTE echo set AMBIENTE=%AMBIENTE% >> "%backup_file%"

echo Backup creado: %backup_file%
pause
goto automatizar_tareas

:tarea_personalizada
cls
echo === TAREA PERSONALIZADA ===
echo.
set /p comando="Comando a ejecutar: "
if not "%comando%"=="" (
    echo Ejecutando: %comando%
    %comando%
) else (
    echo Comando no válido.
)
pause
goto automatizar_tareas

:entornos_multiples
cls
echo ========================================
echo    CREAR ENTORNOS MULTIPLES
echo ========================================
echo.
echo 1. Crear entorno de desarrollo
echo 2. Crear entorno de produccion
echo 3. Crear entorno de testing
echo 4. Crear entorno personalizado
echo 5. Listar entornos creados
echo 6. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto crear_entorno_desarrollo
if "%subopcion%"=="2" goto crear_entorno_produccion
if "%subopcion%"=="3" goto crear_entorno_testing
if "%subopcion%"=="4" goto crear_entorno_personalizado
if "%subopcion%"=="5" goto listar_entornos
if "%subopcion%"=="6" goto menu_principal
goto entornos_multiples

:crear_entorno_desarrollo
cls
echo === CREAR ENTORNO DE DESARROLLO ===
echo.
echo @echo off > "entorno_desarrollo.bat"
echo set AMBIENTE=DESARROLLO >> "entorno_desarrollo.bat"
echo set PATH=%%PATH%%;C:\DevTools;C:\SDK;C:\Git\bin >> "entorno_desarrollo.bat"
echo set DEBUG=1 >> "entorno_desarrollo.bat"
echo set LOG_LEVEL=DEBUG >> "entorno_desarrollo.bat"
echo echo Entorno de desarrollo cargado. >> "entorno_desarrollo.bat"
echo cmd /k >> "entorno_desarrollo.bat"

echo Entorno de desarrollo creado: entorno_desarrollo.bat
pause
goto entornos_multiples

:crear_entorno_produccion
cls
echo === CREAR ENTORNO DE PRODUCCION ===
echo.
echo @echo off > "entorno_produccion.bat"
echo set AMBIENTE=PRODUCCION >> "entorno_produccion.bat"
echo set PATH=%%PATH%%;C:\ProdTools >> "entorno_produccion.bat"
echo set DEBUG=0 >> "entorno_produccion.bat"
echo set LOG_LEVEL=INFO >> "entorno_produccion.bat"
echo echo Entorno de produccion cargado. >> "entorno_produccion.bat"
echo cmd /k >> "entorno_produccion.bat"

echo Entorno de produccion creado: entorno_produccion.bat
pause
goto entornos_multiples

:crear_entorno_testing
cls
echo === CREAR ENTORNO DE TESTING ===
echo.
echo @echo off > "entorno_testing.bat"
echo set AMBIENTE=TESTING >> "entorno_testing.bat"
echo set PATH=%%PATH%%;C:\TestTools >> "entorno_testing.bat"
echo set TEST_MODE=1 >> "entorno_testing.bat"
echo set LOG_LEVEL=DEBUG >> "entorno_testing.bat"
echo echo Entorno de testing cargado. >> "entorno_testing.bat"
echo cmd /k >> "entorno_testing.bat"

echo Entorno de testing creado: entorno_testing.bat
pause
goto entornos_multiples

:crear_entorno_personalizado
cls
echo === CREAR ENTORNO PERSONALIZADO ===
echo.
set /p nombre="Nombre del entorno: "
set /p ambiente="Ambiente: "
set /p rutas="Rutas adicionales (separadas por ;): "

echo @echo off > "entorno_%nombre%.bat"
echo set AMBIENTE=%ambiente% >> "entorno_%nombre%.bat"
if not "%rutas%"=="" echo set PATH=%%PATH%%;%rutas% >> "entorno_%nombre%.bat"
echo echo Entorno %nombre% cargado. >> "entorno_%nombre%.bat"
echo cmd /k >> "entorno_%nombre%.bat"

echo Entorno personalizado creado: entorno_%nombre%.bat
pause
goto entornos_multiples

:listar_entornos
cls
echo === LISTAR ENTORNOS CREADOS ===
echo.
echo Entornos disponibles:
dir entorno_*.bat /b 2>nul
if !errorlevel! neq 0 (
    echo No hay entornos creados.
)
pause
goto entornos_multiples

:diagnosticar_shell
cls
echo ========================================
echo    DIAGNOSTICAR SHELL
echo ========================================
echo.
echo 1. Informacion del sistema
echo 2. Variables de entorno criticas
echo 3. Comandos disponibles
echo 4. Permisos de usuario
echo 5. Diagnostico completo
echo 6. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto info_sistema
if "%subopcion%"=="2" goto variables_criticas
if "%subopcion%"=="3" goto comandos_disponibles
if "%subopcion%"=="4" goto permisos_usuario
if "%subopcion%"=="5" goto diagnostico_completo
if "%subopcion%"=="6" goto menu_principal
goto diagnosticar_shell

:info_sistema
cls
echo === INFORMACION DEL SISTEMA ===
echo.
echo Sistema: %COMPUTERNAME%
echo Usuario: %USERNAME%
echo Directorio actual: %CD%
echo Fecha: %date%
echo Hora: %time%
pause
goto diagnosticar_shell

:variables_criticas
cls
echo === VARIABLES DE ENTORNO CRITICAS ===
echo.
echo PATH: %PATH%
echo TEMP: %TEMP%
echo SYSTEMROOT: %SYSTEMROOT%
echo USERPROFILE: %USERPROFILE%
pause
goto diagnosticar_shell

:comandos_disponibles
cls
echo === COMANDOS DISPONIBLES ===
echo.
echo Verificando comandos disponibles...
where cmd
where powershell
where reg
where sc
echo Verificacion completada.
pause
goto diagnosticar_shell

:permisos_usuario
cls
echo === PERMISOS DE USUARIO ===
echo.
echo Informacion de permisos:
whoami /priv
pause
goto diagnosticar_shell

:diagnostico_completo
cls
echo === DIAGNOSTICO COMPLETO ===
echo.
set "log_file=diagnostico_shell_%date:~-4,4%%date:~-10,2%%date:~-7,2%.log"
set "log_file=%log_file: =0%"

echo DIAGNOSTICO DE SHELL > %log_file%
echo ======================================== >> %log_file%
echo Fecha: %date% %time% >> %log_file%
echo. >> %log_file%

echo === INFORMACION DEL SISTEMA === >> %log_file%
echo Sistema: %COMPUTERNAME% >> %log_file%
echo Usuario: %USERNAME% >> %log_file%
echo Directorio actual: %CD% >> %log_file%
echo. >> %log_file%

echo === VARIABLES DE ENTORNO CRITICAS === >> %log_file%
echo PATH: %PATH% >> %log_file%
echo TEMP: %TEMP% >> %log_file%
echo SYSTEMROOT: %SYSTEMROOT% >> %log_file%
echo. >> %log_file%

echo === COMANDOS DISPONIBLES === >> %log_file%
where cmd >> %log_file%
where powershell >> %log_file%
where reg >> %log_file%
echo. >> %log_file%

echo === PERMISOS === >> %log_file%
whoami /priv >> %log_file%

echo Diagnostico completo guardado en: %log_file%
pause
goto diagnosticar_shell

:ejecutar_comando
cls
echo ========================================
echo    EJECUTAR COMANDO
echo ========================================
echo.
echo 1. Ejecutar comando simple
echo 2. Ejecutar comando con parametros
echo 3. Ejecutar comando de PowerShell
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto comando_simple
if "%subopcion%"=="2" goto comando_parametros
if "%subopcion%"=="3" goto comando_powershell
if "%subopcion%"=="4" goto menu_principal
goto ejecutar_comando

:comando_simple
cls
echo === EJECUTAR COMANDO SIMPLE ===
echo.
set /p comando="Comando a ejecutar: "
if not "%comando%"=="" (
    echo Ejecutando: %comando%
    %comando%
) else (
    echo Comando no válido.
)
pause
goto ejecutar_comando

:comando_parametros
cls
echo === EJECUTAR COMANDO CON PARAMETROS ===
echo.
set /p comando="Comando: "
set /p parametros="Parametros: "
if not "%comando%"=="" (
    echo Ejecutando: %comando% %parametros%
    %comando% %parametros%
) else (
    echo Comando no válido.
)
pause
goto ejecutar_comando

:comando_powershell
cls
echo === EJECUTAR COMANDO DE POWERSHELL ===
echo.
set /p comando="Comando de PowerShell: "
if not "%comando%"=="" (
    echo Ejecutando: %comando%
    powershell -Command "%comando%"
) else (
    echo Comando no válido.
)
pause
goto ejecutar_comando

:generar_reportes
cls
echo ========================================
echo    GENERAR REPORTES
echo ========================================
echo.
echo 1. Reporte de configuracion
echo 2. Reporte de variables
echo 3. Reporte de entornos
echo 4. Reporte completo
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto reporte_configuracion
if "%subopcion%"=="2" goto reporte_variables
if "%subopcion%"=="3" goto reporte_entornos
if "%subopcion%"=="4" goto reporte_completo
if "%subopcion%"=="5" goto menu_principal
goto generar_reportes

:reporte_configuracion
cls
echo === REPORTE DE CONFIGURACION ===
echo.

set "reporte_file=reporte_configuracion_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "reporte_file=%reporte_file: =0%"

echo Reporte de Configuracion - %date% %time% > "%reporte_file%"
echo. >> "%reporte_file%"

echo === CONFIGURACION ACTUAL === >> "%reporte_file%"
echo Sistema: %COMPUTERNAME% >> "%reporte_file%"
echo Usuario: %USERNAME% >> "%reporte_file%"
echo PATH: %PATH% >> "%reporte_file%"
echo PROMPT: %PROMPT% >> "%reporte_file%"

echo Reporte generado: %reporte_file%
pause
goto generar_reportes

:reporte_variables
cls
echo === REPORTE DE VARIABLES ===
echo.

set "reporte_file=reporte_variables_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "reporte_file=%reporte_file: =0%"

echo Reporte de Variables - %date% %time% > "%reporte_file%"
echo. >> "%reporte_file%"

echo === VARIABLES DEFINIDAS === >> "%reporte_file%"
set >> "%reporte_file%"

echo Reporte generado: %reporte_file%
pause
goto generar_reportes

:reporte_entornos
cls
echo === REPORTE DE ENTORNOS ===
echo.

set "reporte_file=reporte_entornos_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "reporte_file=%reporte_file: =0%"

echo Reporte de Entornos - %date% %time% > "%reporte_file%"
echo. >> "%reporte_file%"

echo === ENTORNOS DISPONIBLES === >> "%reporte_file%"
dir entorno_*.bat /b >> "%reporte_file%" 2>nul

echo Reporte generado: %reporte_file%
pause
goto generar_reportes

:reporte_completo
cls
echo === REPORTE COMPLETO ===
echo.

set "reporte_file=reporte_completo_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "reporte_file=%reporte_file: =0%"

echo Reporte Completo de Shell - %date% %time% > "%reporte_file%"
echo. >> "%reporte_file%"

echo === INFORMACION DEL SISTEMA === >> "%reporte_file%"
echo Sistema: %COMPUTERNAME% >> "%reporte_file%"
echo Usuario: %USERNAME% >> "%reporte_file%"
echo Directorio actual: %CD% >> "%reporte_file%"
echo. >> "%reporte_file%"

echo === VARIABLES DE ENTORNO === >> "%reporte_file%"
set >> "%reporte_file%"

echo === ENTORNOS DISPONIBLES === >> "%reporte_file%"
dir entorno_*.bat /b >> "%reporte_file%" 2>nul

echo Reporte completo generado: %reporte_file%
pause
goto generar_reportes

:salir
echo Gracias por usar la Gestion Completa de Shell
exit /b 0 