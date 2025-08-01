@echo off
:: Otorgar permisos de lectura
echo Otorgando permisos de lectura...

:: Dar permisos de lectura a un usuario
icacls "documento.txt" /grant "usuario:r"

echo.
echo ✅ Permisos de lectura otorgados
pause 