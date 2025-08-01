@echo off
:: Acceder en distintos directorios mediante variables de entorno
echo ========================================
echo    ACCESO A DIRECTORIOS CON VARIABLES
echo ========================================
echo.

echo 🏠 Accediendo a ALLUSERSPROFILE:
echo %ALLUSERSPROFILE%
echo.

echo 🚀 Abriendo HOMEDRIVE con start:
start %HOMEDRIVE%
echo ✅ HOMEDRIVE abierto con start
echo.

echo 📂 Abriendo HOMEDRIVE con explorer:
explorer %HOMEDRIVE%
echo ✅ HOMEDRIVE abierto con explorer
echo.

echo 💡 Variables útiles para navegación:
echo    %ALLUSERSPROFILE% - Perfil de todos los usuarios
echo    %HOMEDRIVE% - Unidad del directorio home
echo    %USERPROFILE% - Perfil del usuario actual
echo.
pause 