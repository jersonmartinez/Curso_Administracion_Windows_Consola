@echo off
:: Verificar si una ruta está en el PATH
echo ========================================
echo        VERIFICADOR DE RUTAS
echo ========================================
echo.
set /p ruta_buscar="Ingresa la ruta a buscar: "
echo.

:: Buscar la ruta en el PATH
echo %PATH% | find /i "%ruta_buscar%" >nul
if %errorlevel%==0 (
    echo ✅ La ruta %ruta_buscar% está en el PATH
) else (
    echo ❌ La ruta %ruta_buscar% NO está en el PATH
)
echo.
pause 