@echo off
:: Auditoría de vínculos
title 🔍 Auditoría de Vínculos
color 0B

echo ========================================
echo    🔍 AUDITORÍA DE VÍNCULOS
echo ========================================
echo.

:menu_auditoria
echo 1. 📊 Reporte de vínculos
echo 2. 🔍 Buscar vínculos rotos
echo 3. 📋 Listar tipos de vínculos
echo 4. ⚠️ Detectar vínculos problemáticos
echo 5. 📈 Estadísticas
echo 6. 🚪 Salir
echo.
set /p opcion="Selecciona opción: "

if "%opcion%"=="1" goto reporte_vinculos
if "%opcion%"=="2" goto buscar_rotos
if "%opcion%"=="3" goto tipos_vinculos
if "%opcion%"=="4" goto detectar_problemas
if "%opcion%"=="5" goto estadisticas
if "%opcion%"=="6" goto salir
goto menu_auditoria

:reporte_vinculos
cls
echo ========================================
echo         📊 REPORTE DE VÍNCULOS
echo ========================================
echo.
set /p ruta="Ruta a auditar: "
if defined ruta (
    echo 🔄 Generando reporte...
    echo === REPORTE DE VÍNCULOS === > reporte_vinculos.txt
    echo Fecha: %date% %time% >> reporte_vinculos.txt
    echo Ruta: %ruta% >> reporte_vinculos.txt
    echo. >> reporte_vinculos.txt
    dir "%ruta%" /al /s >> reporte_vinculos.txt
    echo ✅ Reporte generado en reporte_vinculos.txt
) else (
    echo ❌ Ruta no especificada
)
pause
goto menu_auditoria

:buscar_rotos
cls
echo ========================================
echo         🔍 BUSCAR VÍNCULOS ROTOS
echo ========================================
echo.
set /p ruta="Ruta a verificar: "
if defined ruta (
    echo 🔍 Buscando vínculos rotos...
    for /f "tokens=*" %%f in ('dir "%ruta%" /al /b 2^>nul') do (
        if not exist "%%f" echo ⚠️ Vínculo roto: %%f
    )
    echo ✅ Búsqueda completada
) else (
    echo ❌ Ruta no especificada
)
pause
goto menu_auditoria

:tipos_vinculos
cls
echo ========================================
echo         📋 TIPOS DE VÍNCULOS
echo ========================================
echo.
echo 📋 Tipos de vínculos en Windows:
echo.
echo 🔗 Vínculo Simbólico (Symbolic Link)
echo    - Apunta a archivos o directorios
echo    - Puede cruzar volúmenes
echo    - Requiere permisos de administrador
echo.
echo 🔗 Enlace Duro (Hard Link)
echo    - Solo para archivos
echo    - Mismo volumen
echo    - Múltiples referencias al mismo contenido
echo.
echo 🔗 Punto de Unión (Junction Point)
echo    - Solo para directorios
echo    - Mismo volumen
echo    - Compatible con versiones anteriores
echo.
pause
goto menu_auditoria

:detectar_problemas
cls
echo ========================================
echo         ⚠️ DETECTAR PROBLEMAS
echo ========================================
echo.
set /p ruta="Ruta a verificar: "
if defined ruta (
    echo 🔍 Detectando problemas...
    echo ⚠️ Verificando permisos de vínculos...
    for /f "tokens=*" %%f in ('dir "%ruta%" /al /b 2^>nul') do (
        icacls "%%f" | findstr /i "Everyone.*F" >nul && echo ⚠️ %%f - Permisos excesivos
    )
    echo ✅ Detección completada
) else (
    echo ❌ Ruta no especificada
)
pause
goto menu_auditoria

:estadisticas
cls
echo ========================================
echo         📈 ESTADÍSTICAS
echo ========================================
echo.
set /p ruta="Ruta a analizar: "
if defined ruta (
    echo 📊 Generando estadísticas...
    set contador=0
    for /f %%a in ('dir "%ruta%" /al /s ^| find /c /v ""') do set /a contador+=1
    echo Total de vínculos: %contador%
    echo ✅ Estadísticas generadas
) else (
    echo ❌ Ruta no especificada
)
pause
goto menu_auditoria

:salir
exit 