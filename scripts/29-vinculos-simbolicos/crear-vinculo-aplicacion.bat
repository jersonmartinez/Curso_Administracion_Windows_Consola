@echo off
:: Crear vínculo para aplicación
echo Creando vínculo para aplicación...

:: Crear vínculo a aplicación
mklink "notepad_plus.bat" "C:\Program Files\Notepad++\notepad++.exe"

echo.
echo ✅ Vínculo para aplicación creado
pause 