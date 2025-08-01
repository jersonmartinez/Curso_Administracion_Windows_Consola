@echo off
:: Crear vínculo simbólico de archivo
echo Creando vínculo simbólico de archivo...

:: Crear vínculo a un archivo
mklink "acceso_rapido.txt" "C:\documentos\archivo_importante.txt"

echo.
echo ✅ Vínculo simbólico creado
pause 