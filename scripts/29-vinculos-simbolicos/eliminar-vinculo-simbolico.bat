@echo off
:: Eliminar vínculo simbólico
echo Eliminando vínculo simbólico...

:: Eliminar vínculo (no elimina el archivo original)
del "acceso_rapido.txt"

echo.
echo ✅ Vínculo simbólico eliminado
pause 