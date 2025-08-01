@echo off
:: Crear un comando personalizado
echo ========================================
echo      CREAR COMANDO PERSONALIZADO
echo ========================================
echo.

echo 🔧 Creando comando helloworld.bat en System32...
echo @echo off > C:\Windows\System32\helloworld.bat
echo echo Hello World! >> C:\Windows\System32\helloworld.bat
echo ✅ Comando helloworld creado
echo.

echo 🚀 Probando el comando:
helloworld
echo.

echo 💡 Ahora puedes usar 'helloworld' desde cualquier terminal
echo.
pause 