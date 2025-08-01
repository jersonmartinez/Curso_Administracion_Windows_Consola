@echo off
:: Gestor avanzado de usuarios del sistema
title 👥 Gestor de Usuarios
color 0A

:menu
cls
echo ========================================
echo    👥 GESTOR AVANZADO DE USUARIOS
echo ========================================
echo.
echo 1. ➕ Crear usuario
echo 2. ❌ Eliminar usuario
echo 3. 🔄 Modificar usuario
echo 4. 👁️ Ver usuarios
echo 5. 🔐 Cambiar contraseña
echo 6. 👥 Gestionar grupos
echo 7. 📊 Reporte de usuarios
echo 8. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto crear_usuario
if "%opcion%"=="2" goto eliminar_usuario
if "%opcion%"=="3" goto modificar_usuario
if "%opcion%"=="4" goto ver_usuarios
if "%opcion%"=="5" goto cambiar_password
if "%opcion%"=="6" goto gestionar_grupos
if "%opcion%"=="7" goto reporte_usuarios
if "%opcion%"=="8" goto salir
goto menu

:crear_usuario
cls
echo ========================================
echo         ➕ CREAR USUARIO
echo ========================================
echo.
set /p username="Nombre de usuario: "
set /p password="Contraseña: "
set /p fullname="Nombre completo: "
set /p comment="Comentario (opcional): "
set /p expires="Fecha de expiración (MM/DD/YYYY o never): "

echo 🔄 Creando usuario...
net user %username% %password% /add /fullname:"%fullname%"
if defined comment net user %username% /comment:"%comment%"
if not "%expires%"=="never" net user %username% /expires:%expires%

echo ✅ Usuario creado exitosamente
pause
goto menu

:eliminar_usuario
cls
echo ========================================
echo         ❌ ELIMINAR USUARIO
echo ========================================
echo.
set /p username="Nombre de usuario a eliminar: "
echo ⚠️ ¿Estás seguro de eliminar el usuario %username%?
set /p confirm="(S/N): "
if /i "%confirm%"=="S" (
    echo 🔄 Eliminando usuario...
    net user %username% /delete
    echo ✅ Usuario eliminado
) else (
    echo ❌ Operación cancelada
)
pause
goto menu

:modificar_usuario
cls
echo ========================================
echo         🔄 MODIFICAR USUARIO
echo ========================================
echo.
set /p username="Nombre de usuario: "
echo 1. Activar/Desactivar
echo 2. Cambiar nombre completo
echo 3. Cambiar comentario
echo 4. Establecer fecha de expiración
echo.
set /p mod="Selecciona modificación: "

if "%mod%"=="1" (
    set /p active="Activar (S/N): "
    if /i "%active%"=="S" net user %username% /active:yes
    if /i "%active%"=="N" net user %username% /active:no
) else if "%mod%"=="2" (
    set /p fullname="Nuevo nombre completo: "
    net user %username% /fullname:"%fullname%"
) else if "%mod%"=="3" (
    set /p comment="Nuevo comentario: "
    net user %username% /comment:"%comment%"
) else if "%mod%"=="4" (
    set /p expires="Nueva fecha de expiración: "
    net user %username% /expires:%expires%
)

echo ✅ Usuario modificado
pause
goto menu

:ver_usuarios
cls
echo ========================================
echo         👁️ VER USUARIOS
echo ========================================
echo.
echo 🔍 Listando usuarios del sistema...
net user
echo.
pause
goto menu

:cambiar_password
cls
echo ========================================
echo         🔐 CAMBIAR CONTRASEÑA
echo ========================================
echo.
set /p username="Nombre de usuario: "
set /p password="Nueva contraseña: "
echo 🔄 Cambiando contraseña...
net user %username% %password%
echo ✅ Contraseña cambiada
pause
goto menu

:gestionar_grupos
cls
echo ========================================
echo         👥 GESTIONAR GRUPOS
echo ========================================
echo.
set /p username="Nombre de usuario: "
echo 1. Agregar a grupo
echo 2. Remover de grupo
echo 3. Ver grupos del usuario
echo.
set /p op="Selecciona opción: "

if "%op%"=="1" (
    set /p group="Nombre del grupo: "
    net localgroup %group% %username% /add
    echo ✅ Usuario agregado al grupo
) else if "%op%"=="2" (
    set /p group="Nombre del grupo: "
    net localgroup %group% %username% /delete
    echo ✅ Usuario removido del grupo
) else if "%op%"=="3" (
    echo 🔍 Grupos del usuario %username%:
    net user %username%
)
pause
goto menu

:reporte_usuarios
cls
echo ========================================
echo         📊 REPORTE DE USUARIOS
echo ========================================
echo.
echo 🔄 Generando reporte...
echo === REPORTE DE USUARIOS === > reporte_usuarios.txt
echo Fecha: %date% %time% >> reporte_usuarios.txt
echo. >> reporte_usuarios.txt
net user >> reporte_usuarios.txt
echo. >> reporte_usuarios.txt
echo === GRUPOS === >> reporte_usuarios.txt
net localgroup >> reporte_usuarios.txt
echo ✅ Reporte generado en reporte_usuarios.txt
pause
goto menu

:salir
exit 