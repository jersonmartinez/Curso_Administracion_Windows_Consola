@echo off
setlocal enabledelayedexpansion
title GESTION COMPLETA DEL REGISTRO

REM Verificar privilegios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Este script requiere privilegios de administrador.
    echo Por favor, ejecuta como administrador.
    pause
    exit /b 1
)

echo ========================================
echo    GESTION COMPLETA DEL REGISTRO
echo ========================================
echo.

:menu_principal
cls
echo ========================================
echo    GESTION COMPLETA DEL REGISTRO
echo ========================================
echo.
echo 1. Consultar registro
echo 2. Agregar configuracion
echo 3. Modificar configuracion
echo 4. Eliminar configuracion
echo 5. Exportar registro
echo 6. Importar registro
echo 7. Comparar registros
echo 8. Monitorear cambios
echo 9. Auditoria y reportes
echo 10. Salir
echo.
set /p opcion="Seleccione una opcion: "

if "%opcion%"=="1" goto consultar_registro
if "%opcion%"=="2" goto agregar_configuracion
if "%opcion%"=="3" goto modificar_configuracion
if "%opcion%"=="4" goto eliminar_configuracion
if "%opcion%"=="5" goto exportar_registro
if "%opcion%"=="6" goto importar_registro
if "%opcion%"=="7" goto comparar_registros
if "%opcion%"=="8" goto monitorear_cambios
if "%opcion%"=="9" goto auditoria_reportes
if "%opcion%"=="10" goto salir
goto menu_principal

:consultar_registro
cls
echo ========================================
echo    CONSULTAR REGISTRO
echo ========================================
echo.
echo 1. Consultar clave
echo 2. Consultar valor
echo 3. Listar subclaves
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto consultar_clave
if "%subopcion%"=="2" goto consultar_valor
if "%subopcion%"=="3" goto listar_subclaves
if "%subopcion%"=="4" goto menu_principal
goto consultar_registro

:consultar_clave
cls
echo === CONSULTAR CLAVE ===
echo.
set /p clave="Ingrese la clave (ej: HKLM\SOFTWARE\MiApp): "
if not "%clave%"=="" (
    reg query "%clave%"
    if !errorlevel! equ 0 (
        echo Consulta completada.
    ) else (
        echo Clave no encontrada o error.
    )
) else (
    echo Clave no valida.
)
pause
goto consultar_registro

:consultar_valor
cls
echo === CONSULTAR VALOR ===
echo.
set /p clave="Ingrese la clave (ej: HKLM\SOFTWARE\MiApp): "
set /p valor="Ingrese el nombre del valor: "
if not "%clave%"=="" (
    reg query "%clave%" /v "%valor%"
    if !errorlevel! equ 0 (
        echo Consulta completada.
    ) else (
        echo Valor no encontrado o error.
    )
) else (
    echo Clave no valida.
)
pause
goto consultar_registro

:listar_subclaves
cls
echo === LISTAR SUBCLAVES ===
echo.
set /p clave="Ingrese la clave (ej: HKLM\SOFTWARE): "
if not "%clave%"=="" (
    reg query "%clave%" /s
    if !errorlevel! equ 0 (
        echo Listado completado.
    ) else (
        echo Clave no encontrada o error.
    )
) else (
    echo Clave no valida.
)
pause
goto consultar_registro

:agregar_configuracion
cls
echo ========================================
echo    AGREGAR CONFIGURACION
echo ========================================
echo.
echo 1. Agregar clave
echo 2. Agregar valor (REG_SZ)
echo 3. Agregar valor (REG_DWORD)
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto agregar_clave
if "%subopcion%"=="2" goto agregar_valor_sz
if "%subopcion%"=="3" goto agregar_valor_dword
if "%subopcion%"=="4" goto menu_principal
goto agregar_configuracion

:agregar_clave
cls
echo === AGREGAR CLAVE ===
echo.
set /p clave="Ingrese la nueva clave (ej: HKLM\SOFTWARE\NuevaApp): "
if not "%clave%"=="" (
    reg add "%clave%" /f
    if !errorlevel! equ 0 (
        echo Clave %clave% agregada.
    ) else (
        echo Error al agregar la clave.
    )
) else (
    echo Clave no valida.
)
pause
goto agregar_configuracion

:agregar_valor_sz
cls
echo === AGREGAR VALOR (REG_SZ) ===
echo.
set /p clave="Ingrese la clave: "
set /p nombre="Ingrese el nombre del valor: "
set /p datos="Ingrese los datos del valor: "
if not "%clave%"=="" (
    reg add "%clave%" /v "%nombre%" /t REG_SZ /d "%datos%" /f
    if !errorlevel! equ 0 (
        echo Valor %nombre% agregado a %clave%.
    ) else (
        echo Error al agregar el valor.
    )
) else (
    echo Clave no valida.
)
pause
goto agregar_configuracion

:agregar_valor_dword
cls
echo === AGREGAR VALOR (REG_DWORD) ===
echo.
set /p clave="Ingrese la clave: "
set /p nombre="Ingrese el nombre del valor: "
set /p datos="Ingrese los datos del valor (numero): "
if not "%clave%"=="" (
    reg add "%clave%" /v "%nombre%" /t REG_DWORD /d "%datos%" /f
    if !errorlevel! equ 0 (
        echo Valor %nombre% (DWORD) agregado a %clave%.
    ) else (
        echo Error al agregar el valor.
    )
) else (
    echo Clave no valida.
)
pause
goto agregar_configuracion

:modificar_configuracion
cls
echo ========================================
echo    MODIFICAR CONFIGURACION
echo ========================================
echo.
echo 1. Modificar valor (REG_SZ)
echo 2. Modificar valor (REG_DWORD)
echo 3. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto modificar_valor_sz
if "%subopcion%"=="2" goto modificar_valor_dword
if "%subopcion%"=="3" goto menu_principal
goto modificar_configuracion

:modificar_valor_sz
cls
echo === MODIFICAR VALOR (REG_SZ) ===
echo.
set /p clave="Ingrese la clave: "
set /p nombre="Ingrese el nombre del valor a modificar: "
set /p nuevos_datos="Ingrese los nuevos datos: "
if not "%clave%"=="" (
    reg add "%clave%" /v "%nombre%" /t REG_SZ /d "%nuevos_datos%" /f
    if !errorlevel! equ 0 (
        echo Valor %nombre% en %clave% modificado.
    ) else (
        echo Error al modificar el valor.
    )
) else (
    echo Clave no valida.
)
pause
goto modificar_configuracion

:modificar_valor_dword
cls
echo === MODIFICAR VALOR (REG_DWORD) ===
echo.
set /p clave="Ingrese la clave: "
set /p nombre="Ingrese el nombre del valor a modificar: "
set /p nuevos_datos="Ingrese los nuevos datos (numero): "
if not "%clave%"=="" (
    reg add "%clave%" /v "%nombre%" /t REG_DWORD /d "%nuevos_datos%" /f
    if !errorlevel! equ 0 (
        echo Valor %nombre% (DWORD) en %clave% modificado.
    ) else (
        echo Error al modificar el valor.
    )
) else (
    echo Clave no valida.
)
pause
goto modificar_configuracion

:eliminar_configuracion
cls
echo ========================================
echo    ELIMINAR CONFIGURACION
echo ========================================
echo.
echo 1. Eliminar clave
echo 2. Eliminar valor
echo 3. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto eliminar_clave
if "%subopcion%"=="2" goto eliminar_valor
if "%subopcion%"=="3" goto menu_principal
goto eliminar_configuracion

:eliminar_clave
cls
echo === ELIMINAR CLAVE ===
echo.
set /p clave="Ingrese la clave a eliminar (ej: HKLM\SOFTWARE\MiApp): "
if not "%clave%"=="" (
    echo ¿Estas seguro de eliminar la clave %clave% y todas sus subclaves/valores? (s/n)
    set /p confirm="Confirmar: "
    if /i "%confirm%"=="s" (
        reg delete "%clave%" /f
        if !errorlevel! equ 0 (
            echo Clave %clave% eliminada.
        ) else (
            echo Error al eliminar la clave.
        )
    ) else (
        echo Operacion cancelada.
    )
) else (
    echo Clave no valida.
)
pause
goto eliminar_configuracion

:eliminar_valor
cls
echo === ELIMINAR VALOR ===
echo.
set /p clave="Ingrese la clave: "
set /p nombre="Ingrese el nombre del valor a eliminar: "
if not "%clave%"=="" (
    echo ¿Estas seguro de eliminar el valor %nombre% de %clave%? (s/n)
    set /p confirm="Confirmar: "
    if /i "%confirm%"=="s" (
        reg delete "%clave%" /v "%nombre%" /f
        if !errorlevel! equ 0 (
            echo Valor %nombre% eliminado de %clave%.
        ) else (
            echo Error al eliminar el valor.
        )
    ) else (
        echo Operacion cancelada.
    )
) else (
    echo Clave no valida.
)
pause
goto eliminar_configuracion

:exportar_registro
cls
echo ========================================
echo    EXPORTAR REGISTRO
echo ========================================
echo.
set /p clave="Ingrese la clave a exportar (ej: HKLM\SOFTWARE\MiApp): "
set /p archivo="Ingrese el nombre del archivo .reg (ej: backup.reg): "
if not "%clave%"=="" (
    reg export "%clave%" "%archivo%"
    if !errorlevel! equ 0 (
        echo Clave %clave% exportada a %archivo%.
    ) else (
        echo Error al exportar el registro.
    )
) else (
    echo Clave no valida.
)
pause
goto menu_principal

:importar_registro
cls
echo ========================================
echo    IMPORTAR REGISTRO
echo ========================================
echo.
set /p archivo="Ingrese el nombre del archivo .reg a importar (ej: backup.reg): "
if exist "%archivo%" (
    echo ¿Estas seguro de importar %archivo%? Esto puede modificar el registro. (s/n)
    set /p confirm="Confirmar: "
    if /i "%confirm%"=="s" (
        reg import "%archivo%"
        if !errorlevel! equ 0 (
            echo Archivo %archivo% importado.
        ) else (
            echo Error al importar el registro.
        )
    ) else (
        echo Operacion cancelada.
    )
) else (
    echo Archivo no encontrado.
)
pause
goto menu_principal

:comparar_registros
cls
echo ========================================
echo    COMPARAR REGISTROS
echo ========================================
echo.
echo 1. Comparar dos claves
echo 2. Comparar clave con archivo .reg
echo 3. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto comparar_claves
if "%subopcion%"=="2" goto comparar_clave_archivo
if "%subopcion%"=="3" goto menu_principal
goto comparar_registros

:comparar_claves
cls
echo === COMPARAR DOS CLAVES ===
echo.
set /p clave1="Ingrese la primera clave: "
set /p clave2="Ingrese la segunda clave: "
if not "%clave1%"=="" (
    echo Comparando %clave1% con %clave2%...
    REM Esta funcionalidad es mas compleja y requeriria parsing de la salida de reg query
    echo (Funcionalidad avanzada, requiere parsing de salida de 'reg query')
    echo Ejemplo: reg query "%clave1%" > temp1.txt & reg query "%clave2%" > temp2.txt & fc temp1.txt temp2.txt
) else (
    echo Clave no valida.
)
pause
goto comparar_registros

:comparar_clave_archivo
cls
echo === COMPARAR CLAVE CON ARCHIVO .REG ===
echo.
set /p clave="Ingrese la clave: "
set /p archivo="Ingrese el archivo .reg: "
if not "%clave%"=="" (
    echo Comparando %clave% con %archivo%...
    REM Esta funcionalidad es mas compleja y requeriria parsing
    echo (Funcionalidad avanzada, requiere parsing de salida de 'reg query' y contenido de .reg)
) else (
    echo Clave no valida.
)
pause
goto comparar_registros

:monitorear_cambios
cls
echo ========================================
echo    MONITOREAR CAMBIOS
echo ========================================
echo.
echo 1. Monitorear clave en tiempo real (basico)
echo 2. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto monitorear_clave_tiempo_real
if "%subopcion%"=="2" goto menu_principal
goto monitorear_cambios

:monitorear_clave_tiempo_real
cls
echo === MONITOREAR CLAVE EN TIEMPO REAL ===
echo.
set /p clave="Ingrese la clave a monitorear (ej: HKLM\SOFTWARE\MiApp): "
if not "%clave%"=="" (
    echo Monitoreando cambios en %clave%. Presiona Ctrl+C para detener.
    :monitor_loop
    cls
    echo Monitoreando: %clave%
    echo Fecha: %date% Hora: %time%
    reg query "%clave%"
    timeout /t 5 /nobreak >nul
    goto monitor_loop
) else (
    echo Clave no valida.
)
pause
goto monitorear_cambios

:auditoria_reportes
cls
echo ========================================
echo    AUDITORIA Y REPORTES
echo ========================================
echo.
echo 1. Generar reporte de clave
echo 2. Generar reporte de cambios
echo 3. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto reporte_clave
if "%subopcion%"=="2" goto reporte_cambios
if "%subopcion%"=="3" goto menu_principal
goto auditoria_reportes

:reporte_clave
cls
echo === GENERAR REPORTE DE CLAVE ===
echo.
set /p clave="Ingrese la clave para el reporte: "
set "report_file=reporte_registro_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "report_file=%report_file: =0%"

if not "%clave%"=="" (
    echo Reporte de Clave de Registro - %date% %time% > "%report_file%"
    echo ======================================== >> "%report_file%"
    echo Clave: %clave% >> "%report_file%"
    echo. >> "%report_file%"
    reg query "%clave%" /s >> "%report_file%"
    echo Reporte generado en: %report_file%
) else (
    echo Clave no valida.
)
pause
goto auditoria_reportes

:reporte_cambios
cls
echo === GENERAR REPORTE DE CAMBIOS ===
echo.
echo Esta funcionalidad requiere un monitoreo continuo o logs previos.
echo (Implementacion avanzada)
pause
goto auditoria_reportes

:salir
echo Gracias por usar la Gestion Completa del Registro
exit /b 0 