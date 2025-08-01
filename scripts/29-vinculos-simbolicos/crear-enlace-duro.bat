@echo off
:: Crear enlace duro
echo Creando enlace duro...

:: Crear enlace duro a un archivo
mklink /h "backup_documento.txt" "documento_original.txt"

echo.
echo ✅ Enlace duro creado
pause 