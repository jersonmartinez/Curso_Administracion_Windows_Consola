@echo off
:: Extraer nombre de usuario sin dominio
echo ========================================
echo      PROCESADOR DE NOMBRE DE USUARIO
echo ========================================
echo.
echo 👤 Usuario completo: %username%
echo.

:: Extraer solo el nombre (asumiendo formato DOMINIO\usuario)
for /f "tokens=2 delims=\" %%i in ("%username%") do set nombre=%%i
echo 📝 Nombre sin dominio: %nombre%
echo.
echo 💡 Útil para: directorios personales, configuraciones, logs
echo.
pause 