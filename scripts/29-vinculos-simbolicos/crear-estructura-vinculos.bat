@echo off
:: Crear estructura de vínculos
echo Creando estructura de vínculos...

:: Crear directorio para vínculos
mkdir "enlaces_rapidos"

:: Crear vínculos organizados
mklink "enlaces_rapidos\documentos.txt" "C:\documentos\importante.txt"
mklink "enlaces_rapidos\config.txt" "C:\config\configuracion.txt"
mklink "enlaces_rapidos\logs.txt" "C:\logs\aplicacion.log"

echo.
echo ✅ Estructura de vínculos creada
pause 