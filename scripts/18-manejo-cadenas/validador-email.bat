@echo off
:: Validador de email
echo ========================================
echo        VALIDADOR DE EMAIL
echo ========================================
echo.
set /p email="Ingresa un email: "
echo 📧 Email: %email%

:: Verificar si contiene @
echo %email% | find "@" >nul
if %errorlevel%==0 (
    echo ✅ Contiene @: Sí
) else (
    echo ❌ Contiene @: No
)

:: Verificar si contiene punto después del @
for /f "tokens=1,2 delims=@" %%a in ("%email%") do (
    echo 📝 Parte local: %%a
    echo 🌐 Parte dominio: %%b
    echo %%b | find "." >nul
    if !errorlevel!==0 (
        echo ✅ Formato válido: Sí
    ) else (
        echo ❌ Formato válido: No
    )
)
echo.
echo 💡 Útil para: validación de formularios, configuraciones
echo.
pause 