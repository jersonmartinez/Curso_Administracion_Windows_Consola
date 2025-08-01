@echo off
echo ========================================
echo    VERIFICAR RENDIMIENTO DE APLICACIONES
echo ========================================
echo.

echo Verificando rendimiento de aplicaciones...
echo Verificacion iniciada: %date% %time%

REM Aplicaciones en ejecución
echo === APLICACIONES EN EJECUCION ===
tasklist /FI "WINDOWTITLE ne N/A" /FO TABLE

REM Información de aplicaciones específicas
echo.
echo === INFORMACION DE APLICACIONES ESPECIFICAS ===
for %%a in (chrome.exe firefox.exe notepad.exe) do (
    echo --- Aplicacion: %%a ---
    echo.
)

REM Aplicaciones con mayor uso de memoria
echo === APLICACIONES CON MAYOR USO DE MEMORIA ===
tasklist /FI "MEMUSAGE gt 100000" /FO TABLE

echo Verificacion de aplicaciones completada
pause
