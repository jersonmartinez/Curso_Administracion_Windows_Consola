@echo off
:: Restaurar asociación por defecto
echo Restaurando asociación por defecto...

:: Restaurar asociación de .txt
assoc .txt=txtfile
ftype txtfile=%SystemRoot%\system32\NOTEPAD.EXE %1

echo.
echo ✅ Asociación restaurada por defecto
pause 