@echo off
setlocal enabledelayedexpansion
title 💾 GESTOR COMPLETO DE FORMATEO DE DISCOS

:menu_principal
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║            💾 GESTOR DE FORMATEO DE DISCOS 💾               ║
echo ║                    Sistema de Preparación Avanzada           ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] 💾 Formateo básico de unidad
echo [2] 🔍 Formateo completo con verificación
echo [3] 📱 Formateo para dispositivos USB
echo [4] ⚙️ Formateo con clúster personalizado
echo [5] 🔄 Formateo de múltiples unidades
echo [6] 🔧 Formateo avanzado con DISKPART
echo [7] 🖥️ Formateo para sistema operativo
echo [8] 📦 Formateo con compresión
echo [9] 🌐 Formateo para almacenamiento de red
echo [0] ❌ Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto formateo_basico
if "%opcion%"=="2" goto formateo_completo
if "%opcion%"=="3" goto formateo_usb
if "%opcion%"=="4" goto formateo_cluster
if "%opcion%"=="5" goto formateo_multiple
if "%opcion%"=="6" goto formateo_diskpart
if "%opcion%"=="7" goto formateo_sistema
if "%opcion%"=="8" goto formateo_compresion
if "%opcion%"=="9" goto formateo_red
if "%opcion%"=="0" goto salir
goto menu_principal

:formateo_basico
cls
echo.
echo 💾 FORMATEO BÁSICO DE UNIDAD
echo ════════════════════════════════════════════════════════════════
echo.
set /p unidad="Letra de unidad (ej: D): "
set /p etiqueta="Etiqueta del volumen (ej: DATOS): "

echo.
echo ⚠️  Formateando unidad %unidad%: con NTFS...
format %unidad%: /FS:NTFS /Q /V:%etiqueta% /Y

echo ✅ Formateo básico completado
pause
goto menu_principal

:formateo_completo
cls
echo.
echo 🔍 FORMATEO COMPLETO CON VERIFICACIÓN
echo ════════════════════════════════════════════════════════════════
echo.
echo ⚠️  Esta operación puede tomar varias horas
echo.
set /p confirmar="¿Continuar? (S/N): "
if /i not "%confirmar%"=="S" goto menu_principal

set /p unidad="Letra de unidad (ej: E): "
set /p etiqueta="Etiqueta del volumen (ej: DATOS_COMPLETOS): "

echo.
echo 🔍 Iniciando formateo completo...
format %unidad%: /FS:NTFS /V:%etiqueta% /Y

echo ✅ Formateo completo finalizado
pause
goto menu_principal

:formateo_usb
cls
echo.
echo 📱 FORMATEO PARA DISPOSITIVOS USB
echo ════════════════════════════════════════════════════════════════
echo.
echo [1] FAT32 (Máxima compatibilidad)
echo [2] exFAT (Archivos grandes)
echo [3] NTFS (Windows)
echo.
set /p tipo_usb="Selecciona tipo de formateo: "

set /p unidad="Letra de unidad USB (ej: F): "
set /p etiqueta="Etiqueta del volumen (ej: USB_DATOS): "

if "%tipo_usb%"=="1" (
    echo 📱 Formateando con FAT32...
    format %unidad%: /FS:FAT32 /Q /V:%etiqueta% /Y
) else if "%tipo_usb%"=="2" (
    echo 📱 Formateando con exFAT...
    format %unidad%: /FS:exFAT /Q /V:%etiqueta% /Y
) else if "%tipo_usb%"=="3" (
    echo 📱 Formateando con NTFS...
    format %unidad%: /FS:NTFS /Q /V:%etiqueta% /Y
)

echo ✅ Formateo USB completado
pause
goto menu_principal

:formateo_cluster
cls
echo.
echo ⚙️ FORMATEO CON CLÚSTER PERSONALIZADO
echo ════════════════════════════════════════════════════════════════
echo.
echo Tamaños de clúster disponibles:
echo [1] 512 bytes (Archivos pequeños)
echo [2] 4KB (Estándar)
echo [3] 16KB (Archivos medianos)
echo [4] 32KB (Archivos grandes)
echo [5] 64KB (Archivos muy grandes)
echo.
set /p tamano_cluster="Selecciona tamaño de clúster: "

set /p unidad="Letra de unidad (ej: G): "
set /p etiqueta="Etiqueta del volumen (ej: OPTIMIZADO): "

if "%tamano_cluster%"=="1" set "cluster=512"
if "%tamano_cluster%"=="2" set "cluster=4096"
if "%tamano_cluster%"=="3" set "cluster=16384"
if "%tamano_cluster%"=="4" set "cluster=32768"
if "%tamano_cluster%"=="5" set "cluster=65536"

echo.
echo ⚙️ Formateando con clúster de %cluster% bytes...
format %unidad%: /FS:NTFS /A:%cluster% /Q /V:%etiqueta% /Y

echo ✅ Formateo con clúster personalizado completado
pause
goto menu_principal

:formateo_multiple
cls
echo.
echo 🔄 FORMATEO DE MÚLTIPLES UNIDADES
echo ════════════════════════════════════════════════════════════════
echo.
echo ⚠️  Esta operación formateará múltiples unidades
echo.
set /p confirmar="¿Continuar? (S/N): "
if /i not "%confirmar%"=="S" goto menu_principal

echo.
echo 🔄 Formateando múltiples unidades...

for %%d in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo 📁 Formateando unidad %%d:...
        format %%d: /FS:NTFS /Q /V:UNIDAD_%%d /Y
        echo.
    )
)

echo ✅ Formateo de múltiples unidades completado
pause
goto menu_principal

:formateo_diskpart
cls
echo.
echo 🔧 FORMATEO AVANZADO CON DISKPART
echo ════════════════════════════════════════════════════════════════
echo.
echo ⚠️  Esta operación requiere conocimientos avanzados
echo.
set /p confirmar="¿Continuar? (S/N): "
if /i not "%confirmar%"=="S" goto menu_principal

set /p disco="Número de disco (ej: 1): "
set /p unidad="Letra de unidad (ej: D): "
set /p etiqueta="Etiqueta del volumen (ej: DISKPART): "

echo.
echo 🔧 Creando script de DISKPART...
echo select disk %disco% > "%TEMP%\diskpart_script.txt"
echo clean >> "%TEMP%\diskpart_script.txt"
echo create partition primary >> "%TEMP%\diskpart_script.txt"
echo format fs=ntfs quick label="%etiqueta%" >> "%TEMP%\diskpart_script.txt"
echo assign letter=%unidad% >> "%TEMP%\diskpart_script.txt"
echo exit >> "%TEMP%\diskpart_script.txt"

echo ⚠️  Ejecutando formateo con DISKPART...
diskpart /s "%TEMP%\diskpart_script.txt"

echo 🗑️ Limpiando archivo temporal...
del "%TEMP%\diskpart_script.txt"

echo ✅ Formateo con DISKPART completado
pause
goto menu_principal

:formateo_sistema
cls
echo.
echo 🖥️ FORMATEO PARA SISTEMA OPERATIVO
echo ════════════════════════════════════════════════════════════════
echo.
echo ⚠️  Esta operación preparará un disco para sistema operativo
echo.
set /p confirmar="¿Continuar? (S/N): "
if /i not "%confirmar%"=="S" goto menu_principal

set /p unidad="Letra de unidad del sistema (ej: C): "
set /p etiqueta="Etiqueta del sistema (ej: SISTEMA): "

echo.
echo 🖥️ Preparando disco para sistema operativo...
format %unidad%: /FS:NTFS /V:%etiqueta% /Y

echo.
echo 🔧 Configurando optimizaciones del sistema...
fsutil behavior set disablelastaccess 1
fsutil behavior set disable8dot3 1

echo ✅ Disco preparado para sistema operativo
pause
goto menu_principal

:formateo_compresion
cls
echo.
echo 📦 FORMATEO CON COMPRESIÓN
echo ════════════════════════════════════════════════════════════════
echo.
set /p unidad="Letra de unidad (ej: H): "
set /p etiqueta="Etiqueta del volumen (ej: COMPRIMIDO): "

echo.
echo 📦 Formateando con compresión...
format %unidad%: /FS:NTFS /Q /V:%etiqueta% /Y

echo.
echo 🔧 Habilitando compresión del sistema de archivos...
compact /c /s %unidad%:\ /i /q

echo ✅ Formateo con compresión completado
pause
goto menu_principal

:formateo_red
cls
echo.
echo 🌐 FORMATEO PARA ALMACENAMIENTO DE RED
echo ════════════════════════════════════════════════════════════════
echo.
set /p unidad="Letra de unidad (ej: I): "
set /p etiqueta="Etiqueta del volumen (ej: RED): "

echo.
echo 🌐 Preparando disco para almacenamiento de red...
format %unidad%: /FS:NTFS /A:32768 /Q /V:%etiqueta% /Y

echo.
echo 🔧 Configurando optimizaciones de red...
fsutil behavior set disablelastaccess 1
fsutil behavior set mftzone 2

echo ✅ Disco preparado para almacenamiento de red
pause
goto menu_principal

:salir
echo.
echo 👋 ¡Gracias por usar el Gestor de Formateo de Discos!
echo.
exit /b 0 