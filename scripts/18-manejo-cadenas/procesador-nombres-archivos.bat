@echo off
:: Procesador completo de nombres de archivos
title 🔤 Procesador de Nombres de Archivos
color 0E

:menu
cls
echo ========================================
echo    🔤 PROCESADOR DE NOMBRES DE ARCHIVOS
echo ========================================
echo.
echo 1. ✂️ Extraer extensión
echo 2. 📝 Extraer nombre sin extensión
echo 3. 🔤 Convertir a mayúsculas
echo 4. 🔄 Reemplazar espacios por guiones
echo 5. 🚪 Salir
echo.
set /p opcion="Selecciona una opción: "

if "%opcion%"=="1" goto extraer_extension
if "%opcion%"=="2" goto extraer_nombre
if "%opcion%"=="3" goto convertir_mayusculas
if "%opcion%"=="4" goto reemplazar_espacios
if "%opcion%"=="5" goto salir
goto menu

:extraer_extension
cls
echo ========================================
echo         EXTRACTOR DE EXTENSIÓN
echo ========================================
echo.
set /p archivo="Ingresa el nombre del archivo: "
call :get_extension "%archivo%"
echo 🔍 Extensión: %extension%
pause
goto menu

:extraer_nombre
cls
echo ========================================
echo      EXTRACTOR DE NOMBRE BASE
echo ========================================
echo.
set /p archivo="Ingresa el nombre del archivo: "
call :get_name "%archivo%"
echo 📝 Nombre sin extensión: %nombre_sin_ext%
pause
goto menu

:convertir_mayusculas
cls
echo ========================================
echo        CONVERTIDOR A MAYÚSCULAS
echo ========================================
echo.
set /p texto="Ingresa el texto: "
for /f %%i in ('powershell -command "[string]::ToUpper('%texto%')"') do set mayusculas=%%i
echo 🔤 Mayúsculas: %mayusculas%
pause
goto menu

:reemplazar_espacios
cls
echo ========================================
echo        REEMPLAZADOR DE ESPACIOS
echo ========================================
echo.
set /p texto="Ingresa el texto: "
set "texto_modificado=%texto: =_%"
echo ✅ Texto modificado: %texto_modificado%
pause
goto menu

:salir
exit

:get_extension
set "archivo=%~1"
set "temp=%archivo%"
set "pos=0"
:buscar_punto_ext
if "%temp:~0,1%"=="." goto encontrado_ext
set "temp=%temp:~1%"
set /a "pos+=1"
if not "%temp%"=="" goto buscar_punto_ext
set "extension="
goto :eof

:encontrado_ext
set "extension=%archivo:~%pos%%"
goto :eof

:get_name
set "archivo=%~1"
set "temp=%archivo%"
set "pos=0"
set "ultimo_punto=0"
:buscar_ultimo_punto_name
if "%temp:~0,1%"=="." set "ultimo_punto=%pos%"
set "temp=%temp:~1%"
set /a "pos+=1"
if not "%temp%"=="" goto buscar_ultimo_punto_name

if %ultimo_punto%==0 (
    set "nombre_sin_ext=%archivo%"
) else (
    set "nombre_sin_ext=%archivo:~0,%ultimo_punto%%"
)
goto :eof 