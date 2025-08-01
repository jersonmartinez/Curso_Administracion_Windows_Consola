@echo off
:: Gestor avanzado de programas externos
title 🔗 Gestor de Programas Externos
color 0A

:menu
cls
echo ========================================
echo    🔗 GESTOR DE PROGRAMAS EXTERNOS
echo ========================================
echo.
echo 1. 🚀 Ejecutar programa
echo 2. 🔧 Instalar software
echo 3. 💻 Herramientas de desarrollo
echo 4. 🗄️ Herramientas de backup
echo 5. 🌐 Herramientas de red
echo 6. 🛡️ Herramientas de seguridad
echo 7. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto ejecutar_programa
if "%opcion%"=="2" goto instalar_software
if "%opcion%"=="3" goto herramientas_dev
if "%opcion%"=="4" goto herramientas_backup
if "%opcion%"=="5" goto herramientas_red
if "%opcion%"=="6" goto herramientas_seguridad
if "%opcion%"=="7" goto salir
goto menu

:ejecutar_programa
cls
echo ========================================
echo         🚀 EJECUTAR PROGRAMA
echo ========================================
echo.
set /p programa="Ruta del programa: "
set /p parametros="Parámetros (opcional): "
if exist "%programa%" (
    echo 🔄 Ejecutando programa...
    start "" "%programa%" %parametros%
    echo ✅ Programa ejecutado.
) else (
    echo ❌ Programa no encontrado.
)
pause
goto menu

:instalar_software
cls
echo ========================================
echo         🔧 INSTALAR SOFTWARE
echo ========================================
echo.
set /p instalador="Ruta del instalador: "
if exist "%instalador%" (
    echo 🔄 Instalando software...
    start /wait "" "%instalador%" /silent
    echo ✅ Software instalado.
) else (
    echo ❌ Instalador no encontrado.
)
pause
goto menu

:herramientas_dev
cls
echo ========================================
echo         💻 HERRAMIENTAS DE DESARROLLO
echo ========================================
echo.
echo 1. Git
echo 2. Node.js
echo 3. Python
echo 4. Visual Studio Code
echo.
set /p dev_tool="Selecciona herramienta: "
if "%dev_tool%"=="1" start "" "C:\Program Files\Git\bin\git.exe"
if "%dev_tool%"=="2" start "" "C:\Program Files\nodejs\node.exe"
if "%dev_tool%"=="3" start "" "C:\Python39\python.exe"
if "%dev_tool%"=="4" start "" "C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\Code.exe"
pause
goto menu

:herramientas_backup
cls
echo ========================================
echo         🗄️ HERRAMIENTAS DE BACKUP
echo ========================================
echo.
echo 1. 7-Zip
echo 2. Robocopy
echo 3. Acronis
echo.
set /p backup_tool="Selecciona herramienta: "
if "%backup_tool%"=="1" start "" "C:\Program Files\7-Zip\7zFM.exe"
if "%backup_tool%"=="2" start cmd /k robocopy /?
if "%backup_tool%"=="3" start "" "C:\Program Files\Acronis\TrueImage\TrueImage.exe"
pause
goto menu

:herramientas_red
cls
echo ========================================
echo         🌐 HERRAMIENTAS DE RED
echo ========================================
echo.
echo 1. Wireshark
echo 2. Nmap
echo 3. PuTTY
echo.
set /p net_tool="Selecciona herramienta: "
if "%net_tool%"=="1" start "" "C:\Program Files\Wireshark\wireshark.exe"
if "%net_tool%"=="2" start "" "C:\Program Files (x86)\Nmap\nmap.exe"
if "%net_tool%"=="3" start "" "C:\Program Files\PuTTY\putty.exe"
pause
goto menu

:herramientas_seguridad
cls
echo ========================================
echo         🛡️ HERRAMIENTAS DE SEGURIDAD
echo ========================================
echo.
echo 1. Malwarebytes
echo 2. Avast
echo 3. Windows Defender
echo.
set /p sec_tool="Selecciona herramienta: "
if "%sec_tool%"=="1" start "" "C:\Program Files\Malwarebytes\Anti-Malware\mbam.exe"
if "%sec_tool%"=="2" start "" "C:\Program Files\Avast Software\Avast\avast.exe"
if "%sec_tool%"=="3" start "" "C:\Program Files\Windows Defender\MSASCui.exe"
pause
goto menu

:salir
exit 