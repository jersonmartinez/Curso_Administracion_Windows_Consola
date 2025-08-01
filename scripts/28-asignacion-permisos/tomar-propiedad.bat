@echo off
:: Tomar propiedad de archivos
echo Tomando propiedad de archivos...

:: Tomar propiedad como administrador
takeown /f "archivo.txt" /a

echo.
echo ✅ Propiedad tomada
pause 