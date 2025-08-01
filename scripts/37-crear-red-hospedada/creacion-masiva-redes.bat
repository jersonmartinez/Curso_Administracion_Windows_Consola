@echo off
title Creación Masiva de Redes Hospedadas
color 0E

:: Verificar permisos de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Se requieren permisos de administrador
    pause
    exit /b 1
)

echo === CREACIÓN MASIVA DE REDES HOSPEDADAS ===
echo.
echo Este script permite crear múltiples redes hospedadas
echo para diferentes propósitos (eventos, departamentos, etc.)
echo.

:: Leer archivo de configuración masiva
set "CONFIG_FILE=redes_masivas.txt"
if not exist "%CONFIG_FILE%" (
    echo Creando archivo de configuración de ejemplo...
    (
        echo EVENTO_TECNOLOGIA|TechEvent2024|8
        echo DEPTO_VENTAS|Ventas2024|5
        echo SALA_REUNIONES|Reunion2024|10
        echo AREA_COMUN|Comun2024|15
    ) > "%CONFIG_FILE%"
    echo Archivo de configuración creado: %CONFIG_FILE%
    echo Edita el archivo y ejecuta nuevamente el script
    pause
    exit /b 0
)

echo Procesando configuraciones...
echo.

:: Contador de redes creadas
set "creadas=0"
set "errores=0"

:: Procesar cada línea del archivo
for /f "tokens=1,2,3 delims=|" %%a in (%CONFIG_FILE%) do (
    echo Configurando red: %%a
    echo SSID: %%a
    echo Contraseña: %%b
    echo Máximo clientes: %%c
    echo.
    
    netsh wlan set hostednetwork mode=allow ssid="%%a" key="%%b"
    if !errorlevel!==0 (
        echo ✓ Red "%%a" configurada correctamente
        set /a creadas+=1
    ) else (
        echo ✗ Error al configurar "%%a"
        set /a errores+=1
    )
    echo.
)

echo ========================================
echo RESUMEN DE CREACIÓN MASIVA
echo ========================================
echo Redes creadas exitosamente: %creadas%
echo Errores encontrados: %errores%
echo Total procesadas: %creadas% + %errores%
echo.

if %creadas% gtr 0 (
    set /p iniciar="¿Deseas iniciar todas las redes configuradas? (s/n): "
    if /i "%iniciar%"=="s" (
        echo Iniciando redes...
        for /f "tokens=1 delims=|" %%a in (%CONFIG_FILE%) do (
            netsh wlan start hostednetwork
            if !errorlevel!==0 (
                echo ✓ Red "%%a" iniciada
            ) else (
                echo ✗ Error al iniciar "%%a"
            )
        )
    )
)

echo.
echo Proceso completado
pause 