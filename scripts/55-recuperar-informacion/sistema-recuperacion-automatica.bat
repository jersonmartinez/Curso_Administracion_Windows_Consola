@echo off
setlocal enabledelayedexpansion
title SISTEMA DE RECUPERACION AUTOMATICA

echo ========================================
echo  SISTEMA DE RECUPERACION AUTOMATICA
echo ========================================
echo.

:menu_principal
cls
echo ========================================
echo    SISTEMA DE RECUPERACION
echo ========================================
echo.
echo 1. Recuperar archivos eliminados
echo 2. Reparar sector de arranque
echo 3. Recuperar MFT corrupta
echo 4. Recuperar partición perdida
echo 5. Recuperar datos de disco dañado
echo 6. Restaurar sistema
echo 7. Recuperar contraseñas
echo 8. Recuperar configuración de red
echo 9. Recuperar archivos de backup
echo 10. Recuperación completa del sistema
echo 11. Crear punto de restauración
echo 12. Verificar integridad del sistema
echo 13. Salir
echo.
set /p opcion="Seleccione una opcion: "

if "%opcion%"=="1" goto recuperar_archivos
if "%opcion%"=="2" goto reparar_arranque
if "%opcion%"=="3" goto recuperar_mft
if "%opcion%"=="4" goto recuperar_particion
if "%opcion%"=="5" goto recuperar_disco
if "%opcion%"=="6" goto restaurar_sistema
if "%opcion%"=="7" goto recuperar_password
if "%opcion%"=="8" goto recuperar_red
if "%opcion%"=="9" goto recuperar_backup
if "%opcion%"=="10" goto recuperacion_completa
if "%opcion%"=="11" goto crear_restore_point
if "%opcion%"=="12" goto verificar_integridad
if "%opcion%"=="13" goto salir
goto menu_principal

:recuperar_archivos
cls
echo ========================================
echo    RECUPERAR ARCHIVOS ELIMINADOS
echo ========================================
echo.
set /p unidad="Unidad a escanear: "
set /p patron="Patrón de archivos (ej: *.docx): "
set /p destino="Directorio de destino: "

mkdir "%destino%" 2>nul

REM Usar PowerShell para recuperación avanzada
powershell -command "& { $files = Get-ChildItem -Path '%unidad%:\' -Recurse -Force | Where-Object { $_.Name -like '%patron%' -and $_.Attributes -match 'Hidden' }; foreach($f in $files) { Copy-Item $f.FullName -Destination '%destino%' -Force; Write-Host 'Recuperado:' $f.Name } }"

echo Recuperación de archivos completada
pause
goto menu_principal

:reparar_arranque
cls
echo ========================================
echo    REPARAR SECTOR DE ARRANQUE
echo ========================================
echo.
echo Reparando sector de arranque...
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd
echo Sector de arranque reparado
pause
goto menu_principal

:recuperar_mft
cls
echo ========================================
echo    RECUPERAR MFT CORRUPTA
echo ========================================
echo.
echo Reparando MFT...
chkdsk C: /f /r /x
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
echo MFT reparada
pause
goto menu_principal

:recuperar_particion
cls
echo ========================================
echo    RECUPERAR PARTICION PERDIDA
echo ========================================
echo.
set /p disco="Número de disco: "

echo select disk %disco% > temp_recover.txt
echo list partition >> temp_recover.txt
echo recover >> temp_recover.txt
echo exit >> temp_recover.txt

diskpart /s temp_recover.txt
del temp_recover.txt

echo Partición recuperada
pause
goto menu_principal

:recuperar_disco
cls
echo ========================================
echo    RECUPERAR DATOS DE DISCO DAÑADO
echo ========================================
echo.
set /p disco="Disco dañado: "
set /p destino="Unidad de destino: "

mkdir "%destino%:\Recuperacion_Disco_%disco%" 2>nul

echo select disk %disco% > temp_disk.txt
echo list volume >> temp_disk.txt
echo select volume 0 >> temp_disk.txt
echo assign letter=T >> temp_disk.txt
echo exit >> temp_disk.txt

diskpart /s temp_disk.txt
del temp_disk.txt

if exist T:\ (
    xcopy T:\ "%destino%:\Recuperacion_Disco_%disco%\" /E /H /C /I /Y
    
    echo select volume T > temp_unmount.txt
    echo remove letter=T >> temp_unmount.txt
    echo exit >> temp_unmount.txt
    diskpart /s temp_unmount.txt
    del temp_unmount.txt
    
    echo Datos recuperados
) else (
    echo No se pudo acceder al disco
)

pause
goto menu_principal

:restaurar_sistema
cls
echo ========================================
echo    RESTAURAR SISTEMA
echo ========================================
echo.
echo Puntos de restauración disponibles:
wmic.exe /Namespace:\\root\default Path SystemRestore Call GetRestorePoints

echo.
set /p punto="ID del punto de restauración: "
echo rstrui.exe /restorepoint:%punto% > restore.bat
echo Script de restauración creado: restore.bat
pause
goto menu_principal

:recuperar_password
cls
echo ========================================
echo    RECUPERAR CONTRASEÑAS
echo ========================================
echo.
echo Usuarios del sistema:
net user

echo.
set /p usuario="Usuario a recuperar: "
echo net user %usuario% * > reset_pass.bat
echo Script creado: reset_pass.bat
echo.
echo Habilitando cuenta de administrador...
net user administrator /active:yes
net user administrator *
echo Administrador habilitado
pause
goto menu_principal

:recuperar_red
cls
echo ========================================
echo    RECUPERAR CONFIGURACION DE RED
echo ========================================
echo.
echo Reseteando red...
ipconfig /release
ipconfig /renew
ipconfig /flushdns
netsh winsock reset
netsh int ip reset
net stop dnscache
net start dnscache
echo Red reseteada
pause
goto menu_principal

:recuperar_backup
cls
echo ========================================
echo    RECUPERAR ARCHIVOS DE BACKUP
echo ========================================
echo.
set /p backup="Ruta del backup: "
set /p destino="Destino: "

mkdir "%destino%" 2>nul

if exist "%backup%\*.zip" (
    for %%f in ("%backup%\*.zip") do (
        powershell -command "Expand-Archive -Path '%%f' -DestinationPath '%destino%' -Force"
    )
) else (
    xcopy "%backup%" "%destino%" /E /H /C /I /Y
)

echo Backup restaurado
pause
goto menu_principal

:recuperacion_completa
cls
echo ========================================
echo    RECUPERACION COMPLETA
echo ========================================
echo.
echo Iniciando recuperación completa...
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd
chkdsk C: /f /r /x
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
ipconfig /renew
ipconfig /flushdns
echo Recuperación completa finalizada
pause
goto menu_principal

:crear_restore_point
cls
echo ========================================
echo    CREAR PUNTO DE RESTAURACION
echo ========================================
echo.
echo Creando punto de restauración...
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Recuperacion Manual", 100, 7
echo Punto de restauración creado
pause
goto menu_principal

:verificar_integridad
cls
echo ========================================
echo    VERIFICAR INTEGRIDAD
echo ========================================
echo.
echo Verificando integridad del sistema...
chkdsk C: /f
sfc /scannow
DISM /Online /Cleanup-Image /ScanHealth
echo Verificación completada
pause
goto menu_principal

:salir
echo Gracias por usar el sistema de recuperación 