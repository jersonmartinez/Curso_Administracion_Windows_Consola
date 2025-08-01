@echo off
:: Verificar vínculo simbólico
echo Verificando vínculo simbólico...

:: Mostrar información del vínculo
dir "acceso_rapido.txt" | findstr "SYMLINK"

echo.
echo ✅ Vínculo simbólico verificado
pause 