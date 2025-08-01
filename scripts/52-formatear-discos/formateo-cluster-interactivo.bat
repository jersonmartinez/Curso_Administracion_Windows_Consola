@echo off
REM Formateo con tamaño de clúster personalizado de forma interactiva

echo ⚙️ FORMATEO CON CLÚSTER PERSONALIZADO (INTERACTIVO)
echo ====================================================

echo Tamaños de clúster disponibles:
echo [1] 512 bytes (Archivos pequeños)
echo [2] 4KB (Estándar)
echo [3] 16KB (Archivos medianos)
echo [4] 32KB (Archivos grandes)
echo [5] 64KB (Archivos muy grandes)
set /p tamano_cluster="Selecciona tamaño de clúster: "
set /p unidad="Letra de unidad (ej: G): "
set /p etiqueta="Etiqueta del volumen (ej: OPTIMIZADO): "

if "%tamano_cluster%"=="1" set "cluster=512"
if "%tamano_cluster%"=="2" set "cluster=4096"
if "%tamano_cluster%"=="3" set "cluster=16384"
if "%tamano_cluster%"=="4" set "cluster=32768"
if "%tamano_cluster%"=="5" set "cluster=65536"

echo ⚙️ Formateando con clúster de %cluster% bytes...
format %unidad%: /FS:NTFS /A:%cluster% /Q /V:%etiqueta% /Y

echo ✅ Formateo con clúster personalizado completado
echo.
pause
