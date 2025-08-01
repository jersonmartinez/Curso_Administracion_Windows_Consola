@echo off
:: Denegar acceso
echo Denegando acceso...

:: Denegar acceso a un usuario
icacls "confidencial.txt" /deny "usuario:F"

echo.
echo ✅ Acceso denegado
pause 