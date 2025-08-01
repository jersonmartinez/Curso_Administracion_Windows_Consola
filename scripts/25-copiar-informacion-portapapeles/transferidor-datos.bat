@echo off
:: Transferidor de datos con portapapeles
title 🔄 Transferidor de Datos
color 0E

echo ========================================
echo    🔄 TRANSFERIDOR DE DATOS CON PORTAPAPELES
echo ========================================
echo.

:: Leer datos de un archivo y copiarlos al portapapeles
set /p archivo_origen="Archivo de origen: "
if exist "%archivo_origen%" (
    echo 🔄 Copiando datos al portapapeles...
    type "%archivo_origen%" | clip
    echo ✅ Datos copiados al portapapeles
    
    :: Pausa para permitir pegado manual
    echo.
    echo 💡 Ahora puedes pegar los datos en la aplicación de destino
    echo ⏰ Pausa de 10 segundos para pegado...
    timeout /t 10 /nobreak >nul
    
    :: Limpiar portapapeles
    echo "" | clip
    echo ✅ Portapapeles limpiado
) else (
    echo ❌ Archivo de origen no encontrado
)

echo.
pause 