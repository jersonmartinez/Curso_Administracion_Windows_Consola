@echo off
setlocal enabledelayedexpansion
title Gestión Completa de Liberación de Espacio
color 0C

:: Verificar privilegios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Este script requiere privilegios de administrador.
    echo Ejecuta como administrador y vuelve a intentar.
    pause
    exit /b 1
)

:: Configuración
set "space_config=C:\Space_Config"
set "space_logs=C:\Space_Logs"
set "space_backup=C:\Space_Backup"

:: Crear directorios si no existen
if not exist "%space_config%" mkdir "%space_config%"
if not exist "%space_logs%" mkdir "%space_logs%"
if not exist "%space_backup%" mkdir "%space_backup%"

echo.
echo ========================================
echo    GESTIÓN COMPLETA DE LIBERACIÓN DE ESPACIO
echo ========================================
echo.

:menu_principal
echo [1] Análisis de espacio en disco
echo [2] Limpieza de archivos temporales
echo [3] Eliminación de archivos antiguos
echo [4] Limpieza de caché del navegador
echo [5] Limpieza de archivos de sistema
echo [6] Limpieza de papelera de reciclaje
echo [7] Compresión de archivos
echo [8] Limpieza completa del sistema
echo [9] Reportes y auditoría
echo [10] Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto analisis_espacio
if "%opcion%"=="2" goto limpieza_temporales
if "%opcion%"=="3" goto archivos_antiguos
if "%opcion%"=="4" goto limpieza_cache
if "%opcion%"=="5" goto limpieza_sistema
if "%opcion%"=="6" goto limpieza_papelera
if "%opcion%"=="7" goto compresion_archivos
if "%opcion%"=="8" goto limpieza_completa
if "%opcion%"=="9" goto reportes_auditoria
if "%opcion%"=="10" goto salir
goto menu_principal

:analisis_espacio
echo.
echo Análisis de espacio en disco:
echo =============================
echo.

echo Espacio disponible en unidades:
echo ═══════════════════════════════
wmic logicaldisk get deviceid,size,freespace,volumename

echo.
echo Análisis de directorios principales:
echo ════════════════════════════════════
echo.

echo 📁 Usuarios:
dir "C:\Users" /s | findstr "File(s)"
echo.

echo 📁 Programas:
dir "C:\Program Files" /s | findstr "File(s)"
echo.

echo 📁 Windows:
dir "C:\Windows" /s | findstr "File(s)"
echo.

pause
goto menu_principal

:limpieza_temporales
echo.
echo Limpieza de archivos temporales:
echo ================================
echo.

echo 📁 Limpiando archivos temporales del sistema...
del /q /f /s "%TEMP%\*.*" 2>nul
del /q /f /s "%TMP%\*.*" 2>nul

echo 📁 Limpiando archivos temporales del usuario...
del /q /f /s "%USERPROFILE%\AppData\Local\Temp\*.*" 2>nul

echo 📁 Limpiando archivos temporales de Windows...
del /q /f /s "C:\Windows\Temp\*.*" 2>nul

echo ✅ Limpieza de archivos temporales completada
echo.
pause
goto menu_principal

:archivos_antiguos
echo.
echo Eliminación de archivos antiguos:
echo =================================
echo.

set /p dias="Ingresa el número de días (ej: 30): "
set /p directorio="Ingresa el directorio (ej: C:\Users\%USERNAME%\Downloads): "

if not exist "%directorio%" (
    echo Error: El directorio no existe.
    pause
    goto archivos_antiguos
)

echo.
echo 🗑️ Eliminando archivos más antiguos de %dias% días en %directorio%...
forfiles /p "%directorio%" /s /m *.* /d -%dias% /c "cmd /c del @path" 2>nul

echo ✅ Eliminación de archivos antiguos completada
echo.
pause
goto menu_principal

:limpieza_cache
echo.
echo Limpieza de caché del navegador:
echo ================================
echo.

echo 🌐 Limpiando caché de Internet Explorer...
del /q /f /s "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache\*.*" 2>nul

echo 🌐 Limpiando caché de Chrome...
del /q /f /s "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache\*.*" 2>nul

echo 🌐 Limpiando caché de Firefox...
del /q /f /s "%USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles\*\cache2\*.*" 2>nul

echo 🌐 Limpiando caché de Edge...
del /q /f /s "%USERPROFILE%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*.*" 2>nul

echo ✅ Limpieza de caché completada
echo.
pause
goto menu_principal

:limpieza_sistema
echo.
echo Limpieza de archivos de sistema:
echo ================================
echo.

echo ⚠️ Esta operación eliminará archivos del sistema. ¿Continuar? (S/N):
set /p confirmar=""
if /i not "%confirmar%"=="S" goto menu_principal

echo.
echo 🔄 Limpiando puntos de restauración antiguos...
vssadmin delete shadows /for=C: /oldest /quiet

echo 📦 Limpiando actualizaciones descargadas...
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*.*" 2>nul

echo 🗂️ Limpiando archivos de hibernación...
powercfg /hibernate off
del /f "C:\hiberfil.sys" 2>nul
powercfg /hibernate on

echo 📝 Limpiando archivos de log antiguos...
forfiles /p "C:\Windows\Logs" /s /m *.log /d -60 /c "cmd /c del @path" 2>nul

echo ✅ Limpieza de sistema completada
echo.
pause
goto menu_principal

:limpieza_papelera
echo.
echo Limpieza de papelera de reciclaje:
echo ==================================
echo.

echo ⚠️ ¿Vaciar completamente la papelera de reciclaje? (S/N):
set /p confirmar=""
if /i not "%confirmar%"=="S" goto menu_principal

echo.
echo 🗑️ Vaciamiento de papelera de reciclaje...
rd /s /q C:\$Recycle.Bin 2>nul

echo ✅ Papelera de reciclaje vaciada
echo.
pause
goto menu_principal

:compresion_archivos
echo.
echo Compresión de archivos:
echo =======================
echo.

set /p directorio="Directorio a comprimir: "
set /p tamano="Tamaño mínimo en MB (ej: 10): "

if not exist "%directorio%" (
    echo Error: El directorio no existe.
    pause
    goto compresion_archivos
)

echo.
echo 📦 Comprimiendo archivos mayores a %tamano% MB...
for /r "%directorio%" %%f in (*.*) do (
    set /a "tamano_archivo=%%~zf/1048576"
    if !tamano_archivo! gtr %tamano% (
        echo Comprimiendo: %%~nxf
        compact /c "%%f"
    )
)

echo ✅ Compresión completada
echo.
pause
goto menu_principal

:limpieza_completa
echo.
echo Limpieza completa del sistema:
echo ==============================
echo.

echo ⚠️ Esta operación realizará una limpieza completa. ¿Continuar? (S/N):
set /p confirmar=""
if /i not "%confirmar%"=="S" goto menu_principal

echo.
echo 📊 Analizando espacio antes de la limpieza...
wmic logicaldisk get deviceid,size,freespace,caption

echo.
echo 🧹 Iniciando limpieza completa...

echo 📁 Limpiando archivos temporales...
del /q /f /s "%TEMP%\*.*" 2>nul
del /q /f /s "%TMP%\*.*" 2>nul
del /q /f /s "%USERPROFILE%\AppData\Local\Temp\*.*" 2>nul

echo 🌐 Limpiando caché del navegador...
del /q /f /s "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache\*.*" 2>nul

echo 🗑️ Eliminando archivos antiguos...
forfiles /p "%USERPROFILE%\Downloads" /s /m *.* /d -30 /c "cmd /c del @path" 2>nul

echo 📦 Limpiando actualizaciones...
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*.*" 2>nul

echo 🔄 Limpiando puntos de restauración...
vssadmin delete shadows /for=C: /oldest /quiet

echo 🗑️ Vaciamiento de papelera de reciclaje...
rd /s /q C:\$Recycle.Bin 2>nul

echo 📊 Analizando espacio después de la limpieza...
wmic logicaldisk get deviceid,size,freespace,caption

echo ✅ Limpieza completa finalizada
echo.
pause
goto menu_principal

:reportes_auditoria
echo.
echo [1] Generar reporte de espacio
echo [2] Auditoría de archivos grandes
echo [3] Análisis de uso de espacio
echo [4] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto generar_reporte
if "%sub_opcion%"=="2" goto auditoria_archivos_grandes
if "%sub_opcion%"=="3" goto analisis_uso_espacio
if "%sub_opcion%"=="4" goto menu_principal
goto reportes_auditoria

:generar_reporte
echo.
set /p report_name="Nombre del reporte: "
echo.
echo Generando reporte de espacio...

echo Reporte de Espacio en Disco > "%space_logs%\%report_name%.txt"
echo Fecha: %date% %time% >> "%space_logs%\%report_name%.txt"
echo ======================================== >> "%space_logs%\%report_name%.txt"
echo. >> "%space_logs%\%report_name%.txt"

echo ESPACIO EN UNIDADES: >> "%space_logs%\%report_name%.txt"
echo ════════════════════════════════════════════════════════════════ >> "%space_logs%\%report_name%.txt"
wmic logicaldisk get deviceid,size,freespace,caption >> "%space_logs%\%report_name%.txt"
echo. >> "%space_logs%\%report_name%.txt"

echo TAMAÑO DE DIRECTORIOS PRINCIPALES: >> "%space_logs%\%report_name%.txt"
echo ════════════════════════════════════════════════════════════════ >> "%space_logs%\%report_name%.txt"
dir "C:\Users" /s | findstr "File(s)" >> "%space_logs%\%report_name%.txt"
dir "C:\Program Files" /s | findstr "File(s)" >> "%space_logs%\%report_name%.txt"
dir "C:\Windows" /s | findstr "File(s)" >> "%space_logs%\%report_name%.txt"

echo Reporte generado: %space_logs%\%report_name%.txt
pause
goto reportes_auditoria

:auditoria_archivos_grandes
echo.
echo Auditoría de archivos grandes:
echo ==============================
echo.

set /p directorio="Directorio a auditar: "
set /p tamano="Tamaño mínimo en MB: "

if not exist "%directorio%" (
    echo Error: El directorio no existe.
    pause
    goto reportes_auditoria
)

echo.
echo 📊 Archivos mayores a %tamano% MB en %directorio%:
echo ════════════════════════════════════════════════════════════════

for /r "%directorio%" %%f in (*.*) do (
    set /a "tamano_archivo=%%~zf/1048576"
    if !tamano_archivo! gtr %tamano% (
        echo %%~nxf - !tamano_archivo! MB
    )
)

echo.
pause
goto reportes_auditoria

:analisis_uso_espacio
echo.
echo Análisis de uso de espacio:
echo ===========================
echo.

echo 📊 Análisis detallado de uso de espacio...
echo.

for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo 📁 Unidad %%d::
        for /f "tokens=3" %%f in ('dir %%d:\ /-c ^| findstr "bytes free"') do (
            set "espacio_libre=%%f"
            set /a "espacio_gb=!espacio_libre!/1073741824"
            echo   Espacio libre: !espacio_gb! GB
        )
        echo.
    )
)

pause
goto reportes_auditoria

:salir
echo.
echo ¡Hasta luego!
exit /b 0 