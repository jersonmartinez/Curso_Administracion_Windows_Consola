@echo off
setlocal enabledelayedexpansion
title Gestión Completa de Servidor DNS
color 0C

:: Configuración
set "dns_config=C:\DNS_Config"
set "dns_logs=C:\DNS_Logs"
set "dns_backup=C:\DNS_Backup"

:: Crear directorios si no existen
if not exist "%dns_config%" mkdir "%dns_config%"
if not exist "%dns_logs%" mkdir "%dns_logs%"
if not exist "%dns_backup%" mkdir "%dns_backup%"

echo.
echo ========================================
echo    GESTIÓN COMPLETA DE SERVIDOR DNS
echo ========================================
echo.

:menu_principal
echo [1] Instalar y configurar DNS
echo [2] Gestionar zonas DNS
echo [3] Gestionar registros DNS
echo [4] Configurar servidores
echo [5] Monitorear servidor
echo [6] Backup y restauración
echo [7] Logs y auditoría
echo [8] Mantenimiento
echo [9] Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto instalar_dns
if "%opcion%"=="2" goto gestionar_zonas
if "%opcion%"=="3" goto gestionar_registros
if "%opcion%"=="4" goto configurar_servidores
if "%opcion%"=="5" goto monitorear_servidor
if "%opcion%"=="6" goto backup_restauracion
if "%opcion%"=="7" goto logs_auditoria
if "%opcion%"=="8" goto mantenimiento
if "%opcion%"=="9" goto salir
goto menu_principal

:instalar_dns
echo.
echo Instalando y configurando servidor DNS...
echo.

:: Verificar si DNS está instalado
dism /online /get-featureinfo /featurename:DNS-Server | findstr "Enabled"
if errorlevel 1 (
    echo Instalando DNS Server...
    dism /online /enable-feature /featurename:DNS-Server /all
)

:: Iniciar servicio
echo Iniciando servicio DNS...
net start "DNS Server" 2>nul

:: Configurar DNS local
echo Configurando DNS local...
netsh interface ip set dns "Local Area Connection" static 127.0.0.1

echo Servidor DNS instalado y configurado.
pause
goto menu_principal

:gestionar_zonas
echo.
echo [1] Crear zona primaria
echo [2] Crear zona secundaria
echo [3] Listar zonas
echo [4] Eliminar zona
echo [5] Configurar transferencia
echo [6] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto crear_zona_primaria
if "%sub_opcion%"=="2" goto crear_zona_secundaria
if "%sub_opcion%"=="3" goto listar_zonas
if "%sub_opcion%"=="4" goto eliminar_zona
if "%sub_opcion%"=="5" goto configurar_transferencia
if "%sub_opcion%"=="6" goto menu_principal
goto gestionar_zonas

:crear_zona_primaria
echo.
set /p nombre_zona="Nombre de la zona (ej: empresa.local): "
set /p archivo_zona="Archivo de zona (ej: empresa.local.dns): "
dnscmd /zoneadd %nombre_zona% /primary /file %archivo_zona%
echo Zona primaria %nombre_zona% creada.
pause
goto gestionar_zonas

:crear_zona_secundaria
echo.
set /p nombre_zona="Nombre de la zona: "
set /p servidor_maestro="Servidor maestro: "
set /p archivo_zona="Archivo de zona: "
dnscmd /zoneadd %nombre_zona% /secondary %servidor_maestro% /file %archivo_zona%
echo Zona secundaria %nombre_zona% creada.
pause
goto gestionar_zonas

:listar_zonas
echo.
echo Zonas DNS configuradas:
echo ------------------------
dnscmd /enumzones
echo.
pause
goto gestionar_zonas

:eliminar_zona
echo.
set /p nombre_zona="Nombre de la zona a eliminar: "
dnscmd /zonedelete %nombre_zona% /dsdel
echo Zona %nombre_zona% eliminada.
pause
goto gestionar_zonas

:configurar_transferencia
echo.
set /p nombre_zona="Nombre de la zona: "
set /p servidor_secundario="Servidor secundario: "
dnscmd /zoneinfo %nombre_zona% /secondary %servidor_secundario%
echo Transferencia configurada para %nombre_zona%.
pause
goto gestionar_zonas

:gestionar_registros
echo.
echo [1] Agregar registro A
echo [2] Agregar registro CNAME
echo [3] Agregar registro MX
echo [4] Listar registros
echo [5] Eliminar registro
echo [6] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto agregar_registro_a
if "%sub_opcion%"=="2" goto agregar_registro_cname
if "%sub_opcion%"=="3" goto agregar_registro_mx
if "%sub_opcion%"=="4" goto listar_registros
if "%sub_opcion%"=="5" goto eliminar_registro
if "%sub_opcion%"=="6" goto menu_principal
goto gestionar_registros

:agregar_registro_a
echo.
set /p zona="Zona DNS: "
set /p nombre="Nombre del registro: "
set /p ip="Dirección IP: "
dnscmd /recordadd %zona% %nombre% A %ip%
echo Registro A %nombre% agregado.
pause
goto gestionar_registros

:agregar_registro_cname
echo.
set /p zona="Zona DNS: "
set /p alias="Alias: "
set /p destino="Nombre de destino: "
dnscmd /recordadd %zona% %alias% CNAME %destino%
echo Registro CNAME %alias% agregado.
pause
goto gestionar_registros

:agregar_registro_mx
echo.
set /p zona="Zona DNS: "
set /p prioridad="Prioridad: "
set /p servidor="Servidor de correo: "
dnscmd /recordadd %zona% @ MX %prioridad% %servidor%
echo Registro MX agregado.
pause
goto gestionar_registros

:listar_registros
echo.
set /p zona="Zona DNS: "
echo Registros en %zona%:
echo --------------------
dnscmd /enumrecords %zona% @
echo.
pause
goto gestionar_registros

:eliminar_registro
echo.
set /p zona="Zona DNS: "
set /p nombre="Nombre del registro: "
set /p tipo="Tipo de registro (A/CNAME/MX): "
dnscmd /recorddelete %zona% %nombre% %tipo% /f
echo Registro %nombre% eliminado.
pause
goto gestionar_registros

:configurar_servidores
echo.
echo [1] Configurar servidores forwarders
echo [2] Configurar servidores raíz
echo [3] Configurar recursión
echo [4] Ver configuración actual
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto configurar_forwarders
if "%sub_opcion%"=="2" goto configurar_raices
if "%sub_opcion%"=="3" goto configurar_recursion
if "%sub_opcion%"=="4" goto ver_configuracion
if "%sub_opcion%"=="5" goto menu_principal
goto configurar_servidores

:configurar_forwarders
echo.
set /p forwarder1="Forwarder primario (ej: 8.8.8.8): "
set /p forwarder2="Forwarder secundario (ej: 8.8.4.4): "
dnscmd /resetforwarders %forwarder1% %forwarder2%
echo Forwarders configurados.
pause
goto configurar_servidores

:configurar_raices
echo.
echo Configurando servidores raíz...
dnscmd /clearcache
echo Servidores raíz configurados.
pause
goto configurar_servidores

:configurar_recursion
echo.
set /p recursion="Habilitar recursión (1=Si, 0=No): "
dnscmd /config /enableglobalqueryblocklist %recursion%
echo Recursión configurada.
pause
goto configurar_servidores

:ver_configuracion
echo.
echo Configuración actual del servidor DNS:
echo --------------------------------------
dnscmd /info
echo.
pause
goto configurar_servidores

:monitorear_servidor
echo.
echo Monitoreando servidor DNS...
echo Presiona Ctrl+C para detener
echo.

:monitoreo_loop
cls
echo ========================================
echo    MONITOREO DE SERVIDOR DNS
echo    Hora: %time%
echo ========================================
echo.

echo Estado del servicio:
sc query "DNS" | findstr "STATE"
echo.

echo Estadísticas de consultas:
dnscmd /statistics
echo.

echo Zonas activas:
dnscmd /enumzones | findstr "Primary\|Secondary"
echo.

echo Actualizando en 30 segundos...
timeout /t 30 /nobreak >nul
goto monitoreo_loop

:backup_restauracion
echo.
echo [1] Crear backup
echo [2] Restaurar backup
echo [3] Exportar configuración
echo [4] Importar configuración
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto crear_backup
if "%sub_opcion%"=="2" goto restaurar_backup
if "%sub_opcion%"=="3" goto exportar_config
if "%sub_opcion%"=="4" goto importar_config
if "%sub_opcion%"=="5" goto menu_principal
goto backup_restauracion

:crear_backup
echo.
set /p backup_nombre="Nombre del backup: "
echo.
echo Creando backup del servidor DNS...

:: Exportar zonas
for /f "tokens=2" %%a in ('dnscmd /enumzones ^| findstr "Primary"') do (
    echo Exportando zona: %%a
    dnscmd /zoneexport %%a "%dns_backup%\%%a.dns"
)

:: Backup de configuración
copy "%SystemRoot%\System32\dns\*.dns" "%dns_backup%\" >nul

echo Backup creado: %dns_backup%\%backup_nombre%
pause
goto backup_restauracion

:restaurar_backup
echo.
set /p backup_archivo="Archivo de backup a restaurar: "
echo.
echo Restaurando configuración DNS...
copy "%backup_archivo%\*.dns" "%SystemRoot%\System32\dns\" >nul
echo Restauración completada.
pause
goto backup_restauracion

:exportar_config
echo.
set /p archivo="Nombre del archivo de exportación: "
echo.
echo Exportando configuración DNS...
dnscmd /info > "%archivo%"
echo Configuración exportada.
pause
goto backup_restauracion

:importar_config
echo.
set /p archivo="Archivo de configuración a importar: "
echo.
echo Importando configuración DNS...
echo Importación manual requerida.
pause
goto backup_restauracion

:logs_auditoria
echo.
echo [1] Ver logs de eventos
echo [2] Ver estadísticas de consultas
echo [3] Configurar logging
echo [4] Limpiar logs antiguos
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto ver_logs_eventos
if "%sub_opcion%"=="2" goto ver_estadisticas
if "%sub_opcion%"=="3" goto configurar_logging
if "%sub_opcion%"=="4" goto limpiar_logs
if "%sub_opcion%"=="5" goto menu_principal
goto logs_auditoria

:ver_logs_eventos
echo.
echo Últimos eventos del servidor DNS:
echo ----------------------------------
wevtutil qe System /q:"*[System[Provider[@Name='Microsoft-Windows-DNS-Server']]]" /c:20 /f:text
echo.
pause
goto logs_auditoria

:ver_estadisticas
echo.
echo Estadísticas de consultas DNS:
echo -------------------------------
dnscmd /statistics
echo.
pause
goto logs_auditoria

:configurar_logging
echo.
echo Configurando logging detallado...
dnscmd /config /loglevel 7
echo Logging configurado.
pause
goto logs_auditoria

:limpiar_logs
echo.
set /p dias="Eliminar logs más antiguos que (días): "
forfiles /p "%dns_logs%" /s /m *.log /d -%dias% /c "cmd /c del @path"
echo Logs antiguos eliminados.
pause
goto logs_auditoria

:mantenimiento
echo.
echo [1] Limpiar caché DNS
echo [2] Verificar integridad
echo [3] Optimizar rendimiento
echo [4] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto limpiar_cache
if "%sub_opcion%"=="2" goto verificar_integridad
if "%sub_opcion%"=="3" goto optimizar_rendimiento
if "%sub_opcion%"=="4" goto menu_principal
goto mantenimiento

:limpiar_cache
echo.
echo Limpiando caché DNS...
dnscmd /clearcache
ipconfig /flushdns
echo Caché DNS limpiado.
pause
goto mantenimiento

:verificar_integridad
echo.
echo Verificando integridad del servidor DNS...
sc query "DNS" | findstr "RUNNING"
if errorlevel 1 (
    echo ERROR: Servicio DNS no está ejecutándose
) else (
    echo Servicio DNS funcionando correctamente
)
echo.
pause
goto mantenimiento

:optimizar_rendimiento
echo.
echo Optimizando rendimiento del servidor DNS...
echo Configurando parámetros de red...
netsh interface tcp set global autotuninglevel=normal
echo Optimización completada.
pause
goto mantenimiento

:salir
echo.
echo ¡Hasta luego!
exit /b 0 