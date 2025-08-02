@echo off
:: Limpiador de nombres de archivos
title 🧹 Limpiador de Nombres de Archivos
color 0C

echo ========================================
echo    🧹 LIMPIADOR DE NOMBRES DE ARCHIVOS
echo ========================================
echo.

set /p directorio="Ingresa el directorio (Enter para actual): "
if "%directorio%"=="" set "directorio=."

echo 🔍 Procesando archivos en: %directorio%
echo.

for %%f in ("%directorio%\*.*") do (
    set "archivo_original=%%f"
    set "nombre_original=%%~nf"
    
    :: Reemplazar caracteres problemáticos
    set "nombre_limpio=!nombre_original!"
    set "nombre_limpio=!nombre_limpio: =_!"
    set "nombre_limpio=!nombre_limpio:á=a!"
    set "nombre_limpio=!nombre_limpio:é=e!"
    set "nombre_limpio=!nombre_limpio:í=i!"
    set "nombre_limpio=!nombre_limpio:ó=o!"
    set "nombre_limpio=!nombre_limpio:ú=u!"
    set "nombre_limpio=!nombre_limpio:ñ=n!"
    
    echo 📄 Original: !nombre_original!
    echo ✅ Limpio: !nombre_limpio!
    echo.
    
    :: Renombrar archivo
    ren "%%f" "!nombre_limpio!%%~xf"
)

echo 🎉 Proceso completado.
echo 💡 Útil para: compatibilidad, transferencia, normalización
echo.
pause 