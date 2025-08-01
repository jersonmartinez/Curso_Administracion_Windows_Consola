@echo off
setlocal enabledelayedexpansion
title Gestión Completa de Servidor DHCP
color 0B

:: Configuración
set "dhcp_config=C:\DHCP_Config"
set "dhcp_logs=C:\DHCP_Logs"
set "dhcp_backup=C:\DHCP_Backup"

:: Crear directorios si no existen
if not exist "%dhcp_config%" mkdir "%dhcp_config%"
if not exist "%dhcp_logs%" mkdir "%dhcp_logs%"
if not exist "%dhcp_backup%" mkdir "%dhcp_backup%"

echo.
echo ========================================
echo    GESTIÓN COMPLETA DE SERVIDOR DHCP
echo ========================================
echo.

:menu_principal
echo [1] Instalar y configurar DHCP
echo [2] Gestionar ámbitos DHCP
echo [3] Gestionar reservas
echo [4] Configurar opciones
echo [5] Monitorear servidor
echo [6] Backup y restauración
echo [7] Logs y auditoría
echo [8] Mantenimiento
echo [9] Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto instalar_dhcp
if "%opcion%"=="2" goto gestionar_ambitos
if "%opcion%"=="3" goto gestionar_reservas
if "%opcion%"=="4" goto configurar_opciones
if "%opcion%"=="5" goto monitorear_servidor
if "%opcion%"=="6" goto backup_restauracion
if "%opcion%"=="7" goto logs_auditoria
if "%opcion%"=="8" goto mantenimiento
if "%opcion%"=="9" goto salir
goto menu_principal

:instalar_dhcp
echo.
echo Instalando y configurando servidor DHCP...
echo.

:: Verificar si DHCP está instalado
dism /online /get-featureinfo /featurename:DHCPServer | findstr "Enabled"
if errorlevel 1 (
    echo Instalando DHCP Server...
    dism /online /enable-feature /featurename:DHCPServer /all
)

:: Iniciar servicio
echo Iniciando servicio DHCP...
net start "DHCP Server" 2>nul

:: Autorizar servidor DHCP
echo Autorizando servidor DHCP...
netsh dhcp server add securitygroups

echo Servidor DHCP instalado y configurado.
pause
goto menu_principal

:gestionar_ambitos
echo.
echo [1] Crear nuevo ámbito
echo [2] Listar ámbitos existentes
echo [3] Activar/Desactivar ámbito
echo [4] Eliminar ámbito
echo [5] Configurar exclusiones
echo [6] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto crear_ambito
if "%sub_opcion%"=="2" goto listar_ambitos
if "%sub_opcion%"=="3" goto activar_ambito
if "%sub_opcion%"=="4" goto eliminar_ambito
if "%sub_opcion%"=="5" goto configurar_exclusiones
if "%sub_opcion%"=="6" goto menu_principal
goto gestionar_ambitos

:crear_ambito
echo.
set /p red="Red (ej: 192.168.1.0): "
set /p nombre="Nombre del ámbito: "
set /p inicio="IP inicial (ej: 192.168.1.100): "
set /p fin="IP final (ej: 192.168.1.200): "
set /p mascara="Máscara de subred (ej: 255.255.255.0): "

:: Crear ámbito
netsh dhcp server scope %red% add name="%nombre%" start=%inicio% end=%fin% mask=%mascara%

:: Activar ámbito
netsh dhcp server scope %red% set state 1

echo Ámbito %nombre% creado y activado.
pause
goto gestionar_ambitos

:listar_ambitos
echo.
echo Ámbitos DHCP configurados:
echo ---------------------------
netsh dhcp server scope show state
echo.
pause
goto gestionar_ambitos

:activar_ambito
echo.
set /p red="Red del ámbito: "
set /p estado="Estado (1=Activar, 0=Desactivar): "
netsh dhcp server scope %red% set state %estado%
echo Estado del ámbito actualizado.
pause
goto gestionar_ambitos

:eliminar_ambito
echo.
set /p red="Red del ámbito a eliminar: "
netsh dhcp server scope %red% delete
echo Ámbito eliminado.
pause
goto gestionar_ambitos

:configurar_exclusiones
echo.
set /p red="Red del ámbito: "
set /p inicio_excl="IP inicial de exclusión: "
set /p fin_excl="IP final de exclusión: "
netsh dhcp server scope %red% add excluderange %inicio_excl% %fin_excl%
echo Exclusión configurada.
pause
goto gestionar_ambitos

:gestionar_reservas
echo.
echo [1] Crear reserva
echo [2] Listar reservas
echo [3] Eliminar reserva
echo [4] Modificar reserva
echo [5] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto crear_reserva
if "%sub_opcion%"=="2" goto listar_reservas
if "%sub_opcion%"=="3" goto eliminar_reserva
if "%sub_opcion%"=="4" goto modificar_reserva
if "%sub_opcion%"=="5" goto menu_principal
goto gestionar_reservas

:crear_reserva
echo.
set /p red="Red del ámbito: "
set /p ip="Dirección IP: "
set /p mac="Dirección MAC (formato: 00-11-22-33-44-55): "
set /p nombre="Nombre del dispositivo: "
netsh dhcp server scope %red% add reservedip %ip% %mac% "%nombre%"
echo Reserva creada para %nombre%.
pause
goto gestionar_reservas

:listar_reservas
echo.
set /p red="Red del ámbito: "
echo Reservas en %red%:
echo ------------------
netsh dhcp server scope %red% show reservedip
echo.
pause
goto gestionar_reservas

:eliminar_reserva
echo.
set /p red="Red del ámbito: "
set /p ip="Dirección IP de la reserva: "
netsh dhcp server scope %red% delete reservedip %ip%
echo Reserva eliminada.
pause
goto gestionar_reservas

:modificar_reserva
echo.
set /p red="Red del ámbito: "
set /p ip="Dirección IP de la reserva: "
set /p nuevo_nombre="Nuevo nombre: "
netsh dhcp server scope %red% set reservedoptionvalue %ip% 12 STRING "%nuevo_nombre%"
echo Reserva modificada.
pause
goto gestionar_reservas

:configurar_opciones
echo.
echo [1] Configurar gateway
echo [2] Configurar DNS
echo [3] Configurar tiempo de arrendamiento
echo [4] Configurar WINS
echo [5] Ver opciones actuales
echo [6] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto configurar_gateway
if "%sub_opcion%"=="2" goto configurar_dns
if "%sub_opcion%"=="3" goto configurar_lease
if "%sub_opcion%"=="4" goto configurar_wins
if "%sub_opcion%"=="5" goto ver_opciones
if "%sub_opcion%"=="6" goto menu_principal
goto configurar_opciones

:configurar_gateway
echo.
set /p red="Red del ámbito: "
set /p gateway="Gateway (ej: 192.168.1.1): "
netsh dhcp server scope %red% set optionvalue 3 IPADDRESS %gateway%
echo Gateway configurado.
pause
goto configurar_opciones

:configurar_dns
echo.
set /p red="Red del ámbito: "
set /p dns1="DNS primario: "
set /p dns2="DNS secundario: "
netsh dhcp server scope %red% set optionvalue 6 IPADDRESS %dns1% %dns2%
echo Servidores DNS configurados.
pause
goto configurar_opciones

:configurar_lease
echo.
set /p red="Red del ámbito: "
set /p tiempo="Tiempo de arrendamiento en segundos: "
netsh dhcp server scope %red% set lease %tiempo%
echo Tiempo de arrendamiento configurado.
pause
goto configurar_opciones

:configurar_wins
echo.
set /p red="Red del ámbito: "
set /p wins="Servidor WINS: "
netsh dhcp server scope %red% set optionvalue 44 IPADDRESS %wins%
echo Servidor WINS configurado.
pause
goto configurar_opciones

:ver_opciones
echo.
set /p red="Red del ámbito: "
echo Opciones configuradas en %red%:
echo --------------------------------
netsh dhcp server scope %red% show optionvalue
echo.
pause
goto configurar_opciones

:monitorear_servidor
echo.
echo Monitoreando servidor DHCP...
echo Presiona Ctrl+C para detener
echo.

:monitoreo_loop
cls
echo ========================================
echo    MONITOREO DE SERVIDOR DHCP
echo    Hora: %time%
echo ========================================
echo.

echo Estado del servicio:
sc query "DHCPServer" | findstr "STATE"
echo.

echo Ámbitos activos:
netsh dhcp server scope show state | findstr "Active"
echo.

echo Estadísticas de arrendamientos:
netsh dhcp server show mibinfo
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
echo Creando backup del servidor DHCP...

:: Exportar configuración
netsh dhcp server export "%dhcp_backup%\%backup_nombre%.xml" all

:: Backup de logs
xcopy "%dhcp_logs%" "%dhcp_backup%\%backup_nombre%_logs\" /E /I /H

echo Backup creado: %dhcp_backup%\%backup_nombre%.xml
pause
goto backup_restauracion

:restaurar_backup
echo.
set /p backup_archivo="Archivo de backup a restaurar: "
echo.
echo Restaurando configuración DHCP...
netsh dhcp server import "%backup_archivo%"
echo Restauración completada.
pause
goto backup_restauracion

:exportar_config
echo.
set /p archivo="Nombre del archivo de exportación: "
echo.
echo Exportando configuración DHCP...
netsh dhcp server export "%archivo%" all
echo Configuración exportada.
pause
goto backup_restauracion

:importar_config
echo.
set /p archivo="Archivo de configuración a importar: "
echo.
echo Importando configuración DHCP...
netsh dhcp server import "%archivo%"
echo Configuración importada.
pause
goto backup_restauracion

:logs_auditoria
echo.
echo [1] Ver logs de eventos
echo [2] Ver estadísticas de arrendamientos
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
echo Últimos eventos del servidor DHCP:
echo ----------------------------------
wevtutil qe System /q:"*[System[Provider[@Name='Microsoft-Windows-DHCP-Server']]]" /c:20 /f:text
echo.
pause
goto logs_auditoria

:ver_estadisticas
echo.
echo Estadísticas de arrendamientos DHCP:
echo -------------------------------------
netsh dhcp server show mibinfo
echo.
pause
goto logs_auditoria

:configurar_logging
echo.
echo Configurando logging detallado...
netsh dhcp server set auditlog %dhcp_logs%
echo Logging configurado en: %dhcp_logs%
pause
goto logs_auditoria

:limpiar_logs
echo.
set /p dias="Eliminar logs más antiguos que (días): "
forfiles /p "%dhcp_logs%" /s /m *.log /d -%dias% /c "cmd /c del @path"
echo Logs antiguos eliminados.
pause
goto logs_auditoria

:mantenimiento
echo.
echo [1] Limpiar arrendamientos expirados
echo [2] Verificar integridad
echo [3] Optimizar rendimiento
echo [4] Volver al menú principal
echo.
set /p sub_opcion="Selecciona una opción: "

if "%sub_opcion%"=="1" goto limpiar_leases
if "%sub_opcion%"=="2" goto verificar_integridad
if "%sub_opcion%"=="3" goto optimizar_rendimiento
if "%sub_opcion%"=="4" goto menu_principal
goto mantenimiento

:limpiar_leases
echo.
echo Limpiando arrendamientos expirados...
netsh dhcp server scope show state | findstr "Active" > "%temp%\scopes.txt"
for /f "tokens=2" %%a in (%temp%\scopes.txt) do (
    echo Limpiando ámbito: %%a
    netsh dhcp server scope %%a set state 0
    timeout /t 2 /nobreak >nul
    netsh dhcp server scope %%a set state 1
)
del "%temp%\scopes.txt"
echo Limpieza completada.
pause
goto mantenimiento

:verificar_integridad
echo.
echo Verificando integridad del servidor DHCP...
sc query "DHCPServer" | findstr "RUNNING"
if errorlevel 1 (
    echo ERROR: Servicio DHCP no está ejecutándose
) else (
    echo Servicio DHCP funcionando correctamente
)
echo.
pause
goto mantenimiento

:optimizar_rendimiento
echo.
echo Optimizando rendimiento del servidor DHCP...
echo Configurando parámetros de red...
netsh interface tcp set global autotuninglevel=normal
echo Optimización completada.
pause
goto mantenimiento

:salir
echo.
echo ¡Hasta luego!
exit /b 0 