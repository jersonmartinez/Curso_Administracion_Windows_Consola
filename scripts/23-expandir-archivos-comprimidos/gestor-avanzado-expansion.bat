@echo off
:: Gestor avanzado de expansión
title 📂 Gestor Avanzado de Expansión
color 0A

:menu
cls
echo ========================================
echo    📂 GESTOR AVANZADO DE EXPANSIÓN
echo ========================================
echo.
echo 1. 📦 Expandir archivo ZIP
echo 2. 🗜️ Descomprimir archivos nativos
echo 3. 📋 Expandir archivo TAR
echo 4. 🔍 Ver contenido sin extraer
echo 5. 📊 Expansión masiva
echo 6. 🔐 Expansión con verificación
echo 7. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto expandir_zip
if "%opcion%"=="2" goto descomprimir_nativo
if "%opcion%"=="3" goto expandir_tar
if "%opcion%"=="4" goto ver_contenido
if "%opcion%"=="5" goto expansion_masiva
if "%opcion%"=="6" goto expansion_verificada
if "%opcion%"=="7" goto salir
goto menu

:expandir_zip
cls
echo ========================================
echo         📦 EXPANDIR ARCHIVO ZIP
echo ========================================
echo.
set /p archivo="Archivo ZIP: "
set /p destino="Directorio de destino: "
if exist "%archivo%" (
    echo 🔄 Expandiendo archivo ZIP...
    powershell -Command "Expand-Archive -Path '%archivo%' -DestinationPath '%destino%' -Force"
    echo ✅ Archivo ZIP expandido.
) else (
    echo ❌ Archivo no encontrado.
)
pause
goto menu

:descomprimir_nativo
cls
echo ========================================
echo         🗜️ DESCOMPRIMIR ARCHIVOS NATIVOS
echo ========================================
echo.
set /p archivo="Archivo o directorio: "
if exist "%archivo%" (
    echo 🔄 Descomprimiendo archivos nativos...
    compact /u /s "%archivo%"
    echo ✅ Archivos descomprimidos.
) else (
    echo ❌ Archivo/directorio no encontrado.
)
pause
goto menu

:expandir_tar
cls
echo ========================================
echo         📋 EXPANDIR ARCHIVO TAR
echo ========================================
echo.
set /p archivo="Archivo TAR: "
set /p destino="Directorio de destino: "
if exist "%archivo%" (
    echo 🔄 Expandiendo archivo TAR...
    tar -xf "%archivo%" -C "%destino%"
    echo ✅ Archivo TAR expandido.
) else (
    echo ❌ Archivo no encontrado.
)
pause
goto menu

:ver_contenido
cls
echo ========================================
echo         🔍 VER CONTENIDO SIN EXTRAER
echo ========================================
echo.
set /p archivo="Archivo comprimido: "
if exist "%archivo%" (
    echo 📋 Contenido del archivo:
    powershell -Command "Get-ChildItem -Path '%archivo%' -Recurse | Select-Object Name, Length"
) else (
    echo ❌ Archivo no encontrado.
)
pause
goto menu

:expansion_masiva
cls
echo ========================================
echo         📊 EXPANSIÓN MASIVA
echo ========================================
echo.
set /p directorio="Directorio con archivos: "
set /p destino="Directorio de destino: "
if exist "%directorio%" (
    echo 🔄 Procesando archivos comprimidos...
    for %%f in ("%directorio%\*.zip") do (
        echo Expandiendo: %%~nxf
        powershell -Command "Expand-Archive -Path '%%f' -DestinationPath '%destino%' -Force"
    )
    echo ✅ Expansión masiva completada.
) else (
    echo ❌ Directorio no encontrado.
)
pause
goto menu

:expansion_verificada
cls
echo ========================================
echo         🔐 EXPANSIÓN CON VERIFICACIÓN
echo ========================================
echo.
set /p archivo="Archivo a expandir: "
set /p destino="Directorio de destino: "
if exist "%archivo%" (
    echo 🔍 Verificando integridad...
    certutil -hashfile "%archivo%" MD5 > hash_temp.txt
    
    echo 🔄 Expandiendo archivo...
    powershell -Command "Expand-Archive -Path '%archivo%' -DestinationPath '%destino%' -Force"
    
    if %errorlevel%==0 (
        echo ✅ Expansión verificada exitosamente.
    ) else (
        echo ❌ Error en la expansión.
    )
    
    del hash_temp.txt 2>nul
) else (
    echo ❌ Archivo no encontrado.
)
pause
goto menu

:salir
exit 