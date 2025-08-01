@echo off
echo ========================================
echo    CAMBIAR ZONA HORARIA
echo ========================================
echo.

echo Cambiando zona horaria...
echo Cambio iniciado: %date% %time%

REM Mostrar zona horaria actual
echo === ZONA HORARIA ACTUAL ===
tzutil /g

REM Listar zonas horarias disponibles
echo.
echo === ZONAS HORARIAS DISPONIBLES ===
tzutil /l

REM Cambiar a zona horaria específica
echo.
echo === CAMBIANDO ZONA HORARIA ===
set "nueva_zona=Eastern Standard Time"
echo Cambiando a: %nueva_zona%
tzutil /s "%nueva_zona%"

REM Verificar cambio
echo.
echo === VERIFICANDO CAMBIO ===
tzutil /g

echo Cambio de zona horaria completado
pause
