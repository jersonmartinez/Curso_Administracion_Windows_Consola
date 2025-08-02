@echo off
:: Concatenar cadenas de texto
echo ========================================
echo        CONCATENADOR DE CADENAS
echo ========================================
echo.
set nombre=Juan
set apellido=Pérez
set nombre_completo=%nombre% %apellido%
echo 👤 Nombre completo: %nombre_completo%
echo.
echo 💡 Útil para: nombres de archivos, rutas, mensajes personalizados
echo.
pause 