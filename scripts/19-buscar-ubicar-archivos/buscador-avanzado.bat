@echo off
:: Buscador avanzado interactivo
title 🔍 Buscador Avanzado de Archivos
color 0B

:menu
cls
echo ========================================
echo      🔍 BUSCADOR AVANZADO DE ARCHIVOS
echo ========================================
echo.
echo 1. 🔍 Buscar por nombre
echo 2. 📅 Buscar por fecha
echo 3. 📊 Buscar por tamaño
echo 4. 🔎 Buscar contenido
echo 5. 🎨 Buscar por tipo
echo 6. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto buscar_nombre
if "%opcion%"=="2" goto buscar_fecha
if "%opcion%"=="3" goto buscar_tamaño
if "%opcion%"=="4" goto buscar_contenido
if "%opcion%"=="5" goto buscar_tipo
if "%opcion%"=="6" goto salir
goto menu

:buscar_nombre
cls
echo ========================================
echo         🔍 BUSCAR POR NOMBRE
echo ========================================
echo.
set /p nombre="Ingresa el nombre del archivo: "
echo.
echo 🔍 Buscando "%nombre%"...
WHERE /R C:\ "%nombre%"
echo.
pause
goto menu

:buscar_fecha
cls
echo ========================================
echo         📅 BUSCAR POR FECHA
echo ========================================
echo.
set /p dias="Días hacia atrás: "
echo.
echo 🔍 Archivos modificados en los últimos %dias% días...
forfiles /s /m *.* /d -%dias% /c "cmd /c echo @path - @fdate"
echo.
pause
goto menu

:buscar_tamaño
cls
echo ========================================
echo         📊 BUSCAR POR TAMAÑO
echo ========================================
echo.
set /p tamaño="Tamaño mínimo en MB: "
set /a bytes=%tamaño%*1024*1024
echo.
echo 🔍 Archivos mayores a %tamaño%MB...
forfiles /s /m *.* /c "cmd /c if @fsize gtr %bytes% echo @path - @fsize bytes"
echo.
pause
goto menu

:buscar_contenido
cls
echo ========================================
echo         🔎 BUSCAR CONTENIDO
echo ========================================
echo.
set /p texto="Texto a buscar: "
echo.
echo 🔍 Buscando "%texto%" en archivos...
findstr /s /i "%texto%" *.txt *.ini *.cfg *.log
echo.
pause
goto menu

:buscar_tipo
cls
echo ========================================
echo         🎨 BUSCAR POR TIPO
echo ========================================
echo.
echo Tipos disponibles:
echo 1. Imágenes (*.jpg, *.png, *.gif)
echo 2. Documentos (*.doc, *.pdf, *.txt)
echo 3. Música (*.mp3, *.wav, *.flac)
echo 4. Videos (*.mp4, *.avi, *.mkv)
echo.
set /p tipo="Selecciona tipo (1-4): "

if "%tipo%"=="1" (
    echo 🔍 Buscando imágenes...
    dir C:\*.jpg *.png *.gif *.bmp /s /b
) else if "%tipo%"=="2" (
    echo 🔍 Buscando documentos...
    dir C:\*.doc *.pdf *.txt *.rtf /s /b
) else if "%tipo%"=="3" (
    echo 🔍 Buscando música...
    dir C:\*.mp3 *.wav *.flac *.m4a /s /b
) else if "%tipo%"=="4" (
    echo 🔍 Buscando videos...
    dir C:\*.mp4 *.avi *.mkv *.mov /s /b
)
echo.
pause
goto menu

:salir
exit 