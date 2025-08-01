@echo off
:: Otorgar permisos completos
echo Otorgando permisos completos...

:: Dar control total a un usuario
icacls "proyecto/" /grant "desarrollador:(OI)(CI)F" /t

echo.
echo ✅ Permisos completos otorgados
pause 