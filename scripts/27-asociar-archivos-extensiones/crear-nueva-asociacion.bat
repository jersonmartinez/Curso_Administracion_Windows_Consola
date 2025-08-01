@echo off
:: Crear asociación para archivos .log
echo Creando nueva asociación para archivos .log...

:: Crear asociación personalizada
assoc .log=logfile
ftype logfile="C:\Program Files\Notepad++\notepad++.exe" "%1"

echo.
echo ✅ Nueva asociación creada para archivos .log
pause 