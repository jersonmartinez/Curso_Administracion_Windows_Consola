@echo off
:: Verificar programa asociado
echo Verificando programa asociado...

:: Ver tipo de archivo y programa
assoc .txt
ftype txtfile

echo.
echo ✅ Programa asociado verificado
pause 