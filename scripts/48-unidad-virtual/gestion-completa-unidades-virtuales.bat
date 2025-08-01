@echo off
setlocal enabledelayedexpansion
title Gestión Completa de Unidades Virtuales
color 0D

:: Verificar privilegios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Este script requiere privilegios de administrador.
    echo Ejecuta como administrador y vuelve a intentar.
    pause
    exit /b 1
)

:: Configuración
set "virtual_config=C:\Virtual_Config"
set "virtual_logs=C:\Virtual_Logs"
set "virtual_backup=C:\Virtual_Backup"

:: Crear directorios si no existen
if not exist "%virtual_config%" mkdir "%virtual_config%"
if not exist "%virtual_logs%" mkdir "%virtual_logs%"
if not exist "%virtual_backup%" mkdir "%virtual_backup%"

echo.
echo ========================================
echo    GESTIÓN COMPLETA DE UNIDADES VIRTUALES
echo ========================================
echo.

:menu_principal
echo [1] Ver unidades virtuales activas
echo [2] Crear unidad SUBST
echo [3] Montar imagen ISO
echo [4] Crear disco VHD
echo [5] Crear punto de montaje
echo [6] Gestión de unidades RAM
echo [7] Limpiar unidades virtuales
echo [8] Backup y restauración
echo [9] Reportes y auditoría
echo [10] Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto ver_unidades
if "%opcion%"=="2" goto crear_subst
if "%opcion%"=="3" goto montar_iso
if "%opcion%"=="4" goto crear_vhd
if "%opcion%"=="5" goto punto_montaje
if "%opcion%"=="6" goto gestion_ram
if "%opcion%"=="7" goto limpiar_unidades
if "%opcion%"=="8" goto backup_restauracion
if "%opcion%"=="9" goto reportes_auditoria
if "%opcion%"=="10" goto salir
goto menu_principal

:ver_unidades
echo.
echo Unidades virtuales activas:
echo ===========================
echo.
echo Unidades SUBST:
echo ═══════════════
subst
echo.
echo Unidades montadas (ISOs/VHDs):
echo ═══════════════════════════════
wmic logicaldisk get deviceid,volumename,size,mediatype
echo.
pause
goto menu_principal

:crear_subst
echo.
set /p letra="Letra de unidad (ej: V): "
set /p ruta="Ruta del directorio: "

if not exist "%ruta%" (
    echo Error: La ruta especificada no existe.
    pause
    goto crear_subst
)

echo.
echo Creando unidad virtual %letra%: -> %ruta%...
subst %letra%: "%ruta%"

if %errorlevel% equ 0 (
    echo Unidad virtual creada exitosamente
    echo.
    echo Verificando:
    dir %letra%:
) else (
    echo Error al crear la unidad virtual
)
pause
goto menu_principal

:montar_iso
echo.
set /p ruta_iso="Ruta del archivo ISO: "

if not exist "%ruta_iso%" (
    echo Error: El archivo ISO no existe.
    pause
    goto montar_iso
)

echo.
echo Montando ISO...
powershell "Mount-DiskImage -ImagePath '%ruta_iso%'"

if %errorlevel% equ 0 (
    echo ISO montada exitosamente
    echo.
    echo Unidades disponibles:
    wmic logicaldisk get deviceid,volumename
) else (
    echo Error al montar la ISO
)
pause
goto menu_principal

:crear_vhd
echo.
set /p ruta_vhd="Ruta del archivo VHD: "
set /p tamaño="Tamaño en MB: "
set /p letra="Letra de unidad: "

echo.
echo Creando disco VHD...
echo create vdisk file="%ruta_vhd%" maximum=%tamaño% > "%TEMP%\diskpart_script.txt"
echo select vdisk file="%ruta_vhd%" >> "%TEMP%\diskpart_script.txt"
echo attach vdisk >> "%TEMP%\diskpart_script.txt"
echo create partition primary >> "%TEMP%\diskpart_script.txt"
echo format fs=ntfs quick >> "%TEMP%\diskpart_script.txt"
echo assign letter=%letra% >> "%TEMP%\diskpart_script.txt"
echo exit >> "%TEMP%\diskpart_script.txt"

diskpart /s "%TEMP%\diskpart_script.txt"

if %errorlevel% equ 0 (
    echo Disco VHD creado exitosamente
    echo.
    echo Verificando:
    dir %letra%:
) else (
    echo Error al crear el disco VHD
)

del "%TEMP%\diskpart_script.txt"
pause
goto menu_principal

:punto_montaje
echo.
set /p ruta_montaje="Ruta del punto de montaje: "
set /p guid_volumen="GUID del volumen: "

echo.
echo Creando punto de montaje...
if not exist "%ruta_montaje%" mkdir "%ruta_montaje%"

mountvol "%ruta_montaje%" "\\?\Volume{%guid_volumen%}"

if %errorlevel% equ 0 (
    echo Punto de montaje creado exitosamente
    echo.
    echo Verificando:
    dir "%ruta_montaje%"
) else (
    echo Error al crear el punto de montaje
)
pause
goto menu_principal

:gestion_ram
echo.
echo [1] Crear unidad RAM
echo [2] Eliminar unidad RAM
echo [3] Listar unidades RAM
echo [4] Volver al menú principal
echo.
set /p opcion_ram="Selecciona una opción: "

if "%opcion_ram%"=="1" goto crear_ram
if "%opcion_ram%"=="2" goto eliminar_ram
if "%opcion_ram%"=="3" goto listar_ram
if "%opcion_ram%"=="4" goto menu_principal
goto gestion_ram

:crear_ram
echo.
set /p letra="Letra de unidad (ej: R): "
set /p tamaño="Tamaño en MB: "

echo.
echo Creando unidad RAM...
imdisk -a -s %tamaño%M -m %letra%: -p "/fs:ntfs /q /y"

if %errorlevel% equ 0 (
    echo Unidad RAM creada exitosamente
    echo.
    echo Verificando:
    dir %letra%:
) else (
    echo Error al crear la unidad RAM
)
pause
goto gestion_ram

:eliminar_ram
echo.
set /p letra="Letra de unidad a eliminar: "

echo.
echo Eliminando unidad RAM...
imdisk -d -m %letra%:

if %errorlevel% equ 0 (
    echo Unidad RAM eliminada exitosamente
) else (
    echo Error al eliminar la unidad RAM
)
pause
goto gestion_ram

:listar_ram
echo.
echo Unidades RAM activas:
echo =====================
imdisk -l
echo.
pause
goto gestion_ram

:limpiar_unidades
echo.
echo [1] Desmontar todas las ISOs
echo [2] Eliminar todas las unidades SUBST
echo [3] Desadjuntar VHDs
echo [4] Limpieza completa
echo [5] Volver al menú principal
echo.
set /p opcion_limpieza="Selecciona una opción: "

if "%opcion_limpieza%"=="1" goto desmontar_isos
if "%opcion_limpieza%"=="2" goto eliminar_subst
if "%opcion_limpieza%"=="3" goto desadjuntar_vhds
if "%opcion_limpieza%"=="4" goto limpieza_completa
if "%opcion_limpieza%"=="5" goto menu_principal
goto limpiar_unidades

:desmontar_isos
echo.
echo Desmontando ISOs...
powershell "Get-DiskImage | Where-Object {$_.ImagePath -like '*.iso'} | Dismount-DiskImage"
echo ISOs desmontadas
pause
goto limpiar_unidades

:eliminar_subst
echo.
echo Eliminando unidades SUBST...
for %%d in (V W X Y Z) do (
    if exist %%d:\ (
        subst %%d: /d
        echo Unidad %%d: eliminada
    )
)
echo Unidades SUBST eliminadas
pause
goto limpiar_unidades

:desadjuntar_vhds
echo.
echo Desadjuntando VHDs...
echo list vdisk > "%TEMP%\detach_script.txt"
echo exit >> "%TEMP%\detach_script.txt"
diskpart /s "%TEMP%\detach_script.txt"
del "%TEMP%\detach_script.txt"
echo VHDs desadjuntados
pause
goto limpiar_unidades

:limpieza_completa
echo.
echo Limpieza completa...
powershell "Get-DiskImage | Where-Object {$_.ImagePath -like '*.iso'} | Dismount-DiskImage"
for %%d in (V W X Y Z) do (
    if exist %%d:\ (
        subst %%d: /d
    )
)
echo Limpieza completa realizada
pause
goto limpiar_unidades

:backup_restauracion
echo.
echo [1] Crear backup de configuraciones
echo [2] Restaurar configuraciones
echo [3] Backup de VHDs
echo [4] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto crear_backup_config
if "%sub_opcion%"=="2" goto restaurar_config
if "%sub_opcion%"=="3" goto backup_vhds
if "%sub_opcion%"=="4" goto menu_principal
goto backup_restauracion

:crear_backup_config
echo.
set /p backup_name="Nombre del backup: "
echo.
echo Creando backup de configuraciones...

echo [Virtual_Drives] > "%virtual_backup%\%backup_name%.ini"
echo Backup_Date=%date% %time% >> "%virtual_backup%\%backup_name%.ini"
echo. >> "%virtual_backup%\%backup_name%.ini"

echo [SUBST_Units] >> "%virtual_backup%\%backup_name%.ini"
subst >> "%virtual_backup%\%backup_name%.ini"
echo. >> "%virtual_backup%\%backup_name%.ini"

echo [Mounted_ISOs] >> "%virtual_backup%\%backup_name%.ini"
wmic logicaldisk get deviceid,volumename | findstr /i "iso" >> "%virtual_backup%\%backup_name%.ini"
echo. >> "%virtual_backup%\%backup_name%.ini"

echo Backup creado: %virtual_backup%\%backup_name%.ini
pause
goto backup_restauracion

:restaurar_config
echo.
echo Backups disponibles:
echo ====================
dir /b "%virtual_backup%\*.ini"
echo.
set /p backup_file="Nombre del archivo de backup: "
if exist "%virtual_backup%\%backup_file%" (
    echo Restaurando configuraciones desde %backup_file%...
    echo Restauración manual requerida.
) else (
    echo Backup no encontrado.
)
pause
goto backup_restauracion

:backup_vhds
echo.
set /p directorio_vhds="Directorio de VHDs: "
set /p directorio_backup="Directorio de backup: "

if not exist "%directorio_backup%" mkdir "%directorio_backup%"

echo.
echo Creando backup de VHDs...

for %%i in ("%directorio_vhds%\*.vhd") do (
    echo Copiando %%i...
    copy "%%i" "%directorio_backup%\%%~ni_%date:~-4,4%%date:~-10,2%%date:~-7,2%.vhd"
)

echo Backup de VHDs completado
pause
goto backup_restauracion

:reportes_auditoria
echo.
echo [1] Generar reporte completo
echo [2] Auditoría de uso de espacio
echo [3] Estadísticas de unidades virtuales
echo [4] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto reporte_completo
if "%sub_opcion%"=="2" goto auditoria_espacio
if "%sub_opcion%"=="3" goto estadisticas_unidades
if "%sub_opcion%"=="4" goto menu_principal
goto reportes_auditoria

:reporte_completo
echo.
set /p report_name="Nombre del reporte: "
echo.
echo Generando reporte completo...

echo Reporte Completo de Unidades Virtuales > "%virtual_logs%\%report_name%.txt"
echo Fecha: %date% %time% >> "%virtual_logs%\%report_name%.txt"
echo ======================================== >> "%virtual_logs%\%report_name%.txt"
echo. >> "%virtual_logs%\%report_name%.txt"

echo UNIDADES SUBST: >> "%virtual_logs%\%report_name%.txt"
echo ═══════════════ >> "%virtual_logs%\%report_name%.txt"
subst >> "%virtual_logs%\%report_name%.txt"
echo. >> "%virtual_logs%\%report_name%.txt"

echo UNIDADES MONTADAS: >> "%virtual_logs%\%report_name%.txt"
echo ════════════════════════════════════════════════════════════════ >> "%virtual_logs%\%report_name%.txt"
wmic logicaldisk get deviceid,volumename,size,mediatype >> "%virtual_logs%\%report_name%.txt"
echo. >> "%virtual_logs%\%report_name%.txt"

echo UNIDADES RAM: >> "%virtual_logs%\%report_name%.txt"
echo ════════════════════════════════════════════════════════════════ >> "%virtual_logs%\%report_name%.txt"
imdisk -l >> "%virtual_logs%\%report_name%.txt"

echo Reporte generado: %virtual_logs%\%report_name%.txt
pause
goto reportes_auditoria

:auditoria_espacio
echo.
echo Auditoría de uso de espacio en unidades virtuales:
echo ==================================================
echo.

for %%d in (V W X Y Z) do (
    if exist "%%d:\" (
        echo.
        echo Unidad %%d::
        for /f "tokens=3" %%s in ('dir %%d:\ ^| findstr "bytes free"') do (
            set "espacio_libre=%%s"
            echo Espacio libre: !espacio_libre!
        )
    )
)
echo.
pause
goto reportes_auditoria

:estadisticas_unidades
echo.
echo Estadísticas de unidades virtuales:
echo ===================================
echo.

set "unidades_subst=0"
set "unidades_iso=0"
set "unidades_vhd=0"
set "unidades_ram=0"

:: Contar unidades SUBST
for %%d in (V W X Y Z) do (
    if exist "%%d:\" (
        set /a unidades_subst+=1
    )
)

:: Contar ISOs montadas
wmic logicaldisk get volumename | findstr /i "iso" >nul
if !errorlevel! equ 0 set /a unidades_iso+=1

:: Contar VHDs
wmic logicaldisk get volumename | findstr /i "vhd" >nul
if !errorlevel! equ 0 set /a unidades_vhd+=1

:: Contar unidades RAM
imdisk -l | findstr /c:"RAM" >nul
if !errorlevel! equ 0 set /a unidades_ram+=1

echo Tipos de unidades virtuales:
echo - SUBST: %unidades_subst%
echo - ISO: %unidades_iso%
echo - VHD: %unidades_vhd%
echo - RAM: %unidades_ram%
echo.
pause
goto reportes_auditoria

:salir
echo.
echo ¡Hasta luego!
exit /b 0 