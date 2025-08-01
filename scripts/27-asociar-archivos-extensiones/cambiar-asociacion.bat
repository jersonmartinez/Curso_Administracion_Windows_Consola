@echo off
:: Cambiar asociación de archivos .txt
echo Cambiando asociación de archivos .txt...

:: Cambiar a Notepad++
assoc .txt=txtfile
ftype txtfile="C:\Program Files\Notepad++\notepad++.exe" "%1"

echo.
echo ✅ Asociación cambiada a Notepad++
pause 