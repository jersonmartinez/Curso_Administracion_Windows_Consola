@echo off
:: Extraer extensión de archivo
set archivo=documento.txt
echo ========================================
echo        EXTRACTOR DE EXTENSIÓN
echo ========================================
echo.
echo 📄 Archivo: %archivo%
echo.

:: Buscar la posición del punto
set "temp=%archivo%"
set "pos=0"
:buscar_punto
if "%temp:~0,1%"=="." goto encontrado
set "temp=%temp:~1%"
set /a "pos+=1"
if not "%temp%"=="" goto buscar_punto
goto no_extension

:encontrado
set "extension=%archivo:~%pos%%"
echo 🔍 Extensión: %extension%
goto fin

:no_extension
echo ❌ No tiene extensión

:fin
echo.
echo 💡 Útil para: clasificación de archivos, validación, procesamiento
echo.
pause 