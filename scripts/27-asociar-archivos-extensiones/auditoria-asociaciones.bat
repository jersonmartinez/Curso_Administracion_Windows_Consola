@echo off
:: Auditoría de asociaciones
title 🔍 Auditoría de Asociaciones
color 0B

echo ========================================
echo    🔍 AUDITORÍA DE ASOCIACIONES
echo ========================================
echo.

:menu_auditoria
echo 1. 📊 Reporte general
echo 2. 🔍 Verificar programas
echo 3. 📋 Listar extensiones comunes
echo 4. ⚠️ Detectar conflictos
echo 5. 📈 Estadísticas
echo 6. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto reporte_general
if "%opcion%"=="2" goto verificar_programas
if "%opcion%"=="3" goto extensiones_comunes
if "%opcion%"=="4" goto detectar_conflictos
if "%opcion%"=="5" goto estadisticas
if "%opcion%"=="6" goto salir
goto menu_auditoria

:reporte_general
cls
echo ========================================
echo         📊 REPORTE GENERAL
echo ========================================
echo.
echo 🔄 Generando reporte general...
echo === REPORTE DE ASOCIACIONES === > reporte_asociaciones.txt
echo Fecha: %date% %time% >> reporte_asociaciones.txt
echo. >> reporte_asociaciones.txt
assoc >> reporte_asociaciones.txt
echo ✅ Reporte generado en reporte_asociaciones.txt
pause
goto menu_auditoria

:verificar_programas
cls
echo ========================================
echo         🔍 VERIFICAR PROGRAMAS
echo ========================================
echo.
echo 🔄 Verificando programas asociados...
for /f "tokens=1,2 delims==" %%a in ('assoc') do (
    echo Verificando: %%a
    ftype %%b
)
echo ✅ Verificación completada
pause
goto menu_auditoria

:extensiones_comunes
cls
echo ========================================
echo         📋 EXTENSIONES COMUNES
echo ========================================
echo.
echo 📋 Extensiones más comunes:
echo.
echo .txt - Archivos de texto
echo .doc/.docx - Documentos Word
echo .xls/.xlsx - Hojas de cálculo
echo .pdf - Documentos PDF
echo .jpg/.jpeg - Imágenes JPEG
echo .png - Imágenes PNG
echo .mp3 - Audio MP3
echo .mp4 - Video MP4
echo .zip - Archivos comprimidos
echo .exe - Ejecutables
echo.
pause
goto menu_auditoria

:detectar_conflictos
cls
echo ========================================
echo         ⚠️ DETECTAR CONFLICTOS
echo ========================================
echo.
echo 🔍 Detectando conflictos...
echo ⚠️ Verificando programas no encontrados...
for /f "tokens=1,2 delims==" %%a in ('assoc') do (
    ftype %%b | findstr /i "no se encuentra" >nul && echo ❌ %%a - Programa no encontrado
)
echo ✅ Detección completada
pause
goto menu_auditoria

:estadisticas
cls
echo ========================================
echo         📈 ESTADÍSTICAS
echo ========================================
echo.
echo 📊 Generando estadísticas...
set contador=0
for /f %%a in ('assoc ^| find /c /v ""') do set /a contador+=1
echo Total de asociaciones: %contador%
echo ✅ Estadísticas generadas
pause
goto menu_auditoria

:salir
exit 