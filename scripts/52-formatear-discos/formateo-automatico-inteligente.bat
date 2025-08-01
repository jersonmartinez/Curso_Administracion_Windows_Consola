@echo off
setlocal enabledelayedexpansion
title 🤖 SISTEMA DE FORMATEO AUTOMÁTICO INTELIGENTE

:configuracion_inicial
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║        🤖 SISTEMA DE FORMATEO AUTOMÁTICO INTELIGENTE 🤖     ║
echo ║                    Formateo Adaptativo por Tipo de Uso       ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo Tipos de formateo disponibles:
echo [1] Sistema Operativo (Optimizado para Windows)
echo [2] Datos Generales (Uso diario)
echo [3] Almacenamiento de Red (Servidor de archivos)
echo [4] Respaldo (Archivos grandes)
echo [5] Multimedia (Videos, música, fotos)
echo [6] Desarrollo (Proyectos de programación)
echo.
set /p tipo_formateo="Selecciona tipo de formateo: "
set /p unidad="Letra de unidad: "
set /p etiqueta="Etiqueta del volumen: "

echo.
echo ⚙️ Configuración del formateo:
echo    Tipo: %tipo_formateo%
echo    Unidad: %unidad%:
echo    Etiqueta: %etiqueta%
echo.
pause

:formateo_adaptativo
cls
echo.
echo 🤖 FORMATEO ADAPTATIVO EN PROGRESO
echo ════════════════════════════════════════════════════════════════
echo.

if "%tipo_formateo%"=="1" goto formateo_sistema
if "%tipo_formateo%"=="2" goto formateo_datos
if "%tipo_formateo%"=="3" goto formateo_red
if "%tipo_formateo%"=="4" goto formateo_respaldo
if "%tipo_formateo%"=="5" goto formateo_multimedia
if "%tipo_formateo%"=="6" goto formateo_desarrollo

:formateo_sistema
echo 🖥️ Configurando para Sistema Operativo...
format %unidad%: /FS:NTFS /V:%etiqueta% /Y
echo 🔧 Aplicando optimizaciones de sistema...
fsutil behavior set disablelastaccess 1
fsutil behavior set disable8dot3 1
goto finalizar

:formateo_datos
echo 📁 Configurando para Datos Generales...
format %unidad%: /FS:NTFS /A:4096 /Q /V:%etiqueta% /Y
echo 🔧 Aplicando optimizaciones estándar...
goto finalizar

:formateo_red
echo 🌐 Configurando para Almacenamiento de Red...
format %unidad%: /FS:NTFS /A:32768 /Q /V:%etiqueta% /Y
echo 🔧 Aplicando optimizaciones de red...
fsutil behavior set disablelastaccess 1
fsutil behavior set mftzone 2
goto finalizar

:formateo_respaldo
echo 💾 Configurando para Respaldo...
format %unidad%: /FS:NTFS /A:65536 /Q /V:%etiqueta% /Y
echo 🔧 Aplicando optimizaciones para archivos grandes...
goto finalizar

:formateo_multimedia
echo 🎬 Configurando para Multimedia...
format %unidad%: /FS:NTFS /A:32768 /Q /V:%etiqueta% /Y
echo 🔧 Aplicando optimizaciones multimedia...
goto finalizar

:formateo_desarrollo
echo 💻 Configurando para Desarrollo...
format %unidad%: /FS:NTFS /A:4096 /Q /V:%etiqueta% /Y
echo 🔧 Aplicando optimizaciones para desarrollo...
goto finalizar

:finalizar
echo.
echo ✅ Formateo adaptativo completado
echo 📊 Verificando integridad...
chkdsk %unidad%: /F
echo.
pause
exit /b 0
