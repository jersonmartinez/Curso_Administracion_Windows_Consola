@echo off
:: Crear vínculo con PowerShell
echo Creando vínculo con PowerShell...

:: Crear vínculo simbólico usando PowerShell
powershell -Command "New-Item -ItemType SymbolicLink -Path 'enlace_powershell.txt' -Target 'archivo_original.txt'"

echo.
echo ✅ Vínculo creado con PowerShell
pause 