@echo off
:: Obtener todas las variables definidas
echo ========================================
echo      OBTENER VARIABLES DE ENTORNO
echo ========================================
echo.

echo 📋 Mostrando todas las variables definidas:
SET
echo.

echo 🔄 Variables dinámicas:
echo CD: %CD%
echo RANDOM: %RANDOM%
echo DATE: %DATE%
echo TIME: %TIME%
echo.
echo 📅 Combinación: %DATE% - %TIME%
echo.

echo 📁 Variable OneDriveConsumer:
SET OneDriveConsumer
echo.

echo 🔗 Creando variable personalizada:
SET Jerson=%OneDriveConsumer%
echo Variable Jerson creada: %Jerson%
echo.

echo 💡 Nota: Estas variables locales dejan de existir al salir del script
echo.
pause 