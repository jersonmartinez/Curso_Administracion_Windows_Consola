@echo off
:: Extraer nombre sin extensión
echo ========================================
echo      EXTRACTOR DE NOMBRE BASE
echo ========================================
echo.
set archivo=documento.txt
echo 📄 Archivo: %archivo%
echo.

:: Buscar la posición del último punto
set "temp=%archivo%"
set "pos=0"
set "ultimo_punto=0"
:buscar_ultimo_punto
if "%temp:~0,1%"=="." set "ultimo_punto=%pos%"
set "temp=%temp:~1%"
set /a "pos+=1"
if not "%temp%"=="" goto buscar_ultimo_punto

if %ultimo_punto%==0 (
    echo 📝 Nombre sin extensión: %archivo%
) else (
    set "nombre_sin_ext=%archivo:~0,%ultimo_punto%%"
    echo 📝 Nombre sin extensión: %nombre_sin_ext%
)
echo.
echo 💡 Útil para: copias, conversiones, nombres derivados
echo.
pause 