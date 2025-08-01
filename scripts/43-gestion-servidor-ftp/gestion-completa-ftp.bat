@echo off
setlocal enabledelayedexpansion
title Gestión Completa de Servidor FTP
color 0D

:: Configuración
set "ftp_root=C:\FTP_Root"
set "ftp_logs=C:\FTP_Logs"
set "ftp_users=C:\FTP_Users"

:: Crear directorios si no existen
if not exist "%ftp_root%" mkdir "%ftp_root%"
if not exist "%ftp_logs%" mkdir "%ftp_logs%"
if not exist "%ftp_users%" mkdir "%ftp_users%"

echo.
echo ========================================
echo    GESTIÓN COMPLETA DE SERVIDOR FTP
echo ========================================
echo.

:menu_principal
echo [1] Instalar y configurar FTP
echo [2] Gestionar usuarios FTP
echo [3] Configurar directorios
echo [4] Configurar firewall
echo [5] Monitorear servidor
echo [6] Backup de configuración
echo [7] Logs y auditoría
echo [8] Mantenimiento
echo [9] Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto instalar_ftp
if "%opcion%"=="2" goto gestionar_usuarios
if "%opcion%"=="3" goto configurar_directorios
if "%opcion%"=="4" goto configurar_firewall
if "%opcion%"=="5" goto monitorear_servidor
if "%opcion%"=="6" goto backup_configuracion
if "%opcion%"=="7" goto logs_auditoria
if "%opcion%"=="8" goto mantenimiento
if "%opcion%"=="9" goto salir
goto menu_principal

:instalar_ftp
echo.
echo Instalando y configurando servidor FTP...
echo.

:: Verificar si IIS está instalado
dism /online /get-featureinfo /featurename:IIS-WebServerRole | findstr "Enabled"
if errorlevel 1 (
    echo Instalando IIS...
    dism /online /enable-feature /featurename:IIS-WebServerRole /all
)

:: Instalar FTP
echo Instalando FTP Server...
dism /online /enable-feature /featurename:IIS-FTPServer /all

:: Iniciar servicios
echo Iniciando servicios...
net start "W3SVC" 2>nul
net start "FTPSVC" 2>nul

:: Configurar directorio raíz
echo Configurando directorio raíz...
icacls "%ftp_root%" /grant "IUSR:(OI)(CI)F" /grant "IIS_IUSRS:(OI)(CI)F"

echo Servidor FTP instalado y configurado.
pause
goto menu_principal

:gestionar_usuarios
echo.
echo [1] Crear usuario FTP
echo [2] Eliminar usuario FTP
echo [3] Listar usuarios
echo [4] Cambiar contraseña
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto crear_usuario
if "%sub_opcion%"=="2" goto eliminar_usuario
if "%sub_opcion%"=="3" goto listar_usuarios
if "%sub_opcion%"=="4" goto cambiar_password
if "%sub_opcion%"=="5" goto menu_principal
goto gestionar_usuarios

:crear_usuario
echo.
set /p username="Nombre de usuario: "
set /p password="Contraseña: "
set /p directorio="Directorio personal (opcional): "

:: Crear usuario
net user %username% %password% /add
net localgroup "FTP Users" %username% /add

:: Crear directorio personal si se especifica
if not "%directorio%"=="" (
    mkdir "%ftp_root%\%directorio%" 2>nul
    icacls "%ftp_root%\%directorio%" /grant "%username%:(OI)(CI)F"
)

echo Usuario %username% creado exitosamente.
pause
goto gestionar_usuarios

:eliminar_usuario
echo.
set /p username="Nombre de usuario a eliminar: "
net user %username% /delete
echo Usuario %username% eliminado.
pause
goto gestionar_usuarios

:listar_usuarios
echo.
echo Usuarios FTP:
echo -------------
net localgroup "FTP Users"
echo.
pause
goto gestionar_usuarios

:cambiar_password
echo.
set /p username="Nombre de usuario: "
set /p new_password="Nueva contraseña: "
net user %username% %new_password%
echo Contraseña cambiada para %username%.
pause
goto gestionar_usuarios

:configurar_directorios
echo.
echo [1] Crear directorio público
echo [2] Crear directorio privado
echo [3] Configurar permisos
echo [4] Listar estructura
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto crear_publico
if "%sub_opcion%"=="2" goto crear_privado
if "%sub_opcion%"=="3" goto configurar_permisos
if "%sub_opcion%"=="4" goto listar_estructura
if "%sub_opcion%"=="5" goto menu_principal
goto configurar_directorios

:crear_publico
echo.
set /p nombre="Nombre del directorio público: "
mkdir "%ftp_root%\%nombre%"
icacls "%ftp_root%\%nombre%" /grant "Everyone:(OI)(CI)R"
echo Directorio público %nombre% creado.
pause
goto configurar_directorios

:crear_privado
echo.
set /p nombre="Nombre del directorio privado: "
set /p usuario="Usuario propietario: "
mkdir "%ftp_root%\%nombre%"
icacls "%ftp_root%\%nombre%" /grant "%usuario%:(OI)(CI)F"
echo Directorio privado %nombre% creado para %usuario%.
pause
goto configurar_directorios

:configurar_permisos
echo.
set /p directorio="Ruta del directorio: "
set /p usuario="Usuario: "
set /p permisos="Permisos (F=Full, R=Read, W=Write): "
icacls "%directorio%" /grant "%usuario%:(OI)(CI)%permisos%"
echo Permisos configurados.
pause
goto configurar_directorios

:listar_estructura
echo.
echo Estructura del servidor FTP:
echo ----------------------------
tree "%ftp_root%" /f
echo.
pause
goto configurar_directorios

:configurar_firewall
echo.
echo Configurando reglas de firewall para FTP...
echo.

:: Regla para puerto de control
netsh advfirewall firewall add rule name="FTP Control" dir=in action=allow protocol=TCP localport=21

:: Regla para modo pasivo
netsh advfirewall firewall add rule name="FTP Passive" dir=in action=allow protocol=TCP localport=1024-65535

:: Regla para modo activo
netsh advfirewall firewall add rule name="FTP Active" dir=in action=allow protocol=TCP localport=20

echo Reglas de firewall configuradas.
pause
goto menu_principal

:monitorear_servidor
echo.
echo Monitoreando servidor FTP...
echo Presiona Ctrl+C para detener
echo.

:monitoreo_loop
cls
echo ========================================
echo    MONITOREO DE SERVIDOR FTP
echo    Hora: %time%
echo ========================================
echo.

echo Estado del servicio:
sc query "FTPSVC" | findstr "STATE"
echo.

echo Conexiones activas:
netstat -an | findstr :21
echo.

echo Uso de disco:
dir "%ftp_root%" /s | findstr "File(s)"
echo.

echo Actualizando en 30 segundos...
timeout /t 30 /nobreak >nul
goto monitoreo_loop

:backup_configuracion
echo.
set /p backup_nombre="Nombre del backup: "
echo.
echo Creando backup de configuración FTP...

:: Crear directorio de backup
mkdir "backup_%backup_nombre%" 2>nul

:: Copiar configuración
xcopy "%ftp_root%" "backup_%backup_nombre%\ftp_root\" /E /I /H
xcopy "%ftp_logs%" "backup_%backup_nombre%\ftp_logs\" /E /I /H

:: Exportar usuarios
net localgroup "FTP Users" > "backup_%backup_nombre%\ftp_users.txt"

:: Exportar reglas de firewall
netsh advfirewall firewall show rule name="FTP*" > "backup_%backup_nombre%\firewall_rules.txt"

echo Backup creado: backup_%backup_nombre%
pause
goto menu_principal

:logs_auditoria
echo.
echo [1] Ver logs de conexiones
echo [2] Ver logs de errores
echo [3] Configurar logging
echo [4] Limpiar logs antiguos
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto ver_logs_conexiones
if "%sub_opcion%"=="2" goto ver_logs_errores
if "%sub_opcion%"=="3" goto configurar_logging
if "%sub_opcion%"=="4" goto limpiar_logs
if "%sub_opcion%"=="5" goto menu_principal
goto logs_auditoria

:ver_logs_conexiones
echo.
echo Últimas conexiones FTP:
echo -----------------------
findstr "FTP" "%ftp_logs%\*.log" | tail -20
echo.
pause
goto logs_auditoria

:ver_logs_errores
echo.
echo Últimos errores FTP:
echo --------------------
findstr "ERROR" "%ftp_logs%\*.log" | tail -20
echo.
pause
goto logs_auditoria

:configurar_logging
echo.
echo Configurando logging detallado...
netsh advfirewall set logging allowedconnections enable
netsh advfirewall set logging droppedconnections enable
echo Logging configurado.
pause
goto logs_auditoria

:limpiar_logs
echo.
set /p dias="Eliminar logs más antiguos que (días): "
forfiles /p "%ftp_logs%" /s /m *.log /d -%dias% /c "cmd /c del @path"
echo Logs antiguos eliminados.
pause
goto logs_auditoria

:mantenimiento
echo.
echo [1] Limpiar archivos temporales
echo [2] Verificar integridad
echo [3] Optimizar rendimiento
echo [4] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto limpiar_temporales
if "%sub_opcion%"=="2" goto verificar_integridad
if "%sub_opcion%"=="3" goto optimizar_rendimiento
if "%sub_opcion%"=="4" goto menu_principal
goto mantenimiento

:limpiar_temporales
echo.
echo Limpiando archivos temporales FTP...
del /q "%ftp_root%\*.tmp" 2>nul
del /q "%ftp_root%\*.temp" 2>nul
echo Limpieza completada.
pause
goto mantenimiento

:verificar_integridad
echo.
echo Verificando integridad del servidor FTP...
sc query "FTPSVC" | findstr "RUNNING"
if errorlevel 1 (
    echo ERROR: Servicio FTP no está ejecutándose
) else (
    echo Servicio FTP funcionando correctamente
)
echo.
pause
goto mantenimiento

:optimizar_rendimiento
echo.
echo Optimizando rendimiento del servidor FTP...
echo Configurando buffer de red...
netsh interface tcp set global autotuninglevel=normal
echo Optimización completada.
pause
goto mantenimiento

:salir
echo.
echo ¡Hasta luego!
exit /b 0 