@echo off
:: Gestor avanzado del usuario Administrador
title 👑 Gestor del Usuario Administrador
color 0A

:menu
cls
echo ========================================
echo    👑 GESTOR DEL USUARIO ADMINISTRADOR
echo ========================================
echo.
echo 1. ✅ Habilitar Administrador
echo 2. ❌ Deshabilitar Administrador
echo 3. 🔐 Cambiar contraseña
echo 4. 👁️ Ver estado
echo 5. 🔧 Configurar políticas
echo 6. 📊 Reporte de seguridad
echo 7. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto habilitar_admin
if "%opcion%"=="2" goto deshabilitar_admin
if "%opcion%"=="3" goto cambiar_password
if "%opcion%"=="4" goto ver_estado
if "%opcion%"=="5" goto configurar_politicas
if "%opcion%"=="6" goto reporte_seguridad
if "%opcion%"=="7" goto salir
goto menu

:habilitar_admin
cls
echo ========================================
echo         ✅ HABILITAR ADMINISTRADOR
echo ========================================
echo.
echo ⚠️ ADVERTENCIA: Esta operación habilita la cuenta más poderosa del sistema
echo.
set /p confirm="¿Estás seguro? (S/N): "
if /i "%confirm%"=="S" (
    echo 🔄 Habilitando usuario Administrador...
    net user Administrator /active:yes
    if %errorlevel%==0 (
        echo ✅ Usuario Administrador habilitado
        echo.
        set /p password="¿Deseas establecer una contraseña? (S/N): "
        if /i "%password%"=="S" (
            set /p newpass="Nueva contraseña: "
            net user Administrator %newpass%
            echo ✅ Contraseña establecida
        )
    ) else (
        echo ❌ Error al habilitar el usuario
    )
) else (
    echo ❌ Operación cancelada
)
pause
goto menu

:deshabilitar_admin
cls
echo ========================================
echo         ❌ DESHABILITAR ADMINISTRADOR
echo ========================================
echo.
echo ⚠️ ADVERTENCIA: Esta operación deshabilita la cuenta de Administrador
echo.
set /p confirm="¿Estás seguro? (S/N): "
if /i "%confirm%"=="S" (
    echo 🔄 Deshabilitando usuario Administrador...
    net user Administrator /active:no
    if %errorlevel%==0 (
        echo ✅ Usuario Administrador deshabilitado
    ) else (
        echo ❌ Error al deshabilitar el usuario
    )
) else (
    echo ❌ Operación cancelada
)
pause
goto menu

:cambiar_password
cls
echo ========================================
echo         🔐 CAMBIAR CONTRASEÑA
echo ========================================
echo.
set /p password="Nueva contraseña: "
echo 🔄 Cambiando contraseña del Administrador...
net user Administrator %password%
if %errorlevel%==0 (
    echo ✅ Contraseña cambiada exitosamente
) else (
    echo ❌ Error al cambiar la contraseña
)
pause
goto menu

:ver_estado
cls
echo ========================================
echo         👁️ VER ESTADO
echo ========================================
echo.
echo 🔍 Estado del usuario Administrador:
net user Administrator
echo.
echo === VERIFICACIÓN ADICIONAL ===
wmic useraccount where name="Administrator" get name,disabled,lockout 2>nul
pause
goto menu

:configurar_politicas
cls
echo ========================================
echo         🔧 CONFIGURAR POLÍTICAS
echo ========================================
echo.
echo 1. Requerir contraseña
echo 2. Permitir cambio de contraseña
echo 3. Establecer fecha de expiración
echo 4. Configurar comentario
echo.
set /p politica="Selecciona política: "

if "%politica%"=="1" (
    set /p req="¿Requerir contraseña? (S/N): "
    if /i "%req%"=="S" net user Administrator /passwordreq:yes
    if /i "%req%"=="N" net user Administrator /passwordreq:no
) else if "%politica%"=="2" (
    set /p chg="¿Permitir cambio de contraseña? (S/N): "
    if /i "%chg%"=="S" net user Administrator /passwordchg:yes
    if /i "%chg%"=="N" net user Administrator /passwordchg:no
) else if "%politica%"=="3" (
    set /p expires="Fecha de expiración (MM/DD/YYYY o never): "
    net user Administrator /expires:%expires%
) else if "%politica%"=="4" (
    set /p comment="Comentario: "
    net user Administrator /comment:"%comment%"
)

echo ✅ Política configurada
pause
goto menu

:reporte_seguridad
cls
echo ========================================
echo         📊 REPORTE DE SEGURIDAD
echo ========================================
echo.
echo 🔄 Generando reporte de seguridad...
echo === REPORTE DE SEGURIDAD === > reporte_admin.txt
echo Fecha: %date% %time% >> reporte_admin.txt
echo. >> reporte_admin.txt
echo === ESTADO DEL ADMINISTRADOR === >> reporte_admin.txt
net user Administrator >> reporte_admin.txt
echo. >> reporte_admin.txt
echo === USUARIOS ADMINISTRATIVOS === >> reporte_admin.txt
net localgroup Administradores >> reporte_admin.txt
echo. >> reporte_admin.txt
echo === VERIFICACIÓN WMIC === >> reporte_admin.txt
wmic useraccount where name="Administrator" get name,disabled,lockout >> reporte_admin.txt 2>&1
echo ✅ Reporte generado en reporte_admin.txt
pause
goto menu

:salir
exit 