@echo off
echo ========================================
echo  RESTAURAR SISTEMA
echo ========================================
echo.

echo Puntos de restauración disponibles:
wmic.exe /Namespace:\\root\default Path SystemRestore Call GetRestorePoints

echo.
set /p punto="ID del punto de restauración: "

echo @echo off > restore_system.bat
echo echo Restaurando sistema al punto %punto%... >> restore_system.bat
echo rstrui.exe /restorepoint:%punto% >> restore_system.bat
echo pause >> restore_system.bat

echo Script de restauración creado: restore_system.bat
echo Ejecute el script como administrador para restaurar
echo.
echo ADVERTENCIA: Esto reiniciará el sistema
pause
