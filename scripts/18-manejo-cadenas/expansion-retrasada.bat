@echo off
:: Demostración de expansión retrasada
echo ========================================
echo      EXPANSIÓN RETRASADA
echo ========================================
echo.
setlocal enabledelayedexpansion

set "texto=Hola Mundo"
for %%i in (1 2 3) do (
    echo 🔄 Iteración %%i: !texto!
    set "texto=!texto! %%i"
)
echo.
echo 💡 Útil para: bucles dinámicos, procesamiento secuencial
echo.
pause 