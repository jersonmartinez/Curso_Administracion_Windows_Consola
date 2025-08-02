@echo off
:: Reemplazar caracteres en cadena
echo ========================================
echo        LIMPIADOR DE CADENAS
echo ========================================
echo.
set texto=Hola Mundo
echo 📝 Texto original: %texto%
echo.

:: Reemplazar espacios por guiones bajos
set "texto_modificado=%texto: =_%"
echo ✅ Texto modificado: %texto_modificado%
echo.
echo 💡 Útil para: nombres de archivos, URLs, compatibilidad
echo.
pause 