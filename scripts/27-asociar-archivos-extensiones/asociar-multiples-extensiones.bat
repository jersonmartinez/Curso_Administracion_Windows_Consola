@echo off
:: Asociar múltiples extensiones
echo Asociando múltiples extensiones...

:: Asociar archivos de texto
assoc .txt=txtfile
assoc .log=txtfile
assoc .ini=txtfile
assoc .cfg=txtfile

echo.
echo ✅ Múltiples extensiones asociadas
pause 