@echo off
:: Procesamiento carácter por carácter
echo ========================================
echo    PROCESAMIENTO CARÁCTER POR CARÁCTER
echo ========================================
echo.
setlocal enabledelayedexpansion

set "texto=Hola"
set "resultado="

for /l %%i in (0,1,3) do (
    set "caracter=!texto:~%%i,1!"
    set "resultado=!resultado!!caracter!_"
)

echo 📝 Texto original: %texto%
echo 🔤 Procesado: !resultado!
echo.
echo 💡 Útil para: validación, transformación, análisis
echo.
pause 