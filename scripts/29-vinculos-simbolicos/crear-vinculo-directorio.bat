@echo off
:: Crear vínculo simbólico de directorio
echo Creando vínculo simbólico de directorio...

:: Crear vínculo a un directorio
mklink /d "acceso_proyectos" "C:\proyectos\desarrollo"

echo.
echo ✅ Vínculo simbólico de directorio creado
pause 