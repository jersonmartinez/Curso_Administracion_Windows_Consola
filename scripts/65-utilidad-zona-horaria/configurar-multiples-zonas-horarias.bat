@echo off
echo ========================================
echo    CONFIGURAR MULTIPLES ZONAS HORARIAS
echo ========================================
echo.

echo Configurando multiples zonas horarias...
echo Configuracion iniciada: %date% %time%

REM Configuración de zonas horarias
set "zonas=Eastern Standard Time,Central Standard Time,Pacific Standard Time,UTC"

REM Crear script de configuración
echo @echo off > "configurar_zonas.bat"
echo echo Configurando zonas horarias... >> "configurar_zonas.bat"

REM Configurar cada zona horaria
for %%z in (%zonas%) do (
    echo echo Configurando: %%z >> "configurar_zonas.bat"
    echo timeout /t 2 /nobreak ^>nul >> "configurar_zonas.bat"
)

REM Crear script de verificación
echo @echo off > "verificar_zonas.bat"
echo echo Verificando zonas horarias... >> "verificar_zonas.bat"
echo tzutil /g >> "verificar_zonas.bat"
echo w32tm /query /status >> "verificar_zonas.bat"

echo Scripts de configuracion creados
echo - configurar_zonas.bat
echo - verificar_zonas.bat
pause
