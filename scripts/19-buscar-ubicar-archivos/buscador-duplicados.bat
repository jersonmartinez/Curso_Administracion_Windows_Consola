@echo off
:: Buscador de archivos duplicados
echo ========================================
echo      🔄 BUSCADOR DE DUPLICADOS
echo ========================================
echo.
echo 🔍 Buscando archivos duplicados por nombre...
for /f "tokens=*" %%i in ('dir /s /b *.txt ^| findstr /i "copy\|duplicate\|backup"') do (
    echo 📄 %%i
)
echo.
echo 💡 Útil para: limpieza de disco, organización, optimización
echo.
pause 