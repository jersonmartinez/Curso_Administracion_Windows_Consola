@echo off
setlocal enabledelayedexpansion
title GESTION COMPLETA DE PAPELERA DE RECICLAJE

echo ========================================
echo    GESTION COMPLETA DE PAPELERA DE RECICLAJE
echo ========================================
echo.

:menu_principal
cls
echo ========================================
echo    GESTION COMPLETA DE PAPELERA DE RECICLAJE
echo ========================================
echo.
echo 1. Verificar contenido
echo 2. Limpiar papelera
echo 3. Recuperar archivos
echo 4. Monitorear uso
echo 5. Limpieza automatica
echo 6. Backup de papelera
echo 7. Generar reportes
echo 8. Salir
echo.
set /p opcion="Seleccione una opcion: "

if "%opcion%"=="1" goto verificar_contenido
if "%opcion%"=="2" goto limpiar_papelera
if "%opcion%"=="3" goto recuperar_archivos
if "%opcion%"=="4" goto monitorear_uso
if "%opcion%"=="5" goto limpieza_automatica
if "%opcion%"=="6" goto backup_papelera
if "%opcion%"=="7" goto generar_reportes
if "%opcion%"=="8" goto salir
goto menu_principal

:verificar_contenido
cls
echo ========================================
echo    VERIFICAR CONTENIDO
echo ========================================
echo.
echo 1. Verificar papelera del sistema
echo 2. Verificar archivos temporales
echo 3. Verificar cache de internet
echo 4. Verificar todo
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto verificar_sistema
if "%subopcion%"=="2" goto verificar_temporales
if "%subopcion%"=="3" goto verificar_cache
if "%subopcion%"=="4" goto verificar_todo
if "%subopcion%"=="5" goto menu_principal
goto verificar_contenido

:verificar_sistema
cls
echo === VERIFICAR PAPELERA DEL SISTEMA ===
echo.
if exist "C:\$Recycle.Bin" (
    echo Papelera del sistema encontrada:
    dir "C:\$Recycle.Bin" /A /S
) else (
    echo Papelera del sistema no encontrada o vacia.
)
pause
goto verificar_contenido

:verificar_temporales
cls
echo === VERIFICAR ARCHIVOS TEMPORALES ===
echo.
if exist "%TEMP%" (
    echo Archivos temporales encontrados:
    dir "%TEMP%" /A | findstr /v "Directory"
) else (
    echo Directorio de archivos temporales no encontrado.
)
pause
goto verificar_contenido

:verificar_cache
cls
echo === VERIFICAR CACHE DE INTERNET ===
echo.
if exist "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" (
    echo Cache de internet encontrado:
    dir "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" /A
) else (
    echo Cache de internet no encontrado.
)
pause
goto verificar_contenido

:verificar_todo
cls
echo === VERIFICAR TODO ===
echo.
echo === PAPELERA DEL SISTEMA ===
if exist "C:\$Recycle.Bin" (
    dir "C:\$Recycle.Bin" /A /S
) else (
    echo Papelera del sistema no encontrada.
)

echo.
echo === ARCHIVOS TEMPORALES ===
if exist "%TEMP%" (
    dir "%TEMP%" /A | findstr /v "Directory"
) else (
    echo Directorio de archivos temporales no encontrado.
)

echo.
echo === CACHE DE INTERNET ===
if exist "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" (
    dir "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" /A
) else (
    echo Cache de internet no encontrado.
)
pause
goto verificar_contenido

:limpiar_papelera
cls
echo ========================================
echo    LIMPIAR PAPELERA
echo ========================================
echo.
echo 1. Limpiar papelera del sistema
echo 2. Limpiar archivos temporales
echo 3. Limpiar cache de internet
echo 4. Limpiar todo
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto limpiar_sistema
if "%subopcion%"=="2" goto limpiar_temporales
if "%subopcion%"=="3" goto limpiar_cache
if "%subopcion%"=="4" goto limpiar_todo
if "%subopcion%"=="5" goto menu_principal
goto limpiar_papelera

:limpiar_sistema
cls
echo === LIMPIAR PAPELERA DEL SISTEMA ===
echo.
echo ¿Estas seguro de limpiar la papelera del sistema?
set /p confirm="(s/n): "
if /i "%confirm%"=="s" (
    if exist "C:\$Recycle.Bin" (
        rd /s /q "C:\$Recycle.Bin" 2>nul
        echo Papelera del sistema limpiada.
    ) else (
        echo Papelera del sistema ya estaba vacia.
    )
) else (
    echo Operacion cancelada.
)
pause
goto limpiar_papelera

:limpiar_temporales
cls
echo === LIMPIAR ARCHIVOS TEMPORALES ===
echo.
echo ¿Estas seguro de limpiar los archivos temporales?
set /p confirm="(s/n): "
if /i "%confirm%"=="s" (
    del /q /f "%TEMP%\*.*" 2>nul
    echo Archivos temporales limpiados.
) else (
    echo Operacion cancelada.
)
pause
goto limpiar_papelera

:limpiar_cache
cls
echo === LIMPIAR CACHE DE INTERNET ===
echo.
echo ¿Estas seguro de limpiar el cache de internet?
set /p confirm="(s/n): "
if /i "%confirm%"=="s" (
    if exist "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" (
        rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" 2>nul
        echo Cache de internet limpiado.
    ) else (
        echo Cache de internet no encontrado.
    )
) else (
    echo Operacion cancelada.
)
pause
goto limpiar_papelera

:limpiar_todo
cls
echo === LIMPIAR TODO ===
echo.
echo ¿Estas seguro de limpiar todo?
set /p confirm="(s/n): "
if /i "%confirm%"=="s" (
    echo Limpiando papelera del sistema...
    if exist "C:\$Recycle.Bin" (
        rd /s /q "C:\$Recycle.Bin" 2>nul
    )
    
    echo Limpiando archivos temporales...
    del /q /f "%TEMP%\*.*" 2>nul
    
    echo Limpiando cache de internet...
    if exist "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" (
        rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" 2>nul
    )
    
    echo Limpieza completada.
) else (
    echo Operacion cancelada.
)
pause
goto limpiar_papelera

:recuperar_archivos
cls
echo ========================================
echo    RECUPERAR ARCHIVOS
echo ========================================
echo.
echo 1. Buscar archivo especifico
echo 2. Recuperar archivo
echo 3. Listar archivos disponibles
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto buscar_archivo
if "%subopcion%"=="2" goto recuperar_archivo
if "%subopcion%"=="3" goto listar_archivos
if "%subopcion%"=="4" goto menu_principal
goto recuperar_archivos

:buscar_archivo
cls
echo === BUSCAR ARCHIVO ESPECIFICO ===
echo.
set /p archivo="Nombre del archivo a buscar: "
if not "%archivo%"=="" (
    echo Buscando %archivo%...
    
    if exist "C:\$Recycle.Bin" (
        echo Buscando en papelera del sistema...
        for /r "C:\$Recycle.Bin" %%f in (%archivo%) do (
            echo Encontrado: %%f
        )
    )
    
    if exist "%TEMP%" (
        echo Buscando en archivos temporales...
        for /r "%TEMP%" %%f in (%archivo%) do (
            echo Encontrado: %%f
        )
    )
) else (
    echo Nombre de archivo no válido.
)
pause
goto recuperar_archivos

:recuperar_archivo
cls
echo === RECUPERAR ARCHIVO ===
echo.
set /p archivo="Nombre del archivo a recuperar: "
set /p destino="Directorio de destino: "

if not "%archivo%"=="" (
    if not exist "%destino%" mkdir "%destino%"
    
    echo Recuperando %archivo%...
    
    if exist "C:\$Recycle.Bin" (
        for /r "C:\$Recycle.Bin" %%f in (%archivo%) do (
            copy "%%f" "%destino%\" >nul
            echo Archivo recuperado: %%f
        )
    )
    
    if exist "%TEMP%" (
        for /r "%TEMP%" %%f in (%archivo%) do (
            copy "%%f" "%destino%\" >nul
            echo Archivo temporal recuperado: %%f
        )
    )
    
    echo Recuperacion completada.
) else (
    echo Nombre de archivo no válido.
)
pause
goto recuperar_archivos

:listar_archivos
cls
echo === LISTAR ARCHIVOS DISPONIBLES ===
echo.
echo Archivos en papelera del sistema:
if exist "C:\$Recycle.Bin" (
    dir "C:\$Recycle.Bin" /A /S /B
) else (
    echo Papelera del sistema vacia.
)

echo.
echo Archivos temporales:
if exist "%TEMP%" (
    dir "%TEMP%" /A /B | findstr /v "Directory"
) else (
    echo No hay archivos temporales.
)
pause
goto recuperar_archivos

:monitorear_uso
cls
echo ========================================
echo    MONITOREAR USO
echo ========================================
echo.
echo 1. Espacio usado por papelera
echo 2. Espacio usado por temporales
echo 3. Espacio total en disco
echo 4. Monitoreo completo
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto espacio_papelera
if "%subopcion%"=="2" goto espacio_temporales
if "%subopcion%"=="3" goto espacio_disco
if "%subopcion%"=="4" goto monitoreo_completo
if "%subopcion%"=="5" goto menu_principal
goto monitorear_uso

:espacio_papelera
cls
echo === ESPACIO USADO POR PAPELERA ===
echo.
if exist "C:\$Recycle.Bin" (
    echo Espacio usado por papelera del sistema:
    dir "C:\$Recycle.Bin" /S | find "File(s)"
) else (
    echo Papelera del sistema vacia.
)
pause
goto monitorear_uso

:espacio_temporales
cls
echo === ESPACIO USADO POR TEMPORALES ===
echo.
if exist "%TEMP%" (
    echo Espacio usado por archivos temporales:
    dir "%TEMP%" /S | find "File(s)"
) else (
    echo No hay archivos temporales.
)
pause
goto monitorear_uso

:espacio_disco
cls
echo === ESPACIO TOTAL EN DISCO ===
echo.
echo Espacio disponible en disco C:
dir C:\ /-c | find "bytes free"
pause
goto monitorear_uso

:monitoreo_completo
cls
echo === MONITOREO COMPLETO ===
echo.
echo === PAPELERA DEL SISTEMA ===
if exist "C:\$Recycle.Bin" (
    dir "C:\$Recycle.Bin" /S | find "File(s)"
) else (
    echo Papelera del sistema vacia.
)

echo.
echo === ARCHIVOS TEMPORALES ===
if exist "%TEMP%" (
    dir "%TEMP%" /S | find "File(s)"
) else (
    echo No hay archivos temporales.
)

echo.
echo === ESPACIO EN DISCO ===
dir C:\ /-c | find "bytes free"
pause
goto monitorear_uso

:limpieza_automatica
cls
echo ========================================
echo    LIMPIEZA AUTOMATICA
echo ========================================
echo.
echo 1. Limpiar archivos antiguos
echo 2. Limpiar por tamaño
echo 3. Limpiar por extension
echo 4. Limpieza completa automatica
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto limpiar_antiguos
if "%subopcion%"=="2" goto limpiar_tamaño
if "%subopcion%"=="3" goto limpiar_extension
if "%subopcion%"=="4" goto limpieza_completa
if "%subopcion%"=="5" goto menu_principal
goto limpieza_automatica

:limpiar_antiguos
cls
echo === LIMPIAR ARCHIVOS ANTIGUOS ===
echo.
set /p dias="Dias para limpiar archivos: "
if not "%dias%"=="" (
    echo Limpiando archivos de mas de %dias% dias...
    
    echo Limpiando archivos temporales antiguos...
    forfiles /p "%TEMP%" /s /d -%dias% /c "cmd /c del @path" 2>nul
    
    echo Limpiando cache de internet antiguo...
    if exist "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" (
        forfiles /p "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" /s /d -%dias% /c "cmd /c del @path" 2>nul
    )
    
    echo Limpieza de archivos antiguos completada.
) else (
    echo Numero de dias no válido.
)
pause
goto limpieza_automatica

:limpiar_tamaño
cls
echo === LIMPIAR POR TAMAÑO ===
echo.
set /p tamaño="Tamaño minimo en MB: "
if not "%tamaño%"=="" (
    echo Limpiando archivos mayores a %tamaño% MB...
    
    echo Limpiando archivos temporales grandes...
    forfiles /p "%TEMP%" /s /m *.* /c "cmd /c if @fsize gtr %tamaño%000000 del @path" 2>nul
    
    echo Limpieza por tamaño completada.
) else (
    echo Tamaño no válido.
)
pause
goto limpieza_automatica

:limpiar_extension
cls
echo === LIMPIAR POR EXTENSION ===
echo.
set /p extension="Extension a limpiar (ej: .tmp): "
if not "%extension%"=="" (
    echo Limpiando archivos con extension %extension%...
    
    echo Limpiando archivos temporales con extension %extension%...
    del /q /f /s "%TEMP%\*%extension%" 2>nul
    
    echo Limpieza por extension completada.
) else (
    echo Extension no válida.
)
pause
goto limpieza_automatica

:limpieza_completa
cls
echo === LIMPIEZA COMPLETA AUTOMATICA ===
echo.
echo ¿Estas seguro de realizar una limpieza completa automatica?
set /p confirm="(s/n): "
if /i "%confirm%"=="s" (
    echo Realizando limpieza completa automatica...
    
    echo Limpiando archivos temporales...
    del /q /f "%TEMP%\*.*" 2>nul
    
    echo Limpiando cache de internet...
    if exist "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" (
        rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache" 2>nul
    )
    
    echo Limpiando papelera del sistema...
    if exist "C:\$Recycle.Bin" (
        rd /s /q "C:\$Recycle.Bin" 2>nul
    )
    
    echo Limpieza completa automatica finalizada.
) else (
    echo Operacion cancelada.
)
pause
goto limpieza_automatica

:backup_papelera
cls
echo ========================================
echo    BACKUP DE PAPELERA
echo ========================================
echo.
echo 1. Crear backup de papelera
echo 2. Restaurar backup
echo 3. Listar backups disponibles
echo 4. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto crear_backup
if "%subopcion%"=="2" goto restaurar_backup
if "%subopcion%"=="3" goto listar_backups
if "%subopcion%"=="4" goto menu_principal
goto backup_papelera

:crear_backup
cls
echo === CREAR BACKUP DE PAPELERA ===
echo.
set /p backup_dir="Directorio de backup: "
if not "%backup_dir%"=="" (
    if not exist "%backup_dir%" mkdir "%backup_dir%"
    
    echo Creando backup de papelera...
    
    if exist "C:\$Recycle.Bin" (
        xcopy "C:\$Recycle.Bin" "%backup_dir%" /E /I /H /Y >nul
        echo Backup de papelera del sistema completado.
    ) else (
        echo Papelera del sistema vacia.
    )
    
    echo Backup completado en: %backup_dir%
) else (
    echo Directorio de backup no válido.
)
pause
goto backup_papelera

:restaurar_backup
cls
echo === RESTAURAR BACKUP ===
echo.
set /p backup_dir="Directorio de backup: "
if not "%backup_dir%"=="" (
    if exist "%backup_dir%" (
        echo Restaurando backup...
        xcopy "%backup_dir%" "C:\$Recycle.Bin" /E /I /H /Y >nul
        echo Backup restaurado.
    ) else (
        echo Directorio de backup no encontrado.
    )
) else (
    echo Directorio de backup no válido.
)
pause
goto backup_papelera

:listar_backups
cls
echo === LISTAR BACKUPS DISPONIBLES ===
echo.
echo Backups disponibles:
dir "C:\Backups\Papelera_*" /d /b 2>nul
if !errorlevel! neq 0 (
    echo No hay backups disponibles.
)
pause
goto backup_papelera

:generar_reportes
cls
echo ========================================
echo    GENERAR REPORTES
echo ========================================
echo.
echo 1. Reporte de contenido
echo 2. Reporte de uso de espacio
echo 3. Reporte de limpieza
echo 4. Reporte completo
echo 5. Volver al menu principal
echo.
set /p subopcion="Seleccione una opcion: "

if "%subopcion%"=="1" goto reporte_contenido
if "%subopcion%"=="2" goto reporte_espacio
if "%subopcion%"=="3" goto reporte_limpieza
if "%subopcion%"=="4" goto reporte_completo
if "%subopcion%"=="5" goto menu_principal
goto generar_reportes

:reporte_contenido
cls
echo === REPORTE DE CONTENIDO ===
echo.

set "reporte_file=reporte_contenido_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "reporte_file=%reporte_file: =0%"

echo Reporte de Contenido - %date% %time% > "%reporte_file%"
echo. >> "%reporte_file%"

echo === PAPELERA DEL SISTEMA === >> "%reporte_file%"
if exist "C:\$Recycle.Bin" (
    dir "C:\$Recycle.Bin" /A /S >> "%reporte_file%"
) else (
    echo Papelera del sistema vacia. >> "%reporte_file%"
)

echo Reporte generado: %reporte_file%
pause
goto generar_reportes

:reporte_espacio
cls
echo === REPORTE DE USO DE ESPACIO ===
echo.

set "reporte_file=reporte_espacio_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "reporte_file=%reporte_file: =0%"

echo Reporte de Uso de Espacio - %date% %time% > "%reporte_file%"
echo. >> "%reporte_file%"

echo === ESPACIO EN DISCO === >> "%reporte_file%"
dir C:\ /-c >> "%reporte_file%"

echo Reporte generado: %reporte_file%
pause
goto generar_reportes

:reporte_limpieza
cls
echo === REPORTE DE LIMPIEZA ===
echo.

set "reporte_file=reporte_limpieza_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "reporte_file=%reporte_file: =0%"

echo Reporte de Limpieza - %date% %time% > "%reporte_file%"
echo. >> "%reporte_file%"

echo === ARCHIVOS TEMPORALES === >> "%reporte_file%"
dir "%TEMP%" /S | find "File(s)" >> "%reporte_file%"

echo Reporte generado: %reporte_file%
pause
goto generar_reportes

:reporte_completo
cls
echo === REPORTE COMPLETO ===
echo.

set "reporte_file=reporte_completo_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
set "reporte_file=%reporte_file: =0%"

echo Reporte Completo de Papelera - %date% %time% > "%reporte_file%"
echo. >> "%reporte_file%"

echo === PAPELERA DEL SISTEMA === >> "%reporte_file%"
if exist "C:\$Recycle.Bin" (
    dir "C:\$Recycle.Bin" /A /S >> "%reporte_file%"
) else (
    echo Papelera del sistema vacia. >> "%reporte_file%"
)

echo. >> "%reporte_file%"
echo === ARCHIVOS TEMPORALES === >> "%reporte_file%"
dir "%TEMP%" /S >> "%reporte_file%"

echo. >> "%reporte_file%"
echo === ESPACIO EN DISCO === >> "%reporte_file%"
dir C:\ /-c >> "%reporte_file%"

echo Reporte completo generado: %reporte_file%
pause
goto generar_reportes

:salir
echo Gracias por usar la Gestion Completa de Papelera de Reciclaje
exit /b 0 