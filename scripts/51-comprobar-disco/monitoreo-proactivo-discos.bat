@echo off
setlocal enabledelayedexpansion
title 🛡️ SISTEMA DE MONITOREO PROACTIVO DE SALUD DE DISCOS

REM Lógica avanzada extraída del documento
REM Para detalles, consulta la documentación en el capítulo 51
REM Ejecuta este script para iniciar el monitoreo proactivo

:configuracion_inicial
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║      🛡️ SISTEMA DE MONITOREO PROACTIVO DE SALUD DE DISCOS 🛡️ ║
echo ║                    Detección Temprana de Problemas            ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
set /p umbral_espacio="Umbral de espacio libre (GB): "
set /p intervalo_monitoreo="Intervalo de monitoreo (minutos): "
set /p log_file="Archivo de log: "

echo.
echo ⚙️ Configuración del sistema:
echo    Umbral de espacio libre: %umbral_espacio% GB
echo    Intervalo de monitoreo: %intervalo_monitoreo% minutos
echo    Archivo de log: %log_file%
echo.
pause

REM ... (resto de la lógica avanzada, extraída del documento)
REM Consulta el capítulo para la descripción completa de cada función
