@echo off
:: Eliminar variables de entorno
echo ========================================
echo    ELIMINAR VARIABLES DE ENTORNO
echo ========================================
echo.

echo ⚠️  ADVERTENCIA: Este script elimina variables de entorno
echo    Ejecutar como Administrador para variables de sistema
echo.

echo 🔄 Eliminación temporal de MYPATH:
SET MYPATH=
echo ✅ MYPATH eliminada temporalmente
echo.

echo 🗑️  Eliminación persistente a nivel de usuario:
REG delete "HKCU\Environment" /v MYPATH /f
REG delete "HKCU\Environment" /v CursoAWC /f
echo ✅ Variables eliminadas (usuario)
echo.

echo 🗑️  Eliminación persistente a nivel de sistema:
REG delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /F /V MYPATH
REG delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /F /V CursoAWC
echo ✅ Variables eliminadas (sistema)
echo.

echo 💡 Verificar eliminación desde interfaz gráfica
echo.
pause 