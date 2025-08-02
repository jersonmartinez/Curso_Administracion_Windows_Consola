@echo off
:: Convertir texto a mayúsculas
echo ========================================
echo        CONVERTIDOR DE CASO
echo ========================================
echo.
set texto=Hola Mundo
echo 📝 Texto original: %texto%
echo.

:: Convertir a mayúsculas (usando PowerShell)
for /f %%i in ('powershell -command "[string]::ToUpper('%texto%')"') do set mayusculas=%%i
echo 🔤 Mayúsculas: %mayusculas%
echo.
echo 💡 Útil para: normalización, validación, consistencia
echo.
pause 