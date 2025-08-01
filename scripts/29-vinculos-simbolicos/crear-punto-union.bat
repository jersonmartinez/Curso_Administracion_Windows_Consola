@echo off
:: Crear punto de unión
echo Creando punto de unión...

:: Crear punto de unión para directorio
mklink /j "datos_app" "C:\programas\aplicacion\datos"

echo.
echo ✅ Punto de unión creado
pause 