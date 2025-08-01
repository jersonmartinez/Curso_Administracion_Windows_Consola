@echo off
:: Crear script dinámicamente usando redireccionamiento
echo ========================================
echo    CREACIÓN DINÁMICA DE SCRIPTS
echo ========================================
echo.

echo 🔧 Creando script.bat dinámicamente...
(
echo @echo off
echo title Saludos
echo color 0E
echo echo Hola!
echo echo.
echo pause
) >> script.bat

echo ✅ Script creado dinámicamente
echo 📁 Archivo: script.bat
echo.
echo 💡 El script fue creado usando redireccionamiento de comandos
echo.
pause 