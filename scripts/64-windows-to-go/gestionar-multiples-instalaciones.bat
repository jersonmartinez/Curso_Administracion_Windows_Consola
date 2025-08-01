@echo off
echo ========================================
echo    GESTIONAR MULTIPLES INSTALACIONES
echo ========================================
echo.

echo Gestionando multiples instalaciones...
echo Gestion iniciada: %date% %time%

REM Configuración
set "inventory_file=inventory_wtg.txt"
set "backup_dir=C:\Backups\WindowsToGo"

REM Crear inventario
echo INVENTARIO WINDOWS TO GO > %inventory_file%
echo ======================================== >> %inventory_file%
echo Fecha: %date% %time% >> %inventory_file%
echo. >> %inventory_file%

REM Detectar dispositivos USB
echo === DETECTANDO DISPOSITIVOS USB ===
for %%d in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\Windows\System32" (
        echo Dispositivo Windows To Go encontrado: %%d: >> %inventory_file%
    )
)

echo Inventario guardado en: %inventory_file%
pause
