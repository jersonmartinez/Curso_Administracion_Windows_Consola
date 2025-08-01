@echo off
:: Gestor de servicios con herramientas externas
title 🔧 Gestor de Servicios
color 0D

echo ========================================
echo    🔧 GESTOR DE SERVICIOS CON HERRAMIENTAS EXTERNAS
echo ========================================
echo.

:: Verificar si NSSM está disponible
if exist "C:\Tools\nssm.exe" (
    echo ✅ NSSM encontrado
    
    :: Instalar servicio con NSSM
    echo 🔄 Instalando servicio personalizado...
    C:\Tools\nssm.exe install MiServicio "C:\MiApp\app.exe"
    C:\Tools\nssm.exe set MiServicio AppDirectory "C:\MiApp"
    C:\Tools\nssm.exe set MiServicio Description "Servicio personalizado"
    
    echo ✅ Servicio instalado con NSSM
) else (
    echo ⚠️ NSSM no encontrado, usando servicios nativos
    sc create MiServicio binPath= "C:\MiApp\app.exe"
)

:: Usar herramientas de monitoreo
if exist "C:\Tools\processhacker.exe" (
    echo 🔍 Iniciando monitor de procesos...
    start "" "C:\Tools\processhacker.exe"
)

echo.
pause 